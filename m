Return-Path: <netdev+bounces-249415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEF1D18235
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B85423017216
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FD4355046;
	Tue, 13 Jan 2026 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyXKhICb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275F31353B
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301211; cv=none; b=SUnYJFvGR1w3gfgavrBdvGiJde2YQaZW6n24DHjjdX0AIjHZ9r80+IrNgul9sr45IOAIUnKk3m9fnqga1GjMrfJmOtPROLQBcLpOVb18T9zH+FUx4xCS+saMV8dLsWpv8OLodPcQQKJkzI39hsWpG8E5d/J8LnIeDAntlvRTG34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301211; c=relaxed/simple;
	bh=fYO5mAVLp/077UFBDfQhXzmX4QvLaBG8lItV9IMLT1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXZVHUkQGQhgBAhhx0xiLaG2qesd1Dc2ygeA0uOq3JQFWR6eWzgU2pyZivloCnHelGPu7nVbRsN01u8igXnQwWcnkdrRpDxFPCxj2HtWybXOo4xUxkT2o/F1XciZ4wbhbI2EO0h5dIa4VQCt7DhmEbR8BJKcL2t1SwKQS0d5S6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyXKhICb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso52022615e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768301208; x=1768906008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKsf3wgw23/pKBp3MaibLO9IrAlpfXga+vfr5Wqb9rU=;
        b=JyXKhICbCoxP4aQeGECr8h7juVZdqeUZtCsHAACCmLhkJ9aLM2y+NZoqn0eL6f2r3p
         df1b+F6B3uSBXVjDOcz1Kfj214xWYIx6H86DQ8Hhw2Jsy0M9YtKzEPV4I38I2mepytQK
         gJMn8zeE1OsZq/HVlUCIgeN7c+MfTZrNgS7tU31PtvArPKl1NHElPMD7DxmnpzaGsh2B
         A3GWLEXLZBWrE6Cv4aHV+x/aJH10eZC5W0xW8otpiUj/05wiQmP/v2mvWfxcSv7+7XKO
         ZoVHNExc1emjviKYf8v4WMXDIgCEzv5EJN2y16SK4KXQ8BX9sz05qYbghCzMzMoY4wmX
         xI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768301208; x=1768906008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKsf3wgw23/pKBp3MaibLO9IrAlpfXga+vfr5Wqb9rU=;
        b=dUB7l7aEp0a9bQrhpRAPrbK0muGpAtbppBay1aJj2QbcfK4po5WbQ1ow83xIj+TX7j
         n7JRa9z1KCexj81G9QoMFB1iD9Amcrda9AtzguGS+G3GOuKbPJxhV/wn3cvIYXpqrVKv
         6qCHdu0ofy3Nb6TbHKXgcqWKkzYFZCj32jnyIczT993QvGXsml8pohY0lTKTU95reyUK
         pMpOxLX06BP+d9BSbpz018/ilD+1+ZZBLRcAJ98USbkzKL86w3ZInkIGBXK9FVxDxYZd
         74O2nPBUxtu6gMti8pnA2rgUKzPsBBFFjrk7ASooPZPXaOZJmQI8d29PabtPFAgkT+dI
         P4kg==
X-Forwarded-Encrypted: i=1; AJvYcCUyiH8YiledrBj+PyKQmI9L2vkkXh3KIddlzCPAugS9Hub3rwXlHQFMn1IeGqT/wKP+jcfBaK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jMVvv4R71AmoxrE5cmnibfH7JApdYXdzRnUA5CDpnhGsoV++
	Z4StWHVrWRZocQZQEgmP53alhcOJ2V5wrehzpzxqGzoRdSK3rM6gkukD
X-Gm-Gg: AY/fxX5Ltuk38EX+PNPUfUaLoOeA05+75UZZyP7+l3sxODzv6FjobAVjZ07IKBieWfT
	T5z1COlTo3tEX4Vr9188YeJe/13fhtpKJtmlPcGPoDl6zpQxzBNc1FE36mJqmTt+Dnk7YJgtLD0
	m99dBkFmP21dtykjjDiB2FjQfNZYmZ4IekWj4H4wmVtxO8CNcjCQBBuv/uCrTHcAJl4f+pvKTvF
	G11GUJiVz6YX/wbVDiFOC3GIPZgsPjBF5WJ7Fdr+nbGorAJVj6ZLhkVjXDGrwcE1EU8v2ALHeC7
	4wlz+njMI1iJls9khnvqhhsTXSZJz+VTRAkTxy0jMdBZnCPjUEzLuUHNMSF4Qj6Xe8rX/Zqyq+b
	ltJ0XfC9NVNhcEFxKOdJZ2xHGA8FQ1nEJdQxLdeURqAaOv/tz49z/1gXXD7zjfSkA0a8JmMZexJ
	KDWO+PBDPyGVTCYuzpA4AWiqqrJ6cZ0912THmp8nlr05JWfqV+Ie3zWB3vt1bvF0TusQeDydwLO
	MNOfPDDQ6zzGF7fJQULycyMSy0/qlP+2Km7J6y4HQ0Cttmn00o1ritQExZBiqaueg==
X-Google-Smtp-Source: AGHT+IEymhtJvsVvq7h/MiDqH9B3Tq4aNk4c91QeNppt4FR+JHUA9Tffj05tYCrsjh9jqUJvxHBGZw==
X-Received: by 2002:a05:600c:3152:b0:47d:403c:e5a0 with SMTP id 5b1f17b1804b1-47d84b184abmr250841245e9.12.1768301207472;
        Tue, 13 Jan 2026 02:46:47 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f65d9f0sm409975245e9.12.2026.01.13.02.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:46:46 -0800 (PST)
Message-ID: <da02d2af-ba34-4646-b56b-bcb9631cb286@gmail.com>
Date: Tue, 13 Jan 2026 10:46:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 5/9] eth: bnxt: store rx buffer size per queue
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
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
 <e01023029e10a8ff72b5d85cb15e7863b3613ff4.1767819709.git.asml.silence@gmail.com>
 <017b07c8-ed86-4ed1-9793-c150ded68097@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <017b07c8-ed86-4ed1-9793-c150ded68097@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/26 10:19, Paolo Abeni wrote:
> On 1/9/26 12:28 PM, Pavel Begunkov wrote:
>> @@ -4478,7 +4485,7 @@ static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
>>   	ring = &rxr->rx_agg_ring_struct;
>>   	ring->fw_ring_id = INVALID_HW_RING_ID;
>>   	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
>> -		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
>> +		type = ((u32)(u32)rxr->rx_page_size << RX_BD_LEN_SHIFT) |
> 
> Minor nit: duplicate cast above.

oops, missed that, thanks

> 
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> index f5f07a7e6b29..4c880a9fba92 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>> @@ -1107,6 +1107,7 @@ struct bnxt_rx_ring_info {
>>   
>>   	unsigned long		*rx_agg_bmap;
>>   	u16			rx_agg_bmap_size;
>> +	u16			rx_page_size;
> 
> Any special reason for using u16 above? AFAICS using u32 will not change
> the struct size on 64 bit arches, and using u32 will likely yield better
> code.

IIRC bnxt doesn't support more than 2^16-1, but it doesn't really
matter, I can convert it to u32.

-- 
Pavel Begunkov


