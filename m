Return-Path: <netdev+bounces-168501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2973A3F2B5
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248693B8B74
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EFB20898C;
	Fri, 21 Feb 2025 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LO1xFUr2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C8208960
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136187; cv=none; b=dxH/LXA0sr+cjx8ffplMhv5jvGyH6DWMOgOJBbBoFk6ZykSN/k4Z4XxRQfKnEz7d82tYPu5xe1tbOksXNjg0ElQxWkXUk+kjUFRqcQ4pVcpgBC6TxrEsGHUHyB+yEw93PHU+PcEBbrOPIMsPUW+4Gzp//5cJDEjn80oCg6/Ipuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136187; c=relaxed/simple;
	bh=MMSUSQ1zq/5iZleZRFTlY8fIfRRDT53Sfdb3LE3BaXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZfD6sUvpz+fmCVI+uzH7iU5IVMpqbvhDKAxKtznTynoz9Mhoq4CeT+lSD3PXmfgYrZHHcfvuMW3dDjhmBu0+BG1kscfMVFY/DuQ6czFQoYiEC1flsDGDwIj9zQIOuJpHcsFAfLA0DZ0q/PqWRmeglA/N4Bt1CmfZxUdGsB4yTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=LO1xFUr2; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-439a7d9a87bso1491005e9.2
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 03:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740136183; x=1740740983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ86mHRD17jzXayTUI/7zYpjMkLmV4veQWy37saC9iw=;
        b=LO1xFUr25XJy8tJg2pxHAuVHQLtLRLJL2dcylDfDeE1KIy63aOzu9YR6cxnGFjSi8S
         5fjHVnx95UcBtuzSKDjSS+v/t9TjH1It19b5FSTA8Jcj7L+cYb8fc440LtPr6VbrZ+Mp
         PucVnxFBzcB6gy/VLv+l3naXsj5oWV2fiP3k2GgVeCLMv9sB2TO3msPm75nOqGSszb5X
         w2ZwqQLXoAHcFYAd5N2gjTadCHqQ46zTp1dEdzl+Pa7oIfA0r87a+ue6twryuKE8lfti
         boE898y+Udi6CosZEcsIqWWVVKUdwTmevaUSyOcb5k98exac8MrcxbKcGma6O0n31ok1
         NUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740136183; x=1740740983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ86mHRD17jzXayTUI/7zYpjMkLmV4veQWy37saC9iw=;
        b=PsVATU/8MnirOEuWY6C+MVFvpZ2dUZ3sDcoPg3Hh+zEWENTrl8mgjvjTezVpJT/xKm
         ysBpOZKY3pb3N966ZOHqwNhqisp9dRw3Xud7Rn/qaZpkMEl/c8K3RdKqownoZ8S1vrr2
         rrsXAJwB9kND5QejZ5PlK0YQSNQHpIDdHYThTHTKCsn7DMT7aABmxnaMeSCMXZSwXKRB
         tkagzB6T6HtnSKV1uedjR+uNyQBcaYPYwel2ghGIUjTsdo8gBfueEhbb+YW4C/3g50Ss
         u0ZwKstWb8O/IP8Yc7o8FaN23VVY7OUznSeaU+geokHvWKI21QXqBGllhyVXLWGmVQFH
         zp0g==
X-Forwarded-Encrypted: i=1; AJvYcCV1sQMGRNfRVKB9ah5yO65f9RvEdztt3wl2qBICxJ1dtCtAmUr8/U5DOLCruL1kNDQmOakMpNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxyt69WarZQ8yrtiNGUxNfpHK0gMy6fq9qaRhBEt6vKhQjMEKk
	QVxrb6KGE0ySamGuNv0wl6wIliH3k4S5i3bGYGzv/f/FlYXMVa/eI8iouKI3ZpXz99AqlOEX0+9
	dUwxgl6NzmIZL5h6kDp1H1MV9Y5i1f7yF
X-Gm-Gg: ASbGnctu8tCOVaA/4XGdg9aPTnZDZ/9b2Cf8nTre6oVct4HrFSRX7SZ4DQXzO7wJH8v
	Wl8nTQ+Jvt92lzAhqaFyg87RzGNTLIv3N/w7m2yZcp888VIYn5FVzRC1HEzorMi/IhkM6ShJcL9
	Jdvc1WaYq2WzeGgI7eaHQRQ3rb+1kOJ8ZbWInfD092pSwnHXZIXFdpyqV1PW0N9sDAGk4mtneBg
	btAz+6ERgnGC1smYru9CWNpw+8YiUG/6mhNBU+P/ZogIiLQGHj7QMsM6Yf7ET6DQABizpMxCG8V
	EtcT6l299SoeQu6dHVUQAnsCAX7rgVStipgeHazPhqYyh9nuiub55zTJkPSqhGCWq2klXLM=
