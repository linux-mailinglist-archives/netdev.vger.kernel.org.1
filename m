Return-Path: <netdev+bounces-217284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D9CB382E3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29E04619B7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AC634A32B;
	Wed, 27 Aug 2025 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGE76VaH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89034F48C
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299243; cv=none; b=dNTMI/2/gh6hi12hdG6NmNNHDr7usgkz9Kx8L9DWqAf4fSey1/D3YgVDOqIeAWajXkiaze1O7iVSREXwnM/YKB93LpPrZ/j4qAEQdPWs47gL7lGSc5AKroV9cuJyZ9bXRKwJKiWmOiMpUtiGDX5Y098hvi0vOKx3JkLwiNqzC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299243; c=relaxed/simple;
	bh=KEaQpTosP7yv7EcJkJl03TAwgxaWV3BXJqVnn1/W9pI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i76JWAITOe1N9POmYFm5tdmmPWAlZYI32H6syrF1j/M3dNyWDSDpyqP4qheCOXxmMsMZCna6xayTYSolYpn1sKxp6fkO3PIplzJS4GNKentAuD7fuyM0fBzBJ+PA0GP1BJIZo9gd2X3cftG4HGocn1zUNBbeqEHPoTkqnNDeqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGE76VaH; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b109ae72caso156720701cf.1
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756299240; x=1756904040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYnEb5GDIb0yKDrnqeExnL93xyX1gOO5EFHnsF1W7qs=;
        b=cGE76VaH01D5BmRXScPbb3yEAWGIT3pua8dNMba8FuggWHM3tEeFM+QGU4kGiFt67Q
         F9PbekeMCXBHfI7ROd+E1FThb9yjKWm7BDnYkiHKq83LD+sieQEN96PN2rD+4bmJ+9A1
         rGR4XCBaI792SW5xTT/h1g5nEgMoLcG1SbsJuYuNE2bKexOykqa4aQCaUjWbIjLqZLNs
         6OYYbc3ez/90TySqMSzvk10Ko7cvxcHdfLx7AU2fs5YEUDykS7XQ0TQcTNbAh6ndcNE8
         mkCKluxHzfreuTF8uSY3ZxcyKveICUimFrWXhrTIcRteVDXwhMUowun0xhpYKuDhiS+A
         OaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299240; x=1756904040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYnEb5GDIb0yKDrnqeExnL93xyX1gOO5EFHnsF1W7qs=;
        b=u6KKdsRNHX0K+vCRMO3cNprykJaXVUAfQYCkoYv/DdMUGg7jvR5OwzOpVHt+ReMcLa
         79RpoOqeu69rBL084yiJt7P4VkKs2A5xiUZGciIDb47gm/1EU1rEv3GFTCO4Cosce6de
         LvkgXhVzrzFag6QlS+MEfv4ncIy/ey4Pw+jW0sumAo8G+Hon5G+5++BdvcofXQxKoVI5
         gKqmczJ4mLDnkAlsxg9sgispk2/wZOpNHlPO6LmrAMMomz/XkLELPqDOJIEy/njVnQ0w
         brJNQp9eRQ6KMKRdkxT12l7ZPkPnRcUdkh/gMsSti3TByYsR2Y+jcm55xhHha9yyUqiI
         1LEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrRgklhfkFpFCB2AlGLV05RaS/yEaLglDtQJtwjsNIBD2Bdp87R7O0U80y5LcgGWjTm2VR0Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzprfDmmhBH3hgakPzYGUsXtLC1J9TTjAvo0sL0yQLkl1/8YNkd
	LiGLNkJ0nbdCvjetxSmC898y5Y5SjXTgMqBPsoGPLea7EN19d+Afv19VDCz3y5v+ZtA+9uLhuYi
	ikSFB6X9PxHtfXA==
