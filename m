Return-Path: <netdev+bounces-245813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFF5CD85D3
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 08:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56BC73017653
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD883009E1;
	Tue, 23 Dec 2025 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj26hUa7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKV8sheE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CF2DC336
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473938; cv=none; b=S/jDP8VflfPK080PerC72J35K2yG4IaxdxW9M0yBTDJKVcWxKetgt9twI2O6Er0Y1OMb3p0hBvWzDk5n7pZMuH2fN42DyGmHovRcSSjEa+XQPyIvC/aW8kGgs/HzBCTfqxUG9cwS9U+Z4tfU66RfKUhVLlb+7It6SbAhhyT0TQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473938; c=relaxed/simple;
	bh=qtBD34ND33HEKc6KO+kOa/6yxiJiBKRTxnIIZwXRUGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZ74Qr8MSzKYRPnf9DxUruOYjA73qWC4WCkNJM50EXWWA/7FHzEC9exim7w0ILSYpwCr+MF2escg41TEMWQ7qlo3osehYJWc/1mYmL0DSWyq/WlcCbga8003SMv+PJ32POTpIP9CM79yxn86ePUd5pvNUbfiIJ2EmS8oUXSm/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hj26hUa7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKV8sheE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766473934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/xQOrsVN9dvDtH/XoXjL+agoHhOzWcsBqQ/BiMMAg8=;
	b=hj26hUa7TVbGSiyid4d+HitGi97p7PrA2KCJ5zDS+Lg6jZ0lwcvSQHMBSuDInzYZ5WDUIq
	9ib0ULy8JgtRzrGZ98hZURFtxpNOxxo8v25rwWcmJnpsMdmavcMu/1mmlDRADVajX6AXxi
	8CIJ3b5ji8BVqg3T8GPUcB52fUPoLiQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-MLmfIVvNMqO7b1GsZBqodQ-1; Tue, 23 Dec 2025 02:12:12 -0500
X-MC-Unique: MLmfIVvNMqO7b1GsZBqodQ-1
X-Mimecast-MFC-AGG-ID: MLmfIVvNMqO7b1GsZBqodQ_1766473931
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47777158a85so53790815e9.3
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 23:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766473931; x=1767078731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/xQOrsVN9dvDtH/XoXjL+agoHhOzWcsBqQ/BiMMAg8=;
        b=KKV8sheEDO4sSHO/fBAgRwq6hM3K2YE7s4bN44zjgQQxtbQaX2mHwFZFIjqx0gRg8T
         adQlhAYZyAi6UJcgY3aHT285iux3GigTjXfSe8ycFOi0efgi4D+ZmeTHe+ucqqOtyOEx
         C1n/+E8DJ26kMWnOJNzXNP9h1c0aIVkt/b5IsrBjbiUcxMsI4clyIJL+b5oT6mPMjfxF
         loVWgSsiuugAXXOHkVpIY/oNhj5cVqVUWbFkyyg5GSWMd6muniGWOlXaG+UAX50oaleV
         z4jLhZGRJqflv30OC+P3J/E18441Va/4WTZEyAnkn356O9bMnS2fIGvdmkY2Pn3jV32e
         l5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766473931; x=1767078731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/xQOrsVN9dvDtH/XoXjL+agoHhOzWcsBqQ/BiMMAg8=;
        b=s+nwpjFH8aMzMRCUbB4mK4LoXFHRDzvSDdPDDP0Z1gBbmAuABzYReymvdvEEvMKiAr
         eA4Ypa0KgQ7Cwjd4cLsPqoa0N0JEMNIVkhjVWbYJMFWk6a8x3A4HVS14eM1nEumz0Gjx
         1veiQKUaAhlTYFBgVplk6AOsQ9F1ut+KiU7NlCNGx0zU56qiOPgF0LwvBRh6D907LM2W
         aBw2sUz3D88hbTC0LImYiUPuQNIWrneLNOVEjv8OXPxk9k2m1po0+InELSbSzwE2C2Ax
         heplhb2k08OtgcKhO2EMgWkWpUQHKBCageXUTs0aCWtSTVVioPimFto21S7wuGp1GtQK
         +MrQ==
