Return-Path: <netdev+bounces-244764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B93FCBE3D0
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86577301BCD8
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E0533B97B;
	Mon, 15 Dec 2025 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHt7Cyu7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Km5bXhrt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3631B4F09
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808138; cv=none; b=th4kGfaDrwjOD+SmNxWNte+8IdHtSYkTtIJAVAHhhwklk2QoKipiUDuMuFO3biha4ot+acKzNPoPncQ1/v7E9Wf10y4Ghz7zSOQ5mBo2JN+QIVCjJ2+q6W5sW0ZlxAQFOzIIYNQBeL/9PIoSBmvgS5ADePl1XuJz34AwWQKIq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808138; c=relaxed/simple;
	bh=XCaTRYYtdjBnDMmtW6LMz2eDeLZgPQs0Zj1KdxrUzfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLXnQtdj05sa/BJ0DCuwAxdDGvaevCqFZTkmzaOmoqyIDQQjsPlVo+hwOPniX+wWwTJho/1dO5EL2sQQv/YxltElXC+nV1rrU9KxdmrrCWl6/HGybD40IPNwQ1a/Lgz7tJ1kAvfh+si7g7QB3oxIGzHko+WgNBfl43Bfmez1NIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHt7Cyu7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Km5bXhrt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765808135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L49NIO1n5q1751W/k8gzxOpfDxRxrpcTIrbILgaPsTg=;
	b=ZHt7Cyu7nCClh7wd/fjjaeRWmFPmsqrZqQFbYOc8RedXqvMaljrTGRqT+If2sBUMqXk/0H
	sfaM/1+XribY+BWDU0szNtvMxrXN5ryqvy66Am5Gq1LKo9gIfYsKCNCwFcNP8qpqBGfWFm
	DBWdaXOUzdm6MsyAuOGfyKldHhDUGqc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-NDC6vvCsNGSDbXN0INnfSw-1; Mon, 15 Dec 2025 09:15:33 -0500
X-MC-Unique: NDC6vvCsNGSDbXN0INnfSw-1
X-Mimecast-MFC-AGG-ID: NDC6vvCsNGSDbXN0INnfSw_1765808132
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477964c22e0so24534955e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 06:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765808132; x=1766412932; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L49NIO1n5q1751W/k8gzxOpfDxRxrpcTIrbILgaPsTg=;
        b=Km5bXhrtdN2KikWd5IIL/6aCY0asNiWVxdAlBBlZjrJb2H2uFyl9cjXpr7SIT1H6aN
         kiVx7sThAasJcTGofSio393QL5u5TRIweCFugqMDVqMltC2m45BDMLKFlA7JUodU2JKJ
         DNhNXMf1K9BAfTl4C8BrBQ4OdC0E1Ww0ye/vm0tJOLzgb0cM9DsYupvh3DX10ACJBkoy
         VbZLSci7zcab5NE0LIsojyBPYlYOWXic1mTSDup4k/BCI7Laz2ijBKOYl5gsSPE6XcmV
         oTJ4yRJXoQhcJN/Kq47oRp6Rjr65n4gsTKJLX/65ugJtOVCPtPb6VkmeKC4F+cvmCtBX
         pV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808132; x=1766412932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L49NIO1n5q1751W/k8gzxOpfDxRxrpcTIrbILgaPsTg=;
        b=SgVQcQmsZ67qnb1Qlc4BjZdvHbGJKVqG2qlFuM4ITfMYsm3oarnwmHpyOzQtgnsKkx
         1jd6IiIjHqf1lLPKtL5XbGSCEoG4+Mh5KKk/yAg6Jg+0rwQ+vA/sGNLiQ9WNPupITOP4
         FTW8WnBSQ6k9ImKRD/36jodju4hDuGLis4Y1rDoOExs3wYzoWU6I9pi0/djIVvPhsKDL
         yibz3Bd5SFNMDow85BF5VSznaRUoAdDD5aTFNR0SIx5jKGgZV4kh80KdwQczf//78Jox
         MwsbxE32mX1LEzrWmxRTSj0tB8i7iRHB4tGbWpmb8V1RomwE5LcNRqdtktZZk3ZuQ5qd
         Gjhg==
