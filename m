Return-Path: <netdev+bounces-50394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3187F58BE
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 07:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDB41C20A75
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 06:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5318913ACD;
	Thu, 23 Nov 2023 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SskrVJvb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9691B5
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 22:58:51 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso738504a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 22:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700722730; x=1701327530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A0zbTvAUka6aMherpVjkOx7P0dclFSJl9tP9EnXEi5s=;
        b=SskrVJvb03MmJ+37lx6HSL9h2QsxYtt1xCRgBEtkgNepzwMaNqub2wi5L5hmjG6qg3
         WL/mgN82fEn1tHALcb1p1fkslXsGFcuPfrun/DKTTOPm390aua+hxAC77INSlngpn5Kh
         r1jI1T1Gcb4k7MTOTsoz+BXYf6l4KUmACNjTbA8nvPLlZGvoO52eT3so1d3x2n8+Lout
         gaBdZlOW9G/d205ty8NKsrr2+V4dYJU5GGgDiApOpV7bE2/a2X8k73hQmcRPVKZCfUbR
         y4FhfjLqXLN371x2uxf2efnHruSb+tlvLOa106uDuLvNOagAszw5flJNc1OpMn5W8dby
         HTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700722730; x=1701327530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0zbTvAUka6aMherpVjkOx7P0dclFSJl9tP9EnXEi5s=;
        b=CH8GOY+MKWh87c0jox2upuA/5qysJM+XK5jlA4rbf+T8YULYyTqNzo2NR8eiIKTC+k
         wuHqdI6Gh+k4FuPSbdqSsYp3ZBlzY2ekoteyrj/ouX8OkHswgzxDCj9j8UqfnAOawcZI
         1tigLlERm9shAbv1TrHNVaDdznQN3LYojpm9igCzvj9I/gCTnhilDpZDMCBRlnLcWMOg
         lfTzsa0DA3xSJ05BH5eOEvCq2PvAd23JPO5JVMQURmUZkeXesPKOxqo4qGYoOPULuDLe
         du/YqBz+1ryh1jNbe31h/pjmiIEOqm2cvbiAIUh2qp7PM1Lz0CHUoB5RRcl6p0fCIA8G
         RFWA==
X-Gm-Message-State: AOJu0YzkJ0aGw7pP+gK9bWTrPIkBXYAZWHgXF8KQFi3KI7RarMeTAcLp
	Sbof65XIlAUVnYhg7u166fCo+w==
X-Google-Smtp-Source: AGHT+IH0Y4UvJgztW7RfVuaHQt9zZ8sQz0ODWs0oVLGt7v79H7lPGjLBpTpfCJKpcWzCTWSsQ1W8Zw==
X-Received: by 2002:a17:906:10d9:b0:9fd:8d07:a3ad with SMTP id v25-20020a17090610d900b009fd8d07a3admr3128295ejv.17.1700722730330;
        Wed, 22 Nov 2023 22:58:50 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id jy18-20020a170907763200b009fada3e836asm388403ejc.53.2023.11.22.22.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 22:58:49 -0800 (PST)
Date: Thu, 23 Nov 2023 07:58:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next RFC v5 1/4] net/sched: act_mirred: Separate
 mirror and redirect into two distinct functions
Message-ID: <ZV74KFOpn6PilY72@nanopsycho>
References: <20231110214618.1883611-1-victor@mojatatu.com>
 <20231110214618.1883611-2-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110214618.1883611-2-victor@mojatatu.com>

Fri, Nov 10, 2023 at 10:46:15PM CET, victor@mojatatu.com wrote:
>Separate mirror and redirect code into two into two separate functions
>(tcf_mirror_act and tcf_redirect_act). This not only cleans up the code and
>improves both readability and maintainability in addition to reducing the
>complexity given different expectations for mirroring and redirecting.
>
>This patchset has a use case for the mirror part in action "blockcast".

Patchset? Which one? You mean this patch?

