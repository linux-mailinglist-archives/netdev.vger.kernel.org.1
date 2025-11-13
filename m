Return-Path: <netdev+bounces-238439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6271DC58D8B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474413B72E9
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1878A358D34;
	Thu, 13 Nov 2025 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWvR+5OX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712013559EE
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051580; cv=none; b=FGkxSQLnLpMYuxpdmYfbHzRJ8ym7BAB7U0RzfZPDKYHlGFfCDTZcL3uxrveSJJo5M4OmVEv8W1//NLt5iz7kZT0jmjSPYXKyYVAoH29axLhU8Nfsq6LYCXDw1ZHM6XL09Ap+efDaXTKtSZBVn+CHLLRivbzga8AUqyY9Udp4JbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051580; c=relaxed/simple;
	bh=t6Fmt4wv7oAC0aHrB69ItO8hB+u00274+wAmHaYqlF8=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=n2xL9tGDTbDLETvl9DVxjKxYTzQjvrEDPstQZuAWB9J5GxLOb81b/7wA3cU1rD2w9WrVgRsp0ywmD5bslLBsgzF9QYhdZwU8nX0Wf8edKzBgmJV94AvftelZmNtrDJ20kqTTAapVfe5/KqgGHl/hZJcS4RHh+HsHmOBX+5WDTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWvR+5OX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295548467c7so11338855ad.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051578; x=1763656378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=toekOdBn4I50C10qOh4hWmRYNqt393qtwZ6s1C6jTlc=;
        b=YWvR+5OXMYPBMbpmv0qoTomZ5lvFhY6pEC2RWVA3l36kcbWhq69gS0f5qMENUxOIUM
         2/6GbaGFevCGi0Fwgv2cvKv4h4XFKgCjrV7Wk+056kN687I9mFZQWe2eC6y7zOILrlFj
         +QRqvfi0r4hQJsUVopb2GRH+AkP0eT8nJkOMSfKC5oYBmJvsyii7pIPVJ6CLkc+yUGk9
         j65uUeyMP5MoTebm+dqD7o3K4Q7GAn3oXpTOWqRBfD2GMsr2OLmti8IrUZEZ9BY4V7Uf
         V4wGNa3mQbiyquaywGJSkuRYizCMBN6iXEEPzWC/oBIuuk+dgKARs1ujPSMxIQJas5zo
         I8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051578; x=1763656378;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=toekOdBn4I50C10qOh4hWmRYNqt393qtwZ6s1C6jTlc=;
        b=VwFuF3Y0oHHmylD92lAh+oU1IN4ReBoS+hHiSIJ+Jq+GCtmfydFTnkIfwFU+Jvomyt
         GCDA2DRp2OU0YIxpSKPfXJgT4HH7torj1RRKrZA7cCuq2E5oeQ7OJ5+FbW72pT2Fskw2
         TptmqfehN8BkdXLxI9bMLfIb4HWOwokssSH43BOPxF57NCZyUrSLtSucrRtDF37QSCy4
         WjKAy4wjMrnGYukVbsaRbP3BoplzWQ2VPAMWRlHOjnpjBAd52DW1RtNF14ihC05/XV7w
         vL1iSLWDUxSaNdHQqQ9MblqMfc0NGpGAnTrlCccSqTsX3efyus58OA4iIcmYx33KAhV7
         Mk6g==
X-Gm-Message-State: AOJu0YxtPJUkU8H8gGM0LavYh2KPoNygFlkk4u5nuxPG1NL8JRahZfLH
	Y+jcG57YpZUvUgrborvJXaQCxPAwyW1OMELXyEqNcba2ph1Ybxr0EcUR
X-Gm-Gg: ASbGncuGRyS69FTUHpxUuHKM/S5A3Hh4o+znj2vEAsZcDOL6pZTlpZablMX88D++etw
	sSFB3+ZBxFhkI6cyj94wVV0Q1fjifrNtnRNH4YeYzxYgKxnrlVgUxIM8IF3+/TSXQjfr38gIusT
	nF/eB7piKYONOn7mylqGyhlUbkcA3GVf4aON35gnTf1XeWqNhn9CPlPo3PWtP3bB5sl+oTpEJ7D
	ExEvXEJFwQFN9nXcJm1ZNluI6AwA/0UwmtEl+m2qe11ECtfsHfU3vnCBRdFIDYmK04PHwsds5c0
	ygMmjAAcfT6VbAJ/GuTRYjj1Wi8sRR45gPd1XTAoY3SWnKue7Qogo4nsr7a0P6E9ootwg/QmzjT
	XFVQ2Nxr1y7em0dU6t0akD1xPY9cVH/4w7FfEiMdy/qNe2VXc81pmOr2VcjyFufaPuq7Rraib9c
	D/YmNFs5q/gxHNTWs5EhQ0BqUi3MSJEMDoWA==
