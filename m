Return-Path: <netdev+bounces-249405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B610DD17FED
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F79E3061635
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0263938B7AD;
	Tue, 13 Jan 2026 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIcheGNe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ooiqeq4C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43CC38A730
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299608; cv=none; b=jFfGz8x817PBR/HHDjEMNh4y8EnQ/hiyv9yElnS6GM4igb9g2/tz34vdlfENL3l3bTb0ofomUHug2ZYO7r/LnctgGV/16qMet3H4D1fpgKoJ1B/OuP9SYDirKWxZvwy2iX1ZJepARmWrAk+yTMcWnmKuMM1VMoAqhckKos1JJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299608; c=relaxed/simple;
	bh=qrJawEyRk9QiRfi3F12wRwzElwNErv3g2l29eOs+r0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhHkKbZ7U88iuTfHLw/2LE8+hcUe8oraMb8KAWLvbLUmsWR2F9+TQRaGCLCMoZ20u2eCPecahNNvriKTZt/SseOAi6KIeDVW+ikEhULQ52X/m9Tycj7BBNPpLT36/3cBJom15puYLfkxJrkJCgT4tSTjXkYp5lbh63NdA6WwFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIcheGNe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ooiqeq4C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768299605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bv1RPjaO9ZdZred2Z39o/pHiVJywyFuAbsRMKmfexlM=;
	b=HIcheGNe7k18hNS9kZhjl0ulo7Wm+W1t8ShqjQcofzTqFPNU4fuW/S3YXicuWwSiFqcwLr
	uGcyI+GcR9J8Y6SuUbE8ZoOJUbIObs2bkpN/QI4nAB3TmTRR2uOqmsdfMLddIT95+rcA95
	NkxLc9al15W+MOLub7mvhPOXcjXbh44=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-NC6UsOZzNrmBTsfERmjp9Q-1; Tue, 13 Jan 2026 05:20:04 -0500
X-MC-Unique: NC6UsOZzNrmBTsfERmjp9Q-1
X-Mimecast-MFC-AGG-ID: NC6UsOZzNrmBTsfERmjp9Q_1768299603
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-432db1a9589so1708632f8f.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 02:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768299603; x=1768904403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bv1RPjaO9ZdZred2Z39o/pHiVJywyFuAbsRMKmfexlM=;
        b=Ooiqeq4CDJAdeztIVeP08RIjonIFbu0Ix1QSuGAGLnpXxoa1G3zjRACEzvO2cO3ng5
         K2zLp5murkupoMQjsTkt9xyL+bugptxPbtuaxL0PmUm2MeHLsh6JpmYCJcD6ViHvQH8v
         P3Xjf6FBz8ZsWfwg3RlydqvAFLgF734ZChGJX/Rxjup6E0lD0YazXep9YNEvw+gEXxhB
         y0PYSiW7q1diBoV5bcyaw+WPI0/VuMzlg9av8Bske1sOljgBO+qV2wTVqNaE7l0+wop6
         BIE3XlsWPy2wCq73FGqRfy/zu5PLxZ441tO03GqAILwUpvnuVJdr777gVgEP+SxqdJ3w
         xkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768299603; x=1768904403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bv1RPjaO9ZdZred2Z39o/pHiVJywyFuAbsRMKmfexlM=;
        b=uyCApOqaZuqI2wNxwnV/Mc4TjDUwZk0dCW6pDojl4DLgVwIC2Mtfr0iTXrGUBWvQnI
         L6G5PGP++UkI/iGuN9YjHnaQ4rw+X104R7OGckA6WVUEdZZJrFC3RYzO3vBmBQRUip/E
         i/hUmme6YJlYE1iuG8nuwjaKsl+UmXqM4x48PbMY/qqwngrFchM+xUpiceFl7gbWsB/z
         2Q0V7ZMmfQufwSmkBb2XV4xBeGsyBPYy3UjDBbHuD0mcy0G0pZHqNGxW4dBitPd/xslI
         gmmtveRgnc+WTpwGEL540DL4j+svtcrlcIxs4KjcKWt+hkQdEptH9JRoknkyshfnChS8
         gZdA==
