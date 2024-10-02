Return-Path: <netdev+bounces-131195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D7698D296
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5310CB20BFC
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813521EC012;
	Wed,  2 Oct 2024 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="p42o4svy"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203533D1;
	Wed,  2 Oct 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870139; cv=none; b=AZC4UhjEfv6x4DmdN9mWeVyDi64G49FqxdxPhG5kaNAqj6GoGqtYAQ1gjMYkw/t1Ns8BIYsLxRBYwzbPQ/R+KeVRjMbsS3mWf6agNvtJKPfanaIoW1/fwfXmVeMS/R00V1j+XTFQYr8VHIthUodbin6uh0mvhswFz30xkIpY7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870139; c=relaxed/simple;
	bh=trKtu00w560aRZ33sa2qLUIEv1TIrKjjUKl1Kf5aYs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGDJXPtxIq6ETT2YC9ItCA5R9SDk9IhNAVGcHtD2nIwXk6amefyttq7Vwpypk1jftj9nAW+85xZF20ZPto/CRaxUo4zxp74pAjXD1Y3l2AsPwAa3bxQHKbC60MK5mAx2Nelk47E1JPZ1FIeNQKMmB4z8Z8Gozw3qxJCFX02wA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=p42o4svy; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/S+gakIAqaeqjsBG/kejxdXC2oSDDBw94J7/fJzlQzA=; b=p42o4svyA+h9Iwo9dtlgvSivAA
	mbkNzrNY/AgpRhwobGi2pXOohHBFDZrWC2NEaSH2mPuubZRHtmw70zVrnxTYNDW8UNhwj7xK8k4TR
	6ik1Y34Rng2QSmZ2PAC1GpGUaueM73eoFEB/YETeyUjViCOlWD6deO/4dumfO7htw+jq5l1nimyzI
	t/DIwJPrZYQbdNpf2x7tSFec6iH3cvZ5fKWdmDR4B/p71u8l13YAbx5asxCh3LPRl4crSGtlsB7FS
	/iKR5M5GZbpSWEs3ErOaKyFfKXFu+PJlsZU8YXucqwgzbM5dv/gmZiXHURZVQfL0FOnzyUgSZpmqY
	PEZB2iYQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1svxx6-000Fli-I9; Wed, 02 Oct 2024 13:55:32 +0200
Received: from [178.197.249.44] (helo=[192.168.1.114])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1svxx5-000Brt-2e;
	Wed, 02 Oct 2024 13:55:31 +0200
Message-ID: <ff22de41-07a5-4d16-9453-183b0c6a2872@iogearbox.net>
Date: Wed, 2 Oct 2024 13:55:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix KMSAN infoleak, initialize unused data in
 pskb_expand_head
To: Eric Dumazet <edumazet@google.com>, Daniel Yang <danielyangkang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
References: <20241002053844.130553-1-danielyangkang@gmail.com>
 <CANn89i+y77-1skcxeq+OAeOVBDXhgZb75yZCq8+NBpHtZGySmw@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CANn89i+y77-1skcxeq+OAeOVBDXhgZb75yZCq8+NBpHtZGySmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27415/Wed Oct  2 10:52:29 2024)

On 10/2/24 9:27 AM, Eric Dumazet wrote:
> On Wed, Oct 2, 2024 at 7:39 AM Daniel Yang <danielyangkang@gmail.com> wrote:
>> pskb_expand_head doesn't initialize extra nhead bytes in header and
>> tail bytes, leading to KMSAN infoleak error. Fix by initializing data to
>> 0 with memset.
>>
>> Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
>> Tested-by: Daniel Yang <danielyangkang@gmail.com>
>> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> No no no.
>
> Please fix the root cause, instead of making slow all the users that
> got this right.
>
> Uninit was stored to memory at:
>   eth_header_parse+0xb8/0x110 net/ethernet/eth.c:204
>   dev_parse_header include/linux/netdevice.h:3158 [inline]
>   packet_rcv+0xefc/0x2050 net/packet/af_packet.c:2253
>   dev_queue_xmit_nit+0x114b/0x12a0 net/core/dev.c:2347
>   xmit_one net/core/dev.c:3584 [inline]
>   dev_hard_start_xmit+0x17d/0xa20 net/core/dev.c:3604
>   __dev_queue_xmit+0x3576/0x55e0 net/core/dev.c:4424
>   dev_queue_xmit include/linux/netdevice.h:3094 [inline]
>
>
> Sanity check [1] in __bpf_redirect_common() does not really help, if
> skb->len == 1 :/
>
> /* Verify that a link layer header is carried */
> if (unlikely(skb->mac_header >= skb->network_header || skb->len == 0)) {
>       kfree_skb(skb);
>       return -ERANGE;
> }
>
> These bugs keep showing up.
>
> [1]
>
> commit 114039b342014680911c35bd6b72624180fd669a
> Author: Stanislav Fomichev <sdf@fomichev.me>
> Date:   Mon Nov 21 10:03:39 2022 -0800
>
>      bpf: Move skb->len == 0 checks into __bpf_redirect
>
>      To avoid potentially breaking existing users.
>
>      Both mac/no-mac cases have to be amended; mac_header >= network_header
>      is not enough (verified with a new test, see next patch).
>
>      Fixes: fd1894224407 ("bpf: Don't redirect packets with invalid pkt_len")
>      Signed-off-by: Stanislav Fomichev <sdf@google.com>
>      Link: https://lore.kernel.org/r/20221121180340.1983627-1-sdf@google.com
>      Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>
> I sent an earlier patch, this went nowhere I am afraid.
>
> https://www.spinics.net/lists/netdev/msg982652.html
>
> Daniel, can you take a look and fix this in net/core/filter.c ?

Ack, I'll have it on my todo list. Thanks!

