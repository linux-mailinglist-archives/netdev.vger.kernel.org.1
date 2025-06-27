Return-Path: <netdev+bounces-201964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E43AEBA05
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF5D1C60801
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA422E339B;
	Fri, 27 Jun 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqEkXbma"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD003234
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034984; cv=none; b=DVPT9hFBcAfhNV0IpDSwwBSsu/3L+Nu4oIlNEPfBi+TPzS+QwcCGhwgRTIQP9ihfXqIALg7/b5J3kI6BaYPUShG6oyzpVBqfdcpoDc3kmhm3kXxYYYP7VUi9Z235GlaTuzV1EgD9tv59iID57MVTEZywzX2dDjVf4cQ1wmab6b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034984; c=relaxed/simple;
	bh=Tfu8JZFRme0Wx7D48w6lMCNGofFMcZDYXD29DNRCWMs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ddXmGeuuZzofQ5BeV9XXO0G0RU+v5SCrA+aB0xm32fqYCrDaVLcJEyYvZGxLrvp7G/jMF7ld7GZn9ojADinz6bf5ZDGYOFAAjq0attZhRjvUPqmVo1Obyy9/d0lrnx8+QtZrxUGCx1QJbv1yeNc8vlt91o/vMHL6OUoeywJCWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqEkXbma; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751034980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6d2ywoZ4WYJbwX3rPgTWq2na+2kMYRT6d9X4oshzDcQ=;
	b=QqEkXbmau+L6+w8uQvsECL/gHGkY/md7Lcb24DlXC27+MPW3ZETBk8Aao6+Ak20hOQP7FA
	Z/4pnGbXebdUcI2CBJphg8TqDJ7RJOnX+4UQCNKjKaOCUjG3zf9c2HP9ipSQv3t1bGhx1F
	dwFgIxqWEfsOSfM6F9b7/JHkL2F9MX4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-X2fbpUimOj6MP3pYxx8osA-1; Fri, 27 Jun 2025 10:36:19 -0400
X-MC-Unique: X2fbpUimOj6MP3pYxx8osA-1
X-Mimecast-MFC-AGG-ID: X2fbpUimOj6MP3pYxx8osA_1751034978
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso1449536f8f.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 07:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751034978; x=1751639778;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6d2ywoZ4WYJbwX3rPgTWq2na+2kMYRT6d9X4oshzDcQ=;
        b=rLkWmI4shSDLQFuHS1v2inMffryUfkwv//aH1LAGXie0hRgCipRARkSH8OXkqCKkAI
         lYIYV8lpJl3wTLTW4Wv74Bjo2CN4xkt3m5GyM1uDTxk6qrAjFtnUgS7wBtyLezNv4HuT
         As1XsunWhjESx+jReQgtiLPY2IngKd8BQbCCps3tgR/0ZpM/HV9In6/Qtt76WfKHNzg9
         1Dl+MUZhLYmOVg0ViwsPG9w6jc15i7bwkuhsUQLy9cP961uGx2/TgFStKiiGOF+0jTsf
         S+JgnaP0AMm+384UEJyjfeJORkAXoOO1UN5+tYzSQ10R/rfcckFW9HFw6pxPcHefZDvi
         hxLw==
X-Forwarded-Encrypted: i=1; AJvYcCVVxUKRBJRZ6l14s55o1tPqIf+4EqzNT4yyGBxxhKzSvoQMG0cagV0YA/oIVPN74UWw4hOmEhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBxiw+7Wnp3p1f7NVccKs6PkR2TG3f2IA8MfOO0Awdt3qdoaBP
	/eB5Kw5svAluKuwFX4QimPTB8f0wUfB1GoubwPvfjawKAOmWMjLbOD1hO5cPmx2/qPVRRI7LEDQ
	Rz6747Dr0d8amtMApega6KxxahiC/dNt/Iia9qo8VuwF38XCjPW14IooM+w==
