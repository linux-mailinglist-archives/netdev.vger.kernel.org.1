Return-Path: <netdev+bounces-214031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E77B27E99
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4C05C08CC
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9EB3009C1;
	Fri, 15 Aug 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpaNjNK6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA03002CB;
	Fri, 15 Aug 2025 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254611; cv=none; b=N3iIozUx1quHID0Djs4Hr/T7EcMCaUDJJ++DswdzqpZzngWEXLYXnjsXWHvzuwz3Eb0jCf52y6WPbLngUWKWX5p/lhutFwCr7jLvOHTBySad3pY4+5VVDigYT9ycE6okcuPDHE0fipksBSo+yg71h86IzKhHcy0GMbMW8l36wTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254611; c=relaxed/simple;
	bh=KvmU5UEOZJhFu9T8syNR046vf1lHnn0RMi9zcqQE9xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFPVW+GBB0THuwODHmLY2hdfHmy+CU8VIdUDMzGGxeBIleoJ94vry8vUrd7x1oRk0vighGpJMMZlTVmpspmRTQcZ6IpUxW3RogeJlZL7vMrrm8KjufE0Jed9NV/+RI1Awau1q4MsGirXDYkfj1uk6NwQbUiMZVyfVRRXWne/zQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpaNjNK6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9e413a219so1539753f8f.3;
        Fri, 15 Aug 2025 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755254608; x=1755859408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukp18VqoNWqBuSWBM5wWXkFOB7Qcbp/e2GJ3Zc0A3VE=;
        b=dpaNjNK6QbjMR+CFjGZlYhfpRTDguTsBc74qhucW5cVJbEZ8DBxXTLrg/Wct8B7mb/
         yC4IbxmF+kEq2/QuUZBHf1pI2MZajJ3W3oRqe/WfFZcli+IizROvs5BxPaJJcT3Q+L+c
         1ZLfBwFl3yrNUge00wB0Penqan2g7X+5fZZ9TgB59Sy5m3FY/s1BzrZL4S99dThMvUFS
         uxpgTXiXEkAwpSSAyZThOsRERT0SZlq5pPH2pADeMQh/6xZuH5qtFo9GhcC50koGCaAf
         x+poXOEZWYlDZ7UZcElq7kD1BZmShxqEWmQ6JKD6chrq1UDA6HcG5yHCDFdgXtFTZvJb
         VXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254608; x=1755859408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukp18VqoNWqBuSWBM5wWXkFOB7Qcbp/e2GJ3Zc0A3VE=;
        b=oh2JgWag0eAE29jf48ncFxJN8Y8ezn8d9X8jCmY5G/1STKlHv0FcmDH/iq2j6Jjb2/
         +caxkJ+Vs3a9YCVIncADnoW9sglCEzJtgG6mx/WWZZgT4YDq/d20YqqZ1z4h7Oz6AeEA
         kMbze2tmpe5KClxd0pvZFSMLJ5LPVQWx3TYXqmpMFB7GnhVs6mAnk/WORYSMIjgUGpzo
         FVgVIeL8P0DQ+yAYV1lShV0Q6Joz9Qs8xKL0bh+mKx6tUh+Ik5rdP6pSNHNDGqj8l3/F
         qiKaykLw7gMiSOII6+q9OI7iS95iHdcBlnHXTPYwJ9ivlJXIS8x/c+MtABhCxDWZ0fc0
         HRMg==
X-Forwarded-Encrypted: i=1; AJvYcCVs/W+naBQ6KrcKTADHjb2KUx4HdgTkj1UDjxDeBfPr9Cmjqw30/LtvXcYJo3GbpPF5EPvDTwK1c58jgJo=@vger.kernel.org, AJvYcCWC0//XHQmvYKcyk8pIn/1ICdan5sH0FEQEYvPyx6SrWG2QoefFQ9tMF6KJ9Ycn2dsDEo13HLse@vger.kernel.org
X-Gm-Message-State: AOJu0YwbufYwlmLWkcb1H1uXMu0BY+X28pLzinH3/Qik7yHLRd1+s+iW
	S/zEQD4VVScrzk901RhpXoTyyarysVntRnq42xt59bUM/DJ+1j+6x6D4
X-Gm-Gg: ASbGncuE+PiPsPMLO68Jnj0x0uyq+2cIwYgyc4oPVn8Tq6bC6O34fRwU8X9XP8kvaQ9
	sD3zNr2E2Z7VAyvbYW8wU6wEIJpnyHeSJ20EM3Wu/Y2EQ0cq3ynWuL7j1Rvw+7xD8Rvlzhyjvi+
	WLtMHNBKCmfTK5hclRchQg6EzypAHxLIF1cLQt9pK+U2jXr0VfpZF1j106oqI57hcOah8Pk3MDo
	iyNctdA4sE6wfeEBgApTK+P3nOodUi1KUA8m7qaAQ6mERuG/nnEaOpan7t3Dq5BLQ1JKzIwBZcG
	BAPFUb9+U5FxPvhXSI4MInCF7Tdqv+Df9BZDluRrBomku1U11W/XIevJjTgOqszU/s+DATh9X13
	pTeDomECTshmoDpQUsALHLXLyAO3+fBTXi3M=