>
>Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>---
> include/net/act_api.h  |  85 ++++++++++++++++++++++++++++++++++
> net/sched/act_mirred.c | 103 +++++++++++------------------------------
> 2 files changed, 113 insertions(+), 75 deletions(-)
>
>diff --git a/include/net/act_api.h b/include/net/act_api.h
>index 4ae0580b63ca..8d288040aeb8 100644
>--- a/include/net/act_api.h
>+++ b/include/net/act_api.h
>@@ -12,6 +12,7 @@
> #include <net/pkt_sched.h>
> #include <net/net_namespace.h>
> #include <net/netns/generic.h>
>+#include <net/dst.h>
> 
> struct tcf_idrinfo {
> 	struct mutex	lock;
>@@ -293,5 +294,89 @@ static inline void tcf_action_stats_update(struct tc_action *a, u64 bytes,
> #endif
> }
> 
>+static inline int tcf_mirred_forward(bool to_ingress, bool nested_call,
>+				     struct sk_buff *skb)
>+{
>+	int err;
>+
>+	if (!to_ingress)
>+		err = tcf_dev_queue_xmit(skb, dev_queue_xmit);
>+	else if (nested_call)
>+		err = netif_rx(skb);
>+	else
>+		err = netif_receive_skb(skb);
>+
>+	return err;
>+}
>+
>+static inline struct sk_buff *
>+tcf_mirred_common(struct sk_buff *skb, bool want_ingress, bool dont_clone,
>+		  bool expects_nh, struct net_device *dest_dev)
>+{
>+	struct sk_buff *skb_to_send = skb;
>+	bool at_ingress;
>+	int mac_len;
>+	bool at_nh;
>+	int err;
>+
>+	if (unlikely(!(dest_dev->flags & IFF_UP)) ||
>+	    !netif_carrier_ok(dest_dev)) {
>+		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
>+				       dest_dev->name);
>+		err = -ENODEV;
>+		goto err_out;
>+	}
>+
>+	if (!dont_clone) {
>+		skb_to_send = skb_clone(skb, GFP_ATOMIC);
>+		if (!skb_to_send) {
>+			err =  -ENOMEM;
>+			goto err_out;
>+		}
>+	}
>+
>+	at_ingress = skb_at_tc_ingress(skb);
>+
>+	/* All mirred/redirected skbs should clear previous ct info */
>+	nf_reset_ct(skb_to_send);
>+	if (want_ingress && !at_ingress) /* drop dst for egress -> ingress */
>+		skb_dst_drop(skb_to_send);
>+
>+	at_nh = skb->data == skb_network_header(skb);
>+	if (at_nh != expects_nh) {
>+		mac_len = at_ingress ? skb->mac_len :
>+			  skb_network_offset(skb);
>+		if (expects_nh) {
>+			/* target device/action expect data at nh */
>+			skb_pull_rcsum(skb_to_send, mac_len);
>+		} else {
>+			/* target device/action expect data at mac */
>+			skb_push_rcsum(skb_to_send, mac_len);
>+		}
>+	}
>+
>+	skb_to_send->skb_iif = skb->dev->ifindex;
>+	skb_to_send->dev = dest_dev;
>+
>+	return skb_to_send;
>+
>+err_out:
>+	return ERR_PTR(err);
>+}

It's odd to see functions this size as inlined in header files. I don't
think that is good idea.


