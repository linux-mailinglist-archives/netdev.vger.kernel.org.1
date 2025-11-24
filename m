Return-Path: <netdev+bounces-241163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED8C80DD7
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC2823436C9
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF230BBA3;
	Mon, 24 Nov 2025 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3XnvC3X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A97030B533
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992528; cv=none; b=Kd10T4jgdYc2Kh7eaTUFrQzAZpAufoLxKWpdrEsqGN5EzR4IZuOIXNKYqsOizZtcefapI7JknduW3opOMyjnHfNeWD6Zz/J9HMKmxe4yq4UFPxk/4fMeGuZaCZ7uCZKCAwDwUDXLKwXoU9SJgNwRQMjm+OafCraqhQcqaepzxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992528; c=relaxed/simple;
	bh=KcRJ6bA0N4k/0qX2qf76ruEaf9NEU/cfr2d/Oiy3vB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jnAS8V5ArnXLCwt28qtvEI0Np3ytP3y1aMVPFsKGkgykRjJdm+7KVBQA2oVNPqfjicU2Y+pQ3+9SGhvRXS2VzDARzziVp5ORz+7wExLb+J6JHqIG63PgGuUnx4PYF+MBmj8+i4t94NlJVTim5arKHqdDmMrmNuRS4mpH7Dik8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3XnvC3X; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29555415c5fso47911735ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 05:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763992526; x=1764597326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtKCReeJtvWy6BfJy3mDpL0IyZ6PcVJYYVjC5YADlrI=;
        b=L3XnvC3XAdgf81Uka+f9ZMRkrao3u19GMamwXpqGHUGPa8oM/i+2QB6v4ukHXyHLEK
         zRaIZWsVT0eTrK5s8/AddGdoibZUF/t6RZrcjO7cdkwqCGqiH9UjTtmFS7HqI0Q2QQW3
         YWchK4gmqnuaztcWwxyVzbnFOh6yQ+3jwDI2eUV7Qo/F9SudkMgTKBtI4lQf338y0Tr0
         Mt7klgNJTASO32DC5HcdLwFPdOemY2a4NSuaOijK5vBAgEY+sM7mEppha1Kv6bMaY9Fc
         pNYlg9gx3VvVWaOlpQN+zUXFxTLfIc71XQAssJEI6wDrQn7/OKnDuqNxDbAtFrgUPVuR
         sHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763992526; x=1764597326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtKCReeJtvWy6BfJy3mDpL0IyZ6PcVJYYVjC5YADlrI=;
        b=n4NJ705hxBmI6iPwGIrPp3bIctCBrrVDj+QRuFjwL2HFQvjWBhb5XF4TPadZVQfUT8
         5Mo8mn59anijUtIkDHpvDxXlirjAsU5846c8VGQdg0ycpeZsHyiXbX2bGinhVOoytD6+
         iO+ITV+IbDUOmXI8MYvYs88gcYcRDUDoAeOk/RFZeVtoqoYnSqZoNA7eJm2V40sBAqgn
         BYEPn5iXCjSb1FkR7Q9gmhj2akucANkmTREyl/FPrjFqF/66kop4RwglcpcIUeOmBlxJ
         aP2JNl3anSxudvjcmmOD/AQ+oaWHgcSOU+Ex/HvJ46KLP1ElTCaKKvRbjCV9/SSzEUWI
         MPlA==
X-Gm-Message-State: AOJu0YzhZLhryGgA8sUNwCmAokzCLbmP05nSGJ40aVcOL+W9+0ITj9pZ
	t93zfPw0mh695NVuAuKCOBDwCrPAbLsyVro5mUDBx0JIGe/7yYNTuwjWrijK2gpDMbk=
X-Gm-Gg: ASbGncv+3KDc9ovEX7U4RoLrLL63lqdZ7d608bsXf+ZA6x2cG84/Nt/9IyAswVcVBZ/
	b7MENp5QqJZJRLJTFAdfe2sSn1yP6fCHuA/oMFgt+pQIorj/o+4hn21abvCn+hq5FaS4FSZAJNi
	hJQ46PsVs+oh3up1+xk3jSP3IGZJ4MXUBEtamlQPuAAuW55jH6Ut4soRzdaCeL5PCrghMrgFOud
	2NnQMRS8g63rQCoN6BpiF9JfbMy9lCQnAZxaoVJIQ0+s5sfFbiOxj3WzwdLPmZjQHMMpXEz9l7m
	ZlSvmPeHKJHrquMFzJXbrnisa85v8xTLz1c+NMSHTMZy4/0Fi/RgjFHNm0+Y9LizoUW2kKeWM6I
	Ml6Mz+AX5ph9J640fEFJ8lnXBjsq9UEq1rnD6jjUlouc5Wn967qdblCD/4d2qcQnBelqwkKNE0A
	9mPPvpfFXsC+imWUgl1IxFQZDXbnY4VA7Ups0=
