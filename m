Return-Path: <netdev+bounces-279379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePdeHYVr4mkf5wAAu9opvQ
	(envelope-from <netdev+bounces-279379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:19:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D069941D73D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CD1D3085EBD
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3327A3A1A42;
	Fri, 17 Apr 2026 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FfCHPmpQ"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262E4397680
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776446335; cv=none; b=kkQtQ00l5sfNyqnJGWF5z9ZvwScLFeUKQZT69jge3pW8j1p5kO9ubPJJ28QNHstJZL65/9IkVHoagbGc9MDOGmsR4CAuNeR4nUc18Z/1G1+Pr/tgRayl9N2e434UvraMZD2bp7Taw8mIDnxgxQ6XQZwthGZR3ZE6DNq7dgrYivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776446335; c=relaxed/simple;
	bh=z8u6t67rEtqOmMgDkP0y+Xtdn2TUCsW6a2uvyzmdBxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fH39QMbgSgrxDfH+paz+R33GW3Bhob+ls527+SvzYfK8d2ztbVN8GITb6tlnHF0hSZy0CyP3wJzpnvJjG9p+2okStcKBYe+SD5qtXrHPk3DFRevIZ7Zrw1zeN+RzPglRjG49SWhKezDD6cdlUPSbAWbQDMnjQzBXZiCKmLDyawA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=FfCHPmpQ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=4Eu/Nmy9RBp394Fay93CwfFWHMTG9W++HwH4+v2qyo0=; b=FfCHPmpQSvWkvspEUw6Iy5jKZc
	Ylmnth5FmXZIaWad0DvLKoDC9zsb3qTTNKArnXE/D5JXcCypU71wdDuOiNkM/n1LY4Hzy2fKwVxk1
	zQdzcv+OUj4TqW0IN9Wrh3r3+WuM+7M5bqDCreAdt0/Ofhm4Xl6Zi1dA66dGIqF0rMuUVACp23Yld
	LW++i9DiZ3Ww42i9tZSizejzhcMqArjrxzP6krhr8HkAeksy+AT4eiL3gnkQbipDeNSQWN/u1o4Uj
	/zMS3e/sBvN/vKA1+9uEEud3MEf0AI80kksK8j2yLLiyHo6lD+R+HbDjhqbOHM7bXeh2r/UT4rTcD
	/FOWqhqg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wDmps-000Oa5-0q;
	Fri, 17 Apr 2026 19:18:32 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: edumazet@google.com,
	dsahern@kernel.org,
	tom@herbertland.com,
	willemdebruijn.kernel@gmail.com,
	idosch@nvidia.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH net] ipv6: Implement limits on extension header parsing
Date: Fri, 17 Apr 2026 19:18:31 +0200
Message-ID: <20260417171831.687053-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27974/Fri Apr 17 08:24:08 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279379-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:email,iogearbox.net:dkim,iogearbox.net:mid]
X-Rspamd-Queue-Id: D069941D73D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipv6_{skip_exthdr,find_hdr}() and ip6_tnl_parse_tlv_enc_lim() iterate
over IPv6 extension headers until they find a non-extension-header
protocol or run out of packet data. The loops have no iteration counter,
relying solely on the packet length to bound them. For a crafted packet
with 8-byte extension headers filling a 64KB jumbogram, this means a
worst case of up to ~8k iterations with a skb_header_pointer call each.
ipv6_skip_exthdr(), for example, is used where it parses the inner
quoted packet inside an incoming ICMPv6 error:

  - icmpv6_rcv
    - checksum validation
    - case ICMPV6_DEST_UNREACH
      - icmpv6_notify
        - pskb_may_pull()       <- pull inner IPv6 header
        - ipv6_skip_exthdr()    <- iterates here
        - pskb_may_pull()
        - ipprot->err_handler() <- sk lookup (matching sk not required)

The per-iteration cost of ipv6_skip_exthdr itself is generally light,
but skb_header_pointer becomes more costly on reassembled packets: the
first ~1KB of the inner packet are in the skb's linear area, but the
remaining ~63KB are in the frag_list where skb_copy_bits is needed to
read data.

Add a configurable limit via a new sysctl net.ipv6.max_ext_hdrs_number
(default 32, minimum 1). All three extension header walking functions
are bound by this limit. The sysctl is in line with commit 47d3d7ac656a
("ipv6: Implement limits on Hop-by-Hop and Destination options"). The
init_net is used since plumbing a struct net * through all helpers
would touch a lot of callsites.

There's an ongoing IETF draft-ietf-6man-eh-limits-18 that states that
8 extension headers before the transport header is the baseline which
routers MUST handle; section 7 details also why limits are needed.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 Documentation/networking/ip-sysctl.rst |  7 +++++++
 include/net/ipv6.h                     |  2 ++
 include/net/netns/ipv6.h               |  1 +
 net/ipv6/af_inet6.c                    |  1 +
 net/ipv6/exthdrs_core.c                | 11 +++++++++++
 net/ipv6/ip6_tunnel.c                  |  5 +++++
 net/ipv6/sysctl_net_ipv6.c             |  8 ++++++++
 7 files changed, 35 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 6921d8594b84..4559a956bbd9 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2503,6 +2503,13 @@ max_hbh_length - INTEGER
 
 	Default: INT_MAX (unlimited)
 
