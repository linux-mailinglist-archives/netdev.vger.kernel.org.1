Return-Path: <netdev+bounces-106918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E33E91816E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C6D28213E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0396317F39D;
	Wed, 26 Jun 2024 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgQsin4x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4D1E87C
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406424; cv=none; b=onN+wjSUcaNEOtjeKo8iS9lgzNSezfDDfPAIHn3xg0X0JJGmR9mWUD3D5df/hbMMdSEnGzx4TO6upBypEg0BmTPECMXPp8kRe1fvxnF7b1WEtmuvyIJYvXlsGB+Q6UGSFYXgU6EG0OLPUpvn8Vc49v9kwzqFwAEMIRB5gR1TbFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406424; c=relaxed/simple;
	bh=BcGQuYGU7aq5lcN4YU/X2cMwKQLmQV16y1V+Mz9RmUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XI5H8AIhdUIcGYUy9AC0r6WdfH13aY5bomvSWKBEq9VuS5zMDSmX6jTjvr78shwAXSdwALXKlY8dWWwbg8oy6PnRPvmlgy7ZWaGtDUrpb/dFSN9wo91dRXZe6iBj5wvXz4VL4wVrT3/W4IqFPFtschmxw67Cbxvw96k5f9dQ8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgQsin4x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719406422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqcG2qgB9OU4ZG+L51leem8UKs9vigswdVQfu7Fh1gE=;
	b=PgQsin4xiwCPk++H5LqhRnMoKFivi0RnZo0HPk2cQ8R+Dg/JPp9J8fAWmImysJr/PHdRjR
	fwejnCDdZuNZDdcXruFqx1Ju0JXPf9lXvmqNqJM01tpL3GZCWLZKoK8+hmHrn4xfgqONNG
	qD63fa8+xzUYfJgMIATykESxt132zD4=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-Zx7p0g3DPJePcxEXEAG0ZQ-1; Wed, 26 Jun 2024 08:53:40 -0400
X-MC-Unique: Zx7p0g3DPJePcxEXEAG0ZQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-700d1893f82so875448a34.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 05:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719406420; x=1720011220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqcG2qgB9OU4ZG+L51leem8UKs9vigswdVQfu7Fh1gE=;
        b=KuU3xi48nEh1PlEcTQPczcVM3lhIJqaDT81Xn+kKVbVHIwngF9uLdMfSuBso1+DemI
         Rn1PW9DbP1hzmdcl1Fp3KbWg7xBYfjMtAepScHzAWfosy1FPgYMhXZYYE+vq/cC+6va+
         BBUtx8qakHCgRi5h00ha4Uya2SOpWW5cytbN0TN0hWeY9KMu50xto4WyndudUOPBmg3N
         Qq2dJTl83u1KlygveFRc5P++SnKsQl+Idnahzq3NH3IM3/bPVstObo8maQ8xJKAVohjw
         66oXaGYFCcqYZdqrl6aMM+jQ6VUzrB3lJFLUGYoLYiiBQ0maajSoaZs3eD18WJwwzRIB
         JrIg==
X-Forwarded-Encrypted: i=1; AJvYcCXFU8yh9Dt8yA475JN+JkEfIINzSx3FvBiYdzqyDVkjOezrJPC4jixsHC6KU3bCVRS2Bd6qU9ABWpNeDpXkKIpiafzJ0A60
X-Gm-Message-State: AOJu0YyhjcQsJbQZH/0QSCblKDYtS6pDBHO9XC2uGQrrNCgW+JvqIzJq
	VjjDoQ+46gv9gHjXwE5vJKHXU1K8FMtEmGTN30fExVmUNjCdrMOd6gnO1jBPecWucxKOALJ1vxv
	UNFS2+a67DGi0Sl+gY7XZPeioocmL+v36GnWyJShASXqEMCBvPckHDA==
X-Received: by 2002:a05:6830:e13:b0:6f9:f7f4:d771 with SMTP id 46e09a7af769-700b1216cc1mr9920824a34.21.1719406419784;
        Wed, 26 Jun 2024 05:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCMGMi8jIG1h6fbS9UIaRbq3LYyK+A23OEi/1TWgLYETnZQfoWbQTOZVFQzt+bD04zG0ycng==
X-Received: by 2002:a05:6830:e13:b0:6f9:f7f4:d771 with SMTP id 46e09a7af769-700b1216cc1mr9920797a34.21.1719406419391;
        Wed, 26 Jun 2024 05:53:39 -0700 (PDT)
