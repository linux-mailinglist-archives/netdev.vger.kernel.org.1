Return-Path: <netdev+bounces-241429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B2DC83CD3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1BC3B0434
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF04B2DE6EF;
	Tue, 25 Nov 2025 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvcvSCk5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF02D9EF4
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057133; cv=none; b=G/7Gxi5/p+nM8MWs3ISczsI55jDHh72G8hzsDJ3nZOkH+bVGI7m3sQT3l69QzzRayg0gJRdLTk3mRhKcdSTxVUsTt9ryloCm0pg6NGRkqESkMagDO7G3AwPwZrhzACi9i7IRkjv5oiyMhYR/PTRcC0N2WJjHbLgC7OEdUx0nFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057133; c=relaxed/simple;
	bh=q1IKP+j9PFBXI9VECNtuhPrYa6qPbjLTzChyrHb6Ui0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1CfNMSw+OObSZNqxsd0e6T1xVCkmC1x8vnkLZdh6OXiI4XN/2sb0E8kB9KHaqh8l83FeTMtq+UIK56Rgz/9vOrNZVLfCw5tx8RrU0bBvTHEDq1MS50fdyq2gysrd/TvCcfqYtmbmawuejUUWEKbeb8AMkfQ6/ZWHpdJ7VJAWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvcvSCk5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so7174531a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 23:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764057129; x=1764661929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V+iOBjztOFiOh8XvFtucaeDeOd2zLS6YUjWGQu28Ko=;
        b=KvcvSCk58BkXcnjQeIhGGClq3+qDZS94+R/LL128FtdGmb0Zavs7Dj5pip5jLzGEgf
         huNDNLCbWfFmyKg4PQujH2l1wSfUoeWe1q46lN2oqTBfFO/Ibrbpk0+LGlZkcOI9uWto
         8LKBeMgFEvvGohslgLzCJYgQTV6pMwf5A8OSTA0a4yjKNqjAdlje3uBTHDKz0cxNRreb
         njm1s25/bRssJRVl/3v7wvxgjyyYc5lX1OVHYFMsfeQKzNGUgCM0lmUFeMeiHZFBiqAD
         H6OBh89larz/Oau4QqDjo1mjro1OU6nxfzVdtSLAsmEdAY7D3tH8RmI/GWdiNSkt7lbX
         hJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764057129; x=1764661929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0V+iOBjztOFiOh8XvFtucaeDeOd2zLS6YUjWGQu28Ko=;
        b=i1/8s88zzSih79emdELF8KSJq0WQzJ/4l7uP1I5wf3PRou/SFomDmHe7nZsko6cN0G
         Ez4TMC6dhSYa5o1D8sB6wq0/FE0H0XcvLD1mT+VySQdc1PwpsB+WJE53GEHNowuXyvfg
         +K6KePTaGwHBxPIUTnPrvegabi/LSpUaqWLh8tMJRr115ceIBE55rNIuwpfCdCbXHaWH
         lv79IvmN32KjDqjq8uYyCCNMWa/t/hNCETgHuaqxhP4z5nqL+VO+a53VWEjcHThUlaGz
         /Ke6tyF8i1NDCQebHL1mVOrk4WtymIKTzj91ujO09NoeXIdnKoBvaQKvsMC9AiJxAPWH
         B+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8UOPg+myoBQ8AlL7Gnne9AipvEflFE+bHyz1D9nR6jvIOmnjGlhiT1dCGxcQZi0lofbfS0WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmZBULEI8Od0pVg027K2PCIiSMV1wdm0l9XaYXkqRxHFaNrl3
	nx+PKT6G3DVryLUYeUXotyiAeViQtQ21fKJQeZepFGNCir+Eb3AFEu4r
X-Gm-Gg: ASbGncszsex3R7/kCEGlNgdgjkzNjLIhJTB9fpdFCdMfj03wj8qmNqsl1C41iI5lpxg
	h7QuCfASL8ZLQYjRpPKxVdo1epPeViK6/0iXnA4LuWEyWioYXn7/pr9kWZ+bYegEcCyoekDbScl
	KLim5p0zktLFH6LomnO9yjbuvVDiiWYplFfQC5p6H9BN+z0AcOzgSwDYHe4fvVzvo4GbNhYOJVF
	yIZ/2+HyaxQAfWE0xbX7eVB2PkrMQbKXB6BB47RtC+SBHrCTZ+k65+symppf8CI92f5LQ2+8IEb
	deY1uYW/exZ/rbt9lOszZSwKJuCfJh5SYgyyOEXeRSFUb8alCbFu6k6YlNXnGPpnK2c2op1Xu3D
	s4Dx6YNx90T7i3foeK1gWiRREe4Gtu3Q81lHZCz0mz6ggZzANYxMy6DP2zdwDBlDNuwDy/eJYic
	rb8CMIf9ZhiNNEEF7CuPqygGdGG4jj42biqwywTEnv9DVTcWN1oGjYIajLP54BxoWJNM0qArE4O
	wbZow==
X-Google-Smtp-Source: AGHT+IFk77GelQTFcD92LcQnmuvfhCPsowRD//MZHMAJK96B1Vx8M3nO5H9fm/u7Xvl37U98LQQeqQ==
X-Received: by 2002:a05:6402:2111:b0:640:a9fb:3464 with SMTP id 4fb4d7f45d1cf-645544421efmr12259245a12.7.1764057128901;
        Mon, 24 Nov 2025 23:52:08 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b62cesm14126718a12.13.2025.11.24.23.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 23:52:08 -0800 (PST)
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
Subject: [PATCH net-next 6/7] net: dsa: b53: fix BCM5325/65 ARL entry VIDs
Date: Tue, 25 Nov 2025 08:51:49 +0100
Message-ID: <20251125075150.13879-7-jonas.gorski@gmail.com>
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

BCM5325/65's ARL entry registers do not contain the VID, only the search
result register does. ARL entries have a separate VID entry register for
the index into the VLAN table.

So make ARL entry accessors use the VID entry registers instead, and
move the VLAN ID field definition to the search register definition.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
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
index 24df3ab64395..ea99e4d322bd 100644
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
 	if (!is_multicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT)
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


