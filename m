Return-Path: <netdev+bounces-237253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81721C47F4D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035E33B6C25
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF4325A340;
	Mon, 10 Nov 2025 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz1FX7JE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A22147E6
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790458; cv=none; b=ktGZ0esmyXdHO+sLEFbXfxSt3oUK6LSakRtow5bjGWaYk/rbnQ1vU38FT8pQu2rD0PFuLtTfzZKs/OO6zoxMyAGMvtPtyYt61iBqoYikULeO5LTuGmHfU2psMHdH5TIOQmiHcW99TA/NGVbqRtjpPpHQbZyDuWWk9Vnml9urThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790458; c=relaxed/simple;
	bh=YKy6nf/WLesO+4dyp0Fli6ZEcoUscJSJks9BpyhpdHQ=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=DrSSWAVsXN/gAls5zOLiMrwxCexRal5P0IwNVFkzugBi9tbXVwVgmTTsfsmL9eX9jbopWgbfv/4nPstgk8OUbZgelsPJyJiH68Mk3QWhvmJ+1zxdlBi3w6ANMJZuUizLp/0odwXs+U6ymjtQk2E0WQDBwFodKVxKcEPNm0duZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xz1FX7JE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7af603c06easo2932033b3a.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790456; x=1763395256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=f/vL+BwfikbSCE8G55Qulmyt0hKx4dL0IdL2jb1WbT8=;
        b=Xz1FX7JE+cTqmGzEefIJtcP3IaUs4oCRpmJNyC2Y9q7PvU/uu7cKEnBut0aEcDwYCv
         QrbwI86gxddiSEMGQDnLjARC8rj8VpNy/O5uISDR9O/pRexpoJeHsZsJ5HhlzWRcJtJN
         xvTHcsSLV+k3SK5BtZLtiedczVfif+Sw0LCu3mN9t/YXpzsCG29odosMJq5RCwycXhDg
         YuhuWTL8UCdvjnPPYjfKTCSp+KOFnZXMigjvlzGZQuy2ESph9KCE5fahfLwaVViDRSvn
         +gnuMkvhnxGuGtiS9+gFfMk4A60WjhkWFkZDWOnq8ps/+Jj4nZDebBr8FbAoGupIKejP
         IpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790456; x=1763395256;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f/vL+BwfikbSCE8G55Qulmyt0hKx4dL0IdL2jb1WbT8=;
        b=GBuygerFJ52Y65ByS7iIVqhLAzM28G2p+bpcuOfCjcPjrk0YkLp1CHUxaKRWVl2r1i
         023GpI+R1o3vFv4IbI5JvsqZqIK14Wya+Iyrgfp7ZyMGjahRDeWqrP1ihzEh71XUh/eL
         AVBOXbVZv81mzlTR8gxoJgwFtFPQpZS8n9ESIwVDTtKjJvT1VuE9xPCGIaodSxgiQDH3
         oZvhfJg8wEjmzm2emVKTCeMs58kXl2EZ28hO+9QDMyeKOzDE5+fAlg9823/cl7RWkkZZ
         kA/weTpXci8Iqw5ocKu2RJs1udaOvAIn+AumF6HJZZNLnGiAz7fM84FMYqz0Wrt17njo
         vWWw==
X-Gm-Message-State: AOJu0YztcAGAmZ3a2UrkaUZvEbu5D3Rbi+uOcnGt5qKx/PRRuQ11VW5S
	emK0rZTC/3vvfFrpPhkcy7SSF2141kTybu6Mc+VwJMhM0aZVLErKuFM1eUSwaQ==
X-Gm-Gg: ASbGnct0HzFzHzuGrB2wYH2vgr6Hb/Tb4s3QUTs7og+zUXM0XLpYobqz+oP5YzBkGB1
	zlqE5rulqSzl4IBvL/sLzFCtQ8sDIHGCknHxK0le1fcwTvP+YOx9fivH6n65FsmSaTqiIX8A8LN
	fBJ7TNxay/E56d/5Q6u5oxftd6k7e+YQEJmam9tfiPKjsdi+vzKrZ3+ojDoCpPPb55zqc0oOh48
	Udim6O4Lfh6MZ9jxxuuC++zqMkOTYFEU/zIrlaiNCQjd39gurCk56Q7LHyHQLm5epMji98h6DgQ
	2mju2gw0BTl19z3gcrxEJwX2ZUn24eUZgORyNS7JfZgMqRGO0wdXMXEADRcMxd4FQawZhfp7hze
	++cvdR+wMGogbAC1+qL7BpByscyCqV/t7ks18TyCOMG0DLTykTR4ZsHJLvxD2mAX0czj2OtP/Gw
	HOUnbo1BA8QohOQ8TcfG0Ma/aQTHGFwU7vg0Ol1BE0WXre
X-Google-Smtp-Source: AGHT+IEBSOtygxSsJANK+fchIIPKYEmhowZlPstLfF7ZMZ3KiL5Jcf1jLkiKyQkeVZycLwP0ZLVaCw==
X-Received: by 2002:a05:6a20:4306:b0:342:1d16:80e with SMTP id adf61e73a8af0-35388831928mr11661571637.4.1762790454412;
        Mon, 10 Nov 2025 08:00:54 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17784bsm12485053b3a.47.2025.11.10.08.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:00:53 -0800 (PST)
Subject: [net-next PATCH v3 00/10] net: phy: Add support for fbnic PHY w/ 25G,
 50G, and 100G support
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 10 Nov 2025 08:00:52 -0800
Message-ID: 
 <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
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

---

Alexander Duyck (10):
      net: phy: Add support for 25, 50 and 100Gbps PMA to genphy_c45_read_pma
      net: phy: Rename MDIO_CTRL1_SPEED for 2.5G and 5G to reflect PMA values
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
 include/uapi/linux/mdio.h                     |  18 +-
 17 files changed, 592 insertions(+), 153 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c

--


