Return-Path: <netdev+bounces-195296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 562CDACF4B7
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089007A5815
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7722C27510A;
	Thu,  5 Jun 2025 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G5TQU6+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF432620E8
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142233; cv=none; b=acYaXCC5r2b5AvDVyGiI+5uhlaW9KFbxxuUfkGweVxkoetw71hSzasWwF2k8V2wTp6wTqBEjg1BWlXGDt516GwEn1sExNVzLtqv+8sRxisHbqz4of6YR1VLkqauLuWISiifMsY2XqjCeyJify8FGCSKy2mPEzGd/If6GtfRB6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142233; c=relaxed/simple;
	bh=ZHCAmfHlX4KQFHaG55ogITAmWjpCAZ9v2RgfvCQDhOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lul4F8s3sWI/x0GkQheF08oQP+cFg79LaV7oqv49Eche/H38QTUJsr1U3BMQUyHJ5O86O43ZJgZriEkHiOwWxdAZ1EOiB/b83HlqeUOjn+7OYmOvt7raxexC1HwMYLhOBn62PEoXMVaMxbwP1ZiKgCFDOIhsIb1dSkgvosTL1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G5TQU6+Y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0ac853894so1135171f8f.3
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749142229; x=1749747029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jz9xUyA/EiH5AU4vuSWkBdaNT/IXuogFlw5tRX78z5A=;
        b=G5TQU6+YeHyOtWB4O/1sTjRNIW654AyUZq4loPCuE0lKAgJ2OWs5s1TOfHA7Qil8u1
         PDOIxRvXPJLiaarxgf5lk7PCV8UthsFWq86M+xLPunjpN+QCJj+coHs1G20rDQXguH7k
         3Cpzj2KdlKJybWl6xx/WQmmouvexIMX3FebzQeR9CvERIVr1y8wm9kADTR5qUwPFFtlG
         AdrXq4kR0tsFm1cLYY/K3DT0Osw+PNxuBy909MjQzRjv17grsXyS64O9ur8eaLlrM56o
         wdTX6kiVujrYoBmaV4yhMNL/mTZ3JTxJA2m5Ao60vkPndThXrcUQkwCVlvxaHXmD8YFT
         BPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142229; x=1749747029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jz9xUyA/EiH5AU4vuSWkBdaNT/IXuogFlw5tRX78z5A=;
        b=vGhzPMoe7d/lczxcCxY/1USE3gAT03P+FUpVDQiwzvDqh6EBPVOyUZBAfws6xDNw0X
         imdYaUt8mxmm3jp6YuWzGYCpOVvFDj1yDq6WvSKu/JlYxPctPR82vGv2wjhWFu/7yPD3
         zPKjEezN4jsyU4xWWYJ7PEMDrYNJiMZnwyWFYsf+FINeuZeuVE61VfkfciBHzQbg3Mg6
         z0ID/F2BySQBivijhqOZfkjIhmWe+It3TnAah3Kpew6xTpI3O7GfFnyUAWn0JrrnzKmx
         AAbRbJ4pOVVvcgcP0OUCcewxlzK5wjzBCslTzJrYk8yjZWtK428dv3U39Iy8Y6M4n+C3
         oqyg==
X-Forwarded-Encrypted: i=1; AJvYcCX1sWJGIND0IcpcazV8FNIFRj009l33OGGqDghRYAcByk6U84JR15ApdWFHWJN5LDmCDSTh3O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMnSmiye3aXU63jUzrUEM47bBi3FTjPNzwYWzNR6axFQskjQ2n
	H3KXF1f5XpqSLmYhunv+uU06FEOP4rlCZewupR9FoDPkqGEMw5lo+YTzR9mCCKK2kws=
X-Gm-Gg: ASbGncsJUUX8Ofpt0WJo56QDqDSF3uyeToNhStiolyZUKjM6KYJJVCgfg0np9EMngQO
	A83LsfmfCNpTa6WPA/4qF8JFcIjDqx7bICu8T7uEua9guZNBtJeO/eMqJ2xfIxPSrjuStVe2Ogf
	+ZR4fKg9ip/QGbz7+KkC8vz/bx9Vhk0u9r3r3/MIl/WcT493ySg5KJyp4KoQi920Bu/DSqxYeMR
	Y3Rx80GcyaSoVuKkcjZWAAkYl8oqGz/sQzANmkgZpCljfRhZOfrp17qt2g+QwW5ogUviGK0uTtI
	TU2Xqilm9lCBvMQNXe8cXOS2D1XAHq5qsD9PZM9wtQQ3rGgro2EjziDrGsiq/ZE6A+njiw==
