Return-Path: <netdev+bounces-156814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D030DA07E45
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A013A4B5C
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0881118A959;
	Thu,  9 Jan 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRGV+LLn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E5273F9
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736442191; cv=none; b=PgfoVDRqydbDs6I2DGxyL15dnJWob15FtUv6FzYCgjMH/XcGo8kVws63oAZAk+8u5if3Z7eaWksB/+wU23r1GOYSXgDYRHAG7F8YqFNDYx1A3IYefWxVpXqMhEIpHP26hWJNxkL/AQTMZiuns7NXtgbxjuC9VfHKHrxU1xZ52VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736442191; c=relaxed/simple;
	bh=LTwbijH3e+9CTwXx7coYGmUJP8JWJzCux9SOtCp8tJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bAtDhaGOHm5vzLVc3lhTpqf2roj+UHe10Cveyk4TamoCKyyVSMYTLnTC0EjYJ5+1E4+hweDmw0EaiRL4egCLhfMG3YdfXfneMhRwzgri3FJB/MHlC3Hw5NIldSTXJZo6MZkEKsXYoACU8gO6T0X1KsgjZSuBUnaSJrL7SqjZFeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRGV+LLn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736442189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTwbijH3e+9CTwXx7coYGmUJP8JWJzCux9SOtCp8tJY=;
	b=fRGV+LLn4xICDO3uCHZRR011afMjO9mgaiBnF7kqrcNULxOHSZNuPrMkRzEAD54KUmCcbA
	sgnWzt387p8J+XlFR3I9c/SqAdY9iNQx+kJOLqBuHcIq/SMBmTwAK2QrDwQ5F+rmb/10Q4
	Lt8NDTqHgwoVNX1Ux/QhDJ3aIT3V/xo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-hdfzpkllNoyC4f_VL2AYVQ-1; Thu, 09 Jan 2025 12:03:05 -0500
X-MC-Unique: hdfzpkllNoyC4f_VL2AYVQ-1
X-Mimecast-MFC-AGG-ID: hdfzpkllNoyC4f_VL2AYVQ
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53eca4ec061so1075156e87.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 09:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736442184; x=1737046984;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTwbijH3e+9CTwXx7coYGmUJP8JWJzCux9SOtCp8tJY=;
        b=l2O/A1Ym36xTCOvw0GwMWU8kIe8IPvCZtUUNKcvWo4TC3oYYIeVBWJfhcS+haVZGTo
         JkvxKtkTi3Saxiic4NDndKIKRd5zDZQEz+rzJmVMjDLfQjYS6O8aR01ByIJTkBwa3v0Y
         EWfSNuJFIjxuBAvdBGBPOIjJTzvxEQIzQ0yH8eTKbrvurwuRrzXL0YQofqe2lc98HM6o
         RWJbnizFRWsZt2j76Y2/p7AckpNQ44uIvaQt/+JVNPJFKRUreKiO6SvGFEpii3jTFu87
         m25uP6yycgFhQ02/vxSkRvL0CidWVJdylOS7KTO4cFz0/uNrhPrkB21bQ7TGLwbm4XB4
         hqvg==
X-Forwarded-Encrypted: i=1; AJvYcCXzlxE8bLXB9+3Kj1Q8gBkF2r3VIhKFk/DnQwotcr9K2zU6jdKJeXwXywiuc/v2xmHxD1XtyMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4jxmhs8hNs5vn+YFafSIs8TpbfzNJIkzEVJaEJ9sblEy4ZlD
	prC31KVBhdbHZ0lfSQoXxCkBmy3YBUh/2K9A7yL1Ghffia0uHJ7DaHD41Q6X8LfpVIn3C/wnd5n
	z50yrtpOdW1EhXzK1Z58tPUwKii2wur2qEajjWarHsxRkXrVUfNKomA==
X-Gm-Gg: ASbGncuYHKlE+hTUmym+TlJJN8bBPXzrpUmNUklO4oaWipq8DiE3UThiFMeUY5a42kC
	64k+gGn49XWYZf4ucv9FfHeRIGhFUklJ6ns7Dspml/EG7/s6UIOFnMkrT3uP+RwPwd8w1O3HGoo
	byVHhTqMmolkDPOBUolYAS0quJdg1l4qv9YvPTRyJwWCmNdXw7CBqfSvsX128/9nvX0bOoz8tHZ
	kPKapALyTu9bpnHHNZXcnY/hoJqXeH3jggy0M49Qp6a4r/4ThV0bu5EK+I56gEhZu7iIYIclWhE
	GNecfw==
X-Received: by 2002:a05:6512:10c7:b0:540:2d60:d6ce with SMTP id 2adb3069b0e04-5428a68abe1mr1354782e87.24.1736442184033;
        Thu, 09 Jan 2025 09:03:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAYUgH2H+LqOnRoo7/m9gv3kHlx0Ztv+dlDTJQZQb9Ao8W1+CWaxCXuEzHbKIh70tKhNTDsA==
X-Received: by 2002:a05:6512:10c7:b0:540:2d60:d6ce with SMTP id 2adb3069b0e04-5428a68abe1mr1354722e87.24.1736442183467;
        Thu, 09 Jan 2025 09:03:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428fa8439esm90120e87.208.2025.01.09.09.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:03:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 25DC3177E397; Thu, 09 Jan 2025 18:02:59 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Brandeburg
 <jbrandeburg@cloudflare.com>, kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v2 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
In-Reply-To: <d37132e7-b8a6-4095-904c-efa85e15f9e7@intel.com>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
 <5ea87b3d-4fcb-4e20-a348-ff90cd9283d9@kernel.org>
 <d37132e7-b8a6-4095-904c-efa85e15f9e7@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 09 Jan 2025 18:02:59 +0100
Message-ID: <87cygvj4xo.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

>> What is the "small frame" size being used?
>
> xdp-trafficgen currently hardcodes frame sizes to 64 bytes. I was
> planning to add an option to configure frame size and send it upstream,
> but never finished it yet unfortunately.

Well, I guess I can be of some help here. Just pushed an update to
xdp-trafficgen to support specifying the packet size :)

-Toke


