Return-Path: <netdev+bounces-176100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C2EA68C8E
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 13:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D423B00DD
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4424255E55;
	Wed, 19 Mar 2025 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8e8zMqR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394A254AE4;
	Wed, 19 Mar 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386504; cv=none; b=agylEmLAJLERoYGUcHFik/sk/uYFtKaUPy6ha3aE0ECgzF7095nvkoocvTX+n8DocxUcnTST3Dtcz4tH0ES4r2pQ7CSRMTX/W5Xl7tV7/vPF9keXWQZaAaAQ/W/rye4Ox9DZk37oWvbU/gszA9Hcvb0h7DLp4aIJUwingqfRZdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386504; c=relaxed/simple;
	bh=iVBAeEdmO5RxhpnsDC583W/lzWPAdfNq7iwNnkT1hPs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DR0pm8m9r2xwcou3MmmNS7562YhRdUaL/S7d/rlS1xJzhj5xDQfpN00AMhbY0sl4/dZCL0aK+Dw/pCfLwkwx/PDix6GlLFDIVpF6+Pu89TBYimnrGhDSwJw4KTEQo3pBWWRnKwpqGkzC5DYEZGN+Vm0nyC05C58va2W9QmfWVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8e8zMqR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742386503; x=1773922503;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iVBAeEdmO5RxhpnsDC583W/lzWPAdfNq7iwNnkT1hPs=;
  b=K8e8zMqRa+q5nL/7PelrTi74Pt3yfGzhoxtf8UmqPb7xmlTk6WrOHSxG
   aOswvzQX6fZv9wextmGiAABvCOxssGuu8Z+FdAfUxDwlvRYgBmLOJXeQw
   qcTsTkn+cj7HjfL0PUvS0oq0VSDVkCPJyb03htWakKz6yz6QWPwCGUqpS
   V7S3cL6mp8mvdkNJLnnsp/OQGNU0Myv2XK+Bng760VV9syY4zs2l1Y5+r
   MttA64yhez+WBjHUceCxLSdLOVnXxcFQCN+wo+KvewzPhgHNVVxkjTch8
   1N22MzuV+l1/iF9X59I79cC+KROdPJuwUVRQLYqkShlqsM/6M5pHYIb3R
   Q==;
X-CSE-ConnectionGUID: nlk+/9U3QX+0N6YgW3HFhw==
X-CSE-MsgGUID: R+4HMFlbQdW5Eomp7U3NAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47220905"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="47220905"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:15:02 -0700
X-CSE-ConnectionGUID: FwK72CK3QIuh2cODDD7pfw==
X-CSE-MsgGUID: WjdfvLQUQFKr9+feqPuVKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127408039"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:14:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 19 Mar 2025 14:14:55 +0200 (EET)
To: Lukas Bulwahn <lbulwahn@redhat.com>
cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
    David E Box <david.e.box@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
    Chao Qin <chao.qin@intel.com>, 
    Choong Yong Liang <yong.liang.choong@linux.intel.com>, 
    Jakub Kicinski <kuba@kernel.org>, Netdev <netdev@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH net-next] MAINTAINERS: adjust the file entry in INTEL
 PMC CORE DRIVER
In-Reply-To: <20250317092717.322862-1-lukas.bulwahn@redhat.com>
Message-ID: <f224cd8e-2330-8c69-dcb1-7953017d9ff1@linux.intel.com>
References: <20250317092717.322862-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-423036490-1742386495=:10063"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-423036490-1742386495=:10063
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 17 Mar 2025, Lukas Bulwahn wrote:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>=20
> Commit 7e2f7e25f6ff ("arch: x86: add IPC mailbox accessor function and ad=
d
> SoC register access") adds a new file entry referring to the non-existent
> file linux/platform_data/x86/intel_pmc_ipc.h in section INTEL PMC CORE
> DRIVER rather than referring to the file
> include/linux/platform_data/x86/intel_pmc_ipc.h added with this commit.
> Note that it was missing 'include' in the beginning.
>=20
> Adjust the file reference to the intended file.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
> I think the commit above is in net-next, this patch is to be applied
> on the tree where the commit has been added.
>=20
> Jakub, please pick this minor non-urgent fix. Thanks.
>=20
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96ae7f628da4..9544a4e84f99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12069,7 +12069,7 @@ L:=09platform-driver-x86@vger.kernel.org
>  S:=09Maintained
>  F:=09Documentation/ABI/testing/sysfs-platform-intel-pmc
>  F:=09drivers/platform/x86/intel/pmc/
> -F:=09linux/platform_data/x86/intel_pmc_ipc.h
> +F:=09include/linux/platform_data/x86/intel_pmc_ipc.h
> =20
>  INTEL PMIC GPIO DRIVERS
>  M:=09Andy Shevchenko <andy@kernel.org>

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-423036490-1742386495=:10063--

