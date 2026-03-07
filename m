Return-Path: <netdev+bounces-265061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD0kBSChq2kKfAEAu9opvQ
	(envelope-from <netdev+bounces-265061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:53:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237422A017
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15A1A3027942
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738C030DED5;
	Sat,  7 Mar 2026 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bASu/eQk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D254284884;
	Sat,  7 Mar 2026 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772855581; cv=none; b=sH83LRhVJ+ddai3To9vCRpKbwNU9T29arVDIoYy1H8MwkWalWsDz9WAL/6BZHotae4vPwad9/wlQ7e4iBKvIZV6aT/aTGNfqz2zKQeJxV0j4POISsVZpb2n38FH55rbSEcOUmEvgft86YLh5if63ReY+9vclDzCUqD95VL0zGh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772855581; c=relaxed/simple;
	bh=2VKjOBAvdDuHyTYpQp4+fH3E0GVniSmbG/grWeTNYbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ts9hR08j/Ipt8PHgSuZnOtGjXK5YKGmIXbtdvMN4f0/YM+Owiw+CLx3O9+quWVdizBi0s0e93dWQZBiICSCXIqKP8YKbRmf/O2jDfWCRSGng+QS2CSKYIIgkAhiSF8ZORArzTGFvgX7d+HbWVoTa7PshK6sKGPhC5nVCQhE8yCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bASu/eQk; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Y9
	FgILjFxFmSSdvhtpxbCtpywPbYSocA+aWvpBBe7Rk=; b=bASu/eQkGl/8rQYpBI
	YVg51DJUWaN8XRRs4aE/UVCMXIV1OHmWs1zCoFZPNEejjZdUCcdQax2/nLEAffCs
	WtEYv6oFEZ8QoT7P1j4Q2SMKUX6dgFhE4YNaJXqnQYsxXo23g55UVlJMhvFJo3Xc
	CugXBhm+57LkYHs5njeSTk2xU=
Received: from localhost.net (unknown [])
	by gzsmtp3 (Coremail) with UTF8SMTPA id M88vCgD3f6vioKtpEUwtAg--.60202S2;
	Sat, 07 Mar 2026 11:52:03 +0800 (CST)
From: xietangxin <xietangxin@yeah.net>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xietangxin <xietangxin@yeah.net>
Subject: [PATCH] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
Date: Sat,  7 Mar 2026 11:51:10 +0800
Message-ID: <20260307035110.7121-1-xietangxin@yeah.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:M88vCgD3f6vioKtpEUwtAg--.60202S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArW3XF43AFy5Jw1kArW3GFg_yoW5WF4fpF
	4YkrW5Zr4vqry7Aa95Xw4kWry8Zan5J3y3Grs0gw1a9398CFy5tr1IvryUtFWDCFs5Z347
	Zr4Fvr17KrZ0vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Utu4UUUUUU=
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiNAOl2WmroOOxQwAA34
X-Rspamd-Queue-Id: 6237422A017
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265061-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[yeah.net];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[yeah.net:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,yeah.net];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,yeah.net:dkim,yeah.net:email,yeah.net:mid]
X-Rspamd-Action: no action

A UAF issue occurs when the virtio_net driver is configured with napi_tx=N
and the device's IFF_XMIT_DST_RELEASE flag is cleared
(e.g., during the configuration of tc route filter rules).

When IFF_XMIT_DST_RELEASE is removed from the net_device, the network stack
expects the driver to hold the reference to skb->dst until the packet
is fully transmitted and freed. In virtio_net with napi_tx=N,
skbs may remain in the virtio transmit ring for an extended period.

If the network namespace is destroyed while these skbs are still pending,
the corresponding dst_ops structure has freed. When a subsequent packet
is transmitted, free_old_xmit() is triggered to clean up old skbs.
It then calls dst_release() on the skb associated with the stale dst_entry.
Since the dst_ops (referenced by the dst_entry) has already been freed,
a UAF kernel paging request occurs.

fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
the dst reference before the skb is queued in virtio_net.

Call Trace:
 Unable to handle kernel paging request at virtual address ffff80007e150000
 CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc1+ #6 PREEMPT
  ...
  percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
  dst_release+0xe0/0x110  net/core/dst.c:177
  skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
  sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
  dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
  napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
  __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_net]
  free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
  start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
  ...

Reproduction Steps:
NETDEV="enp3s0"

config_qdisc_route_filter() {
    tc qdisc del dev $NETDEV root
    tc qdisc add dev $NETDEV root handle 1: prio
    tc filter add dev $NETDEV parent 1:0 protocol ip prio 100 route to 100 flowid 1:1
    ip route add 192.168.1.100/32 dev $NETDEV realm 100
}

test_ns() {
    ip netns add testns
    ip link set $NETDEV netns testns
    ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
    ip netns exec testns ping -c 1 10.0.32.1
    ip netns del testns
}

config_qdisc_route_filter

test_ns
sleep 2
test_ns

Signed-off-by: xietangxin <xietangxin@yeah.net>
---
 drivers/net/virtio_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 72d6a9c6a..5b13a61b3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3351,6 +3351,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Don't wait up for transmitted skbs to be freed. */
 	if (!use_napi) {
 		skb_orphan(skb);
+		skb_dst_drop(skb);
 		nf_reset_ct(skb);
 	}
 
-- 
2.43.0


