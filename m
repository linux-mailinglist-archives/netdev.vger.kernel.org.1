Return-Path: <netdev+bounces-117612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC87494E8E1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA2B28286C
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D715C156;
	Mon, 12 Aug 2024 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIl9o+64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4214C5AA;
	Mon, 12 Aug 2024 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452656; cv=none; b=XuAmQ2MYdvnYXp6D28+CG3B+HvCduNecs9+lCD1np4fX69reXlSNCcC2RWqhY0iZXVGR8mLTOp0/Qj6JQXdKd5JasMvG97DBGxysBUM8ZMlSgnkzGe1pbWZirY4IbQsCQHLaVcsYpZyDkus/XnAtSzXywzjLXoXd9heLI/A7Ro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452656; c=relaxed/simple;
	bh=KbbZ+rpsEkDND5eECFTPrRuGUpHUqBZrd8jAJAPCZXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EirohIKnzQJJ+rP0lsJdSiDMyChCXVFTIq7o9pxGTcwu1F4UZPQhWGWHXBk2CHWQEk1ztq/dLmSg4lCjrB2guqZ6p/dqDjRJaa3fXR4d2weyqyIDZe22QU19uktwt4PkJAaUZ3jukbRDqX8C7QKHW1N5lCpMObL2+kbtFGzfCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIl9o+64; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so4741256a12.2;
        Mon, 12 Aug 2024 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723452653; x=1724057453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lopga2KKIArf9qHPlQY1hc8QRVx5iSU42NmUBmFo1GE=;
        b=TIl9o+64+SO67Hhftxv3t/rWgbLuxJBGc9u7G/0KuDDQqzl5m5TO6/dtqkWfHf9yF1
         /Mb3Srt54UvZg9FKd6sroUdiS9cR5hMISEyOvga74UX5mctfZaJcP9vQRXUylPQWrIRi
         Y3Qr1UZTbMRMYmggNEY3yKrdktC8YVWGbHNCPz/qQGD4t04kiZkIKS2XDTQhFko+LP87
         9SlUlkCFimITuM7nDhNC1w/2htsR43YxGKb47tFvNJYpLg5NT96BWLFkVOdMSFCelnMI
         9hrN2CW93tobeeBeFFh0pG+iqtG51q+/C5ktaGej4hdgNqg11R2OhNT0mXG0Z18VgHBJ
         fmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723452653; x=1724057453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lopga2KKIArf9qHPlQY1hc8QRVx5iSU42NmUBmFo1GE=;
        b=SFEpbP9yCtzs2cVwR6AQoCowgw+oEdDgt2jra6VwRFQNQNscWDAxhuewyx+ffZJBjD
         Sw/y33WI+bFAKx0fIpM0D227LJi6kw3j9ZkNcJ8jR2efE3eoOsKhNUtBfJHhQmWWLup7
         2U4e7haLMtCtFjiCQRXnKQ3JKgROd7T7tXH9fUdomFB0Dw8zAcTkGOq1tzF8cW4S6eiu
         eIeMwDQELYnOwThPmGeBE4bYoCITOGLSv9C9OvNySh4FZVSScRtK/0X8W7uNq04b1/Sx
         B/TQm126rAnV54pRZkgxKOt/3q24AROkP78u3jeBlMe7jO5cjU42kZiTo4Pq3yB0OFTM
         8W3A==
X-Forwarded-Encrypted: i=1; AJvYcCXohYUWkyVIGGd2np8pyaHqthPl3J0mfFm/DLfH04oA/p2E1jv4djnPo71m/ak1+8B6y8EcKxB93Rhv/ar593aRlVxBs047csJi5l2KMPEjzUbzK2LfdUKOjydr+5BWgxRJstU5CCJk5R29usGtE37vhQci/fKwicrbIxzoL+ZIXQ==
X-Gm-Message-State: AOJu0Yysd618CaLZXrGIhRrZ1TuK53vv8RgywQ0eD+Em0v/WhdmPDdUv
	RoU2Ja6O30K2br0FzHYvdXXftyC7Iy8AbreeXfjqRoZW6eWoORRn
X-Google-Smtp-Source: AGHT+IFuyqF/GhcqT6VIFtNNMITKP6KYp5jqN0ABDUuzEUlBwGWniLAjFk7IEFEhdn2EA5Qcmvq2ww==
X-Received: by 2002:a05:6402:2809:b0:5a2:84e2:c895 with SMTP id 4fb4d7f45d1cf-5bd0a6dd39cmr6697176a12.34.1723452652454;
        Mon, 12 Aug 2024 01:50:52 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f517dsm2094761a12.4.2024.08.12.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 01:50:51 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/5] net: dsa: microchip: ksz8795: add Wake on LAN support
Date: Mon, 12 Aug 2024 10:49:31 +0200
Message-ID: <20240812084945.578993-1-vtpieter@gmail.com>
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
an additional patch that fixes some bugs found when further testing
DSA with this KSZ8794 chip.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
v4:
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

Pieter Van Trappen (5):
  dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
  net: dsa: microchip: move KSZ9477 WoL functions to ksz_common
  net: dsa: microchip: generalize KSZ9477 WoL functions at ksz_common
  net: dsa: microchip: add WoL support for KSZ87xx family
  net: dsa: microchip: apply KSZ87xx family fixes wrt datasheet

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


