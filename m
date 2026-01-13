Return-Path: <netdev+bounces-249412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74609D181B4
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C23E3005F34
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C330F949;
	Tue, 13 Jan 2026 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJnvgGen";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXjzljLa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE712DCBF8
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300906; cv=none; b=KdfVBRRoAAkV3+duByHMH28mSNHp9noGL0ZyEpSqaV8JrZZwzE/mFusr2QLWQ6MxWCvmtx2SMm0pRTaeN1OpaWekfyp9Wvj+O39/rSB10b7xq3VtEfwJ29yDzZUk4rkWTC1Xl8ngVh/o+fiyate0KgrC8g9LKOLSbe5vdkfNP+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300906; c=relaxed/simple;
	bh=6rphP0XeUY1TRejd2aNPhK+QTTqnj0/IWJtxgLJQFlY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kBK5I3lW6Tt7sRxx8IZrNNdVKbQtHklY/WEjqzWadnYn08JJ65s+taRPtxxrST3qH53q3sYhmhLx6gSCHo2RLAv3TAsoasFWl6qxOkwgMiVluBfBRE9dIyPftmh464zZfphzWVVxY9e6tR8w2gDqbl0d6TsNzgxzA7dop6Wuvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJnvgGen; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXjzljLa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768300904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0UJyxAD7OV1Vlm9xAqwyNi0f+c77Epf12aV/zNPFd8=;
	b=PJnvgGenfsCv7t5Bdr3VWROi3sZ/hYfl1gijxLuSjZTAYuhbXOx9tPTDfGwOHPTai3+tgK
	9gz8G8eU7VBzldAnD1lErLpDWCaUb90QhDtJFQVlHOM7rTyOAG2tZ5qJ/TWNLrEPCvmnmI
	ozPxlaOvQ4SMKPptlbIrQ+qyJKIQ3zA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-VQlSYJ0lOkCgx4Hs4oeSPg-1; Tue, 13 Jan 2026 05:41:33 -0500
X-MC-Unique: VQlSYJ0lOkCgx4Hs4oeSPg-1
X-Mimecast-MFC-AGG-ID: VQlSYJ0lOkCgx4Hs4oeSPg_1768300892
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d3ba3a49cso68293315e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 02:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768300892; x=1768905692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S0UJyxAD7OV1Vlm9xAqwyNi0f+c77Epf12aV/zNPFd8=;
        b=MXjzljLa7elUnoRzn0CoAuENKKL7+rkFSYz3pNVLDoVAhVOvcjNiZtPElWhwD7kXbq
         qqw1wK7DLG3xP+IHUEoeKSvBbXw/xjF1X5a7bsQ3+FaJBe7nrHprzbxWKsEJEVKo6q6/
         QasZpeKDDAsO2NzG21ebv3pCuprozp1/3E0UNsnhdDgRPAp68yooZ9OudB3vHOydBY26
         Y8rHifgm7wMMhLVXDZ/srSFr6Djv6D81wpNO0ZVk6qOwWwyQQa8WK7HMuDb24yfQyIcO
         WFpxnnQNPAuZ0vfEbhdoBGgiEDEhXueJsHEembd3aqyOkXcAJ6iHvBvNooKN81HAQlN8
         pyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300892; x=1768905692;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0UJyxAD7OV1Vlm9xAqwyNi0f+c77Epf12aV/zNPFd8=;
        b=MlfNwCxBJclVLVv6KsVufO4HbbYEK5b8ADbpF1i0eU3MBhm39JrJwTpZ85+Q8CEcg3
         2E/0UNaFWqHhpsAQFxiZsAhNxkmxoO69r+5h30L9DAdBk2VnVaJJx9nZkGGtHM3d2gr5
         UEXXbfFRW2JC7EerTD/P//511iGxrawkeK2tt2ISH0OpdmRccsBsk9Yzc7GI++lfl56p
         IKdpYHpL7TwOhk2mARcW6esOIlBmt/gcBkeaJt4saiLQhlJrD1Vn5JCyV4DIvnCXa8Ei
         a8HRPy/VGCPHGtz8pPbCoy95pk917Z27vfqd6NsyHw1nnp5DWcveO5YtB5mNB34h17lI
         Bkcg==
X-Forwarded-Encrypted: i=1; AJvYcCWdiAWctchL39CA09NQPj/CNwnJtxn1WNRNNmUrfGSXZLHoQq0xUcGaFo1a2/egNy0LTn5eRo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQrsxs39Z1yhDi/CvA/qVtrLj1sROnuo44JhA6SR4DrJJhdLbP
	Ozi9gVIEHEj7/26758Lm09RLG/RtcZTrmNhfkyIOIULN2FqOXkkTQ/SEd9/QO+TTETJY9F7LoDP
	kGeta+KuJnUJWuVaG+YQkd42FVrhL/aPI/1fNnFoF1f9I62yeuWnApeGOUg==
