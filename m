Return-Path: <netdev+bounces-177723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFB2A716AB
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 13:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8657B7A525B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72771E1020;
	Wed, 26 Mar 2025 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="zDXdZbrH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F78158A09
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992032; cv=none; b=FnjZhkPDoNlHixLPtupzVivgZpsoo5iFGOikvDRPCxCs+T6IhCGBu2NDtQBf1kbLyOx7xISVtpvRLsoA3OPxo6t66TYdO1SulefDYRNJ9nLnBypCtOJPb+sziocMqlL+9xLx6zJ4f4g3pL2TCXz51SY6AKPi9L7bsWVPHvQFMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992032; c=relaxed/simple;
	bh=SV+/e0uOpaXgdqdk1UV8GlqnRF/RD/ueS6pKXijqHyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I7YEIfndEDFdpN/Rmh89n51b+EYBKtH8YNnS23wCnajONhbXuB8k7vOSTicrC23Dv83ve33dmm0R0J/GEu4dyq4crPNxc82ZAQPPtz3og0IsYXsFCLHpTNv+4Asa4FfSjjYhzgVjj56+IzCJ3dx9xAJHH8rKTfDqeE2Rxc5l/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=zDXdZbrH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac29af3382dso1135882766b.2
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1742992027; x=1743596827; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNXRzOksnIPDw2T5nHIgavLJ/ABfFnOewbwM5RTRJBA=;
        b=zDXdZbrHv1Qrqq9SFM9FnHEZJnw7gBQnFba2hD+v/uvqqQU9bpNYpLV/Apl/SqFJh7
         t6cl+Rp7p+s47MjBmvuaRKedRLVoG7EeCdaLE3+ZrK0elcniRe53JtUNlzSthIrYS6VK
         AjlyZc7TubPofvp6BQNRu3ff7SrHaqke3eppdaHegfI5inTQf3dqoqzX2Uc+c2PgfiJu
         EV7AIe5LjEbtEchAPDH7SipsMlogvjUpjopZSQnkDO0a442G1yUh27EVlgBUKNJwLa/t
         TT1XGoDBjKXgp0XvXzjquEgiSbxrcmQgBjZ9rLLBOLrp9RVbdHhnGJt+Aj9r+ecqYcQB
         9V+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992027; x=1743596827;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNXRzOksnIPDw2T5nHIgavLJ/ABfFnOewbwM5RTRJBA=;
        b=TEJk4xH/fuKu2KSfrmpqQR+hpdB5bYQrISW2LBWUZ6w1rB9PyiZ0QXyrf3nnMgTcjV
         EIep66gcGPiqwORecNsxFla9Lryl+0+cLV3mFLq7+SMjr1MxQk1L5O8I8Sv5yqiCD3ck
         KY2VthQeOc3xiWb5E4JsPsXX4Lu5OpuD1s2NdQ9DTFZEqXPKI/sHh8h17zydZSFKDggG
         FEPQ3KXN5RszJICRB5zflZLeMPLrL1l0c07RQHi4uUrjxwZ+c/IVnRyBz4psT3YFsLaH
         l1Od7kNFOsSqbbUBT/vct+tGKdTX/qYHlyZGHQ/Myhkw7CrdJpHqvrHdLjxN0ZCf/xJd
         PyLg==
X-Forwarded-Encrypted: i=1; AJvYcCUmwGt8u0k2zhwIeVxfR5NR625QwoIWTBeEPA7uag6ytrDPtVzV5j0dzGkE3KMN8fHLi8Ho+OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00OkFQYEqOZseDX8atk1PX4paSABLvBi181NEq5qR8lf28GX2
	YqKZ05LcZwA2goU1OxDEWFJ69W/Au42FbFiKzEBVvoyde6Bopq6/4GzjUbKGijmzpIK4U1IY8mP
	K
X-Gm-Gg: ASbGncvDRJanKvzNW3AfnMKja25SN/BfG723vLaXvVpADLRYavZyoFF5Dbk6mmvzy26
	diRff8ySm9YSh6x8n0hIVpubAQpMHCL96H7FL4J0GkDlfMkCHXvsOaIx2o4QeCKTGXRdD7PoWa9
	5Wwp7hOj5cY108udER+uAkm/KczlBDXpURFE+lFAWUx/8TfzBG5OQcoubx3KWCeos8vlCoKLxnI
	SxHb6kGZGDrYh4qgBSOjxFg6PRKiydeQ4G1+yRaeRiRKbn3LhIHiQtDSwhsSqaOxW3CCBTpEqhn
	V5dCEIW+esba/vtkKqOQKiNo8Xds91gCKJE4hE82t6JVvHUbCgHe9OVYRnfbtUbdrOWT8jlH5Zc
	=
X-Google-Smtp-Source: AGHT+IFPBtsAcJaLibETOYQEyo7vPUdMPrrhSAxNPFMy81iqRnoMoEXYFf087GIM9GGxwTxqpWW/CQ==
X-Received: by 2002:a17:907:7295:b0:ac6:dfb0:292b with SMTP id a640c23a62f3a-ac6dfb02985mr384679466b.32.1742992027053;
        Wed, 26 Mar 2025 05:27:07 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6964189b3sm581380866b.3.2025.03.26.05.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 05:27:06 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, kuba@kernel.org, marcin.s.wojtas@gmail.com,
 linux@armlinux.org.uk, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net] net: mvpp2: Prevent parser TCAM memory corruption