Received: from [10.0.0.200] (modemcable096.103-83-70.mc.videotron.ca. [70.83.103.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8b3777sm493772585a.54.2024.06.26.05.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 05:53:38 -0700 (PDT)
Message-ID: <a4549e76-5852-4b9f-82f9-0f2d665ab122@redhat.com>
Date: Wed, 26 Jun 2024 08:53:37 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ice driver crash on arm64
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, xmu@redhat.com
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, poros@redhat.com,
 netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 magnus.karlsson@intel.com
References: <8f9e2a5c-fd30-4206-9311-946a06d031bb@redhat.com>
 <ZnQsdxzumig7CD7c@boxer> <34ffbdcb-b1f9-4cee-9f55-7019a228d3f8@redhat.com>
 <ZnvdGQ0fUTAIorhS@boxer>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <ZnvdGQ0fUTAIorhS@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-26 05:19, Maciej Fijalkowski wrote:
> On Thu, Jun 20, 2024 at 09:23:42AM -0400, Luiz Capitulino wrote:
>> On 2024-06-20 09:19, Maciej Fijalkowski wrote:
>>> On Tue, Jun 18, 2024 at 11:23:28AM -0400, Luiz Capitulino wrote:
>>>> Hi,
>>>>
>>>> We have an Ampere Mount Snow system (which is arm64) with an Intel E810-C
>>>> NIC plugged in. The kernel is configured with 64k pages. We're observing
>>>> the crash below when we run iperf3 as a server in this system and load traffic
>>>> from another system with the same configuration. The crash is reproducible
>>>> with latest Linus tree 14d7c92f:
>>>>
>>>> [  225.715759] Unable to handle kernel paging request at virtual address 0075e625f68aa42c
>>>> [  225.723669] Mem abort info:
>>>> [  225.726487]   ESR = 0x0000000096000004
>>>> [  225.730223]   EC = 0x25: DABT (current EL), IL = 32 bits
>>>> [  225.735526]   SET = 0, FnV = 0
>>>> [  225.738568]   EA = 0, S1PTW = 0
>>>> [  225.741695]   FSC = 0x04: level 0 translation fault
>>>> [  225.746564] Data abort info:
>>>> [  225.749431]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>>> [  225.754906]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>>> [  225.759944]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>>> [  225.765250] [0075e625f68aa42c] address between user and kernel address ranges
>>>> [  225.772373] Internal error: Oops: 0000000096000004 [#1] SMP
>>>> [  225.777932] Modules linked in: xfs(E) crct10dif_ce(E) ghash_ce(E) sha2_ce(E) sha256_arm64(E) sha1_ce(E) sbsa_gwdt(E) ice(E) nvme(E) libie(E) dimlib(E) nvme_core(E) gnss(E) nvme_auth(E) ixgbe(E) igb(E) mdio(E) i2c_algo_bit(E) i2c_designware_platform(E) xgene_hwmon(E) i2c_designware_core(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
>>>> [  225.807902] CPU: 61 PID: 7794 Comm: iperf3 Kdump: loaded Tainted: G            E      6.10.0-rc4+ #1
>>>> [  225.817021] Hardware name: LTHPC GR2134/MP32-AR2-LT, BIOS F31j (SCP: 2.10.20220531) 08/01/2022
>>>> [  225.825618] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> [  225.832566] pc : __arch_copy_to_user+0x4c/0x240
>>>> [  225.837088] lr : _copy_to_iter+0x104/0x518
>>>> [  225.841173] sp : ffff80010978f6e0
>>>> [  225.844474] x29: ffff80010978f730 x28: 0000000000007388 x27: 4775e625f68aa42c
>>>> [  225.851597] x26: 0000000000000001 x25: 00000000000005a8 x24: 00000000000005a8
>>>> [  225.858720] x23: 0000000000007388 x22: ffff80010978fa60 x21: ffff80010978fa60
>>>> [  225.865842] x20: 4775e625f68aa42c x19: 0000000000007388 x18: 0000000000000000
>>>> [  225.872964] x17: 0000000000000000 x16: 0000000000000000 x15: 4775e625f68aa42c
>>>> [  225.880087] x14: aaa03e61c262c44f x13: 5fb01a5ebded22da x12: 415feff815830f22
>>>> [  225.887209] x11: 7411a8ffaab6d3d7 x10: 95af4645d12e6d70 x9 : ffffba83c2faddac
>>>> [  225.894332] x8 : c1cbcc6e9552ed64 x7 : dfcefe933cdc57ae x6 : 0000fffde5aa9e80
>>>> [  225.901454] x5 : 0000fffde5ab1208 x4 : 0000000000000004 x3 : 0000000000016180
>>>> [  225.908576] x2 : 0000000000007384 x1 : 4775e625f68aa42c x0 : 0000fffde5aa9e80
>>>> [  225.915699] Call trace:
>>>> [  225.918132]  __arch_copy_to_user+0x4c/0x240
>>>> [  225.922304]  simple_copy_to_iter+0x4c/0x78
>>>> [  225.926389]  __skb_datagram_iter+0x18c/0x270
>>>> [  225.930647]  skb_copy_datagram_iter+0x4c/0xe0
>>>> [  225.934991]  tcp_recvmsg_locked+0x59c/0x9a0
>>>> [  225.939162]  tcp_recvmsg+0x78/0x1d0
>>>> [  225.942638]  inet6_recvmsg+0x54/0x128
>>>> [  225.946289]  sock_recvmsg+0x78/0xd0
>>>> [  225.949766]  sock_read_iter+0x98/0x108
>>>> [  225.953502]  vfs_read+0x2a4/0x318
>>>> [  225.956806]  ksys_read+0xec/0x110
>>>> [  225.960108]  __arm64_sys_read+0x24/0x38
>>>> [  225.963932]  invoke_syscall.constprop.0+0x80/0xe0
>>>> [  225.968624]  do_el0_svc+0xc0/0xe0
>>>> [  225.971926]  el0_svc+0x48/0x1b0
>>>> [  225.975056]  el0t_64_sync_handler+0x13c/0x158
>>>> [  225.979400]  el0t_64_sync+0x1a4/0x1a8
>>>> [  225.983051] Code: 78402423 780008c3 910008c6 36100084 (b8404423)
>>>> [  225.989132] SMP: stopping secondary CPUs
>>>> [  225.995919] Starting crashdump kernel...
>>>> [  225.999829] Bye!
>>>>
>>>> I was able to find out this is actually a regression introduced in 6.3-rc1
>>>> and was able to bisect it down to commit:
>>>>
>>>> commit 1dc1a7e7f4108bad4af4c7c838f963d342ac0544
>>>> Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>>> Date:   Tue Jan 31 21:44:59 2023 +0100
>>>>
>>>>       ice: Centrallize Rx buffer recycling
>>>>
>>>>       Currently calls to ice_put_rx_buf() are sprinkled through
>>>>       ice_clean_rx_irq() - first place is for explicit flow director's
>>>>       descriptor handling, second is after running XDP prog and the last one
>>>>       is after taking care of skb.
>>>>
>>>>       1st callsite was actually only for ntc bump purpose, as Rx buffer to be
>>>>       recycled is not even passed to a function.
>>>>
>>>>       It is possible to walk through Rx buffers processed in particular NAPI
>>>>       cycle by caching ntc from beginning of the ice_clean_rx_irq().
>>>>
>>>>       To do so, let us store XDP verdict inside ice_rx_buf, so action we need
>>>>       to take on will be known. For XDP prog absence, just store ICE_XDP_PASS
>>>>       as a verdict.
>>>>
>>>>       Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>>>       Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>>>       Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>>>       Link: https://lore.kernel.org/bpf/20230131204506.219292-7-maciej.fijalkowski@intel.com
>>>>
>>>> Some interesting/important information:
>>>>
>>>>    * Issue doesn't reproduce when:
>>>>       - The kernel is configured w/ 4k pages
>>>>       - UDP is used (ie. iperf3 -c <server> -u -b 0)
>>>>       - legacy-rx is set
>>>>    * The NIC firmware is version 4.30 (we haven't figured out how to update it from arm)
>>>>
>>>> By taking a quick look at the code, ICE_LAST_OFFSET in ice_can_reuse_rx_page() seems
>>>> wrong since Rx buffers are 3k w/ bigger page sizes but just changing it to
>>>> ICE_RXBUF_3072 doesn't fix the issue.
>>>>
>>>> Could you please help taking a look?
>>>
>>> Thanks for the report. I am on sick leave currently, will try to take
>>> alook once I'm back.
>>
>> I'm sorry to hear that Maciej, I hope you get well soon.
> 
> Thanks I'm back now. Can you tell us also what MTU is used for these
> tests? Our validation is working on repro now.

Xiumei,

Can you take a look now that you got the machine back?

- Luiz


