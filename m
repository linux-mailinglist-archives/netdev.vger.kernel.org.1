Return-Path: <netdev+bounces-240811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06CC7AE2C
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F213A1E7E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E21A286D5D;
	Fri, 21 Nov 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmWZlj2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F13285C88
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743194; cv=none; b=bFxGxca8GQBflUlsS2VSkGaoG7xdlgHG0I2uVB4LPZ4CCMQLUlQ9lb0aK7FQAUhKlIOLJg4lI+HCV4b92A28U1bJYTyfmDojZnP8oBra3h6fZdQRM5Bee707eAZZ2vWbyViKRbfISrGREuL6sr9EQJkxriAzfG9lxB+ESX7ErVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743194; c=relaxed/simple;
	bh=tQBbJqBLvxVOjcMuI46orS1VNYDV0ORUa5QJx6jvvOU=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=AkpO44InOJQHjfYcT7p4mT6Zm9bauU/AXhXWp0bUAzMAG1xfj8ExSROhvFaxwEyumdGy6MgPbXbuonY2rpT8WU9GQEy0HmS9P6P0yl7dpNn3YD1+fWZa5mE+9E7h1sEJO+f7EH5MZyh+q+gPDE0v7P76fHKn3Y0UFInDdoZ87/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmWZlj2o; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-794e300e20dso1819582b3a.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763743190; x=1764347990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=aOIvzR6LRlROF10XjfHXzrSCkv5N4sk+2Pw15FIzmvs=;
        b=dmWZlj2oqUENrsa2ONMokoPI4mKzUm2gWOmlkqnz2C0VNIRv0hsLyc4uBa86/I10oZ
         vA8VNWUa+iJiEGRD8flGerWnIKprHx3fbQXXh+EYqovP0l4/EGPQJYKDssZQM/QRhLbZ
         4iKENCr4MlyqM10IVkFBwzBDXbkQG4SXk01RYAwBmqg3T2tzB8yPgqFYlX3i1LU0cNvA
         4BR0u7uOZ8xvcAVbHwWkdYWqFBcDxiIAoM8G2GELOUqcLWX496jLi0dd0pe6eokV+pYL
         +8bXkvLo6KAZvxhLs/7QsVWdRwiS2ViuEBc932lE/PGULMq3w8CZsLr6KhOdRlnNrqie
         jWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743190; x=1764347990;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aOIvzR6LRlROF10XjfHXzrSCkv5N4sk+2Pw15FIzmvs=;
        b=AOpQ2qZOBDOGzISQNc+EdCbP8dErhej5ZscYRF0qbZxaqJaeK1fJ13bipWlA3RsgeM
         jR9Kc3ai1pyt4aO7XyS/CymIySdb++h7iqU/yVBUtxF+pLKrBOfpIf3u85wynImUIJ3b
         3iXztRlCDSPLySa6gIRmfQq++2eubBcXI3I6PF+KT+PTGlOKIHAi+ij0pHLc9UXmyPCY
         yt4xK127FmJ5uPjdVC9YwmgS/Ko0H3zHcPs2LaWVc9Kv2Hv1TXSlN0+8bF+4B80lfSLt
         +kRQw02isEEOqr+6qq9FWroxBmJu8gUXUPDMzABCbHvO9HRR0K4tulPB5gkh4jf6t7ft
         LRvg==
X-Gm-Message-State: AOJu0Yy3JTJY0ondaFTffbA1hI6hTX7Ws/yOufPtwg7IC//jDlRbShcO
	p2FvIP419V6zKbwu9L4dC2iY7R02Yv6Pt1ucp9HCo+wIaE8uvL1NFzAS
