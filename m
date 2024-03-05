Return-Path: <netdev+bounces-77586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DE1872398
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F285328783C
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB6712A153;
	Tue,  5 Mar 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFgjDblu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A54129A87
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654671; cv=none; b=huGW6wKIDEu2wR3coxcACDXAqu2m9zRw32SbLTSstXPafNIXI/FCPZ+07yVhjmncGK0yOVebhbCH9DaYmc5i0GAsq7p3tWCIMMWuOuu9xYvw7JphpxNk+x7zNGmCEF9wkPWVEAP03DikKjQ3BFhF0tZ2p62XZm7bUGHKaWoY3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654671; c=relaxed/simple;
	bh=2galitw1vnNWkoOIoi3x8QmdLxZubnHTMRQfqPrTm2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=euewfLZQabftj0jGsTRLDD3rh0DrhLf6Qp8LngjgGWqjLmkkJWtnd4sUTsiHPZDLhkz6nc8VbcmiR1TJesRC8Mw08JHXLyW7kU0leeNloPDqYH5jcTHjlp/OiPQTg+Ebg9aHzrJTZtJqxFsWRGyPFb4aTFDtQ3F78zMW5OOXkH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFgjDblu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so7154448276.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654669; x=1710259469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bZWA9akZOOSAULCC8k5FbB+CJKWtlh5EikBpmDhk9u8=;
        b=BFgjDbluvB4NnQGyhMQ4RhLfgX2kjmYBSv76wlYlwLo9aJus7fmbrY/4Utscc/JJKh
         Puw4BlfbHKdBBeGq1egV9wmaF85HWiImnjOPZjbTVzcSU6SruaVsAoh+EgpD2Ecycsn9
         biGn8b2HUcMgQdtTCyel8staGQRtDEFLjPS+TMGi/Et9ivj7N/SAcr8v2N80T7q2n0iH
         qHHPXIiNeQn94ppLsjwGNSlobYl9rjYOsazWtUwzwUnCjw6JK6a8WLK9Sn838N5f3b03
         Qcr47vVNvnmloYq+wXjbEPCrREeqDnthqa1xhg6uPzxxVSnc5LGuYOic0ImXjU1XXVvw
         NM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654669; x=1710259469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZWA9akZOOSAULCC8k5FbB+CJKWtlh5EikBpmDhk9u8=;
        b=TSgIAtiaitavdI6Q+UsScF/NysSrBhs6Bsjz+9VlT/M1hUcbmWpiUC0VljM4cfQ85y
         lQLSAFrH5AE3RtAWFSR0Ghcbq2Ltyc9RWBNLdSSdJvna5DXegvhtrBQwQusx0AqjcEuG
         1giIJ9BsEQHNmOJI3qiY6GYWFqiSbnC+YWDlxWJB+YTTI1/4xDk5Ot1yI5ydUcYP6rfg
         Z9PWu56Ryju9uI0DwR/pMqZPHXt2ICRwHWwR4kT7J0ad+6g2OOnpjOlTWXlzvSY5+grw
         zLR8YcmoeNWC7LmRxAKlR2WKkBG94v42aVOjXu/QpS0PbSUxJc4V6sNLAA+zzDLkqFcK
         iF7Q==
X-Gm-Message-State: AOJu0YwYzNSF+rM0eX9Un0lzq3JML9w39BTEuHNaJClxmfF+/9nLN3zi
	iD+05a1NIsErJ+5Yf6fSVA1IaWNo6MrRYhBJ/h9kQqACDU1nG4ecD2/mkrqLMyCzC2F4DNSNffs
	aalI/vWCZqQ==
X-Google-Smtp-Source: AGHT+IH7l/+ToW6rIS8SW7Neu9VBv9FdYCcJyXa5bwVuuTtW/R4T/QNNYFoXlTH/wzAJG1b/Zz7vSL/0NfHZXw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:70d:b0:dc6:c94e:fb85 with SMTP
 id k13-20020a056902070d00b00dc6c94efb85mr417157ybt.2.1709654668968; Tue, 05
 Mar 2024 08:04:28 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:04 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-10-edumazet@google.com>
Subject: [PATCH net-next 09/18] net: move dev_rx_weight to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_rx_weight is read from process_backlog().

Move it to net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
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
index 2b0eb6b7f1f2c9b1273b07e06ba0b5c12a2934bf..f45085eddbc997c2a9686b5b4de9da4cc8c4ede8 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -24,6 +24,7 @@ struct net_hotdata {
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


