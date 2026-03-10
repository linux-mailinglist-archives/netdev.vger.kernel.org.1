Return-Path: <netdev+bounces-266222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDMqNDg7sGmDhQIAu9opvQ
	(envelope-from <netdev+bounces-266222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:39:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E17C253BF7
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CA1C30489B5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2FD3A380D;
	Tue, 10 Mar 2026 15:37:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607C38AC82
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157045; cv=none; b=KUnRnUN4J4E0b6/IHqbYxrkMEs+0x37tHl5NfM3+EepLZ5kcEixtjkLk3t4ViqpZGUMmEohKLB79DDmIDje5uls1JHwOcS5Tf71inBpvErs+egG/ur9wXKG8wSV7LNAPkcVL93s6eOrBfQHd3oU8Cl3zjxu0WKDdy8iG7VoL7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157045; c=relaxed/simple;
	bh=cfVUkAr1lDXzHwI9wTVQnCRsgIeV0hRZthIgVnHuWp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PajlkHAxp7sNftDESiLVbYe6tasZaGKqZ2yLKVa9+KIr8LBt20nMtp47CjbMdXC4Xe1JhVVO85wS/kTruXKQeJTTbEIPbgCW6uq2dskrVjRVrPd8j0skLvTS81doCMkSK61FlNb6iyogFzqaFChXT5GnTDCA5eXmluhQIacfIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1241C4D284;
	Tue, 10 Mar 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6190B3F519;
	Tue, 10 Mar 2026 15:37:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mJmHFKY6sGlKXwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 10 Mar 2026 15:37:10 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: rbm@suse.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/10 net-next v2] ipv6: remove dynamic ICMPv6 sender registration infrastructure
Date: Tue, 10 Mar 2026 16:34:26 +0100
Message-ID: <20260310153506.5181-4-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310153506.5181-1-fmancera@suse.de>
References: <20260310153506.5181-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6E17C253BF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266222-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:mid,suse.de:email]
X-Rspamd-Action: no action

As IPv6 is built-in only, there is no need to maintain the sender
registration infrastructure used to allow built-in subsystems to send
ICMPv6 messages when IPv6 was compiled as a module.

Drop the registration mechanism and the __icmpv6_send() sender
implementation. While icmpv6_send() users could be converted to
icmp6_send() that doesn't seems necessary as none of them are using the
force_saddr parameter.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: no changes
---
 include/linux/icmpv6.h | 26 ++----------------------
 net/ipv6/icmp.c        |  6 ------
 net/ipv6/ip6_icmp.c    | 46 +++---------------------------------------
 3 files changed, 5 insertions(+), 73 deletions(-)

diff --git a/include/linux/icmpv6.h b/include/linux/icmpv6.h
index e3b3b0fa2a8f..bb000dc571f0 100644
--- a/include/linux/icmpv6.h
+++ b/include/linux/icmpv6.h
@@ -21,32 +21,10 @@ typedef void ip6_icmp_send_t(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		const struct in6_addr *force_saddr,
 		const struct inet6_skb_parm *parm);
-#if IS_BUILTIN(CONFIG_IPV6)
-static inline void __icmpv6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
-				 const struct inet6_skb_parm *parm)
-{
-	icmp6_send(skb, type, code, info, NULL, parm);
-}
-static inline int inet6_register_icmp_sender(ip6_icmp_send_t *fn)
-{
-	BUILD_BUG_ON(fn != icmp6_send);
-	return 0;
-}
-static inline int inet6_unregister_icmp_sender(ip6_icmp_send_t *fn)
-{
-	BUILD_BUG_ON(fn != icmp6_send);
-	return 0;
-}
-#else
-extern void __icmpv6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
-			  const struct inet6_skb_parm *parm);
-extern int inet6_register_icmp_sender(ip6_icmp_send_t *fn);
-extern int inet6_unregister_icmp_sender(ip6_icmp_send_t *fn);
-#endif
 
 static inline void icmpv6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info)
 {
-	__icmpv6_send(skb, type, code, info, IP6CB(skb));
+	icmp6_send(skb, type, code, info, NULL, IP6CB(skb));
 }
 
 int ip6_err_gen_icmpv6_unreach(struct sk_buff *skb, int nhs, int type,
@@ -58,7 +36,7 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info);
 static inline void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 {
 	struct inet6_skb_parm parm = { 0 };
-	__icmpv6_send(skb_in, type, code, info, &parm);
+	icmp6_send(skb_in, type, code, info, NULL, &parm);
 }
 #endif
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 813d2e9edb8b..8e8d7bd84a4c 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -1288,13 +1288,8 @@ int __init icmpv6_init(void)
 	if (inet6_add_protocol(&icmpv6_protocol, IPPROTO_ICMPV6) < 0)
 		goto fail;
 
