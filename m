Return-Path: <netdev+bounces-237338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EFAC49050
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 20:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDDB3A6638
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF4331A72;
	Mon, 10 Nov 2025 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bv3p5nzH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r5rc7s6J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E714329C4D
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802644; cv=none; b=Wj2/DT0x+jNLwQQ1Pnc23C2RWHAa9pXbRzlc3mfi+8k5oBFaQJYnL218QSZymX7Ey7ux06sZ+q+pgHJwcpbfHkQovNTM1Cbzsg429IWZzTw/8/G0bQZflJwLCqOb1NuW/QzmW03rD067B6WyJ2bSqY2zAnYSXr/q1FdIy8zhv6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802644; c=relaxed/simple;
	bh=rwed5s0NZcKmoWliUWQycRPIRqkLjWCU1S0rHF7ZPc8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j9twU9T7qrEIkBFzD6tw8XazF1IwYjbhgFQwykU3QK762dIPZ/5FwnflI7btjcLuBX9uk+gaTF61VWlWv9OTtobdVftA+scG3+3/zzLxzt5ysRTZHze+Mzc4xzcUYc1bVsPNGKNu+VV+Vef3FWJ8yHp3wikJni5LIf58/byOoas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bv3p5nzH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r5rc7s6J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762802641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFmkfkXaVUQbQzQgIBWtDhMvK7IUgEF1iDdcU6dO2Sg=;
	b=Bv3p5nzHbIqoKj3SLJXk3yNDlDsBKSvK1Rh5oKgkew6mbpgIH3kPCNWsOiq2gwzAMrdgX3
	nyOhLAMxsBIW6lCC1JCTgu/oEzskCrC6yfSmW2Rwq/ydcA/fuhgdLN/P44sL3bJO5xehLD
	0qAuC2L9/xdE+wDv5SjWxehj0C+/RUQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-oKphTEZ8NoCpoglgf6V07w-1; Mon, 10 Nov 2025 14:23:59 -0500
X-MC-Unique: oKphTEZ8NoCpoglgf6V07w-1
X-Mimecast-MFC-AGG-ID: oKphTEZ8NoCpoglgf6V07w_1762802639
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b33d2a818so685018f8f.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 11:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762802638; x=1763407438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qFmkfkXaVUQbQzQgIBWtDhMvK7IUgEF1iDdcU6dO2Sg=;
        b=r5rc7s6JJ7jipKP/eIHEqfKQAfg4KETwrzlyyHwu+BT49FHPgb8pCEwPRmU7V+g7/H
         6Od5kDsHxgYA9uc/yWk93eZ9dwZzLMyCM6gQq2JUcw/kuF6KWQqu4Q9NLzGyqVau721U
         9AyKrmGiji/UuwNhMDrbUe2pRsrY2RH0v3hk7gzd6IQglWQNEVbDkYNO2NudEz5896Qe
         lq/q1Wet23wUww3DTfTq67WyJveNg6WSmV2Jnwf1DRkjbnIMq2DKPeWDRj2Kq3AL/y+B
         q2YgFCh6pvmDT/tPYcvWDO/zZdN/nNXgbQpGfO78hEm0s+7pWKZEQKPi/fXi9roonnEC
         EW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802638; x=1763407438;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFmkfkXaVUQbQzQgIBWtDhMvK7IUgEF1iDdcU6dO2Sg=;
        b=SVavKsGEdLneZFs3/kN04XTY3BwlXFrqJiGUL7Bn5yM2/1tRnDFzRN1RSBKPNakx1p
         q77vk9fdaSFs5kh2mYbjFK+5IWrqluQs+qTIuvAMCLA7pNP5wM/1OrXOf08Rnt9Ci4Rm
         0IEJ9jHpACfx4Mw0i8ufAjdch1gz1+IM8j4+Xbu7FPSmgA4p1c3FO8okOwOEhh8J9cgs
         bDatidLgZwvD6eK438suWw+i3SlF2lxnwFH7LNEmDEEQmhbxNnVJfMHeTCxX/C5v7iuB
         I6C0fKpXrJvE1crOqFgknhTGuwwZbjdUEFPxgGmKSMhnccSxCBpIx65REtrQohb0hnlY
         NuSw==
X-Forwarded-Encrypted: i=1; AJvYcCX/YrOthof+RxhX3xVpO8LG/8K9owUasiYI/r4N5aayejFCMHQ9R54u2unz3G1umcRfqXxTGsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdKf47h7H5Ya0yfNx5U+6hRBYH7sYcX6SWWQKxsz+YzvlIbBQ
	lt7EawML3RnDW1j2VsbAg4abJP6RznTcZ31QMD7C2HKvEYfH+j6JKTBflZ4LVhWR1NMAW3ZMQJd
	2EkOeuJgmpI5PvFb0armTANQoBSt3BNy8TDr8TSI7HebMvAWjtX6t1XW46Q==
