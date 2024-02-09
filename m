Return-Path: <netdev+bounces-70491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1225E84F397
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448711C22198
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A681DA52;
	Fri,  9 Feb 2024 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Y9k5no00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91B1DDD5
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475154; cv=none; b=cZAcsR/VoqCMvNrraJiwKo4XQCZOl23ZCO6/Yw1n/1NdDgN7GkxewHOuINA9dxM9/snz2cxp/0wi0Z7rpIm+uTalj4/00rhrJFfCcpyRypsmHmUZoHpUOFHDr9oc7YIFdzS9dR2H5ptfcXXlPiu96S6mHwoz7f2OswlvrP1o5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475154; c=relaxed/simple;
	bh=f3LgH8ZgUOwkLE4+iCPUvTYipmbL9Vhij4R5Psmp2no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9ZBlK+fRFdne89V+d+ynHnRg0Mi4E+QgzxfKFbYkvQrbFw8yVlcXrdP8pDMjd2QLCSTQK58dnfqKxe9FedhCHFZAD2+hy5yozpkL3Qhj2hPqqwy3VesceV/3khz6HxC9mTfhKuUW1ZKlmwnf8Q5CaSzru/skPpFredgHe+AgTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Y9k5no00; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a38a1a9e2c0so93925966b.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 02:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1707475151; x=1708079951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqVTxyo1KD7O54qRAZAz9ywsVou+rYDkxiKGodO8a4g=;
        b=Y9k5no00/mGfsyLvYdzTQPtyVSf/VhtmfGCHVCcFIaKSQmgJ7ABhGnQf+u6Mb7lkAs
         KUwpIpQUxN+4aTN4apOMOmsEXumCOQRMUxx+tGVG6bpSqeKavD7+t8Y0Z7JvA0m6l7rp
         uCDFUzMwrpUvcNuy32bDuKHzejIm0i+RKg1fgGbY2kofGY0LiagXjiRDY89bWVwzAPgT
         Ww/rXOqXeKthFCm186c11804UuUdXhgnWbDrAbvAZefkZ6DtyVncAFYycV0aO1DfwjhN
         MuhqoHUM8brUiM1dZ6u7ZhKimr5t3FS8OBOeUmCTZyXhqo567ZmXr12YGoBNlN4q5j2S
         MzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707475151; x=1708079951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqVTxyo1KD7O54qRAZAz9ywsVou+rYDkxiKGodO8a4g=;
        b=Hn1N447Tg5j3s2rVbm9RhLljZWI+/6wbmrRZZkoUhpI/1pAxy2+spiZyT3kB0TqbHY
         EOWTNll8TQ9OhFCcf2mvCeUe+oqYGk9afi2nzKZuIIg14XKe/rJUyu9MomtHSE2ONQxd
         7ULBNJNyKoToeo66BzPX8zxzwiVu1ROYT5wxReJrWYLX9AGfRDJDhULpAj4/DGDjtbLp
         siGXyELnrDikwZId5TLtrzMcjsnas/KlZPuCv0GWv7PBmFNZOxD3/ELr3HwjNjfPj0XA
         jSlzBesp5NW82reot9PBrf2c3BaEsDGIHaLm6zSc84bLjgKhxRn6y8v18KLpwUh6cPSu
         thAA==
X-Forwarded-Encrypted: i=1; AJvYcCXGSbjI3fuoeFc3WG9PdMWhWMcxjnllZKmzWiGcnuugVdaXe/uHmbbTu5+PXxRnCj9wufFDhfJNIn8XKqI9m7n9Ew+MU3PQ
X-Gm-Message-State: AOJu0Yw0ThXBh59n4NLH/3F3o5JgnSgNPSqn8AWUSag2yAEkVO3vAeeQ
	ZKS9GATYIo1e6vnWO3EKgtYZCy0CQhShTJwjYWG7VZdralRGhRUIsYEOc+3xWr8=
X-Google-Smtp-Source: AGHT+IEnjJblrcbbe1ReLw5pUJIloJnFk8qGeth0QS3qJc5Y5kRco8Nqf0/aOVyGWohAEYpBieTgOw==
X-Received: by 2002:a17:906:ce26:b0:a37:fb7d:6f21 with SMTP id sd6-20020a170906ce2600b00a37fb7d6f21mr969798ejb.51.1707475151160;
        Fri, 09 Feb 2024 02:39:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDE0Qfqvw6FUruVAQFTyP3htBqsqB0Hl58T3TeFjVb6hJmTO5W4stBUzSjIIPkbcficDZIdpHcbNBr6OjxfZqLMwBpCp91hP5/4aU30lcyfYhT24c4QugauZsLHp0W0AnGe7RWoRALd8XIXwib/kKbsCLxLC+PFisXDi8ZT0VtY3qiqHQgQu/eFmn3PQvlLlMqqJLdRX2ssO2lipPLCnLK8zNT1tgsxGQCcoAGKAauFbFWRAcK752yiov4DGl4XMyl65Rgqb5bETg812kW9UwFFwBLAujqBUl+RA==
Received: from [192.168.0.106] (176.111.176.127.kyiv.volia.net. [176.111.176.127])
        by smtp.gmail.com with ESMTPSA id tl13-20020a170907c30d00b00a38378d11e7sm626760ejc.132.2024.02.09.02.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 02:39:10 -0800 (PST)
Message-ID: <e27b3f91-051f-4fec-9b07-abf0615024bb@blackwall.org>
Date: Fri, 9 Feb 2024 12:39:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/4] selftests: forwarding: Various fixes
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com
References: <20240208155529.1199729-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240208155529.1199729-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 17:55, Ido Schimmel wrote:
> Fix various problems in the forwarding selftests so that they will pass
> in the netdev CI instead of being ignored. See commit messages for
> details.
> 
> Ido Schimmel (4):
>    selftests: forwarding: Fix layer 2 miss test flakiness
>    selftests: forwarding: Fix bridge MDB test flakiness
>    selftests: forwarding: Suppress grep warnings
>    selftests: forwarding: Fix bridge locked port test flakiness
> 
>   .../selftests/net/forwarding/bridge_locked_port.sh |  4 ++--
>   .../testing/selftests/net/forwarding/bridge_mdb.sh | 14 +++++++++-----
>   .../selftests/net/forwarding/tc_flower_l2_miss.sh  |  8 ++++++--
>   3 files changed, 17 insertions(+), 9 deletions(-)
> 

Nice, for the series:
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


