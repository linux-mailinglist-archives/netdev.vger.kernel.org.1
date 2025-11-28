Return-Path: <netdev+bounces-242510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8064C91183
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412073A5397
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BA72E7BC9;
	Fri, 28 Nov 2025 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oh+GuvW3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024302E6CA6
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317207; cv=none; b=ZOVBVu5nolaeBy9MC9X/ArEq/fzQmU5PPrw8zDBm1xLIME4t0wCrUs0ReL3GEynlxN4J+wI+kijAvsK1Q7CK2Ek2t3RZ+WC0imY0mlNiVrfKmtSazEFCmLhlRwU3rFrkGv8hIF+dQxWj6dCXuWvdSQarfkSFX/tfJ/WpR7DRCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317207; c=relaxed/simple;
	bh=Nmo8ZLI6199XNiEIlcuBZ0RadcL5ViBUVaQFBDqqlDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGQx4RQ15ICIaJaYxJrSTcelFAPd2eV+SRuxbnhp3IqfelsbrjqoGwKxSGFu6//LvcctADoRRP9SpzhbEuHunaT5VmKaqht3Yg9hVTcfLODnLwg7T613QXGv4VZyZzFAz8iFvG3n9R/t5FmiwgQKubiqtT6zpUX0QSuWFdY32hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oh+GuvW3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b735b7326e5so448643966b.0
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764317204; x=1764922004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjZRXDSVub8tCCZ0/UK52o25z1qku925qGRpjMBIfdg=;
        b=Oh+GuvW3usITTb3LD+ry4tuXAC0Ahr9+L+3pDRQyPUj62j5SHnBH3INKjx1ANxHeaI
         3RqINr9ZH4U4S6BtwC1KwmlhbfBjW216W09CZec54YZLH5cjNyys3kQbhGSJisTdCOhC
         tiH/MNjBATfv9b8ezwk3qKNO8xXqviO31cOjpdzmX1xtsCKETUb/Dh2ZzN/x9OfR2aik
         15iM1RSApirk5FtapJNoRdRDNrZh9NBdPYWxZctvMChSIMg/O1kceyPGRTmHGr0/k9Eq
         t/sb0LZ6JPw1E1GWQQY7crP6lMdrtNaxMgmnEv40LDj5icIOH4/UVxjIn4N/8nagsXub
         mLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317204; x=1764922004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjZRXDSVub8tCCZ0/UK52o25z1qku925qGRpjMBIfdg=;
        b=euM7DYF9SMVRmFRXHS9gcA0iL/AbdqhvhILvGbbe8egxVnQIluOxQMcvCB4w4iEjSk
         Rd8MJ5aMVZSaka2kGZKjnrmD9qbkRR0bnidckT8IO0hJkD2y7hgWqxuxuHdxd6EUy+oU
         31vlkflDq2NZ8ngMYpZ6mM7cZ28gtdpgCBzXk4i4jKxRrOnuvNV4b6yNyZ7I4jn6tEBS
         yoV+DRxxlzZe9ZdrmtCUsdcJEHkASw4IrV5HoHq60+vuw1+LX7VJ4bF51rXQ9fazjZxE
         YemzA3NMl0bNbgeE77Wv7JheHrBnW/RlNavMnFlWhPM3R0ej7NnCfPiwlGBnIhrG8NT9
         4P+A==
X-Forwarded-Encrypted: i=1; AJvYcCVZKgp5lMPuCksUiO512W9c0s8gJxfgT+a7ujRS3VVWCYdcE3XwoqBllRLiSCt5CiZUoyVq1+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66RepMOHUwkM2fdobtHrGfZHNMk5vDRcMnRjXZH0/0MomVVGs
	TfHbHGPQrtbrKL3Vqx/aGkzfrnoxq1JIt4Ztk24v2UNfsU82siXWqAEB
