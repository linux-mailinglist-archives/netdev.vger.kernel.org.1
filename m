Return-Path: <netdev+bounces-188893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E16ADAAF32D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 07:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1921C058E3
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 05:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF42E2153C7;
	Thu,  8 May 2025 05:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fOxb1Rzs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD68C1E
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746683548; cv=none; b=cG8VSpqJ6jFi6MsNJd7lUYh6RU0CEyn62T33/nTpH35dAgIFKIjCu0v3RwIgRvRWpCKW5WEvdFI90RZUBAd2+CfoQP7bLxrnDZxKy96dSumMglzFOpGgHKpVLs1LvAsdGcZXzlqzikhsOg05gI7MCxMrRojdh3u4NNWpQioWPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746683548; c=relaxed/simple;
	bh=Bdr0Y12g3c39kjcWKCc2YzMJ3H9Q6kgUJpj4VDFpyrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1Ml+Tkj/I2NM1VAMP6K/yy8aYeaI7ZuLv9ilAWPU4zYNvvbRao6MqVXNnSgfry6COsESqA6+6CO97eZoyYPOZoBnMB0ija7W81lTInnhjq0qvDppX3WZhb1z/p7aVv6sFAcrz2F7iVtAUQ2nDqVxardWnpeQkVNE4ejYiUdk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fOxb1Rzs; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7369ce5d323so589795b3a.1
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 22:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1746683546; x=1747288346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i96evhJ3L1i9OAU+AfaaUL87qGEjMeohLnza5fm08Wg=;
        b=fOxb1Rzsxp+u1f29STC6FGnaeVCbF8GWYstGl6Kr2bvDwP8Tb6T36udDZulkmXbSex
         DciRl0l2Qf1OgDdaFw7oBfMio7J+Eik++dMzzXWfJzPRoPo/7nySTN+OnZRVz29RUJR1
         7pfCzBxRJ+IFRe/fhCrxuZOhetlZJSws2MBcSujN+hxptJOWdtPJCb73FSqus7rKHEZ5
         OojjNOXZKwd+ymdNosQfjTOX4OTx5LzY1rgovcdPATQ1t9kkToxrn7/Mxv+WSC3tJD6X
         II4EcPCc9HiC9CCqKAy6/p6XDa2w8X7KtyyYUSCP21LMQtzoiZe5f/AZf3YPQZ9RVCmp
         D7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746683546; x=1747288346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i96evhJ3L1i9OAU+AfaaUL87qGEjMeohLnza5fm08Wg=;
        b=Yd4oF6nqk1EemugT+LlORbP7ttFq6wCn0DWYAuCxdIjhyiyzJ947nU3YzV53BBLoKA
         OY8crqqDyFOpDoLzTAJUiIee433l8YTOA+GN/qtgoscSY3kb/Q9kY98CN4CrkhSe693w
         6fCi+Di/MHkveAKxCgVOk/Ex8kyptvmw+03WD/Em8oYQ0BpXyfSJp9VWgPazl+5pKdn7
         z+rAv9iN/Niq/ACaK5UxD0WFEPi1EU7jgT12w6CvQmzF66BJHCDNiuRFEd3kKrGT3jOi
         tZwvkVda6SWc/jOUbq15ySSq+jZ033TVy0js9zgWw7m3XkcRabsKm9/7soJS5ZOyrrLC
         rs/w==
X-Forwarded-Encrypted: i=1; AJvYcCVMHAvCG0Z3z3Py1zkQ5oYaQoPrunoRwJGUq5IyVIICX+t8mG8KAhFDPJvAStfa0j4cMJZqOTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+jPs23WRR5S+fhVwy/0zzY7hvq0TpXCgtr/2rF055B3B8ES9i
	ShXGAExeQY3XIb7CfimpgMIHATmeqjZskocADwAIcXf+PzUOxzKQ7Tc4eRnD4Hg=
X-Gm-Gg: ASbGncvyr7mj9HjTpEon55UfNTOmcbv3YsEjW0KE3Tii1wlJnW/u2PyTmQfIyCQvg7G
	189Xpg/oFCZtmdK4zQGacwBVeFmXP3KmFlcqx6x6kGjo9Bsmk2u5nsQ1ylwlvu+f95C8CoEdwWD
	IveMofG9Ij2oQgcnwGbjptwHK5lgY4QQg1AFEAo1yfDAOwcNOCwvT/iD75lr3CUntMqIl4xIvWF
	il5f9yZYEHVQnmo6K7eYAA6Rl8jMCkBVJtFgydJy+951a1XEdHRytUuFdVyeHwn4sJkJ+2xg4Ob
	Oz2tBGRERJL8S2x5zRNLMfLHO/BtMXt91JFO0KriJqchM9wsHg==
X-Google-Smtp-Source: AGHT+IGmwK30GKDHe76KfJPNmh+RRFgtlk9wRBYzR5kfcfKZL7Pabnt4BlHQN5A4h5RiewR3yM1+wQ==
X-Received: by 2002:a05:6a00:428a:b0:740:6f69:f52a with SMTP id d2e1a72fcca58-740a98634bbmr3130848b3a.0.1746683546092;
        Wed, 07 May 2025 22:52:26 -0700 (PDT)
