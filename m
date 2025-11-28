Return-Path: <netdev+bounces-242512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 108EAC911A4
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9DDF4E7551
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4514B2EE5FE;
	Fri, 28 Nov 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/ThSavi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC32E92B4
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317211; cv=none; b=CZVxs8+JZfnARPUlptXm4KAUrKTxxnUQh72Jwp4ipMa0uiYPrjlFe46hUyCOFYWm+FzWPzT49dPJUCr2LAt0ISsmbOsnrp5Vk+xxwFnQrfkzi9l6s67QIwVAbtnRgnT4GtwEEmvw21hgtByjbzxdp4KNpI+QNQY6ZOBxslomBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317211; c=relaxed/simple;
	bh=Rgs2EQ3Q36rzped/ecsC+M5qqjYWihe5acs+Gfc5BMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYeNQX2Tr91DzfA6Sc0mIewiARh1K/4a3RZ6wr0trqd0cQFtMV44yx49zwk0GRjmpUyuca5t3QuCSL0KZAXLFlisrDEw0jWmbPm986XS/mqqesN5n2vxnBDTIUhJpZz/blhdfLEuq7shJ36VbF2QoVN0JiFqzIZo10mUDXiMuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/ThSavi; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so2386686a12.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764317208; x=1764922008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYp7E+XRleF9Ba/rdsGt5FOtJp0XS5WeD2C0kR30ens=;
        b=J/ThSaviOkr1kCpDo32mtPbPlBAEGL/ytV4/tTjr+GLc2SYEgyAwLTy2yr9ma+aggq
         akRLWMcq67Q3XwLdOPr/Vtn8BeGK8Y6mXy/gPD3SLkh4A0rVvQIMWrzTpSfSyBYZM6Mt
         8Q3tpv7o/Mx0jVdoDNWPnPvobLXD1daC5k8ITBKgMra/zgMMutbZXewwPAqrKXNBY/Di
         gFBVytBGvUzQnHpSGc9vTA+jKqaY0idWDm4ggzT8y8AfTZDugBpBsXxUN82yt82TKQco
         N26F4RLEkYznn7RwecURMwbtUMBJF9bK2mSILZu7UL50zy0b8sDcGA5DmhCvetYFulbh
         Ou7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317208; x=1764922008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYp7E+XRleF9Ba/rdsGt5FOtJp0XS5WeD2C0kR30ens=;
        b=qBfc6krjjLtz4eFq67ZQY+/qp77MJGcGr/rHXsDN3rJ4+Y7tU7CcN26CShd1ZiF75r
         v8Rmc9rBxYrbrGIPJXwsZCiqP9Ued33DfDIDfJHREPNG1AEdeS5hy+JE5S6U8a8RsDqv
         dD23XnEeXgifnEWUUqtCFdboIwyNmj6m/5pPSdEr7wNBuwd4nMDbGUqxk+1gSkzQ+8iA
         7OuhdgXDWPVNGJtTbQC2vRQ32EzvD9bF1m4pjfoAYNiWD4yU6VS0VqiCShibNjeaV9LT
         I37QPVdYXWFLUc2r6GnC7PAD+56PsWMaJvXKo5bovV0m8dvsV3ZW/NGSBp2lu3bKvOsm
         if+g==
X-Forwarded-Encrypted: i=1; AJvYcCULS0cf1Rj7P1MiFAXSVqSyrZ5p3SwAF0ergEfEeruS8louQjlc0evzaRm5o0HuMVKAo1awaII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwTvcKXiaB2WGgr0FaiyRRdT8kwTdtgk6UOIREPB/FXCFfKyl
	BDhbMp/K3QH6oES6qcHEiQCDQJ4qsA5xzi99dBVYH8EwGHyw7Z/Kg+FjcBX0gA==