X-Forwarded-Encrypted: i=1; AJvYcCV9iHMOy07yx8mwaEHNNUsphrgPaGm5NZenpcBS99CYhtmRZXlSlzQEbOCGR/aJu3pdNBjSRFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rDqj9M7e/JTjZQatce6JTsYpLn1CQ63dJKv20Lfg/fXKdW4l
	G5x6N9+AHSpW6/wnK5YaiOQpBXLaCucUgKyAzJruwQ3YL4t7tlWX5oWg6MX6K8B2DymSt1OqNNv
	e7XUaYkC1FZMpwK2wee3R0J9oiE9MDfwpipo2f8tLEdt3gR4oNGKzMML3IQ==
X-Gm-Gg: AY/fxX6Mno9TFcIyh7R6OPp7AZRyuRjrLXSxgdnedY6AaCa85mUy+XVkNWEqNCv0C6D
	DbmbUNvJ6qUJZTnxsd80n1NDxnERZk8qEkDCOUnKJu9pc+JY6Hj1oQkIYFnMyV5MJfeMgSQ4sLN
	hYs6jqXPYtXWK//meUBA5R2d1O7M2ctvj96cNhAu/1BknBzi+PqN2fXDMjan4mu/M+rWIVRDMBu
	3hKF9/8Lx9diHCPJK1NRHkIT+zUx4NHe4Km6F0cu4HPrPBJ6ntuBIYXnheK5uIiMvHu48rUcKEm
	9YGfszrIg7yBtP/OJBVCcjOsj09Y/9rbEE8jJ4ukB9LBo4KGRa+XkFI5Z/eLlnI3Vp/Qy1GBAT+
	aIPyCyJMK1W+e3lKE
X-Received: by 2002:a05:600c:c0d2:10b0:477:9cec:c83e with SMTP id 5b1f17b1804b1-47a89d9c2f9mr119399545e9.1.1765808132062;
        Mon, 15 Dec 2025 06:15:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnn39+IGc8T4gbIMiapFrAkLpdN3U9Oa1ixlw3v9TO5MUF+UqsPDl1fUxMRulxmuHP3h3NgA==
X-Received: by 2002:a05:600c:c0d2:10b0:477:9cec:c83e with SMTP id 5b1f17b1804b1-47a89d9c2f9mr119399175e9.1.1765808131556;
        Mon, 15 Dec 2025 06:15:31 -0800 (PST)