>+
>+static inline int
>+tcf_redirect_act(struct sk_buff *skb,
>+		 bool nested_call, bool want_ingress)
>+{
>+	skb_set_redirected(skb, skb->tc_at_ingress);
>+
>+	return tcf_mirred_forward(want_ingress, nested_call, skb);
>+}
>+
>+static inline int
>+tcf_mirror_act(struct sk_buff *skb, bool nested_call, bool want_ingress)
>+{
>+	return tcf_mirred_forward(want_ingress, nested_call, skb);
>+}
> 
> #endif
>diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>index 0a711c184c29..95d30cb06e54 100644
>--- a/net/sched/act_mirred.c
>+++ b/net/sched/act_mirred.c
>@@ -211,38 +211,22 @@ static bool is_mirred_nested(void)
> 	return unlikely(__this_cpu_read(mirred_nest_level) > 1);
> }
> 
>-static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
>-{
>-	int err;
>-
>-	if (!want_ingress)
>-		err = tcf_dev_queue_xmit(skb, dev_queue_xmit);
>-	else if (is_mirred_nested())
>-		err = netif_rx(skb);
>-	else
>-		err = netif_receive_skb(skb);
>-
>-	return err;
>-}
>-
> TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
> 				     const struct tc_action *a,
> 				     struct tcf_result *res)
> {
> 	struct tcf_mirred *m = to_mirred(a);
>-	struct sk_buff *skb2 = skb;
>+	struct sk_buff *skb_to_send;
>+	unsigned int nest_level;
> 	bool m_mac_header_xmit;
> 	struct net_device *dev;
>-	unsigned int nest_level;
>-	int retval, err = 0;
>-	bool use_reinsert;
> 	bool want_ingress;
> 	bool is_redirect;
> 	bool expects_nh;
>-	bool at_ingress;
>+	bool dont_clone;
> 	int m_eaction;
>-	int mac_len;
>-	bool at_nh;
>+	int err = 0;
>+	int retval;
> 
> 	nest_level = __this_cpu_inc_return(mirred_nest_level);
> 	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
>@@ -255,80 +239,49 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
> 	tcf_lastuse_update(&m->tcf_tm);
> 	tcf_action_update_bstats(&m->common, skb);
> 
>-	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
> 	m_eaction = READ_ONCE(m->tcfm_eaction);
>-	retval = READ_ONCE(m->tcf_action);
>+	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
>+	retval = READ_ONCE(a->tcfa_action);
> 	dev = rcu_dereference_bh(m->tcfm_dev);
> 	if (unlikely(!dev)) {
> 		pr_notice_once("tc mirred: target device is gone\n");
>+		err = -ENODEV;
> 		goto out;
> 	}
> 
>-	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
>-		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
>-				       dev->name);
>-		goto out;
>-	}
>+	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
>+	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
>+	expects_nh = want_ingress || !m_mac_header_xmit;
> 
> 	/* we could easily avoid the clone only if called by ingress and clsact;
> 	 * since we can't easily detect the clsact caller, skip clone only for
> 	 * ingress - that covers the TC S/W datapath.
> 	 */
>-	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
>-	at_ingress = skb_at_tc_ingress(skb);
>-	use_reinsert = at_ingress && is_redirect &&
>-		       tcf_mirred_can_reinsert(retval);
>-	if (!use_reinsert) {
>-		skb2 = skb_clone(skb, GFP_ATOMIC);
>-		if (!skb2)
>-			goto out;
>-	}
>-
>-	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
>-
>-	/* All mirred/redirected skbs should clear previous ct info */
>-	nf_reset_ct(skb2);
>-	if (want_ingress && !at_ingress) /* drop dst for egress -> ingress */
>-		skb_dst_drop(skb2);
>+	dont_clone = skb_at_tc_ingress(skb) && is_redirect &&
>+		     tcf_mirred_can_reinsert(retval);
> 
>-	expects_nh = want_ingress || !m_mac_header_xmit;
>-	at_nh = skb->data == skb_network_header(skb);
>-	if (at_nh != expects_nh) {
>-		mac_len = skb_at_tc_ingress(skb) ? skb->mac_len :
>-			  skb_network_offset(skb);
>-		if (expects_nh) {
>-			/* target device/action expect data at nh */
>-			skb_pull_rcsum(skb2, mac_len);
>-		} else {
>-			/* target device/action expect data at mac */
>-			skb_push_rcsum(skb2, mac_len);
>-		}
>+	skb_to_send = tcf_mirred_common(skb, want_ingress, dont_clone,
>+					expects_nh, dev);
>+	if (IS_ERR(skb_to_send)) {
>+		err = PTR_ERR(skb_to_send);
>+		goto out;
> 	}
> 
>-	skb2->skb_iif = skb->dev->ifindex;
>-	skb2->dev = dev;
>-
>-	/* mirror is always swallowed */
> 	if (is_redirect) {
>-		skb_set_redirected(skb2, skb2->tc_at_ingress);
>-
>-		/* let's the caller reinsert the packet, if possible */
>-		if (use_reinsert) {
>-			err = tcf_mirred_forward(want_ingress, skb);
>-			if (err)
>-				tcf_action_inc_overlimit_qstats(&m->common);
>-			__this_cpu_dec(mirred_nest_level);
>-			return TC_ACT_CONSUMED;
>-		}
>+		if (skb == skb_to_send)
>+			retval = TC_ACT_CONSUMED;
>+
>+		err = tcf_redirect_act(skb_to_send, is_mirred_nested(),
>+				       want_ingress);
>+	} else {
>+		err = tcf_mirror_act(skb_to_send, is_mirred_nested(),
>+				     want_ingress);
> 	}
> 
>-	err = tcf_mirred_forward(want_ingress, skb2);
>-	if (err) {
> out:
>+	if (err)
> 		tcf_action_inc_overlimit_qstats(&m->common);
>-		if (tcf_mirred_is_act_redirect(m_eaction))
>-			retval = TC_ACT_SHOT;
>-	}
>+
> 	__this_cpu_dec(mirred_nest_level);
> 
> 	return retval;
>-- 
>2.25.1
>

