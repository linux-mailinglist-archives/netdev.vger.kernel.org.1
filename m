Return-Path: <netdev+bounces-242511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8945C9118C
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D053A275B
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34E2E9759;
	Fri, 28 Nov 2025 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMveoSW7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F732E7F1D
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317209; cv=none; b=D+gVvuHvG9Qi2k+QKROW+pVrjYU7sHOst/ALK9NOPrUleXY7r8qaaC5e8HO8e7WzZCbiYOxUAdt/mYZj3m6Syrsm7rjJ8JY//ylfuIR8ycdlo7QykGY1AbN0ZACqtF3+0ULHINS/ww9u9pD+GKlQE4bH0qScn7fhjk/ggawAVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317209; c=relaxed/simple;
	bh=YoEpu4LLgmyvg6uR8vGP8DRlBZ1dUR7rfJAUV0XOx/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HweK+apARED/zHW2/nuyEPP37Gf82xMtgvLthi0dGPXWTNdPtoHWnwwc/wmczlakLvDj3tlxgLSp79bhndsJwNuGSVt2tSfdgI2QBgmTwVa4cOxLBvujFkcUTzCWFhTdEjTmM/zY39Wc7qEgkY0cfn2ASZS81lOoxJ3+n/a5nio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMveoSW7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b72bf7e703fso283244166b.2
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764317206; x=1764922006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTeNK2aPj9lGYXJg2ZeiumJ8UHiV1+byQcRUQv3qjGw=;
        b=FMveoSW7cjuAV27pfw84g+2ES7E37oyhvymDNDULRlG1prq9ZXUHbkUnQS8CDpEypt
         q/qwG+7/TSEHUuf3O+6RojWcU4UHaDBVkHD1kYp6y/35YZ1oqwR1LHzIfqBLGl4AUvcc
         fyyG8rAd2MA1/+qyH37wD2GggPXgOWGYwD3ZKqtopwYjMVCS1aVciYck50glxESbdvb6
         OqnELxxmV9K1JcKLte1PbdwQ2yERhc0+oZK7RaU+Tfx+ST6hjrtd5JwcmsmAB51UglbX
         9uiR9+Mi/2sKRnyQo+208xYMGlPuxRtQWi/u8aSghY0J9p7a5feDKk/DS4O8JeumSOc0
         qz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317206; x=1764922006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTeNK2aPj9lGYXJg2ZeiumJ8UHiV1+byQcRUQv3qjGw=;
        b=qrRoni2yteGgTo7zfnqE5+hm5DifE1bUeHubmAwybWsOC3eecq+/kB/6wsZxuOmq2F
         zc+tdV0FcFBtJXfEOGlO4XKO7epUKPnUQgIVMMIZQ66crxu19mU8wftyFzPqWj+1GwrT
         T5+RA9u/1phzybyrvO0eSqJgDlms+OTyDokZyDXeLEuiwf2irNGwtXNzSONPx49AFOpf
         4WkNM9lPebRw0aIT9pcbImLzAetF74SSXfsqULHo6a/W4gQgQbFVV7K7RbWKcvhiG9ip
         E9gzbk9+kgdCp8XTrSROGUyEZLcy1vzUjP/iZnLpkIS3NNWNNYcWCIBG4QAlgfnqNq+e
         y4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCU1q+PjhT9dENl9jDi5g1sjzOKS29ys8873zL7VtAjU9DM0W6GWoLRMeMSjBxgy1t4P9BdPMXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFPXrxltcv6AFPWBT9Nom9U+onZqVRk/cFqxUpIA9lh5an8dIw
	l2qds0eb+DynWXV64N+oub7RlNVQ8or6jb74sg2wvpD7AzktcJxl2XBI
X-Gm-Gg: ASbGncvsU+irIQazf/jIRCJXLvtzCZvFsPjj7hz24kBjNbBBOk5/JbA9/mCIPoSnFmV
	9oXarncXoO9S8r9jGeXVkTQzdQZDGdNWx+fEsJbns25ZMREdBqXGTF8JCV5TEEx15kLeOU45bo4
	HCZ0r+YJwKx6Brzhu1HosNARLgETuyT1eg5jnY71tR9zsXd/r86PJyIfQhyLFdUQP6woX5fSTWW
	Pjlw3gmNUyas1cgc1jQfuA1OnrN/rT1KmnLtlbQtltRZSBer7sWpfPiBnvxaFklS9pENBU9SbMn
	/85Z41NvyAikmWLFqzyKdgRHDdGbQRJYM9zip3wnulpU/OFA0OLpPV2o9iI/mJvXxK33OP9/0iE
	rrerSbtHqs3xBjcnsg0i+ewGNe1M94KmSLx2mzBDiv3QI5QKUp0sjJSgZvOVo2FmuKYtij1l+wX
	ae8i2+UyF6n/wAgAXkLyiKWdw6g2N09QnkEdJiasT0bQ/7Voc1EW5U8ChN4hbC8O3xMjI=
X-Google-Smtp-Source: AGHT+IH7nU8AOL5x+a/3Q11acHdLE+U/kwyWxUsIRL445ue9LpTHuAxa2dyVH8VJRBHo6dsCGgbXtg==
X-Received: by 2002:a17:907:1b02:b0:b40:b54d:e687 with SMTP id a640c23a62f3a-b7671acc2d5mr2970835666b.47.1764317205840;
        Fri, 28 Nov 2025 00:06:45 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162bb6sm389506866b.12.2025.11.28.00.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:06:45 -0800 (PST)
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
Subject: [PATCH net-next v2 5/7] net: dsa: b53: fix BCM5325/65 ARL entry multicast port masks
Date: Fri, 28 Nov 2025 09:06:23 +0100
Message-ID: <20251128080625.27181-6-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128080625.27181-1-jonas.gorski@gmail.com>
References: <20251128080625.27181-1-jonas.gorski@gmail.com>
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
 * added Review tag from Florian

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
index ae2c615c088e..f4afbfcc345e 100644
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
 	if (is_unicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT)
 		ent->port = B53_CPU_PORT_25;
 	ent->vid = (mac_vid >> ARLTBL_VID_S_65) & ARLTBL_VID_MASK_25;
@@ -388,8 +388,8 @@ static inline void b53_arl_from_entry_25(u64 *mac_vid,
 	if (is_unicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT_25)
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


