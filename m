Return-Path: <netdev+bounces-182378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD0A8898E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BBA3A63F4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F090289359;
	Mon, 14 Apr 2025 17:16:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D52820BB
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650990; cv=none; b=sm9tkmHegENZaFxELLpgDTOioStNKsO117j8iHJYfdOOyJJWBtHnoWt66QBCZLvdlAwfJXw/qGOSJtdrVl8R7zpBUHhnAd91FHLvf+2Bk4arJ8kW7MhkK7Qubz7qIQZm4LykwuzJnSl8NdqDpSXq2FjBEiCE96ndUzV2QhHd4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650990; c=relaxed/simple;
	bh=OJcs/XVthOpv6Q27QIk83Dxn+e3WU8k80K16H2ugiB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6jk5jsR9zHA2As17MVXUrTdTz63Sw8i/63enK1GCG1jEcoGr9fEYzD/IpiDs5yUaTx1N7JPPE3MsIS6FqWYbCh0RQY03rZQ9nRXG+GVkctDeumEtb5Uog8vtSF8LsC6vV0cJBfIR2+IQ2UOUW2tkfYskWQMLLABrHQnR+SGCo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.43] (g43.guest.molgen.mpg.de [141.14.220.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D72EF61E647A7;
	Mon, 14 Apr 2025 19:15:51 +0200 (CEST)
Message-ID: <559a9953-cd51-42ce-b2a5-83bd185cf008@molgen.mpg.de>
Date: Mon, 14 Apr 2025 19:15:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] Increased memory usage on NUMA nodes with ICE
 driver after upgrade to 6.13.y (regression in commit 492a044508ad)
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>
Cc: jdamato@fastly.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Igor Raits <igor@gooddata.com>,
 Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>, regressions@lists.linux.dev
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

#regzbot ^introduced: 492a044508ad13a490a24c66f311339bf891cb5f

Am 14.04.25 um 18:29 schrieb Jaroslav Pulchart:
> Hello,
> 
> While investigating increased memory usage after upgrading our
> host/hypervisor servers from Linux kernel 6.12.y to 6.13.y, I observed
> a regression in available memory per NUMA node. Our servers allocate
> 60GB of each NUMA node’s 64GB of RAM to HugePages for VMs, leaving 4GB
> for the host OS.
> 
> After the upgrade, we noticed approximately 500MB less free RAM on
> NUMA nodes 0 and 2 compared to 6.12.y, even with no VMs running (just
> the host OS after reboot). These nodes host Intel 810-XXV NICs. Here's
> a snapshot of the NUMA stats on vanilla 6.13.y:
> 
>       NUMA nodes:  0     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15
>       HPFreeGiB:   60    60    60    60    60    60    60    60    60    60   60    60    60    60    60    60
>       MemTotal:    64989 65470 65470 65470 65470 65470 65470 65453 65470 65470 65470 65470 65470 65470 65470 65462
>       MemFree:     2793  3559  3150  3438  3616  3722  3520  3547  3547  3536  3506  3452  3440  3489  3607  3729
> 
> We traced the issue to commit 492a044508ad13a490a24c66f311339bf891cb5f
> "ice: Add support for persistent NAPI config".
> 
> We limit the number of channels on the NICs to match local NUMA cores
> or less if unused interface (from ridiculous 96 default), for example:
>     ethtool -L em1 combined 6       # active port; from 96
>     ethtool -L p3p2 combined 2      # unused port; from 96
> 
> This typically aligns memory use with local CPUs and keeps NUMA-local
> memory usage within expected limits. However, starting with kernel
> 6.13.y and this commit, the high memory usage by the ICE driver
> persists regardless of reduced channel configuration.
> 
> Reverting the commit restores expected memory availability on nodes 0
> and 2. Below are stats from 6.13.y with the commit reverted:
>      NUMA nodes:  0     1     2     3     4     5     6     7     8     9    10    11    12    13    14    15
>      HPFreeGiB:   60    60    60    60    60    60    60    60    60    60   60    60    60    60    60    60
>      MemTotal:    64989 65470 65470 65470 65470 65470 65470 65453 65470 65470 65470 65470 65470 65470 65470 65462
>      MemFree:     3208  3765  3668  3507  3811  3727  3812  3546  3676  3596 ...
> 
> This brings nodes 0 and 2 back to ~3.5GB free RAM, similar to kernel
> 6.12.y, and avoids swap pressure and memory exhaustion when running
> services and VMs.
> 
> I also do not see any practical benefit in persisting the channel
> memory allocation. After a fresh server reboot, channels are not
> explicitly configured, and the system will not automatically resize
> them back to a higher count unless manually set again. Therefore,
> retaining the previous memory footprint appears unnecessary and
> potentially harmful in memory-constrained environments
> 
> Best regards,
> Jaroslav Pulchart

