Return-Path: <netdev+bounces-201947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49923AEB890
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01667A9CA2
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795182D97A4;
	Fri, 27 Jun 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8c75ek8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A42D8DC5
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751029922; cv=none; b=T0UtCi3Cs9Z6rDm8M0RuROau0IkW+Jze45DJ8m5ZgYEiC4mVOcl/IAe/jW6kpeKbTgXr/ZTPpaTEKv07akzsqt/Boy+mFC9AzefIYXktTisCxauShV0RL1EITnHWjT5Ls7wxhjUOj5D3owo47lp3R0RvWnC7UXuE9WZgqF3wWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751029922; c=relaxed/simple;
	bh=mIJdA8oyrBJtCKvVrpFyFaT8GrYlGBhg+w1F4G+yCO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmFei7cQAMb2Sq7K38t3Dqs669IR9ixPbti0ZDGvvVBtF918oScHqbBsDJ1Dqo0UsrzWTgQMUEUowqMXmLK6ngCvfnKlNSn8xjEBoRJXwwOetG1oRJy4zyJTvvRwYu4G6y7RFoK5o1Oifu+60P/RmNJCGuo/oiIofJflVDexT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8c75ek8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751029919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ys8fge79MdtM3x3QY1EsmwTkUuQvryJDQHLXtfNdWdE=;
	b=Y8c75ek8z1EGUcIg+Vi+ggIXDKnUMJYUFmZ00ujAH3gA/zQj20Cbc2tKX7M1R7jq51zwXj
	75nmlrTzi6ha9IW9y2RqnMd0u1Lneu04BZ4i8H+sb/mllzkjxN9HWhCNW0bMxeN5eVMQEP
	h8rPYTJpYl8Ud794R32rodq+ceKWQwY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-AP__KTXANIaQaeV8JXHuyw-1; Fri, 27 Jun 2025 09:11:58 -0400
X-MC-Unique: AP__KTXANIaQaeV8JXHuyw-1
X-Mimecast-MFC-AGG-ID: AP__KTXANIaQaeV8JXHuyw_1751029917
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d30992bcso14924005e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 06:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751029917; x=1751634717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ys8fge79MdtM3x3QY1EsmwTkUuQvryJDQHLXtfNdWdE=;
        b=Lg4nk4/COL82uH24TSZKN0XxCyf7hMU0EDp/8OQ9pOsgNslJRDpBkp1OsSNQgdpTiW
         m3XRrfrH2qZs8t+gSKcLGKszWXYEbOqXnoDczjYxtSp3dHTBAk7SCGaL09R21lsIzJZj
         aUkvu9J374hMUxwZtyQ0rbVvRfjCGtAeRjvdL/IPfx4ymp/iz83jeXTn4CZXeaRoo9E8
         Xo9BoRH/qsCvAT41bffFO+ASBibUQofAZW+kTfOtUKZSWuOoInhiwUpEQI8phvljaRJf
         cfzLDvTAGingQljRrhcNyN7PoDEaHlItmGke+WWg3EbFBYrwu6gwY8MFv6Zhyip//hRf
         LUnA==
X-Forwarded-Encrypted: i=1; AJvYcCWNjrhnCAbiwMNhn4dUJC9H5R7KfIe75XzxE0JDR0sA2H4euNrqhCJA+MPG1fzhv2kmep1Lu/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVcusZztgnEOEsaw3sQOxdVpQvZRFzq8wdKkLle3isf071Dl5B
	0BYJzKyBF+pbnhZf6S5MVngcE8jcoRFbgE8dO+jcslDCc6bXKyRSFN+spwIAX0MVYavLtzbLv6d
	egazgz0t3bTGPAKx4BDjyen5Mc0YCYFJdMIkVKVLB4A7khfpVyZoMTI96bA==
X-Gm-Gg: ASbGncuJIrtlTwHtPQKEcmXgvKRiX1s4OlXc6SuzNOP2DRLu72aVdBt884G4gF4WFQl
	5aMa/DXRIvrE2xoWAmQiS4r4pg9hqMXeyC/R/FegNLOvbWCh/NMFUi26wzord/CS8Nn8khGQH4d
	w9yztc8kY5ZfV6kwTHUgcpojBV5hZBHBaFvbL3tIJX6lUCZvgfHeNmLs/vNw4vJrupWGBDLGm78
	OSnhaRlpqMtMIoCy48ilBMb2q/VDg43nVoql64Zk/4RvvXB/YjmepAwZnbUV0zBsrjUNVbkwquB
	filqWAmgKTgW/njwE/F8u7mx+nuqgtme7Sc6m2JdzkydDaGLcZM1UyAEUyVoK4lmJZoypA==
X-Received: by 2002:a05:600c:1c82:b0:442:e109:3027 with SMTP id 5b1f17b1804b1-4538ff99773mr24440075e9.24.1751029916807;
        Fri, 27 Jun 2025 06:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOjbmnV8AGEK3VsZuXyJT+M82EkGZQMH1NSx1G2LB57B4V2LMyf8aplKTlmyoakMjajubMtg==
X-Received: by 2002:a05:600c:1c82:b0:442:e109:3027 with SMTP id 5b1f17b1804b1-4538ff99773mr24439355e9.24.1751029916255;
        Fri, 27 Jun 2025 06:11:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f918sm2672083f8f.100.2025.06.27.06.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 06:11:55 -0700 (PDT)