X-Gm-Gg: AY/fxX6HT3lzs6yZAMDYiavnFA3wv47TKfbuqdFLyZ86aqBQfLzS2OP/LbaZmh9fJWI
	62ZsV2nm9wKCXADWBWj8gfCEcW4mxXg8uqsVi07CSsrrTATN1Wi+EKHPaGAy1980TKhHn9Nx/Jg
	PuD4MYInIvnzZ2/+0ZMTQg8YGNyYMckrWFcu+6qP+GaZAxjfAFe0EylUBrebk9ll58JAkO39PaT
	DgAN2qQGy7wqeS53gtAaijcqHNl84t5bEGDRZ81iQLjWoDdbnDncLATpQZGsRqHNGpp07TN+4Vq
	Xx/kKMmSMJing23TxYyT/IyhznEBedzdmNh3yDKDHgc04QQc4IOagBS01dcYosNhrEb6u//muQZ
	dEXMoV9Dx15Wk
X-Received: by 2002:a05:600c:a16:b0:47b:de05:aa28 with SMTP id 5b1f17b1804b1-47d84b0aadcmr200306755e9.2.1768300892146;
        Tue, 13 Jan 2026 02:41:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyA6GIRnSDRUL9ab020nIrIsOT+mtQP2pIuI9imx0C1in3fLtYCcDSBcqt+RulymIY1xRsYA==
X-Received: by 2002:a05:600c:a16:b0:47b:de05:aa28 with SMTP id 5b1f17b1804b1-47d84b0aadcmr200306215e9.2.1768300891731;
        Tue, 13 Jan 2026 02:41:31 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47edfd5cfd5sm4882345e9.8.2026.01.13.02.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:41:31 -0800 (PST)
Message-ID: <0eab9112-eedf-4425-9ce9-be0a59191d8d@redhat.com>
Date: Tue, 13 Jan 2026 11:41:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 6/9] eth: bnxt: adjust the fill level of agg
 queues with larger buffers
From: Paolo Abeni <pabeni@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Ziwei Xiao <ziweixiao@google.com>,
 John Fraker <jfraker@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Joe Damato <joe@dama.to>,
 Mina Almasry <almasrymina@google.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, David Wei
 <dw@davidwei.uk>, Yue Haibing <yuehaibing@huawei.com>,
 Haiyue Wang <haiyuewa@163.com>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dtatulea@nvidia.com,
 io-uring@vger.kernel.org
References: <cover.1767819709.git.asml.silence@gmail.com>
 <8b6486d8a498875c4157f28171b5b0d26593c3d8.1767819709.git.asml.silence@gmail.com>
 <4db44c27-4654-46f9-be41-93bcf06302b2@redhat.com>
Content-Language: en-US
In-Reply-To: <4db44c27-4654-46f9-be41-93bcf06302b2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 11:27 AM, Paolo Abeni wrote:
> On 1/9/26 12:28 PM, Pavel Begunkov wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>>
>> The driver tries to provision more agg buffers than header buffers
>> since multiple agg segments can reuse the same header. The calculation
>> / heuristic tries to provide enough pages for 65k of data for each header
>> (or 4 frags per header if the result is too big). This calculation is
>> currently global to the adapter. If we increase the buffer sizes 8x
>> we don't want 8x the amount of memory sitting on the rings.
>> Luckily we don't have to fill the rings completely, adjust
>> the fill level dynamically in case particular queue has buffers
>> larger than the global size.
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> [pavel: rebase on top of agg_size_fac, assert agg_size_fac]
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 28 +++++++++++++++++++----
>>  1 file changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index 8f42885a7c86..137e348d2b9c 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -3816,16 +3816,34 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
>>  	}
>>  }
>>  
>> +static int bnxt_rx_agg_ring_fill_level(struct bnxt *bp,
>> +				       struct bnxt_rx_ring_info *rxr)
>> +{
>> +	/* User may have chosen larger than default rx_page_size,
>> +	 * we keep the ring sizes uniform and also want uniform amount
>> +	 * of bytes consumed per ring, so cap how much of the rings we fill.
>> +	 */
>> +	int fill_level = bp->rx_agg_ring_size;
>> +
>> +	if (rxr->rx_page_size > BNXT_RX_PAGE_SIZE)
>> +		fill_level /= rxr->rx_page_size / BNXT_RX_PAGE_SIZE;
> 
> According to the check in bnxt_alloc_rx_page_pool() it's theoretically
> possible for `rxr->rx_page_size / BNXT_RX_PAGE_SIZE` being zero. If so
> the above would crash.
> 
> Side note: this looks like something AI review could/should catch. The
> fact it didn't makes me think I'm missing something...

I see the next patch rejects too small `rx_page_size` values; so
possibly the better option is to drop the confusing check in
bnxt_alloc_rx_page_pool().

/P


