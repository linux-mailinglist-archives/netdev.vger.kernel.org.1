Return-Path: <netdev+bounces-177028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7F1A6D615
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 09:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269457A4534
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DEA25D1FA;
	Mon, 24 Mar 2025 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faFabRAw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F290C257453
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804495; cv=none; b=VZAJblEGUjs098/rospWLbLOWzTjOnvvrtvB0xhle8zoEpatme4PMLf4bvcfjH06SOLhEyFr2ZOGZ1R5uaDtAy1isQQ1BH03eBsHCV7O77K1GKST8EiI+Z+wqH8ch0ECOEii+9tVsaOo6gb0LsQamEuDVjrbsFFZU0e5QrrLeYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804495; c=relaxed/simple;
	bh=AxkAYyt/NnYhFzHN3kktODaHuGAd/4RJ5RyffLbJCmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/RJLotg54klyLdUrYPIb8hERy/vnS8Bl7akmWfbEbKQh8fsjoY7/ySialysCKgzom9I8FIWWG5r9g5GoBU1/7hQqYnpVpSBUQiZcmbl1w9eVmyC7yQRXenjtgbGnCfjl4xc8JXp5r3NDbQLZxFvs+2i1RtT7P8lMK+kkW1kjsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faFabRAw; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-548430564d9so4252550e87.2
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742804492; x=1743409292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUNJX5h1/Y0+tFVg362+NZoW6VjO7ffKTXhFKGRDAqc=;
        b=faFabRAwigqeunNrwyKWsK4nbvCRIYvzcc3XkZduscnFkC1+DbkvsELyFAkz/hp9Xu
         yKCrTMyQzSf5M6fkKjmVO/TqGJ8OAayUMOtbLjz/79f+pUEJmO53gXmF+vRRB6kXW5i+
         b215coW0byYkEkAcszDadi8ieI2YVilMuJjWcmeI/c64pq4f6f05xhojGtfd/mC4s9aN
         kLel1Iob592Is/2p35dojEOzo3Ga51ZODuxFeRWmzGyCTExVbN64+MVrvl8PsmomU921
         6qSPZr4lGP8kQZarsY6ZFUcAti4ld26IChIIy/wRdHQOPgX1tr0Z2VKAQd11zD/BUar3
         SFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742804492; x=1743409292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUNJX5h1/Y0+tFVg362+NZoW6VjO7ffKTXhFKGRDAqc=;
        b=S/2ctnS+2WIRff/MzXNlkavA4HkTevryXv45XT92vINvyFh+hYIQVtErnFkJBZ21we
         3zZdfAazUaH1PMhbY4p3r6+Yr/dWFW4jJkOm8xsi2Vq5pxKsc2Za4KkUUjXthv30Vwmk
         MxhNi3E41oLCX4DMpA0IiFBSpN5AMd+VspERL3eyaLfX76DcxnaUtbciTjgjiZqxhfNc
         dusBssTDlUhgZ3JgUBKmSkBTM++4E63UzcR2Fjia8G+2GnR4yO8GUv2eXr6N9NawnyLd
         LkvV4EOieNQttUdZku3No4vCsly1q7qbwy/GbvZ1PFwLu8j4zc4TLiQ0Po6vey6ETv6a
         yHsQ==
X-Gm-Message-State: AOJu0YzPevh+pAJ5VukYpXfn0IfcL/kzXZDunGGQEkPnJbQSEHls7SYM
	INyzOwQf/7sqOTTrbHaujRTZjJNAS64+/lepiokpCWabJt4emm8DvDIx97NqRqN9iQ==
X-Gm-Gg: ASbGncsu8REFib24TUpBWbVAvBXjOmxz81nFMevGViBTEhKtE92oA3QE8SreckGvLm/
	9+A81S6vsaKa9B4NJ1NoPENqZ9QTLOw1t2c2/lBCfbVfmolteikw6GpdXVp0Y9XVoCZpAHvCMc9
	9lpG0jbJjp0ZqwEaKLtf08J1RXC9vU3tY+Ii5hmvxewZk4x9fkw+Oxr8sd9mkeHG/Ej8g0fTvRL
	vkQW0pekKGcDdRLb3Y0g2esXcw5PQQFzZLNuXX7FX/d+0fvEILb9teLKUG81ZE7svFhJCKQN7br
	CF1PjJSg2yQ5S0Vglb8MG0dWQjKPoch8HQdI8oiE54/e9GqzVgKJz+WRsLZi7yTKi7qptzv33ma
	W2sM45rMtMWZ2YoEN3AbqP2DPezmj3th1lIBy
X-Google-Smtp-Source: AGHT+IE8+g1te4P2VYphFXilFoSGknKWBbvdrVI+/CSUAKfotqEpoTdfNLgc5DBHxTSha+71xTqYBw==
X-Received: by 2002:a05:6512:ba5:b0:54a:c4af:18 with SMTP id 2adb3069b0e04-54ad6486711mr4113974e87.22.1742804491391;
        Mon, 24 Mar 2025 01:21:31 -0700 (PDT)
Received: from ?IPV6:2001:4643:2b9c:0:93a:fc4b:4cd8:860e? ([2001:4643:2b9c:0:93a:fc4b:4cd8:860e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad65125c0sm1052696e87.255.2025.03.24.01.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 01:21:30 -0700 (PDT)
Message-ID: <16fd5d51-fc2e-453c-9e81-c2530e4d3ea7@gmail.com>
Date: Mon, 24 Mar 2025 09:21:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: au1000_eth: Mark au1000_ReleaseDB() static
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250323190450.111241-1-johan.korsnes@gmail.com>
 <Z+D1NpUDCsIZLAEP@mev-dev.igk.intel.com>
Content-Language: en-US
From: Johan Korsnes <johan.korsnes@gmail.com>
In-Reply-To: <Z+D1NpUDCsIZLAEP@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/03/2025 07:01, Michal Swiatkowski wrote:
> On Sun, Mar 23, 2025 at 08:04:50PM +0100, Johan Korsnes wrote:
>> This fixes the following build warning:
>> ```
>> drivers/net/ethernet/amd/au1000_eth.c:574:6: warning: no previous prototype for 'au1000_ReleaseDB' [-Wmissing-prototypes]
>>   574 | void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
>>       |      ^~~~~~~~~~~~~~~~
>> ```
>>
>> Signed-off-by: Johan Korsnes <johan.korsnes@gmail.com>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  drivers/net/ethernet/amd/au1000_eth.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
>> index 0671a066913b..9d35ac348ebe 100644
>> --- a/drivers/net/ethernet/amd/au1000_eth.c
>> +++ b/drivers/net/ethernet/amd/au1000_eth.c
>> @@ -571,7 +571,7 @@ static struct db_dest *au1000_GetFreeDB(struct au1000_private *aup)
>>  	return pDB;
>>  }
>>  
>> -void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
>> +static void au1000_ReleaseDB(struct au1000_private *aup, struct db_dest *pDB)
>>  {
>>  	struct db_dest *pDBfree = aup->pDBfree;
>>  	if (pDBfree)
> 
> Thanks for fixing it
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> You didn't specify the tree (net vs net-next in [PATCH ...]). If you
> want it to go to net you will need fixes tag, if to net-next it is fine.

Thank you for the review. I don't mind adding fixes tags and re-submit,
but would that be preferred in this case? Or will it just be noise for
the maintainers?

Kind regards,
Johan

> 
>> -- 
>> 2.49.0


