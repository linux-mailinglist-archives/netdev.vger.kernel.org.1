Return-Path: <netdev+bounces-270028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IERPAYGZvWmR/QIAu9opvQ
	(envelope-from <netdev+bounces-270028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:01:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1162DFA68
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 163443164DB7
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68433EDAD8;
	Fri, 20 Mar 2026 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oiEFukwl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l9fd5Tmz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oiEFukwl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l9fd5Tmz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0D3E8664
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033090; cv=none; b=VjYw81gwzZeBNc1+RlWRNZKmCJXdmYjS/1ku47E3H+eq4eLCu0UgT3RN9+TaRy+Pz2yQbAFVVQnPk08o5mUpxAiDXstuzHsNco9ZZVndqsuGiNDJ7ZvBn7IuxVhXDhljOaW0wZST6HnUD0bke2ZeIkHBA+Kv9DgjzYl4UpzdiHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033090; c=relaxed/simple;
	bh=WY8ODosNSGmnKvuWeEk8e8/wT8q1KDpglJ/ZCg5Gmk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bb2VFj2gujpqvu6fa9OOLEI3iZ4s6VuphmWCkQWI2zIh8hnuENp5yGHH51KTrzyZgVCHwa/F6cDQGZ6qPy80CUIwzLAsj/5pf0QEThRojtP9UKDiJqwm2/Gf8yftJQMgLGuMppI6KY+tX+Wj/JSk0qquY0wzdj4ecgW3QYeKUaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oiEFukwl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l9fd5Tmz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oiEFukwl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l9fd5Tmz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DA0B4D2BD;
	Fri, 20 Mar 2026 18:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774033087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhXYanpKhRbc7Csv2V+KDVPMYJAOfZD9uLLzEdpB6ZE=;
	b=oiEFukwl9gh2dawoOEx3L5VHJIS7qoqlL+sJ2HrW468xrarvVW7JOloqOXXhGjfJItYf/m
	zGnEMi7mVm9aus6ipBKh7qycdGVF1ZUPQyVIw3mkrANAaMwmsutwKxpu6wxkfLmo+IcArB
	sGZdydCAhYWoQ9RCfcrCFDIFNW7dQts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774033087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhXYanpKhRbc7Csv2V+KDVPMYJAOfZD9uLLzEdpB6ZE=;
	b=l9fd5TmzR5ss39oSff3mJjKIrpO2TvK5Lv8Oi8OBGwI4w3RQoOjkzcO5r7FpdGI1Zm4NFz
	TF2kwK2+nkrlrZBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774033087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhXYanpKhRbc7Csv2V+KDVPMYJAOfZD9uLLzEdpB6ZE=;
	b=oiEFukwl9gh2dawoOEx3L5VHJIS7qoqlL+sJ2HrW468xrarvVW7JOloqOXXhGjfJItYf/m
	zGnEMi7mVm9aus6ipBKh7qycdGVF1ZUPQyVIw3mkrANAaMwmsutwKxpu6wxkfLmo+IcArB
	sGZdydCAhYWoQ9RCfcrCFDIFNW7dQts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774033087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhXYanpKhRbc7Csv2V+KDVPMYJAOfZD9uLLzEdpB6ZE=;
	b=l9fd5TmzR5ss39oSff3mJjKIrpO2TvK5Lv8Oi8OBGwI4w3RQoOjkzcO5r7FpdGI1Zm4NFz
	TF2kwK2+nkrlrZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA4C742953;
	Fri, 20 Mar 2026 18:58:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aGQiKr6YvWnyTgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 20 Mar 2026 18:58:06 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11 net-next v4] ipv6: prepare headers for ipv6_stub removal
Date: Fri, 20 Mar 2026 19:55:57 +0100
Message-ID: <20260320185649.5411-6-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320185649.5411-1-fmancera@suse.de>
References: <20260320185649.5411-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -7.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270028-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5E1162DFA68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation for dropping ipv6_stub and converting its users to direct
function calls, introduce static inline dummy functions and fallback
macros in the IPv6 networking headers. In addition, introduce checks on
fib6_nh_init(), ip6_dst_lookup_flow() and ip6_fragment() to avoid a
crash due to ipv6.disable=1 set during booting. The other functions are
safe as they cannot be called with ipv6.disable=1 set.

These fallbacks ensure that when CONFIG_IPV6 is completely disabled,
there are no compiling or linking errors due to code paths not guarded
by preprocessor macro IS_ENABLED(CONFIG_IPV6).

