Return-Path: <netdev+bounces-302629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bhJeDf5wQmpZ7QkAu9opvQ
	(envelope-from <netdev+bounces-302629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:19:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 873DF6DB13E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:19:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rcpassos.me header.s=purelymail2 header.b=WNdUmxUN;
	dkim=pass header.d=purelymail.com header.s=purelymail2 header.b=GyEMib7G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302629-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302629-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rcpassos.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19EC13125B75
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59748403E87;
	Mon, 29 Jun 2026 12:59:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE37403AEE
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:59:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737966; cv=none; b=ZiLhoEvEO/Keb6VsaCIJyk1BrCh1J9CmgK7U92BNctrdUDXH7uKhNLQz83+dwGjFvmkGwYnV0PmiMEs1E6JLptSjLGgzsIV/CRVWDvcey7/EqvKNen6eYPu15LURak5kLkkxNFminSOEsHYy8QfDZarP08qEoO4/YVeSNneCtzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737966; c=relaxed/simple;
	bh=OAabJhZJpwdljO6/DOk3RokqXfpzgC+NtYOZUkORDt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9MGCYfriAPM59kdtACUpv0kVUgb9MkAlbQYvRCUFzO5KPQ9UwemTDBuW0vfbooqiAXpS+y54OSWKAavpknFUs8yuNCQI4k7r5NnejM5GYHIjlyoJOmuw4bWkOOiETjRShBFSu4V5sjzoIAcq+6h3zVm7hgb3dL2OHAfFg/YrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=WNdUmxUN; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=GyEMib7G; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=WNdUmxUNjSIFknvfTJ0w5wTRP9R0jFn/wzrIGwbmMaukZVK3ih7w2yozFrKJj7Qkxr0DAG1sDDIpj9sWyu3u7QY47EemI0kk9AK+q2JG/Yr1wpl0Id5r3FJN6C1qlEPnprbi5dax3EWftVC3J+4Jrhgn8ln522ZEIitzfVE+D8+eHizV7dL0G95s+Lhrm8xTNpNmdv2nsJ2FfW+ssKxzemPsN/IerApwUfMa+V5P4QmUNTWaQL9YS7/aaMSdQPYuZbi3GL05Ncepk2Bq4Hhp8oONUAlx+Pp1vAMnNc50D7HACz7Ja4yl/XnhOCFd2yz+gkuanL9hLEWY4Ka92M5Nbg==; s=purelymail2; d=rcpassos.me; v=1; bh=OAabJhZJpwdljO6/DOk3RokqXfpzgC+NtYOZUkORDt0=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=GyEMib7GxlAfbmEixXiJ+7ATVUeMTInm2mJGrzGh7uS98PRodaLZ9H8Kua3hvuhn1z5Ccqd2uEVvD0FuKLY3AwVU7McoFmHenF2gNFamgvMrVgAA/EbvvH3SFUs/LE7oE/5yUmKmJ87adLhu3oHOEceBpOetVIa9gHYvcHIFq4giAg7RU3MOnGeqpUzlHqf6a/gqxpMO4+vZ3Kv3Z0BV7eMnX8TgBni3KLDqIibfQ3zWXEtVmHkvjloIiIuj+vwX942zuvMSFmwpDGJRhoWTU5Ds3JtmJ39cOdaQhWpXVt09Vi7PCtT7+bwA02M3UQenZqkux5t2ZZ4FI5EAdtFlFw==; s=purelymail2; d=purelymail.com; v=1; bh=OAabJhZJpwdljO6/DOk3RokqXfpzgC+NtYOZUkORDt0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 647000529;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 29 Jun 2026 12:59:01 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: andrew+netdev@lunn.ch,
	tytso@mit.edu
Cc: rafael@rcpassos.me,
	Jason@zx2c4.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	wireguard@lists.zx2c4.com
Subject: [PATCH v2] Wireguard: Fix data-race in rx/tx counter
Date: Mon, 29 Jun 2026 09:59:13 -0300
Message-ID: <20260629125913.2354450-1-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DJL786MPR9HO.BWHI3U37PDVM@rcpassos.me>
References: <DJL786MPR9HO.BWHI3U37PDVM@rcpassos.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rcpassos.me,reject];
	R_DKIM_ALLOW(-0.20)[rcpassos.me:s=purelymail2,purelymail.com:s=purelymail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302629-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rafael@rcpassos.me,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:tytso@mit.edu,m:rafael@rcpassos.me,m:Jason@zx2c4.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,m:syzkaller-bugs@googlegroups.com,m:wireguard@lists.zx2c4.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@rcpassos.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rcpassos.me:+,purelymail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9ca7674fa7521a3f1bc2];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,purelymail.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 873DF6DB13E

