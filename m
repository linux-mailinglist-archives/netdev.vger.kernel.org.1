Return-Path: <netdev+bounces-241539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B4C856E4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049DA3A2082
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2034325701;
	Tue, 25 Nov 2025 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cslPuAVc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lap8gg2N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30C2441B8
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081046; cv=none; b=j6BnfllvYvfNzTyVmT1pgmh+yeeMplC5haeQfoqwrXGnF0EfrZNGX3pQNTGtghQ5ZWwlXpGQJn+21GmEscCSoJaDE1x7ItKx0ioxZpfRxjnedtyvfPQ/oPko3M7xj9+hHC/m1BBcbIgCXlRgGCRpNIPbmIfjZHtYolcQU6XOnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081046; c=relaxed/simple;
	bh=PSBqs1pwd9s4J335D6b0Q0cZNgvebfoVunfZ2KMCgRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMvkIUB//99bJCF54+voYIj7u/3QO9WO2o61NEa1Sta8p/4AW5nfJMjoRQeTAG4SmPP0l8jOGW1gyT9aQwxez32zBmquLwcizI38I97I7PwNQS1/4C5bygNWE2M082Bv2wE5Kmx2/0uOfloRgB7fgAil5fHENs5WEOIh2IwkXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cslPuAVc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lap8gg2N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764081044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+S30exXD6KMESwDkMoJIku4UCZ5sjAEWetq4qMD/Ug=;
	b=cslPuAVcr1vEI4tgMfYyxgskT7iGLzKMLAN+JzpS1ZHpAQqUpCQ3TKDzOyjJL+jtATu0Ex
	SXwbj82/6pm1jZqV1WUG4O3bAWwWoH44s9yZKnsVsYSHwxuvqZ95Y8DxsKrYQGA9B5KwQD
	MuSybkQpTakssHqNqR7cEP9pq7RPILw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-gO5EYIVgOVGwNB7dFY1f0w-1; Tue, 25 Nov 2025 09:30:42 -0500
X-MC-Unique: gO5EYIVgOVGwNB7dFY1f0w-1
X-Mimecast-MFC-AGG-ID: gO5EYIVgOVGwNB7dFY1f0w_1764081040
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477212937eeso33549375e9.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764081040; x=1764685840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+S30exXD6KMESwDkMoJIku4UCZ5sjAEWetq4qMD/Ug=;
        b=Lap8gg2NoGTyfMPBXoLv5QTOv2SlFvAT//92olFwh+0de8iFd6oAlTE8h+pHbAenC4
         0gMJr2qX5WuSblxkjabR8QdGUpf6MDVvuMqw7b92K9e7OBZqsblc1EjHDtHENRhmtw2I
         joWwQXnvUTltpECOpm3UYccKe+2M29W9TVJjBi1f08mGr6dionYlGDeg6mmLovLdn/tM
         jxTN+KGmb2ScpeHeL6+70e6ixh3vQusGaA35K/F29jly72rO9hqSGCUzSRAhBn4ybNLt
         FEoTsPRl0Cglb9Wt9/kZXS8kVVkx2N97INkeLP7LMsN3l1pvxYGnJy/xU0xXXOa3o2VA
         40Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764081040; x=1764685840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+S30exXD6KMESwDkMoJIku4UCZ5sjAEWetq4qMD/Ug=;
        b=pX8evgUP/WvjuyoqJXDAIsc73IMm+kwZ8vIyvrySXl6uNodzHwCQlAQOZhMcvbX9/B
         g6zPCyzKJa30cxf4Mfdy+DXeKq0k6+fT8vjXdmC9YbO3JpY2SYgJMsq4i3labTVc68sQ
         YUalbQgHI503km93w1JJj449ARvBPrczKcxtj5ueNJZVeO41LL+J0Wm3/CEkcx7jotyO
         NBzcmPLjZgqHOPPKD/P98JoxQoBq87mVZ4u98Wm3aC3Vcdws+E8CzoLPvOkj5GpSd81O
         6a8Spgh15wbGzfZWX9nasXvwbF17nj8uGjHuiw4Vu+I5btr7z+jvypNAw7wgpvpxWv8r
         MDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkgv+SPsJO8Vgc3Ae2T3AJcYcWwKfFcS3Sy5W5RW6BP9jZipyTpKpTfDlJborkv2Bc5a9c/lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKMQPF2da2ms/eG6Xl1GNfbTBbX2Kie+9ciaaZyInjARqMAcC9
	t7HsRlDssa8coY8yNRE1P6Cj+aX6WysuvabtfLdgBYkcKKY331U8/WIX+rUayqPZ/L9RXRxWl/b
	51PaYETXBWioj1acQ24tFV7hz8+VFkMvr6eK0X9E7QNcbIao5UW57a5kQYafIHENAlg==
X-Gm-Gg: ASbGncupXKGTYZKkfPDVs9sI4om5yqqFaE7EHejeLjncTVS+ehgbIcqQfsDXQkFejnl
	D1rFbRdbjfmmFtRdsz1MdUoH56FMgafiHgIEGJLyQ1M06hzytYtpnaqpKvnrxbY4Wj3XGLQ3YEG
	2mQBJZpSXYBJURWFy1reD9nNKacBDSaw0vah9izfscYYyyzBnBcLiRHje41H2RT1A9nG+9HE+KY
	Qkaf0iBu1K/ccfGNcXyJX6/+u79jbojfe/5HDHerOI2AiN38CiM0D7k24GsrcYNRw8kPHg4pt09
	x4tWKzDJx5NQ/9Aa1d97KvTWBnaP6Q1/r9frNewFflhzv2DoskVg1k5Nc54Slc8OSMG7Iqg0QdA
	=
X-Received: by 2002:a05:600c:4f46:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-477c1103099mr156262005e9.2.1764081040138;
        Tue, 25 Nov 2025 06:30:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEV+T5PmUzkohb6Bk+rDJzYp5RGhxCexrqvlML8JKg6LvhBzqVidta539/QnHYCDx/bBzX+IA==
X-Received: by 2002:a05:600c:4f46:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-477c1103099mr156261585e9.2.1764081039745;
        Tue, 25 Nov 2025 06:30:39 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf36f535sm258809175e9.8.2025.11.25.06.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 06:30:39 -0800 (PST)
Message-ID: <ea2db7e6-bc4b-4717-a188-faab3c13ef5c@redhat.com>
Date: Tue, 25 Nov 2025 15:30:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/12] ipvlan: Ignore PACKET_LOOPBACK in
 handle_mode_l2()
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Julian Vetter <julian@outer-limits.org>,
 Guillaume Nault <gnault@redhat.com>, linux-kernel@vger.kernel.org
Cc: andrey.bokhanko@huawei.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
 <20251120174949.3827500-12-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251120174949.3827500-12-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 6:49 PM, Dmitry Skorodumov wrote:
> Packets with pkt_type == PACKET_LOOPBACK are captured by
> handle_frame() function, but they don't have L2 header.
> We should not process them in handle_mode_l2().
> 
> This doesn't affect old L2 functionality, since handling
> was anyway incorrect.
> 
> Handle them the same way as in br_handle_frame():
> just pass the skb.
> 
> To observe invalid behaviour, just start "ping -b" on bcast address
> of port-interface.
> 
> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>

Again, this looks like a fix suitable for 'net'.

Also the condition described above looks easily reproducible, you should
add a specific self-test.

/P


