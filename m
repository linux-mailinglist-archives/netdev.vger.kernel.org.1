Return-Path: <netdev+bounces-274598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFMEB+qKzmlMoQYAu9opvQ
	(envelope-from <netdev+bounces-274598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:27:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BE838B3F6
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5435E301FD73
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A083446BE;
	Thu,  2 Apr 2026 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evw7K95o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C54331214
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143619; cv=none; b=jsILhmMhK10x/QHawmCjbZB76CaAwyfrLXiDB1jT5KLvHHH8HpQfDSJ2Z7TCwdr4kuG7hVE6+cxbjeVq9uPPQKB8rei9xfpVdeRi/RIkWmfl2of4oEOQh+vxtl/rwzreciDP/6TjKVKC7b+GORNzPaGTARkbwF7Q3P7mGRcgJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143619; c=relaxed/simple;
	bh=Ogllwm+AwXKCuYKPpYu0Lns0Kw2y4lBQNP9rtjKklJE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nGlAZ3QYim0Elfk8BkuUdYfsWUlzs1H5G1ful+bx/TPjN5u4BzOz246E6xS7F0cMX3BJskvenIFlCv5jAqDVNgFssXaYoQ5sJ3piB/5haorNpvhCM9r8NYj7qSlUn0N/99shqiCZDsRw3N/QLtPb/6RP2DG0aDaTE1KWYWKZ4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evw7K95o; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cd7ea0bb20so268190585a.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775143617; x=1775748417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jnWZOmIke8pjw9DoTgyjkqim64gngYd3D207RMKEsj4=;
        b=evw7K95oVNO4C/VECYvGnA5bC4LZk6CQTEIPtqGmfzb25/33RW84BlA3kWLlMGecHm
         JTOy030LitH/0YWF9zn+YhyLzRy5X1RfzaHjs462Iln5PrhiQrLgwgvE/6PP2TPGlRZG
         3WdV1aIgLSeQe9b9TilLLFqbHFX0iHcT2KgEjPOdsaSz3igU91pm3VM52iZCfv6o4xW8
         hS6gFOk42Lvbgxv5AS2ltF2jPdn6L8NYm0wUAE9kwriHDa7RsymAXAPLRzbrcZkDMMa4
         BRKCjuSpklqUpM4IaHu5fsXJZ7JhDdgfvBtCtjjWvudRlNzoxoCLg7FRuXaWtiIo6ZwO
         okpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775143617; x=1775748417;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jnWZOmIke8pjw9DoTgyjkqim64gngYd3D207RMKEsj4=;
        b=B4jFZybgTykHH1rxVRhOhYM8jLtKl3zhjP/bmnV1rolIMsJpghqob3oy8TIGpbZl3H
         rLxhdmnxMGLlfekg1FezFEdWvUTCGkRVM45dNMenrNcEnaRTBRY1aYdizsbwRRPj8BeT
         ptpKCQh8gMmr3aF6kTRFbP/IINCkeKR2lGzpNhwno5cX/ji6NOJXmqaC5WCqFuSi60lL
         WjDnRRjS8xmmdI8bSiJCQDvSwmj7o46cQxPNaZFKx2HLLCHk0v0XA2oZwEkHvLjf1Xtn
         HtyJlAjOqhtKvE7Ukkd1bjHAHb2jOTNfpCyJObfFPLXL4Vb7Ko+ui6pkui9KBXeAkbU0
         1siA==
X-Forwarded-Encrypted: i=1; AJvYcCUX9My3fo7/SNS+vQy/46NFXBcHQnro3ku6WZF/pZIgEMXGu0Z4SyShuBE548m98Er1I8vm0AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1m2aVx7R5wFdYR1c+vUxOq4sEFdOzgzCZ7w/q5CCW8Ulpi80C
	/b6t4EIQyq+Yb8GS4u7xBGWQtOkP0mLpb5eefGMP4hUty5lfw4RkEh8GQhOpOWRX0dXaTp27CHu
	TRXRcCSw3RMB2TQ==
X-Received: from qknqz18.prod.google.com ([2002:a05:620a:8c12:b0:8cf:c6b4:e3a1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:280c:b0:8cf:f215:24c6 with SMTP id af79cd13be357-8d1b5ae661cmr1171109185a.21.1775143616740;
 Thu, 02 Apr 2026 08:26:56 -0700 (PDT)
Date: Thu,  2 Apr 2026 15:26:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260402152654.1720627-1-edumazet@google.com>
Subject: [PATCH net-next] net: always inline some skb helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274598-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: 66BE838B3F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some performance critical helpers from include/linux/skbuff.h
are not inlined by clang.

Use __always_inline hint for:

 - __skb_fill_netmem_desc()
 - __skb_fill_page_desc()
 - skb_fill_netmem_desc()
 - skb_fill_page_desc()
 - __skb_pull()
 - pskb_may_pull_reason()
 - pskb_may_pull()
 - pskb_pull()
 - pskb_trim()
 - skb_orphan()
 - skb_postpull_rcsum()
 - skb_header_pointer()
 - skb_clear_delivery_time()
 - skb_tstamp_cond()
 - skb_warn_if_lro()

This increases performance and saves ~1200 bytes of text.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 4/24 grow/shrink: 66/12 up/down: 4104/-5306 (-1202)
Function                                     old     new   delta
ip_multipath_l3_keys                           -     303    +303
tcp_sendmsg_locked                          4560    4848    +288
xfrm_input                                  6240    6455    +215
esp_output_head                             1516    1711    +195
skb_try_coalesce                             696     866    +170
bpf_prog_test_run_skb                       1951    2091    +140
tls_strp_read_copy                           528     667    +139
gue_udp_recv                                 738     871    +133
__ip6_append_data                           4159    4279    +120
__bond_xmit_hash                            1019    1122    +103
ip6_multipath_l3_keys                        394     495    +101
bpf_lwt_seg6_action                         1096    1197    +101
input_action_end_dx2                         344     442     +98
vxlan_remcsum                                487     581     +94
udpv6_queue_rcv_skb                          393     480     +87
udp_queue_rcv_skb                            385     471     +86
gue_remcsum                                  453     539     +86
udp_lib_checksum_complete                     84     168     +84
vxlan_xmit                                  2777    2857     +80
nf_reset_ct                                  456     532     +76
igmp_rcv                                    1902    1978     +76
mpls_forward                                1097    1169     +72
tcp_add_backlog                             1226    1292     +66
nfulnl_log_packet                           3091    3156     +65
tcp_rcv_established                         1966    2026     +60
__strp_recv                                 1547    1603     +56
eth_type_trans                               357     411     +54
bond_flow_ip                                 392     444     +52
__icmp_send                                 1584    1630     +46
ip_defrag                                   1636    1681     +45
tpacket_rcv                                 2793    2837     +44
refcount_add                                 132     176     +44
nf_ct_frag6_gather                          1959    2003     +44
napi_skb_free_stolen_head                    199     240     +41
__pskb_trim                                    -      41     +41
napi_reuse_skb                               319     358     +39
icmpv6_rcv                                  1877    1916     +39
br_handle_frame_finish                      1672    1711     +39
ip_rcv_core                                  841     879     +38
ip_check_defrag                              377     415     +38
br_stp_rcv                                   909     947     +38
qdisc_pkt_len_segs_init                      366     399     +33
mld_query_work                              2945    2975     +30
bpf_sk_assign_tcp_reqsk                      607     637     +30
udp_gro_receive                             1657    1686     +29
ip6_rcv_core                                1170    1193     +23
ah_input                                    1176    1197     +21
tun_get_user                                5174    5194     +20
llc_rcv                                      815     834     +19
__pfx_udp_lib_checksum_complete               16      32     +16
__pfx_refcount_add                            48      64     +16
__pfx_nf_reset_ct                             96     112     +16
__pfx_ip_multipath_l3_keys                     -      16     +16
__pfx___pskb_trim                              -      16     +16
packet_sendmsg                              5771    5781     +10
esp_output_tail                             1460    1470     +10
alloc_skb_with_frags                         433     443     +10
xsk_generic_xmit                            3477    3486      +9
mptcp_sendmsg_frag                          2250    2259      +9
__ip_append_data                            4166    4175      +9
__ip6_tnl_rcv                               1159    1168      +9
skb_zerocopy                                1215    1220      +5
gre_parse_header                            1358    1362      +4
__iptunnel_pull_header                       405     407      +2
skb_vlan_untag                               692     693      +1
psp_dev_rcv                                  701     702      +1
netkit_xmit                                 1263    1264      +1
gre_rcv                                     2776    2777      +1
gre_gso_segment                             1521    1522      +1
bpf_skb_net_hdr_pop                          535     536      +1
udp6_ufo_fragment                            888     884      -4
br_multicast_rcv                            9154    9148      -6
snap_rcv                                     312     305      -7
skb_copy_ubufs                              1841    1834      -7
__pfx_skb_tstamp_cond                         16       -     -16
__pfx_skb_clear_delivery_time                 16       -     -16
__pfx_pskb_trim                               16       -     -16
__pfx_pskb_pull                               16       -     -16
ipv6_gso_segment                            1400    1383     -17
ipv6_frag_rcv                               2511    2492     -19
erspan_xmit                                 1221    1190     -31
__pfx_skb_warn_if_lro                         32       -     -32
__pfx___skb_fill_page_desc                    32       -     -32
skb_tstamp_cond                               42       -     -42
pskb_trim                                     46       -     -46
__pfx_skb_postpull_rcsum                      48       -     -48
tcp_gso_segment                             1524    1475     -49
skb_clear_delivery_time                       54       -     -54
__pfx_skb_fill_page_desc                      64       -     -64
__pfx_skb_header_pointer                      80       -     -80
pskb_pull                                     91       -     -91
skb_warn_if_lro                              110       -    -110
tcp_v6_rcv                                  3288    3170    -118
__pfx___skb_pull                             128       -    -128
__pfx_skb_orphan                             144       -    -144
__pfx_pskb_may_pull                          160       -    -160
tcp_v4_rcv                                  3334    3153    -181
__skb_fill_page_desc                         231       -    -231
udp_rcv                                     1809    1553    -256
skb_postpull_rcsum                           318       -    -318
skb_header_pointer                           367       -    -367
fib_multipath_hash                          3399    3018    -381
skb_orphan                                   513       -    -513
skb_fill_page_desc                           534       -    -534
__skb_pull                                   568       -    -568
pskb_may_pull                                604       -    -604
Total: Before=29652698, After=29651496, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 46 ++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9cc98f850f1d7cd01eed3fe9d17b59116b49958e..98e87bda9fa5add3e778d704373b300fc86e474a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2605,8 +2605,9 @@ static inline void skb_len_add(struct sk_buff *skb, int delta)
  *
  * Does not take any additional reference on the fragment.
  */
-static inline void __skb_fill_netmem_desc(struct sk_buff *skb, int i,
-					  netmem_ref netmem, int off, int size)
+static __always_inline void
+__skb_fill_netmem_desc(struct sk_buff *skb, int i, netmem_ref netmem,
+		       int off, int size)
 {
 	struct page *page;
 
@@ -2628,14 +2629,16 @@ static inline void __skb_fill_netmem_desc(struct sk_buff *skb, int i,
 		skb->pfmemalloc = true;
 }
 
-static inline void __skb_fill_page_desc(struct sk_buff *skb, int i,
-					struct page *page, int off, int size)
+static __always_inline void
+__skb_fill_page_desc(struct sk_buff *skb, int i, struct page *page,
+		     int off, int size)
 {
 	__skb_fill_netmem_desc(skb, i, page_to_netmem(page), off, size);
 }
 
-static inline void skb_fill_netmem_desc(struct sk_buff *skb, int i,
-					netmem_ref netmem, int off, int size)
+static __always_inline void
+skb_fill_netmem_desc(struct sk_buff *skb, int i, netmem_ref netmem,
+		     int off, int size)
 {
 	__skb_fill_netmem_desc(skb, i, netmem, off, size);
 	skb_shinfo(skb)->nr_frags = i + 1;
@@ -2655,8 +2658,9 @@ static inline void skb_fill_netmem_desc(struct sk_buff *skb, int i,
  *
  * Does not take any additional reference on the fragment.
  */
-static inline void skb_fill_page_desc(struct sk_buff *skb, int i,
-				      struct page *page, int off, int size)
+static __always_inline void
+skb_fill_page_desc(struct sk_buff *skb, int i, struct page *page,
+		   int off, int size)
 {
 	skb_fill_netmem_desc(skb, i, page_to_netmem(page), off, size);
 }
@@ -2828,7 +2832,7 @@ static inline void *__skb_push(struct sk_buff *skb, unsigned int len)
 }
 
 void *skb_pull(struct sk_buff *skb, unsigned int len);
-static inline void *__skb_pull(struct sk_buff *skb, unsigned int len)
+static __always_inline void *__skb_pull(struct sk_buff *skb, unsigned int len)
 {
 	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
 
@@ -2853,7 +2857,7 @@ void *skb_pull_data(struct sk_buff *skb, size_t len);
 
 void *__pskb_pull_tail(struct sk_buff *skb, int delta);
 
-static inline enum skb_drop_reason
+static __always_inline enum skb_drop_reason
 pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
 {
 	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
@@ -2871,12 +2875,13 @@ pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
 	return SKB_NOT_DROPPED_YET;
 }
 
-static inline bool pskb_may_pull(struct sk_buff *skb, unsigned int len)
+static __always_inline bool
+pskb_may_pull(struct sk_buff *skb, unsigned int len)
 {
 	return pskb_may_pull_reason(skb, len) == SKB_NOT_DROPPED_YET;
 }
 
-static inline void *pskb_pull(struct sk_buff *skb, unsigned int len)
+static __always_inline void *pskb_pull(struct sk_buff *skb, unsigned int len)
 {
 	if (!pskb_may_pull(skb, len))
 		return NULL;
@@ -3337,7 +3342,7 @@ static inline int __pskb_trim(struct sk_buff *skb, unsigned int len)
 	return 0;
 }
 
-static inline int pskb_trim(struct sk_buff *skb, unsigned int len)
+static __always_inline int pskb_trim(struct sk_buff *skb, unsigned int len)
 {
 	skb_might_realloc(skb);
 	return (len < skb->len) ? __pskb_trim(skb, len) : 0;
@@ -3380,7 +3385,7 @@ static inline int __skb_grow(struct sk_buff *skb, unsigned int len)
  *	destructor function and make the @skb unowned. The buffer continues
  *	to exist but is no longer charged to its former owner.
  */
-static inline void skb_orphan(struct sk_buff *skb)
+static __always_inline void skb_orphan(struct sk_buff *skb)
 {
 	if (skb->destructor) {
 		skb->destructor(skb);
@@ -4044,8 +4049,8 @@ __skb_postpull_rcsum(struct sk_buff *skb, const void *start, unsigned int len,
  *	update the CHECKSUM_COMPLETE checksum, or set ip_summed to
  *	CHECKSUM_NONE so that it can be recomputed from scratch.
  */
-static inline void skb_postpull_rcsum(struct sk_buff *skb,
-				      const void *start, unsigned int len)
+static __always_inline void
+skb_postpull_rcsum(struct sk_buff *skb, const void *start, unsigned int len)
 {
 	if (skb->ip_summed == CHECKSUM_COMPLETE)
 		skb->csum = wsum_negate(csum_partial(start, len,
@@ -4304,7 +4309,7 @@ __skb_header_pointer(const struct sk_buff *skb, int offset, int len,
 	return buffer;
 }
 
-static inline void * __must_check
+static __always_inline void * __must_check
 skb_header_pointer(const struct sk_buff *skb, int offset, int len, void *buffer)
 {
 	return __skb_header_pointer(skb, offset, len, skb->data,
@@ -4476,7 +4481,7 @@ DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
 /* It is used in the ingress path to clear the delivery_time.
  * If needed, set the skb->tstamp to the (rcv) timestamp.
  */
-static inline void skb_clear_delivery_time(struct sk_buff *skb)
+static __always_inline void skb_clear_delivery_time(struct sk_buff *skb)
 {
 	if (skb->tstamp_type) {
 		skb->tstamp_type = SKB_CLOCK_REALTIME;
@@ -4503,7 +4508,8 @@ static inline ktime_t skb_tstamp(const struct sk_buff *skb)
 	return skb->tstamp;
 }
 
-static inline ktime_t skb_tstamp_cond(const struct sk_buff *skb, bool cond)
+static __always_inline ktime_t
+skb_tstamp_cond(const struct sk_buff *skb, bool cond)
 {
 	if (skb->tstamp_type != SKB_CLOCK_MONOTONIC && skb->tstamp)
 		return skb->tstamp;
@@ -5292,7 +5298,7 @@ static inline void skb_decrease_gso_size(struct skb_shared_info *shinfo,
 
 void __skb_warn_lro_forwarding(const struct sk_buff *skb);
 
-static inline bool skb_warn_if_lro(const struct sk_buff *skb)
+static __always_inline bool skb_warn_if_lro(const struct sk_buff *skb)
 {
 	/* LRO sets gso_size but not gso_type, whereas if GSO is really
 	 * wanted then gso_type will be set. */
-- 
2.53.0.1185.g05d4b7b318-goog


