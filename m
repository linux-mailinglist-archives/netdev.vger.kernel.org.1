Return-Path: <netdev+bounces-106271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 138CE915A19
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 00:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1EB1F20FAA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99C2136E17;
	Mon, 24 Jun 2024 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="jENJayRh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7812EBD7
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269417; cv=none; b=JVgwhvZ3d3Nqk4dnTg60uEnGseo02MwlsheudVW9kNxCLHOR1CjXwJsAsBIpqPiEYQIp79hoZy15mI+JXFctuwDirPFCwoUcHWK4j/cz/D8n9cAMolgSP2WCyHdO3lSkSdngB/jWQ4grJjll4ficNuOOaV2jxpTHnM5BJJV4FCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269417; c=relaxed/simple;
	bh=E8BWu9LDbJWPQv2ggCJpYglKgXnCkvHHhpW89qP1YRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suP09P/EeqLj25kEKCATr8uuYtj8kmiluUYr61qMkf4uLLFfuo7WucWGqGIGqSkoE7uLFh+luNQr1d2iDPqDw90vWSHE401ljCB0sECmyTGbvOknUJ8U8s+xV3CxGP2wZ87LxGCTdRAtpNkxsSavPfS8gAuQqi9ArTljL0/iCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=jENJayRh; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-632750bf73bso43532217b3.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 15:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1719269414; x=1719874214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3A2C4uSeo7c1KnnKImD61WOo6L6zry4cQHWNwoOZsU=;
        b=jENJayRhYOrJB/N3wgwM1yzNoCRtAhhIL6KzfiNxqTdYqrER9fp3lCDKJgzuD0sk2r
         WICOmynA4r13qV1yniPCTAwHILTpj+k9pVUN+rTEApBKC/bv6lMWLQgQyC64210WQ417
         YBgOmIzbsTUx0XRCy/4sCPfbMn7IVess3ym3EF+P+qkjf/nPDpdJnV2uGaKijYukCJgX
         hrBSVpTNeMfeYBGAeGlrw7zjm0578GwJlZz2YW7I8crbAvQtFGlUpCLDN7dlKZiQfSFk
         qk1dI4wrHqoLIpTEQUtUjLpB9Mtw7KFFnxXnzeg+H+C3Mi0OpzueCXjGjE6x3vGl3Qtq
         6nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719269414; x=1719874214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3A2C4uSeo7c1KnnKImD61WOo6L6zry4cQHWNwoOZsU=;
        b=qSTH8/f8OEKsSRhFWQdl4+GxuMPCkS61S50HpmoQ6+TxrcqPhl06XR7NumIBsUnFCN
         FEpfmDkdit1P2Zfzrx8fMEgGJpGwOdw7pClqLK6VKW6x0ZoEGKRHwoVeDNKCnhi3/JXw
         5Q2MHY5rPj3j1wUF3VhUcpbHsTpebUcOTIsQ7MJm0by//zFAA25AoiIz6JfBRJOkzJg8
         t240NAu77iYfrEOHchw//scK2Ofyn9kTLgpFcAp0h3CWrvyfbX/uwAszvhEFtgrlL6Nx
         JoRwe/qjaoY1cy6ywRfKaN/sjQNbvOdg4U+W06DdC5ZVunzy6S0Te9Of5kipJEfGnvVt
         iRPg==
X-Forwarded-Encrypted: i=1; AJvYcCXWTMotOnORx+K1bWclmANgj0r2whlIoKd1JA9Rp8G35qrg1BHNMRtlsyBKecbTy47SCwYc04IdQcY4o7QGeWvII9rfUeq9
X-Gm-Message-State: AOJu0YwnxRnnJaeetzzyXsIUexjjXT4w4YaACGdKCGaZgM+mUQi01+I0
	3M4/DOpkWwtIsD+DSj8CCkb9UIjcSC0xBOPZZfrCAOzxZPysNgj9OdHOQ+KPCE8=
X-Google-Smtp-Source: AGHT+IHy7rKzViKj5HXbHFMAp05Ax0y9lOw1cCh1Q4gp9hdrl4o1/7JnYieVrSvkmmfObIUbySZeZA==
X-Received: by 2002:a05:690c:6a12:b0:646:6983:2742 with SMTP id 00721157ae682-6466983275amr17769267b3.33.1719269414390;
        Mon, 24 Jun 2024 15:50:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::7:10ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef66aa8sm38439226d6.127.2024.06.24.15.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 15:50:14 -0700 (PDT)
Message-ID: <34db3490-efac-48e7-a551-821b2f6e5d99@davidwei.uk>
Date: Mon, 24 Jun 2024 15:50:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] bnxt_en: implement netdev_queue_mgmt_ops
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Adrian Alvarado <adrian.alvarado@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240619062931.19435-1-dw@davidwei.uk>
 <20240619062931.19435-3-dw@davidwei.uk> <20240621172053.258074e7@kernel.org>
 <ba5bef44-c823-4ec3-bf2d-66f66821d043@davidwei.uk>
 <20240624150254.053d0c00@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240624150254.053d0c00@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-24 15:02, Jakub Kicinski wrote:
> On Mon, 24 Jun 2024 11:20:59 -0700 David Wei wrote:
>>> What's the warning you hit?
>>> We should probably bring back page_pool_unlink_napi(), 
>>> if this is really needed.  
>>
>> This one:
>>
>> https://elixir.bootlin.com/linux/v6.10-rc5/source/net/core/page_pool.c#L1030
>>
>> The cause is having two different bnxt_rx_ring_info referring to the
>> same NAPI instance. One is the proper one in bp->rx_ring, the other is
>> the temporarily allocated one for holding the "replacement" during the
>> reset.
> 
> Makes sense, as I said please look thru the history - some form of
> page_pool_unlink_napi() used to be exported for this use case, but
> Olek(?) deleted it due to lack of in-tree users.
> 
> With that helper in place you can unlink the page pool while the NAPI
> is stopped, without poking into internals at the driver level.

You got it. I'll send as a follow up.