X-Gm-Gg: ASbGnctV5GhbaWnab7yMXluH/ZUxZb0I8l2qxLwmHzSl1kXBwU3eCBbXUL+Z32adaZt
	h21BgJ2Zjie0srpAQYBUY8mhOr35kQvSuXn8pEw+W/LzF2UJ53Sk12SOFz571z/SzmEIPi+AiFb
	uvLSCrmiElru5KVx75vzCwbDNjyOEaEJCVjZq5JPyON6LOJIr7Fl2dKww7t/FSvUw8gvuWcI+dR
	TKSBzECQqX0nmfGcJowE6FDYtcujUAJeMGI0tN8/+HYWe0sXOHdI1T/R6RPaLv0HRYeCatx0Mkj
	T9K1oq2hnsfLHqQtXE/j3SBaeTuWjQlobdtZtAvy0yeznJKr3hc5heSFhwKEz1zP/rD/qw==
X-Received: by 2002:a5d:620d:0:b0:3a5:2ef8:34f9 with SMTP id ffacd0b85a97d-3a917603b17mr2772864f8f.27.1751034977617;
        Fri, 27 Jun 2025 07:36:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrL2JMPa0B3wSUQcYTT6SCHofxYsyABbFr/1j92PwwqgB+hJXVVINt691+I+fzBXgGF7JEog==
X-Received: by 2002:a5d:620d:0:b0:3a5:2ef8:34f9 with SMTP id ffacd0b85a97d-3a917603b17mr2772834f8f.27.1751034977124;
        Fri, 27 Jun 2025 07:36:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a390d3fsm53563295e9.1.2025.06.27.07.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 07:36:16 -0700 (PDT)
Message-ID: <27f1275a-aaff-4cc2-896c-b2c34f08ab73@redhat.com>
Date: Fri, 27 Jun 2025 16:36:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 4/9] vhost-net: allow configuring extended
 features
From: Paolo Abeni <pabeni@redhat.com>
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
 <eca0952c-d96c-4d80-8f07-86c8d4caae0b@redhat.com>