In addition, export ndisc_send_na(), ip6_route_input() and
ip6_fragment().

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Tested-by: Ricardo B. Marlière <rbm@suse.com>
---
 include/net/ip6_fib.h   | 32 ++++++++++++++++++++++++++++++++
 include/net/ip6_route.h | 26 ++++++++++++++++++++++++++
 include/net/ipv6.h      | 10 ++++++++++
 include/net/ndisc.h     | 15 +++++++++++++--
 net/ipv6/ip6_output.c   |  5 +++++
 net/ipv6/ndisc.c        |  1 +
 net/ipv6/route.c        |  6 ++++++
 7 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 39c98c3d8ac5..f01ef8ffe296 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -486,11 +486,30 @@ void rt6_get_prefsrc(const struct rt6_info *rt, struct in6_addr *addr)
 	rcu_read_unlock();
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 		 struct fib6_config *cfg, gfp_t gfp_flags,
 		 struct netlink_ext_ack *extack);
 void fib6_nh_release(struct fib6_nh *fib6_nh);
 void fib6_nh_release_dsts(struct fib6_nh *fib6_nh);
+#else
+static inline int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
+			       struct fib6_config *cfg, gfp_t gfp_flags,
+			       struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG(extack, "IPv6 support not enabled in kernel");
+	return -EAFNOSUPPORT;
+}
+
+static inline void fib6_nh_release(struct fib6_nh *fib6_nh)
+{
+}
+
+static inline void fib6_nh_release_dsts(struct fib6_nh *fib6_nh)
+{
+}
+#endif
+
 
 int call_fib6_entry_notifiers(struct net *net,
 			      enum fib_event_type event_type,
@@ -502,8 +521,15 @@ int call_fib6_multipath_entry_notifiers(struct net *net,
 					unsigned int nsiblings,
 					struct netlink_ext_ack *extack);
 int call_fib6_entry_notifiers_replace(struct net *net, struct fib6_info *rt);
+#if IS_ENABLED(CONFIG_IPV6)
 void fib6_rt_update(struct net *net, struct fib6_info *rt,
 		    struct nl_info *info);
+#else
+static inline void fib6_rt_update(struct net *net, struct fib6_info *rt,
+				  struct nl_info *info)
+{
+}
+#endif
 void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		     unsigned int flags);
 
@@ -569,7 +595,13 @@ int fib6_tables_dump(struct net *net, struct notifier_block *nb,
 		     struct netlink_ext_ack *extack);
 
 void fib6_update_sernum(struct net *net, struct fib6_info *rt);
+#if IS_ENABLED(CONFIG_IPV6)
 void fib6_update_sernum_upto_root(struct net *net, struct fib6_info *rt);
+#else
+static inline void fib6_update_sernum_upto_root(struct net *net, struct fib6_info *rt)
+{
+}
+#endif
 void fib6_update_sernum_stub(struct net *net, struct fib6_info *f6i);
 
 void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val);
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 0c8eeb6abe7a..09ffe0f13ce7 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -77,7 +77,14 @@ static inline bool rt6_qualify_for_ecmp(const struct fib6_info *f6i)
 		f6i->fib6_nh->fib_nh_gw_family;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 void ip6_route_input(struct sk_buff *skb);
+#else
+static inline void ip6_route_input(struct sk_buff *skb)
+{
+}
+#endif
+
 struct dst_entry *ip6_route_input_lookup(struct net *net,
 					 struct net_device *dev,
 					 struct flowi6 *fl6,
@@ -119,7 +126,15 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd,
 int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
 		  struct netlink_ext_ack *extack);
 int ip6_ins_rt(struct net *net, struct fib6_info *f6i);
+#if IS_ENABLED(CONFIG_IPV6)
 int ip6_del_rt(struct net *net, struct fib6_info *f6i, bool skip_notify);
+#else
+static inline int ip6_del_rt(struct net *net, struct fib6_info *f6i,
+			     bool skip_notify)
+{
+	return -EAFNOSUPPORT;
+}
+#endif
 
 void rt6_flush_exceptions(struct fib6_info *f6i);
 void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
@@ -270,8 +285,19 @@ static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
 	return __ipv6_anycast_destination(&rt->rt6i_dst, rt->rt6i_flags, daddr);
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 int (*output)(struct net *, struct sock *, struct sk_buff *));
+#else
+static inline int ip6_fragment(struct net *net, struct sock *sk,
+			       struct sk_buff *skb,
+			       int (*output)(struct net *, struct sock *,
+					     struct sk_buff *))
+{
+	kfree_skb(skb);
+	return -EAFNOSUPPORT;
+}
+#endif
 
 /* Variant of dst_mtu() for IPv6 users */
 static inline u32 dst6_mtu(const struct dst_entry *dst)
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 0958cc5c6ec3..f99f273341f0 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1044,8 +1044,18 @@ static inline struct sk_buff *ip6_finish_skb(struct sock *sk)
 
 int ip6_dst_lookup(struct net *net, struct sock *sk, struct dst_entry **dst,
 		   struct flowi6 *fl6);
