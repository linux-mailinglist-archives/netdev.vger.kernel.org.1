Return-Path: <netdev+bounces-119599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CA39564C1
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC4B281291
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D48158532;
	Mon, 19 Aug 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KPliGOpD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9613BC1E
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052862; cv=none; b=Hv40cjfOh6bjYQvn8zL0W3EOfvNLQz68gb2lAURukDassGyMYds+s2v6GqHbWub5R70zotXwSBl9wXqpG3I7bl8W5La9F8xfA4sInTIrYlyamSestoFejFhVbtPXr+xG5iLvlLb9rhj5GctZ9S1DkRMLX8oW09sIFJnhgoA62Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052862; c=relaxed/simple;
	bh=8oPGgySbV2HkWjcUrxTBY6WVXOwBo+jviRMF6fsBJJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jp6ehgYpNtIPdIfdQUsNqrsVSLpQJXGi3OU0hdRYq2G+qL9NEdj/bFH3tbGALhw+bbQS/7U3GvkhYPasfTcsVrYtP0CMPLVZfhMTieXR9onVR7VZxTrQkqM183gAvBnTwmEiDkRwFcPpWr2meWiYbmZ1f3AvBMHH4fyOO+i8ztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=KPliGOpD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so2709012a12.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1724052859; x=1724657659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXtLstPWNzLzHmcbZlyWuprdgqgSNp8UZGZxAHv9jYw=;
        b=KPliGOpDV8rqBJ+Uim8Nb4Rl/jTYRqftPocg8JC3fDNka7H5C5i73I+iDmMxGuACfg
         O9HillzHvEZF38I9zAdNAYA4W+uuTnjkcD/Hj4/CoZUpBplGWC7CAiq98x6NdyBzLjN9
         FeWVz8OvII6GTfq1XVrm+ARvyRgzvKNOjVNfB6C6Yqak8wVCdNBXVmHgOsLLjIOdEiIH
         1hZIBn+Oz48FkcidLtwhnLUviKwkzZbElTKsbvjt2phRtQLtMQxI9PSLKQJZ3aLDs590
         UJjjQT1duaNMVUcZ3kpx2/nxosddEq3KQw8yS6UCgpjWQfkVppa2tXdRWxFlP/D28MOc
         NlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052859; x=1724657659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXtLstPWNzLzHmcbZlyWuprdgqgSNp8UZGZxAHv9jYw=;
        b=OHdpypUxRmDzfE66csfLtY2xDLun/cqwvuAYhQdHbpkMjBtmU6mbn5vUHS1f+m/x0h
         WBVCYdVsx3OOEbPyLCq0ooPw/I80/W6Sy9XcjuZoSmgC8vWHshYLbSzXuPGScfRYYwKv
         BemXGBZNMsBV2OY3u16W34fon311QJBf+gJUweDPEHa+2/qvGqb95h674Y042PZs00jF
         jXnUA0v0CgFBpAl6+Onem2CrIFPfcQsxuwukNZslJy+J5kPZltOfRIZIZQ6OwI0q/umN
         LyMG1vdbsYlz9A5BqkZeF6XEbChMKkvnnUK/BmEIOhUdklvufKN8BKspdEHot6dmaYOB
         gAwQ==
X-Gm-Message-State: AOJu0YwiZx3B9yk9k22aCnsvxsgvCkSPtGsqoFUH5LyQydRzaJx34I3D
	224OaFRqo6mrVg8OrsKdevU57Z73wOBxbpdaGyFJpQYQDOUI5oKW/eb5mY14OTw=
X-Google-Smtp-Source: AGHT+IGBy5FU6h6oZohtGR6Eg6XYyJDapBBRhB+qHIc+fLBLbssyVK0wo9kHncFbFTY+bj5G+b9A5w==
X-Received: by 2002:a05:6402:4307:b0:5a2:84e2:c88a with SMTP id 4fb4d7f45d1cf-5beca576917mr7040380a12.12.1724052858549;
        Mon, 19 Aug 2024 00:34:18 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bee665297csm2346614a12.50.2024.08.19.00.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 00:34:18 -0700 (PDT)
Message-ID: <c6c965c3-dc69-4be9-8817-2146992f9359@blackwall.org>
Date: Mon, 19 Aug 2024 10:34:16 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] bonding: fix xfrm real_dev null pointer
 dereference
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
 davem@davemloft.net, jv@jvosburgh.net, andy@greyhouse.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jarod@redhat.com
References: <20240816114813.326645-1-razor@blackwall.org>
 <20240816114813.326645-4-razor@blackwall.org> <ZsK0AJXxNtJqr9AR@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZsK0AJXxNtJqr9AR@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 05:54, Hangbin Liu wrote:
> On Fri, Aug 16, 2024 at 02:48:12PM +0300, Nikolay Aleksandrov wrote:
>> We shouldn't set real_dev to NULL because packets can be in transit and
>> xfrm might call xdo_dev_offload_ok() in parallel. All callbacks assume
>> real_dev is set.
>>
>>  Example trace:
>>  kernel: BUG: unable to handle page fault for address: 0000000000001030
>>  kernel: bond0: (slave eni0np1): making interface the new active one
>>  kernel: #PF: supervisor write access in kernel mode
>>  kernel: #PF: error_code(0x0002) - not-present page
>>  kernel: PGD 0 P4D 0
>>  kernel: Oops: 0002 [#1] PREEMPT SMP
>>  kernel: CPU: 4 PID: 2237 Comm: ping Not tainted 6.7.7+ #12
>>  kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
>>  kernel: RIP: 0010:nsim_ipsec_offload_ok+0xc/0x20 [netdevsim]
>>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
> 
> I saw the errors are during bond_ipsec_add_sa_all, which also
> set ipsec->xs->xso.real_dev = NULL. Should we fix it there?
> 
> Thanks
> Hangbin

Correct, I saw it too but I didn't remove it on purpose. I know it can lead to a
similar error, but the fix is more complicated. I don't believe it's correct to
set real_dev if the SA add failed, so we need to think about a different way
to sync it. To be fair in real life it would be more difficult to hit it because
the device must be in a state where the SA add fails, although it supports
xfrm offload. The problem is that real_dev must be set before attempting the SA
add in the first place.

>>  kernel: Code: e0 0f 0b 48 83 7f 38 00 74 de 0f 0b 48 8b 47 08 48 8b 37 48 8b 78 40 e9 b2 e5 9a d7 66 90 0f 1f 44 00 00 48 8b 86 80 02 00 00 <83> 80 30 10 00 00 01 b8 01 00 00 00 c3 0f 1f 80 00 00 00 00 0f 1f
>>  kernel: bond0: (slave eni0np1): making interface the new active one
>>  kernel: RSP: 0018:ffffabde81553b98 EFLAGS: 00010246
>>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>>  kernel:
>>  kernel: RAX: 0000000000000000 RBX: ffff9eb404e74900 RCX: ffff9eb403d97c60
>>  kernel: RDX: ffffffffc090de10 RSI: ffff9eb404e74900 RDI: ffff9eb3c5de9e00
>>  kernel: RBP: ffff9eb3c0a42000 R08: 0000000000000010 R09: 0000000000000014
>>  kernel: R10: 7974203030303030 R11: 3030303030303030 R12: 0000000000000000
>>  kernel: R13: ffff9eb3c5de9e00 R14: ffffabde81553cc8 R15: ffff9eb404c53000
>>  kernel: FS:  00007f2a77a3ad00(0000) GS:ffff9eb43bd00000(0000) knlGS:0000000000000000
>>  kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  kernel: CR2: 0000000000001030 CR3: 00000001122ab000 CR4: 0000000000350ef0
>>  kernel: bond0: (slave eni0np1): making interface the new active one
>>  kernel: Call Trace:
>>  kernel:  <TASK>
>>  kernel:  ? __die+0x1f/0x60
>>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>>  kernel:  ? page_fault_oops+0x142/0x4c0
>>  kernel:  ? do_user_addr_fault+0x65/0x670
>>  kernel:  ? kvm_read_and_reset_apf_flags+0x3b/0x50
>>  kernel: bond0: (slave eni0np1): making interface the new active one
>>  kernel:  ? exc_page_fault+0x7b/0x180
>>  kernel:  ? asm_exc_page_fault+0x22/0x30
>>  kernel:  ? nsim_bpf_uninit+0x50/0x50 [netdevsim]
>>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>>  kernel:  ? nsim_ipsec_offload_ok+0xc/0x20 [netdevsim]
>>  kernel: bond0: (slave eni0np1): making interface the new active one
>>  kernel:  bond_ipsec_offload_ok+0x7b/0x90 [bonding]
>>  kernel:  xfrm_output+0x61/0x3b0
>>  kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>>  kernel:  ip_push_pending_frames+0x56/0x80
>>
>> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>>  drivers/net/bonding/bond_main.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index 65ddb71eebcd..f74bacf071fc 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -582,7 +582,6 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>>  		} else {
>>  			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
>>  		}
>> -		ipsec->xs->xso.real_dev = NULL;
>>  	}
>>  	spin_unlock_bh(&bond->ipsec_lock);
>>  	rcu_read_unlock();
>> -- 
>> 2.44.0
>>