X-Google-Smtp-Source: AGHT+IErBwzifu/OXNZ4OQn2YeStaBStcYMsFoxxBJ8kwGcCPriLFiwci5sRHV2n0AEYreyBDsCvlA==
X-Received: by 2002:a17:903:37ce:b0:297:f8d9:aae7 with SMTP id d9443c01a7336-29b6c6a8ce0mr117104615ad.46.1763992526493;
        Mon, 24 Nov 2025 05:55:26 -0800 (PST)
Received: from gmail.com ([183.56.183.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e56esm138338545ad.57.2025.11.24.05.55.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Nov 2025 05:55:26 -0800 (PST)
From: jiefeng.z.zhang@gmail.com
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	irusskikh@marvell.com,
	Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
Subject: [PATCH net v3] net: atlantic: fix fragment overflow handling in RX path
Date: Mon, 24 Nov 2025 21:55:18 +0800
Message-Id: <20251124135518.66243-1-jiefeng.z.zhang@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>

The atlantic driver can receive packets with more than MAX_SKB_FRAGS (17)
fragments when handling large multi-descriptor packets. This causes an
out-of-bounds write in skb_add_rx_frag_netmem() leading to kernel panic.

The issue occurs because the driver doesn't check the total number of
fragments before calling skb_add_rx_frag(). When a packet requires more
than MAX_SKB_FRAGS fragments, the fragment index exceeds the array bounds.

Fix by assuming there will be an extra frag if buff->len > AQ_CFG_RX_HDR_SIZE,
then all fragments are accounted for. And reusing the existing check to
prevent the overflow earlier in the code path.

This crash occurred in production with an Aquantia AQC113 10G NIC.

Stack trace from production environment:
```
RIP: 0010:skb_add_rx_frag_netmem+0x29/0xd0
Code: 90 f3 0f 1e fa 0f 1f 44 00 00 48 89 f8 41 89
ca 48 89 d7 48 63 ce 8b 90 c0 00 00 00 48 c1 e1 04 48 01 ca 48 03 90
c8 00 00 00 <48> 89 7a 30 44 89 52 3c 44 89 42 38 40 f6 c7 01 75 74 48
89 fa 83
RSP: 0018:ffffa9bec02a8d50 EFLAGS: 00010287
RAX: ffff925b22e80a00 RBX: ffff925ad38d2700 RCX:
fffffffe0a0c8000
RDX: ffff9258ea95bac0 RSI: ffff925ae0a0c800 RDI:
0000000000037a40
RBP: 0000000000000024 R08: 0000000000000000 R09:
0000000000000021
R10: 0000000000000848 R11: 0000000000000000 R12:
ffffa9bec02a8e24
R13: ffff925ad8615570 R14: 0000000000000000 R15:
ffff925b22e80a00
FS: 0000000000000000(0000)
GS:ffff925e47880000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff9258ea95baf0 CR3: 0000000166022004 CR4:
0000000000f72ef0
PKRU: 55555554
Call Trace:
<IRQ>
aq_ring_rx_clean+0x175/0xe60 [atlantic]
? aq_ring_rx_clean+0x14d/0xe60 [atlantic]
? aq_ring_tx_clean+0xdf/0x190 [atlantic]
? kmem_cache_free+0x348/0x450
? aq_vec_poll+0x81/0x1d0 [atlantic]
? __napi_poll+0x28/0x1c0
? net_rx_action+0x337/0x420
```

Changes in v3:
- Fix by assuming there will be an extra frag if buff->len > AQ_CFG_RX_HDR_SIZE,
  then all fragments are accounted for.

Signed-off-by: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index f21de0c21e52..d23d23bed39f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -547,6 +547,11 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 
 		if (!buff->is_eop) {
 			unsigned int frag_cnt = 0U;
+
+			/* There will be an extra fragment */
+			if (buff->len > AQ_CFG_RX_HDR_SIZE)
+				frag_cnt++;
+
 			buff_ = buff;
 			do {
 				bool is_rsc_completed = true;
-- 
2.39.5


