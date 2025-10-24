Return-Path: <netdev+bounces-232680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B9AC0814F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F21E356DD9
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566402F619F;
	Fri, 24 Oct 2025 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNlWXiWV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9C2BE7B2
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338437; cv=none; b=n3Bco7Tt/DjUl15VdRP+9uf26gQQ+GyYSFFrLP0WA66nBe9K3h5etNglTgxCPR7wNRa9UZeSLZ013tlgRGXDpcwbEVEvoyEVZiYfnRTU5UvyD2iDXA8gatJ9ZL4+10Wxjg70XV/QFUmHVhgxv0Sjm1n2I4eLrY0RXGeDD+pkQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338437; c=relaxed/simple;
	bh=uSWnJ8OU/N2HwYnYhuuF4j75CdGYPNIRwWaENk4W1SY=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=mt0pwUyYIzRiW4/+vXwSh2MiFovEHwiMuBIoGjThVQrOm20sxliTG3CVaLECzhhpuO4uZbun4WyfKeVMwpkyhoR+MOqQ9l/BwTfWnWUldePIzF0Oe9v7iT6opeZjrdV9W+ZaBQzHP4RB8Eqm7mxXidIq79vFlsRZWtNmLK1K1R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNlWXiWV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29476dc9860so19032215ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338435; x=1761943235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=szvWGQTczW8nEw+tRngFFf52+4pIMax1CzFPfFGJSsA=;
        b=hNlWXiWVsmXbxFR+b9tFGkxN6bZ5DnM8dRDh+WHy7FRwIh81O8CueetqG50Pi9BNZn
         jvgCafdwdVhKPYP92kVmXGrhva0oQF6VE+EWKzqqW0yo+//o3E5ZsEw38tfMcNo09KMr
         /QGwjGwpjQMVbNTWT1T2ZerB0D5VdH6vI6mwIP2Qt9yzNmQwa+kdKeBo8KmAR7JQ9Mn6
         gfVjAtdOXK88aVOFbWUHh0IIVzJ/Uqwa2EBovCiC7lbK3WNg9t4Acf2KiRXH90uzoRbs
         0jIkpF/+51xAa3lM6ve617Qqxi6EJtEmNaMIvc3Q5cXLRGVLGy94YCAyyqz14rN+lN+o
         L0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338435; x=1761943235;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szvWGQTczW8nEw+tRngFFf52+4pIMax1CzFPfFGJSsA=;
        b=IoFupAEEYk5csClMAUlpYyhvTuwod7GEaKaGfgZUnA9HvjNvdfpwXzsTX7GhR7xDDg
         yo3RqblXuZJw8xZ5TfexjafFNOPjVpj2Mp47SOEnkrG6KFTkhTf12OFn/S37GEHFzhZT
         zzPH8pqH3a4JKLQ+H46tub8MURY26wcN+RKw1qpiZj4qL4iMik8CREZJQfN6UMyhDTH8
         jxqqGFvSCMTfw0YznB9Fw4x9pL4GnUuaCObSHHVxDC1kxJ8uICfxssJC7CBhZ2jIiLov
         O0Ehp6fL/7L8Gq6WYk1sAPa31MTEaU7MAdOFgdAXGZnFQuqh61f4zu2XIAnBI/weVcqn
         m4sA==
X-Gm-Message-State: AOJu0Yx25p2tYFqshINQk87NglaGdQv5M+UUzYf5wvOa7akLYXAOxT/d
	J2Z92m6cpn1bnhOqE3YRJ25jrf4eGWJ48gDY88SeGFwUazOGqznYDvDA
