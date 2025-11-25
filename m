Return-Path: <netdev+bounces-241426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E6C83CC1
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D040D3AF625
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0582D94BE;
	Tue, 25 Nov 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TelOzZTY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EBD2D7DEC
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057129; cv=none; b=rbSzIChDcB4gOgM5F451gedG1bzYgwwBLnO4/T5P+XantChsRDwj4QfZe1HgD6g+YyNdYO56cIXsBesdsnTXnX/Qq7f8RNH3Gu2E26RCpfdXDpYNp4kIhk0oObbBbQ6n8L04RVg3u1kShAXOZQBZA8pFVPYkMTLhegFdzm4Wz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057129; c=relaxed/simple;
	bh=zCC4+YkA9UAw7b7xc8yUmNa0ykjEhE1Rm4iJZzm1pEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtuqnmbcrIo37CRasFWax6fzlgyChHmziMG79dm/ZOBsMyyre7XenjB+OW1+7jz3Gy5+3NaSCnlGU3D01DkbEDA9TD2gOa0IvKFVnMhb9Bh2upEJa3/HSbuDeioe9WZcxDZgjPkhhYcRUYsSVtUMI0K/bF+z0qQ87gqRLdiJeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TelOzZTY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b727f452fffso1016983666b.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 23:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764057126; x=1764661926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSKGq0zk1sClAA4+Iq95EBi32w5W2hPy1VTmIbO4UJw=;
        b=TelOzZTYPGm8wwUjrcilrMBZ4RZxRTlOdKFtNBLZ+sjGG35JmJKLJXNL4P6LxqIN7L
         UOrBrXmwKCCNo4Tin8yo2MOoqLs8moewzHoeXFfqrCMJWXDLasku1a9IuP0jHblrFmll
         DScmmvH3EJqclUiqQNsIU5qz/XK/VW1h5E2xpMshWONZsNsmRDLuZUSsFBT9CAeIKJPI
         McExhGqIe5TJ1E0nNNKw5uNUH794kXgYJtcmNNcU4exZxP7yq6BCxLxYy0gReHy1IHbD
         vfqSereVjckzFETLcNBpV3U+EtqLLXJw2d0vVJngRf0jU2Y9E2eZQIiGDKbCfOlTlCYX
         toOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764057126; x=1764661926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSKGq0zk1sClAA4+Iq95EBi32w5W2hPy1VTmIbO4UJw=;
        b=itUv9jneDbVhzIpPYfVL1ELMLZBkSM3dAvK1h39IWJRlRypOL36DtUCZGMCPL9a19m
         FhwFAI8vRYhlS7ljZoiVqs1Vk7KsX7wWCPHDRH+vaiYPQ0vGXacaQgmWeWH8ERFPmtx2
         6snGF9UMaAZ96cD6lzap33jNu/Rj+FXzGcbp7ynlCNyqjsdNIHncW0Z0LHxKYYjMJ/uR
         UX6sVUZbtfKfXV8ypoj9otFZDU1zSc70OTY6BFm/1TFPcj50a00cqIoRS0f+s7CAEjBb
         25BEr8smpyhGnVaYPWIgQqgRAydAebTr/tLvaKokeHv79ZH/5Q+9E2OW3rO7M0/5J80D
         tDbA==
X-Forwarded-Encrypted: i=1; AJvYcCU81/4X3klsOELZchmp4Sywnk9Mf/E3RytVAI88kcIPSTyFqIArYBTjqFZw7+6rx+gJbuJVrAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7G+2bgGOIZND3ynjuiSSyL7f6i4uB6hifi2KBpPB+Zh6/gTJ5
	Le99TAKxCahiO+Aj15ixY8/iBjjrJtaGeQW1tqDO1ZsmxReMpoMAlDtv
