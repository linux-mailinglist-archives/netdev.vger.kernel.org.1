Return-Path: <netdev+bounces-105280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AEF9105BB
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF791C20B17
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A47C1ACE86;
	Thu, 20 Jun 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdLpt6kF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF51A4F12
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889828; cv=none; b=VhLVBfkLK+aU6bMrCAepFKd9L+ieuAO7VIl20HIAzJ8FeH+bOnEiDT2SzrTbpkNGmi41wpLZa+vFR9+1zbbCGX5zkinbfEZKFSIkrDSSrdQt/T7pRs6mN67gwfBPkUf2M4zp+Ay9FljZoWLH3BlX22UXdb7sLTCimRCpyWlhCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889828; c=relaxed/simple;
	bh=PF804oOWsningKyY8X2WCmaUQpFqh6+o21ojOYTaW5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OvLjt4YqDTvH/idwrnOFAMJR7E2Qjlgo7B8hq2kNSsvjxeQD70YgZmDKmeXwGWGPo04AjvZ/kRUBkzVxBEsTvoNUfXS0TTwSjKghnhDWpjzRHo/0eePhdY5vcad2ej+o0R1SK+9ghgGDwhEP41CUjE7eVVs9ZM6Pn8B51fke/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdLpt6kF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718889826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H32ryajiAMQje4E0qEx+NRHYNdsGJp/lNSL+93uxA7U=;
	b=KdLpt6kFI/bPfw0+nnIjAvbuooRphQmuJ6yhYuYJ6UL1xazdapJm1FAlZF1UJPZg/v20oB
	Pp2+QY0hsK5Zv+gtvDqAv/NkPyB2gCjYgdHOMh1ocKCFxF5WYff9SDcDNadu/eUleMu8Vv
	t1vGGHHvzjnAsznhntRV9r80yhkDw4s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-N6TebLTnN8mnts2RqgPjvQ-1; Thu, 20 Jun 2024 09:23:45 -0400
X-MC-Unique: N6TebLTnN8mnts2RqgPjvQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-797d167a402so100537685a.2
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 06:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718889825; x=1719494625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H32ryajiAMQje4E0qEx+NRHYNdsGJp/lNSL+93uxA7U=;
        b=m8G2nAcS97Eb9+/6/3hW5K4R5DFgxATAom3gbMTVGCAUCZdbpA5eP1CJXcvfxXz0nI
         7U4JyyujdWgYouwHJdCOaVfwBLUgs9uQgwtNZ6JL7HUouoT4Yyzq+7DzwVUbX/UBeblA
         Di5X2zXTl3iN6BaxdONEKIzLK0o5lYKnaNVBEMmCJGrbky4LS0OiqKhCr2DFqJSPkBnB
         eqerIn8MwO/lQMZIvKT4++DqtSO+7WB8NpjloDHMp8SHaNxWwkRrsVjxhRCw/MCmGy9E
         0GDt1xWOfiaZtawiy5A0cj/zzW96++0sj932CJdLrN3ave5zxAdBKfr0tqbEGTYWLAoT
         X4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVx4E8Y2Mzu4HaCEufC6JYuotxYHk2J+eWZdP1Y+YHUaYPyiOi72bYmYFw0pkQLMK/igzIMSHjghYOCgjtD8aPjq8L4HHJV
X-Gm-Message-State: AOJu0YxLA+2xlJ7ZiSyTR/Cjyaqcn4jUPZquxD1ioe4r3zcPwUDCJyBB
	0LmFXFk4sczLSeemVu9NaxdgaLDDmRCWtnTklJxbpiisAVCnJI+EsKK1pjmKLZKf2fxeSAOp7Qv
	1IWqbP+KUT3fOqFGoEab4HD/l+GLLBnPUpmAjuqpiIx8rdYoGSIUYYQ==
X-Received: by 2002:a05:620a:2403:b0:795:5f71:b190 with SMTP id af79cd13be357-79bb3e57dcbmr639459285a.37.1718889824617;
        Thu, 20 Jun 2024 06:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7lR8Qj5tqxCfDCAWyzhiZxYPsaC/gvkzL3X7mSeb6vi1+5SrnEdEkb+ho0G8dGXin7KMHWQ==
