Return-Path: <netdev+bounces-89775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA358AB8AB
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 04:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561071F213AB
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 02:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8F610F7;
	Sat, 20 Apr 2024 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="eJJI1SpU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12B5A48
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713579089; cv=none; b=m8Za2DBIIglzUfXBO6i0w/BfWR3JYsUFlm3NdEXwhW3YaTAYhK8kKjr3sFp8epYZqKo/qxCW3O9h8K7qsMykziXoxm8FKc/cUmu883//pPFz4UIrib++cTX5DQRS0H1Lu/fLleCa05gREua1DyR75FOj43NNpcEiTG4quk20u6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713579089; c=relaxed/simple;
	bh=wikyFeUBEfnydUX/pVI96vc6QWnQ86p7m+yF+ZKlJtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g88u/8xppOfrALggHrpBmbfaB5KiAT18msFf7AcLzgOGE+b8amnPeijUWC0XdtYTfEEzDoSWSrVYDffAqTTniBHQB6j3UCZsQ3WDCByoduRG3hvR0wy6D/5FpZaCA/5iCDV0WB9XvecnrY9eVRhX76IJRYxxKR7BF6SrNVVJejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=eJJI1SpU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso1228553b3a.1
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 19:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713579087; x=1714183887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LwKhPTBlLLmY8prnocFcN5+/7Df2fLOK4nBUsSFUKbI=;
        b=eJJI1SpUUr+rBt1mMDKPKdagH9GbUq/cA+9zYh2L7cbnEdOpzgc/1eKlYZOars76PJ
         Cwz0sLxJQWQ3dboGW0G69QgNWSGydni/E/940B/rkJwTWMmVmLBvVZWNnSm0QXWIBGsp
         pF22hA3ODGSjGtFdlO+zcwmmtG/mILcMD2umRN5Nu2CT+TfYdFIV3Sqf9ElowxsL2b6e
         AKfh52InqiJ41KsF28gbgmpBVqbPhWPr/XL5jrC0ww6t+iuz2Jo1goIIkEN+Eye1Wpq9
         KedvpgUeFem6xjhc/uHuLoxqLZFsCsxzM+YRPjb8SCem4oZLq+Jrq2kz9tHRflJN6Rv3
         c5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713579087; x=1714183887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwKhPTBlLLmY8prnocFcN5+/7Df2fLOK4nBUsSFUKbI=;
        b=modp7M32iuvZeH8EU4gr9QtGPkv+6jRDcOw18+vzWzHQySh7w7p+oH+m/YNXfd2NPI
         aUYvt64rcOMLG9x4KvKLeb+kPOpm9J+7CKBelStZaXT2yd8tNm14DeBLxtmsXFoqtNSD
         zHK1L/B1FS/FmQ+zwMCMm6pH2i/HZAtbFJXwZYRRuOt73TkqSgXOYeeIt+Xn9EQOjX2J
         FrJJCSIJ+zYS764NiVgIP8OGbNc3hI4rQLehkVx3MxOEwYYvRG7tz7BswDKXmTHbFg6s
         UNWHhqz6D9RZ84XEsvW01dpsfCWRF5/wl7Wvcl9ux0ggC7jQx8422usrz9WL9TIlRMWg
         obQA==
X-Gm-Message-State: AOJu0YypItHrxC+tk2KwEI+9NkJuHRXNCBhiRzOjwK+VLzOkG7OElJ4k
	rn7gQKar+8KO7PIESOvhMbfqClZXvcVkMFairDDGVzwW6ffTCXPSgUwvh7J/ic0=
X-Google-Smtp-Source: AGHT+IFwtEI9EUoANES5nvYlAq2ZzcgoUL7/jWCU3RUm1+Y4J2JfnvDS01K4MxN7RNcJAfwTV4ru9A==
X-Received: by 2002:a05:6a20:a103:b0:1a7:1c9:5f86 with SMTP id q3-20020a056a20a10300b001a701c95f86mr11090392pzk.16.1713579086806;
        Fri, 19 Apr 2024 19:11:26 -0700 (PDT)
Received: from [192.168.1.27] (71-212-18-124.tukw.qwest.net. [71.212.18.124])
        by smtp.gmail.com with ESMTPSA id i123-20020a639d81000000b005f7ff496050sm1846213pgd.76.2024.04.19.19.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 19:11:26 -0700 (PDT)
Message-ID: <77786fd8-02e7-4f38-a629-2f347d2317ad@davidwei.uk>
Date: Fri, 19 Apr 2024 19:11:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] netdevsim: add NAPI support
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240419220857.2065615-1-dw@davidwei.uk>
 <20240419184757.6d4334cf@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240419184757.6d4334cf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-19 6:47 pm, Jakub Kicinski wrote:
> On Fri, 19 Apr 2024 15:08:55 -0700 David Wei wrote:
>> Add NAPI support to netdevsim and register its Rx queues with NAPI
>> instances. Then add a selftest using the new netdev Python selftest
>> infra to exercise the existing Netdev Netlink API, specifically the
>> queue-get API.
> 
> I haven't looked at the code but this makes the devlink test crash 
> the kernel:

Sorry, I'll look into it.

> 
> [ 1130.858677][T11010] KASAN: null-ptr-deref in range [0x0000000000000190-0x0000000000000197]
> [ 1130.859158][T11010] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [1130.859478][T11010] RIP: 0010:skb_queue_purge_reason (./include/linux/skbuff.h:1846 net/core/skbuff.c:3821) 
> [ 1130.859672][T11010] Code: f1 f1 f1 f1 c7 40 0c 00 00 00 f3 c7 40 10 f3 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 d8 00 00 00 48 89 f8 48 c1 e8 03 <80> 3c 10 00 0f 85 bb 02 00 00 48 8b 03 48 39 c3 0f 84 ed 01 00 00
> All code
> ========
>    0:	f1                   	int1
>    1:	f1                   	int1
>    2:	f1                   	int1
>    3:	f1                   	int1
>    4:	c7 40 0c 00 00 00 f3 	movl   $0xf3000000,0xc(%rax)
>    b:	c7 40 10 f3 f3 f3 f3 	movl   $0xf3f3f3f3,0x10(%rax)
>   12:	65 48 8b 04 25 28 00 	mov    %gs:0x28,%rax
>   19:	00 00 
>   1b:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
>   22:	00 
>   23:	48 89 f8             	mov    %rdi,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
>   2a:*	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1)		<-- trapping instruction
>   2e:	0f 85 bb 02 00 00    	jne    0x2ef
>   34:	48 8b 03             	mov    (%rbx),%rax
>   37:	48 39 c3             	cmp    %rax,%rbx
>   3a:	0f 84 ed 01 00 00    	je     0x22d
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1)
>    4:	0f 85 bb 02 00 00    	jne    0x2c5
>    a:	48 8b 03             	mov    (%rbx),%rax
>    d:	48 39 c3             	cmp    %rax,%rbx
>   10:	0f 84 ed 01 00 00    	je     0x203
> [ 1130.860181][T11010] RSP: 0018:ffffc900044ff8e0 EFLAGS: 00010202
> [ 1130.860367][T11010] RAX: 0000000000000032 RBX: 0000000000000190 RCX: 0000000000000001
> [ 1130.860580][T11010] RDX: dffffc0000000000 RSI: 0000000000000055 RDI: 0000000000000190
> [ 1130.860821][T11010] RBP: ffffc900044ff9f0 R08: 0000000000000001 R09: fffffbfff10468b4
> [ 1130.861067][T11010] R10: 0000000000000003 R11: ffffffff84800130 R12: ffffed10010f7584
> [ 1130.861312][T11010] R13: 0000000000000001 R14: 0000000000000055 R15: 1ffff9200089ff20
> [ 1130.861543][T11010] FS:  00007f691c6ba740(0000) GS:ffff888036180000(0000) knlGS:0000000000000000
> [ 1130.861801][T11010] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1130.861983][T11010] CR2: 000055d41b377ff0 CR3: 000000000988a003 CR4: 0000000000770ef0
> [ 1130.862199][T11010] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1130.862408][T11010] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1130.862630][T11010] PKRU: 55555554
> [ 1130.862745][T11010] Call Trace:
> [ 1130.862876][T11010]  <TASK>
> [1130.862954][T11010] ? die_addr (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:460) 
> [1130.863080][T11010] ? exc_general_protection (arch/x86/kernel/traps.c:702 arch/x86/kernel/traps.c:644) 
> [1130.863256][T11010] ? asm_exc_general_protection (./arch/x86/include/asm/idtentry.h:617) 
> [1130.863401][T11010] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> [1130.863599][T11010] ? skb_queue_purge_reason (./include/linux/skbuff.h:1846 net/core/skbuff.c:3821) 
> [1130.863755][T11010] ? __pfx_skb_queue_purge_reason (net/core/skbuff.c:3817) 
> [1130.863954][T11010] ? unregister_netdevice_queue (net/core/dev.c:11123) 
> [1130.864129][T11010] ? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c:114) 
> [1130.864291][T11010] ? __pfx_unregister_netdevice_queue (net/core/dev.c:11112) 
> [1130.864469][T11010] nsim_destroy (drivers/net/netdevsim/netdev.c:653 drivers/net/netdevsim/netdev.c:784) netdevsim
> [1130.864651][T11010] __nsim_dev_port_del (drivers/net/netdevsim/dev.c:426 drivers/net/netdevsim/dev.c:1426) netdevsim
> [1130.864889][T11010] nsim_dev_reload_destroy (drivers/net/netdevsim/dev.c:591 drivers/net/netdevsim/dev.c:1655) netdevsim
> [1130.865081][T11010] nsim_drv_remove (drivers/net/netdevsim/dev.c:1675) netdevsim
> [1130.865250][T11010] device_release_driver_internal (drivers/base/dd.c:1272 drivers/base/dd.c:1293) 

