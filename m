Return-Path: <netdev+bounces-197718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A91A0AD9B13
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954F41896365
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893131F4626;
	Sat, 14 Jun 2025 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBAGF8pB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693391EA7CF;
	Sat, 14 Jun 2025 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888007; cv=none; b=NV5gaGJ65JW6oJ8HeRflyxYXKTRRiRI3GdDdsOHxOMJ91l9AvqBr5pi2rPwdoHSv+f8pTP6A4DvlFoG50AdBf4+9LrdFFf1j9j0/A6Slab9jSes5veXzXM+okvWYeHRyswD2LxJslY3ov01TMYjRjhURmZ3lWmi3Xd5Dk56TFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888007; c=relaxed/simple;
	bh=wx8XifZaDjRnCzS3v0hs6z7kuaDT8E356U8OcXLLePw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gCgSwoXOHEy90bEpvPWbkhi0u2n1Qc8xLvE8vti7saHQ3cW16619DCkL6RdivEuZGtsyQcGuVdxEo6B32BitWsHm5uUDJvf7Pmbc7diJDNkLJztvde7bu2vUKQFFzAUihMlXzRwrq3USg8nSUOaqMrV7C1kvGk8uMvs9Q0ytv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBAGF8pB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-442f9043f56so16565995e9.0;
        Sat, 14 Jun 2025 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888004; x=1750492804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuY7r4ivUNLHUWRuzIMvjwh5ErDtvA5lHBM3lRE0SpU=;
        b=bBAGF8pBJSeyzOUOAgusstI52YX+VMpg1GBQjfa9MNfbizbj1r+1cw6ljonzUaSEed
         6aAjJxvJ8divS5xLAzOqtT4+qByTYuRQ06KpLKYSjI8OkdKUe6VrbGNAfTmhOR/C9xde
         5DMEeidSQCw2FXcsBZpkxaxxopSIvKEZ2aHHaxr94GvCBOpuYeyybWYDSU4sri+Qzti8
         ziDok4WqxzD7D7ce4FvwrZQUMrpAnRzK3IjDMUwfJHGjAJvdPA+To+2vFEooEHw0lpUE
         727j4nrgOgaISNSnnv7o9rTPrSGvn5UVLbrx7eLZyA9MCuXisFkNeDsFXQU4CixbjkV6
         SfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888004; x=1750492804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuY7r4ivUNLHUWRuzIMvjwh5ErDtvA5lHBM3lRE0SpU=;
        b=SrXE/mBpxeETd4PuIib2VwFL+JQ0u6BrTefugOHaHnZJfdVQOX1hApqOLG24bf44/D
         rTYOW6C/sEXtvTxh+57w28F7qTEkhizPsESj17V9Q/nTez5WuIyS35T7al+eF7PgEZ4x
         HmFA9QNTzZWGzLgKVVjGLvj3qgeqh+Ucx5UdOB2m4fwnrNJHgMzaYIUXIz5wmmvYBZ/8
         cyZeum2JRXLqZUnq0bFHbec2/RWOq2RTxEEPZC0NKOnBzmQ2UIuggxrFyrPvzoWaJLvk
         GOvrpHRcrqaPnxtIV2hv1Oa50sdVS/EaqD1iJQHWv5RnsVMGwRMtJQpUSLLXZhHcKzKP
         1J4w==
X-Forwarded-Encrypted: i=1; AJvYcCUw6SayXhehN3lpeTFubJQSK66U0ite1F7lUh1iI44JbAt+KDmSBVpNdOu0nexOVaQ0nkFyOu/A@vger.kernel.org, AJvYcCV2re1gfBkz1mJhmjo6AWzv4UWG+xeZWxDNyFrSDjE29kGoeqYz6WYg71UEV9ICRwtVPvJJIUIQ/AiqUu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoUffSe6QC+Hp5yTB8ojQeGR4KtV9+Awzi81uDGsnuukCF6mE8
	cvK73faQLo9Wra0we22PIz5PYbccY2GO32g5F0Ic6qtWZGvvfZXkvxdV
X-Gm-Gg: ASbGncv4WmRfVAHrRmlaidQ5d0cFwVXc/MDwFl0j0mqS2yJ4ZrjZjyqIkb//57seblv
	3IOEl+DQDnVYj4kS5AGqh7dFL+Yf8Kba2OUHwNUmCqJevq9Cnq/y9qCTsjoS8T+7Ka7Xk/ubi+H
	e5vx4XTuWzvB+kklusH0YKtkbx2QhpTtNP7lzHZ5AJ57Gx7RfyTd1sqpKInErK52X12m9fd51BG
	fR/5Mll0pRg97KuKvMbL8/kP1dSSq8n9lJ9G5ZSohVAk8lHnnaLxiawsC/NXh0jgdOdRDW6RoqX
	Wg7fn3HBczytUF3/fFCb/Om1E04IvIHbnfsEOMGBSx7O+YeM7apeN4Ar+AmdQkfe4BeoJq1Jhkd
	xQzpjn11TMUDLrEv31SpKm3w19AGsyF94/mQYaNSVS3jOLiDMBquJ5CaVT47xhIo=
