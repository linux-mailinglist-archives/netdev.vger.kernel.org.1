Return-Path: <netdev+bounces-102483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4051903333
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB791F28016
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79F5171E66;
	Tue, 11 Jun 2024 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMXKfzS4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD0B657;
	Tue, 11 Jun 2024 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718089625; cv=none; b=dA2G4lwuRwIKz7yRAW6vP259cbnlmbS3xFo8ZaIb5WlLzAmnDlmulrVown70Gx1V1GIlyVquv5eA5Bn5+BM5kHjmlcQ4Af4QYPgbE/CT8z9GJQB/oZ53m5Fj4PR7vQRDXJS8RnjsUIPae242A3UYTa543mFDSyZ3ZTjxC+4D+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718089625; c=relaxed/simple;
	bh=O7FhlWpnmO6DG8mmvYqNQY1UaM6Z2e5kCT35MiL0Qzo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lOl6GTvdtHNB4IUe8EWz6+JYrWobZRJPV6gBX1IWLgC4TWGcqB7fGbmNOJeDdMSA/gkOcCKtZ9Hyj1ZdP2u0OevWWaJDC0scQiMlRMuBjlhXKHI332wqzAYirTa05y5c+5xT3OBXE0XbX43Yw3ASJvVimWSOcMktFb0Sxs4J9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMXKfzS4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718089624; x=1749625624;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=O7FhlWpnmO6DG8mmvYqNQY1UaM6Z2e5kCT35MiL0Qzo=;
  b=nMXKfzS4qyvrYUju9hiFjxIX2GAY1IJNDQVTI+i1Og0EL/1/UW987Ieq
   8wqj6IfGvxtDTCQf4zIBL98Ddes56Ez4xLhZGq4D/cEFvVVrJo8O6cA7O
   cJOK51g1NfOILzSixnUkfOjkcg5e91YFgayXVeWdGm7yTQJ5i2dMCISXD
   n96B3U4ZyVMjqpfOFkIpC93IE0IEi9iwW0IlFEYJ5qw3eOEolDtKN0G+4
   gUrPcolP43DHr9K+ZAs4NHHA7Mj4zWJCJcYNlyd0dqEVSKbaeKLxwmB6N
   s279ORwEtm/9k69d/A6JV90hpx6zoi2oB9/0G7HwXTNUYdiOGLqRGFTKt
   g==;
X-CSE-ConnectionGUID: HLff8ASbTpS5rv9NTGqKng==
X-CSE-MsgGUID: J9deQ2cDSXGAmzZWTQHCNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14950409"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14950409"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 00:07:03 -0700
X-CSE-ConnectionGUID: k1lMzQXiRqCvcTIBQayrzw==
X-CSE-MsgGUID: Hsi4SuxNTey4XSabgKdncg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="76786882"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.197])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 00:06:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 11 Jun 2024 10:06:55 +0300 (EEST)
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>
cc: Andrew Lunn <andrew@lunn.ch>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
    "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
    "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "Ang, Tien Sung" <tien.sung.ang@intel.com>, 
    "G Thomas, Rohan" <rohan.g.thomas@intel.com>, 
    "Looi, Hong Aun" <hong.aun.looi@intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    "Tham, Mun Yew" <mun.yew.tham@intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
In-Reply-To: <DM8PR11MB5751B40B4FB8C1DA200D05FEC1C72@DM8PR11MB5751.namprd11.prod.outlook.com>
Message-ID: <f125a891-0e09-8cd7-4b23-6a936493ccfc@linux.intel.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com> <20240527093339.30883-2-boon.khai.ng@intel.com> <48176576-e1d2-4c45-967a-91cabb982a21@lunn.ch> <DM8PR11MB5751469FAA2B01EB6CEB7B50C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
 <48673551-cada-4194-865f-bc04c1e19c29@lunn.ch> <DM8PR11MB5751194374C75EC5D5889D6AC1F32@DM8PR11MB5751.namprd11.prod.outlook.com> <322d8745-7eae-4a68-4606-d9fdb19b4662@linux.intel.com> <BL3PR11MB57488DF9B08EACD88D938E2FC1F82@BL3PR11MB5748.namprd11.prod.outlook.com>
 <734c0d46-63f2-457d-85bf-d97159110583@lunn.ch> <DM8PR11MB5751CD3D8EF4DF0B138DEB7FC1FB2@DM8PR11MB5751.namprd11.prod.outlook.com> <3c32c9b9-be77-41c8-97f7-371bd6f8fa16@lunn.ch> <DM8PR11MB5751B40B4FB8C1DA200D05FEC1C72@DM8PR11MB5751.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 11 Jun 2024, Ng, Boon Khai wrote:

> > > it does have stmmac_est.c and stmmac_ptp.c to that support for both
> > > dwmac4 and dwxgmac2, with that I think it is suitable for introducing
> > > another file called stmmac_vlan?
> > 
> > Yes, stmmac_vlan.c is O.K.
> 
> Thanks Andrew, I'll make an effort to consolidate the code into the
> stmmac_vlan.c, wonder the next submission I should go into net or 
> net next?

By default, everything goes to -next (in any subsystem). Only fixes and a 
few other exceptions this is not go through the non-next trees.

-- 
 i.


