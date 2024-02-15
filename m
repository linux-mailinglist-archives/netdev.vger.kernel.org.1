Return-Path: <netdev+bounces-72058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DFC856604
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 15:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A95D28398F
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B7813246A;
	Thu, 15 Feb 2024 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGdRG/M1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4FE132466
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007629; cv=none; b=gRSTncqNr/6P5UZiUhNgdUjnyjosWP9N7KsRHCpeQtAYlZGBLgoTYzGYtio9gm3UPu/w6JSXrcFGRH+JoFKq2M1vuM1kAdKnqKZyU2OVWlG7m21qq4ClXxpQMUts/Ap5v8/urQllLMzdl0W+PZnzBEB6OZ0UaaUgPk+JYtgVnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007629; c=relaxed/simple;
	bh=5s8cNNhQRYyrqVCXz7NI/5KvK73sRuHxFI0BlrRsZ+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CR9tGka0VExqne4oCIEMjTMtVLJeQ/dQy5wUc+w2T46Ti6M81XNfU/JfWTg2It0rXkX4BnbqvB+SlmwNNZOdtoDbCExJkU+DlLDus9sa5n74CzFFl9kMHT2CCWnO0Xir8reGdn+731dayKnjOsPI2OaeanZxctV8dk8ZWjdbH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGdRG/M1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84349C43390;
	Thu, 15 Feb 2024 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708007628;
	bh=5s8cNNhQRYyrqVCXz7NI/5KvK73sRuHxFI0BlrRsZ+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGdRG/M1xeeGtTQz0XKWEKbfM22ZPbvVINokcixZrL2mCIyxU6uQItaXyBso+qjBT
	 F/D+3Pkw3A+tv3IBNHGbq0BFvRcp9259dV+Z37X5j/3uuJegZJYe+eFc3rYp845Lrj
	 GjgDjlMbUiQCYQauHf4zh/Sx/v65TyYzCPFr75mdVy3NtIW/yiRGMnEEsXoqYxMmbF
	 QqKhv+eRqoFzsZu+3PVnOhb/nOUoCqUfnCYVo76W7bTLjXxkLurlj7ZrkDaGIikFSU
	 j4tQIh+I7kDDvYbr3pxxHAp37+dDh2M6J/mZo67OCxcE1zcC/eviMn4uhyUpu0OCMo
	 w9HlCJOwYkxKA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net v3 2/2] net/sched: act_mirred: don't override retval if we already lost the skb
Date: Thu, 15 Feb 2024 06:33:46 -0800
Message-ID: <20240215143346.1715054-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215143346.1715054-1-kuba@kernel.org>
References: <20240215143346.1715054-1-kuba@kernel.org>
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

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
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


