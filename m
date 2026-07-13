Return-Path: <netdev+bounces-307269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nsrGEiNAVWpcmAAAu9opvQ
	(envelope-from <netdev+bounces-307269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:44:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9842674ED8D
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:44:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b="ZEka/sdd";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307269-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307269-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 683B9311D86A
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D82A35AC1E;
	Mon, 13 Jul 2026 19:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98178359A6C
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 19:40:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971623; cv=none; b=WdBQ08hqy+SdV5Vw2eqvyxRbrfwfcEUQd3+J7v4CBCewjRvQcrL87IZbmyx22dZ3ADXYlcleYgYFvz36ZbucYU0a3DunqtiqoTuXcbgcHo9eTcBM//atYq0yOtPCpxctvXtRL/ygWcv2MguTrkYdeP3J5O1F9hsqzdd2aPRGz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971623; c=relaxed/simple;
	bh=ZElYX+gf59pRPgluKzpGvx9WiCEsZq+Swc8cluTkDzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li4jwEahM5uUuLxRu1maCaKdpid2sw9IZ37wWPedDwz0rKzNt+39l1Qx9hYbJ8ccMqoo5EoPCYmnBaPHLbG00nbLG55vGcVbkXZkGlJ69/Y719K5+e8RvYNtDcM/1rXfv/dhJBoH4uQ7IdDg4JhASljuYj8Y9kvmV6e22VMVn2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=ZEka/sdd; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso2183916f8f.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783971618; x=1784576418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Anq+ZgEfX5t6X9Q7TePAbPIwtsyngsq62Z1m8/YM/k=;
        b=ZEka/sddEpto7RUMFCIQb5azkrkfoCdYr8etYSkVMWZO4ISCu/iad8n56x1S3UkYt7
         XpNtEycCBk0zqhZUN8/F4j8Q+gleArHpn8qeMlXD6G55tv73Yt7JZcg5Y+4AiJ5Imydu
         yhTc0xH4X0s4HZK7NOph4LgugRFZ0eCK2hk2cR5qA8yqzVNwpJ2VTgDpWswdoC4DwrZe
         7Jvn4MuqaMmjuqwveOJiuZbv1MTGRHm4iiAuIttR9wVV4gx1DveX7VerssR79FE7USfT
         ivHn4PH/Yt4RQGEf0GdB/hQ/jDHWNfL3EOfCX9HaWKEp4tvffW2fmOxelNeZA+EV+Gjj
         OQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971618; x=1784576418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Anq+ZgEfX5t6X9Q7TePAbPIwtsyngsq62Z1m8/YM/k=;
        b=OhaUOv387Ykz3uFk91mY4QLR01GIKZ0Zfh3mz50PfgZ3F7wTNxMVRyAxlC/Cs8pvqI
         CFChb7M4thReLqLIwps25fvQd+WOU6xljsWfpyoD4h76l0E4Ox1Nji0JEjfQyF2Xtdqe
         5vNPiP7x7IG4A4BWjw6lhQoDV4vTKaRENzm7z7xa39PfCvGnsHRMGuz+fblQuBJA0CNb
         uWdu+X52qeVuttkyiMNkjxXqbAnYtc9cZnI0BmrAqIOg/d3MNd0OdpU3o4zYg6VcaN0J
         Z7RG0Vl2OUYp2CvGJ+C6ZlE5fYLh0y2pex6ueOBHBMDPwyLnyZ4/cwENipwk5i/Tsjdd
         6RIA==
X-Gm-Message-State: AOJu0Yzinqk265t7AXZAvsMrs7aDC0T94DnTYqQ0pb89row/O8U/O5LF
	/k+eCfbEc+E1j2z3dgJXe2Xg2mg/HmeKVhIflvUlWGpYvt+oKTYGFmIbFecgcHPIPICH
X-Gm-Gg: AfdE7ckEd53mQ0yQ1dUMKChBFGM6xKeEZYM/YMzSvWt8ULR7D8B3igEqo9HsaDqcWuz
	Ibz/GHEfxcqZyFjZUaNcYmslc7PzYZSc9DvT6ASQxhG3BhyaF38M0A4xIkbfHeYeYiMYLiY5cYY
	lE12Au3losl6BXTGsIs5yallh0uK0dE55ILfwKB5Ye1AgDd8ZhBnXznMKx1NU2GPk6VDVrREMRt
	gd4fQbLEJBGQCl1+HOEMvDqAKDmV9AY7E5maV5CiZnRK/6tV7Gb7d/n+N3QoCWoyHxt/+ZIC+wR
	iwOLn+CrLVShJ6vj5v4Mf+5p6KL9+XwuuVdOoekFvk2eF/b4pIGXSOGP2tPkyFEu2u6pYRPbt7f
	6mkAhNTeCa/WZh5GyqvcMXVRApeHTTLWczB9CuFnzRYXiveNA//Ou5XSDh0WavSXHIx3fCyZ81g
	kNwKCh5Wkgd9KzgC9b3zhaJgOEeQCZPlFgaR83AC3p4fiL+Z1hMKJcKiYyiGl18IpW+JEX25821
	qfzofcgyuq/+rJQHq3c7C4lO1poE5KfMlfIMV2nnreVWA==
X-Received: by 2002:a05:6000:2908:b0:46d:9871:1a44 with SMTP id ffacd0b85a97d-47f2dcc5c1amr11070214f8f.32.1783971617968;
        Mon, 13 Jul 2026 12:40:17 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm1648928f8f.32.2026.07.13.12.40.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 12:40:17 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Nick Child <nnac123@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net 2/3] net: dsa: tag_ksz: don't read an unset MAC header in lan937x_xmit()
Date: Mon, 13 Jul 2026 21:40:09 +0200
Message-ID: <20260713194010.54642-3-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713194010.54642-1-doruk@0sec.ai>
References: <20260713194010.54642-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307269-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:andrew+netdev@lunn.ch,m:f.fainelli@gmail.com,m:woojung.huh@microchip.com,m:nnac123@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:sd@queasysnail.net,m:arun.ramadoss@microchip.com,m:UNGLinuxDriver@microchip.com,m:mpe@ellerman.id.au,m:doruk@0sec.ai,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,microchip.com,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0sec.ai:email,0sec.ai:dkim,0sec.ai:url,0sec.ai:from_mime,0sec.ai:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9842674ED8D

lan937x_xmit() reads the Ethernet header via eth_hdr(skb) to test the
destination address. The sibling xmit paths in this file (ksz8795_xmit,
ksz9477_xmit, ksz9893_xmit) already use skb_eth_hdr(); lan937x_xmit() is
the lone hold-out.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
resolves to skb->head + (u16)~0 and the read is out of bounds.

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
done for the same class by
commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").

Fixes: 092f875131dc ("net: dsa: tag_ksz: add tag handling for Microchip LAN937x")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/dsa/tag_ksz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 67fa89f102e0..4f74336ae396 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -430,7 +430,7 @@ static struct sk_buff *lan937x_xmit(struct sk_buff *skb,
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
 	struct dsa_port *dp = dsa_user_to_port(dev);
-	const struct ethhdr *hdr = eth_hdr(skb);
+	const struct ethhdr *hdr = skb_eth_hdr(skb);
 	__be16 *tag;
 	u16 val;
 
-- 
2.43.0


