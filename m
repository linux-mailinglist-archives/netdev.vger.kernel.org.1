Return-Path: <netdev+bounces-211409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4627AB188D6
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 23:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A5937AF90E
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 21:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFAE270ED7;
	Fri,  1 Aug 2025 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCY8cKZ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5990220680
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084184; cv=none; b=UjY+JWqEHxiCxtFJKUOSqTQljbLjB6AfVixrunBnGXVdyKuqEgYdrN/5CuVfjLUkBFaLT5JBlW62dQmKAV6hVLwxTKbcUAFFa3/XP91QNsaMDm/z2C1del65Vua1hheC+beKsE8V2jznutfjGioryY5MNFBJcjV8PrIQhhVV2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084184; c=relaxed/simple;
	bh=Kfa3rsdndDnPoZ4edKRwlTCxcNpJk8kPFvVM7pCSvjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDsuD3dz280ZruoV50Yvm8O9vF8C8D5hxj3KlEqWlRxhYLyHLLWTGdaA2uE9t7WPBKMbyXYNG4vM577yMeN+XLfDJ4Btz3M5o6+kWue4j3SopNtmpoHTz2vBow03mE0xzsNOpdpSi5e73X7rk+uFytr9wGVX6YFDbHI21iTPd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCY8cKZ4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bd2b11f80so2109913b3a.3
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754084182; x=1754688982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1IGumx1tyEe+2p0w76kDk2V+xsYhcdqQ4A/mHNCTTU=;
        b=aCY8cKZ4T8n2xI5K1TuBNbEwMiM5H7pmJ4hfMqPhdPvn2LfZjVqZTT7hK7YpLycS9B
         4Jj5hLNyLFM60kq2UdUYaw5SCcofQYeriudhC9PNLxvcFd5v05GaNQmJutxMnB+0UXdT
         Hvp9S3sJRSAoOso0C56EjlanEP9YeF7cr/zPu9jxM9h6SygX0PNG7HxJ8HUNvPZbnxbv
         5y+OPgtORf05a3qlaiajpF8OWVb3IBJqJRt57FCZt+YEifFZ/NlLoC/W73WtUj4fK//9
         atD1gz+IHo5rzRQX8RSNTYs2nXX4i/RFUx4kwRfy6gFMSTsUOaFugh/EhQwqqD2N5c7e
         e/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754084182; x=1754688982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1IGumx1tyEe+2p0w76kDk2V+xsYhcdqQ4A/mHNCTTU=;
        b=I0aW004sSoa6S5LqaHma0LAIAwwUg5obDIvxlmA7kwk8Wayd6THTrJCL4lWgbeIAJv
         X96WrUeFo8MAzDgSlOAOLkNU1DBa8gnGQXzAzK7k0cGZZqjCF8ii44pfhC/8DB49S1n6
         H+dt0pOVswyX/bwpHcdKiu0NcnJaEujY9t4TrvhIOsRZu4jFLoIr6FmSk9nTTAg1DBuI
         wFtw8pgMubTzHqmp8s1JorYzgyu6NYWtQ/aBtWxzy5caDVEMAUH5BE7yEwwzhO9I9qO4
         7A+YoQs2r4urIBO+5I3ZtL9VIxhC6FJ7BIChDU9+OA6h0iZ5u+jtLVFAnTf9n/pLrkC4
         w0nA==
X-Forwarded-Encrypted: i=1; AJvYcCW6mZX1ID+rj8Ft3fG2YTzMaROIEUewOo+j9PFDB427gyh0Ohn3GGeD+scdqznDOobQPVsX1rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw8vaB4fggy7wo51GdunvIKeJcGrajeywvpNvn3lj2O6eB04P9
	OhrblxfJqsKmqul1f8Xv6pDCscc5Fjq3JjyqZqpkaxofzH4kaQSJA4A=
X-Gm-Gg: ASbGncvPwzbHm3IMGK+HheLflGConsrP5O7miGAwA6cszF9FFzLFUmaMPduqhYdXU5g
	+1jGDyX9iB5XQYu2PZYYpPGo28k/6Q2ofWQGYeX8MW9Lovsx2iym4fhKK/0h/uqzykQYb2ut1Iy
	BFvIkj7bavFqLXVPQIvNOn5owIzXMqbOUh9opc4YTTUkxvGiTlzcM6YjgLnrBvod8hWqY/rQjvz
	UPgmN/dByYsvXvH3q0M3JGDdVE2i8gjpigGasaEZr2stlaL2jI0IuuK/VX3BTVUY66a2aaxixfO
	JCHTiBMMAEsZZa0d+V7GIsCS3uJv7E1/EG2umFKEASFOUc9IxI51A03I+mM5PEh2sABHsfHlp+h
	IoTx9t5nyTK7h3R4wq7NZN4EYE6T9Aw2ilko/zEgoMhje26kxQ0C8vpMVfWY=
X-Google-Smtp-Source: AGHT+IESyuQWczGbF4mOK/yjdCREk51JsIwFslf1+frymguNT7JRzlrrGw9c2vmOpJfJt9Xg2Z1a+g==
X-Received: by 2002:a17:902:ec90:b0:240:2145:e51d with SMTP id d9443c01a7336-24246ffbd4dmr12142795ad.31.1754084181925;
        Fri, 01 Aug 2025 14:36:21 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2422ba1e09csm24899445ad.16.2025.08.01.14.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 14:36:21 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:36:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	David Wei <dw@davidwei.uk>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, hawk@kernel.org,
	ilias.apalodimas@linaro.org, almasrymina@google.com,
	sdf@fomichev.me
Subject: Re: [PATCH net] net: page_pool: allow enabling recycling late, fix
 false positive warning
Message-ID: <aI0zVd1QJ-CMVX3u@mini-arch>
References: <20250801173011.2454447-1-kuba@kernel.org>
 <aI0prRzAJkEXdkEa@mini-arch>
 <20250801140506.5b3e7213@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250801140506.5b3e7213@kernel.org>

On 08/01, Jakub Kicinski wrote:
> On Fri, 1 Aug 2025 13:55:09 -0700 Stanislav Fomichev wrote:
> > > +static void bnxt_enable_rx_page_pool(struct bnxt_rx_ring_info *rxr)
> > > +{
> > > +	page_pool_enable_direct_recycling(rxr->head_pool, &rxr->bnapi->napi);
> > > +	page_pool_enable_direct_recycling(rxr->page_pool, &rxr->bnapi->napi);  
> > 
> > We do bnxt_separate_head_pool check for the disable_direct_recycling
> > of head_pool. Is it safe to skip the check here because we always allocate two
> > pps from queue_mgmt callbacks? (not clear for me from a quick glance at
> > bnxt_alloc_rx_page_pool)
> 
> It's safe (I hope) because the helper is duplicate-call-friendly:
> 
> +void page_pool_enable_direct_recycling(struct page_pool *pool,
> +				       struct napi_struct *napi)
> +{
> +	if (READ_ONCE(pool->p.napi) == napi)   <<< right here
> +		return;
> +	WARN_ON_ONCE(!napi || pool->p.napi);
> +
> +	mutex_lock(&page_pools_lock);
> +	WRITE_ONCE(pool->p.napi, napi);
> +	mutex_unlock(&page_pools_lock);
> +}
> 
> We already have a refcount in page pool, I'm planning to add
> page_pool_get() in net-next and remove the
> 
> 	if (bnxt_separate_head_pool)
> 
> before page_pool_destroy(), too.

Ah, I see, I missed that fact that page_pool and head_pool point to the
same address when we don't have separate pools. Makes sense, thanks!

