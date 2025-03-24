Return-Path: <netdev+bounces-177095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB32CA6DD57
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFDF16DC8F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA1025F79B;
	Mon, 24 Mar 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/XXlTPj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C428502B1;
	Mon, 24 Mar 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827679; cv=none; b=jB1PqE4J64BdCtpRNnc4nFjLQ63CpaenLi7oibpu9bM3YdPLIcJLE8a8b28u/yByX+kmcExHqslMVoBh8u8s23Pc1c/JSuipDK444OT3xHCArSy9H86LbVbeSJQETKx99HE+5orqTuvl4uUQNnzJBgEovueY2C5B8Ar8uY+Dc54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827679; c=relaxed/simple;
	bh=f5WoR9C6FEyWk59i9LulIupWqmrwbOKvqOYOe7GwAu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k/SQU2pGnjh2Q3a3NtS38NIjlPahTaR8ZHWAim8B9wpSOAor/JSZMJgjgR93BJUdKEfBr73wsa3Mc9I8+sXoGQVYeKoO5WCZHCW7Bad1DQwU837d54xqymtI1UGW+/djx0irsTN/D7zNQ59g/qo/uTWPLTWPkgMyFNOjyYiyMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/XXlTPj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742827678; x=1774363678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f5WoR9C6FEyWk59i9LulIupWqmrwbOKvqOYOe7GwAu4=;
  b=h/XXlTPjS+lT4FKh8dhFKc6wS9D6NY9nvFrjDmx/6uANjptxYFVUmTGr
   4MLdN+B8z1b4S7ybmww4aAsoBl8fHqUUFatuP70JrBKVHMzwHI2oiEE4c
   WDXUdj62NDhUj1ASF8y+X/qRD7b7kD1QcapWY/1Cou9mx3+Awpei+55nF
   mLUQK+Bi1DFcS6zZtCzov73+Z/TFgENI4SOdpAIbE40+HudCR3IuN81yR
   IohVelVBuTSrIqHtWAeUwraHnlWb7DEe2XFy69cejmv/WLh7p42rw5xKu
   r9gD2fqNMyRN/Ita4MeBit5wYdPix15UwmBxZ97GLPgiFHa75mY6SPjS3
   Q==;
X-CSE-ConnectionGUID: IUGEw9AMTIOqG31Bwir05g==
X-CSE-MsgGUID: FkYqy9krQ6uaG4tVKzdkug==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43192104"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="43192104"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 07:47:57 -0700
X-CSE-ConnectionGUID: mflDKyU8RZSX5K+kLVs3bQ==
X-CSE-MsgGUID: 9t6lR2ANRYyxLNct16mZEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124022002"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2025 07:47:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D6B2126F; Mon, 24 Mar 2025 16:47:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net v3 0/2] net: usb: asix: ax88772: Fix potential string cut
Date: Mon, 24 Mar 2025 16:39:28 +0200
Message-ID: <20250324144751.1271761-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The agreement and also PHY_MAX_ADDR limit suggest that the PHY address
can't occupy more than two hex digits. In some cases GCC complains about
potential string cut. In course of fixing this, introduce the PHY_ID_SIZE
predefined constant to make it easier for the users to know the bare
minimum for the buffer that holds PHY ID string (patch 1). With that,
fix the ASIX driver that triggers GCC accordingly (patch 2).

In v3:
- dropped format specifier changes (Russell, LKP)
- added predefined constant for a minimum buffer size (Russell)
- updated error message to refer to the address and not ID string (Russell)
- changed type of phy_addr to u8, otherwise GCC can't cope with its range

In v2:
- added first patch
- added a conditional to the ASIX driver (Andrew)

Andy Shevchenko (2):
  net: phy: Introduce PHY_ID_SIZE — minimum size for PHY ID string
  net: usb: asix: ax88772: Increase phy_name size

 drivers/net/usb/ax88172a.c | 12 ++++++++----
 include/linux/phy.h        |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.47.2


