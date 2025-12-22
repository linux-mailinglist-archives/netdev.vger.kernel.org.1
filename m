Return-Path: <netdev+bounces-245771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A53CD73E0
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 23:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF463013963
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 22:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCDB266EE9;
	Mon, 22 Dec 2025 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RX8rGQVt"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DC1DE4E1
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766441352; cv=none; b=ud9vecWbkJo4YrarUzhLQJ6TCub1SRjW1bA8dth3Lp9fZu88PX0f2sHD42oS6GN64kamEw+d/40c0kbMI8+Dv1jxbuZdUpvbC09mra0wKl6Qq6FnjzQyXlkCt83mli9NOpxtcFAHmoA963BXdGjdtI9DKIcT6MnsobzWqVD5mgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766441352; c=relaxed/simple;
	bh=n6NsL7t0E3hr021rvI2bJe4MeW/7173JoX6PaUB0znk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf5Lqg75CwW/1MlZUNb5io4pnIPoRkppaga2KjZ5+cBVFf5KRhCxTldBirYTiQogwMlBeMQ7gsVT1JGJabQIwXG408D29KSHRv6N/PDO8D/j5/vQUdpJwaj7cydI7/O5OBjQt6fxQJGufGaxlOyc6Kd/ZoZMsHNgEcE3iesD0wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RX8rGQVt; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c2c9959f-8df0-4a78-8064-733a643351fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766441341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/AjJKHwpoDaNbpB2cbwNJpKLjkrT12IVah9PmKAFJU=;
	b=RX8rGQVt9Uu9K/3SZxok6J9rR0zdjJSuFAr8mvYy4nieamnCc71IW75ZkonxC3pGs2bwfH
	kjJkZQp3/K/NKUkKkCuaxXDD2fDfFl6BrIifYYEH1j1o0Ugqbca4aBy7/8SZenmKnwrXIg
	oFAPvwkQlRoBnpHvWLW4WXySt1i5coU=
Date: Mon, 22 Dec 2025 22:08:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC net 1/5] arp: discard sha bcast/null (bcast ARP
 poison)
To: Marc Sune <marcdevel@gmail.com>
Cc: kuba@kernel.org, willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 netdev@vger.kernel.org, dborkman@kernel.org
References: <cover.1766349632.git.marcdevel@gmail.com>
 <99815e3b40dccf5971b7e9e0edb18c8df11af403.1766349632.git.marcdevel@gmail.com>
 <4ab8135d-75b8-4aa0-b5ce-f917e4a34e18@linux.dev>
 <CA+3n-TrGSs-rPswMmCaUjYnM=f1APBWtmAguMUaAOvwuKm30+Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CA+3n-TrGSs-rPswMmCaUjYnM=f1APBWtmAguMUaAOvwuKm30+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 22/12/2025 21:37, Marc Sune wrote:
> Missatge de Vadim Fedorenko <vadim.fedorenko@linux.dev> del dia dl.,
> 22 de des. 2025 a les 10:47:
>>
>> On 21/12/2025 21:19, Marc SuÃ±Ã© wrote:
>>>
>>>    /*
>>> + *   For Ethernet devices, Broadcast/Multicast and zero MAC addresses should
>>> + *   never be announced and accepted as sender HW address (prevent BCAST MAC
>>> + *   and NULL ARP poisoning attack).
>>> + */
>>> +     if (dev->addr_len == ETH_ALEN &&
>>
>> dev_type == ARPHRD_ETHER ?
> 
> This is discussed in the cover letter, comments section d). I would
> think more dev_types than that need to check this, at least:
> 
> +       case ARPHRD_ETHER:
> +       case ARPHRD_EETHER:
> +       case ARPHRD_FDDI:
> +       case ARPHRD_IEEE802:
> +       case ARPHRD_IEEE80211:
> 
> but as said, I _think_ it's sufficient to check for HW addrlen == ETH_ALEN.

ARPHRD_EETHER and ARPHRD_IEEE80211 are not really used in the kernel.
For other 3 we already have such case a bit earlier in arp_process(),
it's fine to be aligned with the existing code.

> 
>>
>>
>>> +         (is_broadcast_ether_addr(sha) || is_zero_ether_addr(sha)))
>>
>> RFC says that neither broadcast, nor multicast must be believed. You
>> check for broadcast only. The better check would be:
>>
>> !is_unicast_ether_addr(sha)
> 
> This is discussed in the cover letter, comments section b). In short,
> some NLBs announce MCAST MAC addresses.
> 
> Mind the context there, but I think it's safe. This is applicable to
> ARP and NDP, so I would suggest to follow up there.
> 
> Btw, the is_zero_ether_addr(addr) check is still needed.
> is_unicast_ether_addr(addr) is implemented as
> !is_multicast_ether_addr(addr), and the NULL mac (00:00:00:00:00:00)
> doesn't have the "MCAST bit" set to 1.

Yeah, "!is_valid_ether_addr(sha)" is better in this case.

> 
>>
>>> +             goto out_free_skb;
>>> +
>>> + /*
>>>     *     Special case: We must set Frame Relay source Q.922 address
>>>     */
>>>        if (dev_type == ARPHRD_DLCI)
>>