X-Google-Smtp-Source: AGHT+IGRSHzXfap9n0kjJuSMfLR19jyrXtVbAavtSq9J0Rzklw4pAacRpF/BuRTIrpXiqvpyofge9w==
X-Received: by 2002:a05:6000:2283:b0:3a4:fa6a:9174 with SMTP id ffacd0b85a97d-3a51d9708d4mr7314965f8f.33.1749142229184;
        Thu, 05 Jun 2025 09:50:29 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-248.rct.o2.cz. [109.81.1.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a0a96sm25345955f8f.96.2025.06.05.09.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 09:50:28 -0700 (PDT)
Message-ID: <6a770057-2076-4523-9c98-5ff10ac3562f@suse.com>
Date: Thu, 5 Jun 2025 18:50:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: Make sure relocations are applied to the
 per-CPU section
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
References: <202506041623.e45e4f7d-lkp@intel.com>
 <20250604152707.CieD9tN0@linutronix.de>
 <20250605060738.SzA3UESe@linutronix.de>
 <beb343ec-6349-4f9c-9fea-588b04eb49ee@suse.com>
 <20250605155405.3BiTtQej@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250605155405.3BiTtQej@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/5/25 5:54 PM, Sebastian Andrzej Siewior wrote:
> On 2025-06-05 15:44:23 [+0200], Petr Pavlu wrote:
>> Isn't this broken earlier by "Don't relocate non-allocated regions in modules."
>> (pre-Git, [1])?
> 
> Looking further back into the history, we have
> 	21af2f0289dea ("[PATCH] per-cpu support inside modules (minimal)")
> 
> which does
> 
> +       if (pcpuindex) {
> +               /* We have a special allocation for this section. */
> +               mod->percpu = percpu_modalloc(sechdrs[pcpuindex].sh_size,
> +                                             sechdrs[pcpuindex].sh_addralign);
> +               if (!mod->percpu) {
> +                       err = -ENOMEM;
> +                       goto free_mod;
> +               }
> +               sechdrs[pcpuindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
> +       }
> 
> so this looks like the origin.

This patch added the initial per-cpu support for modules. The relocation
handling at that point appears correct to me. I think it's the mentioned patch
"Don't relocate non-allocated regions in modules" that broke it.

> 
> …
>>> --- a/kernel/module/main.c
>>> +++ b/kernel/module/main.c
>>> @@ -2816,6 +2816,10 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>>>  	if (err)
>>>  		return ERR_PTR(err);
>>>  
>>> +	/* Add SHF_ALLOC back so that relocations are applied. */
>>> +	if (IS_ENABLED(CONFIG_SMP) && info->index.pcpu)
>>> +		info->sechdrs[info->index.pcpu].sh_flags |= SHF_ALLOC;
>>> +
>>>  	/* Module has been copied to its final place now: return it. */
>>>  	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
>>>  	kmemleak_load_module(mod, info);
>>
>> This looks like a valid fix. The info->sechdrs[info->index.pcpu].sh_addr
>> is set by rewrite_section_headers() to point to the percpu data in the
>> userspace-passed ELF copy. The section has SHF_ALLOC reset, so it
>> doesn't move and the sh_addr isn't adjusted by move_module(). The
>> function apply_relocations() then applies the relocations in the initial
>> ELF copy. Finally, post_relocation() copies the relocated percpu data to
>> their final per-CPU destinations.
>>
>> However, I'm not sure if it is best to manipulate the SHF_ALLOC flag in
>> this way. It is ok to reset it once, but if we need to set it back again
>> then I would reconsider this.
> 
> I had the other way around but this flag is not considered anywhere
> else other than the functions called here. So I decided to add back what
> was taken once.
> 
>> An alternative approach could be to teach apply_relocations() that the
>> percpu section is special and should be relocated even though it doesn't
>> have SHF_ALLOC set. This would also allow adding a comment explaining
>> that we're relocating the data in the original ELF copy, which I find
>> useful to mention as it is different to other relocation processing.
> 
> Not sure if this makes it better. It looks like it continues a
> workaround…
> The only reason why it has been removed in the first place is to skip
> the copy process.

The SHF_ALLOC flag is also removed to prevent the section from being allocated
by layout_sections().

> We could also keep the flag and skip the section during the copy
> process based on its id. This was the original intention.
> 
>> For instance:
>>
>> 	/*
>> 	 * Don't bother with non-allocated sections.
>> 	 *
>> 	 * An exception is the percpu section, which has separate allocations
>> 	 * for individual CPUs. We relocate the percpu section in the initial
>> 	 * ELF template and subsequently copy it to the per-CPU destinations.
>> 	 */
>> 	if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
>> 	    infosec != info->index.pcpu)
>> 		continue;
>>
> 
> If you insist but…

It seems logical to me that the SHF_ALLOC flag is removed for the percpu section
since it isn't directly allocated by the regular process. This is consistent
with what the module loader does in other similar cases. I could also understand
keeping the flag and explicitly skipping the layout and allocate process for the
section. However, adjusting the flag back and forth to trigger the right code
paths in between seems fragile to me and harder to maintain if we need to
shuffle things around in the future.

-- 
Cheers,
Petr

