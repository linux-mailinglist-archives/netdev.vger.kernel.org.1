Return-Path: <netdev+bounces-14103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 542B673EDB9
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AB91C20A52
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F37174E2;
	Mon, 26 Jun 2023 21:51:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BD8174E7
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E337FC43391;
	Mon, 26 Jun 2023 21:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687816279;
	bh=sBkglsaDnwOkcI2kCnoA34AtBWoZOKhM/qzwWI3FR7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnKWxHjdjLND0VkvcDvk3cb5fZU/dUXgUcQDgGIM0MfkUbQ4BvjyNTKYYKPXF2GDA
	 FvxDzRjFCw2IQw5jfn6VpZDaFaZGa3MetHQaUSCqaIndEmvct0lxK5PUmYVhkWj3fI
	 SZsH6+ALSpHllbcKt7bQpPvGINYnAKC4B788SgfuxYrzEItCSR/p4pg5ErBVNkb5oM
	 v2qWxUAJ48TFG9qRJw8gB5+xFhjL4nxZqnJ5g3tqyTn4O8HwZtDxR6GC5tzxU3IdfX
	 F38nWkdQsnX12eboDdRXLPsYF9xyKkPVWs75zC2tlBA97Jk+if8WwIKVTEHph/lMds
	 hTE/O058lWU+w==
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
Subject: [PATCH AUTOSEL 5.4 3/6] sctp: handle invalid error codes without calling BUG()
Date: Mon, 26 Jun 2023 17:51:13 -0400
Message-Id: <20230626215116.179581-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215116.179581-1-sashal@kernel.org>
References: <20230626215116.179581-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.248
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
index 8d32229199b96..c964e7ca6f7e5 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1240,7 +1240,10 @@ static int sctp_side_effects(enum sctp_event_type event_type,
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