Content-Language: en-US
In-Reply-To: <eca0952c-d96c-4d80-8f07-86c8d4caae0b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 3:11 PM, Paolo Abeni wrote:
> +csky maintainer
> On 6/27/25 8:41 AM, kernel test robot wrote:
>> Hi Paolo,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on net-next/main]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/scripts-kernel_doc-py-properly-handle-VIRTIO_DECLARE_FEATURES/20250624-221751
>> base:   net-next/main
>> patch link:    https://lore.kernel.org/r/23e46bff5333015d92bf0876033750d9fbf555a0.1750753211.git.pabeni%40redhat.com
>> patch subject: [PATCH v6 net-next 4/9] vhost-net: allow configuring extended features
>> config: csky-randconfig-001-20250627 (https://download.01.org/0day-ci/archive/20250627/202506271443.G9cAx8PS-lkp@intel.com/config)
>> compiler: csky-linux-gcc (GCC) 15.1.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250627/202506271443.G9cAx8PS-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202506271443.G9cAx8PS-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>    In file included from include/linux/uaccess.h:12,
>>                     from include/linux/sched/task.h:13,
>>                     from include/linux/sched/signal.h:9,
>>                     from include/linux/rcuwait.h:6,
>>                     from include/linux/percpu-rwsem.h:7,
>>                     from include/linux/fs.h:34,
>>                     from include/linux/compat.h:17,
>>                     from drivers/vhost/net.c:8:
>>    arch/csky/include/asm/uaccess.h: In function '__get_user_fn.constprop':
>>>> arch/csky/include/asm/uaccess.h:147:9: warning: 'retval' is used uninitialized [-Wuninitialized]
>>      147 |         __asm__ __volatile__(                           \
>>          |         ^~~~~~~
>>    arch/csky/include/asm/uaccess.h:187:17: note: in expansion of macro '__get_user_asm_64'
>>      187 |                 __get_user_asm_64(x, ptr, retval);
>>          |                 ^~~~~~~~~~~~~~~~~
>>    arch/csky/include/asm/uaccess.h:170:13: note: 'retval' was declared here
>>      170 |         int retval;
>>          |             ^~~~~~
>>
>>
>> vim +/retval +147 arch/csky/include/asm/uaccess.h
>>
>> da551281947cb2c Guo Ren 2018-09-05  141  
>> e58a41c2226847f Guo Ren 2021-04-21  142  #define __get_user_asm_64(x, ptr, err)			\
>> da551281947cb2c Guo Ren 2018-09-05  143  do {							\
>> da551281947cb2c Guo Ren 2018-09-05  144  	int tmp;					\
>> e58a41c2226847f Guo Ren 2021-04-21  145  	int errcode;					\
>> e58a41c2226847f Guo Ren 2021-04-21  146  							\
>> e58a41c2226847f Guo Ren 2021-04-21 @147  	__asm__ __volatile__(				\
>> e58a41c2226847f Guo Ren 2021-04-21  148  	"1:   ldw     %3, (%2, 0)     \n"		\
>> da551281947cb2c Guo Ren 2018-09-05  149  	"     stw     %3, (%1, 0)     \n"		\
>> e58a41c2226847f Guo Ren 2021-04-21  150  	"2:   ldw     %3, (%2, 4)     \n"		\
>> e58a41c2226847f Guo Ren 2021-04-21  151  	"     stw     %3, (%1, 4)     \n"		\
>> e58a41c2226847f Guo Ren 2021-04-21  152  	"     br      4f              \n"		\
>> e58a41c2226847f Guo Ren 2021-04-21  153  	"3:   mov     %0, %4          \n"		\
>> e58a41c2226847f Guo Ren 2021-04-21  154  	"     br      4f              \n"		\
>> da551281947cb2c Guo Ren 2018-09-05  155  	".section __ex_table, \"a\"   \n"		\
>> da551281947cb2c Guo Ren 2018-09-05  156  	".align   2                   \n"		\
>> e58a41c2226847f Guo Ren 2021-04-21  157  	".long    1b, 3b              \n"		\
>> e58a41c2226847f Guo Ren 2021-04-21  158  	".long    2b, 3b              \n"		\
>> da551281947cb2c Guo Ren 2018-09-05  159  	".previous                    \n"		\
>> e58a41c2226847f Guo Ren 2021-04-21  160  	"4:                           \n"		\
>> e58a41c2226847f Guo Ren 2021-04-21  161  	: "=r"(err), "=r"(x), "=r"(ptr),		\
>> e58a41c2226847f Guo Ren 2021-04-21  162  	  "=r"(tmp), "=r"(errcode)			\
>> e58a41c2226847f Guo Ren 2021-04-21  163  	: "0"(err), "1"(x), "2"(ptr), "3"(0),		\
>> e58a41c2226847f Guo Ren 2021-04-21  164  	  "4"(-EFAULT)					\
>> da551281947cb2c Guo Ren 2018-09-05  165  	: "memory");					\
>> da551281947cb2c Guo Ren 2018-09-05  166  } while (0)
>> da551281947cb2c Guo Ren 2018-09-05  167  
> 
> The intel test report reported the above compile warning on this series:
> 
> https://lore.kernel.org/netdev/20250627084609-mutt-send-email-mst@kernel.org/T/#md788de2b3a4e9da23ac93b5f1c773a6070b5b4fb
> 
> specifically, in patch 4:
> 
> +                       if (get_user(features, featurep + 1 + i))
> +                               return -EFAULT;
> 
> AFAICS such statement is legit, and the bot points to some problem in
> the arch specific get_user() implementation. Could you please have a look?

Out of sheer ignorance on my side, I fail to see how the csky get_user()
could work correctly without something alike the following (which indeed
fixes the issue here).

/P
---
diff --git a/arch/csky/include/asm/uaccess.h
b/arch/csky/include/asm/uaccess.h
index 2e927c21d8a1..ae0864ad59a3 100644
--- a/arch/csky/include/asm/uaccess.h
+++ b/arch/csky/include/asm/uaccess.h
@@ -167,7 +167,7 @@ do {							\

 static inline int __get_user_fn(size_t size, const void __user *ptr,
void *x)
 {
-	int retval;
+	int retval = 0;
 	u32 tmp;

 	switch (size) {