Received: from [127.0.0.1] ([104.28.205.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dbbb15sm12759071b3a.58.2025.05.07.22.52.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 May 2025 22:52:25 -0700 (PDT)
Message-ID: <cf46f385-0e85-4b71-baad-3b88b1d49376@cloudflare.com>
Date: Wed, 7 May 2025 22:51:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 0/3] Fix XDP loading on machines with many CPUs
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
 aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
 dawid.osuchowski@linux.intel.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, kernel-team@cloudflare.com
References: <20250422153659.284868-1-michal.kubiak@intel.com>
 <b36a7cb6-582b-422d-82ce-98dc8985fd0d@cloudflare.com>
 <aBsTO4_LZoNniFS5@localhost.localdomain>
Content-Language: en-US
From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
In-Reply-To: <aBsTO4_LZoNniFS5@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/25 1:00 AM, Michal Kubiak wrote:
> On Tue, May 06, 2025 at 10:31:59PM -0700, Jesse Brandeburg wrote:
>> On 4/22/25 8:36 AM, Michal Kubiak wrote:
>>> Hi,
>>>
>>> Some of our customers have reported a crash problem when trying to load
>>> the XDP program on machines with a large number of CPU cores. After
>>> extensive debugging, it became clear that the root cause of the problem
>>> lies in the Tx scheduler implementation, which does not seem to be able
>>> to handle the creation of a large number of Tx queues (even though this
>>> number does not exceed the number of available queues reported by the
>>> FW).
>>> This series addresses this problem.
>>
>> Hi Michal,
>>
>> Unfortunately this version of the series seems to reintroduce the original
>> problem error: -22.
> Hi Jesse,
>
> Thanks for testing and reporting!
>
> I will take a look at the problem and try to reproduce it locally. I would also
> have a few questions inline.
>
> First, was your original problem not the failure with error: -5? Or did you have
> both (-5 and -22), depending on the scenario/environment?
> I am asking because it seems that these two errors occurred at different
> initialization stages of the tx scheduler. Of course, the series
> was intended to address both of these issues.


We had a few issues to work through, I believe the original problem we 
had was -22 (just confirmed) with more than 320 CPUs.

>> I double checked the patches, they looked like they were applied in our test
>> version 2025.5.8 build which contained a 6.12.26 kernel with this series
>> applied (all 3)
>>
>> Our setup is saying max 252 combined queues, but running 384 CPUs by
>> default, loads an XDP program, then reduces the number of queues using
>> ethtool, to 192. After that we get the error -22 and link is down.
>>
> To be honest, I did not test the scenario in which the number of queues is
> reduced while the XDP program is running. This is the first thing I will check.

Cool, I hope it will help your repro, but see below.

> Can you please confirm that you did that step on both the current
> and the draft version of the series?
> It would also be interesting to check what happens if the queue number is reduced
> before loading the XDP program.

We noticed we had a difference in the testing of draft and current. We 
have a patch against the kernel that was helping us work around this 
issue, which looked like this:


diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c 
b/drivers/net/ethernet/intel/ice/ice_irq.c
index ad82ff7d1995..622d409efbce 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -126,6 +126,10 @@ static void ice_reduce_msix_usage(struct ice_pf 
*pf, int v_remain)
      }
  }

+static int num_msix = -1;
+module_param(num_msix, int, 0644);
+MODULE_PARM_DESC(num_msix, "Default limit of MSI-X vectors for LAN");
+
  /**
   * ice_ena_msix_range - Request a range of MSIX vectors from the OS
   * @pf: board private structure
@@ -156,7 +160,16 @@ static int ice_ena_msix_range(struct ice_pf *pf)
      v_wanted = v_other;

      /* LAN traffic */
-    pf->num_lan_msix = num_cpus;
+    /* Cloudflare: allocate the msix vector count based on module param
+     * num_msix. Alternately, default to half the number of CPUs or 128,
+     * whichever is smallest, and should the number of CPUs be 2, 1, or
+     * 0, then default to 2 vectors
+     */
+    if (num_msix != -1)
+        pf->num_lan_msix = num_msix;
+    else
+        pf->num_lan_msix = min_t(u16, (num_cpus / 2) ?: 2, 128);
+
      v_wanted += pf->num_lan_msix;

      /* RDMA auxiliary driver */


The module parameter helped us limit the number of vectors, which 
allowed our machines to finish booting before your new patches were 
available.

The failure of the new patch was when this value was set to 252, and the 
"draft" patch also fails in this configuration (this is new info from today)


>> The original version you had sent us was working fine when we tested it, so
>> the problem seems to be between those two versions. I suppose it could be
So the problem is also related to the inital number of queues the driver 
starts with. When we
>> possible (but unlikely because I used git to apply the patches) that there
>> was something wrong with the source code, but I sincerely doubt it as the
>> patches had applied cleanly.
The reason it worked fine was we tested "draft" (and now the new patches 
too) with the module parameter set to 384 queues (with 384 CPUs), or 
letting it default to 128 queues, both worked with the new and old 
series. 252 seems to be some magic failure causing number with both 
patches, we don't know why.


Thanks for your patience while we worked through the testing differences 
here today. Hope this helps and let me know if you have more questions.


Jesse


