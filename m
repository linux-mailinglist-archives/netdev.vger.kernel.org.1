Return-Path: <netdev+bounces-195253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B307ACF128
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018053AA819
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86225E816;
	Thu,  5 Jun 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kr9Id81S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBFE25DCFF
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131069; cv=none; b=sssYqpDLx5ZLpdrRBj76+G0eZo6BD/LKtzuYz464tq1AspT67y0qLEOc64JdXEAyh8ASppuf95hNyRQRqqoL7BzjRwWNROt+np3grGzc2KE4GB2ck08QVf0ccZrPOUMo4nooF9YjanDxUDqsx59Wy/szP46ThPhowfKWPfgXB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131069; c=relaxed/simple;
	bh=rCO97t5tY3E5x9tBF5MM51T7nX5k5kOJxQqu9YByUYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+BnKUcxPWWQ5JU1UuZu59I1HW0TdhdRSFtexG35SdOoWZS5yt8/1n5YVQhvfwDdjyC77pIMw+IyzcW7Yg3y0GNCs7VR5DjxIVfoLjN8dewy9snO1MKrE3M7wmFnjhUh+04tchUguZgAwxFafF5NvRmauwmGvavY/qiRkvPJu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kr9Id81S; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3a528243636so566603f8f.3
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 06:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749131065; x=1749735865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQdIuSTATuzb/lH9GWsSgTLyKRDQtpfdIWX4HXG5tVQ=;
        b=Kr9Id81Sb1GR3sMZ3YtsKIYQhLqsGiDv5tZqVbu/cb74ByVLmEwaOyjMeG2DM95QaA
         XK1IjD4wa5jCqTLwqEFuEJfceyBX56DM34xzwhUAx9m9O+cqQb0R1aDeKQInzXWHbA3a
         dGVpq7tmG/nXAshI9IBQrcp5+b8WlF43evlFmWdxV97Y/k9Io20JaF3VT6GCTJi/Mcv+
         AbMsQLaa8tajF+n80XD7UV/bLO/oc6LQhwtGcT+PkPzcNcPxh7ijhco6mBSbO24MWsfF
         djkPdjMkU5jtuJyttk7z7aufJ2XrtuGW61D9ToOIf2Le7bM5MlNGP+QVLPVyPx+m1Gmw
         Pguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749131065; x=1749735865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQdIuSTATuzb/lH9GWsSgTLyKRDQtpfdIWX4HXG5tVQ=;
        b=PcCwaeJVXUGHjoXNjkeTPvkHGxzZLydxJnqosWfyvZPvlwY2nREs9XSBoYVTTbxFEf
         yAyQvmjPG0T1QHdiWD+BpekNagud7DETFs1Tu38IrCuFUqqS1ejNrhLqTYf30OOl+gmF
         0CmOqZV//l2jluu62w6mXbudunuBO7eRvaNsPgMaKUSAqiS/thCTFu5M8kvu8iXIB2WL
         JvpKq8mTX47nqm80XquOGVcBzMdljeRIeXVN+pSeXetxVBucf5SMNjJgto8f4NraYt9e
         f6RS+Ul7GZXuRyONfxX2vRttOC2SOvyiBzK70frBRAfQpq/DXTvoMJzWWKkupGC+c0ZL
         kL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhb2rI9qpMXiScuG0y/gtihPaRe0vrWwJ/ELGBh8JwAXY2ATcAn4tZaocPb71VX7hVn8L7Dg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLuUgysaR2fKPtcP3mQF92cq+Kbcdj7uCUn1nQ0WOxKL9Om8g
	/C0ywGH9Ze2Dajf8XsGNSkaEUTDwJn8mU4lATx+R/prhs4i5jbBnpqRnVABa4vrLBto=
X-Gm-Gg: ASbGncsrQ1jHvU/3yr9F1EPDp/SQDIXyPVIb5jsN7pd1pnktUhSUMt2K8yUhz1llr5Q
	Oixhf3I1/M6VeiN+c9k8lSdCx3LVWIFWuP8FWvXF0uoQ3fszEQI0ObrpP+ItoP5/uGmUTDDlo6A
	z4eDlfBmM0271NUcrCsrm9Uk6PoC6KDcKkZhtK6V6uCvULvczkH5HM19uBmkKROrCtOVFLYRM1D
	YHaTUAzbjj/E5oidsiuoLvW1qXAdyuW7L1A4coHjbf/SX7awcMmMpumR+GGVNdHYqUIUHdmR3td
	v2AfVp+EYH0iM9TysR6Og4dZ0gAJ8AnClsNUNXgYePwbPFWFV9XuXjKIoQuTdxxtref5570gXcJ
	56/cN
