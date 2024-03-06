Return-Path: <netdev+bounces-78000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C9873B7A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136331F25691
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1357413BAE3;
	Wed,  6 Mar 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pv5Vbu1l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774D13BAD0
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740857; cv=none; b=TqGWlvp4vP9jt0gYduy1tfb7T245svF+30ldoAVQPxxHjfjAtq8osyi1KbWg0P0dXihXvoDDn11qGtwyz0FEj6xZKvOj8OCIvLItSt6WQulJoJb5hd6kkq7btc43X38D5jkulUeTgyQwTv4+bTpKh5VZM/sttLj+syTa3Wu8lMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740857; c=relaxed/simple;
	bh=KXKN08tlstmfKE8ZXAi8jqIBurtQLBC6PZjviSAZzAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cevaUkYwsnueAdlcJVw3DqrdmczKslkIRbj4wkwezG/TJBCNPYAIFvNDU/MldT6LUJvY9dx7NjNEInN5xcXyuN6q+X2f/SGjcPVGdkFRRytHiMAClvRRd/SCwDO5QayfAJSBGl+nEO3VCvP8DkGtTpx9hLKpOQhB1iTPRXkrW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pv5Vbu1l; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609c800881fso36294117b3.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740855; x=1710345655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Caqqa5nak6NSJOsavnSGkyHAkf1ZcxluNQW5G1xrl1Y=;
        b=Pv5Vbu1lPvSckOZvpkeOcYhK0Cs3uGS17UR3HvCEQ3axJVKeAmruUCGGIjTt3A4I8v
         9XQ79465GSCyRp/PwdzQO+R8u8L6DWtuZkAHC1DMqEUomwob9Wc8SmJxP5O5CwUDgMNc
         CJ50MZ0KtEXObrnqb4kPIl+KljRIGT1hnp8GTmy64hgkntTIVmKrDPNkIWcPSe8pV9AB
         EsoTZJ/LlKSzAbsG56tHaAOJY1pMRoyO/hV08oQnTLzOYxWtVifyJFvBPP4TTMEIanNp
         mx8Hg0R+wIKcqjF7Aq4V5yVNLLbWvkmrHNHFnzr0R/k4doAG33OlO5LHfmicjOK6tSuN
         i23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740855; x=1710345655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Caqqa5nak6NSJOsavnSGkyHAkf1ZcxluNQW5G1xrl1Y=;
        b=YcDjGhssku2Sk4u4d6KszRPqhgn+zfnY7DtVEKsCagtel5CeuKHbPuGP89SFbHSjbv
         EoBrRU+wEdmZdUM8En2/4C5/ZraNJjZ7js+4WqKCi0Q6QXZ9/Ap1N+xymZvDv0+32Gk0
         uiF03t2Dt962gHpFPxW1qUjUlvgfmiV4ZfzBrzcUO51hT9UUhxcmaPI7eXJrrGPdvnt0
         va6hzFN7q0kj6JL3eAudWxu3irnN9mbbcruAAteLi10iiwdIBN2tQPXMswAPDMb0mGA1
         ZpFnLsJz+SbdcbES2c+8JmXg3dDONcnv0F3+bFj9ZWPu7s/5UrFYDUWcD67K+8QYKskS
         EjPg==
X-Forwarded-Encrypted: i=1; AJvYcCVxBU0TylT+sAKEw5gs/53K96O/UonwFpKH8Snw1aQSJmj1vzDPxBJtBSb6jZ+BoqpB1JHTslnRJ8AEVmOuW95C5gLOH1uW
X-Gm-Message-State: AOJu0Yy+FFnw2OUO2XroIfgbXZ3dxYb/8FqEpJo355yJY1Z9nz8J/GYc
	ymBXOXNX3/NTzQOItooySg8nMl8QjLvj4pybiLW3Y0sXaTnm2v1KuiT9R1MX1AshOrn3s79kKYL
	azRWJKYT3tw==
