Return-Path: <netdev+bounces-65017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B01F838DE8
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 12:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B54B212D6
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC65A5D8F6;
	Tue, 23 Jan 2024 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/vhiKEG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD85D8F5
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010666; cv=none; b=lYJLxCHznbah8PUVA7SGQleLp5DUSwTODE7jGOqfzmOdtjfFpIYxfQn+5sZ340yEBUVgwaTBqtXIPzFIqUiSqX5uL4lz+p5KMzyfbfC/dTxDZM6DkDbnaKP1UjRxIH6Zwxhf1vcp8ik7hHpWNBJcvSCF8TIZX2Ce5VWDyQpNtXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010666; c=relaxed/simple;
	bh=d5vhFCDXKWhD60RsAQav6/vwZUdmlljGAlTzyAXrtIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/w6swor3SjmT7y83IvyBk5FciHEQYxSp+u9HOtJVZp/LVrQJHa6UMDNFlaJ3mveEBMcFetqAt6H4R5wfkf2nWvtAAzwZ5g6lkEjbugRW1D7rzrFY7xjD+hnOdxWvTeuXv1GsT6cpEzXtBw+Al8ez0ozuurKjWRcDQpsOwMXGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/vhiKEG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so53385565e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 03:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706010663; x=1706615463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFRffleIAqadI2iTXNPf3Kv9B1TyPL31+wiflzV2Cps=;
        b=A/vhiKEGtzkiBcWKulR4DkFW+i/lGX5rceXIRY0zo1hRfu8W/amjmpgySWYRYCFkiz
         o99SKSKQexlq5+oOsLMCLRNIij/yCQkKP2dzb8R//zdMWwtp0v9wt7+qY+VnsX4CHEet
         HlbaQ1gRWgprF5/Dzqm/LGdVzL1qom4gK/rW7YHjEmCOfu/P6BUyfeFnkNrgDUm2KKKL
         g6RAApkewRMGCTgL/4mMSEpIYt/r9kKKQtQywjegKd+pXC46D2ZUQqNlAdjCAm49WOb3
         D+izQWEPVsYyemWa6xwp8bY2xhazot297GKhpkVyiw6dgl51gHELzhmJK7CY+BMqmL4f
         hYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010663; x=1706615463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFRffleIAqadI2iTXNPf3Kv9B1TyPL31+wiflzV2Cps=;
        b=FaCnApSIIfMmFETpJ20/2I/CCo0v3clpFJQI/lUe9ZIvrCv/nBfcx3QhZpK1Ayf576
         VSaoGs4vNu76Hy9hih8yNV8w6zMGdB1LERrzTHSBKsRWiIQ7idvVO1F3f7FVa2OEAeTa
         n4aCDNSQ/9X9SeEJ2Z8iHGcxVYFSvZKYZCMbGF42n2oijDviwr4mRr1D6rRP9B0rasKm
         Or+1EPWRReWEl9top8f1qd4rRZMFYpZ9YjxygH3oz7t7Cs8jBaOzAUtsgVVWRqKxxYRz
         fhqyH1SHQoGgyaQBiiAs5/Jwt5CEdR48WMBWNLi45C2UM27cIaMwcDSNMz1jH/jLpdyz
         W/3g==
X-Gm-Message-State: AOJu0YyQTpjtPITdXXc7PYqUEQGIJaGVFdpcOpFjrOGzAKWI9KaNpDdF
	jJ+8BNnAr+2wOYpcMgmKAoJ64CplV+1JhPYVhzJ+YCh8oyzGpdTK
X-Google-Smtp-Source: AGHT+IG6Id+VnEV/RTvaSpLrVSm2xbv2SdskzsiuIdY0t97H31mdQNpMj4o9yWgfoKbxS9RCk/TzeQ==
X-Received: by 2002:a05:600c:190e:b0:40d:92c4:c2da with SMTP id j14-20020a05600c190e00b0040d92c4c2damr64966wmq.31.1706010663012;
        Tue, 23 Jan 2024 03:51:03 -0800 (PST)
Received: from ?IPV6:2001:b07:646f:4a4d:e17a:bd08:d035:d8c2? ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id o5-20020a1c7505000000b0040ea00a0b75sm424900wmc.0.2024.01.23.03.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 03:51:02 -0800 (PST)
Message-ID: <b90a8935-ab4b-48e2-a21d-1efc528b2788@gmail.com>
Date: Tue, 23 Jan 2024 12:51:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] taprio: validate TCA_TAPRIO_ATTR_FLAGS through
 policy instead of open-coding
To: Jakub Kicinski <kuba@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20240122190738.32327-1-alessandromarcolini99@gmail.com>
 <20240122172438.16196239@kernel.org>
Content-Language: en-US
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
In-Reply-To: <20240122172438.16196239@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:24, Jakub Kicinski wrote:

> On Mon, 22 Jan 2024 20:07:38 +0100 Alessandro Marcolini wrote:
>> +	__u32 taprio_flags;
> nit: s/__u32/u32/ the __u32 version is only for include/uapi/ files
Oh ok, didn't know that, thanks.
>
>> -	q->flags = err;
>> +	/* txtime-assist and full offload are mutually exclusive */
>> +	if ((taprio_flags & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST) &&
>> +	    (taprio_flags & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)) {
>> +		NL_SET_ERR_MSG_MOD(extack, "TXTIME_ASSIST and FULL_OFFLOAD are mutually exclusive");
> Maybe use NL_SET_ERR_MSG_ATTR()? There seems to be no
> NL_SET_ERR_MSG_ATTR_MOD() which is probably for the best.
> The _MOD() prefix is a crutch, IMHO, pointing to the erroneous
> attributes is much better, now that we have YNL and can actually
> interpret the offsets.

Yes, I think that this is better, I'll change it to NL_SET_ERR_MSG_ATTR and resend the patch.


