Return-Path: <netdev+bounces-225101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DADB8E640
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 23:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111E23BC83B
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD734238C07;
	Sun, 21 Sep 2025 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBQEO2Q6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3518BBAE
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490294; cv=none; b=hJF1XUMcc5t4PabFv0ASaHBun/2gZ2kTHh8nbslAZ+NmWjEhkomTvKapGjvRYM7r/gQX5HF9ul8oQf5SJ7iqFMDbw6c51kf3ccGKAbV9LD75tL7D40nZ5MckLHYo0QgJV9P5Joni2XQys77mVADtj5IIJomxj1zVXNZ+kCQhok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490294; c=relaxed/simple;
	bh=zqT1TnahnRM17p1/i8bRil1o0nqomS89t3+MM6Zthw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg4NFMT4Q78m/DjbE6CZErvtARxQ41qO4Lzu51a6vkvYKIQlf0gyUB6SknYEi6POR40mLZ/AM8plXuGctyPdo0Riv3rsveF3ffhMD4WS5/JCG36SLKoYOxYp640/CAo1x0AnS0orZV2lJHdmCBCfb7FZuCmHktpSn3cGwoJwW40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBQEO2Q6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758490292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vMzJv7FtrWlT5/pOKIu9OWpMHtet5A15OykeYCUitfw=;
	b=dBQEO2Q6UE6yfwU7+LoqJWft+dojucm/4I3KH1WDQS50O+gd0ZNNPfeTnO4NNoOllh8PWl
	Qa85jDu60vfBhRK9sCGdTzaYAmhm5ySH2gdbwHuyKQQePkaCwExTURkBpMXtCAYb1W9ugU
	bsw11ByECQkCEblAZqOd7p62lP/kjqE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-AS8RgAsgNO2CjbH9y8c6UA-1; Sun, 21 Sep 2025 17:31:30 -0400
X-MC-Unique: AS8RgAsgNO2CjbH9y8c6UA-1
X-Mimecast-MFC-AGG-ID: AS8RgAsgNO2CjbH9y8c6UA_1758490289
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46be15ade1dso6291225e9.3
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 14:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490289; x=1759095089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMzJv7FtrWlT5/pOKIu9OWpMHtet5A15OykeYCUitfw=;
        b=q/SnEexrBUAcxYoP783HaVcsJ6l5cmSp/Xvn0Zpm+1sjIvkFPWqLAx5MZKbxPgbAVk
         BOzjKs8hBmZuWUNFxqQzLzT7HS5dSLnSecQonBKelXLzea0aSCBRfm+cE/Hkm3PO2JSA
         U4CFfqJNbRDM86Nv//5g6wGdfN5hvO/J9umuWMLAzfff691ZUZ7wUgQQB0SC1Js3ipp7
         okTMFfZeK0bFgagyhSpxeWujDjH/elzoWF41gDIvDZq7pWEXC+bPSPNHnPN969DKcI3s
         d7H5HkT0iqK7164BK1MhGpgkCE3liPJkEf6mSE6rXiknpj2H8yf7cxHlDPSux4GIlCVX
         BOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0BVs8eSOtiK5fquJamwutX4+PHAAUv5dsd4x2jcY+mm9OXS57vBEf4g3QRPjQu+HTliIIxRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVoRvAu5LmlUsEpirSQFuKngMSNkaoDvxoR67qUcV04dyIOs/g
	sYj7Ai1R5nu6XQIfFUtddnt+vxerVhYBxVCHyTfmaDq6f6eQCcZt9PDYXYdcMugyUPnx/s9he5s
	LF9GeR4ijbLe3+F17sKlsFbUWY038b09EpFbNI1qE0Xw2akoFwC8Q+2d/UQ==
X-Gm-Gg: ASbGncs5ObgTFgxFILdfKxPtaiagXGqrpgaLphud+NuhioMDdqRFmxuA+ZWsxK8/tk8
	5W1yoZjdJai0xsw9A4MxAzVUQVaXsrsZXeF0yA+Ys3fOtFE7YTPiw733oTsDHP0AcE212Hgaem2
	t1pOuJZu81f1mGs8XL707my2PW3Ie9SKNH5eufsHWGsvwGILX/JJFGmEvz6EBcsjAQnmxDAWbCj
	czX8lRgDdivkRAcDi7IRzu37xR8t8FqxOeo+qR6aYEGpaUPr/Vh0zY5Q88mbxMA/4qKa+pk0Jnh
	IFMqiBaKTFKb5VSs9m5G/AGZtRnASuFyUdo=
X-Received: by 2002:a05:600c:a43:b0:45d:f7cb:70f4 with SMTP id 5b1f17b1804b1-467e6f37f06mr92245395e9.13.1758490289242;
        Sun, 21 Sep 2025 14:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnBRTWDkC6y2pA+1GqSrUmiizkLbPjFI1ya/MytaZ7T1ocVq1gR43EQYG+wvlvwojzYCFD3w==