X-Gm-Gg: ASbGnctpBxr0G1qQtwMD8+LVyLygzXQSnJXYG/y2vtxhbZ3JVUHdiXO6MzdkFN1aOHI
	Juyvnc/G4z1Fv4sHf5uQrdNA+GeMZEXwjoqm0AfPWTDlGOfNGdEoHeouodCStiPmUNCE1AEEGHB
	t1HyD06+pgvfeVsOoJx4MAYTzFVHlQPuS31nboiRpUWQ2tOVRwYZ+RZXJf9RX8PJYzRT4oId11e
	fPw4C8PrS0ym4MubxiiIKQ6dVikZO0FRgaS4yStW2/mpwnIvLJS1Cj3J/+1d0T3n9vuD6VEgaIp
	KE4eUYOGk7OKoHufkw+b3z646IwQ0JPXFzEfw5oJgAeNBso6I5fyJ9kjPr1gt4ddN/zvO2pP93S
	F8X9/3lbI7oQVEoHtdtNNsCRQBYVyPPrdYcIGgzLjSfgrh76BBKLpV0iCxPO43zDgbTsdj5btFq
	sBLSPaaIgXi0BazIC3MF9QN2KVtj7qezcYvYY3x27/Lxdb7indru1kWDE4f2KE1jtg4cM=
X-Google-Smtp-Source: AGHT+IEuoa4sdgQqqYNp7CqZVz2E21Qbjw8iF2McemoqfWLRx21Vkc5hzn3Uvm8M2w3AUT4YCyd2Ew==
X-Received: by 2002:a17:907:3d87:b0:b72:671:b2a5 with SMTP id a640c23a62f3a-b76571367f9mr2358253266b.3.1764057125492;
        Mon, 24 Nov 2025 23:52:05 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d7cb3bsm1536185666b.27.2025.11.24.23.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 23:52:04 -0800 (PST)
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
Subject: [PATCH net-next 3/7] net: dsa: b53: use same ARL search result offset for BCM5325/65
Date: Tue, 25 Nov 2025 08:51:46 +0100
Message-ID: <20251125075150.13879-4-jonas.gorski@gmail.com>
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

BCM5365's search result is at the same offset as BCM5325's search
result, and they (mostly) share the same format, so switch BCM5365 to
BCM5325's arl ops.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 18 +-----------------
 drivers/net/dsa/b53/b53_regs.h   |  4 +---
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 7f24d2d8f938..91b0b4de475f 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2125,16 +2125,6 @@ static void b53_arl_search_read_25(struct b53_device *dev, u8 idx,
 	b53_arl_to_entry_25(ent, mac_vid);
 }
 
-static void b53_arl_search_read_65(struct b53_device *dev, u8 idx,
-				   struct b53_arl_entry *ent)
-{
-	u64 mac_vid;
-
-	b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSTL_0_MACVID_65,
-		   &mac_vid);
-	b53_arl_to_entry_25(ent, mac_vid);
-}
-
 static void b53_arl_search_read_89(struct b53_device *dev, u8 idx,
 				   struct b53_arl_entry *ent)
 {
@@ -2746,12 +2736,6 @@ static const struct b53_arl_ops b53_arl_ops_25 = {
 	.arl_search_read = b53_arl_search_read_25,
 };
 
-static const struct b53_arl_ops b53_arl_ops_65 = {
-	.arl_read_entry = b53_arl_read_entry_25,
-	.arl_write_entry = b53_arl_write_entry_25,
-	.arl_search_read = b53_arl_search_read_65,
-};
-
 static const struct b53_arl_ops b53_arl_ops_89 = {
 	.arl_read_entry = b53_arl_read_entry_89,
 	.arl_write_entry = b53_arl_write_entry_89,
@@ -2814,7 +2798,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.arl_buckets = 1024,
 		.imp_port = 5,
 		.duplex_reg = B53_DUPLEX_STAT_FE,
-		.arl_ops = &b53_arl_ops_65,
+		.arl_ops = &b53_arl_ops_25,
 	},
 	{
 		.chip_id = BCM5389_DEVICE_ID,
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 69ebbec932f6..505979102ed5 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -376,10 +376,8 @@
 #define B53_ARL_SRCH_RSLT_MACVID_89	0x33
 #define B53_ARL_SRCH_RSLT_MACVID_63XX	0x34
 
-/* Single register search result on 5325 */
+/* Single register search result on 5325/5365 */
 #define B53_ARL_SRCH_RSTL_0_MACVID_25	0x24
-/* Single register search result on 5365 */
-#define B53_ARL_SRCH_RSTL_0_MACVID_65	0x30
 
 /* ARL Search Data Result (32 bit) */
 #define B53_ARL_SRCH_RSTL_0		0x68
-- 
2.43.0


