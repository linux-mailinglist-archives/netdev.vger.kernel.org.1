Return-Path: <netdev+bounces-151372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E65C9EE70F
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C08165C83
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E32135DE;
	Thu, 12 Dec 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpTmeg/j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF720E02C
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007780; cv=none; b=aX2PjP0iynDo8ZWGmIkG8K9DD8Gs4XYboieecw5wSCIXrbMhp6d/IBLW80oVjuNyZwRRY7D/t+lYhkoagFjqxOiZXOS0yICXQLh0AvEijabzf2p+8Ygk5bGdYdFXLwZ4/spocNyIM9eMaJjLRodpijRJEuEe1+Xmbc4WNIr5k+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007780; c=relaxed/simple;
	bh=YyEpl48QgjEe2bn12JUr/hGhuZXIyNMzlFs8mERZ05k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2ZSX1kqYs6zxYf+ObB/PKmFp7dhR/xjDttN97G4woM72ynmwmaeGZNx9TndjvVIqWwkzT6VN9ECxFCsL4T4n0Qo1IK3BoUmovCQ4sWZ9UK3tueSYLvYIplc0T7PWzBIUVDz6u/DXfWhJjO1WgIaPwj347+JERB40xOyVBFAvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpTmeg/j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734007776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itGE2V8xhlh187Ac7QymDWhnP6f5RsijIHH7cFJeYf8=;
	b=OpTmeg/j7JlzxqzC4ZWAGloMEfjbPlbtLqrppy0KozEnPKLgDJdwYvphsKSdcfFvNMQi8P
	aEsjMH1cTseOVEef0bxvg5oX9jY6VwE2uN965ggms8D7qTWtRxGej56sjhF0A+COHp8A3p
	jSHNy/XBSYkRSz/Cdda6eNkQHQy/DPY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-dv2OjcCqN6y7m7O6v4dzkw-1; Thu, 12 Dec 2024 07:49:35 -0500
X-MC-Unique: dv2OjcCqN6y7m7O6v4dzkw-1
X-Mimecast-MFC-AGG-ID: dv2OjcCqN6y7m7O6v4dzkw
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8f14fc179so16184856d6.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007775; x=1734612575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itGE2V8xhlh187Ac7QymDWhnP6f5RsijIHH7cFJeYf8=;
        b=oi/TLx5cwii4u7DZqW8PDrT2njupv0QwkZWqoyJyw+uHd77mizFcWAB0GXlHADyK9l
         UsDUM8fBnFzFkmSG1gHGXK+/MRl4Fsgy3lQk1rmzcxgtsyP50veZuGk3SR/oOwcWa5/m
         mtkU2ZH6N8Yi/6zKBi/hCu+fbrtxr30EGaZHHCDtnTKctG/NGTA90Bq04nfXRrzCm7fT
         BboWMtYRntTV2ETK/fovDVDrth0pxQMTJYtLKmXz5yNd7UbxXTFc/ZFa9RcF9JwRzSS+
         evXywnnWXtIp0iYhdjIMC8rSt8U0wcAo1xBvKF5wHSb14YmXvk8Kuppzt0wwV0LHww5G
         3shw==
X-Forwarded-Encrypted: i=1; AJvYcCXvwQDTdZgPz5P5l5cwDpcBiJ+QRRmA7k8dmkayA4YjU419jbInRnFNYroSnpG75u1FQ/sfXAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQt75cgMcSHbe9mZtb3cDdTD4pQFV/SpSFW7VqgdEkGvK5/6mN
	+a3oQwAcWxR0XMqq0cpCbbnkRzU1SDaoZcolgBAA9R/t/XvQbg3mAe+4cyUpxN488bMo5eSJSjd
	lko1XxPWcXoUa+e1WuIny7KK82Z233m0r6PXAbw4fc+mFyLD1Kx/Juw==
X-Gm-Gg: ASbGnctXTqZPY1zfzy2DF3YIIrNm/z58P2aRWddQTDZTVr/n2DUQOl7kw/+c4HGVeRe
	qbgXoUrtY6+60hb+93IBd2zBbda6V/TlYWDj0ySoxYg+yUusUlZA5B9vhJMfM/p+1uhwDBJNEvM
	7xMiRJtO1+OT+PiQuzyVRzIy0q6ENVTxmVyQIea9mZh5NseQoMGCB6y9KnmLcJttKWrKUtj6Qxg
	aXjPmZApkGEdMAH0/lydiASxFMIz+RYOoTzn0VHKd4o5OztsWUXXU9xjfU74EWp1GCeUOLve6EC
	yvZAkc8=
X-Received: by 2002:a05:620a:1a03:b0:7b1:4fba:b02e with SMTP id af79cd13be357-7b6f88c85b4mr44457885a.12.1734007774835;
        Thu, 12 Dec 2024 04:49:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4Ag6lWJ9NB6/EzRTpVTPEefZcnvZ6mnIYDz3+GXqvWUtfKmm+Nj3KJ0262kDPgAuHx0vVcw==
X-Received: by 2002:a05:620a:1a03:b0:7b1:4fba:b02e with SMTP id af79cd13be357-7b6f88c85b4mr44455085a.12.1734007774551;
        Thu, 12 Dec 2024 04:49:34 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6db04175bsm327709085a.52.2024.12.12.04.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 04:49:34 -0800 (PST)
Message-ID: <c67f6f4d-2291-41c8-8a89-aa0ae8f2ecd9@redhat.com>
Date: Thu, 12 Dec 2024 13:49:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RESEND v3 2/2] net/smc: support ipv4 mapped ipv6
 addr client for smc-r v2
To: Halil Pasic <pasic@linux.ibm.com>,
 Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>
References: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
 <20241211023055.89610-3-guangguan.wang@linux.alibaba.com>
 <20241211195440.54b37a79.pasic@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241211195440.54b37a79.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 19:54, Halil Pasic wrote:
> On Wed, 11 Dec 2024 10:30:55 +0800
> Guangguan Wang <guangguan.wang@linux.alibaba.com> wrote:
> 
>> AF_INET6 is not supported for smc-r v2 client before, even if the
>> ipv6 addr is ipv4 mapped. Thus, when using AF_INET6, smc-r connection
>> will fallback to tcp, especially for java applications running smc-r.
>> This patch support ipv4 mapped ipv6 addr client for smc-r v2. Clients
>> using real global ipv6 addr is still not supported yet.
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
>> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
>> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> 
> Sorry for the late remark, but does this need a Fixes tag? I mean
> my gut feeling is that this is a bugfix -- i.e. should have been
> working from the get go -- and not a mere enhancement. No strong
> opinions here.

FTR: my take is this is really a new feature, as the ipv6 support for
missing from the smc-r v2 introduction and sub-system maintainers
already implicitly agreed on that via RB tags.

Cheers,

/P