X-Received: by 2002:a05:600c:a43:b0:45d:f7cb:70f4 with SMTP id 5b1f17b1804b1-467e6f37f06mr92245285e9.13.1758490288758;
        Sun, 21 Sep 2025 14:31:28 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46138695223sm217767975e9.5.2025.09.21.14.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:31:28 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:31:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: Re: [mst-vhost:vhost 41/44] drivers/vdpa/pds/vdpa_dev.c:590:19:
 error: incompatible function pointer types initializing 's64 (*)(struct
 vdpa_device *, u16)' (aka 'long long (*)(struct vdpa_device *, unsigned
 short)') with an expression of type 'u32 (struct vdpa_device *, u16)' (aka
 ...
Message-ID: <20250921173047-mutt-send-email-mst@kernel.org>
References: <202509202256.zVt4MifB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509202256.zVt4MifB-lkp@intel.com>

On Sat, Sep 20, 2025 at 10:41:40PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
> head:   877102ca14b3ee9b5343d71f6420f036baf8a9fc
> commit: 2951c77700c3944ecd991ede7ee77e31f47f24ab [41/44] vduse: add vq group support
> config: loongarch-randconfig-001-20250920 (https://download.01.org/0day-ci/archive/20250920/202509202256.zVt4MifB-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509202256.zVt4MifB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509202256.zVt4MifB-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/vdpa/pds/vdpa_dev.c:590:19: error: incompatible function pointer types initializing 's64 (*)(struct vdpa_device *, u16)' (aka 'long long (*)(struct vdpa_device *, unsigned short)') with an expression of type 'u32 (struct vdpa_device *, u16)' (aka 'unsigned int (struct vdpa_device *, unsigned short)') [-Wincompatible-function-pointer-types]
>      590 |         .get_vq_group           = pds_vdpa_get_vq_group,
>          |                                   ^~~~~~~~~~~~~~~~~~~~~
>    1 error generated.
> 

Eugenio, just making sure you see this. I can not merge patches that
break build.

> vim +590 drivers/vdpa/pds/vdpa_dev.c
> 
> 151cc834f3ddafe Shannon Nelson 2023-05-19  577  
> 151cc834f3ddafe Shannon Nelson 2023-05-19  578  static const struct vdpa_config_ops pds_vdpa_ops = {
> 151cc834f3ddafe Shannon Nelson 2023-05-19  579  	.set_vq_address		= pds_vdpa_set_vq_address,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  580  	.set_vq_num		= pds_vdpa_set_vq_num,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  581  	.kick_vq		= pds_vdpa_kick_vq,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  582  	.set_vq_cb		= pds_vdpa_set_vq_cb,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  583  	.set_vq_ready		= pds_vdpa_set_vq_ready,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  584  	.get_vq_ready		= pds_vdpa_get_vq_ready,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  585  	.set_vq_state		= pds_vdpa_set_vq_state,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  586  	.get_vq_state		= pds_vdpa_get_vq_state,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  587  	.get_vq_notification	= pds_vdpa_get_vq_notification,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  588  	.get_vq_irq		= pds_vdpa_get_vq_irq,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  589  	.get_vq_align		= pds_vdpa_get_vq_align,
> 151cc834f3ddafe Shannon Nelson 2023-05-19 @590  	.get_vq_group		= pds_vdpa_get_vq_group,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  591  
> 151cc834f3ddafe Shannon Nelson 2023-05-19  592  	.get_device_features	= pds_vdpa_get_device_features,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  593  	.set_driver_features	= pds_vdpa_set_driver_features,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  594  	.get_driver_features	= pds_vdpa_get_driver_features,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  595  	.set_config_cb		= pds_vdpa_set_config_cb,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  596  	.get_vq_num_max		= pds_vdpa_get_vq_num_max,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  597  	.get_device_id		= pds_vdpa_get_device_id,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  598  	.get_vendor_id		= pds_vdpa_get_vendor_id,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  599  	.get_status		= pds_vdpa_get_status,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  600  	.set_status		= pds_vdpa_set_status,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  601  	.reset			= pds_vdpa_reset,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  602  	.get_config_size	= pds_vdpa_get_config_size,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  603  	.get_config		= pds_vdpa_get_config,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  604  	.set_config		= pds_vdpa_set_config,
> 151cc834f3ddafe Shannon Nelson 2023-05-19  605  };
> 25d1270b6e9ea89 Shannon Nelson 2023-05-19  606  static struct virtio_device_id pds_vdpa_id_table[] = {
> 25d1270b6e9ea89 Shannon Nelson 2023-05-19  607  	{VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID},
> 25d1270b6e9ea89 Shannon Nelson 2023-05-19  608  	{0},
> 25d1270b6e9ea89 Shannon Nelson 2023-05-19  609  };
> 25d1270b6e9ea89 Shannon Nelson 2023-05-19  610  
> 
> :::::: The code at line 590 was first introduced by commit
> :::::: 151cc834f3ddafec869269fe48036460d920d08a pds_vdpa: add support for vdpa and vdpamgmt interfaces
> 
> :::::: TO: Shannon Nelson <shannon.nelson@amd.com>
> :::::: CC: Michael S. Tsirkin <mst@redhat.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


