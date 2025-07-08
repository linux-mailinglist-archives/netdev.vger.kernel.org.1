Return-Path: <netdev+bounces-205006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A19AFCDB1
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FA418925FC
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115C322127E;
	Tue,  8 Jul 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwow6gqS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E22B2D7;
	Tue,  8 Jul 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985067; cv=none; b=biA7pUTSyzyRj0QlmB086Sf2/oRbtCaRHIRmKVRXqH+tQ6HxW4vb3htOiNdR+3YrbB7fXabqw5sGyPs1dvZHsrTJV8aDUL4zi1PVu2hT4umG+xvOgt3x2bs+lqt5epcADj+YLPdPwSO+m4H2ELgc1m6LPVqUPmG0lpjZzQRzmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985067; c=relaxed/simple;
	bh=OuHY8n2Odq3N7kvzxCgurj7dAhMVYiooBCIgediBTMY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eycjUB298YkZxWWqznLgMoVuL+1iLUysvRhiQM4B3kYAFkYStTODj3CFfVInH80mvFAKRMoWp6PJfSDCF9sAt0ZBV+JvZfT9EUwTOERX+X+x2yu0BLY/s69NeQZdSUVNwCf7LceVBgyvaMxBpnv9CuMFsy9hacw+3MmtzoBuN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwow6gqS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74b54cead6cso2875289b3a.1;
        Tue, 08 Jul 2025 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751985066; x=1752589866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BeYXPTb5LA7yVu+YZrMTInys/k5EZTTHl3niU3gqITo=;
        b=iwow6gqSRKJI12DHuBHBinkd9P5iviK2PxohJhTaE6nYz77NkTIOIV6MAJ5DlOKsXu
         ZmduLgcUVz7L+u0okgZfG4dSP1Ztgn03VApcixu8vS4j/eb36U9by30WUcpzb0RXfGmP
         GzXR3PrcXAGbjdhMU23A/rf/ybcKTsQmfON/6fY5Kj0bH0+uiG5U9wVX51npbyavzKBA
         /R+C99/EvaNDR04s1iseLtZL/Vg23+vuEZwpyz5NoeeJ3LHeuvNTrs/J8YL3R6t9lWdi
         5RBeBeVYJZnclwbf/X/i0DctgFGGZsiAT55UZ8aPo5TXdgaZlw5z/WJuNstfmbHZIZrd
         Lhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985066; x=1752589866;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeYXPTb5LA7yVu+YZrMTInys/k5EZTTHl3niU3gqITo=;
        b=qYntzS31bFg2ypfbb+GQ8OwSVs7ahSiGClycyYu4hCoZsfteSgjLHNS1AgkycDk8ap
         OCvg9t4i/1h9aAteC3ArjXzYx+ETNNoszAmGe9kS4XiUNUIrd7g7Ig4864oxrboyG7il
         tVywsMQ0wSogL5jbyY/VlGqjWIDsVK1S9BIRIA7BLAvxEs1IgTgcj8AMdDYH55/q0HbA
         G4bBwh660n5DyTGpMnYPM6fr/cEC4TeE599mmkcryDolWAIxyFrAhykgf16TFDqoZMmd
         r4W6ZpsXWoLNZ3ZQ8jtLL8f5WTG3D46pZvypQwOtS0xqZFIj1OX26Ds8odWOjPO0+yq5
         TQyg==
X-Forwarded-Encrypted: i=1; AJvYcCXBl0MPOIYWAvYY9iRbcT2SMSCejdkavARMN12WBY/07oS4OuDXVBjqEMsUjS8TG4HgbBOEgbqd7ImSVzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5lz6WtXG0R5XsUA4aR6DLicPXLqgzzqeDcz5I/jAU91DplKqK
	g0ymui86wL7qK1A8ibwNZ3/GkmeNN1woY9Qfxoq/ubjUQpw3zsAJJ3bT