X-Gm-Gg: ASbGnctrojz5idK8fDi6F0AesYwf2nD+qXBziYIgHf1l0mAtrbt4mVGZfXZfQb9Q/ys
	UbEHNXkJlJSPmfQf0Z4eL2PXw4AyYAkGRio/xrliHSnSqmrpkWYUZL4KCbKhgRamZUTuGqqtQGb
	9yzz/KX94YRGdWvVoMSMYAhntdU39saEkaVKW/VFkw3xQIwnNCXHWIaJWg+HBV+02s+Og6qBPRY
	0LQe3KwNWVG0TtfNdk2Waeqj5+xRLtFDF/gWybfekJQnDCwetDRDU1w/QgAFCrEmQQP3ozCZJ11
	Gl4pldXbIRTzGBlznU+zszZICc+GTEpTusupnQeZaKuMkhAjsr5Gx64QUy0p0nhuOyAjOd93nAv
	OUZ1HT64mOEXHPxD1KazsQj6bEq2Z2zRyXm/My5B478rn/HilwmlTPf+Lwkc/qzSfQ95RAv0/Iq
	GTsRHq/GOuZeGzcPGcEFfmlAgUkqEUmSA/iwWoa/SuuxRUzCL2Cm3LyfKsG3I2QBGzd+2MqMFDU
	Jy6fA==
X-Google-Smtp-Source: AGHT+IFY96duyv+vlqfHIde+gmVNd358OanngOWZcQh7EoB022qco1Ij8kgMJjkeZmtUB8/w1LJTSw==
X-Received: by 2002:a17:906:c10a:b0:b6d:6650:c3cd with SMTP id a640c23a62f3a-b76572b24cbmr3170973366b.21.1764317204124;
        Fri, 28 Nov 2025 00:06:44 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751062261sm4215612a12.33.2025.11.28.00.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:06:43 -0800 (PST)
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
Subject: [PATCH net-next v2 4/7] net: dsa: b53: fix CPU port unicast ARL entries for BCM5325/65
Date: Fri, 28 Nov 2025 09:06:22 +0100
Message-ID: <20251128080625.27181-5-jonas.gorski@gmail.com>
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

On BCM5325 and BCM5365, unicast ARL entries use 8 as the value for the
CPU port, so we need to translate it to/from 5 as used for the CPU port
at most other places.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
 * use is_unicast_ether_addr() instead of !is_multicast_ether_addr()

 drivers/net/dsa/b53/b53_priv.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 3b22e817fb28..ae2c615c088e 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -344,12 +344,14 @@ static inline void b53_arl_to_entry_25(struct b53_arl_entry *ent,
 				       u64 mac_vid)
 {
 	memset(ent, 0, sizeof(*ent));
-	ent->port = (mac_vid >> ARLTBL_DATA_PORT_ID_S_25) &
-		     ARLTBL_DATA_PORT_ID_MASK_25;
 	ent->is_valid = !!(mac_vid & ARLTBL_VALID_25);
 	ent->is_age = !!(mac_vid & ARLTBL_AGE_25);
 	ent->is_static = !!(mac_vid & ARLTBL_STATIC_25);
 	u64_to_ether_addr(mac_vid, ent->mac);
+	ent->port = (mac_vid >> ARLTBL_DATA_PORT_ID_S_25) &
+		     ARLTBL_DATA_PORT_ID_MASK_25;
+	if (is_unicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT)
+		ent->port = B53_CPU_PORT_25;
 	ent->vid = (mac_vid >> ARLTBL_VID_S_65) & ARLTBL_VID_MASK_25;
 }
 
@@ -383,8 +385,11 @@ static inline void b53_arl_from_entry_25(u64 *mac_vid,
 					 const struct b53_arl_entry *ent)
 {
 	*mac_vid = ether_addr_to_u64(ent->mac);
-	*mac_vid |= (u64)(ent->port & ARLTBL_DATA_PORT_ID_MASK_25) <<
-			  ARLTBL_DATA_PORT_ID_S_25;
+	if (is_unicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT_25)
+		*mac_vid |= (u64)B53_CPU_PORT << ARLTBL_DATA_PORT_ID_S_25;
+	else
+		*mac_vid |= (u64)(ent->port & ARLTBL_DATA_PORT_ID_MASK_25) <<
+				  ARLTBL_DATA_PORT_ID_S_25;
 	*mac_vid |= (u64)(ent->vid & ARLTBL_VID_MASK_25) <<
 			  ARLTBL_VID_S_65;
 	if (ent->is_valid)
-- 
2.43.0


