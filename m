Return-Path: <netdev+bounces-148052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDBF9E0293
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 13:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B52161507
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B61FECC2;
	Mon,  2 Dec 2024 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQarIxuA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E81FDE05
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144183; cv=none; b=b0TFOMS5dIaWqY7ialpYNpFvD8YRRODYMtBLmym7kArWqn/vS+2rvNG4BhTD7dFDuTd5r5Lm7a1qvu8bd9b+I5Ryn5zYPw3X+lFWTbNOAmSA0ld/UdXWeLvqDoAZpI9ZtJYC+e/+TfIG6oQ0Q9PVv6Qj5Sljyoh2ferfec6NV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144183; c=relaxed/simple;
	bh=XKcSpIqleiLKXzA/UBD2mf8atNVNWe36NG8cwqXHUyQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oYR52FDlDllwTXbKN1n5jqPmxV+BWTGUTkNL4quUmg5XpVnEyjPAccAD9s1AfCT9AOozCOg7JXRN2GX6XD4fjScYRResw1uIVqeG5x6t+L8AAzMO22YOsiTpQgxuQkFJPyBvr34El2chXkql3Yd8o0VrZyaXx5Nb1VQ9DfekXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQarIxuA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733144180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKcSpIqleiLKXzA/UBD2mf8atNVNWe36NG8cwqXHUyQ=;
	b=ZQarIxuARsSQUa8XU7H+cEq4+fmQJL2vFuB6Ck+qCekbSPEa3R9xnhybBbObW6HiCzZf/1
	xAoVTl+PXkvPqz548jTrhWbaLHGJaFeqMnCcH1aTwN94mDl/7MBTK5aSIeCWZ8NFs3e+hv
	PBV8gUznknBhJjwwUpTLTCijDCcRdqM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-VEkwHeEuNw-Y1HPa9UcT8A-1; Mon, 02 Dec 2024 07:56:19 -0500
X-MC-Unique: VEkwHeEuNw-Y1HPa9UcT8A-1
X-Mimecast-MFC-AGG-ID: VEkwHeEuNw-Y1HPa9UcT8A
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-215a3fbb8d4so6111575ad.3
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 04:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733144179; x=1733748979;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XKcSpIqleiLKXzA/UBD2mf8atNVNWe36NG8cwqXHUyQ=;
        b=DSV8H+7A2C12juN5ZLlzmKpcbMAlzaelyu6wlAEwj1KmowKAsp4+qUDGzvhOhOGVPH
         zdQrXuTAJRdUHtEoCxk5sFz9QJJdKIZhShFeC7uj6eXNF+qlMp9HfbIcAiIRdqhkcAax
         Yh6oHqwvHGxDIUnBcUxLPTSb5Hxh54NUjGXJaDlNHpFHLUt8cSUUjcAbX3cJ9bj97n+q
         uTd+R5a2RPea0OmKmAC16dmhtUk6eDAyyUFjfJ4ZL+B6a0RFp6qDblxa/MueDce7Bmiz
         xoBzaI0EMHshB4cv46zPAVKrlXS+UkgyL2xUMG2vJHnmrlpFWhmsxzU0FxswVSJPmR+e
         7ekQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv3Awb2LNR3ZJ/YM15pOuJp2Vp1kdarGARHriUzeCgMOVmatGGJe1deONRc8zyTX+1UIj4UbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywfB7Y5zgojX96DhSHmo+l7wkj7pf/xr4BeQiWep2jZv9wvTE3
	jkkLiFyTdCfi3T09VaGGbIDY+6h1keJQZyyzc6/t7EzAyD+2Qyf0fFNKm7QVohZWgs9HFHoc4iT
	q0I5gK6IkaDYR36A/5aOKtKN8YheUSmdh9YXau1O6u3D9Ymy3iIvmqA==
X-Gm-Gg: ASbGncuNbhMgQD1nX/oRUjBDnGdB2r3ZMX5r/zoBzeprynYS4dsnWlyZu3Ml4dVYAFX
	ekgeYVwUf1mdWKDz52F++k3jBcxDHyt5eJmc85XL7lO9ptjcfDtq7RFBGN7NXR+wdrH6LtawGIf
	DdjfHDvDvhljzKY+khe6wGPYFiCdYVZNEaVNBWfHP8K4Kn6hT6Kq8VdVrt3IxaRvJY9fyp+AJsA
	m69R6HPhSX/B3UjQGwcqiBk4/XnBoSnyVOFusau3dA1KNU=
X-Received: by 2002:a17:903:230d:b0:215:6e01:ad07 with SMTP id d9443c01a7336-2156e01b95fmr108932005ad.6.1733144178713;
        Mon, 02 Dec 2024 04:56:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF2hbG8ic2+7SJeIpAEUnuyceBg+L9EW/IcZgt10HVRUVQF9A3JgMViVeeM6wluV6tH16bJQ==
