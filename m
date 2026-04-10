Return-Path: <netdev+bounces-277204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEfaCU5b2GnJcQgAu9opvQ
	(envelope-from <netdev+bounces-277204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:07:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 978963D151A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C377B3008D1A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D77329E5A;
	Fri, 10 Apr 2026 02:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YxhlSvOO"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC530AD10
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 02:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775786812; cv=none; b=RniJ+Rc3eVpxJWIK4sOfvL7/0Xr2NHb8+yOGovWBEvmCU8T1dk/wHMnmWDaS6cvHxPmbJWR4Jkp9KMqB73Ncl/UMs5KuOiyjPalLFjKYlfvQvc+r7TvhaESYvZA5zdPO8gTQ7GGLR4//NIWGkOooArpnWa6v+ML0LgjL3cAkxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775786812; c=relaxed/simple;
	bh=dqTRc6lb5JaF64i9c1KKNSx1apIREzKFM78MB75p65w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQwop9IZJwJ94MjoCi1o+uX0FnMA1JCTomHqvjtJQjhFJxllrumkwawY4SvM6IiOroQdcWe23vnGOl98ijJ9m1wYqvTE3UN75iKexVL2oyIygPlCidixG7Owqvl3a6++fGLusBJaMRhNEwhtacQjT29rarQvEx+3ZzTTEOcgwNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YxhlSvOO; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775786798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gtvO2HkO2aMIv5kb02WZmk9nNe7YugVZonfkXfzzLO4=;
	b=YxhlSvOONCBmz98+uvWTHMsjRA6kYnspHAal3tazUG9ehACq7QRebBFwgFQVxGCHF1DEHh
	HGu9YZVewrX4SLVC3GShIpi5BqCL+5mZUjp/2NNTMNt8JH0eHGlI2hJhtsTz2uJIvyh2iX
	qQeWDYG83NfbeHkgE3e/VK1pL48STns=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: fix __this_cpu_add() in preemptible code in dev_xmit_recursion_inc/dec
Date: Fri, 10 Apr 2026 10:06:30 +0800
Message-ID: <20260410020631.191786-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277204-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 978963D151A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dev_xmit_recursion_{inc,dec}() use __this_cpu_{inc,dec}() which requires
the caller to be non-preemptible in order to avoid cpu migration. However,
some callers like SCTP's UDP encapsulation path invoke iptunnel_xmit()
from process context without disabling BH or preemption:

  sctp_inet_connect -> __sctp_connect -> sctp_do_sm ->
  sctp_outq_flush -> sctp_packet_transmit -> sctp_v4_xmit ->
  udp_tunnel_xmit_skb -> iptunnel_xmit -> dev_xmit_recursion_inc

This triggers the following warning on PREEMPT(full) kernels:

  BUG: using __this_cpu_add() in preemptible [00000000]
  caller is dev_xmit_recursion_inc include/linux/netdevice.h:3595 [inline]
  caller is iptunnel_xmit+0x1cd/0xb80 net/ipv4/ip_tunnel_core.c:72
  Tainted: [L]=SOFTLOCKUP
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:94 [inline]
   dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
   check_preemption_disabled+0xd8/0xe0 lib/smp_processor_id.c:47
   dev_xmit_recursion_inc include/linux/netdevice.h:3595 [inline]
   iptunnel_xmit+0x1cd/0xb80 net/ipv4/ip_tunnel_core.c:72
   sctp_v4_xmit+0x75f/0x1060 net/sctp/protocol.c:1073
   sctp_packet_transmit+0x22ec/0x3060 net/sctp/output.c:653
   sctp_packet_singleton+0x19e/0x370 net/sctp/outqueue.c:783
   sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline]
   sctp_outq_flush+0x315/0x3350 net/sctp/outqueue.c:1212
   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1824 [inline]
   sctp_side_effects net/sctp/sm_sideeffect.c:1204 [inline]
   sctp_do_sm+0xce1/0x5be0 net/sctp/sm_sideeffect.c:1175
   sctp_primitive_ASSOCIATE+0x9c/0xd0 net/sctp/primitive.c:73
   __sctp_connect+0x9fc/0xc70 net/sctp/socket.c:1235
   sctp_connect net/sctp/socket.c:4818 [inline]
   sctp_inet_connect+0x15f/0x220 net/sctp/socket.c:4833
   __sys_connect_file+0x141/0x1a0 net/socket.c:2089
   __sys_connect+0x141/0x170 net/socket.c:2108
   __do_sys_connect net/socket.c:2114 [inline]
   __se_sys_connect net/socket.c:2111 [inline]
   __x64_sys_connect+0x72/0xb0 net/socket.c:2111
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

All other callers of dev_xmit_recursion_{inc,dec}() are fine: those in
net/core/dev.c and net/core/filter.c run under local_bh_disable(), and
lwtunnel_input() asserts in_softirq() context. Currently only
iptunnel_xmit() and ip6tunnel_xmit() can be reached from process
context via the SCTP UDP encapsulation path.

Fix this by adding guard(migrate)() at the top of iptunnel_xmit() and
ip6tunnel_xmit() to ensure dev_recursion_level(), dev_xmit_recursion_inc()
and dev_xmit_recursion_dec() all run on the same CPU.

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v1->v2: https://lore.kernel.org/netdev/20260409035344.214279-1-jiayuan.chen@linux.dev/
 - Move guard(migrate)() to iptunnel_xmit()/ip6tunnel_xmit() instead
   of dev_xmit_recursion_{inc,dec}(), so that dev_recursion_level() is
   also covered under the same migration protection.
 - Revert changes to include/linux/netdevice.h.
---
 include/net/ip6_tunnel.h  | 2 ++
 net/ipv4/ip_tunnel_core.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index 359b595f1df9..3f877164233c 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -156,6 +156,8 @@ static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
 {
 	int pkt_len, err;
 
+	guard(migrate)();
+
 	if (unlikely(dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT)) {
 		if (dev) {
 			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 5683c328990f..808b8eaf7fad 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -58,6 +58,8 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	struct iphdr *iph;
 	int err;
 
+	guard(migrate)();
+
 	if (unlikely(dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT)) {
 		if (dev) {
 			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
-- 
2.43.0