X-Google-Smtp-Source: AGHT+IHL+ocLTe8ycY2hDxbZOo82Ej2Pn4w1Z0YW1EvqVGj5s5PO3Kos+6aT8XaSCfYxLc5EpOmdGXLxPZrE8A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:7945:0:b0:609:22ea:f95e with SMTP id
 u66-20020a817945000000b0060922eaf95emr4147243ywc.4.1709740855500; Wed, 06 Mar
 2024 08:00:55 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:22 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-10-edumazet@google.com>
Subject: [PATCH v2 net-next 09/18] net: move dev_rx_weight to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_rx_weight is read from process_backlog().

Move it to net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/linux/netdevice.h  | 2 --
 include/net/hotdata.h      | 1 +
 net/core/dev.c             | 3 +--
 net/core/hotdata.c         | 1 +
 net/core/sysctl_net_core.c | 2 +-
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c2a735edc44be95fbd4bbd1e234d883582bfde10..d3d4d1052ecb0bc704e9bb40fffbea85cfb6ab03 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4787,8 +4787,6 @@ void dev_fetch_sw_netstats(struct rtnl_link_stats64 *s,
 			   const struct pcpu_sw_netstats __percpu *netstats);
 void dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
 
-extern int		dev_rx_weight;
-
 enum {
 	NESTED_SYNC_IMM_BIT,
 	NESTED_SYNC_TODO_BIT,
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index ffea9cc263e50e4eb69f4f60e2f10c256d9b633f..e6595ed2c3be527fb90959984aca78349147f2eb 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -22,6 +22,7 @@ struct net_hotdata {
 	int			tstamp_prequeue;
 	int			max_backlog;
 	int			dev_tx_weight;
+	int			dev_rx_weight;
 };
 
 extern struct net_hotdata net_hotdata;
diff --git a/net/core/dev.c b/net/core/dev.c
index 3f8d451f42fb9ba621f1ea19e784c7f0be0bf2d8..26676dbd6c8594371a4d30e0dd95d72342e226ca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4408,7 +4408,6 @@ unsigned int sysctl_skb_defer_max __read_mostly = 64;
 int weight_p __read_mostly = 64;           /* old backlog weight */
 int dev_weight_rx_bias __read_mostly = 1;  /* bias for backlog weight */
 int dev_weight_tx_bias __read_mostly = 1;  /* bias for output_queue quota */
-int dev_rx_weight __read_mostly = 64;
 
 /* Called with irq disabled */
 static inline void ____napi_schedule(struct softnet_data *sd,
@@ -5978,7 +5977,7 @@ static int process_backlog(struct napi_struct *napi, int quota)
 		net_rps_action_and_irq_enable(sd);
 	}
 
-	napi->weight = READ_ONCE(dev_rx_weight);
+	napi->weight = READ_ONCE(net_hotdata.dev_rx_weight);
 	while (again) {
 		struct sk_buff *skb;
 
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index ec8c3b48e8fea57491c5870055cffb44c779db44..c8a7a451c18a383d091e413a510d84d163473f2f 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -17,5 +17,6 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 	.tstamp_prequeue = 1,
 	.max_backlog = 1000,
 	.dev_tx_weight = 64,
+	.dev_rx_weight = 64,
 };
 EXPORT_SYMBOL(net_hotdata);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index a30016a8660e09db89b3153e4103c185a800a2ef..8a4c698dad9c97636ca9cebfad925d4220e98f2a 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -301,7 +301,7 @@ static int proc_do_dev_weight(struct ctl_table *table, int write,
 	ret = proc_dointvec(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		weight = READ_ONCE(weight_p);
-		WRITE_ONCE(dev_rx_weight, weight * dev_weight_rx_bias);
+		WRITE_ONCE(net_hotdata.dev_rx_weight, weight * dev_weight_rx_bias);
 		WRITE_ONCE(net_hotdata.dev_tx_weight, weight * dev_weight_tx_bias);
 	}
 	mutex_unlock(&dev_weight_mutex);
-- 
2.44.0.278.ge034bb2e1d-goog


