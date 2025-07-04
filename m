Return-Path: <netdev+bounces-204167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69422AF9508
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B699A6E30C4
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273141684A4;
	Fri,  4 Jul 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWNkid1X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7415442A
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638149; cv=none; b=b/TEgnDOCZCyrcHxylnl1jJPetd4CyU163Iilv34QoQL8FRbOPcFo4FG3j+/wDAE1tTYjPF9co4TAnkB/LOAYTYxbyP+hpRvxYLYopMOqrcVAu7x0sMIsbIeH34d+wv5MhnTD5ZqGXeogAgXdAuemT5WX0+NKWDB4h7+5XEb5Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638149; c=relaxed/simple;
	bh=U6F2dHrTPmeRrvSQlmw8aoKVIdLE2eX2EcsjXstUjps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Il2awTdyveGggPcvlbYxzCp+xHzHltrOw6AzIOXSkq7PtOvk9RZRQkx569L7fleHc6dj1kKIdy0g4Mt1fACfcbv8Er064SDOn59nGhA2a0g/s1nw4rCQKeRG/i6h8pOAsS7WxcV9s470bVNKZg7oA3i0BJd2oLcCEKou141wTE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWNkid1X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751638146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNE34YJ4bJTdCiv/b67QdArh6u6YpWkqfxv7OOglQc8=;
	b=aWNkid1X65UC1UmbLZPWMXbodiht+af1y8TO/T3og09MWT60AWUe67sD4yR6dOaxR8wdaX
	qHjF19WOjmNOOuyEZHvMbl9MpeG/bzw59+qXMvkAc4RUdEENuKz9n2LTMP7po2BqE+EUF6
	fuAlEr1Q85G+oDn3sLWPGFZx3knEYjk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-yInRyhNhOSSDMSfD9vbOcA-1; Fri, 04 Jul 2025 10:09:04 -0400
X-MC-Unique: yInRyhNhOSSDMSfD9vbOcA-1
X-Mimecast-MFC-AGG-ID: yInRyhNhOSSDMSfD9vbOcA_1751638144
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso651780f8f.2
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 07:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751638143; x=1752242943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNE34YJ4bJTdCiv/b67QdArh6u6YpWkqfxv7OOglQc8=;
        b=DgXW0ecTluTxBuGHDHQy/UkAPVXeSyeRHYZ44+nzYLPaJY7EJ4p7qKHqQa8cpvdUuX
         UYIJj2mAcHKYh4nfFrL25Q1HgLxSTDjzIns7iNxWQYl9S/RMyKp3jPT6aefnyC/kddKB
         Dx5vUypM6PvF6WbIVz9m7i6oQIvTyViVGw3dR9F61UOqr0/rzQAGZ/MmsgnB1kx2bc5C
         DKEhaY2AgZd17f6RSFQTaNqqFsoOlQe/N38vw03Fa8MpcI3V/9y9OUZONCD1Nltw4fuW
         NBNGFZj95weF0smOmp93rhgSRFDNSfyGaCrjXX6tokMkGZxv+YT18QYXAsXv5i8NaBzn
         mr0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMyVDpOs+k0nYDGFnajDu3ka6bHNEM5IlSCFCUy3kAtVUTgvQF9koH/jvFW3NwW5XsEItlznU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfAwcnS3rFFu464p4iYF2+zf9hLZ68QBfz2BshcyS3b1ZWjksh
	65xAWlDUUJNkLWSBGoAOe3al2P1it/0xNKle4x4qGUPxSQSJ1KKZVtunS8TOYVarWb/T3gm5Hk4
	kNn8dzfs1MK8Lhyez6CqFqXquV2bv7xZm3Pvgfdjed87N7AWGxq+RtkqUmw==
