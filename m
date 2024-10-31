Return-Path: <netdev+bounces-140737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092C09B7C46
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3621F21E76
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0F84A32;
	Thu, 31 Oct 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6I6Q2Dr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C557483
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383353; cv=none; b=HtMG1Q6kDLGiNFbuN5+1lJK5JaF6HrPtya5dris1NL+CJvdiOZpjZiFPQH2UIOzk9EGOplU57NSmRGMooqshdg6Ejr7AglyKd0WNAd7ScRHve9GYNCG4inOeqAJ+i44UPFSqy7igZLu46Uz08JAPb0P0EQHPWwebhX9+ivOV+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383353; c=relaxed/simple;
	bh=5iEUfJ/6faLbZEO76qJxSSB9FVwmL0xBsMvvOCB+bgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nD3nExVmW78fk14BAGU6zG1mYRXLlPK3CTO+LiqBPAD33zwXBhHq47zFScobKpfX8UCQC8HhkTpvAeRy2pZc73oHwxCEJ4xkYF2Zfoi3kLFboWuhdTNKe/p7qwNY7fYety29Xu3rp4KndwDhVNjHisU7drNshV7hn32hz3hdHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6I6Q2Dr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730383351; x=1761919351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5iEUfJ/6faLbZEO76qJxSSB9FVwmL0xBsMvvOCB+bgE=;
  b=m6I6Q2Drt0QtE5bjLRThq3qb2D18pSbG1KMCyJDI1tJOLesmZxDuEks3
   jDWgqk3/s7RY3ij9R2v87RihmeL1qXLSmpGGjUTDa5EzAyj7KYIoxECBv
   HUffUUgfha5MKTKPBnMAAfwAsoWupXsHskRjCiZVjilaaoQkbX8aRG0Z3
   4rR5ncmoCd4WVgKw/6KP7CN2CDm8C/xD5xfNoCMhNNAscAEgaKFa+YMFU
   JXs2N2AZwEt2Bzg1/VmpQbl/vVScyAUrkEjOb7R8un4/7vnPhvtPsPLg8
   Lo23u7h4NDreH3lkee1kD2fhpu8N2Q3zQxkltdyLuieTbGm6w87TFHs/1
   A==;
X-CSE-ConnectionGUID: cuZNTGYyQq6T0Uzg4piTFg==
X-CSE-MsgGUID: F8kwj0upRZCgnDd538y93g==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30226269"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30226269"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 07:02:30 -0700
X-CSE-ConnectionGUID: LEPC6x1iS3OIzaFxoigXlQ==
X-CSE-MsgGUID: 4/K6BTTAQ42qouFKerYqdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82791482"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 31 Oct 2024 07:02:23 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6Vki-000gFV-0W;
	Thu, 31 Oct 2024 14:02:20 +0000
Date: Thu, 31 Oct 2024 22:01:56 +0800
From: kernel test robot <lkp@intel.com>
To: qiang4.zhang@linux.intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gonglei <arei.gonglei@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Qiang Zhang <qiang4.zhang@intel.com>
Subject: Re: [PATCH] virtio: only reset device and restore status if needed
 in device resume
Message-ID: <202410312148.w44ttwk7-lkp@intel.com>
References: <20241031030847.3253873-1-qiang4.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031030847.3253873-1-qiang4.zhang@linux.intel.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus mst-vhost/linux-next axboe-block/for-next herbert-cryptodev-2.6/master andi-shyti/i2c/i2c-host mkp-scsi/for-next jejb-scsi/for-next tiwai-sound/for-next tiwai-sound/for-linus linus/master v6.12-rc5 next-20241031]
[cannot apply to herbert-crypto-2.6/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/qiang4-zhang-linux-intel-com/virtio-only-reset-device-and-restore-status-if-needed-in-device-resume/20241031-111315
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20241031030847.3253873-1-qiang4.zhang%40linux.intel.com
patch subject: [PATCH] virtio: only reset device and restore status if needed in device resume
config: arc-randconfig-002-20241031 (https://download.01.org/0day-ci/archive/20241031/202410312148.w44ttwk7-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410312148.w44ttwk7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410312148.w44ttwk7-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/char/hw_random/virtio-rng.c: In function 'virtrng_restore':
>> drivers/char/hw_random/virtio-rng.c:221:15: error: implicit declaration of function 'virtio_device_reset_and_restore_status' [-Werror=implicit-function-declaration]
     221 |         err = virtio_device_reset_and_restore_status(vdev);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/i2c/busses/i2c-virtio.c: In function 'virtio_i2c_restore':
>> drivers/i2c/busses/i2c-virtio.c:256:15: error: implicit declaration of function 'virtio_device_reset_and_restore_status' [-Werror=implicit-function-declaration]
     256 |         ret = virtio_device_reset_and_restore_status(vdev);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +/virtio_device_reset_and_restore_status +221 drivers/char/hw_random/virtio-rng.c

   216	
   217	static int virtrng_restore(struct virtio_device *vdev)
   218	{
   219		int err;
   220	
 > 221		err = virtio_device_reset_and_restore_status(vdev);
   222		if (err)
   223			return err;
   224	
   225		err = probe_common(vdev);
   226		if (!err) {
   227			struct virtrng_info *vi = vdev->priv;
   228	
   229			/*
   230			 * Set hwrng_removed to ensure that virtio_read()
   231			 * does not block waiting for data before the
   232			 * registration is complete.
   233			 */
   234			vi->hwrng_removed = true;
   235			err = hwrng_register(&vi->hwrng);
   236			if (!err) {
   237				vi->hwrng_register_done = true;
   238				vi->hwrng_removed = false;
   239			}
   240		}
   241	
   242		return err;
   243	}
   244	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

