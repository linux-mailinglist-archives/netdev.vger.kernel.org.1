Return-Path: <netdev+bounces-189152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E9AB0B75
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D254C1FDD
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 07:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFFC26C39F;
	Fri,  9 May 2025 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzFYO32x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0A8F64;
	Fri,  9 May 2025 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746775135; cv=none; b=iCVEWteXdTZKBzbUUJZBY30u2oWtEMiuhMlMEdkPMZildVbWsBGM8FKd09wAeKBlWNOEDexErhczL9VqjwwAROlbgq2KMma2P/IqWzdMGWmgidWHKirCKTY2sr4DsCF7Aiqq84CWE8xjkzk87SrVf/AfcbA0QLPKMMZ7Tizh0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746775135; c=relaxed/simple;
	bh=0bpkn16FlO8guV0JpiDuN0GhJ+8MVxdY1+nhUi7V2+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B/TG1pZ4TcUagy3bDUYuiFD3QtUUTNipvwIKcLCrQjQhZTbji8/TIRgjhCsslIc4lNHxqxs1RULSyVf4sBY9ybLwJsYpDBCpY+TNvdsH1WoCTuFnIz9TBcEn6e2B5DYCn7K/yuUV61w86xQyHSpINmNbqhbM9+pY12hjXnjZdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzFYO32x; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fbeadf2275so3227695a12.2;
        Fri, 09 May 2025 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746775132; x=1747379932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PTO5iMS3MJa+j0YRv176Z6nGa9ottE/kWMAQs3ZREo=;
        b=AzFYO32xs1Fcz6WLi0G1XlFGCfFUaK2Ni4J77h8x3AVLRdZI9YUH20wIglEQgvdbkf
         kvBgeQJmSA5iqsnQEeiq/SMZvEvAXgUFQToECI5KXEIImV6aCpJipGJe8jSfSnVW7XDO
         7LilcNNXf8HHC/WJAy62A18VdCQZZa/kJ0q/zmI0dCPOZ++1hMD8eGsx+AJ/2z8X5yQZ
         C15cvm8SfMWn02e4tnHjpMxV6UTcRkHeqFL6Jce4vf4n1YnuSo2naFWkuvkWmO1zhhft
         eUQmD4VM3vLctitzAVjLbWMihd5+EDd076fw7ZFnTUBCuKIJwG6kpN2jN9UkrZUu5OCQ
         iRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746775132; x=1747379932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PTO5iMS3MJa+j0YRv176Z6nGa9ottE/kWMAQs3ZREo=;
        b=iJrCO+UekHTsaeU+T3aS6FRPNbpQ+tOk8Det3AdhszrREnKUW9DVJ3iftEe2uLnMzk
         UVQRB/32VrapWNjLkqcoDNmUz1Ax1qwVHtIpWKeS64Du+x6MWq2u0ECgecCYQFqXfSNd
         MahrMUWdllsiAOVFw0ocyFDH2R+r+GmjhT+ZS9sjr0pE6DJMG9408OAtMkYvHVAh7mIT
         WZbLiAeJK1UrkgKqDmeTixZWey03Q5m8J/J2f/wag2ffmglmcLoST2va0BUnp+wXDLAg
         UMlIXntTfxZB5nbTiGy3df0Du9+L04RmlY/RVLDTq/NORlae7rES242UyqqT3LWZQ8Bx
         9fcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUytrhjEEntLEIuM2VssCquCRCwYKETnYuubca2JwqxSRSqWCwFCVdHbRQtv5W1Hm9dKEPNOrZp@vger.kernel.org, AJvYcCXE9SiJ/yBO5ojz6/wjR6bo8hUl+2qr7wp3uqR3tVukoNgcskTWUWn7V3FeK27gfJWCdbg8ji81RzTxwPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1bAuOxGN7SyTPNgQikIAFGaz0178WBGRBj9PvaLEXd3oFaNOq
	EfWkJl6DvppB5p5iqwmP+HJvCnLkerR+gTjAvds0YLZpdMpmC6RQ
