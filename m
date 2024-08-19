Return-Path: <netdev+bounces-119926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC6495784F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F343B23018
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 23:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD3915AAB8;
	Mon, 19 Aug 2024 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M95E1/Me"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29E14D43D
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 23:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108522; cv=none; b=ugQjASKE3SCYR3QFzuCwwlljLUSV0xooVDt0P7cUulOFz3vuedLxquaqH8P+XHZfZb6i3OAh/QCkYLrig6JjOjrouQ1tefNJfzoE9OylybIqH6nAEf/cZamOLWT5iZYnHum2gRUmFyBMkqQ/hX8l1mdJJVV0AgOSXG25jKlHRxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108522; c=relaxed/simple;
	bh=aOQ/AvfwIXKWVE9u2nssUAmSoql78J0GzbDbsxKCxiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxCeqyk7M5z+7CrS+xlpjxmR28ukisxCeW91RZ80t4c/3w3T4RrT7pqOO6C13CrGYQmyPXXbojFoim0F8YNPu6C+DuoKRiDwZCdCqC5MFakRqmw9mKGgaMdoWZ9PUihIYqBaMN+lFY4GkiCo5/N4sezbp6KYrjHf+VlKC5zFSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M95E1/Me; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7105043330aso3907114b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 16:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724108520; x=1724713320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PRthf3/5zB/bDozkCUHPPkJX2b7Asaxsbf+UdOFSa5w=;
        b=M95E1/MepYi5a3QIJJd4LJnj/eFWanV/n5+LosCivZoSmqGNOGC/3x3tzE++JoDZr4
         0GwU4QyBLCl8eTryspCqGAtTSDFBOGl8DPzIgUSoFEyx3ylh3AcM1vrcWBu6BogpIOTt
         qfvb70BzwjLOvAHRaYzf3WE8I2pOKTkqA8nCQWS3mhBSQdHe40oZuX+28pJSGSgT9djp
         WWKv0Pj3c0QrA+XVIlrwk6Hk798KynfN8zf1cpqz8zZe4Kywihnim8Mz5lznvcAcvjTI
         7zX/BrhRmicc2LZ+wNw9USq0JhHC4/dSMpm75k3L0e0qMPZWGZTBZdZKNMMZ6cfZmJ/s
         hCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724108520; x=1724713320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRthf3/5zB/bDozkCUHPPkJX2b7Asaxsbf+UdOFSa5w=;
        b=N1DdjBstNFkUsT6WiuThgulCimUh9I8W4SlDQTQX2BJDyE/p+sB7EQACESYuqL5iLW
         /6sCWiiRJrA2uP2i4FT/ab4/a8xR+OxGLSMDZ+4tGSoYl19Sa9KlP+xiOSJkgXkDmHwY
         3NyW4RVg91K+7Ct4jiv5hzl3nGxk4ctECVR0CXRwNoFf9ivUoX7TOKqO+GL2i1WmNrET
         IwVUmgDLnOlmiYsxPwjofvBZlFfb+sVzgRHcotOeKVRBe+SWSNzufZhL+HcQG67Bay/l
         afzldqLH8vQjH2ap8R/rlFrs3EAfrAAco46C2q1Uma0VmG8ZtSbhOJ0CdNrWZ//lBasC
         B/0g==
X-Gm-Message-State: AOJu0YzJVmanqbPWFqs39TaEEBa4MlGXXPOx/ScgrWbDLq3o0e9Jxg8s
	CDu8kchZWd35ukt5ZK2djcQu71sDwyn/JjRuRZQNztbim9miAXPXTAgk4m7bIqI=
X-Google-Smtp-Source: AGHT+IF5pDD59PObLd1+d0FpzEGL2rUuQ8YOBhWOfSRzQSN31gavhpsQRaKLr+k2w5mGg2FPQ/xeYQ==
X-Received: by 2002:a05:6a21:3984:b0:1c3:a411:dc49 with SMTP id adf61e73a8af0-1c90505aa0bmr12293118637.51.1724108519776;
        Mon, 19 Aug 2024 16:01:59 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae07443sm7080128b3a.48.2024.08.19.16.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 16:01:59 -0700 (PDT)
Date: Tue, 20 Aug 2024 07:01:53 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCHv2 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <ZsPO4SKb7MIh_wQC@Laptop-X1>
References: <20240819075334.236334-3-liuhangbin@gmail.com>
 <202408200431.wjjkEZ2m-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408200431.wjjkEZ2m-lkp@intel.com>

On Tue, Aug 20, 2024 at 05:17:52AM +0800, kernel test robot wrote:
> Hi Hangbin,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hangbin-Liu/bonding-add-common-function-to-check-ipsec-device/20240819-195504
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240819075334.236334-3-liuhangbin%40gmail.com
> patch subject: [PATCHv2 net-next 2/3] bonding: Add ESN support to IPSec HW offload
> config: x86_64-buildonly-randconfig-001-20240820 (https://download.01.org/0day-ci/archive/20240820/202408200431.wjjkEZ2m-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408200431.wjjkEZ2m-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408200431.wjjkEZ2m-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/net/bonding/bond_main.c:434:10: error: returning 'void *' from a function with incompatible result type 'struct net_device'
>      434 |                 return NULL;
>          |                        ^~~~
>    include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
>        8 | #define NULL ((void *)0)
>          |              ^~~~~~~~~~~
>    drivers/net/bonding/bond_main.c:442:10: error: returning 'void *' from a function with incompatible result type 'struct net_device'
>      442 |                 return NULL;
>          |                        ^~~~
>    include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
>        8 | #define NULL ((void *)0)
>          |              ^~~~~~~~~~~
>    drivers/net/bonding/bond_main.c:446:9: error: returning 'struct net_device *' from a function with incompatible result type 'struct net_device'; dereference with *
>      446 |         return real_dev;
>          |                ^~~~~~~~
>          |                *
>    drivers/net/bonding/bond_main.c:630:11: error: assigning to 'struct net_device *' from incompatible type 'struct net_device'
>      630 |         real_dev = bond_ipsec_dev(xs);
>          |                  ^ ~~~~~~~~~~~~~~~~~~
>    drivers/net/bonding/bond_main.c:658:11: error: assigning to 'struct net_device *' from incompatible type 'struct net_device'
>      658 |         real_dev = bond_ipsec_dev(xs);
>          |                  ^ ~~~~~~~~~~~~~~~~~~
> >> drivers/net/bonding/bond_main.c:668:2: error: use of undeclared identifier 'rhel_dev'; did you mean 'real_dev'?

Hmm, weird... I tried to build the patch via `vng` before post, with
CONFIG_XFRM_OFFLOAD=y in tools/testing/selftests/drivers/net/bonding/config.
But looks it's not build in. Next time I need to double check..

Thanks
Hangbin

