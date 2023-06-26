Return-Path: <netdev+bounces-14094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40D473ED60
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D47F280F18
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4FB15AC2;
	Mon, 26 Jun 2023 21:50:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ECD168B1
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E215C433D9;
	Mon, 26 Jun 2023 21:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687816246;
	bh=1fdzaqEMq6vZyaUUdwoyrVtVn9gfyoo10uV5nez1X1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCTIXBJTjbg3YHXTwdeWTZYc7pyyBpUngGtxLeHDyub1zAMBaK5BN9wgxlM81dHwp
	 2gwsGZL+pbKIhIkk8VVZ+WZjUZnX2QXuCN2BLhISYLZILLMmhCETsfdwXA2U+uSL0k
	 o/6ahsYR8zVrnkbFYt/TJjpnUZQvNVZNqQzgPBVGVpEoTWyzWZGrqIM7R2JZykY3wF
	 g98wKEqU/3BkCcgp3W0BrWJrNdza8JZQyqpyOA0UQ6LRhgIVOUrD7mTiD/q/xFHEe/
	 +ZZ+jmF5B7bG3mb1sohh3U5H/r0Evya1H6sO7yWdA/sSQ71aPfjvaCZnToUYF2OkRm
	 iWr87vIy862mA==
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
Subject: [PATCH AUTOSEL 6.1 08/15] sctp: handle invalid error codes without calling BUG()
Date: Mon, 26 Jun 2023 17:50:24 -0400
Message-Id: <20230626215031.179159-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215031.179159-1-sashal@kernel.org>
References: <20230626215031.179159-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
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
index 463c4a58d2c36..970c6a486a9b0 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1251,7 +1251,10 @@ static int sctp_side_effects(enum sctp_event_type event_type,
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