X-Gm-Gg: ASbGnctvkOZWJr0vUeb3bCLRNOnfuAzpP76hk9Mqmn+4tx+LQScxTUGTmTIZzM0zm++
	A7yoTJvyW2Sp1dkyikeU+DP2DJGBhWhqdPjlWUpXxdia3KGJcVX2nEEg12hCIapJxw1gq32hcJq
	o1zrQz0htNIKdQXdzBZSfd7zVTymNZ/V/VU/Rd3NyPXQDmhtIO5IXhikgXDgouJ3W84P49EEWFc
	6qIUjM1gBZM1mKowNYbI1xCex1Kt4z2RlaRae5Sr1Z8Q6JSeRzbeodrVcCdLhfzrc/0juOuOwHy
	VHqqSy4I5KrZoBCvivB5s333vsj6IsBT1hcb7YP2X3epJsVcPB0jCoc/keMD+eViIjs=
X-Received: by 2002:a5d:59c6:0:b0:3a4:f430:2547 with SMTP id ffacd0b85a97d-3b4964f373dmr2208989f8f.6.1751638143331;
        Fri, 04 Jul 2025 07:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7BaEbdvgTH4TXkFbL8aK5aSuqQqmuFuwPrq4OfVKVv3+Qx3O+iy3X6AnW5/0CjUj4zMFnmg==
X-Received: by 2002:a5d:59c6:0:b0:3a4:f430:2547 with SMTP id ffacd0b85a97d-3b4964f373dmr2208933f8f.6.1751638142700;
        Fri, 04 Jul 2025 07:09:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0941sm2564867f8f.26.2025.07.04.07.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 07:09:01 -0700 (PDT)
Message-ID: <9904e4df-2aac-4dfc-9584-39140ccabbf7@redhat.com>
Date: Fri, 4 Jul 2025 16:09:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 4/9] vhost-net: allow configuring extended
 features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org
References: <23e46bff5333015d92bf0876033750d9fbf555a0.1750753211.git.pabeni@redhat.com>
 <202506271443.G9cAx8PS-lkp@intel.com>
 <d172caa9-6d31-45a3-929c-d3927ba6702e@redhat.com>
 <20250627075441-mutt-send-email-mst@kernel.org>
 <9a940f1d-da2e-4400-909b-36c5d72c950a@redhat.com>
 <20250627084609-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250627084609-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 2:47 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 27, 2025 at 02:44:42PM +0200, Paolo Abeni wrote:
