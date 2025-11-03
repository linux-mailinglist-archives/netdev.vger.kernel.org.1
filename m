Return-Path: <netdev+bounces-235191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF44C2D54B
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98392189D49F
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AD514A4F9;
	Mon,  3 Nov 2025 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftp4PjOi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB013164B7
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189199; cv=none; b=oEQH1kfS3v34ICeisf/tjzj+8IRJ+v0BWBIg2lAvHthIXAmi4b6OpHsGlCa/NG0MPWh83B0D8FhPXcviHoVllv0rZPXBCJjK/OuPtZoKtgeGZp7sdC+nnvNuqhYAstPZHYmqNYt8VpHN8/FUeRHU37er7E0W6ADmhPtcE21cePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189199; c=relaxed/simple;
	bh=jduiX4+B0EpmsyGzG4VAwApWtq+vPg/oJ1GFGo0QV+U=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=tlIQ9kZG05Jn4PemvGmuhd3dYIn1DZfLLBSBuKoAf9y0WpLTpPbz0dLWL0+pQ4ocpBEr8gUxy9eDLWtLQKOoCcVQxHDwbMFZE2WkRn2+i7xdG1ayqksZG1zq7HnANtnsj8QtYDkCRJ3KRPsLKm+3Wgt9O4lvEhXHnAw5/B1Avt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftp4PjOi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2955805b7acso14654505ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 08:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189197; x=1762793997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=1Xx8LUTiqkSFPFGHWmAu9UW3V7AlFnAnsHZWqRtTwlc=;
        b=ftp4PjOiDhKSZFauoVoINvvqSC1Qh9uueCEeBqNaSnOoyxWRkJxt5D8+BroucIqzaP
         G6KL+5KDk+uFp33YJW4VVc7Mvx3/vcMIozLMgbvm/3MdHuNSNCIJnZdEUstY0+09q+6u
         mgMRYX4TY4wTsQic/+kM6Iv744vKsrvbOkFJiFuKM1i+KRnpniYp36bKJNKwEx+QS/VL
         N+YprS/TrrtGWEY86MRt3HYUpHGMgjDsIZf0ySNdZ6OoDD7cW9xKDRC8k4akKUSXMr4j
         VPjsqWYR6F2kn1aJf5oVBDFJF6MCu6Ak3tyn/QmOOOQV6OGXD4uZtn0fQsy7s2m5TpVW
         SJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189197; x=1762793997;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Xx8LUTiqkSFPFGHWmAu9UW3V7AlFnAnsHZWqRtTwlc=;
        b=V3s+bcfM9pRXSamYn3BKeQi/e5f6/XhkguZurA077Q3bZnDVLw5R/4n0S0NmLaJDQ/
         mcAJ0Cz4QuhKtuoIhvDZHYwcZUSCMmqLu7xHMaBL4sApVi+kcOgz9TIF5Shk/xiLywUC
         iA0cPSJlPns9YRShOdrLK7Gs4lk1o5MwJxxK07Q/ouhhWaCxNjzDcmCV3dCwySgpQgJx
         V9M4raGUP7e94yq3xRhHGFJf2sFKrsOhCOuDi75r7+k6JRno4l1uZNkMEXKqeXJGr+bP
         +9CZUYj/BT2sno/YnqooCJ4AVm+HaC30I0bDN1KCtR+KbSJvRrghpy4t1pnQUadOC1dO
         VwJg==
X-Gm-Message-State: AOJu0YzhmZMBvcYLE22Ae1tkrjT2jck/FNdaTGnf/gQ3JqHLgwWsMVVK
	3d9uQEegstWjKOZH4eSagEV8WXIAwiRR8l/XQlCb2vVMFRqrOxrPn7xIKQp+hg==
