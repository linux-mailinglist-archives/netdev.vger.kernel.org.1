Return-Path: <netdev+bounces-213263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA425B24462
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCFF1887CE3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3082EBBAB;
	Wed, 13 Aug 2025 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhfGZGXi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9352D12EF
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074010; cv=none; b=d7akFgnSrSEN1GmtUEYRvWY5zIrfFRQXB3C0ZPNSO8Ck1Wi7pkjZVLMa5yl8I9yffpJmM8ZQjq3ZcQDe9iWVuf4NK4yV40A05iQkNagkRRDTbvkHkf6lkqC8IS+Fn/o6fNrlotEAU1OQCSP70TmHnpvA8PxOji5pPigiIhWeIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074010; c=relaxed/simple;
	bh=8MWYyc4pWgdl1S73eQOvCrejLOkGKZuvFgUyb1SGy4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYig/PxWttQF8ZfE7CI8MM77A8KZ5MmVEHhwz4oXwWzGKW6E24DMD2SMfArrJC6ZZ+rC7O3eFiIqBq6R8lCNs7a1Kaj59tJ7qVBBiXBYh+579pKtP/+iVjV2NxSPBGzkJqV7F+twVu5nDX4a2uD22f7JjFGUz83NeWGMTrKYMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhfGZGXi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b79bd3b1f7so3069359f8f.1
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 01:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755074007; x=1755678807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=teOvt0wiOgB9B6wfD73/ElQ4Xk6YJNybYKKNeoSe/qU=;
        b=OhfGZGXibluqOjesmL8Qt3eti9tic4Z3ELJatjDD5oKEtK2J9MZg+UCdehJ0C+2QUR
         ZNlXnuD4gXWKO3V/f8jlz0wMnxmpp+1AijxjWHaGBXWtPMudM4qNep983z/qBMYMMwC3
         Rf90NKaAqeR/z6LSj3mOnCOxLcqy58qg+fyEQj7rumJYyud/H38JjUP2MV8GLE6u5t3l
         F7l+EZOBZH3/aRtm3m/sGdDXwjAikOKBVqYxUTplv/H5HH0ekdU9sa+c5KFbHMwNT732
         fHPRiW029dxRG0TE20/qGKhFFXe5JPEhXGcTkqrwmIWvseNwDmdqu2GwVBVbw3EhAWZa
         bRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074007; x=1755678807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=teOvt0wiOgB9B6wfD73/ElQ4Xk6YJNybYKKNeoSe/qU=;
        b=aD01f6HdNFgsKXyZ3HEfKg9Nvbv1UDOzfqD38GPFKjZtGilcFmqhcqKfBOuiMhzA9L
         ZSvOI31gOTvTv6apbaNDcSnyubA2k4sqJgMhxJDvihcM2uptW1oOsk9Hil+m7cqn7EGK
         Bg3xp74N8UeQTAX/5CGeqwnrGEHLYoXC36suqxfcYwPY2PVkYclPrIUzpC/pxTAG3y+A
         dgl2v3wguu+h4mc7gC9aCZd6toNQHftKlgNGREwffpzcns3Zne6QHaQZpT8s6jC/39FD
         PTUCt0SQdQzU7RALY6a8FtbVvdgsqXEUfvZAS0C7CQAqRz0yZ6ZapQf5AMOdIiUjrk7G
         z4BQ==
X-Gm-Message-State: AOJu0YyVpqOL9hEKXm29svV+omkhRifnUraoV5+RoIPPM137B3WheXUu
	KpGzaE5eFGd9ffSe+pn9yh2J2ghnFsRUy/I76Il7IWliIGDgqu7y5P+F
X-Gm-Gg: ASbGncvcJQBZuByeAhMCbHDes2bDZDO3c29aLcm3i/4M1EgCpskvpT5YVjEHq6w8Rtt
	c8LI1nRc0FdAzxN4L/eifZTsD7wG2eEFzhRe6yJOIKHMpDoM/xKtFMc4xw2qV8fKIwxTEJ6i8ve
	kf65PWPtz+ZuvQRzj7bO/UFUFGfPvaiTyLxLqfOpnd/0G0tRRsz+KP2lDXtt4T5nHYqKoTOA9OM
	rUOk3vTKXEETZlMLYo8Cw/hGe/lhWTGUgYgZr59D+E0jjqO/1UYtUcXua+gfPUGgK1wNBLpdxDo
	luyAEtBsDNVnJAqzqY7pJj1DuT2sSLsl7jiliXV7o9hV/CKkAzHO8iNm2cUpGomHutA6F1Neu5F
	6o4sDNBARy4TzgnHasFWHKaVSctdacRYD6LI=
X-Google-Smtp-Source: AGHT+IFK9N1ikTwcigdfwqInixCnoOmmdPAPIpB4AxnF/o1BP4cLxhB09qmQ7VQe6AMoeH2J1qy4iA==
X-Received: by 2002:a05:6000:1882:b0:3b8:d4ad:6ae8 with SMTP id ffacd0b85a97d-3b917eb7bbbmr1336251f8f.50.1755074006755;
        Wed, 13 Aug 2025 01:33:26 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::26f? ([2620:10d:c092:600::1:f676])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453ab0sm47241119f8f.44.2025.08.13.01.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 01:33:26 -0700 (PDT)
Message-ID: <fad270c7-5f7f-4739-b40e-4460f96fb9af@gmail.com>
Date: Wed, 13 Aug 2025 09:34:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v1 4/6] net: convert page pool dma helpers to
 netmem_desc
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Byungchul Park <byungchul@sk.com>
References: <cover.1754929026.git.asml.silence@gmail.com>
 <dbde32b0c68a1ac5729e1c331438131bddbf3b04.1754929026.git.asml.silence@gmail.com>
 <CAHS8izNXjGhg2ntH_9rjH8OfbZr8VaU97w6j4uYqK9kkQE+n5g@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNXjGhg2ntH_9rjH8OfbZr8VaU97w6j4uYqK9kkQE+n5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 01:05, Mina Almasry wrote:
...>> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
>> index db180626be06..a9774d582933 100644
>> --- a/include/net/page_pool/helpers.h
>> +++ b/include/net/page_pool/helpers.h
...>> +static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
>> +{
>> +       const struct netmem_desc *desc = netmem_to_nmdesc(netmem);
>> +
>> +       return page_pool_get_dma_addr_nmdesc(desc);
>> +}
>> +
> 
> nit: this wrapper feels very unnecessary. The _nmdesc variant has only
> one call site from page_pool_get_dma_addr_netmem. I'd really prefer we
> don't have the _nmdesc variant.

It's reused for zcrx in Patch 6. If I want a cast there optimised,
it's either that, or some new get_dma_niov helper, which would still
need to be expressed through sth like page_pool_get_dma_addr_nmdesc()
to avoid duplication.

-- 
Pavel Begunkov