Fix data-race in {rx/tx}_bytes counter for wireguard connection.
These values were incremented inside a read_lock_bh block, without
exclusive write protection.
Using per-cpu counters guarantees consistency, and move overhead only to
the read part: the least frequent operation.

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
As we discussed in the thread, keeping this counters accurate might not
be worth this extra memory cost of per-cpu counter.
It was great reading and learning about it. I think this would have been
a good patch :)

When looking around drivers/net, I found a few u64_stats uses without
per-cpu. I will do some digging to understand the reasoning behind it,
compared to the original "bare u64 counters" in wireguard.

Thanks,
Rafael Passos

 drivers/net/wireguard/netlink.c | 22 ++++++++++++++++++++--
 drivers/net/wireguard/peer.c    |  7 ++++++-
 drivers/net/wireguard/peer.h    |  7 ++++++-
 drivers/net/wireguard/receive.c |  9 ++++++++-
 drivers/net/wireguard/socket.c  |  9 +++++++--
 5 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlin=
k.c
index 1da7e98d0d50..f5978a8c2ca3 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -105,13 +105,31 @@ get_peer(struct wg_peer *peer, struct sk_buff *skb, s=
truct dump_ctx *ctx)
 =09=09if (fail)
 =09=09=09goto err;
=20
+=09=09// read per-cpu counters for peer rx/tx_bytes
+=09=09u64 total_rx_bytes =3D 0, total_tx_bytes =3D 0;
+=09=09u64 rx_bytes =3D 0, tx_bytes =3D 0;
+=09=09struct wg_peer_stats *pcpu_ptr;
+=09=09unsigned int cpu, start;
+
+=09=09for_each_possible_cpu(cpu) {
+=09=09=09pcpu_ptr =3D per_cpu_ptr(peer->pcpu_stats, cpu);
+=09=09=09do {
+=09=09=09=09start =3D u64_stats_fetch_begin(&pcpu_ptr->syncp);
+=09=09=09=09rx_bytes =3D u64_stats_read(&pcpu_ptr->rx_bytes);
+=09=09=09=09tx_bytes =3D u64_stats_read(&pcpu_ptr->tx_bytes);
+=09=09=09} while (u64_stats_fetch_retry(&pcpu_ptr->syncp, start));
+
+=09=09=09total_rx_bytes +=3D rx_bytes;
+=09=09=09total_tx_bytes +=3D tx_bytes;
+=09=09}
+
 =09=09if (nla_put(skb, WGPEER_A_LAST_HANDSHAKE_TIME,
 =09=09=09    sizeof(last_handshake), &last_handshake) ||
 =09=09    nla_put_u16(skb, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
 =09=09=09=09peer->persistent_keepalive_interval) ||
-=09=09    nla_put_u64_64bit(skb, WGPEER_A_TX_BYTES, peer->tx_bytes,
+=09=09    nla_put_u64_64bit(skb, WGPEER_A_TX_BYTES, total_tx_bytes,
 =09=09=09=09      WGPEER_A_UNSPEC) ||
-=09=09    nla_put_u64_64bit(skb, WGPEER_A_RX_BYTES, peer->rx_bytes,
+=09=09    nla_put_u64_64bit(skb, WGPEER_A_RX_BYTES, total_rx_bytes,
 =09=09=09=09      WGPEER_A_UNSPEC) ||
 =09=09    nla_put_u32(skb, WGPEER_A_PROTOCOL_VERSION, 1))
 =09=09=09goto err;
diff --git a/drivers/net/wireguard/peer.c b/drivers/net/wireguard/peer.c
index 1cb502a932e0..a37aa31f132a 100644
--- a/drivers/net/wireguard/peer.c
+++ b/drivers/net/wireguard/peer.c
@@ -36,6 +36,10 @@ struct wg_peer *wg_peer_create(struct wg_device *wg,
 =09if (unlikely(dst_cache_init(&peer->endpoint_cache, GFP_KERNEL)))
 =09=09goto err;
=20
+=09peer->pcpu_stats =3D alloc_percpu(struct wg_peer_stats);
+=09if (unlikely(!peer->pcpu_stats))
+=09=09goto err;
+
 =09peer->device =3D wg;
 =09wg_noise_handshake_init(&peer->handshake, &wg->static_identity,
 =09=09=09=09public_key, preshared_key, peer);
@@ -189,7 +193,8 @@ static void rcu_release(struct rcu_head *rcu)
=20
 =09dst_cache_destroy(&peer->endpoint_cache);
 =09WARN_ON(wg_prev_queue_peek(&peer->tx_queue) || wg_prev_queue_peek(&peer=
->rx_queue));
-
+
+=09free_percpu(peer->pcpu_stats);
 =09/* The final zeroing takes care of clearing any remaining handshake key
 =09 * material and other potentially sensitive information.
 =09 */
diff --git a/drivers/net/wireguard/peer.h b/drivers/net/wireguard/peer.h
index 718fb42bdac7..e01781724aa1 100644
--- a/drivers/net/wireguard/peer.h
+++ b/drivers/net/wireguard/peer.h
@@ -34,6 +34,11 @@ struct endpoint {
 =09};
 };
=20
+struct wg_peer_stats {
+=09u64_stats_t rx_bytes, tx_bytes;
+=09struct u64_stats_sync syncp;
+};
+
 struct wg_peer {
 =09struct wg_device *device;
 =09struct prev_queue tx_queue, rx_queue;
@@ -49,7 +54,7 @@ struct wg_peer {
 =09struct work_struct transmit_handshake_work, clear_peer_work, transmit_p=
acket_work;
 =09struct cookie latest_cookie;
 =09struct hlist_node pubkey_hash;
-=09u64 rx_bytes, tx_bytes;
+=09struct wg_peer_stats __percpu *pcpu_stats;
 =09struct timer_list timer_retransmit_handshake, timer_send_keepalive;
 =09struct timer_list timer_new_handshake, timer_zero_key_material;
 =09struct timer_list timer_persistent_keepalive;
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receiv=
e.c
index eb8851113654..d799370122b5 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -19,8 +19,15 @@
 /* Must be called with bh disabled. */
 static void update_rx_stats(struct wg_peer *peer, size_t len)
 {
+=09struct wg_peer_stats *pcpu_ptr;
+
 =09dev_sw_netstats_rx_add(peer->device->dev, len);
-=09peer->rx_bytes +=3D len;
+
+=09pcpu_ptr =3D this_cpu_ptr(peer->pcpu_stats);
+
+=09u64_stats_update_begin(&pcpu_ptr->syncp);
+=09u64_stats_add(&pcpu_ptr->rx_bytes, len);
+=09u64_stats_update_end(&pcpu_ptr->syncp);
 }
=20
 #define SKB_TYPE_LE32(skb) (((struct message_header *)(skb)->data)->type)
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.=
c
index 0028ef17dc71..685ae6a0fb2c 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -166,6 +166,7 @@ static int send6(struct wg_device *wg, struct sk_buff *=
skb,
=20
 int wg_socket_send_skb_to_peer(struct wg_peer *peer, struct sk_buff *skb, =
u8 ds)
 {
+=09struct wg_peer_stats *pcpu_ptr;
 =09size_t skb_len =3D skb->len;
 =09int ret =3D -EAFNOSUPPORT;
=20
@@ -178,8 +179,12 @@ int wg_socket_send_skb_to_peer(struct wg_peer *peer, s=
truct sk_buff *skb, u8 ds)
 =09=09=09    &peer->endpoint_cache);
 =09else
 =09=09dev_kfree_skb(skb);
-=09if (likely(!ret))
-=09=09peer->tx_bytes +=3D skb_len;
+=09if (likely(!ret)) {
+=09=09pcpu_ptr =3D this_cpu_ptr(peer->pcpu_stats);
+=09=09u64_stats_update_begin(&pcpu_ptr->syncp);
+=09=09u64_stats_add(&pcpu_ptr->tx_bytes, skb_len);
+=09=09u64_stats_update_end(&pcpu_ptr->syncp);
+=09}
 =09read_unlock_bh(&peer->endpoint_lock);
=20
 =09return ret;
--=20
2.53.0