X-Gm-Message-State: AOJu0Yyg2lTkDf+pD2Tl5+Ro+zrlg4qcCiHaR+ghZd8+ZWcwHtxV7C+o
	HqrmlZffvtwU/reO1rL9/lLXIzSHvLbb/umogsjfOg61kcdOLeCdvdMzaYkmPeAUpy0CGVmglzo
	eQCg9dWHL2A7+1DdCaXelrDU2hyLY1p1hjED49DXIdu5Wix0IZNWGmnQTkA==
X-Gm-Gg: AY/fxX6irt6N9EfdoF0blGoVo2LiSTCHD7FKD1SU22iH91ofqwc1Pn0wMaJT+Vxn1BH
	U5AB736zHkz8YPt/ykeTO6PcS9UUtv16SwYVYVDJ6eiIefKID3ZhRsyofkvwHggOX2qc8SVZEjs
	C8Bb20OtgpY8cPQ1jLwsDQjIsQjpwxDtkmAczBOEydiPh6u8voxMHa98XN1JjQ/NM6GZrBKoElM
	2qqZoHzgzo+yWZIB8VVxsU4bVaNLtnvTUtrs11N+UxlCjrsL28mD0HzqTbc8BalQXDAIGjQCBpn
	txtHm0HebbYIvCbdwrkbVxKyPNr32Qsdw61aGoLMgdBV2877kzS7RYKChuBI/pFzITS6GofhAu7
	IGGDh6Rd17m9i
X-Received: by 2002:a05:600d:115:b0:46e:37fe:f0e6 with SMTP id 5b1f17b1804b1-47d1997e733mr90556215e9.30.1766473930713;
        Mon, 22 Dec 2025 23:12:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8URVD3KseboNABzqrI65Dq7IvpSQkg5Sza++lkPfCGizUZettH0wLnjNCTNiUJjTuzXbfcw==
X-Received: by 2002:a05:600d:115:b0:46e:37fe:f0e6 with SMTP id 5b1f17b1804b1-47d1997e733mr90555945e9.30.1766473930314;
        Mon, 22 Dec 2025 23:12:10 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272eaf8sm277416435e9.5.2025.12.22.23.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 23:12:09 -0800 (PST)
Message-ID: <b7b10bf1-5294-4515-8d82-31c870525ff7@redhat.com>
Date: Tue, 23 Dec 2025 08:12:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
To: Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org,
 jv@jvosburgh.net, kernel-team@meta.com, Petr Mladek <pmladek@suse.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251222-nbcon-v1-0-65b43c098708@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/22/25 3:52 PM, Breno Leitao wrote:
> This series adds support for the nbcon (new buffer console) infrastructure
> to netconsole, enabling lock-free, priority-based console operations that
> are safer in crash scenarios.
> 
> The implementation is introduced in three steps:
> 
> 1) Refactor the message fragmentation logic into a reusable helper function
> 2) Extend nbcon support to non-extended (basic) consoles using the same
> infrastructure.
> 
> The initial discussion about it appeared a while ago in [1], in order to
> solve Mike's HARDIRQ-safe -> HARDIRQ-unsafe lock order warning, and the root
> cause is that some hosts were calling IRQ unsafe locks from inside console
> lock.
> 
> At that time, we didn't have the CON_NBCON_ATOMIC_UNSAFE yet. John
> kindly implemented CON_NBCON_ATOMIC_UNSAFE in 187de7c212e5 ("printk:
> nbcon: Allow unsafe write_atomic() for panic"), and now we can
> implement netconsole on top of nbcon.
> 
> Important to note that netconsole continues to call netpoll and the
> network TX helpers with interrupt disable, given the TX are called with
> target_list_lock.
> 
> Link:
> https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/
> [1]
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.
---
To save me a few moments, I will not send the same messages in reply to
the others pending  net-next patches of yours, but this still applies :-P


