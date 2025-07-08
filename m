Return-Path: <netdev+bounces-205003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EBAAFCD8A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5D3C7B65D1
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325512DEA98;
	Tue,  8 Jul 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQBrHfQH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C021CFF7;
	Tue,  8 Jul 2025 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984807; cv=none; b=ISWftU5MWXno9twgfhvnymW9SKAiENCURsL6Yjwgo/fsDMlqS6vn2dWBR+jcXeBxxrsgMPjGSBb7jIp7KoM/SY/552T2n3eroBibKDEsaySsYD8FjLRHJ6EaU8rdwbWWGUNu+WqcXjOCpYsszW61AoZPw2DkFhfeVsg25jKR6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984807; c=relaxed/simple;
	bh=FnMJBbKPiDFO1AIn7dnhFfO7zlcFSBcjt9eAlqWtieI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=By4x28ThHl4zFJONwu6iN1Qi8pR7tMuAxRb9WQZXXe0j8gxM+RqOyrA+DQ2qvkZSwIkAA4NsCag3hLUbdHLXCrTJw0Y1xQY9pjMA4T8qhfE52AQpuMmYKy3WT9gQMPt2wdBNvlin92e8U4OA7s0uTV9TMPDg2uDVkrLL+YE/lPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQBrHfQH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso3601906b3a.2;
        Tue, 08 Jul 2025 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751984805; x=1752589605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+V/4hzINiNtnwUKYapOA6OBBGlFzgjmnEijOcNgHxw=;
        b=QQBrHfQHqBSWHp39XkCmf01SjbKtfCQuuUFq4CekN/LMU4rOPGI2yVa64cY74gp09K
         Xw0nqjl6XZfIO2/kAoYcROUKEbDf5kWL0C+E5uxEiMrFQDAmLijhtQIon1hOZGSmcged
         9ZPpMdpIqQJUuvjpgq8sR25cCkgZ0BHMoxsvI4tioZAZRh+mIVWQLBEk7LQfYYvSQYD4
         eBdPDp8D160Tl1VWUEFy07E6j13Oe8UZNsMiIKP9X8KHtMnQTWUXk+F/RbAWCZVuw5LM
         MBohSFNUcCEPF/pInpdjQqJPmWYeXHI2zm5O1MtHUUDlgOKgT4FUQPrZnioeuoTa+N9D
         6DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984805; x=1752589605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+V/4hzINiNtnwUKYapOA6OBBGlFzgjmnEijOcNgHxw=;
        b=gMoXfEEOuOWDGD58yUbtQ1g7RIx4iIYXI1MNSYVtJlucCbwLFO/dlMLhlde+cXcR0q
         zyMspsYlHBRbUoehVjAckz6XDN8zKCfYa3u5tEOoUI/PSw/7UOSPN/eyCzrkrL+qUx2l
         SydGoEUh+JRJIgSBsOY3EAtKqhhGFGzdn0FMZH54rg5cUiI/d/PHL6eRJiCJMqMYCdjb
         iTvoEYVQYqcE2V/9zfFKMMw7MVoHavVtZMs1hOeOk6oWs2OP8b8DASgG0XbLPxXJ8IZm
         /kiO/5HvflXBiPqcO2Juxb2a4SHg5lLfUULu0zPVJCJjJ1ykv8Xkupi/qZV9/Xv/TSvr
         8c5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEs9VmAu4tNfD3PiKC7K6kwR5InG+pOLfxXPHgvpYtyfbTz2mqNaD9yId5rK1gDPHrvrnXQPQiViEWVzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfjmIq+g8WKR0OekBhyZpbGxRCBFR0czyxOHyWLEVdV8PaSZTC
	qCCTZSmr3BavEiW/nRYGKgK66S9rhmKtrar1bbFSLuSenGIc+BsLwpYY
X-Gm-Gg: ASbGncvJnQrRw7FeIbq2MSXo/JF1goimQXHmlld3WOOPBO7cUzhhFV/GvD4kHZoQHXE
	ri7Rw71nJ0IdnRKDZ5Mz/n8G60fYvnxH1vv6bkmw9q9kzZqzdLw64zUGNqnsinjTKBG4XZF4gfv
	DuCLJrsJ6hvYvPtVl//4q4uLrH/+8wNpQS5f3EK/5PaFp2pf2Wbiq02jMuSJKhqRkLvDDNNfL2a
	9YLrd8uxIqK3WA4+tcQ0Vxq/cYYHJu+V388APpGMcdHML8/97+taBA6cIbtZqAE+bA6rWkylAC9
	G/3eO3VSBnoX7DeJMjkgWDrGPqZk39eDwquso92y9aXHQwKiZI1t97j3OMg9m0ny86vqafPWTMY
	AgmPoISIyVElO9WZsHSifKg4A9RE0f4Is6HkN8dHx
X-Google-Smtp-Source: AGHT+IGM8VTrVWuRijpvW/6zRn7zP7Y3/ODvDnK8T/rQZXTP+qzbmuc4pfDOBx/ywvZQREAbUs9kHQ==
X-Received: by 2002:a05:6a00:3c92:b0:73f:f623:55f8 with SMTP id d2e1a72fcca58-74ce88249b6mr19245771b3a.5.1751984804772;
        Tue, 08 Jul 2025 07:26:44 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a? ([2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce4299c3dsm11944325b3a.116.2025.07.08.07.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:26:44 -0700 (PDT)
Message-ID: <9fa577cf-0999-431c-bfc9-e7911601543c@gmail.com>
Date: Tue, 8 Jul 2025 21:26:36 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: fix received length check in big packets
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
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvCZ1D7k+=V-Ta9hXpdW4ofnbXfQ4JcADXabC13CA884A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/7/25 10:48, Jason Wang wrote:
> On Sun, Jul 6, 2025 at 10:12 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>> for big packets"), the allocated size for big packets is not
>> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
>> number of allocated frags for big packets is stored in
>> vi->big_packets_num_skbfrags. This commit fixes the received length
>> check corresponding to that change. The current incorrect check can lead
>> to NULL page pointer dereference in the below while loop when erroneous
>> length is received.
>>
>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 5d674eb9a0f2..ead1cd2fb8af 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   {
>>          struct sk_buff *skb;
>>          struct virtio_net_common_hdr *hdr;
>> -       unsigned int copy, hdr_len, hdr_padded_len;
>> +       unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>>          struct page *page_to_free = NULL;
>>          int tailroom, shinfo_size;
>>          char *p, *hdr_p, *buf;
>> @@ -887,12 +887,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>           * tries to receive more than is possible. This is usually
>>           * the case of a broken device.
>>           */
>> -       if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>> +       BUG_ON(offset >= PAGE_SIZE);
>> +       max_remaining_len = (unsigned int)PAGE_SIZE - offset;
>> +       max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
>> +       if (unlikely(len > max_remaining_len)) {
>>                  net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
>>                  dev_kfree_skb(skb);
>> +               give_pages(rq, page);
> Should this be an independent fix?

I've realized this is not needed. In receive_big(), if page_to_skb() 
returns NULL then give_pages() is called. I'll remove this in next version.

Thanks,
Quang Minh.

>
>>                  return NULL;
>>          }
>> -       BUG_ON(offset >= PAGE_SIZE);
>> +
>>          while (len) {
>>                  unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
>>                  skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
>> --
>> 2.43.0
>>
> Thanks
>


