Return-Path: <netdev+bounces-55544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6F980B396
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 11:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC5B1F20FF3
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0548A125B3;
	Sat,  9 Dec 2023 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDQhgp9i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4C410DA
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 02:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702117665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9sgSSZVoHbtMUxorEO7aIxD48351b/dT2/kcqCclHl8=;
	b=QDQhgp9iyOQwIdcXtPpt4EF42zeE7xMAWRyPOYvAWb0ubBMmIjgdjjY3mWeLwybWvLGP3R
	Gxnh5+0s0GEw/joVmnIHtplNaNo4k8Nx1TbKJPMGcNxtsxL2bSCbdk5y6SYl4WIoseMkUZ
	M4j8/l/mZ7hwLCX2ZB/jl100uqQhRJA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-l0DIQ73OM5-G31NidXHuzA-1; Sat, 09 Dec 2023 05:27:43 -0500
X-MC-Unique: l0DIQ73OM5-G31NidXHuzA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332ee20a40fso2379459f8f.3
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 02:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702117662; x=1702722462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sgSSZVoHbtMUxorEO7aIxD48351b/dT2/kcqCclHl8=;
        b=gskfiMegZVImLk9ogX6qz+u63SZtfh+hZNzzDT4rfpZm6Sqh9rxXFKpmS23XAi9PVp
         O6JwaLRFlwBtcXe/nVKiv1/h1MDJgeiBK8BjgaAnEvos7+1tSrPiMAa6QGi1CBWzA9+k
         EmdgNTVm5nF4DLGavdvinXTihILJut4zWGbxeV1ultejYRhhfH4iDIBtyp2tTEvgqxM0
         zfp4gud/eUPcH2FZAVd0xVi7ieJ04K6DF0uEWlX3UnNutXDOi5twkS6dlUz5H1Tfs9X4
         aMwHZGl3/8/hxiukkX0fowcbaWwkiusdljuM8fSh/DjKmzAbtqUG9I3dp+rTkzW/uHGq
         6hAw==
X-Gm-Message-State: AOJu0YwOIDZLfq+e4cin+7SI8pNQK55aqUo+tSM8W+on/ps4EoCEndQS
	oURTH0P54d2IgJw4P/wqvZ8iCbY7+6+PyTCEBEU3dsAbGnDVONkxm7dQoI4hf1tQQFS4zUXNa/K
	B6KJWvGCMPzMzN6XN
X-Received: by 2002:a5d:6611:0:b0:333:4896:100d with SMTP id n17-20020a5d6611000000b003334896100dmr664686wru.8.1702117662543;
        Sat, 09 Dec 2023 02:27:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDiHXF4XIUOFxXmVXFha/8eTa6nHvn907AvowQMaqP0gK0hvBFBHsptrwJMLI54FcKEUH+MQ==
X-Received: by 2002:a5d:6611:0:b0:333:4896:100d with SMTP id n17-20020a5d6611000000b003334896100dmr664676wru.8.1702117662230;
        Sat, 09 Dec 2023 02:27:42 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ff:4f00:b091:120e:5537:ac67])
        by smtp.gmail.com with ESMTPSA id m1-20020a056000008100b00334b3208700sm3961093wrx.49.2023.12.09.02.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:27:41 -0800 (PST)
Date: Sat, 9 Dec 2023 05:27:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	oe-kbuild-all@lists.linux.dev, jasowang@redhat.com,
	pabeni@redhat.com, kuba@kernel.org, yinjun.zhang@corigine.com,
	edumazet@google.com, davem@davemloft.net, hawk@kernel.org,
	john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v7 4/4] virtio-net: support rx netdim
Message-ID: <20231209052724-mutt-send-email-mst@kernel.org>
References: <9be20d1e86bea91b373f28401a96401b640ef4d1.1701929854.git.hengqi@linux.alibaba.com>
 <202312091132.7eR6Cbs9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312091132.7eR6Cbs9-lkp@intel.com>

On Sat, Dec 09, 2023 at 11:22:11AM +0800, kernel test robot wrote:
> Hi Heng,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/virtio-net-returns-whether-napi-is-complete/20231207-143044
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/9be20d1e86bea91b373f28401a96401b640ef4d1.1701929854.git.hengqi%40linux.alibaba.com
> patch subject: [PATCH net-next v7 4/4] virtio-net: support rx netdim
> config: nios2-randconfig-r064-20231209 (https://download.01.org/0day-ci/archive/20231209/202312091132.7eR6Cbs9-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091132.7eR6Cbs9-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312091132.7eR6Cbs9-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    nios2-linux-ld: drivers/net/virtio_net.o: in function `virtnet_rx_dim_work':
>    virtio_net.c:(.text+0x21dc): undefined reference to `net_dim_get_rx_moderation'
> >> virtio_net.c:(.text+0x21dc): relocation truncated to fit: R_NIOS2_CALL26 against `net_dim_get_rx_moderation'
>    nios2-linux-ld: drivers/net/virtio_net.o: in function `virtnet_poll':
>    virtio_net.c:(.text+0x97bc): undefined reference to `net_dim'
> >> virtio_net.c:(.text+0x97bc): relocation truncated to fit: R_NIOS2_CALL26 against `net_dim'


Looks like select DIMLIB is missing?

> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