>> On 6/27/25 2:18 PM, Michael S. Tsirkin wrote:
>>> On Fri, Jun 27, 2025 at 12:28:00PM +0200, Paolo Abeni wrote:
>>>> On 6/27/25 8:41 AM, kernel test robot wrote:
>>>>> kernel test robot noticed the following build warnings:
>>>>>
>>>>> [auto build test WARNING on net-next/main]
>>>>>
>>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/scripts-kernel_doc-py-properly-handle-VIRTIO_DECLARE_FEATURES/20250624-221751
>>>>> base:   net-next/main
>>>>> patch link:    https://lore.kernel.org/r/23e46bff5333015d92bf0876033750d9fbf555a0.1750753211.git.pabeni%40redhat.com
>>>>> patch subject: [PATCH v6 net-next 4/9] vhost-net: allow configuring extended features
>>>>> config: csky-randconfig-001-20250627 (https://download.01.org/0day-ci/archive/20250627/202506271443.G9cAx8PS-lkp@intel.com/config)
>>>>> compiler: csky-linux-gcc (GCC) 15.1.0
>>>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250627/202506271443.G9cAx8PS-lkp@intel.com/reproduce)
>>>>>
>>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>>> the same patch/commit), kindly add following tags
>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202506271443.G9cAx8PS-lkp@intel.com/
>>>>>
>>>>> All warnings (new ones prefixed by >>):
>>>>>
>>>>>    In file included from include/linux/uaccess.h:12,
>>>>>                     from include/linux/sched/task.h:13,
>>>>>                     from include/linux/sched/signal.h:9,
>>>>>                     from include/linux/rcuwait.h:6,
>>>>>                     from include/linux/percpu-rwsem.h:7,
>>>>>                     from include/linux/fs.h:34,
>>>>>                     from include/linux/compat.h:17,
>>>>>                     from drivers/vhost/net.c:8:
>>>>>    arch/csky/include/asm/uaccess.h: In function '__get_user_fn.constprop':
>>>>>>> arch/csky/include/asm/uaccess.h:147:9: warning: 'retval' is used uninitialized [-Wuninitialized]
>>>>>      147 |         __asm__ __volatile__(                           \
>>>>>          |         ^~~~~~~
>>>>>    arch/csky/include/asm/uaccess.h:187:17: note: in expansion of macro '__get_user_asm_64'
>>>>>      187 |                 __get_user_asm_64(x, ptr, retval);
>>>>>          |                 ^~~~~~~~~~~~~~~~~
>>>>>    arch/csky/include/asm/uaccess.h:170:13: note: 'retval' was declared here
>>>>>      170 |         int retval;
>>>>>          |             ^~~~~~
>>>>>
>>>>>
>>>>> vim +/retval +147 arch/csky/include/asm/uaccess.h
>>>>>
>>>>> da551281947cb2c Guo Ren 2018-09-05  141  
>>>>> e58a41c2226847f Guo Ren 2021-04-21  142  #define __get_user_asm_64(x, ptr, err)			\
>>>>> da551281947cb2c Guo Ren 2018-09-05  143  do {							\
>>>>> da551281947cb2c Guo Ren 2018-09-05  144  	int tmp;					\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  145  	int errcode;					\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  146  							\
>>>>> e58a41c2226847f Guo Ren 2021-04-21 @147  	__asm__ __volatile__(				\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  148  	"1:   ldw     %3, (%2, 0)     \n"		\
>>>>> da551281947cb2c Guo Ren 2018-09-05  149  	"     stw     %3, (%1, 0)     \n"		\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  150  	"2:   ldw     %3, (%2, 4)     \n"		\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  151  	"     stw     %3, (%1, 4)     \n"		\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  152  	"     br      4f              \n"		\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  153  	"3:   mov     %0, %4          \n"		\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  154  	"     br      4f              \n"		\
>>>>> da551281947cb2c Guo Ren 2018-09-05  155  	".section __ex_table, \"a\"   \n"		\
>>>>> da551281947cb2c Guo Ren 2018-09-05  156  	".align   2                   \n"		\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  157  	".long    1b, 3b              \n"		\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  158  	".long    2b, 3b              \n"		\
>>>>> da551281947cb2c Guo Ren 2018-09-05  159  	".previous                    \n"		\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  160  	"4:                           \n"		\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  161  	: "=r"(err), "=r"(x), "=r"(ptr),		\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  162  	  "=r"(tmp), "=r"(errcode)			\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  163  	: "0"(err), "1"(x), "2"(ptr), "3"(0),		\
>>>>> e58a41c2226847f Guo Ren 2021-04-21  164  	  "4"(-EFAULT)					\
>>>>> da551281947cb2c Guo Ren 2018-09-05  165  	: "memory");					\
>>>>> da551281947cb2c Guo Ren 2018-09-05  166  } while (0)
>>>>> da551281947cb2c Guo Ren 2018-09-05  167  
>>>>
>>>> AFAICS the issue reported here is in the arch-specific uaccess helpers
>>>> and not related to this series.
>>>>
>>>> /P
>>>
>>> I think it's due to code like this in your patch:
>>>
>>> +                       if (get_user(features, featurep + 1 + i))
>>> +                               return -EFAULT;
>>>
>>> the specific arch might have a bug that this is unconvering,
>>> or a limitation, I can't say.
>>>
>>> Seems worth fixing, though.
>>>
>>> Poke the mainatiners?
>>
>> FTR, I tried the boot reproducer locally, and does not trigger here.
>>
>> The above statement is AFAICS legit, and the issue, if any, is present
>> into such arch. I would not say this patch is 'uncovering' anything, as
>> the relevant pattern is very common.
>>
>> Possibly the test robot added support for csky only recently?
>>
>> I will ping the arch maintainers, but I suggest/argue not blocking this
>> series for this thing.
>>
>> Thanks,
>>
>> Paolo
> 
> OK.
> Still sick sadly, so I took  more time off through end of month.  If
> this can wait with thorough review until then, maybe the arch
> maintainers will respond.

Just in case you are well again - I sincerely hope that! - and there is
some misunderstanding on the current status, this series is waiting for
your approval.

Cheers,

Paolo