Message-ID: <eca0952c-d96c-4d80-8f07-86c8d4caae0b@redhat.com>
Date: Fri, 27 Jun 2025 15:11:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 4/9] vhost-net: allow configuring extended
 features
To: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
 Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org
References: <23e46bff5333015d92bf0876033750d9fbf555a0.1750753211.git.pabeni@redhat.com>
 <202506271443.G9cAx8PS-lkp@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <202506271443.G9cAx8PS-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+csky maintainer
On 6/27/25 8:41 AM, kernel test robot wrote:
> Hi Paolo,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/scripts-kernel_doc-py-properly-handle-VIRTIO_DECLARE_FEATURES/20250624-221751
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/23e46bff5333015d92bf0876033750d9fbf555a0.1750753211.git.pabeni%40redhat.com
> patch subject: [PATCH v6 net-next 4/9] vhost-net: allow configuring extended features
> config: csky-randconfig-001-20250627 (https://download.01.org/0day-ci/archive/20250627/202506271443.G9cAx8PS-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250627/202506271443.G9cAx8PS-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506271443.G9cAx8PS-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/uaccess.h:12,
>                     from include/linux/sched/task.h:13,
>                     from include/linux/sched/signal.h:9,
>                     from include/linux/rcuwait.h:6,
>                     from include/linux/percpu-rwsem.h:7,
>                     from include/linux/fs.h:34,
>                     from include/linux/compat.h:17,
>                     from drivers/vhost/net.c:8:
>    arch/csky/include/asm/uaccess.h: In function '__get_user_fn.constprop':
>>> arch/csky/include/asm/uaccess.h:147:9: warning: 'retval' is used uninitialized [-Wuninitialized]
>      147 |         __asm__ __volatile__(                           \
>          |         ^~~~~~~
>    arch/csky/include/asm/uaccess.h:187:17: note: in expansion of macro '__get_user_asm_64'
>      187 |                 __get_user_asm_64(x, ptr, retval);
>          |                 ^~~~~~~~~~~~~~~~~
>    arch/csky/include/asm/uaccess.h:170:13: note: 'retval' was declared here
>      170 |         int retval;
>          |             ^~~~~~
> 
> 
> vim +/retval +147 arch/csky/include/asm/uaccess.h
> 
> da551281947cb2c Guo Ren 2018-09-05  141  
> e58a41c2226847f Guo Ren 2021-04-21  142  #define __get_user_asm_64(x, ptr, err)			\
> da551281947cb2c Guo Ren 2018-09-05  143  do {							\
> da551281947cb2c Guo Ren 2018-09-05  144  	int tmp;					\
> e58a41c2226847f Guo Ren 2021-04-21  145  	int errcode;					\
> e58a41c2226847f Guo Ren 2021-04-21  146  							\
> e58a41c2226847f Guo Ren 2021-04-21 @147  	__asm__ __volatile__(				\
> e58a41c2226847f Guo Ren 2021-04-21  148  	"1:   ldw     %3, (%2, 0)     \n"		\
> da551281947cb2c Guo Ren 2018-09-05  149  	"     stw     %3, (%1, 0)     \n"		\
> e58a41c2226847f Guo Ren 2021-04-21  150  	"2:   ldw     %3, (%2, 4)     \n"		\
> e58a41c2226847f Guo Ren 2021-04-21  151  	"     stw     %3, (%1, 4)     \n"		\
> e58a41c2226847f Guo Ren 2021-04-21  152  	"     br      4f              \n"		\
> e58a41c2226847f Guo Ren 2021-04-21  153  	"3:   mov     %0, %4          \n"		\
> e58a41c2226847f Guo Ren 2021-04-21  154  	"     br      4f              \n"		\
> da551281947cb2c Guo Ren 2018-09-05  155  	".section __ex_table, \"a\"   \n"		\
> da551281947cb2c Guo Ren 2018-09-05  156  	".align   2                   \n"		\
> e58a41c2226847f Guo Ren 2021-04-21  157  	".long    1b, 3b              \n"		\
> e58a41c2226847f Guo Ren 2021-04-21  158  	".long    2b, 3b              \n"		\
> da551281947cb2c Guo Ren 2018-09-05  159  	".previous                    \n"		\
> e58a41c2226847f Guo Ren 2021-04-21  160  	"4:                           \n"		\
> e58a41c2226847f Guo Ren 2021-04-21  161  	: "=r"(err), "=r"(x), "=r"(ptr),		\
> e58a41c2226847f Guo Ren 2021-04-21  162  	  "=r"(tmp), "=r"(errcode)			\
> e58a41c2226847f Guo Ren 2021-04-21  163  	: "0"(err), "1"(x), "2"(ptr), "3"(0),		\
> e58a41c2226847f Guo Ren 2021-04-21  164  	  "4"(-EFAULT)					\
> da551281947cb2c Guo Ren 2018-09-05  165  	: "memory");					\
> da551281947cb2c Guo Ren 2018-09-05  166  } while (0)
> da551281947cb2c Guo Ren 2018-09-05  167  

The intel test report reported the above compile warning on this series:

https://lore.kernel.org/netdev/20250627084609-mutt-send-email-mst@kernel.org/T/#md788de2b3a4e9da23ac93b5f1c773a6070b5b4fb

specifically, in patch 4:

+                       if (get_user(features, featurep + 1 + i))
+                               return -EFAULT;

AFAICS such statement is legit, and the bot points to some problem in
the arch specific get_user() implementation. Could you please have a look?

Thanks,

Paolo


