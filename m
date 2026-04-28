Return-Path: <netdev+bounces-281958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK9CH3TU8GkpZgEAu9opvQ
	(envelope-from <netdev+bounces-281958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:38:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDD048809F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6695F3022412
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25392125AA;
	Tue, 28 Apr 2026 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="b5/f7dHU"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F293C3BE2
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390683; cv=none; b=uZ6uOKHhPbXJ04bVDe3UAmzift40zpnkOLoTPudftRKRAM/NJotss2VyFmnEbERyORlx5M9dTIrnjawwtSScohg5gacsA4ss/d4GMrUSk05uQw6rlO7S4/xtqDzEOVMVYDeAv3S8S9NU1IAjXjd7wo/ZS2VGdCKpR2jSvQdcW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390683; c=relaxed/simple;
	bh=KA/SYBplOGUSTjvbTzGzSsatvTD7x3/rP8lEgKVeWC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=us7EOPdXyL+1K6s0zu0dWFUzP8V7XWkknMQjDW9p4zBDxBtqoDWZNl1RgWMbvOzolir5dT9tAzIW/5ErryXg9nTrCrtLxrw9qR8ZJT2yB4s5sK2PJ9SEcwu16dM1CiOZAY69zH4YIxGqKoS7dN37N9b+HYacGCObi2e+kXxWq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=b5/f7dHU; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=FlAGa1ipzYsLxChvlNDwFhihngRccXPBj5bCbC+Zqgs=; b=b5/f7dHUT2zirxiby8gW9GSp2H
	T+gi3qBW90gzsnRVzn1kF/51aA0BbADAEnQxJZZYFSzbdVvejtIYgkto0gjxdDyq9PtnMlYvEopqQ
	WKRKxJ0uK2Ypo9A79Mz98+uuSxQWHwTCZs40nL98NENwvbunr7XSoLVj6/+DJHN4mrUCdjEui4JY2
	bCpvnRDQX2lpXLgT2/URjcePp4BR0NfLM8mg3IAAvmbVatdv2VLb3bRuqngA3wSeodKphuJvMShsF
	9Ni49OMh409zYTIMv6CT53HjQzlAi0R6QFsjvgUt5wR3U5/QhmidjfTRvBdNn2c+mkrHhoS+c7gyr
	13y1zXhQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wHkVS-00062b-2S;
	Tue, 28 Apr 2026 17:37:50 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: edumazet@google.com,
	dsahern@kernel.org,
	tom@herbertland.com,
	willemdebruijn.kernel@gmail.com,
	idosch@nvidia.com,
	pabeni@redhat.com,
	justin.iurman@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net v4] ipv6: Implement limits on extension header parsing
Date: Tue, 28 Apr 2026 17:37:49 +0200
Message-ID: <20260428153749.785611-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27985/Tue Apr 28 08:25:02 2026)
X-Rspamd-Queue-Id: 2DDD048809F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281958-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iogearbox.net:email,iogearbox.net:dkim,iogearbox.net:mid]

ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
protocol_deliver_rcu}() iterate over IPv6 extension headers until they
find a non-extension-header protocol or run out of packet data. The
loops have no iteration counter, relying solely on the packet length
to bound them. For a crafted packet with 8-byte extension headers
filling a 64KB jumbogram, this means a worst case of up to ~8k
iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
for example, is used where it parses the inner quoted packet inside
an incoming ICMPv6 error:

  - icmpv6_rcv
    - checksum validation
    - case ICMPV6_DEST_UNREACH
      - icmpv6_notify
        - pskb_may_pull()       <- pull inner IPv6 header
        - ipv6_skip_exthdr()    <- iterates here
        - pskb_may_pull()
        - ipprot->err_handler() <- sk lookup

The per-iteration cost of ipv6_skip_exthdr itself is generally
light, but skb_header_pointer becomes more costly on reassembled
packets: the first ~1232 bytes of the inner packet are in the skb's
linear area, but the remaining ~63KB are in the frag_list where
skb_copy_bits is needed to read data.

Initially, the idea was to add a configurable limit via a new
sysctl knob with default 8, in line with knobs from commit
47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and Destination
options"), but two reasons eventually argued against it:

- It adds to UAPI that needs to be maintained forever, and
  upcoming work is restricting extension header ordering anyway,
  leaving little reason for another sysctl knob
- exthdrs_core.c is always built-in even when CONFIG_IPV6=n,
  where struct net has no .ipv6 member, so the read site would
  need an ifdef'd fallback to a constant anyway

Therefore, just use a constant (IP6_MAX_EXT_HDRS_CNT). All four
extension header walking functions are now bound by this limit.

Note that the check in ip6_protocol_deliver_rcu() happens right
before the goto resubmit, such that we don't have to have a test
for ipv6_ext_hdr() in the fast-path.

