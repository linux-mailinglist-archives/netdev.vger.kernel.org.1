Return-Path: <netdev+bounces-71604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CD78541D1
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 04:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913FC1C26857
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 03:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378D2B667;
	Wed, 14 Feb 2024 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLsTZ+1R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D30B64A
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 03:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707881936; cv=none; b=YmSOVee9EKreoExoiLCqHDCSKyEyZ8mklBB0l1SXSvEp84lDyNWPWgIgdLG4fMAYzG8xsiZbgj31TcpurtD1I9yNmwhm19MUT6J9MNMOBZ+4m22agTK3FIfW2GVerDSRz1Zg1nP0F82ydutTZjF/01Y2wwq0wFM9DATep9UjI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707881936; c=relaxed/simple;
	bh=3SOk16hiasuTE9/BDUHVgSUmJz6Ked7mnkxTAyWVP6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnjwXNwW1crmPhoeaXCldv5Ta+sNtB0IsB5pVhbU8lrVSo4si6CbNXNc4la66Fp+IvY4FYSmsVnZW+J2G60aX7tASzkXKXttKtEZIAoBjD/U7ACcs2AfRUBgUBYteEgaCVbvQF8IIlaifhKegebh+jCNA53DF3s7/3IALuaz/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLsTZ+1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C296C433C7;
	Wed, 14 Feb 2024 03:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707881935;
	bh=3SOk16hiasuTE9/BDUHVgSUmJz6Ked7mnkxTAyWVP6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLsTZ+1RPs7AlqCpzdAlV8jzQJeAqKIzE2Ar5DhGLhbHELgKfEPjKwuiQmt2dT+5K
	 AdgcrxhdR+srZHCmSrvVnLYOe2cQlN2z6uXUQ06vh2AYpGx7HPd8OroXT5c8oSjvSB
	 VyPNA/Ibag+WNwVvqKdeeFs8IfC4v9u0m8FmpBbVXOPfrtpm6ZMleeEQcrucm2eQyf
	 eKrpYfDXIEZzD1GBQC5VPUXrbWbYfRmREIrBECtfTMpu8++MIl9ivYkC3ONNrgMQ59
	 oJVVKI1quD56DA8+sgkAhK4Y+TWqkx5FFXPI2yxlzmEr4T2397QBR82teko+ElZslx
	 Ghxl0+lWdYSJg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net v2 2/2] net/sched: act_mirred: don't override retval if we already lost the skb
Date: Tue, 13 Feb 2024 19:38:48 -0800
Message-ID: <20240214033848.981211-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214033848.981211-1-kuba@kernel.org>
References: <20240214033848.981211-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're redirecting the skb, and haven't called tcf_mirred_forward(),
yet, we need to tell the core to drop the skb by setting the retcode
to SHOT. If we have called tcf_mirred_forward(), however, the skb
is out of our hands and returning SHOT will lead to UaF.

Move the retval override to the error path which actually need it.

Fixes: e5cf1baf92cb ("act_mirred: use TC_ACT_REINSERT when possible")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
---
 net/sched/act_mirred.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 291d47c9eb69..6faa7d00da09 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -266,8 +266,7 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
-		err = -ENODEV;
-		goto out;
+		goto err_cant_do;
 	}
 
 	/* we could easily avoid the clone only if called by ingress and clsact;
@@ -279,10 +278,8 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 		tcf_mirred_can_reinsert(retval);
 	if (!dont_clone) {
 		skb_to_send = skb_clone(skb, GFP_ATOMIC);
-		if (!skb_to_send) {
-			err =  -ENOMEM;
-			goto out;
-		}
+		if (!skb_to_send)
+			goto err_cant_do;
 	}
 
 	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
@@ -319,15 +316,16 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 	} else {
 		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
 	}
-
-	if (err) {
-out:
+	if (err)
 		tcf_action_inc_overlimit_qstats(&m->common);
-		if (is_redirect)
-			retval = TC_ACT_SHOT;
-	}
 
 	return retval;
+
+err_cant_do:
+	if (is_redirect)
+		retval = TC_ACT_SHOT;
+	tcf_action_inc_overlimit_qstats(&m->common);
+	return retval;
 }
 
 static int tcf_blockcast_redir(struct sk_buff *skb, struct tcf_mirred *m,
-- 
2.43.0