+max_ext_hdrs_number - INTEGER
+	Maximum number of IPv6 extension headers allowed in a packet.
+	Limits how many extension headers will be traversed. The value
+	is read from the initial netns.
+
+	Default: 32
+
 skip_notify_on_dev_down - BOOLEAN
 	Controls whether an RTM_DELROUTE message is generated for routes
 	removed when a device is taken down or deleted. IPv4 does not
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 53c5056508be..d7f0d55e6918 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -90,6 +90,8 @@ struct ip_tunnel_info;
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
 
+#define IP6_DEFAULT_MAX_EXT_HDRS_CNT	 32
+
 /*
  *	Addr type
  *	
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 34bdb1308e8f..5be4dd1c9ae8 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -54,6 +54,7 @@ struct netns_sysctl_ipv6 {
 	int max_hbh_opts_cnt;
 	int max_dst_opts_len;
 	int max_hbh_opts_len;
+	int max_ext_hdrs_cnt;
 	int seg6_flowlabel;
 	u32 ioam6_id;
 	u64 ioam6_id_wide;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 4cbd45b68088..ed7fe6e4a6bd 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -965,6 +965,7 @@ static int __net_init inet6_net_init(struct net *net)
 	net->ipv6.sysctl.flowlabel_state_ranges = 0;
 	net->ipv6.sysctl.max_dst_opts_cnt = IP6_DEFAULT_MAX_DST_OPTS_CNT;
 	net->ipv6.sysctl.max_hbh_opts_cnt = IP6_DEFAULT_MAX_HBH_OPTS_CNT;
+	net->ipv6.sysctl.max_ext_hdrs_cnt = IP6_DEFAULT_MAX_EXT_HDRS_CNT;
 	net->ipv6.sysctl.max_dst_opts_len = IP6_DEFAULT_MAX_DST_OPTS_LEN;
 	net->ipv6.sysctl.max_hbh_opts_len = IP6_DEFAULT_MAX_HBH_OPTS_LEN;
 	net->ipv6.sysctl.fib_notify_on_flag_change = 0;
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 49e31e4ae7b7..917307877cbb 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -4,6 +4,8 @@
  * not configured or static.
  */
 #include <linux/export.h>
+
+#include <net/net_namespace.h>
 #include <net/ipv6.h>
 
 /*
@@ -72,7 +74,9 @@ EXPORT_SYMBOL(ipv6_ext_hdr);
 int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 		     __be16 *frag_offp)
 {
+	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
 	u8 nexthdr = *nexthdrp;
+	int exthdr_cnt = 0;
 
 	*frag_offp = 0;
 
@@ -80,6 +84,8 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 		struct ipv6_opt_hdr _hdr, *hp;
 		int hdrlen;
 
+		if (unlikely(exthdr_cnt++ >= exthdr_max))
+			return -1;
 		if (nexthdr == NEXTHDR_NONE)
 			return -1;
 		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
@@ -188,8 +194,10 @@ EXPORT_SYMBOL_GPL(ipv6_find_tlv);
 int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 		  int target, unsigned short *fragoff, int *flags)
 {
+	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
 	unsigned int start = skb_network_offset(skb) + sizeof(struct ipv6hdr);
 	u8 nexthdr = ipv6_hdr(skb)->nexthdr;
+	int exthdr_cnt = 0;
 	bool found;
 
 	if (fragoff)
@@ -216,6 +224,9 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 			return -ENOENT;
 		}
 
+		if (unlikely(exthdr_cnt++ >= exthdr_max))
+			return -EBADMSG;
+
 		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
 		if (!hp)
 			return -EBADMSG;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 0b53488a9229..78e849e167ca 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -396,15 +396,20 @@ ip6_tnl_dev_uninit(struct net_device *dev)
 
 __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
 {
+	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
 	const struct ipv6hdr *ipv6h = (const struct ipv6hdr *)raw;
 	unsigned int nhoff = raw - skb->data;
 	unsigned int off = nhoff + sizeof(*ipv6h);
 	u8 nexthdr = ipv6h->nexthdr;
+	int exthdr_cnt = 0;
 
 	while (ipv6_ext_hdr(nexthdr) && nexthdr != NEXTHDR_NONE) {
 		struct ipv6_opt_hdr *hdr;
 		u16 optlen;
 
+		if (unlikely(exthdr_cnt++ >= exthdr_max))
+			break;
+
 		if (!pskb_may_pull(skb, off + sizeof(*hdr)))
 			break;
 
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index d2cd33e2698d..93f865545a7c 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -135,6 +135,14 @@ static struct ctl_table ipv6_table_template[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &flowlabel_reflect_max,
 	},
+	{
+		.procname	= "max_ext_hdrs_number",
+		.data		= &init_net.ipv6.sysctl.max_ext_hdrs_cnt,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+	},
 	{
 		.procname	= "max_dst_opts_number",
 		.data		= &init_net.ipv6.sysctl.max_dst_opts_cnt,
-- 
2.43.0


