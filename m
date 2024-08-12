Return-Path: <netdev+bounces-117760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AC594F1AD
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12027B20C30
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF700136E37;
	Mon, 12 Aug 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo9qAx6+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1184AF9E8;
	Mon, 12 Aug 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476625; cv=none; b=fMQBm0u6kDaiWCStjajeXqRcPcCaj1PH/sC/y8p1Dtf9/XPeo09DBEAu74vaaTCCBf1y8rzsiokVSwGPBC9ZHZTCZLyTVjUCNploc91i2CpcpJz9wgTr/2V+b2t1Za3hCjo2yp+ljwFh00IsfZ9vBttLryLa/Py0LHYbV7gXWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476625; c=relaxed/simple;
	bh=HIxMpRFRlHKWZS9zX3Uq7eWitMEmF4+aOCgjFQHiHZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsVzDb1wQl8nvdQKcWAqWWWgPYQ/ifxzPBSW2pMnFTF+xE2+9YfTxWIUE1Pi/lB0+Y8CBuKHb3xffudGBYsl9wFm9U1yfjqWASvtHOf8oOP2ttH7jTIkJ7udqKPM3usSFfCT6CqAojeW4hp6oQNKK9wvrlPFixuCUsfRFDVjwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo9qAx6+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f0277daa5so6164257e87.0;
        Mon, 12 Aug 2024 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723476622; x=1724081422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8MloQL6DzucEeBvQKJ3NnuVJ0vExUXM9IAv+SpReLA=;
        b=jo9qAx6+l+tfePZCjsZXlSmKXexsFz2qATVy3Bjm0PaBR7uNwQgIO9FSOF35r5J3sW
         VXG7/hVOjNCuJ8w0HxIGlJ7yvUm53/LaepKeajME5QRmlifeNxodClYl4/olOdDv3cMy
         xSle0noOccxbMjJNVOBb3RSZZ+laVxIkW/KauEbtHXAL0e/Ovmu9X/KCGRSDZhoqPdh/
         +NDwok/FEUUKITZvKDsIcQe/G6vCrKXuaEChlyzF+8Bjm+0kb4YE+fJ+So9GVdzLyf8Z
         SPiVhubaN8+7v5sYda/JdussrBlN3HY9RKc8289mkvozALOIDBPIlpuY5wZ97j5vfNFU
         ZQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723476622; x=1724081422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8MloQL6DzucEeBvQKJ3NnuVJ0vExUXM9IAv+SpReLA=;
        b=DtLUc0T+S3YExFD94WrGAyuYMz+GMCKo8z4z/imd3ZJL3+XFLbXQ+OD3LQte44J/t+
         wiajtx0EPTZcMpm5rO6bPVEmyvYbMwKtz00iBAWDCp6CFNPKNP1ZvKPYHyNgkYRDmZdZ
         b2sqn6d+mcmCN9ovMZr7e8RuuAGOix/oDB0SFKvVfVcUAQ++A+80xmPJzk3Upb6QqqQD
         dxwlrfyySJbruO9sbG5I7lME3ndCItXaHm9sMoZAAIoA0g7k77ghs9+oQ8KNRnyGjbRF
         HCXcPDbV062lP/ZehjzyJCL7xn7wnyE/+5WYVXdmHIKccvi4hmRhHOQNIkrd7Jbj3bmb
         EOOw==
X-Forwarded-Encrypted: i=1; AJvYcCVtxQ12E4LBUurDipqI9oLoOP4AgWSnVLlKrEoFvMOXorWneTpg40KztK/BcAEDVaA+MvIfTmf+ThWTEe/KWkAqCK4GT7gF/fuOsUkpOng2tagVSv0MoLSHpOBVHbQYufCzeM2eEocVAF7HE1NriHV0fHMGsabuKNBOYiJBMyathQ==
X-Gm-Message-State: AOJu0YzuoAqx92CPTCknfnzoz7rO49JKhUWxBV3TLLUiXPKTcSom8XB4
	3VLeTEQBusox2gRSs+FB0h+iVEJ+pZbKcd4FOMcFb8liHgTiFdE9
