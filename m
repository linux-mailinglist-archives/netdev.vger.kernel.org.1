Return-Path: <netdev+bounces-163389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00337A2A1A9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9B71887282
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A543224AFD;
	Thu,  6 Feb 2025 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="vmnDxC7G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973CF22489A
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825124; cv=none; b=A9NoizOPlWesoM0ILZkVjR1qHhhHYPastvemzy3+uThvNT7zOdGlHhHq/bAwxQ7/GMePbqASCMncPwo6BEHJ5U47aI5VsXqkMeUnYomsSdZt72oTUL0KTKohPXBlI0gxjbsxJM5QtLaReI2n3za746kTlMcXsg47wk3/JHC/ZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825124; c=relaxed/simple;
	bh=og3Aq1IjApPzY4pBlRJEpp2monYtKZMRFoZcCbo2WO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tlkJBtsQuERap5q+LikrULbXOvEmAuklf0cI23njRik0jNmvwa2V+ZvEsDCI2IHR9elg0+Tyow7+Sx8HNbZeUcLqLD6eGa1pfBzNcAIK8iVOLZuMubs8OB3bX4LWh0fXb8QLp8oYc8DispNsHvRmlhcglCZfX5LQ05c045Gtozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=vmnDxC7G; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2164b662090so11591955ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 22:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738825121; x=1739429921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfkFHRY4BuNO95W0YyldJMDcWeJ1g/mRAGw+u9+CPB0=;
        b=vmnDxC7Gxchxw1LtQ3i7bSdlDrG0ebeWraoMP4rauxsI9uiJ5x+WxrDyHSIEWhrb0p
         wjraVaFlMkv16b6IYjG27lol78/n506Ws//dWuJ4sPiUyma+6x3CiRJVc7ZjhHFeEneU
         yA5j0VaFe53ATkXIMJJ8zr1nAuQT1R2TpUOwnainI2C6d7kh4p4AmArZOLGoJ197SCFs
         ngwx3rOENpKJlGX2wy8DLXNzl8vDSmoNgSBWiI3zfDp7FyKrxW9qDdhRXo4i61+y8DFm
         kkfGhfHGGr3rrXObj5zbMB/3FQTxXVU397KqaGCwtPQKG0Qcs+9FdemWZTsf+yuamk0/
         Hpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738825121; x=1739429921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfkFHRY4BuNO95W0YyldJMDcWeJ1g/mRAGw+u9+CPB0=;
        b=C2mFPX0b2c6tEzgggkVEmCbeI1Iwf3ndodnQ2e33ICKupSRwyKTPUL4NU/OauTEwZC
         kJtwIUX5wKkiSwhG2wS7vJBQlWPrQBNCSicvo8Ci2N4Jk6CUmuYX58zeRE/+RU0KuzL6
         AayX/hDDRbZoOlUeQmkFxl4UfEBCVwAMO8AB/ZHDB5gnfuSbV1kc19goOO4DulPAmw/L
         krT7al4qULZKwKOgoniQ+WqNjUk7+unNYid1ImJGBDsPgbbEhqhMX2neOEpv7bmuoaoT
         vPduqF/3vyXIWXpVXUJc/a2D22fAvKBq41dhkwe3HcOSzBSkKcyEZwLVcIkmOJBcOazE
         b7IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyiIOcIWcO152OsqHjAIdSYIORuKtnvKESBw++FPPK11wQhlGWt09thMh/pi8eGH3+EwCjtzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFMDnc9/NleUO/B/3rb1BBZ9UAhZgxgvUD6mVGWWtH34UDDm9
	GVgeb4aPNZ3W9epjHNV46Dho/ktSOt1CsuolsI1qSdISZ/YGM5meeWhJQwPn6i0=
X-Gm-Gg: ASbGncsyei9R+ExUuXessO+5mMGuoNGS7kGKuexDyk3kpU2u5ZG2/HbqbNBJkOUm+mz
	u/kGwgRXgScffLYXNiCNp3ebirXzf8iFiTX4rCpgZJU2aAWDFC0Sdr/3K5dciGyFRgOGrbBESDV
	7j7DO9mtwSXVfnu4UnIguurHWHSBbbrSTlPqxN4BKM69kf2Q47gfWxUwNNYvdBCerl3Gol+ilnM
	+S/CDDXb1Hg9DILcbPJuGPCw/dDcgDiozC0vbSXxdqidm3TAhM0FGhl6bd4yqqtOcIUCAMElNLE
	SZNuweL+nQllzxsUufpBo0sMPQgP
X-Google-Smtp-Source: AGHT+IHSHvbDEBE36nUTLqiZtQMOf3j/rI2OoIwM0kMRTh5vyxMjVD4DwGY5i/68BnM7I5tCX5GUew==
X-Received: by 2002:a05:6a21:1805:b0:1ed:a6d7:3c07 with SMTP id adf61e73a8af0-1ede881f0b3mr9719443637.4.1738825121065;
        Wed, 05 Feb 2025 22:58:41 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad292dsm590546b3a.61.2025.02.05.22.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 22:58:40 -0800 (PST)
Message-ID: <1c2a1bd6-9ce9-47d8-b89d-1a647575ce07@daynix.com>
Date: Thu, 6 Feb 2025 15:58:34 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/7] tun: Extract the vnet handling code
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-5-15d0b32e87fa@daynix.com>
 <67a3d44d44f12_170d392947c@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <67a3d44d44f12_170d392947c@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/02/06 6:12, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> The vnet handling code will be reused by tap.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   MAINTAINERS            |   2 +-
>>   drivers/net/tun.c      | 179 +----------------------------------------------
>>   drivers/net/tun_vnet.h | 184 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 187 insertions(+), 178 deletions(-)
> 
>> -static inline bool tun_legacy_is_little_endian(unsigned int flags)
>> -{
>> -	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
>> -		 (flags & TUN_VNET_BE)) &&
>> -		virtio_legacy_is_little_endian();
>> -}
> 
>> +static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>> +{
>> +	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
>> +		 (flags & TUN_VNET_BE)) &&
>> +		virtio_legacy_is_little_endian();
>> +}
> 
> In general LGTM. But why did you rename functions while moving them?
> Please add an explanation in the commit message for any non obvious
> changes like that.

I renamed them to clarify they are in a distinct, decoupled part of 
code. It was obvious in the previous version as they are static 
functions contained in a translation unit, but now they are part of a 
header file so I'm clarifying that with this rename. I will add this 
explanation to the commit message.

