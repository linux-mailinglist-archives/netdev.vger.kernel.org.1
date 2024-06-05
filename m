Return-Path: <netdev+bounces-100830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9278FC303
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2E71C21282
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 05:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734D513AD18;
	Wed,  5 Jun 2024 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKK18Grm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C47D405
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717565216; cv=none; b=B7Nq4HhqbBfFLEPHITOOkIix9sN9y+tsaMmFnj7W2TA9UiiMnphOMpteSeO4fBzO9w12NeM8rum5gnpjzFWVLUGBXW47/5w+WcgFC1dcLCQPk9km3QjSfO9zqnKFM2aKpd3rV0qQe4D0AjoRQh5tez5uv4kmT4Vm9ZD0z9nMSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717565216; c=relaxed/simple;
	bh=JWl0dvcLsDyhJpa9XHTWrzG8gS4xKr5gWdK/xlwOF90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AF3PJEbyhM3+V40jvl6f3PAmibE7J+AVCav/EmzAZergkLkN9o9VQISbrEIgG83KWFdMvodhuMjjgIN3RDke3nIsNSafK2n0+N9r55eg+0FZwLIfzW4VF+S/QnBsM/hbM+6uQ/4zIxs79gwU0BO7MwjFZEW+Wipthnk74miRqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VKK18Grm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a68e9b84d0eso182507766b.1
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 22:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717565213; x=1718170013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gLp5UQaiZ9Nbta/3ev83gXvw8Hf+0qRq7Af1uLYkp6M=;
        b=VKK18GrmP4u7LAE9/CGvOEPSNV4LxqtuY4bNpPN6nVaWFG1+gLg2nnN4qKjOQJVHd3
         yRe3moeo/3DcVfeR8TpYYaeDeAexVA8i25RQBbsHbAjMb5Rx1Xu2N1PQKde6nN7Kx9SM
         mhLtkKOE7gF6RfEvE6Xs+jJoO4Yy/b+cWDO7QImJffzAFQ9/9TGKdYfH7NSxJUxgqlW4
         avGZPeuDrnRybG6OvCc37DZzSQs2DZRA2GQVAtCDaAQMwRXCJbf8e894140UM8pEnwKW
         3OGPmk4q9xGPWFCUJldc3StsOLPpbq5iuCPqINcFiLxSQkBNMaZGv1Ol21hf8Rwdisuv
         5Ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717565213; x=1718170013;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLp5UQaiZ9Nbta/3ev83gXvw8Hf+0qRq7Af1uLYkp6M=;
        b=JVELSuhHewUDWJSYSrHjxNZ2Ko+kVcift/d4q8rOQojDqsKyKVuD9CT188AFM9Mvb/
         HuLvij1LAnQ5qt7dceX/Vdm+HtP4EqrsNqg8iTwMO+5yloXQrsJr4FvXdqESQbVrpUtw
         VjRVuFaCP/m85Vyf4seGEj5EVRyhBNFnhQsmkDYvT4/pCz3yQJRgPWWl9T3xWBO5CW+h
         4HcIkXIe27VqW3rSqgH9gNGHBODVb/JnFFLDntZthfLsUYG9aFlX/mmTrXqsBgrT93Gj
         LHHQzyzcO2eT6bfhwFLUti4QvxbFnQmgsp9EoZo0HZf0kIQTTjMo4+Ue+SrYjx/wLCU0
         qLMA==
X-Forwarded-Encrypted: i=1; AJvYcCVh4jspaBBW/1ZoRYEShSABfL9tI6V+bMv6QqTcOvismvVTmIN1n27YPa/kNj+3nCX2q/KrTdxZs/Dful64mDT1lVzLnjXm
X-Gm-Message-State: AOJu0YyraE/DffiE7Q1rngLWAvFKo24QoU/Mm9Waz8amovDycdKrDpVA
	NK839MGm0gjZHn2Dn/gH/EZaEYU5CyGrUS1Vhye33H0aN2UhEbz7oI3SMEO+aR8=
X-Google-Smtp-Source: AGHT+IGOMSJFPKFFMw3Bx8/QTz2P9IGqnf2wnl+C+L+ox1QNHbFZ72ssL2lgPvxarUhqjNlSVlRHSg==
X-Received: by 2002:a50:9b18:0:b0:579:d673:4e67 with SMTP id 4fb4d7f45d1cf-57a8bc9ba6emr1091753a12.26.1717565212609;
        Tue, 04 Jun 2024 22:26:52 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b98de7sm8515234a12.10.2024.06.04.22.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 22:26:52 -0700 (PDT)
Date: Wed, 5 Jun 2024 08:26:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Xiaolei Wang <xiaolei.wang@windriver.com>,
	linux@armlinux.org.uk, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net v2 PATCH] net: stmmac: Update CBS parameters when speed
 changes after linking up
Message-ID: <6c78b634-0e83-42dd-81ce-b36999a1b0ef@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530061453.561708-1-xiaolei.wang@windriver.com>

