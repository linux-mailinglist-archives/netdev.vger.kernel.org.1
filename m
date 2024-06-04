Return-Path: <netdev+bounces-100785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A188FBFE1
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 01:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0455284508
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 23:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C43144D3F;
	Tue,  4 Jun 2024 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Ag55BX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90341A5F
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544092; cv=none; b=pn/qUUp412dqyQGUhKE/eKQlE797boTp1eF5H1Aufq9pJhwufnDippGI2jpUMX8CxbAABJiB5erSJgg6pKYgFHxcuICY3mvGl0+Fydqn7/5kwRbmMv8NDAH6Xp28m4Gf7NAnJR1Y/ce3BS7oXHDwaiCEPrs/EQ/CnQHunJfmIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544092; c=relaxed/simple;
	bh=mYvRFBaZUWhUwNAhauXsWdudggSwXJOIWo5iZdCve5g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pUQbs7mIx2xY0Lqv75BDZTj3VkTF2FTuZc6XjThTqsmMSFsFQoyaWrGP61zx0F8D6BJEImQYxiTY1Poa96MnsUZn8kW+udF2tdP434rrGe+YUph9iRF5ct+CqyJwhSZ3cnKkf97CnQ1rf/hUF9VLdIDlBCLKiWPw2qtKm5ROh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Ag55BX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6da49fa2407so20188a12.1
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 16:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717544091; x=1718148891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ukGFGjc2TtcZiNrYPfXwl5+69j7Ba+GYMgvRbMlUtvM=;
        b=g2Ag55BX1oCbjQwGjbctak2z/HIJyN8zg74CXQV4di9/Fy+a2AeT7S3exA55DVJQTU
         kAf2SJGQaAoQTvVnvKfSuG6ddCl4RURBq8uO/bxcHSxVluaaPca/FtrdIOXW/QF1IX43
         dNsLH/4q3fAQeUcsVp/lZ8mNe5aXsPt8pNfgLzn/CRkBiFfDBf/HxOkgk609GRUtJQKN
         ZgmtKeVTAHj7uvfx0aANlGAfXFQ/eBO8Vj3NROCn7PNQ6VMyi1KolnfJf/lIhpHfUwDP
         ueQjGqdDzVrseNVoKauNDrOY2XC/Gkt4cEMu2vAR1qDsjHf7t5rTVyIi5Hj/WJQpb7MH
         bs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544091; x=1718148891;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukGFGjc2TtcZiNrYPfXwl5+69j7Ba+GYMgvRbMlUtvM=;
        b=hS4GwsVITeJLbg6s4ozHqujy2AknZhUAlMJKb7q/NdDgx64T+j7ZGLv3sWAJQkKMVj
         +QBoyGe9CMxm5wp3vEL6qAyHrSPHwEKEdLNrfsMU1IbZHaPxk+tFBZh9uVnGAe1x+k8K
         5qYnXkt/60T+TWSZ1hoN0H27bzO7L63OAVgF2acVYB/Eh3vB8Yo30VdqIjLgyE9Z3Rm3
         3i48Bd/lyeBWO4daCcZPaS65Le4EW81omPAr2n5naiSI55bcx5hpwyU2oxfRF2vu4YuW
         Aw2VqhrRtb9CN1j/bZkoX6ulScgWmHcOuBgzEr84eFEvsCEqsQPo4RID1DhnBzRb53zF
         d6sQ==
X-Gm-Message-State: AOJu0YygMRAiCim02DztKFGOAdEH++NvOxqxiKUvLyMpnm0YkTWRtjC+
	D8WvgE4JXRKcqLAmzPOvoCw27/AXTol908Av1bAESmrIUothxd+s9Rg7XYy8mlNb4RBy
X-Google-Smtp-Source: AGHT+IGMATd0C32PFg/i8pLcoXx5/dE8v2BthZmox2+WPHqWxPD7Ygi9QmaZ+Uf4fBClbSDxQ6Gbeg==
X-Received: by 2002:a05:6a20:12d2:b0:1b0:2af5:f183 with SMTP id adf61e73a8af0-1b2b6fa218emr1242347637.23.1717544090532;
        Tue, 04 Jun 2024 16:34:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:2c0:5:abb:613c:28d6:873e? ([2620:15c:2c0:5:abb:613c:28d6:873e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806983dcsm98452a91.32.2024.06.04.16.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 16:34:50 -0700 (PDT)
Message-ID: <b30f34a1-48d6-4ff4-b375-d0eef5308261@gmail.com>
Date: Tue, 4 Jun 2024 16:34:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Decotigny <ddecotig@gmail.com>
Subject: Re: [PATCH iwl-net] idpf: extend tx watchdog timeout
To: Joshua Hay <joshua.a.hay@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Sridhar Samudrala <sridhar.samudrala@intel.com>
References: <20240603184714.3697911-1-joshua.a.hay@intel.com>
Content-Language: en-US
In-Reply-To: <20240603184714.3697911-1-joshua.a.hay@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/3/2024 11:47 AM, Joshua Hay wrote:
>
> There are several reasons for a TX completion to take longer than usual
> to be written back by HW. For example, the completion for a packet that
> misses a rule will have increased latency. The side effect of these
> variable latencies for any given packet is out of order completions. The
> stack sends packet X and Y. If packet X takes longer because of the rule
> miss in the example above, but packet Y hits, it can go on the wire
> immediately. Which also means it can be completed first.  The driver
> will then receive a completion for packet Y before packet X.  The driver
> will stash the buffers for packet X in a hash table to allow the tx send
> queue descriptors for both packet X and Y to be reused. The driver will
> receive the completion for packet X sometime later and have to search
> the hash table for the associated packet.
>
> The driver cleans packets directly on the ring first, i.e. not out of
> order completions since they are to some extent considered "slow(er)
> path". However, certain workloads can increase the frequency of out of
> order completions thus introducing even more latency into the cleaning
> path. Bump up the timeout value to account for these workloads.
>
> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_lib.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


We tested this patch with our intensive high-performance workloads that
have been able to reproduce the issue, and it was sufficient to avoid tx
timeouts. We also noticed that these longer timeouts are not unusual in
the smartnic space: we see 100s or 50s timeouts for a few NICs, and
other NICs receive this timeout as a hint from the fw.

Reviewed-by: David Decotigny <ddecotig@google.com>

