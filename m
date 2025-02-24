Return-Path: <netdev+bounces-169258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF16A4313C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BD81891697
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2909204687;
	Mon, 24 Feb 2025 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="WeYowFtJ"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B25C204F8B
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440649; cv=none; b=D071oohEbsyZh1s2zU/mwR4d2c7EqVVNrum9+VpcxPjy/3c6mr5qmFpMHr6gzbrOQ7+OM0X6yR8DwT1ZqHAsR2V4RogYGIjpCET/Yakf/hpHIHTR2cLVEz+clxrndVBzqk+aU6pHnPVLhX9PkkRfHRLw20KswXhxV69RNZaNHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440649; c=relaxed/simple;
	bh=d4turpF9X9f2NM3FiwT+FvE08uNAcenl7rCCNPQk5bE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KatnwBq6q8BCbY+eZLOKvQnwxtCwyK02vPdbuCqMatAjKZTy/u4lLzzNJN+MjzFDTRuVdkJXyqfOYjsdugIuEigEhNlOh4YPjRhh5wRER73N7ugfZWCSjIo6K/v0fWCkgRNl8F9fa8AlaC4sefBoXY4bnBJ1Z3fnYA5oF9Xwx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=WeYowFtJ; arc=none smtp.client-ip=173.37.86.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=321; q=dns/txt;
  s=iport01; t=1740440648; x=1741650248;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ffHZRcMhg5E1JPb1sUv04Tt48bVmVyvDlHyyZn9diO8=;
  b=WeYowFtJPREGAcry+ZZr5Z1t3XIbzaMI+zPVJNwHovg3OQAHwwXI3gXi
   6xnv3FoLQ9eRrcvdkJyudL/BqqXRu6F7UpUTVOB8odBmV469DO8TzWOYB
   o70DkKpTtq616tzIWwOl8DgkKOd7gxjZIQyzfIwIdec/flWcPv/b1pH1D
   blPW7QY8ws0JfSMdp3fa/9DD92ommA2Sz9BCn9zEsjDr00uKL52J9Ioj+
   HaudtZEuS/RdXVlyFqJeTsSS94v7U2wJs2OmoVDPHx3QV9OvfzZOpEA8a
   B95muwciYiCIUqqoghQPXVvMfSmCeioBaTlRe5/PG52emBP7sEoBiij1n
   A==;
X-CSE-ConnectionGUID: 6qkWC5z/Qe65ANU0Bc+HxQ==
X-CSE-MsgGUID: b93pinouT6WByX62eOwRwQ==
X-IPAS-Result: =?us-ascii?q?A0ANAADiAr1n/4v/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBgkqBT0NIjHJfpwuBJQNWDwEBAQ9EBAEBhQeLEgImNAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZdNgFGgQwyE?=
 =?us-ascii?q?oMCgmUDriaCLIEB3jSBboFIAYVrh19whHcnG4FJRIR9hRCFdwSCL4FAg2ynM?=
 =?us-ascii?q?UiBIQNZLAFVEw0KCwcFgTk4AyAKCwwLEhwVAhQdDwYQBGpDN4JFaUk6Ag0CN?=
 =?us-ascii?q?YIeJFiCK4RWhEOEQoI/UYJCghFxgRqJL4NIQAMLGA1IESw3Bg4bBj5uB6AMP?=
 =?us-ascii?q?IQ1exOCXaVXoQSEJYFjn2UaM4NwAaZkmH0ipCiEZoFnPIFZMxoIGxWDIlIZD?=
 =?us-ascii?q?94SJTI8AgcLAQEDCZFlAQE?=
IronPort-Data: A9a23:W15TJKlmaU8ncnQVcV2p9HPo5gyjJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIcD2zSOPaIajHwedEgbdyw8klU65bTyoQyTgtp+3pkHltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pa31GONgWYubzpOsf7b9HuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FdMB+dlcXHMJz
 PFGdRkrU0ipjKGW0IvuH4GAhux7RCXqFJkUtnclyXTSCuwrBMiZBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQUaz/7C7pm9Ausrnv4cztUoVaYjaE2+GPUigd21dABNfKOIIDVH5QLxRvwS
 mTu9TWiGhAcM8GjlwWv40Ly3OLoghnkYddHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ0I/9XuvqktgR/VCNVuCqi4ipvyAz6Y/
 tyRhDI1i7NWiYsA0L+2uAidxTmtvZPOCAUy4207Q16Y0++wX6b9D6TA1LQRxa8owFqxJrVZg
 EU5pg==
IronPort-HdrOrdr: A9a23:odwsR6ojebwEvIOy+30g8aIaV5ogeYIsimQD101hICG9vPb2qy
 nIpoV/6faaslcssR0b9OxoW5PwI080i6QU3WB5B97LN2PbUQCTQr2Kg7GP/9SZIVycygaYvp
 0QFJSXz7bLfDxHsfo=
X-Talos-CUID: =?us-ascii?q?9a23=3AOii+IGtCio9ytNL+u6+UKgls6It7a37i5yrCZHa?=
 =?us-ascii?q?1VztAboDNY1TT2LNdxp8=3D?=
X-Talos-MUID: 9a23:sAH6iwZiaqiet+BTvW63nDBkM9pUvZuEGXBTy5ghpPObDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,312,1732579200"; 
   d="scan'208";a="324729635"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Feb 2025 23:44:00 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTP id 91BCB18000224;
	Mon, 24 Feb 2025 23:44:00 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 57C2320F2003; Mon, 24 Feb 2025 15:44:00 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>
Subject: [PATCH net-next 0/1] enic: add dependency on Page Pool
Date: Mon, 24 Feb 2025 15:43:49 -0800
Message-Id: <20250224234350.23157-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-02.cisco.com

Driver was not configured to select page_pool, causing a compile error
if page pool module was not already selected.

Signed-off-by: John Daley <johndale@cisco.com>

John Daley (1):
  enic: Add dependency on Page Pool

 drivers/net/ethernet/cisco/enic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.39.3