There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
IPv6 extension headers ordering and occurrence. The latter also
discusses security implications. As per RFC8200 section 4.1, the
occurrence rules for extension headers provide a practical upper
bound which is 8. In order to be conservative, let's define
IP6_MAX_EXT_HDRS_CNT as 4x that to leave enough room for quirky
setups. In the unlikely event that this is still not enough, then
we might need to reconsider a sysctl.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v3->v4:
   - Switching to hard-coded define with 32 limit as discussed
     earlier, otherwise fixing the kbuild-bot error becomes
     to ugly.. was worth a try, but given the case of being
     built-in also with CONFIG_IPV6=n define seems better
     (Justin, Victor, kbuild-bot)
 v2->v3:
   - Adding IP6SKB_HOPBYHOP coverage (Justin)
   - I left the limit at 8 w/ sysctl, still feels the better
     option to me if we can keep the worst-case more tightened
 v1->v2:
   - Set the default to 8 (Justin)
   - Update IETF references (Justin)
   - Add core path coverage as well (Justin)

 include/net/dropreason-core.h | 6 ++++++
 include/net/ipv6.h            | 3 +++
 net/ipv6/exthdrs_core.c       | 7 +++++++
 net/ipv6/ip6_input.c          | 5 +++++
 net/ipv6/ip6_tunnel.c         | 4 ++++
 5 files changed, 25 insertions(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index e0ca3904ff8e..2f312d1f67d6 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -99,6 +99,7 @@
 	FN(FRAG_TOO_FAR)		\
 	FN(TCP_MINTTL)			\
 	FN(IPV6_BAD_EXTHDR)		\
+	FN(IPV6_TOO_MANY_EXTHDRS)	\
 	FN(IPV6_NDISC_FRAG)		\
 	FN(IPV6_NDISC_HOP_LIMIT)	\
 	FN(IPV6_NDISC_BAD_CODE)		\
@@ -494,6 +495,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TCP_MINTTL,
 	/** @SKB_DROP_REASON_IPV6_BAD_EXTHDR: Bad IPv6 extension header. */
 	SKB_DROP_REASON_IPV6_BAD_EXTHDR,
+	/**
+	 * @SKB_DROP_REASON_IPV6_TOO_MANY_EXTHDRS: Number of IPv6 extension
+	 * headers in the packet exceeds IP6_MAX_EXT_HDRS_CNT.
+	 */
+	SKB_DROP_REASON_IPV6_TOO_MANY_EXTHDRS,
 	/** @SKB_DROP_REASON_IPV6_NDISC_FRAG: invalid frag (suppress_frag_ndisc). */
 	SKB_DROP_REASON_IPV6_NDISC_FRAG,
 	/** @SKB_DROP_REASON_IPV6_NDISC_HOP_LIMIT: invalid hop limit. */
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index d042afe7a245..118a24ac9e73 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -90,6 +90,9 @@ struct ip_tunnel_info;
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
 
+/* Hard limit on traversed IPv6 extension headers */
+#define IP6_MAX_EXT_HDRS_CNT		 32
+
 /*
  *	Addr type
  *	
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 49e31e4ae7b7..9d06d487e8b1 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -73,6 +73,7 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 		     __be16 *frag_offp)
 {
 	u8 nexthdr = *nexthdrp;
+	int exthdr_cnt = 0;
 
 	*frag_offp = 0;
 
@@ -82,6 +83,8 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 
 		if (nexthdr == NEXTHDR_NONE)
 			return -1;
+		if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT))
+			return -1;
 		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
 		if (!hp)
 			return -1;
@@ -190,6 +193,7 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 {
 	unsigned int start = skb_network_offset(skb) + sizeof(struct ipv6hdr);
 	u8 nexthdr = ipv6_hdr(skb)->nexthdr;
+	int exthdr_cnt = 0;
 	bool found;
 
 	if (fragoff)
@@ -216,6 +220,9 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 			return -ENOENT;
 		}
 
+		if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT))
+			return -EBADMSG;
+
 		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
 		if (!hp)
 			return -EBADMSG;
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 967b07aeb683..8972863c93ee 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -403,6 +403,7 @@ INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *));
 void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
 			      bool have_final)
 {
+	int exthdr_cnt = IP6CB(skb)->flags & IP6SKB_HOPBYHOP ? 1 : 0;
 	const struct inet6_protocol *ipprot;
 	struct inet6_dev *idev;
 	unsigned int nhoff;
@@ -487,6 +488,10 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
 				nexthdr = ret;
 				goto resubmit_final;
 			} else {
+				if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT)) {
+					SKB_DR_SET(reason, IPV6_TOO_MANY_EXTHDRS);
+					goto discard;
+				}
 				goto resubmit;
 			}
 		} else if (ret == 0) {
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index c468c83af0f2..9d1037ac082f 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -399,11 +399,15 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
 	unsigned int nhoff = raw - skb->data;
 	unsigned int off = nhoff + sizeof(*ipv6h);
 	u8 nexthdr = ipv6h->nexthdr;
+	int exthdr_cnt = 0;
 
 	while (ipv6_ext_hdr(nexthdr) && nexthdr != NEXTHDR_NONE) {
 		struct ipv6_opt_hdr *hdr;
 		u16 optlen;
 
+		if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT))
+			break;
+
 		if (!pskb_may_pull(skb, off + sizeof(*hdr)))
 			break;
 
-- 
2.43.0