X-Google-Smtp-Source: AGHT+IEu2b86Nwn6thsvmYiD2Fea2qdkurBMTfx/azPMDQLFAtb9VlehmzaGCRx3ii6qgtyfoYz2pg==
X-Received: by 2002:a05:6000:2385:b0:3b7:9c35:bb7 with SMTP id ffacd0b85a97d-3bb6969b0bfmr1071569f8f.46.1755254608044;
        Fri, 15 Aug 2025 03:43:28 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::26f? ([2620:10d:c092:600::1:26b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758463sm1484174f8f.4.2025.08.15.03.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 03:43:27 -0700 (PDT)
Message-ID: <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
Date: Fri, 15 Aug 2025 11:44:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
To: Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: Mike Galbraith <efault@gmx.de>, paulmck@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 boqun.feng@gmail.com
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
 <20250814172326.18cf2d72@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250814172326.18cf2d72@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 01:23, Jakub Kicinski wrote:
> On Thu, 14 Aug 2025 03:16:11 -0700 Breno Leitao wrote:
>>   2.2) netpoll 				// net poll will call the network subsystem to send the packet
>>   2.3) lock(&fq->lock);			// Try to get the lock while the lock was already held

The report for reference:

https://lore.kernel.org/all/fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de/> 
> Where does netpoll take fq->lock ?

the dependencies between the lock to be acquired
[  107.985514]  and HARDIRQ-irq-unsafe lock:
[  107.985531] -> (&fq->lock){+.-.}-{3:3} {
...
[  107.988053]  ... acquired at:
[  107.988054]    check_prev_add+0xfb/0xca0
[  107.988058]    validate_chain+0x48c/0x530
[  107.988061]    __lock_acquire+0x550/0xbc0
[  107.988064]    lock_acquire.part.0+0xa1/0x210
[  107.988068]    _raw_spin_lock_bh+0x38/0x50
[  107.988070]    ieee80211_queue_skb+0xfd/0x350 [mac80211]
[  107.988198]    __ieee80211_xmit_fast+0x202/0x360 [mac80211]
[  107.988314]    ieee80211_xmit_fast+0xfb/0x1f0 [mac80211]
[  107.988424]    __ieee80211_subif_start_xmit+0x14e/0x3d0 [mac80211]
[  107.988530]    ieee80211_subif_start_xmit+0x46/0x230 [mac80211]
[  107.988634]    netpoll_start_xmit+0x8b/0xd0
[  107.988638]    __netpoll_send_skb+0x329/0x3b0
[  107.988641]    write_msg+0x104/0x120 [netconsole]
[  107.988647]    console_emit_next_record+0x203/0x250
[  107.988652]    console_flush_all+0x24d/0x370
[  107.988657]    console_unlock+0x66/0x130
[  107.988662]    vprintk_emit+0x142/0x360
[  107.988666]    _printk+0x5b/0x80
[  107.988671]    enabled_store.cold+0x7e/0x83 [netconsole]
[  107.988677]    configfs_write_iter+0xbd/0x120 [configfs]
[  107.988683]    vfs_write+0x213/0x520
[  107.988689]    ksys_write+0x69/0xe0
[  107.988691]    do_syscall_64+0x94/0xa10
[  107.988695]    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> We started hitting this a lot in the CI as well, lockdep must have
> gotten more sensitive in 6.17. Last I checked lockdep didn't understand

FWIW, I remember there were similar reports last year but with
xmit lock.

> that we manually test for nesting with netif_local_xmit_active().

Looks like Breno tried to simplify it, the original syz report
gave the following scenario:

[  107.984942] Chain exists of:
                  console_owner --> target_list_lock --> &fq->lock

[  107.984947]  Possible interrupt unsafe locking scenario:
[  107.984948]        CPU0                    CPU1
[  107.984949]        ----                    ----
[  107.984950]   lock(&fq->lock);
[  107.984952]                                local_irq_disable();
[  107.984952]                                lock(console_owner);
[  107.984954]                                lock(target_list_lock);
[  107.984956]   <Interrupt>
[  107.984957]     lock(console_owner);


Seems like with the fq->lock trace I pasted above we can get sth like:

         CPU0                    CPU1
         ----                    ----
    lock(&fq->lock);
                                 local_irq_disable();
                                 lock(console_owner);
                                 lock(target_list_lock);
                                 lock(&fq->lock);
    <Interrupt>
      lock(console_owner);

Nesting checks won't help with this one.

-- 
Pavel Begunkov


