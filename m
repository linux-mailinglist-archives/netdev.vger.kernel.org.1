Return-Path: <netdev+bounces-173888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C81CEA5C1D9
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A459188DA9A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440C4288BA;
	Tue, 11 Mar 2025 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCQzw66k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89403282F5
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698301; cv=none; b=LEnp9UDeYK//b0GkFr4qCZc5GqFouQTPipS74KDG+G8O76lZyj69lYP+Nw9qNhXwZNAJ046GFCyhZPt97r6nuwUyJM1vWLbWwpOCAxrijQ6pXQ3ukunclx7bskiu60v1gcuctJZCgR4DgDV/ijeJrq3IrwtYiFN4r1BBeconUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698301; c=relaxed/simple;
	bh=SQtpUGR2YY772K6jsEs2beCALnKeL6NLt6JDYsi9pSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMwL24mJDMA6cVgoY2V8CwTeF5Np6z5Pm2JefCuo1bQ6pwgNk/ZcWD9TR2CqAe/Zw2wHe9AHv12y1vGnhEiwNqaT5p9hUKmuPOXdAlY2ipzojDY+l3SMk0pSr1R7PDum8LFIid/jCnqjZYQWnBCDHVtFbPYlvlgJrCJxj1iZaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCQzw66k; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso981224a12.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741698298; x=1742303098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OpLgqxBZgt5CChPOHVwYhVGZH04vodWSLjcoFJfhNTc=;
        b=nCQzw66k3bX9LjQjGlX0rIksahskLfAMdExwThBQc0TCT93B1RIT5qFAv/79JV5tCP
         NuxrCT6b0mrKv5b3MaBVx4sQhH8V1ipwguPp+OBSPucwiDt4VbKfFVrP1mrKCjNhs0dw
         5Pf1Fr1iW7IH+ugmO8Qem5IlmSvPRalUWoiLgR6XYb8Q9IKlbcfo67TNHfc27GYdENdF
         dNYDpGRLPAERtisKe5dHU+7cy4YRa4a6xFPtgAcCJwtDY5ajHpuEhzUHjXgSNaMqBwD/
         JjDfhbi1G8kBJoe7JqEPjssRW6mpuFv5BcCRZhDx2oaej9748a3x1IT7KMA8NA3i1e0o
         XnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741698298; x=1742303098;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpLgqxBZgt5CChPOHVwYhVGZH04vodWSLjcoFJfhNTc=;
        b=q4wg/5Eucp7TLWz3nLMs5uqpopyC9BUDkA5yMCuDWaqVjsbFWaErQV/UGq894Iq1OW
         erbr3lc1kdP7XHY8FX1OSRqqG9e65OOJsJXonDS56nccubdKktFCO/vUHGvT0w3df1KY
         EIK57K90Khtn9QJs3UAj0RjbhleZlXWYx3NxX6vpKn2v+047aMLDrU4kIEc0YSXXrt7t
         lLVjtY6oTrGlrd/75Mzm3E90pGPTD+HQFaY1zZLVZbXwK/zJz3XeYI+IfnaArMaaC+BJ
         MHsPReDSHdqENBSACnFiJeiCg5Kn8+tWkR7sa6nNHs5l3NdQ2Ie9c+yxXspw9nsPqiDv
         UG3w==
X-Forwarded-Encrypted: i=1; AJvYcCWlXrE5Elagpip9dYp+8ug/7fjwnzXDFzfrUkHwnreiLaNsgyBkd8LwOfkbj5tWoKo7XG+fQ+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iLsdf0R/kWXyQU9NQdv6pGhKi+Fy6b3iF6KFw0HignOCg3fm
	wwAEVcNC6WbE+amWosu1GomkM/PeUnpo8fJJQLAhWnnpqyTPSqK7
