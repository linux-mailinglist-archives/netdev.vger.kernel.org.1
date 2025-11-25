Return-Path: <netdev+bounces-241428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03653C83CC4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C69B34C424
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB00B2DC32A;
	Tue, 25 Nov 2025 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHALn+Bb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C72D97B8
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057131; cv=none; b=DxhrrscAyL11wqGA3+eu0YEZexUhp4k+HmkzippHJRdxwF5J1LxpZBKzNNMmwQXj6vQxVey81hz/vBR2NsJWPjy2v9bbOe2FsTfY0OGSuq7aP2DmjfmtA521NCRLWHh/BcdagqyrcvhngK5oIej3ycD9n3Wp7lD1OE7fU6NXBco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057131; c=relaxed/simple;
	bh=Nvfu7MM5pHEDLKIO/mlFFCj+GO54Sm9aobXGKhtPtE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac4w/Vx78pRSSAM/LSUf/9kpx0fDkKW4aYZROfVFPnVMnpwuvEHSzCeEwZm57BtbBf6NIyU39/urndwrcOZ4IdcRqNpnXfsEV6uMXbi4owbN9d/Rtw/9Cu370ukwpl0NyMaOEBP+Bb+9rCVMykgokyQQLAOKE7OSmXD5W0/r7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHALn+Bb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so7237981a12.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 23:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764057128; x=1764661928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cLF6OW+2TrUATylsfca7SRjZ4XkxUire7MR3XBf0nc=;
        b=EHALn+BbgPfKg8yjgyzLBLA7SfWKDsd+nm6mfuldWcgYSaZ11kO+Q6iiA24vYBh5eH
         ol+qcwlPlQP0lduPceSrkl3e1rvglZ+LvPknuv39Pc23an2e0TZjDnhktWVn8nT94B3k
         xROqQnYp8FtHO8OPPTD8gC8psV0JJQRqRbutlhI3pwMNTUJ+VVw3U28nbZN23mHcl4vt
         JWrHT8V3++qHk7Su8JLxe18CP0jAdpnq48Ned9XW3Pz5/safCnNARuDI6bT+SOkWHLdD
         SGuaZbJi/KjOjHdG6jXFPP8spd5uoX9HtqLT0P+5COn+tYsAuV4oKoXowVBFkIo8Hm/Q
         depA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764057128; x=1764661928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cLF6OW+2TrUATylsfca7SRjZ4XkxUire7MR3XBf0nc=;
        b=uLVldJs4AYQsy8TetjNenY+f2rZkcChfn3aES7F0Sup05JfFTZ6qKFDcep/KJgCPDK
         YYMmsPdOCb5EifixRd1047nFNikgYa049lz5pI61hkxDIVTlQCH8PZN9T4XZSFs+za+A
         hRz8nfEY3Skg4JQpEA2mWFkvUpcfv4kpbMnQzPI8E47mlKVh+Ow/k4K6xKdgthLvPrB2
         nXt7WaRLG3AGmfzMdweJl/cOIwC1TCfyz52danZT2Aw5WjjQqCXoZODE32t+OY+pbwjX
         SW5fImF7RURUHdncrg8QnBh9CA+6rBF6dAcUKNiNxJJaqy69bZ0xkoS8XL/Sc8JKjLOw
         OmcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmZi8SmTaGFx7C8al4sgB1dmYhwQuNnL1ex9C5+/EvMfO1iw9ZYWZYYCEkHGjNOmGzKb3gSpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDy9h49QrXsJh23jRwOjSAviXzAyq+Wr7rjuVCqZbXWC6NvINl
	Cdn0KCn54qXuxATH7PHwjWfg+E7I/lri9fp9AER2Fr63KHJ0MLXrzsuY