+#if IS_ENABLED(CONFIG_IPV6)
 struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk, struct flowi6 *fl6,
 				      const struct in6_addr *final_dst);
+#else
+static inline struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk,
+						    struct flowi6 *fl6,
+						    const struct in6_addr *final_dst)
+{
+	return ERR_PTR(-EAFNOSUPPORT);
+}
+#endif
+
 struct dst_entry *ip6_sk_dst_lookup_flow(struct sock *sk, struct flowi6 *fl6,
 					 const struct in6_addr *final_dst,
 					 bool connected);
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index d38783a2ce57..705e9389b9f2 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -69,6 +69,12 @@ struct prefix_info;
 
 extern struct neigh_table nd_tbl;
 
+#if IS_ENABLED(CONFIG_IPV6)
+#define ipv6_get_nd_tbl() (&nd_tbl)
+#else
+#define ipv6_get_nd_tbl() NULL
+#endif
+
 struct nd_msg {
         struct icmp6hdr	icmph;
         struct in6_addr	target;
@@ -356,7 +362,8 @@ static inline u32 ndisc_hashfn(const void *pkey, const struct net_device *dev, _
 
 static inline struct neighbour *__ipv6_neigh_lookup_noref(struct net_device *dev, const void *pkey)
 {
-	return ___neigh_lookup_noref(&nd_tbl, neigh_key_eq128, ndisc_hashfn, pkey, dev);
+	return ___neigh_lookup_noref(ipv6_get_nd_tbl(), neigh_key_eq128,
+				     ndisc_hashfn, pkey, dev);
 }
 
 static inline
@@ -406,13 +413,17 @@ static inline void __ipv6_confirm_neigh_stub(struct net_device *dev,
 static inline struct neighbour *ip_neigh_gw6(struct net_device *dev,
 					     const void *addr)
 {
+#if IS_ENABLED(CONFIG_IPV6)
 	struct neighbour *neigh;
 
 	neigh = __ipv6_neigh_lookup_noref_stub(dev, addr);
 	if (unlikely(!neigh))
-		neigh = __neigh_create(ipv6_stub->nd_tbl, addr, dev, false);
+		neigh = __neigh_create(&nd_tbl, addr, dev, false);
 
 	return neigh;
+#else
+	return ERR_PTR(-EAFNOSUPPORT);
+#endif
 }
 
 int ndisc_init(void);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8e2a6b28cea7..79f7ee93ceff 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -873,6 +873,8 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	__be32 frag_id;
 	u8 *prevhdr, nexthdr = 0;
 
+	if (!ipv6_mod_enabled())
+		return -EAFNOSUPPORT;
 	err = ip6_find_1stfragopt(skb, &prevhdr);
 	if (err < 0)
 		goto fail;
@@ -1045,6 +1047,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	kfree_skb(skb);
 	return err;
 }
+EXPORT_SYMBOL_GPL(ip6_fragment);
 
 static inline int ip6_rt_check(const struct rt6key *rt_key,
 			       const struct in6_addr *fl_addr,
@@ -1256,6 +1259,8 @@ struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk, st
 	struct dst_entry *dst = NULL;
 	int err;
 
+	if (!ipv6_mod_enabled())
+		return ERR_PTR(-EAFNOSUPPORT);
 	err = ip6_dst_lookup_tail(net, sk, &dst, fl6);
 	if (err)
 		return ERR_PTR(err);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f6a5d8c73af9..f76fb8a85452 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -576,6 +576,7 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 
 	ndisc_send_skb(skb, daddr, src_addr);
 }
+EXPORT_SYMBOL_GPL(ndisc_send_na);
 
 static void ndisc_send_unsol_na(struct net_device *dev)
 {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index c442ac275f58..ba60461db3d5 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2655,6 +2655,7 @@ void ip6_route_input(struct sk_buff *skb)
 	skb_dst_set_noref(skb, ip6_route_input_lookup(net, skb->dev,
 						      &fl6, skb, flags));
 }
+EXPORT_SYMBOL_GPL(ip6_route_input);
 
 INDIRECT_CALLABLE_SCOPE struct rt6_info *ip6_pol_route_output(struct net *net,
 					     struct fib6_table *table,
@@ -3585,6 +3586,11 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 	struct inet6_dev *idev = NULL;
 	int err;
 
+	if (!ipv6_mod_enabled()) {
+		NL_SET_ERR_MSG(extack, "IPv6 support not enabled in kernel");
+		return -EAFNOSUPPORT;
+	}
+
 	fib6_nh->fib_nh_family = AF_INET6;
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	fib6_nh->last_probe = jiffies;
-- 
2.53.0