X-Google-Smtp-Source: AGHT+IF0vY/OxXg7W2wdjBEbR03RUrH8rAKJKTOP+B1UmMHh+Lx/bBcILWzv3kE97LxyBvcE3yHVSw==
X-Received: by 2002:a17:903:1904:b0:297:c638:d7ca with SMTP id d9443c01a7336-2984ed356e1mr79538965ad.14.1763051577767;
        Thu, 13 Nov 2025 08:32:57 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccc03sm30020415ad.109.2025.11.13.08.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:32:57 -0800 (PST)
Subject: [net-next PATCH v4 00/10] net: phy: Add support for fbnic PHY w/ 25G,
 50G, and 100G support
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Thu, 13 Nov 2025 08:32:56 -0800
Message-ID: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

To transition the fbnic driver to using the XPCS driver we need to address
the fact that we need a representation for the FW managed PMA/PMD that is
actually a SerDes PHY to handle link bouncing during link training.

This patch set first introduces the necessary bits to the
generic c45 driver code to enable it to read 25G, 50G, and 100G modes from
the PHY. After that we update the XPCS driver to to do the same.

The rest of this patch set enables the changes to fbnic to make use of these
interfaces and expose a PMA/PMD that can provide a necessary link delay to
avoid link flapping in the event that a cable is disconnected and
reconnected, and to correctly provide the count for the link down events.

With this we have the basic groundwork laid as with this all the bits and
pieces are in place in terms of reading the configuration. The general plan for
follow-on patch sets is to start looking at enabling changing the configuration
in environments where that is supported.

v2: Added XPCS code to the patch set
    Dropped code adding bits for extended ability registers
    Switched from enabling code in generic c45 to enabling code in fbnic_phy.c
    Fixed several bugs related to phy state machine and use of resume
    Moved PHY assignment into ndo_init/uninit
    Renamed fbnic_swmii.c to fbnic_mdio.c
v3: Modified XPCS to have it read link from PMA instead of using a phydev
    Fixed naming for PCS vs PMA for CTRL1 register speed bit values
    Added logic to XPCS to get speed from PCS CTRL1 register
    Swapped fbnic link delay timer from tracking training start to end
    Dropped driver code for fbnic_phy.c and phydev code from patches
    Updated patch naming to match expectations for PCS changes
    Cleaned up dead code and defines from earlier versions
v4: Added back in UAPI defines for MDIO_CTRL1_SPEED[5G|2_5G] w/ comment
    Swapped patches 1 and 2 placing the 2.5/5G fixes first

---

Alexander Duyck (10):
      net: phy: Rename MDIO_CTRL1_SPEED for 2.5G and 5G to reflect PMA values
      net: phy: Add support for 25, 50 and 100Gbps PMA to genphy_c45_read_pma
      net: pcs: xpcs: Add support for 25G, 50G, and 100G interfaces
      net: pcs: xpcs: Fix PMA identifier handling in XPCS
      net: pcs: xpcs: Add support for FBNIC 25G, 50G, 100G PMA
      fbnic: Rename PCS IRQ to MAC IRQ as it is actually a MAC interrupt
      fbnic: Add logic to track PMD state via MAC/PCS signals
      fbnic: Cleanup handling for link down event statistics
      fbnic: Add SW shim for MDIO interface to PMA/PMD and PCS
      fbnic: Replace use of internal PCS w/ Designware XPCS


 drivers/net/ethernet/meta/Kconfig             |   1 +
 drivers/net/ethernet/meta/fbnic/Makefile      |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  15 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   2 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   9 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  45 +++--
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  71 ++++---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  40 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c  | 190 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  11 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  17 +-
 .../net/ethernet/meta/fbnic/fbnic_phylink.c   | 163 ++++++++-------
 drivers/net/pcs/pcs-xpcs.c                    | 135 ++++++++++++-
 drivers/net/phy/phy-c45.c                     |  17 +-
 include/linux/pcs/pcs-xpcs.h                  |   4 +-
 include/uapi/linux/mdio.h                     |  26 ++-
 17 files changed, 600 insertions(+), 153 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c

--


