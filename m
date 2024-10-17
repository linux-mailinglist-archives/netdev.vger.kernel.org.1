Return-Path: <netdev+bounces-136473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6191E9A1E2E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2D61F2353F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C81D8A0B;
	Thu, 17 Oct 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iY5s54sM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6D1D88DB
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156940; cv=none; b=ez2JJ+KOtpNkmzSNVu1fStBGdHTcJfhQOBO2eWcz+X+wjGc0jjsRiqlj7/xF61QDLw6/PYMnXmDcgvbSX7iv4sCilBwVYKWvI1DcmNM1dsP9j2SyMaKArlBaSnDGa6S/TBUYhpFzJlTZiAd0RtwoKGj/N1URf+6/HHfHDR+wiuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156940; c=relaxed/simple;
	bh=gOtVzy6oeRkjun6xC6WucnkJXFO1qgGjrbKINwZy8Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGUh/6Jpg4vvG8BtRbd6sNJd3Zqk9ScNpdykI+0+Ubn/GY9i+QprDunFWZdSrZQIdADgVLyKDNXYd0myLIBiMjCQmHX9qiTFUC63dzEQaxw25KNDJl9mu3/LN+VSyOnWQQzorhBJSbgfdH8BtkSwwbANI92mR+E7MlZNT9ojrgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iY5s54sM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729156937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FO1tIirxUG4TUoZGJvm3K94RNFkmGgydMdW9mwfMF+4=;
	b=iY5s54sMs6eetL/z02DXh4uEBTFS0BmezmkVz1DgPHoYzkbk+Zq2Gce0IrG4dhs3kYGpUl
	NTiNyZm2zsjRQTf8xc/8T3pSQmlDHvj5SgjDez0dH0w+pfU613YDuaJqy4MyApuvu5odou
	rzMehHeeRZzHJkZSqhXL5pBlNOM+OZo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-_DYhkFc1MKywxzszTb5ggw-1; Thu, 17 Oct 2024 05:22:16 -0400
X-MC-Unique: _DYhkFc1MKywxzszTb5ggw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315544642eso5503075e9.3
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 02:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729156935; x=1729761735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FO1tIirxUG4TUoZGJvm3K94RNFkmGgydMdW9mwfMF+4=;
        b=fIaiR9WNr8ePviTijS4kKHCV3ytriE0URzgIiJdiAmFYoXxzy645wCYuXyKLiHtSVB
         W09x8sokNDzDCoRFGN8cKQYmKwEef9U32gGPh39e0n7ltBvC8CrJUt3Sfk5ch0JmIU2X
         8Kw4Erwuu0VkODWVsjz3NyAy1Vd+uAFAessqG7+AIsWLURSOZpYupfb7JWRV+U1qfAUz
         Uu1qMK551TJjJcNtkFB68AbGAhmwbpg2rQTse9xTti0wgrvLjFvN3UHnxXJXLhDfcpJO
         hW9ylf9Vz5EzWY2ztV07q7wlgi62TxOXbMdyfY+z8JViPqrLKYSP5pOm9tzmQNTxq75u
         9gJg==
X-Forwarded-Encrypted: i=1; AJvYcCXH8BskZhahgZzHLPmE/smGTTAboP1ciUZfzE8Xd38ABRdPiWXba/e6+GEwYby2acgleGZihAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wa0MyfJPiNn9cFH4SNYvJssVNRol9fO63cAoUI1PznZuS5Gf
	5/dGtIs7bQXbX10uA1RB/IcHyQCMUWelZ9GIkIt9fnA+vcBfBahe+d+/MmFlUnJuP4Vm2j7RBQ7
	vBhe3FpcGcIDFy/W95NBk6EjB/raOP/yrNF8NPWa4oJ4M+4zCYKiL38S6TyiFNjjI
X-Received: by 2002:a05:600c:3ba9:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-4311decaa31mr187621665e9.10.1729156934741;
        Thu, 17 Oct 2024 02:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuTakEUXtsQSYI9rX85nCg6s0+Oai5+VxWedBDCYi70qq6v9+E9iH/hH0lUZ7GzuiuNV61uA==
X-Received: by 2002:a05:600c:3ba9:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-4311decaa31mr187621335e9.10.1729156934303;
        Thu, 17 Oct 2024 02:22:14 -0700 (PDT)
Received: from [192.168.88.248] (146-241-63-201.dyn.eolo.it. [146.241.63.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c38059sm19888415e9.9.2024.10.17.02.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 02:22:13 -0700 (PDT)
Message-ID: <5b614738-31e8-4070-9517-5523b555106e@redhat.com>
Date: Thu, 17 Oct 2024 11:22:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 0/3] add gettimex64() support for mlx4
To: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>,
 Richard Cochran <richardcochran@gmail.com>,
 Mahesh Bandewar <mahesh@bandewar.net>
References: <20241012114744.2508483-1-maheshb@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241012114744.2508483-1-maheshb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/24 13:47, Mahesh Bandewar wrote:
> The current driver only supports the gettime64() PTP clock read
> operation. This series introduces support for gettimex64(), which
> provides pre- and post-timestamps using one of the supported clock
> bases to help measure the clock-read width.
> 
> The first patch reorganizes the code to enable the existing
> clock-read method to handle pre- and post-timestamps. The second
> patch adds the gettimex64() functionality.

This paragraph is outdated, you must update the cover letter according 
to the series contents.

Additionally please fix you git configuration; you should set 
format.thread=shallow

Thanks,

Paolo


