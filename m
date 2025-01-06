Return-Path: <netdev+bounces-155582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B35C1A03135
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E01518862B0
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9AC1AA783;
	Mon,  6 Jan 2025 20:15:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s802.sureserver.com (s802.sureserver.com [195.8.222.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A82C1DF748
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.8.222.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736194545; cv=none; b=oW5KxpUEW49pdKi3JpS+f1U425+qg6n67Y7PPgVqPWKVq0LItsy5G3Qiy67K41loMOl71D4uxHP4MCS2/zHct+f7LQYrTEM996WIa2aZBkLvyIg5IEsOPrXeEOrGvtCIYj2bidXMqQ7BUgsDtlF7MBWKLHO+wlVNDIIFQ6DOfOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736194545; c=relaxed/simple;
	bh=jvyWbLmgbyMX7a55tEJ5Wnm1hkta+JS/M9QxsKWwRmE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Zf7QNfRJn44o8v4GiaMN2X8/i2uis2+p8TLOCKz2vLYO9vGyXUc7sFtna2TkbmMYOJ2vA4bHcJLSmZ1gHsW3YLYa8KuEsSuEUUs3Pa/cw4SujUPPDWshJi6kF55Lp6qdfnKxxyLdwnz4BjoS9ZecfNCcbKa/tjYOdl8IdtpYVq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=icdsoft.com; spf=fail smtp.mailfrom=icdsoft.com; arc=none smtp.client-ip=195.8.222.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=icdsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=icdsoft.com
Received: (qmail 6838 invoked by uid 1003); 6 Jan 2025 20:15:38 -0000
Received: from unknown (HELO ?94.155.37.179?) (zimage@dni.li@94.155.37.179)
  by s802.sureserver.com with ESMTPA; 6 Jan 2025 20:15:38 -0000
Message-ID: <d1f083ee-9ad2-422c-9278-c50a9fbd8be4@icdsoft.com>
Date: Mon, 6 Jan 2025 22:15:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Teodor Milkov <zimage@icdsoft.com>
Subject: Re: Download throttling with kernel 6.6 (in KVM guests)
To: netdev@vger.kernel.org
References: <e831515a-3756-40f6-a254-0f075e19996f@icdsoft.com>
Content-Language: en-US
In-Reply-To: <e831515a-3756-40f6-a254-0f075e19996f@icdsoft.com>
Organization: ICDSoft Ltd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Following up on my previous email, I’ve found the issue occurs 
specifically with the |virtio-net| driver in KVM guests. Switching to 
the |e1000| driver resolves the slowdown entirely, with no throttling in 
subsequent downloads.

The reproducer and observations remain the same, but this detail might 
help narrow down the issue.

Best regards!


On 12/29/24 14:31, Teodor Milkov wrote:
> Hello,
>
> We've encountered a regression affecting downloads in KVM guests after 
> upgrading to Linux kernel 6.6. The issue is not present in kernel 5.15 
> or the stock Debian 6.6 kernel on hosts (not guests) but manifests 
> consistently in kernels 6.6 and later, including 6.6.58 and even 6.13-rc.
>
> Steps to Reproduce:
> 1. Perform multiple sequential downloads, perhaps on a link with 
> higher BDP (USA -> EU 120ms in our case).
> 2. Look at download speeds in scenarios with varying sleep intervals 
> between the downloads.
>
> Observations:
> - Kernel 5.15: Reaches maximum throughput (~23 MB/s) consistently.
> - Kernel 6.6:
>   - The first download achieves maximum throughput (~23 MB/s).
>   - Subsequent downloads are throttled to ~16 MB/s unless a sleep 
> interval ≥ 0.3 seconds is introduced between them.
>
> Reproducer Script:
> for _ in 1 2; do  curl http://example.com/1000MB.bin --max-time 8 -o 
> /dev/null -w '(%{speed_download} B/s)\n'; sleep 0.1   ;done
>
>
> Tried various sysctl settings, changing qdiscs, tcp congestion algo 
> (e.g. from bbr to cubic), but the problem persists.
>
> git bisect traced the regression to commit dfa2f0483360 ("tcp: get rid 
> of sysctl_tcp_adv_win_scale"). While a similar issue described by 
> Netflix in 
> https://netflixtechblog.com/investigation-of-a-cross-regional-network-performance-issue-422d6218fdf1 
> and was supposedly fixed in kernels 6.6.33 and 6.10, the problem 
> remains in 6.6.58 and even 6.13-rc for our case.
>
> Could this behavior be a side effect of `tcp_adv_win_scale` removal, 
> or is it indicative of something else?
>
> We would appreciate any insights or guidance how to further 
> investigate this regression.
>
> Best regards!
>
-- 
Teodor Milkov | https://icdsoft.com
Head of Linux Engineering & Operations