Hi Xiaolei,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaolei-Wang/net-stmmac-Update-CBS-parameters-when-speed-changes-after-linking-up/20240530-141843
base:   net/main
patch link:    https://lore.kernel.org/r/20240530061453.561708-1-xiaolei.wang%40windriver.com
patch subject: [net v2 PATCH] net: stmmac: Update CBS parameters when speed changes after linking up
config: i386-randconfig-141-20240604 (https://download.01.org/0day-ci/archive/20240605/202406050318.jsyBFsxx-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406050318.jsyBFsxx-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:3234 stmmac_configure_cbs() error: uninitialized symbol 'ptr'.
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:3234 stmmac_configure_cbs() error: uninitialized symbol 'speed_div'.

vim +/ptr +3234 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

19d9187317979c Joao Pinto   2017-03-10  3194  static void stmmac_configure_cbs(struct stmmac_priv *priv)
19d9187317979c Joao Pinto   2017-03-10  3195  {
19d9187317979c Joao Pinto   2017-03-10  3196  	u32 tx_queues_count = priv->plat->tx_queues_to_use;
19d9187317979c Joao Pinto   2017-03-10  3197  	u32 mode_to_use;
19d9187317979c Joao Pinto   2017-03-10  3198  	u32 queue;
882212f550d669 Xiaolei Wang 2024-05-30  3199  	u32 ptr, speed_div;
882212f550d669 Xiaolei Wang 2024-05-30  3200  	u64 value;
882212f550d669 Xiaolei Wang 2024-05-30  3201  
882212f550d669 Xiaolei Wang 2024-05-30  3202  	/* Port Transmit Rate and Speed Divider */
882212f550d669 Xiaolei Wang 2024-05-30  3203  	switch (priv->speed) {
882212f550d669 Xiaolei Wang 2024-05-30  3204  	case SPEED_10000:
882212f550d669 Xiaolei Wang 2024-05-30  3205  		ptr = 32;
882212f550d669 Xiaolei Wang 2024-05-30  3206  		speed_div = 10000000;
882212f550d669 Xiaolei Wang 2024-05-30  3207  		break;
882212f550d669 Xiaolei Wang 2024-05-30  3208  	case SPEED_5000:
882212f550d669 Xiaolei Wang 2024-05-30  3209  		ptr = 32;
882212f550d669 Xiaolei Wang 2024-05-30  3210  		speed_div = 5000000;
882212f550d669 Xiaolei Wang 2024-05-30  3211  		break;
882212f550d669 Xiaolei Wang 2024-05-30  3212  	case SPEED_2500:
882212f550d669 Xiaolei Wang 2024-05-30  3213  		ptr = 8;
882212f550d669 Xiaolei Wang 2024-05-30  3214  		speed_div = 2500000;
882212f550d669 Xiaolei Wang 2024-05-30  3215  		break;
882212f550d669 Xiaolei Wang 2024-05-30  3216  	case SPEED_1000:
882212f550d669 Xiaolei Wang 2024-05-30  3217  		ptr = 8;
882212f550d669 Xiaolei Wang 2024-05-30  3218  		speed_div = 1000000;
882212f550d669 Xiaolei Wang 2024-05-30  3219  		break;
882212f550d669 Xiaolei Wang 2024-05-30  3220  	case SPEED_100:
882212f550d669 Xiaolei Wang 2024-05-30  3221  		ptr = 4;
882212f550d669 Xiaolei Wang 2024-05-30  3222  		speed_div = 100000;
882212f550d669 Xiaolei Wang 2024-05-30  3223  		break;
882212f550d669 Xiaolei Wang 2024-05-30  3224  	default:
882212f550d669 Xiaolei Wang 2024-05-30  3225  		netdev_dbg(priv->dev, "link speed is not known\n");

return;?

882212f550d669 Xiaolei Wang 2024-05-30  3226  	}
19d9187317979c Joao Pinto   2017-03-10  3227  
44781fef137896 Joao Pinto   2017-03-31  3228  	/* queue 0 is reserved for legacy traffic */
44781fef137896 Joao Pinto   2017-03-31  3229  	for (queue = 1; queue < tx_queues_count; queue++) {
19d9187317979c Joao Pinto   2017-03-10  3230  		mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
19d9187317979c Joao Pinto   2017-03-10  3231  		if (mode_to_use == MTL_QUEUE_DCB)
19d9187317979c Joao Pinto   2017-03-10  3232  			continue;
19d9187317979c Joao Pinto   2017-03-10  3233  
882212f550d669 Xiaolei Wang 2024-05-30 @3234  		value = div_s64(priv->old_idleslope[queue] * 1024ll * ptr, speed_div);
                                                                                                              ^^^  ^^^^^^^^^^
Uninitialized.

882212f550d669 Xiaolei Wang 2024-05-30  3235  		priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
882212f550d669 Xiaolei Wang 2024-05-30  3236  
882212f550d669 Xiaolei Wang 2024-05-30  3237  		value = div_s64(-priv->old_sendslope[queue] * 1024ll * ptr, speed_div);
882212f550d669 Xiaolei Wang 2024-05-30  3238  		priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
882212f550d669 Xiaolei Wang 2024-05-30  3239  
c10d4c82a5c84c Jose Abreu   2018-04-16  3240  		stmmac_config_cbs(priv, priv->hw,
19d9187317979c Joao Pinto   2017-03-10  3241  				priv->plat->tx_queues_cfg[queue].send_slope,
19d9187317979c Joao Pinto   2017-03-10  3242  				priv->plat->tx_queues_cfg[queue].idle_slope,
19d9187317979c Joao Pinto   2017-03-10  3243  				priv->plat->tx_queues_cfg[queue].high_credit,
19d9187317979c Joao Pinto   2017-03-10  3244  				priv->plat->tx_queues_cfg[queue].low_credit,
19d9187317979c Joao Pinto   2017-03-10  3245  				queue);
19d9187317979c Joao Pinto   2017-03-10  3246  	}
19d9187317979c Joao Pinto   2017-03-10  3247  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


