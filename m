Return-Path: <netdev+bounces-92936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73F98B95FA
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AE31C21424
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192F723775;
	Thu,  2 May 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="gpmku84a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37263200A0
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636700; cv=none; b=j7wNi8/Kd0rvK1lsm2wm2PZWOixprwEAduz1Gi1mFClItDg5N1Ce8ixRhhUGhrTLD8QoyC7F/evJ3YHU4o1ykpv/GlqoXYFHNn55/h7O4lsAGMNLYz1P0F2rbQI1itRrEG/4WLQRJ2rmf+/txbnLZ5t/5JCwUUyjtt/zMGwZKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636700; c=relaxed/simple;
	bh=ZpTUw637QRFwxmZsr4VDahLHtcKKQTb/9R5rtJz7rtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zxxh5iK0gD8gXUaWuX4G3mnRw/BkYYO/1QzCpIcMrTSJqpo+02Irh7JHx/Zwqi7zHKZXWBCjRn44DURUwV99qwO8U7BvKDgB8VBEvKK1PTy1UIVS6NRQLXvdtJnlys6au+222jml1QZ2DLGwUhGCX0A11o9owWC8gEOFNMzq+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=gpmku84a; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a1d88723bso53602845e9.0
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1714636696; x=1715241496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TMen/Q4ftdBsV1shk7+/wUYbQR1Birf8iZshz4TprHE=;
        b=gpmku84aLGJ3IrRWZbetcMKe+lL5dzPMqniE63pM17HBnGmUANtoexbxDOIpFi7dTZ
         EVYAsn23WhdTYGIzBpuuW6maFqdZc261YDDj6Xl/cLh/DK3adCdCAzRidExSKwzoYJct
         RQOFSwnA8aRUX2X6L2+GfPXfjNaQoQPJlGwIyi6z5D4Gb59p9yw2jIdxD0qHrfDmMvF1
         a11mVj/HuetRKYd7EDMNsHNnXCtKLKCijtDhThxbzIUZhyTtHm014CJJF4OZlve2V9iE
         wtNVSxoJtixXDHAqIX/66Th2b97DBF3JtqOJoTFOspPUr2EKuzR71bBw5idc2I6JrG8J
         62yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636696; x=1715241496;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMen/Q4ftdBsV1shk7+/wUYbQR1Birf8iZshz4TprHE=;
        b=eaUkLJCmSEYE1lGgoBmdGTHhisydCsKTcEpH4Ukd82ndtLadTIYaCjrTH6xEN2+52W
         Z8/nM5kqgphwjVdV/eHCbSiMCV0y2H0NicSmtfzvzNo9mGE2yC8GcIVFzE1MH+RBtm9e
         lIF7uDTQd2BsutFPxsYPoXUg00KO8oBqGfcJTpQ/b4RF6b6hPYqWyQaoU594nrhwgsgL
         36bscy/H/S4XKa6MJaMjdxAt5KDi1oZ6205EGwWks3VStqOBYn+AqGC/MQAfADCzSrGy
         zkv16MXnb4PDJ00phZ239cNDKhgWcKECCvEY77vuNhZQdkADWvLPCJMYFeDvG5k5k1Hz
         XhfA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Gax/WejZnsOpVOlfhcBIVcOikTQdUoQP9NMNCleCq9JBX8lVx94nLNXXob0uiM6beGJYwSNUqnad7pY8uFy25gaoi4ib
X-Gm-Message-State: AOJu0YxNjVkADH7MStcIu65NkNH33aE2cZbSFUJ2BvmaH9fn0fWapSv9
	f3kI5V61MPDZZ2krnedtRlgDBoP3MAhWhgW7Et2wcXsp3+lXSxKjowZ5l3W8pnU=
X-Google-Smtp-Source: AGHT+IHJLEtlPtNHXkSn21A4kJHD1yHL+VAvSYbHQazsXo99qB9GMTAx2IWk0YYZubMGssXKO6d2nQ==
X-Received: by 2002:a5d:6105:0:b0:349:eb59:c188 with SMTP id v5-20020a5d6105000000b00349eb59c188mr3674064wrt.5.1714636696413;
        Thu, 02 May 2024 00:58:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:bb06:acc8:dbc1:95b8? ([2a01:e0a:b41:c160:bb06:acc8:dbc1:95b8])
        by smtp.gmail.com with ESMTPSA id dz5-20020a0560000e8500b0034d10895f95sm595997wrb.56.2024.05.02.00.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:58:15 -0700 (PDT)
Message-ID: <c611c400-d7c2-476d-97e1-127f1cd20baa@6wind.com>
Date: Thu, 2 May 2024 09:58:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v14 0/4] xfrm: Introduce direction attribute
 for SA
To: Sabrina Dubroca <sd@queasysnail.net>,
 Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
 Eyal Birger <eyal.birger@gmail.com>
References: <cover.1714460330.git.antony.antony@secunet.com>
 <ZjC68onD2DvsX6Qy@hog>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZjC68onD2DvsX6Qy@hog>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 30/04/2024 à 11:33, Sabrina Dubroca a écrit :
> 2024-04-30, 09:08:06 +0200, Antony Antony wrote:
>> Hi,
>>
>> Inspired by the upcoming IP-TFS patch set, and confusions experienced in
>> the past due to lack of direction attribute on SAs, add a new direction
>> "dir" attribute. It aims to streamline the SA configuration process and
>> enhance the clarity of existing SA attributes.
>>
>> This patch set introduces the 'dir' attribute to SA, aka xfrm_state,
>> ('in' for input or 'out' for output). Alsp add validations of existing
>> direction-specific SA attributes during configuration and in the data
>> path lookup.
>>
>> This change would not affect any existing use case or way of configuring
>> SA. You will notice improvements when the new 'dir' attribute is set.
>>
>> v14: add more SA flag checks.
>> v13: has one fix, minor documenation updates, and function renaming.
>>
>> Antony Antony (4):
>>   xfrm: Add Direction to the SA in or out
>>   xfrm: Add dir validation to "out" data path lookup
>>   xfrm: Add dir validation to "in" data path lookup
>>   xfrm: Restrict SA direction attribute to specific netlink message
>>     types
> 
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> Thanks Antony.
> 
> Patches 2 and 3 are identical to v13 so you could have kept Nicolas's
> Reviewed-by tags. Steffen, I guess you can copy them in case Nicolas
I agree, thanks Sabrina.

> doesn't look at v14 by the time you apply it?
> 
I was off the last days ;-)