X-Gm-Gg: ASbGncu2nM/bkiYGHPfk738F1OaXOoHTSOl3nsmsOxvy2zU68LPf+Xo2RgxwH5MysR5
	gm70B6Ul1QiogpOdN27Xa2dXsD4dh5os9GtpK6ngEfVkh7jm/s1Wn7YySd1qDLF2Q+GZzHKTJB1
	/qaF6zYl2jBQiL4pcKjtvf3umHQAesPQfdCKPedZpbgLSGlH0Ry5bgFzZP3Q3B3RlfehRTR03hE
	7vWGyxECao3u/riG7d6HM664iyHoah36qmFGZixqzfa6k/x6PN9MIVSvaW4qEt3AzNXIcWNKk1Z
	7aW476uYy33m6B1uuSVg9dQFS9CmQBSIJxtXShN4qB6gxqKkfUEq8M0UcDrgPgxD7Psdb8V1DWU
	t7ICZlOeKp47b3tEoSzk=
X-Google-Smtp-Source: AGHT+IGDdYgrjPJ7ZsaLGSh3Fj2BAgV3yPukGQ/Cd+owAdD4qw418l6Yt2BNI0eGtYS9qF3kyBVs/Q==
X-Received: by 2002:a05:6402:2396:b0:5fc:a51b:9358 with SMTP id 4fb4d7f45d1cf-5fca51b95femr1047572a12.15.1746775131958;
        Fri, 09 May 2025 00:18:51 -0700 (PDT)
Received: from localhost.localdomain (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d70e296sm960777a12.75.2025.05.09.00.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:18:51 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: quentin.schulz@cherry.de,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: microchip: linearize skb for tail-tagging switches
Date: Fri,  9 May 2025 09:18:19 +0200
Message-Id: <20250509071820.4100022-1-jakob.unterwurzacher@cherry.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer arithmentic for accessing the tail tag does not
seem to handle nonlinear skbs.

For nonlinear skbs, it reads uninitialized memory inside the
skb headroom, essentially randomizing the tag, breaking user
traffic.

Example where ksz9477_rcv thinks that the packet from port 1 comes
from port 6 (which does not exist for the ksz9896 that's in use),
dropping the packet. Debug prints added by me (not included in
this patch):

	[  256.645337] ksz9477_rcv:323 tag0=6
	[  256.645349] skb len=47 headroom=78 headlen=0 tailroom=0
	               mac=(64,14) mac_len=14 net=(78,0) trans=78
	               shinfo(txflags=0 nr_frags=1 gso(size=0 type=0 segs=0))
	               csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
	               hash(0x0 sw=0 l4=0) proto=0x00f8 pkttype=1 iif=3
	               priority=0x0 mark=0x0 alloc_cpu=0 vlan_all=0x0
	               encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
	[  256.645377] dev name=end1 feat=0x0002e10200114bb3
	[  256.645386] skb headroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	[  256.645395] skb headroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	[  256.645403] skb headroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	[  256.645411] skb headroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	[  256.645420] skb headroom: 00000040: ff ff ff ff ff ff 00 1c 19 f2 e2 db 08 06
	[  256.645428] skb frag:     00000000: 00 01 08 00 06 04 00 01 00 1c 19 f2 e2 db 0a 02
	[  256.645436] skb frag:     00000010: 00 83 00 00 00 00 00 00 0a 02 a0 2f 00 00 00 00
	[  256.645444] skb frag:     00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
	[  256.645452] ksz_common_rcv:92 dsa_conduit_find_user returned NULL

Call skb_linearize before trying to access the tag.

This patch fixes ksz9477_rcv which is used by the ksz9896 I have at
hand, and also applies the same fix to ksz8795_rcv which seems to have
the same problem.

Tested on v6.12.19 and today's master (d76bb1ebb5587f66b).

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
 net/dsa/tag_ksz.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index c33d4bf17929..7fbcdb7f152a 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -140,7 +140,12 @@ static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
 {
-	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 
 	return ksz_common_rcv(skb, dev, tag[0] & KSZ8795_TAIL_TAG_EG_PORT_M,
 			      KSZ_EGRESS_TAG_LEN);
@@ -311,8 +316,13 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 
 static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev)
 {
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
 	/* Tag decoding */
-	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 	unsigned int port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 	unsigned int len = KSZ_EGRESS_TAG_LEN;
 
-- 
2.39.5