X-Google-Smtp-Source: AGHT+IFUDkpCFC9H+hNuX5rsLEkufRV3NRehCYGMqUeaHnfPXJFM3pWQZ+sJOpToHDdbgxqtrzZzQA==
X-Received: by 2002:a05:600d:10f:b0:452:fdfa:3b3b with SMTP id 5b1f17b1804b1-4533cadf885mr13540155e9.5.1749888003430;
        Sat, 14 Jun 2025 01:00:03 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:02 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v4 00/14] net: dsa: b53: fix BCM5325 support
Date: Sat, 14 Jun 2025 09:59:46 +0200
Message-Id: <20250614080000.1884236-1-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These patches get the BCM5325 switch working with b53.

The existing brcm legacy tag only works with BCM63xx switches.
We need to add a new legacy tag for BCM5325 and BCM5365 switches, which
require including the FCS and length.

I'm not really sure that everything here is correct since I don't work for
Broadcom and all this is based on the public datasheet available for the
BCM5325 and my own experiments with a Huawei HG556a (BCM6358).

Both sets of patches have been merged due to the change requested by Jonas
about BRCM_HDR register access depending on legacy tags.

 v4: introduce changes requested by Jonas and other improvements:
  - Fix line length warning.
  - Introduce variant_id field in b53_device.
  - Move B53_VLAN_ID_IDX BCM5325M check to variants patch.
  - Reduce number of ARL buckets for BCM5325E.
  - Disable ARLIO_PAGE->VLAN_ID_IDX access for BCM5325M.
  - Avoid in_range() confusion.
  - Ensure PD_MODE_POWER_DOWN_PORT(0) is cleared.
  - Improve B53_PD_MODE_CTRL_25 register defines.

 v3: introduce changes requested by Florian, Jonas and Jakub:
  - Improve brcm legacy tag Kconfig description, use __le32 and crc32_le().
  - Detect BCM5325 variants as requested by Florian.
  - B53_VLAN_ID_IDX exists in newer BCM5325E switches.
  - Check for legacy tag protocols instead of is5325() for B53_BRCM_HDR.
  - Use in_range() helper for B53_PD_MODE_CTRL_25.

 v2: introduce changes requested by Jonas, Florian and Vladimir:
  - Add b53_arl_to_entry_25 function.
  - Add b53_arl_from_entry_25 function.
  - Add b53_arl_read_25 function, fixing usage of ARLTBL_VALID_25 and
    ARLTBL_VID_MASK_25.
  - Change b53_set_forwarding function flow.
  - Disallow BR_LEARNING on b53_br_flags_pre() for BCM5325.
  - Drop rate control registers.
  - Move B53_PD_MODE_CTRL_25 to b53_setup_port().
  - Replace swab32 with cpu_to_le32.

Florian Fainelli (1):
  net: dsa: b53: add support for FDB operations on 5325/5365

Álvaro Fernández Rojas (13):
  net: dsa: tag_brcm: legacy: reorganize functions
  net: dsa: tag_brcm: add support for legacy FCS tags
  net: dsa: b53: support legacy FCS tags
  net: dsa: b53: detect BCM5325 variants
  net: dsa: b53: prevent FAST_AGE access on BCM5325
  net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
  net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
  net: dsa: b53: prevent DIS_LEARNING access on BCM5325
  net: dsa: b53: prevent BRCM_HDR access on older devices
  net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
  net: dsa: b53: fix unicast/multicast flooding on BCM5325
  net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
  net: dsa: b53: ensure BCM5325 PHYs are enabled

 drivers/net/dsa/b53/Kconfig      |   1 +
 drivers/net/dsa/b53/b53_common.c | 284 ++++++++++++++++++++++++-------
 drivers/net/dsa/b53/b53_priv.h   |  48 ++++++
 drivers/net/dsa/b53/b53_regs.h   |  27 ++-
 include/net/dsa.h                |   2 +
 net/dsa/Kconfig                  |  16 +-
 net/dsa/tag_brcm.c               | 119 ++++++++++---
 7 files changed, 408 insertions(+), 89 deletions(-)

-- 
2.39.5