X-Gm-Gg: ASbGncuFj9Lrmal63d9si3rbuGFYljvRePSVER5hXGU27awDxAPFx+bHIecfKRkMOCp
	NfikiIBYySbDx7e7Ke4Kd5AIiPXL40qTteDQW7W9ORG6NEmAg7FMvUDpJAPfmeWswcLYaU8cNAk
	IUzeisQfw9JeOm2Ee4LXbW4To8RebgJ1w9byFMuidD9sOadMe58H0/sSk8GPZXEOpxRe6oqW8Jz
	F4bE/QlaGvnOuh2EJO5qoMpnrZz/Aj1diWPq83N7CTfSn7SAMAjfO2O54ny+KQR9ua6+PsoRylj
	kQ7mP+D1jzO3FmtFU+lh2L+XwM9WZnxaMLDHNMIxqzeSgki2/AbBeDOLhZDVWXL59JU/qeX0N5f
	xNZ830rd4damPkC60znwiTr+Sn1sg5MnjaXrYrIOA3aO1yjcKA3IzNT1lhcvhB1svoJMjWdDSM+
	1LdLoRAfv4bUUNdD3/1YKtGvS2d5SWVljuLcr4yeIfh4TmVztl+j91WwI=
X-Google-Smtp-Source: AGHT+IF+m34vPuVaL2WgPfgaeF+wWXp1e3Nk+MIu5VybPdGx5M2ngrJ6OnYNW8SuXSZCImRpAp7zyw==
X-Received: by 2002:a17:90b:3a84:b0:340:c094:fbff with SMTP id 98e67ed59e1d1-347298aa082mr7012512a91.10.1763743190502;
        Fri, 21 Nov 2025 08:39:50 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f174c9dasm6521697b3a.65.2025.11.21.08.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:39:49 -0800 (PST)
Subject: [net-next PATCH v5 0/9] net: phy: Add support for fbnic PHY w/ 25G,
 50G, and 100G support
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 21 Nov 2025 08:39:48 -0800
Message-ID: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
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
the fact that we need a representation for the FW managed PMD that is
actually a SerDes PHY to handle link bouncing during link training.

This patch set introduces the necessary bits to the XPCS driver code to
enable it to read 25G, 50G, and 100G speeds from the PCS ctrl1 register,
and adds support for the approriate interfaces.

The rest of this patch set enables the changes to fbnic to make use of
these interfaces and expose a PMD that can provide a necessary link delay
to avoid link flapping in the event that a cable is disconnected and
reconnected, and to correctly expose the count for the link down events.

With this we have the basic groundwork laid as with this all the bits and
pieces are in place in terms of reading the configuration. The general plan
for follow-on patch sets is to start looking at enabling changing the
configuration in environments where that is supported.

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
v4: Added back in defines for MDIO_CTRL1_SPEED[5G|2_5G] w/ comment
    Swapped order between adding new _PMA_ defines and fixing the 5G/2.5G ones
v5: Dropped adding support for 25G, 50G, 100G to genphy_c45 driver
    Replaced use of MDIO_STAT1_LSTATUS with MDIO_PMD_RXDET_GLOBAL/0/1
    Dropped PMAPMD naming where possible for just PMD
    Dropped extra logic added to track link_down_events as it was redundant
    Updated patch descriptions to try to more accurately reflect their changes
    Updated PMD state tracking to address possible races

---

Alexander Duyck (9):
      net: phy: Add MDIO_PMA_CTRL1_SPEED for 2.5G and 5G to reflect PMA values
      net: pcs: xpcs: Add support for 25G, 50G, and 100G interfaces
      net: pcs: xpcs: Fix PMA identifier handling in XPCS
      net: pcs: xpcs: Add support for FBNIC 25G, 50G, 100G PMD
      fbnic: Rename PCS IRQ to MAC IRQ as it is actually a MAC interrupt
      fbnic: Add logic to track PMD state via MAC/PCS signals
      fbnic: Add handler for reporting link down event statistics
      fbnic: Add SW shim for MDIO interface to PMD and PCS
      fbnic: Replace use of internal PCS w/ Designware XPCS


 drivers/net/ethernet/meta/Kconfig             |   1 +
 drivers/net/ethernet/meta/fbnic/Makefile      |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  15 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   2 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   9 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  34 +--
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  81 +++++---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  41 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c  | 195 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  11 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   9 +-
 .../net/ethernet/meta/fbnic/fbnic_phylink.c   | 184 +++++++++++------
 drivers/net/pcs/pcs-xpcs.c                    | 136 +++++++++++-
 drivers/net/phy/phy-c45.c                     |   8 +-
 include/linux/pcs/pcs-xpcs.h                  |   4 +-
 include/uapi/linux/mdio.h                     |  23 ++-
 17 files changed, 613 insertions(+), 147 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c

--