X-Gm-Gg: ASbGncsy/lWSoacgxLyJfp97A6fo4WHfyxxeQoA8Eq8FHmxnFaZ84ttBdj1l9PG7kvX
	6W+B3UTH9gUgxwKiPIl3eySje44wTdEgs5vdHnvIQUys7MzO3ciQ3oIlfIcrIyPlyihDjIbMr1n
	bdVGjyt87do+9MSMqFOHV8NDFm1lomMLrFLH56EaG14D2uZd6GTrCukP29n9+kzKgZr/A/K1719
	t+C5as84NioKDBaw3q0rLrcDTHtqTiQGHkYAchJR9JIGBGiUDvF3RYv4094ELAdEutcN4JnPtLw
	YYbtalVNO8SwIMCFVFrptTNfocjyps4BaQ7VoOkFMEC9ScbDdVhrVTj0Ghiweor6qTSxeLM+zrJ
	xBR0bY3SooMPqha0gNCIgnt8kNGoxGCuZrh4SS8Cw/iYi5C9JTeC/61EJ8TvaVRD0OVdjTnwR6z
	K8gM0tlUZuI5zJIRmECUbYC/esPVaUcBeGkhj+h4baDrA/82XPaNGU4ApP48nqEK5b2K8=
X-Google-Smtp-Source: AGHT+IGyoTxPMMJ9r04O6fUQyypFHVb2CsZTh5pjSnqd6/53xcOrWoq/NvrC4HH7fZ1Tgl32q5x1UQ==
X-Received: by 2002:a05:6402:2348:b0:640:80cc:f08e with SMTP id 4fb4d7f45d1cf-645eb78686cmr1637901a12.26.1764057127790;
        Mon, 24 Nov 2025 23:52:07 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d307sm14469110a12.19.2025.11.24.23.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 23:52:07 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/7] net: dsa: b53: fix BCM5325/65 ARL entry multicast port masks
Date: Tue, 25 Nov 2025 08:51:48 +0100
Message-ID: <20251125075150.13879-6-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125075150.13879-1-jonas.gorski@gmail.com>
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently use the mask 0xf for writing and reading b53_entry::port,
but this is only correct for unicast ARL entries. Multicast ARL entries
use a bitmask, and 0xf is not enough space for ports > 3, which includes
the CPU port.

So extend the mask accordingly to also fit port 4 (bit 4) and MII (bit
5). According to the datasheet the multicast port mask is [60:48],
making it 12 bit wide, but bits 60-55 are reserved anyway, and collide
with the priority field at [60:59], so I am not sure if this is valid.
Therefore leave it at the actual used range, [53:48].

The ARL search result register differs a bit, and there the mask is only
[52:48], so only spanning the user ports. The MII port bit is
contained in the Search Result Extension register. So create a separate
search result parse function that properly handles this.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c |  4 +++-
 drivers/net/dsa/b53/b53_priv.h   | 25 +++++++++++++++++++++----
 drivers/net/dsa/b53/b53_regs.h   |  8 +++++++-
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 91b0b4de475f..09a64812cd84 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2119,10 +2119,12 @@ static void b53_arl_search_read_25(struct b53_device *dev, u8 idx,
 				   struct b53_arl_entry *ent)
 {
 	u64 mac_vid;
+	u8 ext;
 
+	b53_read8(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSLT_EXT_25, &ext);
 	b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_25,
 		   &mac_vid);