X-Received: by 2002:a17:903:230d:b0:215:6e01:ad07 with SMTP id d9443c01a7336-2156e01b95fmr108931605ad.6.1733144178425;
        Mon, 02 Dec 2024 04:56:18 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a6fc2d31sm9763385ad.236.2024.12.02.04.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:56:18 -0800 (PST)
Date: Mon, 02 Dec 2024 21:56:09 +0900 (JST)
Message-Id: <20241202.215609.382397812745347709.syoshida@redhat.com>
To: glider@google.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH bpf] bpf, test_run: Fix use-after-free issue in
 eth_skb_pkt_type()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <CAG_fn=VqUi=sGzz+0PJ9L7QrtOcgcn0ju=30BEGwB=D728wE8A@mail.gmail.com>
References: <20241201152735.106681-1-syoshida@redhat.com>
	<CAG_fn=VqUi=sGzz+0PJ9L7QrtOcgcn0ju=30BEGwB=D728wE8A@mail.gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gTW9uLCAyIERlYyAyMDI0IDEwOjMyOjA0ICswMTAwLCBBbGV4YW5kZXIgUG90YXBlbmtvIHdy
b3RlOg0KPiBPbiBTdW4sIERlYyAxLCAyMDI0IGF0IDQ6MjfigK9QTSBTaGlnZXJ1IFlvc2hpZGEg
PHN5b3NoaWRhQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4NCj4+IEtNU0FOIHJlcG9ydGVkIGEgdXNl
LWFmdGVyLWZyZWUgaXNzdWUgaW4gZXRoX3NrYl9wa3RfdHlwZSgpWzFdLiBUaGUNCj4+IGNhdXNl
IG9mIHRoZSBpc3N1ZSB3YXMgdGhhdCBldGhfc2tiX3BrdF90eXBlKCkgYWNjZXNzZWQgc2tiJ3Mg
ZGF0YQ0KPj4gdGhhdCBkaWRuJ3QgY29udGFpbiBhbiBFdGhlcm5ldCBoZWFkZXIuIFRoaXMgb2Nj
dXJzIHdoZW4NCj4+IGJwZl9wcm9nX3Rlc3RfcnVuX3hkcCgpIHBhc3NlcyBhbiBpbnZhbGlkIHZh
bHVlIGFzIHRoZSB1c2VyX2RhdGENCj4+IGFyZ3VtZW50IHRvIGJwZl90ZXN0X2luaXQoKS4NCj4g
DQo+IEhpIFNoaWdlcnUsDQo+IA0KPiBUaGFua3MgZm9yIHRha2luZyBjYXJlIG9mIHRoaXMhDQo+
IA0KPiBBbSBJIHVuZGVyc3RhbmRpbmcgcmlnaHQgdGhhdCB0aGlzIGJ1ZyB3YXMgcmVwb3J0ZWQg
YnkgeW91ciBvd24NCj4gc3l6a2FsbGVyIGluc3RhbmNlPw0KDQpIaSBBbGV4YW5kZXIsDQoNClRo
YW5rIHlvdSBmb3IgeW91ciBjb21tZW50IQ0KDQpZZXMsIHRoaXMgaXNzdWUgd2FzIGlkZW50aWZp
ZWQgYnkgcnVubmluZyBteSBvd24gc3l6a2FsbGVyIGxvY2FsbHkuDQoNCkkgYWRkZWQgdGhlICJS
ZXBvcnRlZC1ieTogc3l6a2FsbGVyIDxzeXprYWxsZXJAZ29vZ2xlZ3JvdXBzLmNvbT4iIHRhZw0K
dG8gZ2l2ZSBjcmVkaXQgdG8gdGhlIHN5emthbGxlciBjb21tdW5pdHkuDQoNCj4gT3RoZXJ3aXNl
LCBpZiB0aGUgcmVwb3J0IG9yaWdpbmF0ZXMgZnJvbSBzeXprYWxsZXIuYXBwc3BvdC5jb20sIGNv
dWxkDQo+IHlvdSBwbGVhc2UgYXBwZW5kIHRoZSBidWcgaGFzaCB0byB0aGUgUmVwb3J0ZWQtYnk6
IHRhZz8NCg0KSSBjaGVja2VkIHN5emthbGxlci5hcHBzcG90LmNvbSwgYnV0IHRoaXMgaXNzdWUg
ZG9lcyBub3Qgc2VlbSB0byBiZQ0KcmVwb3J0ZWQuDQoNClRoYW5rcywgIA0KU2hpZ2VydQ0K


