Return-Path: <netdev+bounces-14109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0239B73EDD8
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FF8280F63
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCAF182AB;
	Mon, 26 Jun 2023 21:51:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB217FF3
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086DFC433CC;
	Mon, 26 Jun 2023 21:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687816293;
	bh=vOHhUrqa/Nk0P/voSrPZnhsuDPDSkMt7hNCfAlpuevw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsrIWJIMCmJ0/VbX1a7kiH0s/pwdUSidbH3T7xaSchKRkv6w1VNTfMx3t3AZbvchT
	 YIKnFDPZrEHI8gLHRm9jN9YHZPDNEE7bT67Vas2FyIIBiB/DU6yNhqWIKyquM7MPLH
	 wGi3PAjH7tRpQQzbyqBpqwlqE4BMFMxZiM8TPXjprlKR2BH7zUsn6WKAjJgxEgYimr
	 r/8h1PrCPqjjEz9Q4133vg2MBGeR+xBs1uNltCXpTsEhP+bEtN6CHDvSUdSevzyJB9
	 sUc+0NzWe0eGtYHOQDhCYeo6X+lVTVz7goxFzu8+nuY+J2JpKxWQ+DPdg6HSnCUCKy
	 6bzhezj/ugsiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/5] sctp: handle invalid error codes without calling BUG()
Date: Mon, 26 Jun 2023 17:51:28 -0400
Message-Id: <20230626215130.179740-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215130.179740-1-sashal@kernel.org>
References: <20230626215130.179740-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.319
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit a0067dfcd9418fd3b0632bc59210d120d038a9c6 ]

The sctp_sf_eat_auth() function is supposed to return enum sctp_disposition
values but if the call to sctp_ulpevent_make_authkey() fails, it returns
-ENOMEM.

This results in calling BUG() inside the sctp_side_effects() function.
Calling BUG() is an over reaction and not helpful.  Call WARN_ON_ONCE()
instead.

This code predates git.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/sm_sideeffect.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index 169819263c0bb..87822421b99db 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1235,7 +1235,10 @@ static int sctp_side_effects(enum sctp_event event_type,
 	default:
 		pr_err("impossible disposition %d in state %d, event_type %d, event_id %d\n",
 		       status, state, event_type, subtype.chunk);
-		BUG();
+		error = status;
+		if (error >= 0)
+			error = -EINVAL;
+		WARN_ON_ONCE(1);
 		break;
 	}
 
-- 
2.39.2