-	b53_arl_to_entry_25(ent, mac_vid);
+	b53_arl_search_to_entry_25(ent, mac_vid, ext);
 }
 
 static void b53_arl_search_read_89(struct b53_device *dev, u8 idx,
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index bd821d60ac90..24df3ab64395 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -348,8 +348,8 @@ static inline void b53_arl_to_entry_25(struct b53_arl_entry *ent,
 	ent->is_age = !!(mac_vid & ARLTBL_AGE_25);
 	ent->is_static = !!(mac_vid & ARLTBL_STATIC_25);
 	u64_to_ether_addr(mac_vid, ent->mac);
-	ent->port = (mac_vid >> ARLTBL_DATA_PORT_ID_S_25) &
-		     ARLTBL_DATA_PORT_ID_MASK_25;
+	ent->port = (mac_vid & ARLTBL_DATA_PORT_ID_MASK_25) >>
+		     ARLTBL_DATA_PORT_ID_S_25;
 	if (!is_multicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT)
 		ent->port = B53_CPU_PORT_25;
 	ent->vid = (mac_vid >> ARLTBL_VID_S_65) & ARLTBL_VID_MASK_25;
@@ -388,8 +388,8 @@ static inline void b53_arl_from_entry_25(u64 *mac_vid,
 	if (!is_multicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT_25)
 		*mac_vid |= (u64)B53_CPU_PORT << ARLTBL_DATA_PORT_ID_S_25;
 	else
-		*mac_vid |= (u64)(ent->port & ARLTBL_DATA_PORT_ID_MASK_25) <<
-				  ARLTBL_DATA_PORT_ID_S_25;
+		*mac_vid |= ((u64)ent->port << ARLTBL_DATA_PORT_ID_S_25) &
+			    ARLTBL_DATA_PORT_ID_MASK_25;
 	*mac_vid |= (u64)(ent->vid & ARLTBL_VID_MASK_25) <<
 			  ARLTBL_VID_S_65;
 	if (ent->is_valid)
@@ -414,6 +414,23 @@ static inline void b53_arl_from_entry_89(u64 *mac_vid, u32 *fwd_entry,
 		*fwd_entry |= ARLTBL_AGE_89;
 }
 
+static inline void b53_arl_search_to_entry_25(struct b53_arl_entry *ent,
+					      u64 mac_vid, u8 ext)
+{
+	memset(ent, 0, sizeof(*ent));
+	ent->is_valid = !!(mac_vid & ARLTBL_VALID_25);
+	ent->is_age = !!(mac_vid & ARLTBL_AGE_25);
+	ent->is_static = !!(mac_vid & ARLTBL_STATIC_25);
+	u64_to_ether_addr(mac_vid, ent->mac);
+	ent->vid = (mac_vid >> ARLTBL_VID_S_65) & ARLTBL_VID_MASK_25;
+	ent->port = (mac_vid & ARL_SRCH_RSLT_PORT_ID_MASK_25) >>
+		    ARL_SRCH_RSLT_PORT_ID_S_25;
+	if (is_multicast_ether_addr(ent->mac) && (ext & ARL_SRCH_RSLT_EXT_MC_MII))
+		ent->port |= BIT(B53_CPU_PORT_25);
+	else if (!is_multicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT)
+		ent->port = B53_CPU_PORT_25;
+}
+
 static inline void b53_arl_search_to_entry_63xx(struct b53_arl_entry *ent,
 						u64 mac_vid, u16 fwd_entry)
 {
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 505979102ed5..54b1016eb7eb 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -332,7 +332,7 @@
 #define   ARLTBL_VID_MASK_25		0xff
 #define   ARLTBL_VID_MASK		0xfff
 #define   ARLTBL_DATA_PORT_ID_S_25	48
-#define   ARLTBL_DATA_PORT_ID_MASK_25	0xf
+#define   ARLTBL_DATA_PORT_ID_MASK_25	GENMASK_ULL(53, 48)
 #define   ARLTBL_VID_S_65		53
 #define   ARLTBL_AGE_25			BIT_ULL(61)
 #define   ARLTBL_STATIC_25		BIT_ULL(62)
@@ -378,6 +378,12 @@
 
 /* Single register search result on 5325/5365 */
 #define B53_ARL_SRCH_RSTL_0_MACVID_25	0x24
+#define   ARL_SRCH_RSLT_PORT_ID_S_25	48
+#define   ARL_SRCH_RSLT_PORT_ID_MASK_25	GENMASK_ULL(52, 48)
+
+/* BCM5325/5365 Search result extend register (8 bit) */
+#define B53_ARL_SRCH_RSLT_EXT_25	0x2c
+#define   ARL_SRCH_RSLT_EXT_MC_MII	BIT(2)
 
 /* ARL Search Data Result (32 bit) */
 #define B53_ARL_SRCH_RSTL_0		0x68
-- 
2.43.0