X-Received: by 2002:a05:620a:2403:b0:795:5f71:b190 with SMTP id af79cd13be357-79bb3e57dcbmr639457685a.37.1718889824265;
        Thu, 20 Jun 2024 06:23:44 -0700 (PDT)
Received: from [10.0.0.200] (modemcable096.103-83-70.mc.videotron.ca. [70.83.103.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe48449sm696014785a.104.2024.06.20.06.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 06:23:43 -0700 (PDT)
Message-ID: <34ffbdcb-b1f9-4cee-9f55-7019a228d3f8@redhat.com>
Date: Thu, 20 Jun 2024 09:23:42 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ice driver crash on arm64
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, poros@redhat.com,
 netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 magnus.karlsson@intel.com
References: <8f9e2a5c-fd30-4206-9311-946a06d031bb@redhat.com>
 <ZnQsdxzumig7CD7c@boxer>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <ZnQsdxzumig7CD7c@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-20 09:19, Maciej Fijalkowski wrote:
> On Tue, Jun 18, 2024 at 11:23:28AM -0400, Luiz Capitulino wrote:
>> Hi,
>>
>> We have an Ampere Mount Snow system (which is arm64) with an Intel E810-C
>> NIC plugged in. The kernel is configured with 64k pages. We're observing
>> the crash below when we run iperf3 as a server in this system and load traffic
>> from another system with the same configuration. The crash is reproducible
>> with latest Linus tree 14d7c92f:
>>
>> [  225.715759] Unable to handle kernel paging request at virtual address 0075e625f68aa42c
>> [  225.723669] Mem abort info:
>> [  225.726487]   ESR = 0x0000000096000004
>> [  225.730223]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [  225.735526]   SET = 0, FnV = 0
>> [  225.738568]   EA = 0, S1PTW = 0
>> [  225.741695]   FSC = 0x04: level 0 translation fault
>> [  225.746564] Data abort info:
>> [  225.749431]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>> [  225.754906]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> [  225.759944]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [  225.765250] [0075e625f68aa42c] address between user and kernel address ranges
>> [  225.772373] Internal error: Oops: 0000000096000004 [#1] SMP
>> [  225.777932] Modules linked in: xfs(E) crct10dif_ce(E) ghash_ce(E) sha2_ce(E) sha256_arm64(E) sha1_ce(E) sbsa_gwdt(E) ice(E) nvme(E) libie(E) dimlib(E) nvme_core(E) gnss(E) nvme_auth(E) ixgbe(E) igb(E) mdio(E) i2c_algo_bit(E) i2c_designware_platform(E) xgene_hwmon(E) i2c_designware_core(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
>> [  225.807902] CPU: 61 PID: 7794 Comm: iperf3 Kdump: loaded Tainted: G            E      6.10.0-rc4+ #1
>> [  225.817021] Hardware name: LTHPC GR2134/MP32-AR2-LT, BIOS F31j (SCP: 2.10.20220531) 08/01/2022
>> [  225.825618] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [  225.832566] pc : __arch_copy_to_user+0x4c/0x240
>> [  225.837088] lr : _copy_to_iter+0x104/0x518
>> [  225.841173] sp : ffff80010978f6e0
>> [  225.844474] x29: ffff80010978f730 x28: 0000000000007388 x27: 4775e625f68aa42c
>> [  225.851597] x26: 0000000000000001 x25: 00000000000005a8 x24: 00000000000005a8
>> [  225.858720] x23: 0000000000007388 x22: ffff80010978fa60 x21: ffff80010978fa60
>> [  225.865842] x20: 4775e625f68aa42c x19: 0000000000007388 x18: 0000000000000000
>> [  225.872964] x17: 0000000000000000 x16: 0000000000000000 x15: 4775e625f68aa42c
>> [  225.880087] x14: aaa03e61c262c44f x13: 5fb01a5ebded22da x12: 415feff815830f22
>> [  225.887209] x11: 7411a8ffaab6d3d7 x10: 95af4645d12e6d70 x9 : ffffba83c2faddac
>> [  225.894332] x8 : c1cbcc6e9552ed64 x7 : dfcefe933cdc57ae x6 : 0000fffde5aa9e80
>> [  225.901454] x5 : 0000fffde5ab1208 x4 : 0000000000000004 x3 : 0000000000016180
>> [  225.908576] x2 : 0000000000007384 x1 : 4775e625f68aa42c x0 : 0000fffde5aa9e80
>> [  225.915699] Call trace:
>> [  225.918132]  __arch_copy_to_user+0x4c/0x240
>> [  225.922304]  simple_copy_to_iter+0x4c/0x78
>> [  225.926389]  __skb_datagram_iter+0x18c/0x270
>> [  225.930647]  skb_copy_datagram_iter+0x4c/0xe0
>> [  225.934991]  tcp_recvmsg_locked+0x59c/0x9a0
>> [  225.939162]  tcp_recvmsg+0x78/0x1d0
>> [  225.942638]  inet6_recvmsg+0x54/0x128
>> [  225.946289]  sock_recvmsg+0x78/0xd0
>> [  225.949766]  sock_read_iter+0x98/0x108
>> [  225.953502]  vfs_read+0x2a4/0x318
>> [  225.956806]  ksys_read+0xec/0x110
>> [  225.960108]  __arm64_sys_read+0x24/0x38
>> [  225.963932]  invoke_syscall.constprop.0+0x80/0xe0
>> [  225.968624]  do_el0_svc+0xc0/0xe0
>> [  225.971926]  el0_svc+0x48/0x1b0
>> [  225.975056]  el0t_64_sync_handler+0x13c/0x158
>> [  225.979400]  el0t_64_sync+0x1a4/0x1a8
>> [  225.983051] Code: 78402423 780008c3 910008c6 36100084 (b8404423)
>> [  225.989132] SMP: stopping secondary CPUs
>> [  225.995919] Starting crashdump kernel...
>> [  225.999829] Bye!
>>
>> I was able to find out this is actually a regression introduced in 6.3-rc1
>> and was able to bisect it down to commit:
>>
>> commit 1dc1a7e7f4108bad4af4c7c838f963d342ac0544
>> Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> Date:   Tue Jan 31 21:44:59 2023 +0100
>>
>>      ice: Centrallize Rx buffer recycling
>>
>>      Currently calls to ice_put_rx_buf() are sprinkled through
>>      ice_clean_rx_irq() - first place is for explicit flow director's
>>      descriptor handling, second is after running XDP prog and the last one
>>      is after taking care of skb.
>>
>>      1st callsite was actually only for ntc bump purpose, as Rx buffer to be
>>      recycled is not even passed to a function.
>>
>>      It is possible to walk through Rx buffers processed in particular NAPI
>>      cycle by caching ntc from beginning of the ice_clean_rx_irq().
>>
>>      To do so, let us store XDP verdict inside ice_rx_buf, so action we need
>>      to take on will be known. For XDP prog absence, just store ICE_XDP_PASS
>>      as a verdict.
>>
>>      Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>      Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>      Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>      Link: https://lore.kernel.org/bpf/20230131204506.219292-7-maciej.fijalkowski@intel.com
>>
>> Some interesting/important information:
>>
>>   * Issue doesn't reproduce when:
>>      - The kernel is configured w/ 4k pages
>>      - UDP is used (ie. iperf3 -c <server> -u -b 0)
>>      - legacy-rx is set
>>   * The NIC firmware is version 4.30 (we haven't figured out how to update it from arm)
>>
>> By taking a quick look at the code, ICE_LAST_OFFSET in ice_can_reuse_rx_page() seems
>> wrong since Rx buffers are 3k w/ bigger page sizes but just changing it to
>> ICE_RXBUF_3072 doesn't fix the issue.
>>
>> Could you please help taking a look?
> 
> Thanks for the report. I am on sick leave currently, will try to take
> alook once I'm back.

I'm sorry to hear that Maciej, I hope you get well soon.

- Luiz