X-Google-Smtp-Source: AGHT+IGDmnxbJPHWkf4RwreO1YzQKirJNNzixE1Z9s+saybEnj+6AYcBlkn+wvMaJ6jNfLowMkrYMRar0O4HGQ==
X-Received: from qvbgv14.prod.google.com ([2002:a05:6214:262e:b0:70b:b295:d2a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5cc9:0:b0:707:4f43:eed6 with SMTP id 6a1803df08f44-70d97251887mr234478896d6.19.1756299240157;
 Wed, 27 Aug 2025 05:54:00 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:53:48 +0000
In-Reply-To: <20250827125349.3505302-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827125349.3505302-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250827125349.3505302-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] net_sched: act_tunnel_key: use RCU in tunnel_key_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Also storing tcf_action into struct tcf_tunnel_key_params
makes sure there is no discrepancy in tunnel_key_act().

No longer block BH in tunnel_key_init() when acquiring tcf_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tc_act/tc_tunnel_key.h |  1 +
 net/sched/act_tunnel_key.c         | 20 +++++++++-----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/net/tc_act/tc_tunnel_key.h b/include/net/tc_act/tc_tunnel_key.h
index 879fe8cff581951c759076b159d3ee16f9db34c1..0f1925f97520209b3a9f110d3c7e9bb3c5ef2968 100644
--- a/include/net/tc_act/tc_tunnel_key.h
+++ b/include/net/tc_act/tc_tunnel_key.h
@@ -14,6 +14,7 @@
 struct tcf_tunnel_key_params {
 	struct rcu_head		rcu;
 	int			tcft_action;
+	int			action;
 	struct metadata_dst     *tcft_enc_metadata;
 };
 
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 2cef4b08befbecf498ea836d45abdef1ee4e06b5..e1c8b48c217c339d5e806d031ba287df2a57b1aa 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -29,13 +29,11 @@ TC_INDIRECT_SCOPE int tunnel_key_act(struct sk_buff *skb,
 {
 	struct tcf_tunnel_key *t = to_tunnel_key(a);
 	struct tcf_tunnel_key_params *params;
-	int action;
 
 	params = rcu_dereference_bh(t->params);
 
 	tcf_lastuse_update(&t->tcf_tm);
 	tcf_action_update_bstats(&t->common, skb);
-	action = READ_ONCE(t->tcf_action);
 
 	switch (params->tcft_action) {
 	case TCA_TUNNEL_KEY_ACT_RELEASE:
@@ -51,7 +49,7 @@ TC_INDIRECT_SCOPE int tunnel_key_act(struct sk_buff *skb,
 		break;
 	}
 
-	return action;
+	return params->action;
 }
 
 static const struct nla_policy
@@ -532,11 +530,12 @@ static int tunnel_key_init(struct net *net, struct nlattr *nla,
 	params_new->tcft_action = parm->t_action;
 	params_new->tcft_enc_metadata = metadata;
 
-	spin_lock_bh(&t->tcf_lock);
+	params_new->action = parm->action;
+	spin_lock(&t->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	params_new = rcu_replace_pointer(t->params, params_new,
 					 lockdep_is_held(&t->tcf_lock));
-	spin_unlock_bh(&t->tcf_lock);
+	spin_unlock(&t->tcf_lock);
 	tunnel_key_release_params(params_new);
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
@@ -726,10 +725,9 @@ static int tunnel_key_dump(struct sk_buff *skb, struct tc_action *a,
 	};
 	struct tcf_t tm;
 
-	spin_lock_bh(&t->tcf_lock);
-	params = rcu_dereference_protected(t->params,
-					   lockdep_is_held(&t->tcf_lock));
-	opt.action   = t->tcf_action;
+	rcu_read_lock();
+	params = rcu_dereference(t->params);
+	opt.action   = params->action;
 	opt.t_action = params->tcft_action;
 
 	if (nla_put(skb, TCA_TUNNEL_KEY_PARMS, sizeof(opt), &opt))
@@ -766,12 +764,12 @@ static int tunnel_key_dump(struct sk_buff *skb, struct tc_action *a,
 	if (nla_put_64bit(skb, TCA_TUNNEL_KEY_TM, sizeof(tm),
 			  &tm, TCA_TUNNEL_KEY_PAD))
 		goto nla_put_failure;
-	spin_unlock_bh(&t->tcf_lock);
+	rcu_read_unlock();
 
 	return skb->len;
 
 nla_put_failure:
-	spin_unlock_bh(&t->tcf_lock);
+	rcu_read_unlock();
 	nlmsg_trim(skb, b);
 	return -1;
 }
-- 
2.51.0.261.g7ce5a0a67e-goog