X-Google-Smtp-Source: AGHT+IH30Ql2vSYRLfuIRYZ7cpcy1C9s2aO8v3voppQs2jXf6diYXL+QtyP2wDgBs/Ct9/kwv0Lc5A==
X-Received: by 2002:a05:6512:2346:b0:52e:9481:eaa1 with SMTP id 2adb3069b0e04-53213657e41mr373305e87.23.1723476621814;
        Mon, 12 Aug 2024 08:30:21 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a666fsm2192535a12.46.2024.08.12.08.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:30:21 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David S Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v5 0/6] net: dsa: microchip: ksz8795: add Wake on LAN support
Date: Mon, 12 Aug 2024 17:29:51 +0200
Message-ID: <20240812153015.653044-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add WoL support for KSZ8795 family of switches. This code was tested
with a KSZ8794 chip.

Strongly based on existing KSZ9477 code which has now been moved to
ksz_common instead of duplicating, as proposed during the review of
the v1 version of this patch.

In addition to the device-tree addition and the actual code, there's
two additional patches that fix some bugs found when further testing
DSA with this KSZ8794 chip.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
v5:
 - patch 5/6: split off DSA tag_ksz fix to separate patch 6/6

v4: https://lore.kernel.org/netdev/20240812084945.578993-1-vtpieter@gmail.com/
 - patch 4/5: rename KSZ8795* defines to KSZ87XX*
 - patch 5/5: rename ksz8_dev_ops to ksz88x3_dev_ops
 - patch 5/5: additional DSA tag_ksz fix

v3: https://lore.kernel.org/netdev/20240806132606.1438953-1-vtpieter@gmail.com/
 - ensure each patch separately compiles & works
 - additional return value checks where possible
 - drop v2 patch 5/5 (net: dsa: microchip: check erratum workaround through indirect register read)
 - add new patch 5/5 that fixes KSZ87xx bugs wrt datasheet

v2: https://lore.kernel.org/netdev/20240731103403.407818-1-vtpieter@gmail.com/
 - generalize instead of duplicate, much improved
 - variable declaration reverse Christmas tree
 - ksz8_handle_global_errata: return -EIO in case of indirect write failure
 - ksz8_ind_read8/write8: document functions
 - ksz8_handle_wake_reason: no need for additional write to clear
 - fix wakeup_source origin comments
v1: https://lore.kernel.org/netdev/20240717193725.469192-1-vtpieter@gmail.com/

Pieter Van Trappen (6):
  dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
  net: dsa: microchip: move KSZ9477 WoL functions to ksz_common
  net: dsa: microchip: generalize KSZ9477 WoL functions at ksz_common
  net: dsa: microchip: add WoL support for KSZ87xx family
  net: dsa: microchip: fix KSZ87xx family structure wrt the datasheet
  net: dsa: microchip: fix tag_ksz egress mask for KSZ8795 family

 .../bindings/net/dsa/microchip,ksz.yaml       |   5 +
 drivers/net/dsa/microchip/ksz8.h              |   3 +
 drivers/net/dsa/microchip/ksz8795.c           |  94 +++++-
 drivers/net/dsa/microchip/ksz9477.c           | 197 +------------
 drivers/net/dsa/microchip/ksz9477.h           |   5 -
 drivers/net/dsa/microchip/ksz9477_reg.h       |  12 -
 drivers/net/dsa/microchip/ksz_common.c        | 271 ++++++++++++++++--
 drivers/net/dsa/microchip/ksz_common.h        |  31 +-
 net/dsa/tag_ksz.c                             |   2 +-
 9 files changed, 388 insertions(+), 232 deletions(-)


base-commit: c4e82c025b3f2561823b4ba7c5f112a2005f442b
-- 
2.43.0


