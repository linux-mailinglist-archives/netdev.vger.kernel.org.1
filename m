Return-Path: <netdev+bounces-282366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOnGGErz8WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:02:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA878493D4F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42F033058614
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB053A4538;
	Wed, 29 Apr 2026 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UXDRdFFC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97A3F6606
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777464093; cv=none; b=DcfaKZfJZbUcdK1kzVzkFFD9u6g5d8L8417098Bsvsd0dRhKsyzboKEY0Iv8GyYKdq7+b6YwvTgJeP+Bex4ytrv3d/9fJ1IJ/Pd00tT9jIFxLOZKiXcZte+GLkwGaAKf/3E+1URlaC2ZL/AOWeu/+SDPPv1W2PcgqBPJ33EAfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777464093; c=relaxed/simple;
	bh=9X3karENUvJWWOp6YL8Q3yo7TDalQ4iGucDcNdkacok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maxjzjLJ+3qpGs/yCaUMOSGOPC4NZTGvkifvcJGE/l8rbLrlIIkP5Y00iim7BkGx9KpK6PFNvOXPp5oDsB6+EuVNr7t6Z3nWuxT+E2haTCFbQY8zafmffWpkgzZCWB54t1nWKte0EOOg6xhYnaG0Idg+PrbSpqEoJOqrmV1HjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UXDRdFFC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso96725215e9.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1777464088; x=1778068888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ChWq9HAaUou11S+bBoGkNciymz65d09xVXiU775VAE=;
        b=UXDRdFFCmzKLu1TLHJ7bKBHUmUlOZNoSo4BB5a89KhBMl/Wq3w24wGXZzpRCztzumC
         ZgOnJLN6y5Vbi+QtcKeGTuydP+1hGbPsNyjiZ5VenDIksbBK+ih2sFXEsJ0h8iK00SQ8
         xf55vj8qkRO2f7aWFIQDrTBNf4zOmc0wsEy6mX6seQod55HY6Fskta1LsxvJ3bZ0KLBk
         CTxUVD64gxTER6f2+Rtk7pVasiopuYRs49Qji7uSJBYNz//HH046BqkYZ082l6SaqFJT
         aVqt06bf/UvFlb5nk3M2gRDOhtxrkcbDBJbDtEbqugXGVNeiA1qiv3MhFOTVIeYkb6lw
         ntPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777464088; x=1778068888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ChWq9HAaUou11S+bBoGkNciymz65d09xVXiU775VAE=;
        b=Eg13CXfHvUSMVt4nHYju0oa9+d/jYSz38bN5HvQZVnFETb7kFsxUc9SHq047mP7s3i
         fkqbr0ikvr7PTFIuovhGMHyeHfF6MeltsTgDAIsg7sb/SeVZ/l4q+2XuJA8mLSwZ+oOn
         ux1XspYtn6Ozs2VAADnYj03qg9iD9XDjoaDiCjKvdPmtdQ1sx37JJr0KEs4taH8MSzv7
         EKI9AoxoHKK8pYzMJaP3+tVVA0qhyXDS5gvVoWmfRTA5mfAlKKOsaxJg4W6Pie4K14eo
         OBjnmEr9Qnt/7vo2i9GjkocyCieZPpkWIIR1lk1z3ryByrl+JIv+E8dpkFYQBdq+zpVN
         kvGQ==
X-Gm-Message-State: AOJu0YzWkIx/4q+xSt/jIwbosh7TKn+QfSTiJKnilEXjeYmtmerj8I4b
	LqarxG7Iho3NOVgMzTdol6tAxxuFhOQ4cnoRqHP1dVIxO9E/Ujs6uRgyQ0ktwp9v/AD9Gw2xfvV
	tgT0Fl1cqjBOLcbDRPH0uAk9Cuo6G3vPM7P+xZ+6YEhTnIQTAE8XmaSzKdGdArtNphNo=
X-Gm-Gg: AeBDievO0uKkhL1+T2HNfCWVvWX+rIbwsfysRcspinogSe7ON+FSLSkujxbIWOig9oz
	Tdb7l1yGaAo/L56fc75u67HEf005bxzuwhO7RBBrbJsITRfUOM2jJRhJjPJlObAkz4l3YZWlz0S
	zUjUB/Y9TYX1rJzjqEulQ2alVyStUt3/3t8+P5BMkqLq1NXyXD4/HlyuIxJxX7CYj5ESktjICDv
	Geq2fFjuRxwgmOcEi9wvPAbfwrUFFYe1cGBcJBcOsBqW9prsuelyOQYvA1xFYrMHGt11nwFjP8s
	GVtXKNkbmI7GEQqKUT8Q51iET58ou1WJasPqN6gpiFGq7VC0z2ZNZU5lkrGLdhReNkTVe+kVSxP
	7Bfos4FOmvzehggdkFjgJbCqeWTn1y2F9UiB/XyxwClTQanD0JOLiz0Se7MPbJC0y1Zb9PaVq/2
	CfrlBtoq/5noZUFTMaqHAmwIzLQiZPKaGOQNTwdmYzSiCNM/K1tZmCWVW1dw==
X-Received: by 2002:a05:600c:1d1a:b0:489:1c1f:35f9 with SMTP id 5b1f17b1804b1-48a77afd2a5mr115164675e9.9.1777464088246;
        Wed, 29 Apr 2026 05:01:28 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:1b06:3877:bfc9:c6ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c1c2b37sm31361275e9.1.2026.04.29.05.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:01:27 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 2/2] ovpn: ensure gro_cells_receive() is invoked with BH disabled
Date: Wed, 29 Apr 2026 14:01:20 +0200
Message-ID: <20260429120120.514491-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429120120.514491-1-antonio@openvpn.net>
References: <20260429120120.514491-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CA878493D4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282366-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:email,openvpn.net:dkim,openvpn.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mandelbit.com:email]

From: Ralf Lici <ralf@mandelbit.com>

ovpn injects decrypted packets into the netdev RX path through
ovpn_netdev_write() -> gro_cells_receive().
In case of TCP connections, that injection path can be reached
from either softirq or process context.

However, gro_cells_receive() expects to be invoked in softirq
context to avoid racing its lock acquisition.

When being invoked from process context, we must ensure BH are
disabled to safeguard gro_cells_receive() assumption.

As of now this is not the case and the following WARNING is
triggered:

  [  230.183747][   T12] WARNING: net/core/gro_cells.c:30 at gro_cells_receive+0x708/0xaa0, CPU#1: kworker/u16:0/12

Moreover, not disabling BH was also triggering lockdep, which was
reporting a potential deadlock in case of concurrent softirq and
process context gro_cells->bh_lock acquisition (i.e in case of
concurrent UDP and TCP connection for the same ovpn interface):

  WARNING: inconsistent lock state
  7.0.0-rc4+ #246 Tainted: G        W
  --------------------------------
  inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.

Fix all this by invoking local_bh_disable/enable() around
gro_cells_receive().

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index d92bb87be2b2..c0fdb9504241 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -91,7 +91,13 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 
 	/* cause packet to be "received" by the interface */
 	pkt_len = skb->len;
+	/* we may get here in process context in case of TCP connections,
+	 * therefore we have to disable BHs to ensure gro_cells_receive()
+	 * doesn't enter deadlock
+	 */
+	local_bh_disable();
 	ret = gro_cells_receive(&peer->ovpn->gro_cells, skb);
+	local_bh_enable();
 	if (likely(ret == NET_RX_SUCCESS)) {
 		/* update RX stats with the size of decrypted packet */
 		ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
-- 
2.53.0


