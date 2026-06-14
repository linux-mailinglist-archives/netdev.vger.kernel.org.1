Return-Path: <netdev+bounces-299137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ixeRBZMoLmrtqAQAu9opvQ
	(envelope-from <netdev+bounces-299137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:05:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E7B680558
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:05:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UrBXl85u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299137-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299137-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2729F3058FD3
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 04:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025652D5412;
	Sun, 14 Jun 2026 04:01:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3C2BE7DB
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 04:01:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781409690; cv=none; b=mPkRBXe6BfdMdhgeBPOJqaV5omvFLmrc/Z6R8THQDD+/ZxNZ9BjLBnrvQSuwlRPSxtHEjEnOIdLcQ3kgOnkb+hJMyK/aqqrtpyenH7PC+U2Xi1IjxvGHHbeCBg9t9HFcROIzmKGpj1X16qCg6qNR4GuXpXlw49VL3gxk+6tHmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781409690; c=relaxed/simple;
	bh=1Lr8lhopJLB4l3/8uIHxvubAFVhlBm3hpzdsgOpnjLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI2cy+84IBAzsH+My7cr8IrtihPUcjvyTz7Z0kZ05dJcby+2DKZdZoWraQuqGB2AFVvGZU93kUbQUBXByyejTwkd2MwowwUwON5bCnMDhsdJ2mPhy9+f2OgZHadFNm6fAAhVZs+YkahMAej7Iml1u+DsZNzjNa/dzS3p6jRXG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrBXl85u; arc=none smtp.client-ip=209.85.215.172
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c86214eead7so934737a12.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 21:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781409688; x=1782014488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UyMi/KYvRNIKUlOOeZw9yUh9eSU0o6XkwqlaaJqTO0=;
        b=UrBXl85uu9jKICMoyEzBMEVVuOPHty8yVCG+HDHFUotE+0u5Eyt+X+HGByoXYFHL/y
         WUBwExcnstak+X6GB7wFihCOCzmKceVvMqdecW74Je6I29lA+Lqn0AjfzY/jOebGKljT
         EfAI7kDpcDJaXzbF8mq07bN7oBPkdEFK6k/RXHdQur9pQqEvxTqDk/IJhYa1xIdpqhXe
         OEV4HoDd8EvwWp+VEaxlN42DDjShEmRmZXIlwA+NC+gXIwSngZc9+PI9ruMEm//qpBIs
         Ec8HnDF0rvEQD9Jj/IyJ9PJ8zCG16KULK33RCPBEmw8aoEB/CTGNnMTvM8kYTOAPKCM6
         NZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781409688; x=1782014488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2UyMi/KYvRNIKUlOOeZw9yUh9eSU0o6XkwqlaaJqTO0=;
        b=GNlYiLJmtlxtxGpFwIlZFlrRc5lO8Io+GiXXsW0kGs7/pTb8EkzZLAUnuPzDLqBfUQ
         GScrRu3McyjbLKRkbuRguy7fdwnThXYwOfbI5l/yMi7CUba+AKO9MUVQ/3OlrGa3EwWl
         fYoSIylOcJl9nhsEW+SC+c8j1W5IDNjLN25GpoTvSG7kguAkZTDVPgopUMP9835N5pFD
         DABV02wKY6Wi+uZO9zTGzKLc3wLZAq2uS7LQl0U9mnOKdTA716qYqdlc7RAqA2jQ3TFi
         feCGAbd4DwgLGdiGsSWrXixOuaHuD17yIkeprPscWZFDyYTQx9JKi5XpnrXrl0M7APUN
         la+A==
X-Gm-Message-State: AOJu0Yzmh05Ggfr9ExXdQESkfa89EwuZWrPttmuKAZPPjCxVPgnwilvK
	kkI/33fL06yqDgnIZGgmhwyKB3aJoKpee3hGSkVPynRZVVkqQFXbyDcrlHpRECr5
X-Gm-Gg: Acq92OFHQ+T+Du0mV6sjwQLUs7GSjaRPKy59XlpyfPjbYXa+CkY/Cp/1RNL2pOrJj8V
	q3sfmVn/1jNd6yhAtz3phB22Er9pgrsn11BL7i3gLTJzizNd9VadZ5bt9rGH8CJpAMU2UvErdbv
	LY1Cf7tuYeEhBEajuEzjR7xkVc7sj506ap1c/ICHT/wtm+dz3V0aSksZPc6ntDs8Qb2ICI3Ofih
	ZiaPUpIpqLNNudhju2AhpD56Ky+aSRs9OOi98bfnLpLJRUolZZUoafKnCr2sdXnBxExq3zZWIwU
	Z0evyscWh7msvJHuqK8yxBxXMMfIaHXSiFZvYqj7O0zbuTrmjcIv/0FeYnHFvBBN5qFme46OV6i
	fR5lMLhtICsC7oi3Z3kZkTTMEPDLzrsz8mGB/ckWnhW4p2Wb3RObnyEvY6ywl5UGL1+4i9098/9
	054GLFaCt27qS1BppllgA=
X-Received: by 2002:a05:6300:614e:b0:3a3:adea:83bc with SMTP id adf61e73a8af0-3b7857de9bamr8068767637.15.1781409688176;
        Sat, 13 Jun 2026 21:01:28 -0700 (PDT)
Received: from mincom1 ([115.4.79.42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661a67603sm5676983a12.0.2026.06.13.21.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 21:01:27 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: netdev@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [RFC PATCH net-next 6/7] net: airoha: add PPE support for SOE flows
Date: Sun, 14 Jun 2026 13:00:31 +0900
Message-ID: <20260614040032.1567994-7-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614040032.1567994-1-hurryman2212@gmail.com>
References: <20260614040032.1567994-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299137-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gondor.apana.org.au,secunet.com,vger.kernel.org,gmail.com,collabora.com,lists.infradead.org,nbd.name];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:ansuelsmth@gmail.com,m:nbd@nbd.name,m:linux-kernel@vger.kernel.org,m:hurryman2212@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64E7B680558

Add PPE metadata handling for SOE flows so decrypted packets can carry
their original FOE/SA context until the normal egress path is known, and
so XFRM flowtable entries can be programmed with SOE SA and hop
information.

Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_ppe.c  | 606 +++++++++++++++++++++-
 include/linux/soc/airoha/airoha_offload.h |   5 +
 2 files changed, 585 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 91bcc55a6ac6..faa5f04d4c7b 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -6,18 +6,77 @@
 
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/kstrtox.h>
+#include <linux/moduleparam.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/rhashtable.h>
+#include <linux/sysfs.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
 #include <net/ipv6.h>
+#include <net/netfilter/nf_flow_table.h>
 #include <net/pkt_cls.h>
+#include <net/route.h>
 
 #include "airoha_regs.h"
 #include "airoha_eth.h"
+#include "airoha_soe.h"
 
 static DEFINE_MUTEX(flow_offload_mutex);
 static DEFINE_SPINLOCK(ppe_lock);
 
+#define AIROHA_FOE_HOP0			GENMASK(31, 29)
+#define AIROHA_FOE_HOP1			GENMASK(28, 26)
+#define AIROHA_FOE_HOP2			GENMASK(25, 23)
+#define AIROHA_FOE_HOP3			GENMASK(22, 20)
+#define AIROHA_FOE_HOP_MASK						\
+	(AIROHA_FOE_HOP0 | AIROHA_FOE_HOP1 | AIROHA_FOE_HOP2 |		\
+	 AIROHA_FOE_HOP3)
+#define AIROHA_PPE_SOE_DEFAULT_TUNNEL_MTU	1500
+#define AIROHA_PPE_SOE_MAGIC_IPSEC		0x72a1
+#define AIROHA_PPE_SOE_PORT_AG			0x3f
+#define AIROHA_PPE_SOE_CHANNEL			2
+#define AIROHA_PPE_SOE_META_TIMEOUT_MS		1000
+#define AIROHA_PPE_SOE_MAGIC_GDM4		0x729a
+#define AIROHA_PPE_SOE_MARK_MAGIC		0x5e000000
+#define AIROHA_PPE_SOE_MARK_MAGIC_MASK		0xff000000
+#define AIROHA_PPE_SOE_MARK_HASH_MASK		0x00ffff00
+#define AIROHA_PPE_DEFAULT_BIND_RATE		0x1e
+#define AIROHA_PPE_SOE_BIND_DELAY_PACKETS	2
+#define AIROHA_PPE_FORCE_COMMIT_PROBE_WINDOW	0
+
+struct airoha_ppe_soe_tuple_info {
+	unsigned int tunnel_mtu;
+	u8 sa_index;
+	u8 hop;
+};
+
+static unsigned int airoha_ppe_bind_rate = AIROHA_PPE_DEFAULT_BIND_RATE;
+static unsigned int airoha_ppe_soe_inline_bind_delay_packets =
+	AIROHA_PPE_SOE_BIND_DELAY_PACKETS;
+static unsigned int airoha_ppe_soe_inline_force_commit_probe_window =
+	AIROHA_PPE_FORCE_COMMIT_PROBE_WINDOW;
+static struct airoha_ppe *airoha_ppe_active;
+
+static int airoha_ppe_set_bind_rate(const char *val,
+				    const struct kernel_param *kp);
+static int airoha_ppe_get_bind_rate(char *buf, const struct kernel_param *kp);
+
+module_param_named(soe_inline_force_commit_probe_window,
+		   airoha_ppe_soe_inline_force_commit_probe_window, uint, 0600);
+MODULE_PARM_DESC(soe_inline_force_commit_probe_window,
+		 "Adjacent FOE slots searched before force-commit");
+module_param_named(soe_inline_bind_delay_packets,
+		   airoha_ppe_soe_inline_bind_delay_packets, uint, 0600);
+MODULE_PARM_DESC(soe_inline_bind_delay_packets,
+		 "CPU-visible SOE decrypt packets before binding FOE entry");
+module_param_call(ppe_bind_rate, airoha_ppe_set_bind_rate,
+		  airoha_ppe_get_bind_rate, NULL, 0600);
+__MODULE_PARM_TYPE(ppe_bind_rate, "uint");
+MODULE_PARM_DESC(ppe_bind_rate,
+		 "PPE bind-rate threshold for L2B and bind fields");
+
 static const struct rhashtable_params airoha_flow_table_params = {
 	.head_offset = offsetof(struct airoha_flow_table_entry, node),
 	.key_offset = offsetof(struct airoha_flow_table_entry, cookie),
@@ -78,6 +137,17 @@ bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index)
 	return airoha_fe_rr(eth, REG_PPE_GLO_CFG(index)) & PPE_GLO_CFG_EN_MASK;
 }
 
+static void airoha_ppe_apply_bind_rate(struct airoha_eth *eth, int ppe_idx)
+{
+	u32 rate = min_t(u32, READ_ONCE(airoha_ppe_bind_rate),
+			 FIELD_MAX(PPE_BIND_RATE_BIND_MASK));
+
+	airoha_fe_rmw(eth, REG_PPE_BIND_RATE(ppe_idx),
+		      PPE_BIND_RATE_L2B_BIND_MASK | PPE_BIND_RATE_BIND_MASK,
+		      FIELD_PREP(PPE_BIND_RATE_L2B_BIND_MASK, rate) |
+			      FIELD_PREP(PPE_BIND_RATE_BIND_MASK, rate));
+}
+
 static u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe)
 {
 	return airoha_fe_get(ppe->eth, REG_FE_FOE_TS,
@@ -157,15 +227,14 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 			      FIELD_PREP(PPE_DRAM_TB_NUM_ENTRY_MASK,
 					 dram_num_entries));
 
-		airoha_fe_rmw(eth, REG_PPE_BIND_RATE(i),
-			      PPE_BIND_RATE_L2B_BIND_MASK |
-			      PPE_BIND_RATE_BIND_MASK,
-			      FIELD_PREP(PPE_BIND_RATE_L2B_BIND_MASK, 0x1e) |
-			      FIELD_PREP(PPE_BIND_RATE_BIND_MASK, 0x1e));
+		airoha_ppe_apply_bind_rate(eth, i);
 
 		airoha_fe_wr(eth, REG_PPE_HASH_SEED(i), PPE_HASH_SEED);
 		airoha_fe_clear(eth, REG_PPE_PPE_FLOW_CFG(i),
 				PPE_FLOW_CFG_IP6_6RD_MASK);
+		airoha_fe_set(eth, REG_PPE_PPE_FLOW_CFG(i),
+			      PPE_FLOW_CFG_IP4_IPSEC_MASK |
+				      PPE_FLOW_CFG_IP6_IPSEC_MASK);
 
 		for (p = 0; p < ARRAY_SIZE(eth->ports); p++)
 			airoha_fe_rmw(eth, REG_PPE_MTU(i, p),
@@ -509,6 +578,162 @@ static int airoha_ppe_foe_entry_set_ipv6_tuple(struct airoha_foe_entry *hwe,
 	return 0;
 }
 
+static int airoha_ppe_soe_fill_inner_ipv4_data(struct sk_buff *skb,
+					       struct airoha_flow_data *data,
+					       int *type, int *l4proto)
+{
+	unsigned int ip_offset = ETH_HLEN;
+	union {
+		struct tcphdr tcp;
+		struct udphdr udp;
+	} ports;
+	struct iphdr iph_buf, *iph;
+	unsigned int l4_offset;
+	struct udphdr *udp;
+	struct tcphdr *tcp;
+
+	if (skb_headlen(skb) < ETH_HLEN)
+		return -EINVAL;
+
+	memcpy(&data->eth, skb->data, ETH_HLEN);
+	if (data->eth.h_proto != htons(ETH_P_IP))
+		return -EAFNOSUPPORT;
+
+	iph = skb_header_pointer(skb, ip_offset, sizeof(iph_buf), &iph_buf);
+	if (!iph || iph->ihl < 5 || iph->version != 4)
+		return -EINVAL;
+
+	l4_offset = ip_offset + iph->ihl * 4;
+	data->v4.src_addr = iph->saddr;
+	data->v4.dst_addr = iph->daddr;
+	*l4proto = iph->protocol;
+
+	switch (iph->protocol) {
+	case IPPROTO_TCP:
+		tcp = skb_header_pointer(skb, l4_offset, sizeof(ports.tcp),
+					 &ports.tcp);
+		if (!tcp)
+			return -EINVAL;
+
+		data->src_port = tcp->source;
+		data->dst_port = tcp->dest;
+		*type = PPE_PKT_TYPE_IPV4_HNAPT;
+		break;
+	case IPPROTO_UDP:
+		udp = skb_header_pointer(skb, l4_offset, sizeof(ports.udp),
+					 &ports.udp);
+		if (!udp)
+			return -EINVAL;
+
+		data->src_port = udp->source;
+		data->dst_port = udp->dest;
+		*type = PPE_PKT_TYPE_IPV4_HNAPT;
+		break;
+	default:
+		*type = PPE_PKT_TYPE_IPV4_ROUTE;
+		break;
+	}
+
+	return 0;
+}
+
+static int airoha_ppe_foe_entry_set_soe_fields(struct airoha_foe_entry *hwe,
+					       u8 sa_index, u8 hop,
+					       unsigned int tunnel_mtu)
+{
+	int type;
+
+	if (hop > FIELD_MAX(AIROHA_FOE_HOP0))
+		return -ERANGE;
+
+	type = FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, hwe->ib1);
+	switch (type) {
+	case PPE_PKT_TYPE_IPV4_HNAPT:
+	case PPE_PKT_TYPE_IPV4_ROUTE:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	tunnel_mtu = min_t(unsigned int, tunnel_mtu,
+			   FIELD_MAX(AIROHA_FOE_TUNNEL_MTU));
+
+	/* SOE FOE entries store the hop selector and SA index here. */
+	hwe->ipv4.rsv[0] &= ~AIROHA_FOE_HOP_MASK;
+	hwe->ipv4.rsv[0] |= FIELD_PREP(AIROHA_FOE_HOP0, hop);
+
+	hwe->ipv4.data &= ~(AIROHA_FOE_ACTDP | AIROHA_FOE_TUNNEL_ID);
+	hwe->ipv4.data |= AIROHA_FOE_TUNNEL |
+			  FIELD_PREP(AIROHA_FOE_ACTDP, sa_index);
+
+	hwe->ipv4.l2.meter &= ~AIROHA_FOE_TUNNEL_MTU;
+	hwe->ipv4.l2.meter |= FIELD_PREP(AIROHA_FOE_TUNNEL_MTU, tunnel_mtu);
+
+	hwe->ib1 &= ~AIROHA_FOE_IB1_BIND_TUNNEL_DECAP;
+
+	return 0;
+}
+
+static int
+airoha_ppe_soe_get_tuple_info(const struct flow_offload_tuple *tuple,
+			      struct airoha_ppe_soe_tuple_info *info)
+{
+	int err;
+
+	if (!tuple || !info)
+		return -EINVAL;
+	if (tuple->xmit_type != FLOW_OFFLOAD_XMIT_XFRM)
+		return -EOPNOTSUPP;
+
+	err = airoha_soe_xfrm_ppe_info(tuple->dst_cache, &info->sa_index,
+				       &info->hop);
+	if (err)
+		return err;
+
+	info->tunnel_mtu = tuple->mtu ? tuple->mtu :
+				      AIROHA_PPE_SOE_DEFAULT_TUNNEL_MTU;
+
+	return 0;
+}
+
+static int
+airoha_ppe_foe_entry_set_soe_info(struct airoha_foe_entry *hwe,
+				  const struct flow_offload_tuple *tuple)
+{
+	struct airoha_ppe_soe_tuple_info info;
+	int err;
+
+	if (!tuple)
+		return 0;
+	if (tuple->xmit_type != FLOW_OFFLOAD_XMIT_XFRM)
+		return 0;
+
+	err = airoha_ppe_soe_get_tuple_info(tuple, &info);
+	if (err)
+		return err;
+
+	err = airoha_ppe_foe_entry_set_soe_fields(hwe, info.sa_index,
+						  info.hop, info.tunnel_mtu);
+	if (err)
+		return err;
+
+	/* XFRM packet-offload entries are not plain Ethernet/IP entries:
+	 * the PPE must tag them as SOE/IPsec work and submit them through the
+	 * SOE-facing channel/port aggregation path. Without these fields the
+	 * entry can still become BND, but traffic falls back to the slow path
+	 * instead of the inline encrypt/decrypt datapath.
+	 */
+	hwe->ipv4.l2.common.etype = AIROHA_PPE_SOE_MAGIC_IPSEC;
+	hwe->ipv4.data &= ~AIROHA_FOE_CHANNEL;
+	hwe->ipv4.data |= FIELD_PREP(AIROHA_FOE_CHANNEL,
+				     AIROHA_PPE_SOE_CHANNEL);
+	hwe->ipv4.ib2 &= ~AIROHA_FOE_IB2_PORT_AG;
+	hwe->ipv4.ib2 |= FIELD_PREP(AIROHA_FOE_IB2_PORT_AG,
+				    AIROHA_PPE_SOE_PORT_AG);
+
+	return 0;
+}
+
 static u32 airoha_ppe_foe_get_entry_hash(struct airoha_ppe *ppe,
 					 struct airoha_foe_entry *hwe)
 {
@@ -633,6 +858,9 @@ static void airoha_ppe_foe_flow_stats_update(struct airoha_ppe *ppe,
 		meter = &hwe->ipv4.l2.meter;
 	}
 
+	if (*data & AIROHA_FOE_TUNNEL)
+		return;
+
 	pse_port = FIELD_GET(AIROHA_FOE_IB2_PSE_PORT, *ib2);
 	if (pse_port == FE_PSE_PORT_CDM4)
 		return;
@@ -868,16 +1096,129 @@ airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
 	return 0;
 }
 
-static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
-					struct sk_buff *skb,
-					u32 hash, bool rx_wlan)
+static void airoha_ppe_soe_meta_store(struct airoha_ppe_soe_meta *meta,
+				      u32 key_hash, u16 foe_hash, u8 sa_index,
+				      u8 hop)
 {
-	struct airoha_flow_table_entry *e;
-	struct airoha_foe_bridge br = {};
-	struct airoha_foe_entry *hwe;
-	bool commit_done = false;
-	struct hlist_node *n;
-	u32 index, state;
+	u8 seen = 1;
+
+	if (READ_ONCE(meta->valid) &&
+	    READ_ONCE(meta->key_hash) == key_hash &&
+	    READ_ONCE(meta->foe_hash) == foe_hash &&
+	    READ_ONCE(meta->sa_index) == sa_index &&
+	    READ_ONCE(meta->hop) == hop &&
+	    time_before_eq(jiffies, READ_ONCE(meta->expires)))
+		seen = min_t(u8, READ_ONCE(meta->seen) + 1, U8_MAX);
+
+	WRITE_ONCE(meta->key_hash, key_hash);
+	WRITE_ONCE(meta->foe_hash, foe_hash);
+	WRITE_ONCE(meta->sa_index, sa_index);
+	WRITE_ONCE(meta->hop, hop);
+	WRITE_ONCE(meta->seen, seen);
+	WRITE_ONCE(meta->expires,
+		   jiffies + msecs_to_jiffies(AIROHA_PPE_SOE_META_TIMEOUT_MS));
+	WRITE_ONCE(meta->valid, 1);
+}
+
+void airoha_ppe_soe_mark_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
+			     u16 hash, u8 sa_index, u8 hop)
+{
+	struct airoha_ppe *ppe;
+	u32 ppe_hash_mask;
+
+	if (!dev || !skb)
+		return;
+
+	ppe = dev->priv;
+	if (!ppe || !ppe->soe_meta)
+		return;
+
+	ppe_hash_mask = airoha_ppe_get_total_num_entries(ppe) - 1;
+	if (hash > ppe_hash_mask)
+		return;
+
+	/* SOE decrypt completion is CPU-visible before normal routing has
+	 * selected the plaintext egress netdev. Keep the original encrypted FOE
+	 * hash and SA hop briefly on the skb so airoha_dev_xmit() can finish
+	 * the PPE entry once the final egress descriptor is known.
+	 */
+	airoha_ppe_soe_meta_store(&ppe->soe_meta[hash], hash, hash, sa_index,
+				  hop);
+	ppe->foe_check_time[hash] = 0;
+
+	skb->mark &= ~(AIROHA_PPE_SOE_MARK_MAGIC_MASK |
+		       AIROHA_PPE_SOE_MARK_HASH_MASK);
+	skb->mark |= AIROHA_PPE_SOE_MARK_MAGIC |
+		     FIELD_PREP(AIROHA_PPE_SOE_MARK_HASH_MASK, hash);
+}
+
+bool airoha_ppe_soe_skb_marked(struct sk_buff *skb)
+{
+	return skb && ((skb->mark & AIROHA_PPE_SOE_MARK_MAGIC_MASK) ==
+		       AIROHA_PPE_SOE_MARK_MAGIC);
+}
+
+void airoha_ppe_soe_xmit_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
+			     struct net_device *netdev)
+{
+	struct airoha_foe_entry entry, tmpl, *hwe;
+	struct airoha_flow_data data = {};
+	struct airoha_ppe_soe_meta *meta;
+	u32 ppe_hash_mask, key_hash;
+	struct airoha_gdm_dev *gdm;
+	struct airoha_ppe *ppe;
+	unsigned long expires;
+	u16 hash;
+	int err, l4proto, type;
+	u8 sa_index, hop;
+	u8 seen;
+
+	if (!dev || !skb || !netdev)
+		return;
+
+	if ((skb->mark & AIROHA_PPE_SOE_MARK_MAGIC_MASK) !=
+	    AIROHA_PPE_SOE_MARK_MAGIC)
+		return;
+
+	ppe = dev->priv;
+	if (!ppe || !ppe->soe_meta)
+		goto clear_mark;
+
+	ppe_hash_mask = airoha_ppe_get_total_num_entries(ppe) - 1;
+	key_hash = FIELD_GET(AIROHA_PPE_SOE_MARK_HASH_MASK, skb->mark);
+	if (key_hash > ppe_hash_mask)
+		goto clear_mark;
+
+	meta = &ppe->soe_meta[key_hash];
+	if (!READ_ONCE(meta->valid))
+		goto clear_mark;
+
+	if (READ_ONCE(meta->key_hash) != key_hash)
+		goto clear_mark;
+
+	expires = READ_ONCE(meta->expires);
+	if (time_after(jiffies, expires)) {
+		WRITE_ONCE(meta->valid, 0);
+		goto clear_mark;
+	}
+
+	hash = READ_ONCE(meta->foe_hash);
+	if (hash > ppe_hash_mask) {
+		WRITE_ONCE(meta->valid, 0);
+		goto clear_mark;
+	}
+
+	seen = READ_ONCE(meta->seen);
+	if (seen <= READ_ONCE(airoha_ppe_soe_inline_bind_delay_packets))
+		goto clear_mark;
+
+	err = airoha_ppe_soe_fill_inner_ipv4_data(skb, &data, &type, &l4proto);
+	if (err)
+		goto clear_mark;
+
+	sa_index = READ_ONCE(meta->sa_index);
+	hop = READ_ONCE(meta->hop);
+	WRITE_ONCE(meta->valid, 0);
 
 	spin_lock_bh(&ppe_lock);
 
@@ -885,13 +1226,120 @@ static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
 	if (!hwe)
 		goto unlock;
 
-	state = FIELD_GET(AIROHA_FOE_IB1_BIND_STATE, hwe->ib1);
-	if (state == AIROHA_FOE_STATE_BIND)
+	switch (FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, hwe->ib1)) {
+	case PPE_PKT_TYPE_IPV4_HNAPT:
+	case PPE_PKT_TYPE_IPV4_ROUTE:
+		break;
+	default:
 		goto unlock;
+	}
 
