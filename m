Return-Path: <netdev+bounces-31268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AE878C616
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666F91C20A9A
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BCB17753;
	Tue, 29 Aug 2023 13:33:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE0E17FF9
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 13:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382CAC433A9;
	Tue, 29 Aug 2023 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693316025;
	bh=ZJjuco+PVgNowSVVhULCE7WenwFtCE8kzT28MLJwBvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=alCECCvjDq0ZCV8A0ZiBPtCNLeWWzFeEBETZoXgf5rxxoG7903WvYFvBA829D/jqS
	 yPaMQCik4zgo4mgyhAq8dNoAj3Dd7MRkb//ESqC0Bp/GjVHHzirPwzFddb03sChPUl
	 tLH1Ieh+oVU4YhywyXsL4U278+A5vMXNif4nEVyKmTk5DF3fFxysP8au1iZ+3TRXIx
	 Wh3wfxeY1IkhjF6koxAjwVaF5ECkc+UxvrhpUJE/Bg2crQlSau1YXn6T6fBrXjC9VY
	 4P2w+WQ18qRFVXJPCVEttFC53QxlwfOYYG6vd5MDzJjMnbJUM3TZLAjMU4Wj2dewG3
	 cfx2A9kDvA+6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	vyasevich@gmail.com,
	nhorman@tuxdriver.com,
	marcelo.leitner@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 4/7] sctp: handle invalid error codes without calling BUG()
Date: Tue, 29 Aug 2023 09:33:33 -0400
Message-Id: <20230829133336.520573-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133336.520573-1-sashal@kernel.org>
References: <20230829133336.520573-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.192
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
index d4e5969771f0f..30e9914526337 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1241,7 +1241,10 @@ static int sctp_side_effects(enum sctp_event_type event_type,
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
2.40.1