-	err = inet6_register_icmp_sender(icmp6_send);
-	if (err)
-		goto sender_reg_err;
 	return 0;
 
-sender_reg_err:
-	inet6_del_protocol(&icmpv6_protocol, IPPROTO_ICMPV6);
 fail:
 	pr_err("Failed to register ICMP6 protocol\n");
 	return err;
@@ -1302,7 +1297,6 @@ int __init icmpv6_init(void)
 
 void icmpv6_cleanup(void)
 {
-	inet6_unregister_icmp_sender(icmp6_send);
 	inet6_del_protocol(&icmpv6_protocol, IPPROTO_ICMPV6);
 }
 
diff --git a/net/ipv6/ip6_icmp.c b/net/ipv6/ip6_icmp.c
index 233914b63bdb..e43ea9492332 100644
--- a/net/ipv6/ip6_icmp.c
+++ b/net/ipv6/ip6_icmp.c
@@ -7,47 +7,8 @@
 
 #include <net/ipv6.h>
 
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_IPV6) && IS_ENABLED(CONFIG_NF_NAT)
 
-#if !IS_BUILTIN(CONFIG_IPV6)
-
-static ip6_icmp_send_t __rcu *ip6_icmp_send;
-
-int inet6_register_icmp_sender(ip6_icmp_send_t *fn)
-{
-	return (cmpxchg((ip6_icmp_send_t **)&ip6_icmp_send, NULL, fn) == NULL) ?
-		0 : -EBUSY;
-}
-EXPORT_SYMBOL(inet6_register_icmp_sender);
-
-int inet6_unregister_icmp_sender(ip6_icmp_send_t *fn)
-{
-	int ret;
-
-	ret = (cmpxchg((ip6_icmp_send_t **)&ip6_icmp_send, fn, NULL) == fn) ?
-	      0 : -EINVAL;
-
-	synchronize_net();
-
-	return ret;
-}
-EXPORT_SYMBOL(inet6_unregister_icmp_sender);
-
-void __icmpv6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
-		   const struct inet6_skb_parm *parm)
-{
-	ip6_icmp_send_t *send;
-
-	rcu_read_lock();
-	send = rcu_dereference(ip6_icmp_send);
-	if (send)
-		send(skb, type, code, info, NULL, parm);
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL(__icmpv6_send);
-#endif
-
-#if IS_ENABLED(CONFIG_NF_NAT)
 #include <net/netfilter/nf_conntrack.h>
 void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 {
@@ -60,7 +21,7 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 
 	ct = nf_ct_get(skb_in, &ctinfo);
 	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
-		__icmpv6_send(skb_in, type, code, info, &parm);
+		icmp6_send(skb_in, type, code, info, NULL, &parm);
 		return;
 	}
 
@@ -76,11 +37,10 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 	orig_ip = ipv6_hdr(skb_in)->saddr;
 	dir = CTINFO2DIR(ctinfo);
 	ipv6_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.in6;
-	__icmpv6_send(skb_in, type, code, info, &parm);
+	icmp6_send(skb_in, type, code, info, NULL, &parm);
 	ipv6_hdr(skb_in)->saddr = orig_ip;
 out:
 	consume_skb(cloned_skb);
 }
 EXPORT_SYMBOL(icmpv6_ndo_send);
 #endif
-#endif
-- 
2.53.0