-	index = airoha_ppe_foe_get_entry_hash(ppe, hwe);
-	hlist_for_each_entry_safe(e, n, &ppe->foe_flow[index], list) {
+	err = airoha_ppe_foe_entry_prepare(ppe->eth, &tmpl, netdev, type,
+					   &data, l4proto);
+	if (err)
+		goto unlock;
+
+	memcpy(&entry, hwe, sizeof(entry));
+	entry.ib1 &= ~(AIROHA_FOE_IB1_BIND_STATE |
+		       AIROHA_FOE_IB1_BIND_KEEPALIVE |
+		       AIROHA_FOE_IB1_BIND_TIMESTAMP);
+	entry.ib1 |= FIELD_PREP(AIROHA_FOE_IB1_BIND_STATE,
+				AIROHA_FOE_STATE_BIND) |
+		     AIROHA_FOE_IB1_BIND_TTL;
+	entry.ib1 = (entry.ib1 & (AIROHA_FOE_IB1_BIND_PACKET_TYPE |
+				  AIROHA_FOE_IB1_BIND_UDP)) |
+		    (tmpl.ib1 & ~(AIROHA_FOE_IB1_BIND_PACKET_TYPE |
+				  AIROHA_FOE_IB1_BIND_UDP));
+	entry.ipv4.ib2 = tmpl.ipv4.ib2;
+	entry.ipv4.data = tmpl.ipv4.data;
+	memcpy(&entry.ipv4.l2, &tmpl.ipv4.l2, sizeof(entry.ipv4.l2));
+
+	gdm = netdev_priv(netdev);
+	if (gdm->port && gdm->port->id == AIROHA_GDM4_IDX)
+		entry.ipv4.l2.common.etype = AIROHA_PPE_SOE_MAGIC_GDM4;
+
+	if (FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, entry.ib1) ==
+	    PPE_PKT_TYPE_IPV4_HNAPT)
+		memcpy(&entry.ipv4.new_tuple, &entry.ipv4.orig_tuple,
+		       sizeof(entry.ipv4.new_tuple));
+
+	/* Commit the original decrypt entry only after the normal transmit path
+	 * has provided the final plaintext egress descriptor. Binding it at SOE
+	 * RX completion would miss this device-specific L2/PSE state.
+	 */
+	err = airoha_ppe_foe_entry_set_soe_fields(&entry, sa_index, hop,
+						  AIROHA_PPE_SOE_DEFAULT_TUNNEL_MTU);
+	if (!err)
+		airoha_ppe_foe_commit_entry(ppe, &entry, hash, false);
+
+unlock:
+	spin_unlock_bh(&ppe_lock);
+clear_mark:
+	skb->mark &= ~(AIROHA_PPE_SOE_MARK_MAGIC_MASK |
+		       AIROHA_PPE_SOE_MARK_HASH_MASK);
+}
+
+void airoha_ppe_soe_flush_sa(struct airoha_ppe *ppe, u8 sa_index)
+{
+	u32 num_entries, hash;
+
+	if (!ppe)
+		return;
+
+	num_entries = airoha_ppe_get_total_num_entries(ppe);
+
+	spin_lock_bh(&ppe_lock);
+	for (hash = 0; hash < num_entries; hash++) {
+		struct airoha_foe_entry *hwe;
+		u32 state, type;
+
+		hwe = airoha_ppe_foe_get_entry_locked(ppe, hash);
+		if (!hwe)
+			continue;
+
+		state = FIELD_GET(AIROHA_FOE_IB1_BIND_STATE, hwe->ib1);
+		if (state != AIROHA_FOE_STATE_BIND)
+			continue;
+
+		type = FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, hwe->ib1);
+		if (type != PPE_PKT_TYPE_IPV4_HNAPT &&
+		    type != PPE_PKT_TYPE_IPV4_ROUTE)
+			continue;
+
+		if (!(hwe->ipv4.data & AIROHA_FOE_TUNNEL))
+			continue;
+
+		if (FIELD_GET(AIROHA_FOE_ACTDP, hwe->ipv4.data) != sa_index)
+			continue;
+
+		/* NAT-T data and IKE control both use UDP/4500. A stale SOE
+		 * bound entry can otherwise keep sending later IKE_AUTH packets
+		 * to the SOE path after the SA has been deleted.
+		 */
+		hwe->ib1 &= ~AIROHA_FOE_IB1_BIND_STATE;
+		hwe->ib1 |= FIELD_PREP(AIROHA_FOE_IB1_BIND_STATE,
+				       AIROHA_FOE_STATE_INVALID);
+		airoha_ppe_foe_commit_entry(ppe, hwe, hash, false);
+	}
+	spin_unlock_bh(&ppe_lock);
+}
+
+static bool airoha_ppe_foe_try_flow_commit_bucket(struct airoha_ppe *ppe,
+						  struct airoha_foe_entry *hwe,
+						  u32 hash, u32 probe_index,
+						  bool rx_wlan,
+						  bool allow_l2_subflow)
+{
+	struct airoha_flow_table_entry *e;
+	struct hlist_node *n;
+	bool commit_done = false;
+	u32 state;
+
+	hlist_for_each_entry_safe(e, n, &ppe->foe_flow[probe_index], list) {
 		if (e->type == FLOW_TYPE_L2_SUBFLOW) {
+			if (!allow_l2_subflow)
+				continue;
+
 			state = FIELD_GET(AIROHA_FOE_IB1_BIND_STATE, hwe->ib1);
 			if (state != AIROHA_FOE_STATE_BIND) {
 				e->hash = 0xffff;
@@ -908,6 +1356,51 @@ static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
 		e->hash = hash;
 	}
 
+	return commit_done;
+}
+
+static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
+					struct sk_buff *skb,
+					u32 hash, bool rx_wlan)
+{
+	struct airoha_flow_table_entry *e;
+	struct airoha_foe_bridge br = {};
+	struct airoha_foe_entry *hwe;
+	bool commit_done = false;
+	u32 index, mask, state, window;
+	unsigned int i;
+
+	spin_lock_bh(&ppe_lock);
+
+	hwe = airoha_ppe_foe_get_entry_locked(ppe, hash);
+	if (!hwe)
+		goto unlock;
+
+	state = FIELD_GET(AIROHA_FOE_IB1_BIND_STATE, hwe->ib1);
+	if (state == AIROHA_FOE_STATE_BIND)
+		goto unlock;
+
+	index = airoha_ppe_foe_get_entry_hash(ppe, hwe);
+	commit_done =
+		airoha_ppe_foe_try_flow_commit_bucket(ppe, hwe, hash, index,
+						      rx_wlan, true);
+
+	mask = airoha_ppe_get_total_num_entries(ppe) - 1;
+	window = min_t(u32,
+		       READ_ONCE(airoha_ppe_soe_inline_force_commit_probe_window),
+		       mask);
+	for (i = 1; !commit_done && i <= window; i++) {
+		u32 candidates[2] = { (index + i) & mask, (index - i) & mask };
+		unsigned int j;
+
+		for (j = 0; !commit_done && j < ARRAY_SIZE(candidates); j++) {
+			commit_done =
+				airoha_ppe_foe_try_flow_commit_bucket(ppe, hwe,
+								      hash, candidates[j],
+								      rx_wlan, false);
+		}
+	}
+
 	if (commit_done)
 		goto unlock;
 
@@ -940,8 +1433,9 @@ airoha_ppe_foe_l2_flow_commit_entry(struct airoha_ppe *ppe,
 				       airoha_l2_flow_table_params);
 }
 
-static int airoha_ppe_foe_flow_commit_entry(struct airoha_ppe *ppe,
-					    struct airoha_flow_table_entry *e)
+static int
+airoha_ppe_foe_flow_commit_entry(struct airoha_ppe *ppe,
+				 struct airoha_flow_table_entry *e)
 {
 	int type = FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, e->data.ib1);
 	u32 hash;
@@ -1057,6 +1551,7 @@ static int airoha_ppe_entry_idle_time(struct airoha_ppe *ppe,
 static int airoha_ppe_flow_offload_replace(struct airoha_eth *eth,
 					   struct flow_cls_offload *f)
 {
+	const struct flow_offload_tuple *tuple = (const void *)f->cookie;
 	struct flow_rule *rule = flow_cls_offload_flow_rule(f);
 	struct airoha_flow_table_entry *e;
 	struct airoha_flow_data data = {};
@@ -1183,7 +1678,9 @@ static int airoha_ppe_flow_offload_replace(struct airoha_eth *eth,
 		flow_rule_match_ipv4_addrs(rule, &addrs);
 		data.v4.src_addr = addrs.key->src;
 		data.v4.dst_addr = addrs.key->dst;
-		airoha_ppe_foe_entry_set_ipv4_tuple(&hwe, &data, false);
+		err = airoha_ppe_foe_entry_set_ipv4_tuple(&hwe, &data, false);
+		if (err)
+			return err;
 	}
 
 	if (addr_type == FLOW_DISSECTOR_KEY_IPV6_ADDRS) {
@@ -1228,6 +1725,10 @@ static int airoha_ppe_flow_offload_replace(struct airoha_eth *eth,
 			return err;
 	}
 
+	err = airoha_ppe_foe_entry_set_soe_info(&hwe, tuple);
+	if (err)
+		return err;
+
 	e = kzalloc_obj(*e);
 	if (!e)
 		return -ENOMEM;
@@ -1350,16 +1851,26 @@ static int airoha_ppe_flow_offload_cmd(struct airoha_eth *eth,
 	return -EOPNOTSUPP;
 }
 
-static int airoha_ppe_flush_sram_entries(struct airoha_ppe *ppe)
+static int airoha_ppe_flush_entries(struct airoha_ppe *ppe)
 {
+	u32 ppe_num_entries = airoha_ppe_get_total_num_entries(ppe);
 	u32 sram_num_entries = airoha_ppe_get_total_sram_num_entries(ppe);
 	struct airoha_foe_entry *hwe = ppe->foe;
 	int i, err = 0;
 
+	memset(hwe, 0, ppe_num_entries * sizeof(*hwe));
+	if (ppe->foe_stats) {
+		u32 ppe_num_stats_entries =
+			airoha_ppe_get_total_num_stats_entries(ppe);
+
+		memset(ppe->foe_stats, 0,
+		       ppe_num_stats_entries * sizeof(*ppe->foe_stats));
+	}
+	dma_wmb();
+
 	for (i = 0; i < sram_num_entries; i++) {
 		int err;
 
-		memset(&hwe[i], 0, sizeof(*hwe));
 		err = airoha_ppe_foe_commit_sram_entry(ppe, i);
 		if (err)
 			break;
@@ -1368,6 +1879,37 @@ static int airoha_ppe_flush_sram_entries(struct airoha_ppe *ppe)
 	return err;
 }
 
+static int airoha_ppe_set_bind_rate(const char *val,
+				    const struct kernel_param *kp)
+{
+	struct airoha_ppe *ppe;
+	unsigned long rate;
+	int err, i;
+
+	err = kstrtoul(val, 0, &rate);
+	if (err)
+		return err;
+	if (rate > FIELD_MAX(PPE_BIND_RATE_BIND_MASK))
+		return -ERANGE;
+
+	WRITE_ONCE(airoha_ppe_bind_rate, (unsigned int)rate);
+
+	mutex_lock(&flow_offload_mutex);
+	ppe = READ_ONCE(airoha_ppe_active);
+	if (ppe) {
+		for (i = 0; i < ppe->eth->soc->num_ppe; i++)
+			airoha_ppe_apply_bind_rate(ppe->eth, i);
+	}
+	mutex_unlock(&flow_offload_mutex);
+
+	return 0;
+}
+
+static int airoha_ppe_get_bind_rate(char *buf, const struct kernel_param *kp)
+{
+	return sysfs_emit(buf, "%u\n", READ_ONCE(airoha_ppe_bind_rate));
+}
+
 static struct airoha_npu *airoha_ppe_npu_get(struct airoha_eth *eth)
 {
 	struct airoha_npu *npu = airoha_npu_get(eth->dev);
@@ -1601,12 +2143,20 @@ int airoha_ppe_init(struct airoha_eth *eth)
 			return -ENOMEM;
 	}
 
-	ppe->foe_check_time = devm_kzalloc(eth->dev, ppe_num_entries,
-					   GFP_KERNEL);
+	ppe->foe_check_time =
+		devm_kzalloc(eth->dev,
+			     ppe_num_entries * sizeof(*ppe->foe_check_time),
+			     GFP_KERNEL);
 	if (!ppe->foe_check_time)
 		return -ENOMEM;
 
-	err = airoha_ppe_flush_sram_entries(ppe);
+	ppe->soe_meta = devm_kzalloc(eth->dev,
+				     ppe_num_entries * sizeof(*ppe->soe_meta),
+				     GFP_KERNEL);
+	if (!ppe->soe_meta)
+		return -ENOMEM;
+
+	err = airoha_ppe_flush_entries(ppe);
 	if (err)
 		return err;
 
@@ -1622,6 +2172,8 @@ int airoha_ppe_init(struct airoha_eth *eth)
 	if (err)
 		goto error_l2_flow_table_destroy;
 
+	WRITE_ONCE(airoha_ppe_active, ppe);
+
 	return 0;
 
 error_l2_flow_table_destroy:
@@ -1636,6 +2188,8 @@ void airoha_ppe_deinit(struct airoha_eth *eth)
 {
 	struct airoha_npu *npu;
 
+	WRITE_ONCE(airoha_ppe_active, NULL);
+
 	mutex_lock(&flow_offload_mutex);
 
 	npu = rcu_replace_pointer(eth->npu, NULL,
diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
index 7589fccfeef6..120dbd274c89 100644
--- a/include/linux/soc/airoha/airoha_offload.h
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -11,7 +11,12 @@
 #include <linux/workqueue.h>
 
 enum {
+	PPE_CPU_REASON_UN_HIT = 0x0d,
+	PPE_CPU_REASON_HIT_UNBIND = 0x0e,
 	PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED = 0x0f,
+	PPE_CPU_REASON_HIT_BIND_FORCE_CPU = 0x16,
+	PPE_CPU_REASON_HIT_BIND_EXCEED_MTU = 0x1c,
+	PPE_CPU_REASON_NOT_THROUGH_PPE = 0x1e,
 };
 
 struct airoha_ppe_dev {
-- 
2.53.0