X-Gm-Gg: ASbGncuWVVUHdE5B6MVD3mwo3HUxGj+TzETopmox2TVBjWUTcvDOSWBnQdFVEJG2iXg
	1PTkVkzuC9UD9I07/gyP43wV9/GQ2ETbMHYnyu9f9g8X8Y+HQL4lDkd9G+KLGs9q5hrbX3KDiEO
	GeoCdndbqjNA3v1UWHs+NVyzcgn1Bz1vhW3JBxJWG4iNIVYSdfI3+sZf+RXpZRey3YRiWTkXQGn
	+HZA844z12VsxvfsCjIPgKD4IK40mKtHzkjoUZe4xiOslfbl0yLjvkIe8caPwECRVSBKLf//jrJ
	9P9zIhia9URppB8DSroaA83D4z5JfxJpRNfqtYFZuCGT/c5ojX6ontLCo3zrzZM/SgWPOjaSZ/Q
	IWAqCTzorrYLvgBHjWBuUBKcNJ5CdEVG/tIlRPw==
X-Received: by 2002:a05:6000:651:b0:429:b525:6dc2 with SMTP id ffacd0b85a97d-42b2dbefc86mr7908397f8f.17.1762802638500;
        Mon, 10 Nov 2025 11:23:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK0p4ZVbPaMR6u3DJwr59ksa4Yn0ftjlHyu6Ldm6oYWj198VONDc1tIZaDJUusWs9Czg8v2Q==
X-Received: by 2002:a05:6000:651:b0:429:b525:6dc2 with SMTP id ffacd0b85a97d-42b2dbefc86mr7908365f8f.17.1762802637995;
        Mon, 10 Nov 2025 11:23:57 -0800 (PST)