X-Forwarded-Encrypted: i=1; AJvYcCUqFrqjxtpjJI7mri+XHVE4WIwLuqzgxDwggODxsBorzSa/46H5WenyFVvB6vt09FljtXLzNWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGZUMIbUJK9Xb8+ZjditFacjshv2nQUYKabKwYYfAyQqsknmb
	/VxKaemHD0OI/RSzZ6dnWwyZHoWdWXvdbsOO3Yo0nj/LwxsO+A/zkEiDxIwzB2RodLe5PFdAr5y
	oSYZGyAHfpiJl6tqcy8T5rCzWkEo0q1K7ZAVDBLQEnh8DuZ/mSzIv32XX9Q==
X-Gm-Gg: AY/fxX6gQaGMYimimrE47EUyIZYt4sdykEEHUFBuNnYTz4cGRUZqQOvCbtbdzFsTQd7
	pxGWhbzX4eIYXxx0h9rFmlKm99XReL4Gup/bMpntRmTApExbzi3p05ngUsaMdVv8NTgYiVc2bgP
	Mht1FO2EcNYjy845MAYgyuEwIhtIYD79fRPTOWmZ/Qq4HwPmD/hwqnEiHUnfHXJ156xM7jednqQ
	XlN/9leyRN2jXfjb4bRbuHhSZmYz84b6L94aZOQAKppmW0uxtcbAX2ggZoPJA70O4xGfTLH7EFS
	1kZQF8imyHmZjbBvgDFZbr6iRSdErB9iSAJgrazmdfx/eGJq5v2nbFwPj+XU45jUC1czpbb0LSb
	np4vx+bu5oyJB
X-Received: by 2002:a05:6000:184d:b0:431:35a:4a97 with SMTP id ffacd0b85a97d-432c37c3600mr21248011f8f.59.1768299603293;
        Tue, 13 Jan 2026 02:20:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrath3hRlhdo9WrSLU/1jbO11BPh+MoIv4sHPe4d/wYiA0ReRHh6C563cNyJeTG7EVpok72g==
X-Received: by 2002:a05:6000:184d:b0:431:35a:4a97 with SMTP id ffacd0b85a97d-432c37c3600mr21247977f8f.59.1768299602857;
        Tue, 13 Jan 2026 02:20:02 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df96asm42541852f8f.28.2026.01.13.02.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:20:02 -0800 (PST)
Message-ID: <017b07c8-ed86-4ed1-9793-c150ded68097@redhat.com>
Date: Tue, 13 Jan 2026 11:19:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 5/9] eth: bnxt: store rx buffer size per queue
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
 <e01023029e10a8ff72b5d85cb15e7863b3613ff4.1767819709.git.asml.silence@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e01023029e10a8ff72b5d85cb15e7863b3613ff4.1767819709.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/26 12:28 PM, Pavel Begunkov wrote:
> @@ -4478,7 +4485,7 @@ static void bnxt_init_one_rx_agg_ring_rxbd(struct bnxt *bp,
>  	ring = &rxr->rx_agg_ring_struct;
>  	ring->fw_ring_id = INVALID_HW_RING_ID;
>  	if ((bp->flags & BNXT_FLAG_AGG_RINGS)) {
> -		type = ((u32)BNXT_RX_PAGE_SIZE << RX_BD_LEN_SHIFT) |
> +		type = ((u32)(u32)rxr->rx_page_size << RX_BD_LEN_SHIFT) |

Minor nit: duplicate cast above.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index f5f07a7e6b29..4c880a9fba92 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1107,6 +1107,7 @@ struct bnxt_rx_ring_info {
>  
>  	unsigned long		*rx_agg_bmap;
>  	u16			rx_agg_bmap_size;
> +	u16			rx_page_size;

Any special reason for using u16 above? AFAICS using u32 will not change
the struct size on 64 bit arches, and using u32 will likely yield better
code.

/P


