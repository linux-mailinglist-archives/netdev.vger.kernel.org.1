Return-Path: <netdev+bounces-201874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FE7AEB4C7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C016E1C41704
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618062D97A3;
	Fri, 27 Jun 2025 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJKIDDKl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7570D2D9797
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020089; cv=none; b=B82dK5YteXLqMT+5/McOlLWJ4yFnYtm4Y1pQK9D2Fcor7wl1i41iiV3nhVWHhdmdMzvtyqM1pxbDQJZeLU4kLwSVmyBzzZwZ3r6oxPCi0926kCF9ekHrOGf/el8WOjnS8YOLsoGBE9Xj/4HHbnx9N9qWIl4CKTowVS6z79Ezmy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020089; c=relaxed/simple;
	bh=L+QrdPiV6RVKjdNxIalHS5LAvUl5JKrsnqMr9MWkF+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtHwudtPddmihFKComKkfXUKZMJwF9lZ1V8jDmLa1Q69yjPWssJWOGD//cdem3oodOWwL4cfmiHs3rPP3rE0l4KDKoVjyHn9mD1j6+W/4JopvWDFQVBiB8EdRxNrKwsSAeBW6oMdicJcdl8QGAy3Gsj7mb71GM53o8ogU6ccXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJKIDDKl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751020086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJdsZHiVVLuKwLXH4KCxaDOcm8lE5bSikqTqeRxiKOY=;
	b=BJKIDDKlxqVgG0CBYGsq2nqvXlwkAsb9Qlb5Jt6zlLQHAwsAnQy/tUIlPD4nu0JpSjBXOh
	opWs0yj59upxeqt2iViwRkrj1vwmW5QMRPxoXxmJs+Xcjne6GN0j/VrxZd8CLwUNAtPETL
	oySCYsU4/yVnczu+wOJbd+PLt6+lE8s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-cbBhTak3Mb2fuZDmczO6OA-1; Fri, 27 Jun 2025 06:28:05 -0400
X-MC-Unique: cbBhTak3Mb2fuZDmczO6OA-1
X-Mimecast-MFC-AGG-ID: cbBhTak3Mb2fuZDmczO6OA_1751020084
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d244bfabso16427625e9.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 03:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751020084; x=1751624884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJdsZHiVVLuKwLXH4KCxaDOcm8lE5bSikqTqeRxiKOY=;
        b=QD8asgyzxabJnBLqwYwn024xOWK79Ikyjndf/GKsfuGqA+0uhnhW8vh82cmU3Vw1L+
         iFzwwa8mN9tuMfO837sdfnZmeJFXF0JG7sA9g8CTlFDq/g50BI5RqFiv/Djm8QIysveb
         TUlgGL4iKiNEVYxCYv87gqMEbyIUUMyivelFIcwNeOrauW/In9YY+W0mQyLZN19Sko+8
         akpSfXOlZEcMzXYBKKLFHB+wTQv7wlHr1zuwBQtMUGPeidaRqzZPStNViT+7aLXLdYX+
         tS7B5H7JEx3u9RSv0CjqMAK4YJGGj8tL2dfODRg1B5Fpnz6M9EFfd6qzOe7bknbZQH18
         ztdg==
X-Forwarded-Encrypted: i=1; AJvYcCUYtZK6IIk9OQJJh3lh9Wu1OSXmWr9k9bmPDOXn9gCeFSIgQ0bOS1LIHVLXXEOP2jRn+yKBqP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSfVGXkIc5sOsYNYzuH6O+XmcnH7DXjd7CBJc0XSoi9VSGARTh
	v7WYKTVCmMHyx0mVGaCssE4nXWtp/zUGvej+4EoqS3vKRpgeQeRyuFKvP603Wn0V+nCaAIBFlR2
	MhOvCnNZuxlxhjUPKJELxBVs4XltLhEOjwZ+dLWvCrDWAyhnyjWhFtZt2yQ==
X-Gm-Gg: ASbGncsIxJ66kESNFmVtCYUqX5Fvb+aUJENKKDgKUh/SYtvxIsBf9JRcrIJ35Cb2xgr
	R4c4Dk7SJKi/XOkH2K0SwIDC4gsHd5E8HdjHsv3oTpc9pExSogNTXQrbfpjNPYE+S+0hXGFsPoY
	O+A6plPsDfeXluWsDlRu3k2QugDK2ESrei8VZILdAFEKaWCkvRL1OacWtRe2WLwIHWFqM+ZdWws
	UNzm4yRtLJhuM+RODAD7LpK9cbfbe4MTxUzKh9nENi6TLtzScu90Vpa16Crt4rypH2uPP/kyiBF
	MwyM7nh3ObDFrZd0c7B1zS92/E2njQK8x+lZwuY6PSKRcItERa1yMndn2ppSgVrbpresxA==
X-Received: by 2002:a05:600c:674f:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-4538ee8384emr26594085e9.19.1751020083754;
        Fri, 27 Jun 2025 03:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9k4IjA2+y/oHun89HaX7Ynjd/DsFZcqDREnTUjAINHGGZ0PW4fhojEDavNVYzeGalZ02RXQ==
X-Received: by 2002:a05:600c:674f:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-4538ee8384emr26593745e9.19.1751020083235;
        Fri, 27 Jun 2025 03:28:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm73314445e9.10.2025.06.27.03.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 03:28:02 -0700 (PDT)
Message-ID: <d172caa9-6d31-45a3-929c-d3927ba6702e@redhat.com>
Date: Fri, 27 Jun 2025 12:28:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 4/9] vhost-net: allow configuring extended
 features
To: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org
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

On 6/27/25 8:41 AM, kernel test robot wrote:
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

AFAICS the issue reported here is in the arch-specific uaccess helpers
and not related to this series.

/P