X-Gm-Gg: ASbGncuu97Ts11tUlYVDRuCvs4zwcxPmekp0frbkDrQgXHO4Hx02wIPRK3qz8f6TghS
	5cWSFKZFukRjwOU67yFzqY2hWSmEq3BDMDpcA1a4jALECGYdqeC33KdRAU9+XCyoyuiH9n0VQn0
	sRUmIfiTIEGhXxQkYw2y4rE50OqEC5s6z1yZwOV/KMM2g4xYiYUqzt69Lqr2p9r9SIPwzPIoBeD
	tbMbkiz8OQw0YAH0UkHtOaOUi+4OD7vVSDzT5qYJdHpLlONamVW7QyGub8rdvHeFxmw15L8XOxf
	ZoYS0er7G52wQozTDsx7NMUoDgjxY2OzyLDUrCshMLlmacEH6J9eHEps+EEFuDtuTfoUJskrXeV
	89rzXWXDkeTUPGMbu9S6UdEj31VlTS3rao5yV5k9QEM+pNUAykJ+Tgwzc7JH23AWwXI17uh1O3N
	e+v0PD9DB7zTojHeZ6p3SvNYNkP24VpmoBlG26O6g2sGP16VGnNqfqSM/KbANdwKoQOqc=
X-Google-Smtp-Source: AGHT+IHlfrMxY5sFsBSX7jadMFZM3qxFUUsTxH86IA5j+iftXghDZIBfXbkK4fd2ZtWlHXEYdAUygQ==
X-Received: by 2002:a17:906:478a:b0:b73:42df:29a with SMTP id a640c23a62f3a-b76719ec80fmr2743046266b.59.1764317207486;
        Fri, 28 Nov 2025 00:06:47 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59e8fdasm379537966b.51.2025.11.28.00.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:06:47 -0800 (PST)
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
Subject: [PATCH net-next v2 6/7] net: dsa: b53: fix BCM5325/65 ARL entry VIDs
Date: Fri, 28 Nov 2025 09:06:24 +0100
Message-ID: <20251128080625.27181-7-jonas.gorski@gmail.com>
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

BCM5325/65's ARL entry registers do not contain the VID, only the search
result register does. ARL entries have a separate VID entry register for
the index into the VLAN table.

So make ARL entry accessors use the VID entry registers instead, and
move the VLAN ID field definition to the search register definition.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
 * no changes

 drivers/net/dsa/b53/b53_common.c |  9 +++++++--
 drivers/net/dsa/b53/b53_priv.h   | 12 ++++++------
 drivers/net/dsa/b53/b53_regs.h   |  7 +++++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 09a64812cd84..ac995f36ed95 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1853,19 +1853,24 @@ static int b53_arl_rw_op(struct b53_device *dev, unsigned int op)
 static void b53_arl_read_entry_25(struct b53_device *dev,
 				  struct b53_arl_entry *ent, u8 idx)
 {
+	u8 vid_entry;
 	u64 mac_vid;
 
+	b53_read8(dev, B53_ARLIO_PAGE, B53_ARLTBL_VID_ENTRY_25(idx),
+		  &vid_entry);
 	b53_read64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
 		   &mac_vid);