X-Gm-Gg: ASbGncszXep2+hy/xEc8uu2lBPwUJ23KVyqjAjJ+bboD5+tDt6bEjAjKnMIz4sDHIuy
	1du4CKRCWGqXGQS50kQs2xnCLiHgrKNm8Y2ByPMtQxW9SMhjup7Hz4MnVMTpdE7zWMnlFNj4y7G
	9ABv8/E0iDFC4elmspz6sCcGFcmy3Md7dgqQtx6otJMj/tlhaGLVRhVpu2WuCL7l9IRuR0LN7jO
	i8ND9OqSKvG0BHvG5eOVqdq+9+FVbHHj1lrgTEkG6rxZc4m0McZkf3pgNEw9FxnS66owSCOz227
	Iypwf0aF0Ns5zZMVyi65c+Zzyrsxek8XFLJpaIhFZUWCTuTgu23LxV6hqnnrgmCH1guLoJb426v
	6EWYqap2PvUIDGkKkQgTaB2eV/pSKaUFEUCPaqpGUnnKRmPYCG/wymU7QW80fStVCf1tH864bms
	I5ogHRdMwAIu0Nnu2gDCGASqCDPzRMuareZw==
X-Google-Smtp-Source: AGHT+IHsPUB6EliKg4EkONnJHT2FfL+i3SVnJJ0ykEh2yOX3Q2Q7d6UC7JConAtPLRA37vhmiirM6A==
X-Received: by 2002:a17:902:d489:b0:293:e12:1bec with SMTP id d9443c01a7336-2948b97773cmr52490515ad.20.1761338434988;
        Fri, 24 Oct 2025 13:40:34 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e3d2aasm1192475ad.88.2025.10.24.13.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:40:34 -0700 (PDT)
Subject: [net-next PATCH 0/8] net: phy: Add support for fbnic PHY w/ 25G, 50G,
 and 100G support
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 24 Oct 2025 13:40:33 -0700
Message-ID: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

To enable eventually transitioning the fbnic driver to using the XPCS
driver we first need to address the fact that we need a representation for
the FW managed PMA/PMD that is actually a SerDes PHY to handle link
bouncing during link training.

To enable that this patch set first introduces the necessary bits to the
generic c45 driver to enable it to read 25G, 50G, and 100G modes from the
PHY.  One complication to this though is the fact that 50GBase-CR2 doesn't
exist in the IEEE version of the specification. For now I am taking the
approach that the PMA can show a speed of 50G in the CTRL1 register and set
the PMA_CTRL2 register for 100GBase-CR4 as I am using that as an alias for
the 50R2 due to the fact that the media used is 100R4, it is just shared
between 2 instaces the 50G interface as per the Consortium specification. I
am still open to suggestions on other ways to implement this as it isn't
set in stone and changing it would be pretty straight forward since the
only thing currently impementing this is a SW based MII interface.
Otherwise for 25R1, 50R1, and 100R2 the interface matches the IEEE
specification.

The rest of this patch set enables the changes to fbnic to make use of this
interface and expose a phydev that can provide a necessary link delay to
avoid link flapping in the event that a cable is disconnected and
reconnected, and to correctly provide the count for the link down events.

---

Alexander Duyck (8):
      net: phy: Add support for 25, 50 and 100Gbps PMA to genphy_c45_read_pma
      net: phy: Avoid reusing val in genphy_c45_pma_read_ext_abilities
      net: phy: Add 25G-CR, 50G-CR, 100G-CR2 support to C45 genphy
      fbnic: Rename PCS IRQ to MAC IRQ as it is actually a MAC interrupt
      fbnic: Add logic to track PMD state via MAC/PCS signals
      fbnic: Cleanup handling for link down event statistics
      fbnic: Add SW shim for MII interface to PMA/PMD
      fbnic: Add phydev representing PMD to phylink setup


 drivers/net/ethernet/meta/fbnic/Makefile      |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  15 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   2 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   9 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  42 +++--
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  69 +++++---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  39 +++--
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   7 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   3 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   7 +
 .../net/ethernet/meta/fbnic/fbnic_phylink.c   | 121 ++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_swmii.c | 145 ++++++++++++++++
 drivers/net/phy/phy-c45.c                     | 164 ++++++++++++++++--
 include/uapi/linux/mdio.h                     |  43 ++++-
 14 files changed, 568 insertions(+), 99 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_swmii.c

--