In-Reply-To: <20250326120719.587afbf8@fedora.home>
References: <20250326103821.3508139-1-tobias@waldekranz.com>
 <20250326120719.587afbf8@fedora.home>
Date: Wed, 26 Mar 2025 13:27:05 +0100
Message-ID: <87iknw9duu.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ons, mar 26, 2025 at 12:07, Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> Hi Tobias,
>
> On Wed, 26 Mar 2025 11:37:33 +0100
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
>> Protect the parser TCAM/SRAM memory, and the cached (shadow) SRAM
>> information, from concurrent modifications.
>> 
>> Both the TCAM and SRAM tables are indirectly accessed by configuring
>> an index register that selects the row to read or write to. This means
>> that operations must be atomic in order to, e.g., avoid spreading
>> writes across multiple rows. Since the shadow SRAM array is used to
>> find free rows in the hardware table, it must also be protected in
>> order to avoid TOCTOU errors where multiple cores allocate the same
>> row.
>> 
>> This issue was detected in a situation where `mvpp2_set_rx_mode()` ran
>> concurrently on two CPUs. In this particular case the
>> MVPP2_PE_MAC_UC_PROMISCUOUS entry was corrupted, causing the
>> classifier unit to drop all incoming unicast - indicated by the
>> `rx_classifier_drops` counter.
>> 
>> Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>> 
>> @Andrew: I did finally manage to trigger sparse warnings that could be
>> silenced with __must_hold() annotations, but I still do not understand
>> how they work. I went back to the change that pulled this in:
>> 
>> https://lore.kernel.org/all/C5833F40-2EA6-43DA-B69C-AFF59E76E0C9@coraid.com/T/
>> 
>> The referenced function (tx()), still exists in aoenet.c. Using that
>> as a template, I could construct an unlock+lock sequence that
>> triggered a warning without __must_hold(). For example...
>> 
>> spin_unlock_bh(&priv->prs_spinlock);
>> if (net_ratelimit())
>> 	schedule();
>> spin_lock_bh(&priv->prs_spinlock);
>> 
>> ...would generate a warning. But this...
>> 
>> spin_unlock_bh(&priv->prs_spinlock);
>> net_ratelimit();
>> schedule();
>> spin_lock_bh(&priv->prs_spinlock);
>> 
>> ...would not.
>> 
>> Reading through the sparse validation suite, it does not seem to have
>> any tests that covers this either:
>> 
>> https://web.git.kernel.org/pub/scm/devel/sparse/sparse.git/tree/validation/context.c
>> 
>> Therefore, I decided to take Jakub's advise and add lockdep assertions
>> instead. That necessitated some more changes, since tables are updated
>> in the init phase (where I originally omitted locking).
>> 
>> @Maxime: There was enough of a diff between v2->v3 that I did not feel
>> comfortable including your signoff/testing tags. Would it be possible
>> for you to run your tests again on this version?
>
> Sure thing, although I do have some comments :)
>
> [...]
>
>>  /* Parser default initialization */
>> @@ -2118,6 +2163,8 @@ int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv)
>>  {
>>  	int err, index, i;
>>  
>> +	spin_lock_bh(&priv->prs_spinlock);
>> +
>>  	/* Enable tcam table */
>>  	mvpp2_write(priv, MVPP2_PRS_TCAM_CTRL_REG, MVPP2_PRS_TCAM_EN_MASK);
>>  
>> @@ -2139,8 +2186,10 @@ int mvpp2_prs_default_init(struct platform_device *pdev, struct mvpp2 *priv)
>>  	priv->prs_shadow = devm_kcalloc(&pdev->dev, MVPP2_PRS_TCAM_SRAM_SIZE,
>>  					sizeof(*priv->prs_shadow),
>>  					GFP_KERNEL);
>
> GFP_KERNEL alloc while holding a spinlock isn't correct and triggers a
> splat when building when CONFIG_DEBUG_ATOMIC_SLEEP :

I think I had pretty much every other debug flag enabled in my config :)

Thanks for catching this!

> [    4.380325] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
> [    4.389217] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
> [    4.397120] preempt_count: 201, expected: 0
> [    4.401358] RCU nest depth: 0, expected: 0
> [    4.405507] 2 locks held by swapper/0/1:
> [    4.409488]  #0: ffff000100e168f8 (&dev->mutex){....}-{4:4}, at: __driver_attach+0x8c/0x1ac
> [    4.417971]  #1: ffff00010ae15368 (&priv->prs_spinlock){+...}-{3:3}, at: mvpp2_prs_default_init+0x50/0x1570
> [    4.427843] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc7-01963-g02bf787e4750 #68
> [    4.427851] Hardware name: Marvell 8040 MACCHIATOBin Double-shot (DT)
> [    4.427855] Call trace:
> [    4.427858]  show_stack+0x18/0x24 (C)
> [    4.427867]  dump_stack_lvl+0xd8/0xf0
> [    4.427875]  dump_stack+0x18/0x24
> [    4.427880]  __might_resched+0x148/0x24c
> [    4.427890]  __might_sleep+0x48/0x7c
> [    4.427897]  __kmalloc_node_track_caller_noprof+0x200/0x480
> [    4.427903]  devm_kmalloc+0x54/0x118
> [    4.427910]  mvpp2_prs_default_init+0x138/0x1570
> [    4.427919]  mvpp2_probe+0x904/0xfa4
> [    4.427926]  platform_probe+0x68/0xc8
> [...]
>
> I suggest you move that alloc and associated error handling outside of
> the spinlock.

Will do. Sorry for the noise. I have fixed this locally - will send v4
as soon as the rules permit.