Received: from sgarzare-redhat ([193.207.203.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f8e90f2sm186130175e9.13.2025.12.15.06.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:15:30 -0800 (PST)
Date: Mon, 15 Dec 2025 15:15:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
Message-ID: <wssxyvbgq3a3icydzxsbj5bliqd67xreffaqqusfia2suxrjdk@gcke3jemvycx>
References: <20251211125104.375020-1-mlbnkm1@gmail.com>
 <20251211080251-mutt-send-email-mst@kernel.org>
 <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi>
 <CAMKc4jDpMsk1TtSN-GPLM1M_qp_jpoE1XL1g5qXRUiB-M0BPgQ@mail.gmail.com>
 <CAGxU2F7WOLs7bDJao-7Qd=GOqj_tOmS+EptviMphGqSrgsadqg@mail.gmail.com>
 <CAMKc4jDLdcGsL5_d+4CP6n-57s-R0vzrX2M7Ni=1GeCB1cxVYA@mail.gmail.com>
 <bwmol6raorw233ryb3dleh4meaui5vbe7no53boixckl3wgclz@s6grefw5dqen>
 <deccf66c-dcd3-4187-9fb6-43ddf7d0a905@gmail.com>
 <tandvvk6vas3kgqjuo6w3aagqai246qxejfnzhkbvbxds3w4y6@umqvf7f3m5ie>
 <24b9961d-7e0d-4239-97b3-39799524909f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24b9961d-7e0d-4239-97b3-39799524909f@gmail.com>

On Sun, Dec 14, 2025 at 06:38:22AM +0000, Melbin K Mathew wrote:
>
>
>On 12/12/2025 12:26, Stefano Garzarella wrote:
>>On Fri, Dec 12, 2025 at 11:40:03AM +0000, Melbin K Mathew wrote:
>>>
>>>
>>>On 12/12/2025 10:40, Stefano Garzarella wrote:
>>>>On Fri, Dec 12, 2025 at 09:56:28AM +0000, Melbin Mathew Antony wrote:
>>>>>Hi Stefano, Michael,
>>>>>
>>>>>Thanks for the suggestions and guidance.
>>>>
>>>>You're welcome, but please avoid top-posting in the future:
>>>>https://www.kernel.org/doc/html/latest/process/submitting- 
>>>>patches.html#use-trimmed-interleaved-replies-in-email-discussions
>>>>
>>>Sure. Thanks
>>>>>
>>>>>I’ve drafted a 4-part series based on the recap. I’ve included the
>>>>>four diffs below for discussion. Can wait for comments, iterate, and
>>>>>then send the patch series in a few days.
>>>>>
>>>>>---
>>>>>
>>>>>Patch 1/4 — vsock/virtio: make get_credit() s64-safe and clamp 
>>>>>negatives
>>>>>
>>>>>virtio_transport_get_credit() was doing unsigned arithmetic; if the
>>>>>peer shrinks its window, the subtraction can underflow and look like
>>>>>“lots of credit”. This makes it compute “space” in s64 and clamp < 0
>>>>>to 0.
>>>>>
>>>>>diff --git a/net/vmw_vsock/virtio_transport_common.c
>>>>>b/net/vmw_vsock/virtio_transport_common.c
>>>>>--- a/net/vmw_vsock/virtio_transport_common.c
>>>>>+++ b/net/vmw_vsock/virtio_transport_common.c
>>>>>@@ -494,16 +494,23 @@ 
>>>>>EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>>>>>u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, 
>>>>>u32 credit)
>>>>>{
>>>>>+ s64 bytes;
>>>>> u32 ret;
>>>>>
>>>>> if (!credit)
>>>>> return 0;
>>>>>
>>>>> spin_lock_bh(&vvs->tx_lock);
>>>>>- ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>>>>>- if (ret > credit)
>>>>>- ret = credit;
>>>>>+ bytes = (s64)vvs->peer_buf_alloc -
>>>>
>>>>Why not just calling virtio_transport_has_space()?
>>>virtio_transport_has_space() takes struct vsock_sock *, while 
>>>virtio_transport_get_credit() takes struct virtio_vsock_sock *, so 
>>>I cannot directly call has_space() from get_credit() without 
>>>changing signatures.
>>>
>>>Would you be OK if I factor the common “space” calculation into a 
>>>small helper that operates on struct virtio_vsock_sock * and is 
>>>used by both paths? Something like:
>>
>>Why not just change the signature of virtio_transport_has_space()?
>Thanks, that is cleaner.
>
>For Patch 1 i'll change virtio_transport_has_space() to take
>struct virtio_vsock_sock * and call it from both
>virtio_transport_stream_has_space() and virtio_transport_get_credit().
>
>/*
> * Return available peer buffer space for TX (>= 0).
> *
> * Use s64 arithmetic so that if the peer shrinks peer_buf_alloc while
> * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction does
> * not underflow into a large positive value as it would with u32.
> *
> * Must be called with vvs->tx_lock held.
> */
>static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
>{
>	s64 bytes;
>
>	bytes = (s64)vvs->peer_buf_alloc -
>		((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);

wait, why casting also the counters?
they are supposed to wrap, so should be fine to avoid the cast there.

Please, avoid too many changes in a single patch.

>	if (bytes < 0)
>		bytes = 0;
>
>	return bytes;
>}
>
>s64 virtio_transport_stream_has_space(struct vsock_sock *vsk)
>{
>	struct virtio_vsock_sock *vvs = vsk->trans;
>	s64 bytes;
>
>	spin_lock_bh(&vvs->tx_lock);
>	bytes = virtio_transport_has_space(vvs);
>	spin_unlock_bh(&vvs->tx_lock);
>
>	return bytes;
>}
>
>u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
>{
>	u32 ret;
>
>	if (!credit)
>		return 0;
>
>	spin_lock_bh(&vvs->tx_lock);
>	ret = min_t(u32, credit, (u32)virtio_transport_has_space(vvs));

min_t() is supposed to be use exactly to avoid to cast each member, so 
why adding the cast to the value returned by 
virtio_transport_has_space() ?

>	vvs->tx_cnt += ret;
>	vvs->bytes_unsent += ret;
>	spin_unlock_bh(&vvs->tx_lock);
>
>	return ret;
>}
>
>Does this look right?

Pretty much yes, a part some comments, but I'd like to see the final 
solution.

Thanks,
Stefano


