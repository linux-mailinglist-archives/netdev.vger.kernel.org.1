Return-Path: <netdev+bounces-207324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D6DB06A6D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3742188D498
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E4D35949;
	Wed, 16 Jul 2025 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axaNz0Ij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D92E10F1;
	Wed, 16 Jul 2025 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625773; cv=none; b=FkvjXZ5Za5dRjqn5l00B5hqPXtypAjpc/u2lmOUrCWjyxdD2yeE7MrbMErZeP7v9OGuTkM8LpSTzrne0oyPqoA1cn2Ditl+XihmBZwgXtL1plJsr7pbGn6Cs4wwzyIkKsXSyBcSxQ8bfLSKiYH2PI+PIpBQMIYluShf+QqBln1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625773; c=relaxed/simple;
	bh=+efdQf5cLlAt8xNFBURfx6ooWHxzt2Y/0ClqNFyG/Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYq7rbgJxymafh4PX/rX3d+hU3XW7KVqdBJuH2D777h7P+yeQCZgPUX9Eo8MH8v3VL7VeaBfeEiPtmavHWnq9QDyjbv2liDHQ4VuGcxYpgEL57NrUlrO03jdE0ynqKxn37Ehg48S3wv0rUlORaYVFENQyyGgQVA2dJGL4YaLATY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axaNz0Ij; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747fba9f962so349945b3a.0;
        Tue, 15 Jul 2025 17:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752625771; x=1753230571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KG7b0qLVSsn5JbWgyM54NAxlyaG6RebnutmHkj5W+n8=;
        b=axaNz0IjPSSJE/GpGP3YKUihjMiatP7X1yOScuqbijjb31REPRfGtU5253+II8MVZr
         Aq/wf1j/wE1KaMeDFmh66JmUNizVivN+i7VvRQ65nyMBQK6bRsbl+UhQMDNv5ml1blpE
         HekAwY4ovRWMTp3HkuGdFESOhMFBl2U6wrekxvwHqrBrg7A38fJJiVlHsfTAO+bTldnv
         3eLg/JZ2fhDNZ8uZ/DiyXZ1lzettm0qgHPwSNQkHGt8mCkz7k5NJRcIHmJBT9A2myjfB
         +ZhrozMISWJjIaX2CQqSs0W7ZKFLAA5inbIKJGRtK+e5QO0okuwjQD97CNYaBWYrqHUW
         XvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752625771; x=1753230571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KG7b0qLVSsn5JbWgyM54NAxlyaG6RebnutmHkj5W+n8=;
        b=AXkYzKxQSkMg35pI4XbTFowfsYA2P1YGnM9kHyOkHzfC7daeoDXo4sNqwGI0svO7ES
         cqBI7xXLOJRZb2kblgqdUO748l3q8tIpl3Z2wKEg9SvlcemBFwdxQg7ZZoGAYLu/VYV+
         dDV6VrafuTwDEBR4gLF2pjCSM+WzxojkWxukpTYq/fXc3q4sQcAeRxe501BQu13pOfkS
         hTr0tZblMhzh7R9c01H1tEt+X0fD6c2hOjkEzzGFdVRTXRUJeDOEb9L/W6GEfsBY+sVO
         0I4qhEvHfUgglMWxM1AlDy+QVuZWaljRhZG+X629YCXeysOXvFmQMy/piPCK9m9feD0m
         fwiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKrDtIsob6pPvLiKtKA1/CPATh1xlt6AznQAxRdxVDCL9cxN1Z1/uNl3P4bG25MGKpL0ErwWZrn0yI@vger.kernel.org, AJvYcCW5ODjZRYcocQT0OD1KbCTc7LT9G0aWgTQtw5uKQ4bbM34b5RpZ/kNwkSQsbTH0KagLucFDOkY654+gvnRT@vger.kernel.org, AJvYcCWfigiqnVtEg3eu7nSQTbEqCyOOJhgCAmEheeztqoaBpeFnwghFqtccGaK/WotMKdM62/DiDbkY@vger.kernel.org
X-Gm-Message-State: AOJu0YzK8KRbv4cmdd8i8RMp6zmPLJhePRf1UvaogiubjxU66y/VxzGc
	YW6+3MH0fqCuqRYpB8woQty/KeFJ0IpSzzxqRARnho0GNoME79bn5h3K
X-Gm-Gg: ASbGncuFEMOfEhPGkz/qSie8RCB8EUqNvltE7djjbIgta4KIijagY5gj5/m3JmI30tA
	DizQXjfxyQox8fbQAC9pYfAvnoe0MzdRPcQrYvJ9CtTkKrx0nL1vSwaNnyPMxa3HL8K3V4mckyw
	CoVLmUMIXUSjjl2hWh53dlsTAlsmk4BX/aHUNj0z4ifUlroFFRzxagZks/mKTN/LzDo1FJCFeHL
	XChAoR1fgGsjg7C6xzMWLh+PK45lDORq7jazEGjmacOTRrTrBrdTRHZoxH2SdSfu/NDodsQVGhG
	TXSVode1/eD9NfwoFRtNLJyP21qCra4/Y0VUZCGQmQJh14Sz1/zYVMAolZV1afZj96hSJXz2HYi
	cC6hk+1fzR9h2zhi6+6i1wxD2e8/wknOk0YRa5tLV
X-Google-Smtp-Source: AGHT+IH9V2Q49YMKUDjTBc4USjKcyj0gOV+RrCAvnPWQuK+oUMf2+nf3H8yBLmX/J67DP37IA1LaIA==
X-Received: by 2002:a05:6a20:a108:b0:1f3:20be:c18a with SMTP id adf61e73a8af0-237e295f087mr1748101637.10.1752625770597;
        Tue, 15 Jul 2025 17:29:30 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm11145720b3a.76.2025.07.15.17.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:29:30 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/8] net: dsa: b53: mmap: Add bcm63xx EPHY power control
Date: Tue, 15 Jul 2025 17:28:59 -0700
Message-ID: <20250716002922.230807-1-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpio controller on some bcm63xx SoCs has a register for
controlling functionality of the internal fast ethernet phys.
These patches allow the b53 driver to enable/disable phy
power.

The register also contains reset bits which will be set by
a reset driver in another patch series:
https://lore.kernel.org/all/20250715234605.36216-1-kylehendrydev@gmail.com/

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Kyle Hendry (8):
  net: dsa: b53: Add phy_enable(), phy_disable() methods
  net: dsa: b53: mmap: Add reference to bcm63xx gpio controller
  dt-bindings: net: dsa: b53: Document brcm,gpio-ctrl property
  net: dsa: b53: Define chip IDs for more bcm63xx SoCs
  net: dsa: b53: mmap: Add register layout for bcm63268
  net: dsa: b53: mmap: Add register layout for bcm6318
  net: dsa: b53: mmap: Add register layout for bcm6368
  net: dsa: b53: mmap: Implement bcm63xx ephy power control

 .../devicetree/bindings/net/dsa/brcm,b53.yaml |   5 +
 drivers/net/dsa/b53/b53_common.c              |  27 ++---
 drivers/net/dsa/b53/b53_mmap.c                | 107 +++++++++++++++++-
 drivers/net/dsa/b53/b53_priv.h                |  15 ++-
 4 files changed, 133 insertions(+), 21 deletions(-)

-- 
2.43.0


