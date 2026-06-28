Return-Path: <netdev+bounces-302416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OZaINVyGQWpBrwkAu9opvQ
	(envelope-from <netdev+bounces-302416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 22:38:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 400076D4E6D
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 22:38:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rcpassos.me header.s=purelymail2 header.b=uKCtBt4R;
	dkim=pass header.d=purelymail.com header.s=purelymail2 header.b=W1Yvhwjj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302416-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302416-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rcpassos.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5645B300E5EB
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 20:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E270D3B71B9;
	Sun, 28 Jun 2026 20:38:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921D3B27E7
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 20:38:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782679120; cv=none; b=Z5IHerL112SRd3cv2pCcUFKJuGAhAEnJw5A+wEYBgQGqDz8QDK8TW+jkPy9cvvij8xNlgZW46JMCPbDoS6A09znXt3qVauu4XbEPobzy61CocqVyQ1YSkWqHL6hCcK3RTYJTQwMD3r5dNf9OfN/6x7+TuGbV22GsA7Z1dI7AsZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782679120; c=relaxed/simple;
	bh=eVlNk3fd20VVp42Y7KTyhuYm+giDYVo7aA3aU9r8sjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsij3hi/6HkHXSA/UhYeKi8DHatuXt1x7cwdCu0ZFedlR6Dqea2J+1IDJaVc6paLH+qSHDATCtjyfdm2gsm1ktVIPG866DxAFmee7dR4uYgafexWdF1w+raJP35ulkN6uyeGMVznWFNcAgyrLOyFp3tPMAG/qPLqcFOMKbGEikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=uKCtBt4R; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=W1Yvhwjj; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=uKCtBt4Rp+KXAHSoj8dl0Bs60CfteJJZRP6SZJjbSnQCP9s9fvkKu8bsXWAg2XQl95SEe2N6T0TNOlrwIuRgBBiUrCZlCS4csx60Sat58g1nFWARGdfEcCwwtS2mOfhl8rkRAhGyAsUjeG3ZqkBcljQMu53mZQ2tV45tTcrp7afOn/CeYs9SDXzE7rTcr9WKj1+W8uMJs1pwj2Z0MoOTwzWmSniqs//UaQ3jFQwJK0ZebrCjco2SNbWPT3348d8ytFjJhg3CQoDqGsdAbUAKiPlqmmvlhseJ6lWf1+sGUIcIb7xVGGaNFQbiKcl5nUI2nja4SlyXkv9hSg/t2VyUfw==; s=purelymail2; d=rcpassos.me; v=1; bh=eVlNk3fd20VVp42Y7KTyhuYm+giDYVo7aA3aU9r8sjQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=W1YvhwjjkIiSmzuRoClUVpqDa8Buw27Rhq+r1PhBnTZWLgPsrblJXQ4RQcq5aFizquzQ8EMDmQ0oVmq9LlaeSMN9EkDAyLXItrybo9HnZS1c8DPWjLT8PJHFLGPsbaszDgC1aoN5gTokwin84hdZFTtSNyBSsdQzdPJgak78A55zRyuBl+UxUlUwHXS9pf9wcrLqoZj7ovcS5FTkPvuvwvIANEH3kapaP7YXlPrzu49Ls6EaKjaP2jXIsPWAPf6++fjHC22sYW68WkDYAWMJfqakCk3EpVo6e2Ya45v2bK6I5FfJwJ1ya0I1jEfcNoNdBolm3AgHa03OXP9g9yQMHw==; s=purelymail2; d=purelymail.com; v=1; bh=eVlNk3fd20VVp42Y7KTyhuYm+giDYVo7aA3aU9r8sjQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1919165294;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 28 Jun 2026 20:38:09 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: rafael@rcpassos.me
Cc: Jason@zx2c4.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	wireguard@lists.zx2c4.com
Subject: [PATCH] Wireguard: Fix data-race in rx/tx counter
Date: Sun, 28 Jun 2026 17:38:23 -0300
Message-ID: <20260628203823.144789-1-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DJFTVX3FE7OD.2O8GTO84798T@rcpassos.me>
References: <DJFTVX3FE7OD.2O8GTO84798T@rcpassos.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302416-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rafael@rcpassos.me,m:Jason@zx2c4.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,m:syzkaller-bugs@googlegroups.com,m:wireguard@lists.zx2c4.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rafael@rcpassos.me,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@rcpassos.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rcpassos.me:+,purelymail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9ca7674fa7521a3f1bc2];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 400076D4E6D