-	b53_arl_to_entry_25(ent, mac_vid);
+	b53_arl_to_entry_25(ent, mac_vid, vid_entry);
 }
 
 static void b53_arl_write_entry_25(struct b53_device *dev,
 				   const struct b53_arl_entry *ent, u8 idx)
 {
+	u8 vid_entry;
 	u64 mac_vid;
 
-	b53_arl_from_entry_25(&mac_vid, ent);
+	b53_arl_from_entry_25(&mac_vid, &vid_entry, ent);
+	b53_write8(dev, B53_ARLIO_PAGE, B53_ARLTBL_VID_ENTRY_25(idx), vid_entry);
 	b53_write64(dev, B53_ARLIO_PAGE, B53_ARLTBL_MAC_VID_ENTRY(idx),
 		    mac_vid);
 }
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index f4afbfcc345e..bd6849e5bb93 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -341,7 +341,7 @@ static inline void b53_arl_to_entry(struct b53_arl_entry *ent,
 }
 
 static inline void b53_arl_to_entry_25(struct b53_arl_entry *ent,
-				       u64 mac_vid)
+				       u64 mac_vid, u8 vid_entry)
 {
 	memset(ent, 0, sizeof(*ent));
 	ent->is_valid = !!(mac_vid & ARLTBL_VALID_25);
@@ -352,7 +352,7 @@ static inline void b53_arl_to_entry_25(struct b53_arl_entry *ent,
 		     ARLTBL_DATA_PORT_ID_S_25;
 	if (is_unicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT)
 		ent->port = B53_CPU_PORT_25;
-	ent->vid = (mac_vid >> ARLTBL_VID_S_65) & ARLTBL_VID_MASK_25;
+	ent->vid = vid_entry;
 }
 
 static inline void b53_arl_to_entry_89(struct b53_arl_entry *ent,
@@ -381,7 +381,7 @@ static inline void b53_arl_from_entry(u64 *mac_vid, u32 *fwd_entry,
 		*fwd_entry |= ARLTBL_AGE;
 }
 
-static inline void b53_arl_from_entry_25(u64 *mac_vid,
+static inline void b53_arl_from_entry_25(u64 *mac_vid, u8 *vid_entry,
 					 const struct b53_arl_entry *ent)
 {
 	*mac_vid = ether_addr_to_u64(ent->mac);
@@ -390,14 +390,13 @@ static inline void b53_arl_from_entry_25(u64 *mac_vid,
 	else
 		*mac_vid |= ((u64)ent->port << ARLTBL_DATA_PORT_ID_S_25) &
 			    ARLTBL_DATA_PORT_ID_MASK_25;
-	*mac_vid |= (u64)(ent->vid & ARLTBL_VID_MASK_25) <<
-			  ARLTBL_VID_S_65;
 	if (ent->is_valid)
 		*mac_vid |= ARLTBL_VALID_25;
 	if (ent->is_static)
 		*mac_vid |= ARLTBL_STATIC_25;
 	if (ent->is_age)
 		*mac_vid |= ARLTBL_AGE_25;
+	*vid_entry = ent->vid;
 }
 
 static inline void b53_arl_from_entry_89(u64 *mac_vid, u32 *fwd_entry,
@@ -422,7 +421,8 @@ static inline void b53_arl_search_to_entry_25(struct b53_arl_entry *ent,
 	ent->is_age = !!(mac_vid & ARLTBL_AGE_25);
 	ent->is_static = !!(mac_vid & ARLTBL_STATIC_25);
 	u64_to_ether_addr(mac_vid, ent->mac);
-	ent->vid = (mac_vid >> ARLTBL_VID_S_65) & ARLTBL_VID_MASK_25;
+	ent->vid = (mac_vid & ARL_SRCH_RSLT_VID_MASK_25) >>
+		   ARL_SRCH_RSLT_VID_S_25;
 	ent->port = (mac_vid & ARL_SRCH_RSLT_PORT_ID_MASK_25) >>
 		    ARL_SRCH_RSLT_PORT_ID_S_25;
 	if (is_multicast_ether_addr(ent->mac) && (ext & ARL_SRCH_RSLT_EXT_MC_MII))
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 54b1016eb7eb..54a278db67c9 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -329,11 +329,9 @@
 #define B53_ARLTBL_MAC_VID_ENTRY(n)	((0x10 * (n)) + 0x10)
 #define   ARLTBL_MAC_MASK		0xffffffffffffULL
 #define   ARLTBL_VID_S			48
-#define   ARLTBL_VID_MASK_25		0xff
 #define   ARLTBL_VID_MASK		0xfff
 #define   ARLTBL_DATA_PORT_ID_S_25	48
 #define   ARLTBL_DATA_PORT_ID_MASK_25	GENMASK_ULL(53, 48)
-#define   ARLTBL_VID_S_65		53
 #define   ARLTBL_AGE_25			BIT_ULL(61)
 #define   ARLTBL_STATIC_25		BIT_ULL(62)
 #define   ARLTBL_VALID_25		BIT_ULL(63)
@@ -353,6 +351,9 @@
 #define   ARLTBL_STATIC_89		BIT(14)
 #define   ARLTBL_VALID_89		BIT(15)
 
+/* BCM5325/BCM565 ARL Table VID Entry N Registers (8 bit) */
+#define B53_ARLTBL_VID_ENTRY_25(n)	((0x2 * (n)) + 0x30)
+
 /* Maximum number of bin entries in the ARL for all switches */
 #define B53_ARLTBL_MAX_BIN_ENTRIES	4
 
@@ -380,6 +381,8 @@
 #define B53_ARL_SRCH_RSTL_0_MACVID_25	0x24
 #define   ARL_SRCH_RSLT_PORT_ID_S_25	48
 #define   ARL_SRCH_RSLT_PORT_ID_MASK_25	GENMASK_ULL(52, 48)
+#define   ARL_SRCH_RSLT_VID_S_25	53
+#define   ARL_SRCH_RSLT_VID_MASK_25	GENMASK_ULL(60, 53)
 
 /* BCM5325/5365 Search result extend register (8 bit) */
 #define B53_ARL_SRCH_RSLT_EXT_25	0x2c
-- 
2.43.0