Received: from [192.168.68.125] (bzq-79-177-148-50.red.bezeqint.net. [79.177.148.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b330f6899sm12270704f8f.21.2025.11.10.11.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 11:23:57 -0800 (PST)
Message-ID: <14706795-48fe-43d0-b9c8-53b3d1805c98@redhat.com>
Date: Mon, 10 Nov 2025 21:23:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ionic: add dma_wmb() before ringing TX
 doorbell
From: mohammad heib <mheib@redhat.com>
To: Brett Creeley <bcreeley@amd.com>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
 brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org
References: <20251031155203.203031-1-mheib@redhat.com>
 <176221980675.2281445.11881424128057121869.git-patchwork-notify@kernel.org>
 <78ea772b-bd14-4732-b685-c320ebcb5c55@amd.com>
 <CANQtZ2y5s2m-Gxeqs7-czeKBfGDgfGv+CX_MLL0s-J3JVdCqAg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANQtZ2y5s2m-Gxeqs7-czeKBfGDgfGv+CX_MLL0s-J3JVdCqAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brett,

I was looking at Documentation/memory-barriers.txt, specifically this 
example:

1928         if (desc->status != DEVICE_OWN) {
1929                 /* do not read data until we own descriptor */
1930                 dma_rmb();
1931
1932                 /* read/modify data */
1933                 read_data = desc->data;
1934                 desc->data = write_data;
1935
1936                 /* flush modifications before status update */
1937                 dma_wmb();
1938
1939                 /* assign ownership */
1940                 desc->status = DEVICE_OWN;
1941
1942                 /* Make descriptor status visible to the device 
followed by
1943                  * notify device of new descriptor
1944                  */
1945                 writel(DESC_NOTIFY, doorbell);
1946         }
1947
1948      The dma_rmb() allows us to guarantee that the device has 
released ownership
1949      before we read the data from the descriptor, and the dma_wmb() 
allows
1950      us to guarantee the data is written to the descriptor before 
the device
1951      can see it now has ownership.  The dma_mb() implies both a 
dma_rmb() and
1952      a dma_wmb().
1953


As described there, dma_wmb() guarantees that all descriptor writes are 
visible to the device before ownership (or notification) is handed over 
via the doorbell.

In our case, the original confusion came from the fact that 
ionic_tx_tcp_inner_pseudo_csum() was updating the SKB data after 
mapping, which indeed could require a DMA barrier to make sure those 
writes are visible.
After applying patch 2 from the same series, all data modifications now 
happen before the DMA mapping, so the descriptors and buffers are 
already consistent when the doorbell is written.

That’s why I added the barrier initially, to handle the case where the 
CPU might update memory visible to the device right before ringing the 
doorbell.
With the current order (after patch 2), the need for it is less clear, 
but the change is harmless and ensures correctness on weakly ordered 
architectures.

DMA ordering is not exactly my strongest area, so it’s possible that I 
added it out of caution rather than necessity. Sorry if that caused 
confusion

On 11/10/25 9:21 PM, Mohammad Heib wrote:
> Hi Brett,
> 
> I was looking at Documentation/memory-barriers.txt, specifically this 
> example:
> 
> 1928         if (desc->status != DEVICE_OWN) {
> 1929                 /* do not read data until we own descriptor */
> 1930                 dma_rmb();
> 1931
> 1932                 /* read/modify data */
> 1933                 read_data = desc->data;
> 1934                 desc->data = write_data;
> 1935
> 1936                 /* flush modifications before status update */
> 1937                 dma_wmb();
> 1938
> 1939                 /* assign ownership */
> 1940                 desc->status = DEVICE_OWN;
> 1941
> 1942                 /* Make descriptor status visible to the device 
> followed by
> 1943                  * notify device of new descriptor
> 1944                  */
> 1945                 writel(DESC_NOTIFY, doorbell);
> 1946         }
> 1947
> 1948      The dma_rmb() allows us to guarantee that the device has 
> released ownership
> 1949      before we read the data from the descriptor, and the dma_wmb() 
> allows
> 1950      us to guarantee the data is written to the descriptor before 
> the device
> 1951      can see it now has ownership.  The dma_mb() implies both a 
> dma_rmb() and
> 1952      a dma_wmb().
> 1953
> 
> 
> As described there, |dma_wmb()| guarantees that all descriptor writes 
> are visible to the device before ownership (or notification) is handed 
> over via the doorbell.
> 
> In our case, the original confusion came from the fact that | 
> ionic_tx_tcp_inner_pseudo_csum()| was updating the SKB data after 
> mapping, which indeed could require a DMA barrier to make sure those 
> writes are visible.
> After applying patch 2 from the same series, all data modifications now 
> happen before the DMA mapping, so the descriptors and buffers are 
> already consistent when the doorbell is written.
> 
> That’s why I added the barrier initially, to handle the case where the 
> CPU might update memory visible to the device right before ringing the 
> doorbell.
> With the current order (after patch 2), the need for it is less clear, 
> but the change is harmless and ensures correctness on weakly ordered 
> architectures.
> 
> DMA ordering is not exactly my strongest area, so it’s possible that I 
> added it out of caution rather than necessity. Sorry if that caused 
> confusion
> 
> 
> 
> On Mon, Nov 10, 2025 at 7:28 PM Brett Creeley <bcreeley@amd.com 
> <mailto:bcreeley@amd.com>> wrote:
> 
> 
> 
>     On 11/3/2025 5:30 PM, patchwork-bot+netdevbpf@kernel.org
>     <mailto:patchwork-bot%2Bnetdevbpf@kernel.org> wrote:
>      > Caution: This message originated from an External Source. Use
>     proper caution when opening attachments, clicking links, or responding.
>      >
>      >
>      > Hello:
>      >
>      > This series was applied to netdev/net.git (main)
>      > by Jakub Kicinski <kuba@kernel.org <mailto:kuba@kernel.org>>:
>      >
>      > On Fri, 31 Oct 2025 17:52:02 +0200 you wrote:
>      >> From: Mohammad Heib <mheib@redhat.com <mailto:mheib@redhat.com>>
>      >>
>      >> The TX path currently writes descriptors and then immediately
>     writes to
>      >> the MMIO doorbell register to notify the NIC.  On weakly ordered
>      >> architectures, descriptor writes may still be pending in CPU or DMA
>      >> write buffers when the doorbell is issued, leading to the device
>      >> fetching stale or incomplete descriptors.
> 
>     Apologies for the late response, but it's not clear to me why this is
>     necessary.
> 
>     In other vendors the "doorbell record" (dbr) is writing another
>     location
>     in system memory, not an mmio write. These cases do use a dma_wmb().
> 
>     Why isn't the writeq() sufficient in our case? According to
>     Documentation/memory-barriers.txt it seems like writeq() should be
>     sufficient.
> 
>     Thanks,
> 
>     Brett
>      >>
>      >> [...]
>      >
>      > Here is the summary with links:
>      >    - [net,1/2] net: ionic: add dma_wmb() before ringing TX doorbell
>      > https://git.kernel.org/netdev/net/c/d261f5b09c28 <https://
>     git.kernel.org/netdev/net/c/d261f5b09c28>
>      >    - [net,2/2] net: ionic: map SKB after pseudo-header checksum prep
>      > https://git.kernel.org/netdev/net/c/de0337d641bf <https://
>     git.kernel.org/netdev/net/c/de0337d641bf>
>      >
>      > You are awesome, thank you!
>      > --
>      > Deet-doot-dot, I am a bot.
>      > https://korg.docs.kernel.org/patchwork/pwbot.html <https://
>     korg.docs.kernel.org/patchwork/pwbot.html>
>      >
>      >
> 