fixes data-race in {rx/tx}_bytes counter for wireguard connection.
these values were incremented inside a read_lock_bh block, but write
protections were missing. making them atomic was the simplest way out.
This was found by syzbot with kcsan.

Reported-by: syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=3D9ca7674fa7521a3f1bc2
Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---

Hi,

I am posting this patch to better ilustrate the discussion.
If this is a non-issue, its fine.
As I mentioned in the previous email, this issue was reported by syzbot,
but I was not able to reproduce it.
I am also aware atomic calls may introduce extra cost on older arm cpus.
I would like to hear from the community: would this an adequate solution ?

Thanks,

Rafael Passos



 drivers/net/wireguard/netlink.c | 4 ++--
 drivers/net/wireguard/peer.h    | 2 +-
 drivers/net/wireguard/receive.c | 2 +-
 drivers/net/wireguard/socket.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlin=
k.c
index 1da7e98d0d509..ec66f79e46377 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -109,9 +109,9 @@ get_peer(struct wg_peer *peer, struct sk_buff *skb, str=
uct dump_ctx *ctx)
 =09=09=09    sizeof(last_handshake), &last_handshake) ||
 =09=09    nla_put_u16(skb, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
 =09=09=09=09peer->persistent_keepalive_interval) ||
-=09=09    nla_put_u64_64bit(skb, WGPEER_A_TX_BYTES, peer->tx_bytes,
+=09=09    nla_put_u64_64bit(skb, WGPEER_A_TX_BYTES, atomic64_read(&peer->t=
x_bytes),
 =09=09=09=09      WGPEER_A_UNSPEC) ||
-=09=09    nla_put_u64_64bit(skb, WGPEER_A_RX_BYTES, peer->rx_bytes,
+=09=09    nla_put_u64_64bit(skb, WGPEER_A_RX_BYTES, atomic64_read(&peer->r=
x_bytes),
 =09=09=09=09      WGPEER_A_UNSPEC) ||
 =09=09    nla_put_u32(skb, WGPEER_A_PROTOCOL_VERSION, 1))
 =09=09=09goto err;
diff --git a/drivers/net/wireguard/peer.h b/drivers/net/wireguard/peer.h
index 718fb42bdac7e..01c4b80086759 100644
--- a/drivers/net/wireguard/peer.h
+++ b/drivers/net/wireguard/peer.h
@@ -49,7 +49,7 @@ struct wg_peer {
 =09struct work_struct transmit_handshake_work, clear_peer_work, transmit_p=
acket_work;
 =09struct cookie latest_cookie;
 =09struct hlist_node pubkey_hash;
-=09u64 rx_bytes, tx_bytes;
+=09atomic64_t rx_bytes, tx_bytes;
 =09struct timer_list timer_retransmit_handshake, timer_send_keepalive;
 =09struct timer_list timer_new_handshake, timer_zero_key_material;
 =09struct timer_list timer_persistent_keepalive;
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receiv=
e.c
index eb8851113654f..500d86576c692 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -20,7 +20,7 @@
 static void update_rx_stats(struct wg_peer *peer, size_t len)
 {
 =09dev_sw_netstats_rx_add(peer->device->dev, len);
-=09peer->rx_bytes +=3D len;
+=09atomic64_add(len, &peer->rx_bytes);
 }
=20
 #define SKB_TYPE_LE32(skb) (((struct message_header *)(skb)->data)->type)
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.=
c
index 0028ef17dc716..9e8a49b9078f2 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -179,7 +179,7 @@ int wg_socket_send_skb_to_peer(struct wg_peer *peer, st=
ruct sk_buff *skb, u8 ds)
 =09else
 =09=09dev_kfree_skb(skb);
 =09if (likely(!ret))
-=09=09peer->tx_bytes +=3D skb_len;
+=09=09atomic64_add(skb_len, &peer->tx_bytes);
 =09read_unlock_bh(&peer->endpoint_lock);
=20
 =09return ret;
--=20
2.53.0