X-Gm-Gg: ASbGnctQoAprC8qqDnOfKiM9k57nL1SbuuGs5pzWAB14ycUEdhoZMpTzzIducsYoQsc
	40YzWrzQQ2/cXdarToYaVbqreoCCWyWMvEqcsoe2AwIbGyw2po9umsqc95asLziuSJy1WZt+R/3
	6xtg29hvc+Aq2+dErqebDlsLNJCsf5zFMN2/l8lDelrw9cMuMpcs+Aty6wPH7E4XBRZeAygR+61
	ipW+Fw8H+WOSHzt6wYB9xlk7I5L3UrsmMrsQKUc2BtQP0RG8TcM4XY72+lF3bzxFOiAJRmWIwHJ
	Sh2pNO98HS8eA25GBruPTeI6fLQN+G6cy/OkgDNzSIl1gKzRpxzYhyX9QxG2mTCfIWqPtF3RMDx
	slFgho9++HqeBmKuQMsXqhVi38yB5kCLfhnlmWQU=
X-Google-Smtp-Source: AGHT+IGi9NKWi8E6Z/7yPngDFJ9kYl1XknUux47tkMEMvUexqOhrnZdk0a18FdQITKgVztDsHDC/LA==
X-Received: by 2002:a05:6a00:b89:b0:748:1bac:ad5f with SMTP id d2e1a72fcca58-74ce65a909fmr21643923b3a.12.1751985065387;
        Tue, 08 Jul 2025 07:31:05 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a? ([2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35d0014sm11883826b3a.67.2025.07.08.07.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:31:04 -0700 (PDT)
Message-ID: <a9e0138f-3d8a-4178-b765-869de8ab13b6@gmail.com>
Date: Tue, 8 Jul 2025 21:30:58 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: fix received length check in big packets
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250706141150.25344-1-minhquangbui99@gmail.com>
 <CACGkMEvCZ1D7k+=V-Ta9hXpdW4ofnbXfQ4JcADXabC13CA884A@mail.gmail.com>
 <9fa577cf-0999-431c-bfc9-e7911601543c@gmail.com>
Content-Language: en-US
In-Reply-To: <9fa577cf-0999-431c-bfc9-e7911601543c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/8/25 21:26, Bui Quang Minh wrote:
> On 7/7/25 10:48, Jason Wang wrote:
>> On Sun, Jul 6, 2025 at 10:12 PM Bui Quang Minh 
>> <minhquangbui99@gmail.com> wrote:
>>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>>> for big packets"), the allocated size for big packets is not
>>> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
>>> number of allocated frags for big packets is stored in
>>> vi->big_packets_num_skbfrags. This commit fixes the received length
>>> check corresponding to that change. The current incorrect check can 
>>> lead
>>> to NULL page pointer dereference in the below while loop when erroneous
>>> length is received.
>>>
>>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for 
>>> big packets")
>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>> ---
>>>   drivers/net/virtio_net.c | 10 +++++++---
>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index 5d674eb9a0f2..ead1cd2fb8af 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>   {
>>>          struct sk_buff *skb;
>>>          struct virtio_net_common_hdr *hdr;
>>> -       unsigned int copy, hdr_len, hdr_padded_len;
>>> +       unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>>>          struct page *page_to_free = NULL;
>>>          int tailroom, shinfo_size;
>>>          char *p, *hdr_p, *buf;
>>> @@ -887,12 +887,16 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>           * tries to receive more than is possible. This is usually
>>>           * the case of a broken device.
>>>           */
>>> -       if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>>> +       BUG_ON(offset >= PAGE_SIZE);
>>> +       max_remaining_len = (unsigned int)PAGE_SIZE - offset;
>>> +       max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
>>> +       if (unlikely(len > max_remaining_len)) {
>>>                  net_dbg_ratelimited("%s: too much data\n", 
>>> skb->dev->name);
>>>                  dev_kfree_skb(skb);
>>> +               give_pages(rq, page);
>> Should this be an independent fix?
>
> I've realized this is not needed. In receive_big(), if page_to_skb() 
> returns NULL then give_pages() is called. I'll remove this in next 
> version.

It's a wrong fix actually. Calling give_pages twice will create bug.

>
>>
>>>                  return NULL;
>>>          }
>>> -       BUG_ON(offset >= PAGE_SIZE);
>>> +
>>>          while (len) {
>>>                  unsigned int frag_size = min((unsigned)PAGE_SIZE - 
>>> offset, len);
>>>                  skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, 
>>> page, offset,
>>> -- 
>>> 2.43.0
>>>
>> Thanks
>>
>


