Return-Path: <netdev+bounces-288336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIYZIZY3B2ottwIAu9opvQ
	(envelope-from <netdev+bounces-288336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:11:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB35551EDB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 198D830005A8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F7C48A2AC;
	Fri, 15 May 2026 15:06:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB0292B54
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857589; cv=none; b=KkfM0tgPYxj3pR2nNf2hL36bMG7lMbG910VX/I5ON/n5o7YUY3reDdMYZn/QEnTIJiEcH6HAlW94eYHnB6bns/ku8CpNK8pXu2oguHAscT7EvW1A9OtKM/e0gugMECblNJAompyRtyJHGb84vMCBygK+CZczJFImsfRglkia018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857589; c=relaxed/simple;
	bh=y7UP4DX3+pPFoPxCWSu+GD0Wh8ljcMqmeACCBqn2irY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=UVFDYkG1XOdnbmGlpMSm6Udx8lTPz9rQYpOjBXDSPjCdL9YANhjxYFgo6njwtmA7+ff/G3LeMuivEylQwjImqb51t4GQHEuJTdqcFb7/cvzSObykLdy7zZVWDzy2fuOpkwYkUIWyB4a8mrpkgVOA2nHBquF8AGI7z0TwZAY2A7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64FF5t4G043206;
	Sat, 16 May 2026 00:05:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64FF5tZh043202
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 16 May 2026 00:05:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <98be20ee-c914-4c93-b4bd-d04ddcc349cf@I-love.SAKURA.ne.jp>
Date: Sat, 16 May 2026 00:05:52 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH net] net: neighbour: reject neighbor creation on IFF_NOARP
 devices
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Queue-Id: 7EB35551EDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288336-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,i-love.sakura.ne.jp:email,I-love.SAKURA.ne.jp:mid,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

syzbot is reporting

  unregister_netdevice: waiting for vcan0 to become free. Usage count = 2

problem.

I asked AI Mode in Google Search to analyze a log from my debug printk()
patch in linux-next-20260508. It performed a meticulous trace of
__dev_hold() and __dev_put() frequency, and identified that a reference
acquired via ___neigh_create() remains unreleased at the end of the device
unregistration timeline.

  Call trace for vcan0[24] +1 at
       __dev_hold include/linux/netdevice.h:4470 [inline]
       netdev_hold include/linux/netdevice.h:4513 [inline]
       ___neigh_create+0xcb3/0x2360 net/core/neighbour.c:664
       neigh_add+0xc51/0xf70 net/core/neighbour.c:2136
       rtnetlink_rcv_msg+0x77e/0xbe0 net/core/rtnetlink.c:7005
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x780/0x920 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
       sock_sendmsg_nosec+0x112/0x150 net/socket.c:797

For devices that do not require address resolution, such as CAN devices
(vcan) or loopback (lo) which carry the IFF_NOARP flag, explicit neighbor
creation requests (via Netlink RTM_NEWNEIGH) shouldn't be permitted.
If an arbitrary neighbor entry is created on such a device, it can under
certain protocol mismatches bypass the standard flush mechanism
(neigh_ifdown) during the NETDEV_UNREGISTER notification chain. As a
result, the neighbor object clings onto the net_device's reference tracker
permanently, blocking the device from being freed.

Fix this by explicitly rejecting neighbor creation requests on devices
with the IFF_NOARP flag set, returning -EOPNOTSUPP. How to handle this
problem for devices without the IFF_NOARP flag set needs wider discussion.

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Analyzed-by: AI Mode in Google Search (no mail address)
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Below section is additional comments from AI Mode. Since I'm not familiar
with this area, this is beyond what I can understand. Therefore, I would
appreciate validations / thoughts from the netdev community on how we
should address this wider scope for non-IFF_NOARP devices.

  During the log analysis, we also uncovered a potential "air pocket"
  (protocol mismatch) in the neighbor flush mechanism that could similarly
  affect !IFF_NOARP devices (e.g., standard Ethernet devices).
  
  How the mismatch happens for !IFF_NOARP devices:
  When a neighbor entry is explicitly created via Netlink, the requested
  table's family determines where it gets chained. For example, if a
  request targets the IPv6 neighbor table (nd_tbl) on a device that hasn't
  fully initialized IPv6 (or during a phase where IPv6 contexts are already
  being torn down), the entry successfully hooks into
  dev->neighbours[NEIGH_ND_TABLE].
  
  However, during unregistration (NETREG_UNREGISTERING), the core network
  layer fires the NETDEV_UNREGISTER notifier chain. If the IPv6 notification
  handler (addrconf_notify) decides to skip the cleanup loop because the
  device's IPv6 configuration is absent or already destroyed,
  neigh_ifdown(&nd_tbl, dev) is never triggered. Meanwhile, the IPv4 handler
  (fib_netdev_event) only flushes dev->neighbours[NEIGH_ARP_TABLE] and
  remains blind to the stray IPv6 bucket. This allows the neighbor entry to
  silently bypass the flush process, causing a permanent refcount leak on
  standard devices.

  Additionally, a similar leak can occur if a neighbor entry is marked as
  NUD_PERMANENT. During the early stage of unregistration (e.g., NETDEV_DOWN),
  neigh_flush_dev() skips permanent entries because 'skip_perm' is true.
  If subsequent notifier steps abort or fail to clear out NUD_PERMANENT
  entries properly, the tracker stays alive indefinitely.

  Possible Solutions for !IFF_NOARP devices:
  1. Ingress Validation: In ___neigh_create() or neigh_add(), strictly validate
     that the requested table's family (tbl->family) corresponds to a protocol
     layer that is currently enabled/active on the target net_device.
  2. Safety Net in Dev Core: Introduce a final, unconditional flush (e.g.,
     calling neigh_ifdown_many() with skip_perm=false) directly inside the
     unregister_netdevice core logic before entering the 10-second wait loop,
     rather than relying entirely on protocol-specific notifier chains.

 net/core/neighbour.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 5d9216016507..06170fb3f976 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -652,6 +652,9 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	struct neigh_hash_table *nht;
 	int error;
 
+	if (dev->flags & IFF_NOARP)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	n = neigh_alloc(tbl, dev, flags, exempt_from_gc);
 	trace_neigh_create(tbl, dev, pkey, n, exempt_from_gc);
 	if (!n) {
-- 
2.54.0