X-Gm-Gg: ASbGncv5jukgOvAamv4eTJn/wTC7GVaFKJjl22A+xysio2x6GB2UiwyL9iQ1+SJCeWe
	iIEPvjou5Wnkmdn8tNdOrGlNMtyRZCJhb82f9dmchq8g4Ej6pIB0pzjruqvdm2td00PcETciYwr
	mjh+EBU5gU7KPGXqxSdE0KtwSK8G8nUmavRE7uH4YwHGl3FxgWZDA2PzDBLBAD4dnX4XEThuWcE
	WHYxgUSnjZyosci4UB71TeX3ejXTAkuf9LUtq9u+aLaq8F9OG4GskxBsbkuoe7nUc8D3EqpoOLY
	rubRL1rZxJ33F5Nap28SUn5Bos72+0kUEcOwVxOGRAbc5SvdwJLyVG9W6XPei3H5/lqVwXegMwB
	eecc9ziL3IMh1pv2J8zDqDYTsqgDfFJFVWlsjBtm1vYEO90lIm0rKXG9Oyb5G9LMZG5aqh1hdID
	9fGC45fIKAjxNT/03gjR/IliKmvTNDEroxl5GkLZNl1JNeXPkpxA==
X-Google-Smtp-Source: AGHT+IE4QDqhfwQtfNkJ8YyI3IvfEyLZq9rjXgqvU2XHZ+nNfbOZITcFngOyVUrBae6UAIgD2BSnzQ==
X-Received: by 2002:a17:902:ce8c:b0:269:8ace:cd63 with SMTP id d9443c01a7336-295f94fcf0cmr577045ad.30.1762189197053;
        Mon, 03 Nov 2025 08:59:57 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952774570bsm123830825ad.99.2025.11.03.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:59:56 -0800 (PST)
Subject: [net-next PATCH v2 00/11] net: phy: Add support for fbnic PHY w/ 25G,
 50G, and 100G support
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 03 Nov 2025 08:59:55 -0800
Message-ID: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This first half of this patch set introduces the necessary bits to the
generic c45 driver code to enable it to read 25G, 50G, and 100G speeds from
the PHY and updates the XPCS driver to to enable 25, 50G, and 100G
interfaces matching those supported by the fbnic driver.

The rest of this patch set enables the changes to fbnic to make use of
these interfaces and expose a phydev that can provide a necessary link
delay to avoid link flapping in the event that a cable is disconnected and
reconnected, and to correctly provide the count for the link down events.

With this we have the basic groundwork laid as with this all the bits and
pieces are in place in terms of reading the configuration. The general plan
for follow-on patch sets is to start enabling changing of the configuration
in environments where that is supported.

v2: Added XPCS code to the patch set
    Dropped adding bits for extended ability registers
    Switched from using generic c45 to fbnic_phy
    Fixed several bugs related to phy state machine and use of resume
    Moved PHY connection/disconnection into ndo_init/uninit
    Renamed fbnic_swmii.c to fbnic_mdio.c

---

Alexander Duyck (11):
      net: phy: Add support for 25, 50 and 100Gbps PMA to genphy_c45_read_pma
      net: phy: Add support for 25G, 50G, and 100G interfaces to xpcs driver
      net: phy: Fix PMA identifier handling in XPCS
      net: phy: Add identifier for fbnic PMA and use it to skip initial reset
      net: phy: Add fbnic specific PHY driver fbnic_phy
      fbnic: Rename PCS IRQ to MAC IRQ as it is actually a MAC interrupt
      fbnic: Add logic to track PMD state via MAC/PCS signals
      fbnic: Cleanup handling for link down event statistics
      fbnic: Add SW shim for MDIO interface to PMA/PMD and PCS
      fbnic: Add phydev representing PMD to phylink setup
      fbnic: Replace use of internal PCS w/ Designware XPCS


 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/meta/Kconfig             |   2 +
 drivers/net/ethernet/meta/fbnic/Makefile      |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  15 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |   2 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   9 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  42 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  71 ++++---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  40 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c  | 190 +++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  27 ++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   8 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   8 +
 .../net/ethernet/meta/fbnic/fbnic_phylink.c   | 194 ++++++++++++------
 drivers/net/pcs/pcs-xpcs.c                    |  72 ++++++-
 drivers/net/phy/Kconfig                       |   6 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/fbnic_phy.c                   |  52 +++++
 drivers/net/phy/phy-c45.c                     |   9 +
 include/linux/pcs/pcs-xpcs.h                  |   4 +-
 include/uapi/linux/mdio.h                     |  14 ++
 21 files changed, 629 insertions(+), 139 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
 create mode 100644 drivers/net/phy/fbnic_phy.c

--


