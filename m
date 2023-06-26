Return-Path: <netdev+bounces-14100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC673ED8C
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FBC1C2031A
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1715AE3;
	Mon, 26 Jun 2023 21:51:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D9171B6
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84C7C433C0;
	Mon, 26 Jun 2023 21:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687816272;
	bh=VWhTk9pIwCSI7DIGvt+AI5ivg+IUZ+rwkUnGeJN5yuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkOkeafalWG4YHRGuB6TX+huz1wHoMF5uKubX2+BUaJs5W7DUZzNJ21XPEDzhA4pY
	 F9R0ACSRpGwIBC6UIgh/BbONhe8fdBLQ6w0uoZo4d/akCNyXSC6kaE34OluueDolmH
	 TGJ7P5AlNn9y6n9gKiXYEKGpZGlat0BhHHylrhQN+DVXH8s6p6gKEJH2Y+A0bqPkrW
	 5fjQwQGD6ysprTEF/ihx8GfR8Bhm9dw9KXIhkKceXTDYzwlAh7hnQd3Sxn9NxgecAi
	 RXnHMcqtrwCJnJl0IlEIkDUEWr/0L3ahp9KD8onNiWRbWaVbE3EibXkKQkFDubUpB7
	 vQjDEcM4k8yJw==
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
Subject: [PATCH AUTOSEL 5.10 4/7] sctp: handle invalid error codes without calling BUG()
Date: Mon, 26 Jun 2023 17:51:04 -0400
Message-Id: <20230626215108.179483-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215108.179483-1-sashal@kernel.org>
References: <20230626215108.179483-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.185
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
2.39.2