X-Google-Smtp-Source: AGHT+IEZBXkNJsZax09ksMSFFsYVIlL2lvRHaY0jmuIMadt7kKvrCMXnThYERvTqZ4mq0dgdqgi/bQ==
X-Received: by 2002:a05:6000:25ca:b0:3a5:1c71:432a with SMTP id ffacd0b85a97d-3a51d91c1f0mr5935337f8f.14.1749131064750;
        Thu, 05 Jun 2025 06:44:24 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-248.rct.o2.cz. [109.81.1.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6ca46sm25077312f8f.31.2025.06.05.06.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 06:44:24 -0700 (PDT)
Message-ID: <beb343ec-6349-4f9c-9fea-588b04eb49ee@suse.com>
Date: Thu, 5 Jun 2025 15:44:23 +0200
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
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250605060738.SzA3UESe@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/5/25 8:07 AM, Sebastian Andrzej Siewior wrote:
> The per-CPU data section is handled differently than the other sections.
> The memory allocations requires a special __percpu pointer and then the
> section is copied into the view of each CPU. Therefore the SHF_ALLOC
> flag is removed to ensure move_module() skips it.
> 
> Later, relocations are applied and apply_relocations() skips sections
> without SHF_ALLOC because they have not been copied. This also skips the
> per-CPU data section.
> The missing relocations result in a NULL pointer on x86-64 and very
> small values on x86-32. This results in a crash because it is not
> skipped like NULL pointer would and can't be dereferenced.
> 
> Such an assignment happens during static per-CPU lock initialisation
> with lockdep enabled.
> 
> Add the SHF_ALLOC flag back for the per-CPU section (if found) after
> move_module().
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202506041623.e45e4f7d-lkp@intel.com
> Fixes: 8d8022e8aba85 ("module: do percpu allocation after uniqueness check.  No, really!")

Isn't this broken earlier by "Don't relocate non-allocated regions in modules."
(pre-Git, [1])?

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2: https://lore.kernel.org/all/20250604152707.CieD9tN0@linutronix.de/
>   - Add the flag back only on SMP if the per-CPU section was found.
> 
>  kernel/module/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 5c6ab20240a6d..4f6554dedf8ea 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2816,6 +2816,10 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>  	if (err)
>  		return ERR_PTR(err);
>  
> +	/* Add SHF_ALLOC back so that relocations are applied. */
> +	if (IS_ENABLED(CONFIG_SMP) && info->index.pcpu)
> +		info->sechdrs[info->index.pcpu].sh_flags |= SHF_ALLOC;
> +
>  	/* Module has been copied to its final place now: return it. */
>  	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
>  	kmemleak_load_module(mod, info);

This looks like a valid fix. The info->sechdrs[info->index.pcpu].sh_addr
is set by rewrite_section_headers() to point to the percpu data in the
userspace-passed ELF copy. The section has SHF_ALLOC reset, so it
doesn't move and the sh_addr isn't adjusted by move_module(). The
function apply_relocations() then applies the relocations in the initial
ELF copy. Finally, post_relocation() copies the relocated percpu data to
their final per-CPU destinations.

However, I'm not sure if it is best to manipulate the SHF_ALLOC flag in
this way. It is ok to reset it once, but if we need to set it back again
then I would reconsider this.

An alternative approach could be to teach apply_relocations() that the
percpu section is special and should be relocated even though it doesn't
have SHF_ALLOC set. This would also allow adding a comment explaining
that we're relocating the data in the original ELF copy, which I find
useful to mention as it is different to other relocation processing.

For instance:

	/*
	 * Don't bother with non-allocated sections.
	 *
	 * An exception is the percpu section, which has separate allocations
	 * for individual CPUs. We relocate the percpu section in the initial
	 * ELF template and subsequently copy it to the per-CPU destinations.
	 */
	if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
	    infosec != info->index.pcpu)
		continue;

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/commit/?id=b3b91325f3c77ace041f769ada7039ebc7aab8de

-- 
Thanks,
Petr