X-Google-Smtp-Source: AGHT+IHryYmAf9E+znwkrAD/5Ag+8lkQ2T+yK8TTFye8iMmYj1dumf6Oj/5lnne8WROEh7+XtjgTMdTSb3iQ
X-Received: by 2002:a05:600c:5489:b0:439:a30f:2e49 with SMTP id 5b1f17b1804b1-439ae222bfemr9941745e9.5.1740136182993;
        Fri, 21 Feb 2025 03:09:42 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-439b02ce4besm852315e9.8.2025.02.21.03.09.42;
        Fri, 21 Feb 2025 03:09:42 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id CC6EC13DBF;
	Fri, 21 Feb 2025 12:09:42 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tlQuc-008ZCr-Is; Fri, 21 Feb 2025 12:09:42 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next v2 2/2] net: remove '__' from __skb_flow_get_ports()
Date: Fri, 21 Feb 2025 12:07:29 +0100
Message-ID: <20250221110941.2041629-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221110941.2041629-1-nicolas.dichtel@6wind.com>
References: <20250221110941.2041629-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only one version of skb_flow_get_ports() exists after the previous commit,
so let's remove the useless '__'.

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 drivers/net/bonding/bond_main.c |  2 +-
 include/linux/skbuff.h          |  4 ++--
 net/core/flow_dissector.c       | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f6d0628a36d9..7d716e90a84c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4214,7 +4214,7 @@ static bool bond_flow_ip(struct sk_buff *skb, struct flow_keys *fk, const void *
 	}
 
 	if (l34 && *ip_proto >= 0)
-		fk->ports.ports = __skb_flow_get_ports(skb, *nhoff, *ip_proto, data, hlen);
+		fk->ports.ports = skb_flow_get_ports(skb, *nhoff, *ip_proto, data, hlen);
 
 	return true;
 }
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f403d43064a5..fe7f98e7c69e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1527,8 +1527,8 @@ void __skb_get_hash_net(const struct net *net, struct sk_buff *skb);
 u32 skb_get_poff(const struct sk_buff *skb);
 u32 __skb_get_poff(const struct sk_buff *skb, const void *data,
 		   const struct flow_keys_basic *keys, int hlen);
-__be32 __skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_proto,
-			    const void *data, int hlen_proto);
+__be32 skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_proto,
+			  const void *data, int hlen_proto);
 
 void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
 			     const struct flow_dissector_key *key,
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 9cd8de6bebb5..1b61bb25ba0e 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -106,7 +106,7 @@ int flow_dissector_bpf_prog_attach_check(struct net *net,
 #endif /* CONFIG_BPF_SYSCALL */
 
 /**
- * __skb_flow_get_ports - extract the upper layer ports and return them
+ * skb_flow_get_ports - extract the upper layer ports and return them
  * @skb: sk_buff to extract the ports from
  * @thoff: transport header offset
  * @ip_proto: protocol for which to get port offset
@@ -116,8 +116,8 @@ int flow_dissector_bpf_prog_attach_check(struct net *net,
  * The function will try to retrieve the ports at offset thoff + poff where poff
  * is the protocol port offset returned from proto_ports_offset
  */
-__be32 __skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_proto,
-			    const void *data, int hlen)
+__be32 skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_proto,
+			  const void *data, int hlen)
 {
 	int poff = proto_ports_offset(ip_proto);
 
@@ -137,7 +137,7 @@ __be32 __skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_proto,
 
 	return 0;
 }
-EXPORT_SYMBOL(__skb_flow_get_ports);
+EXPORT_SYMBOL(skb_flow_get_ports);
 
 static bool icmp_has_id(u8 type)
 {
@@ -870,7 +870,7 @@ __skb_flow_dissect_ports(const struct sk_buff *skb,
 	if (!key_ports && !key_ports_range)
 		return;
 
-	ports = __skb_flow_get_ports(skb, nhoff, ip_proto, data, hlen);
+	ports = skb_flow_get_ports(skb, nhoff, ip_proto, data, hlen);
 
 	if (key_ports)
 		key_ports->ports = ports;
-- 
2.47.1


