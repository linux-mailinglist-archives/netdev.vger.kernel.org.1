Return-Path: <netdev+bounces-175931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B768A68025
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480207A3362
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA352066D9;
	Tue, 18 Mar 2025 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oLHTmfmk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8685626;
	Tue, 18 Mar 2025 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338652; cv=none; b=rxHhe57Byv4A2yHdtmHxj48tDNI87Lz4KKEuPw86us9pVZunCQgqboExWN9OLjZUiff1FFTPDNGoTKfcFqyLzals6N9hRoJX4gI0QzMypzscnofTFDAzdXjEp8ccjsVonzzzd6v6Ch+p7OXC6D3vWF0O1uG2g80v11Q+KuDgV3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338652; c=relaxed/simple;
	bh=Ab0mjpny9YV3cDgaOEiBxiCSt5kA5wyfbzdqOnZMbfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFJt8ZTNluJ9mXZegDQl5jwBrndTglhprbRFtR/9m3gVD4SHx65IglsYDbO4C8NlZ+CM39kBjVLngEoG4oa9UnK5/GbK/gdRENyjU1cLHXSbT/toWRIXDAY4k0xH7hC67QrffRFHIcRNq9NVUrtaSxwrQKDbRVeXCmUWWSyOiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oLHTmfmk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742338650; x=1773874650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ab0mjpny9YV3cDgaOEiBxiCSt5kA5wyfbzdqOnZMbfM=;
  b=oLHTmfmkX0WLbrpSr8BDX7nC+CBjtUgivGRbUI3tsf6Zf2A3RnmKI5P3
   BJWQgaUS2NwllSNvUlrSzC5M0p5BLp8CSiQIx74To1BXifEzjBDOJK9DZ
   ZvSXMCUkuey67EzZeliDB/ztmFBK3Q3xGs8dVAfe6wPVZbIrWlUjet6mM
   CfBUHU5URdNjjgTnhJcrozOHJrrcuelxtarYyh3xUqozlA7+f5eMe54Qe
   NUxeV04jnZ/HU6SYaIh5gsOYazYj1IjhQKBXxWybQ30BnLMGdNZfiIWpr
   RCjroi5zH4vk5Pdx0IXSx2iCqa4EZBr/SISFCHI4Ay8JREgisOElXOzVi
   A==;
X-CSE-ConnectionGUID: ioBqKrv1Sp68ugbau9O0Mg==
X-CSE-MsgGUID: eXRR9T/FT6STgnjipVsd5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="60899294"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="60899294"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 15:57:29 -0700
X-CSE-ConnectionGUID: LkmWyGn/TXCsM8/yBE1esg==
X-CSE-MsgGUID: jjNBGmTXT6Cr8oaTnsh5vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="159556524"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 18 Mar 2025 15:57:25 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tufs6-000EE2-2N;
	Tue, 18 Mar 2025 22:57:19 +0000
Date: Wed, 19 Mar 2025 06:56:22 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Hilber <quic_philber@quicinc.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Trilok Soni <quic_tsoni@quicinc.com>,
	Peter Hilber <quic_philber@quicinc.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	"Ridoux, Julien" <ridouxj@amazon.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Parav Pandit <parav@nvidia.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, Simon Horman <horms@kernel.org>,
	virtio-dev@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/4] virtio_rtc: Add PTP clocks
Message-ID: <202503190602.IElWB74j-lkp@intel.com>
References: <20250313173707.1492-3-quic_philber@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313173707.1492-3-quic_philber@quicinc.com>

Hi Peter,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9d8960672d63db4b3b04542f5622748b345c637a]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Hilber/virtio_rtc-Add-module-and-driver-core/20250314-014130
base:   9d8960672d63db4b3b04542f5622748b345c637a
patch link:    https://lore.kernel.org/r/20250313173707.1492-3-quic_philber%40quicinc.com
patch subject: [PATCH v6 2/4] virtio_rtc: Add PTP clocks
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20250319/202503190602.IElWB74j-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503190602.IElWB74j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503190602.IElWB74j-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/virtio/virtio_rtc_driver.c: In function 'viortc_probe':
>> drivers/virtio/virtio_rtc_driver.c:665:23: warning: '/variant ' directive output may be truncated writing 9 bytes into a region of size between 6 and 15 [-Wformat-truncation=]
       "Virtio PTP type %d/variant %d", clock_type,
                          ^~~~~~~~~
   drivers/virtio/virtio_rtc_driver.c:665:4: note: directive argument in the range [0, 2147483647]
       "Virtio PTP type %d/variant %d", clock_type,
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/virtio/virtio_rtc_driver.c:664:2: note: 'snprintf' output between 28 and 46 bytes into a destination of size 32
     snprintf(ptp_clock_name, PTP_CLOCK_NAME_LEN,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       "Virtio PTP type %d/variant %d", clock_type,
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       leap_second_smearing);
       ~~~~~~~~~~~~~~~~~~~~~


vim +665 drivers/virtio/virtio_rtc_driver.c

   641	
   642	/*
   643	 * init, deinit
   644	 */
   645	
   646	/**
   647	 * viortc_init_ptp_clock() - init and register PTP clock
   648	 * @viortc: device data
   649	 * @vio_clk_id: virtio_rtc clock id
   650	 * @clock_type: virtio_rtc clock type
   651	 * @leap_second_smearing: virtio_rtc leap second smearing
   652	 *
   653	 * Context: Process context.
   654	 * Return: Positive if registered, zero if not supported by configuration,
   655	 *         negative error code otherwise.
   656	 */
   657	static int viortc_init_ptp_clock(struct viortc_dev *viortc, u16 vio_clk_id,
   658					 u8 clock_type, u8 leap_second_smearing)
   659	{
   660		struct device *dev = &viortc->vdev->dev;
   661		char ptp_clock_name[PTP_CLOCK_NAME_LEN];
   662		struct viortc_ptp_clock *vio_ptp;
   663	
   664		snprintf(ptp_clock_name, PTP_CLOCK_NAME_LEN,
 > 665			 "Virtio PTP type %d/variant %d", clock_type,
   666			 leap_second_smearing);
   667	
   668		vio_ptp = viortc_ptp_register(viortc, dev, vio_clk_id, ptp_clock_name);
   669		if (IS_ERR(vio_ptp)) {
   670			dev_err(dev, "failed to register PTP clock '%s'\n",
   671				ptp_clock_name);
   672			return PTR_ERR(vio_ptp);
   673		}
   674	
   675		viortc->clocks_to_unregister[vio_clk_id] = vio_ptp;
   676	
   677		return !!vio_ptp;
   678	}
   679	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

