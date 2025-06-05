Return-Path: <netdev+bounces-195229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E51ACEE44
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24ADC3AB2F4
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF45217719;
	Thu,  5 Jun 2025 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUJUQRaE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB380204098
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121392; cv=none; b=QrwuAnK7kSYBFSJ60qRv58suhd0PaxkPrDhYP4Y95oSE9DKX2yqRlyBhiMwwo7733Xyt5kLrqTT7A42XtrElaqqYeqI/ZkzYlZf91FVrBnNQJ5+BtFGQriHu8wAFp3aLJbv+DIsziPQ14/3JfgOAcuiA45qbhTn/xO8B5sKCLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121392; c=relaxed/simple;
	bh=5iVRkX4FSgcRxi/CvcNtolFKz6k8kFco9qX1fh/s/lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seYRyTx9kC6HlMBISkmiwEb0X75ACcJkXxv6kY9/AjGykNz8EGZ4wsNm5nVVBr5t+d7izewq0iOlU1jEHo8/eWXXTVdajIfbDVpLAqgbuz/AoaABRR4QuxsJC3av3W4C0RkK/QAfnEpn/beWNEfT/VzH2+RvktymMdlTCSQghHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUJUQRaE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749121389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/iNd4rCLMH3G4cLnw5oDzeODmTZrxz5jMOWbyZxDPY=;
	b=XUJUQRaEJTUdQYD2qx1MPkdyzhLQ9y8MjiHQrDqIWIlt+ww6FOYUbg8iOh/OVrJsha0heB
	SOkFWwpRMtzL0qiEIoTQXBr1H8nnnqc5+tKuqAjnF/vBwXl43QCBlzKd9c9QHSvqiVCpSw
	SAsU5iW83mlbl1fxzsQhBsdQNXWTD5s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-CpCyY4bbMMidbGYzlvi2Bg-1; Thu, 05 Jun 2025 07:03:08 -0400
X-MC-Unique: CpCyY4bbMMidbGYzlvi2Bg-1
X-Mimecast-MFC-AGG-ID: CpCyY4bbMMidbGYzlvi2Bg_1749121387
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f3796779so589345f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 04:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749121387; x=1749726187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/iNd4rCLMH3G4cLnw5oDzeODmTZrxz5jMOWbyZxDPY=;
        b=e2y7UYx23tPrnu9KD+Kdtte3kKXzhKJGkN2YZB5ZRl5yts5K7XPpZcN7UeuXyI2ltu
         mXTvWCqeDdshg1yV3xJOa2+SePxGVA3hbPBdv00jTFgwj1yEgs5GOtJri3gVX+qnmDFC
         bj1Qh59aAAhumls0S8QGCQgVSKRJuLT022Fb1/QcNsDOXyl7//0T6mhIgcFQF/JxO3zF
         1Zp+grx3tMVoImYduF1v3JEGXMYh8qSHyXgG7XOlb2e3lGxK7nbs3Ad8Ksitd0dk7hiM
         of5XoBUftP3tsvqLAskySfutYFn9x7R0TvrjXR/9NuxznwLd8QgY4W6JGjb5ueRDG64J
         npoA==
X-Forwarded-Encrypted: i=1; AJvYcCXaevFOwDrhpdlUG6sxJVLU5QyefyLkz5jkN52aoUZ0XEI5gCqJvhn9yNKckO9AFisK1zu9Svk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy8zJXRr4CiqO/78PSEogWtw6A4WSUSpog22120hJyhgaiMePK
	6szqYk++30X7n2G1FdA9xIGwdTEPxkbaHVjQYTLAwKyEmMgo8bu3HHy9x/PA+7f18MsZ3PmiXnA
	dxWG3nsQL8tMKth+HxCVy+C0eyuZ7RrUqXUe5VcfQHqYuCqDRPfFvLABwY+TYvZfCTQ==
X-Gm-Gg: ASbGncv4L0VRUcsSgvF6YOuwJ2ciEY5QSsBzbgA5++i1HOAhekdOfB6JhJmaYBVI1xo
	hmkIWF+pj5wmPNJ7n9bEYGqd7TA54B49l6nG5rsTV7c5vnSgaeupsb7MRdf6OLrLwP/UOh9zmE3
	Fq5YLw+AywkxhXzFRXitxllvONKT1cYnCEDgWEm5IR8RkpibPPOIB5fWXKgmUS8wv3dNVMYbmWe
	LlKRbXzl2SXOY/AhQfI3mU1V3YHE0jq8qBu57RGS42VsexAmFCqmIv6a52fH5ltV55i+BmDu8ko
	2JLNilHaQIQYinAWLxnuBDQK+B9b3g==
X-Received: by 2002:a05:6000:4387:b0:3a5:2949:6c24 with SMTP id ffacd0b85a97d-3a529496f56mr1757585f8f.51.1749121384455;
        Thu, 05 Jun 2025 04:03:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdGUXYZXrNIrCyhAh0tp1ScDeHW0FOJjHuHj6Po7K6huTF1gR9wGCaSTi+dFD3HnrC0pmIFw==
X-Received: by 2002:a05:6000:4387:b0:3a5:2949:6c24 with SMTP id ffacd0b85a97d-3a529496f56mr1757543f8f.51.1749121383960;
        Thu, 05 Jun 2025 04:03:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cced:ed10::f39? ([2a0d:3341:cced:ed10::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm20995275e9.23.2025.06.05.04.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 04:03:03 -0700 (PDT)
Message-ID: <dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
Date: Thu, 5 Jun 2025 13:03:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250603150613.83802-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 5:06 PM, Bui Quang Minh wrote:
> In virtio-net, we have not yet supported multi-buffer XDP packet in
> zerocopy mode when there is a binding XDP program. However, in that
> case, when receiving multi-buffer XDP packet, we skip the XDP program
> and return XDP_PASS. As a result, the packet is passed to normal network
> stack which is an incorrect behavior. 

Why? AFAICS the multi-buffer mode depends on features negotiation, which
is not controlled by the VM user.

Let's suppose the user wants to attach an XDP program to do some per
packet stats accounting. That suddenly would cause drop packets
depending on conditions not controlled by the (guest) user. It looks
wrong to me.

XDP_ABORTED looks like a better choice.

/P