X-Gm-Gg: ASbGncvviyAltq/+KHsZgU1WTCR5SkJRG8De2T5/DNBcFAfV0aeAxDBU7DESyQ+nqI4
	bEXHFwssOfNMwn33oJg7MufeS+BJvw2vetNoGbef477d7y8vMAY/pORPjelyONpKvGR3gXLYF+B
	bovEbqzpTl5Tbo7uQnvQCgdrt5J8zm5wXPKd4W0OUViLR4g+QfuO6kqUhLiV6Ex5Ei3TzuZv8dm
	nrVNeVcyyNO+S5Whn4cnMymwcihfA0iIMVx6faEWvUFe4v8PqhQ4uiqdyLes7cQzRj1IVVNXCBS
	dbsQXXxpyLNa4yem5EomM227q8TCtpSpWrls2q9V5xPBxrET72N6dlMa6fl/En94TwCH+u5qLYG
	0cxqm3K6yQDGRwfTUwttgWX0Dhl2lR2AmbiYOR2TU2pG8xzecwg3CK0yWVdnCz632FLK+A4TlIg
	R++IStWizvpImmt2F7y+5OY6jA3pWDk7X8FiQt
X-Google-Smtp-Source: AGHT+IGZY4T1eH0Vzwrd1ctUsHHvc0VOzvOysDPGX6m3m9vEMDVwDDx/GkbCUo/mk9BNUj6q0aTSLA==
X-Received: by 2002:a17:907:7b99:b0:ac2:9210:d966 with SMTP id a640c23a62f3a-ac2b9ee629amr440248266b.48.1741698297287;
        Tue, 11 Mar 2025 06:04:57 -0700 (PDT)
Received: from ?IPV6:2a02:3100:ad09:4d00:9cde:ee76:4d76:9c3c? (dynamic-2a02-3100-ad09-4d00-9cde-ee76-4d76-9c3c.310.pool.telefonica.de. [2a02:3100:ad09:4d00:9cde:ee76:4d76:9c3c])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac29f5d2638sm343631066b.160.2025.03.11.06.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:04:56 -0700 (PDT)
Message-ID: <7e976ad4-9eec-46ff-947a-dbc3ddd1532d@gmail.com>
Date: Tue, 11 Mar 2025 14:05:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: b53: use genphy_c45_eee_is_active
 directly, instead of phy_init_eee
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Vladimir Oltean <olteanv@gmail.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <1c1a5c49-8c9c-42a7-b087-4a84d3585e0d@gmail.com>
 <ec50da60-dde3-45ca-aa6c-eebf59fc5ec5@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ec50da60-dde3-45ca-aa6c-eebf59fc5ec5@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.03.2025 13:41, Andrew Lunn wrote:
> On Tue, Mar 11, 2025 at 07:39:33AM +0100, Heiner Kallweit wrote:
>> Use genphy_c45_eee_is_active directly instead of phy_init_eee,
>> this prepares for removing phy_init_eee. With the second
>> argument being Null, phy_init_eee doesn't initialize anything.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/dsa/b53/b53_common.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
>> index 61d164ffb..17e3ead16 100644
>> --- a/drivers/net/dsa/b53/b53_common.c
>> +++ b/drivers/net/dsa/b53/b53_common.c
>> @@ -2212,10 +2212,7 @@ EXPORT_SYMBOL(b53_mirror_del);
>>   */
>>  int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy)
>>  {
>> -	int ret;
>> -
>> -	ret = phy_init_eee(phy, false);
>> -	if (ret)
>> +	if (!phy->drv || genphy_c45_eee_is_active(phy, NULL) <= 0)
>>  		return 0;
> 
> genphy_c45_eee_is_active() is a function which could be considered
> phylib internal. At least, it currently has no users outside of the
> phylib core.
> 
> b53 uses phylink not phylib, so i actually think it would be better to
> convert it to the phylink way to do EEE, rather than make use of a
> phylib helper.
> 
Right, this would be a more comprehensive approach.

> 	Andrew
> 
> 	

--
pw-bot: cr


