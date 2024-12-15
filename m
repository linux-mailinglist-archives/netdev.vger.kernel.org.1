Return-Path: <netdev+bounces-151983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE19F2378
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 12:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2603E164730
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 11:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD8814901B;
	Sun, 15 Dec 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="DEnUdyJy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C73335C7
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734262048; cv=none; b=Nb/Aq+Wo+LIfdTgt2BIqOPUNaZJ8EbTc5/YtyaGr29DmA8L5VDyL/7eC36IRlGB9vD9jDCZ1yxUenM8fiz2jikQZDabUEFBSTGtxc8Kyt8QViS8ltkXcvr8S+tC6n3jc+gmvIsWsDMYLsrFiLaQmkhW2MHV1QorKveNEr38VSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734262048; c=relaxed/simple;
	bh=5lOdxjwV+N9Vb2eMD4ZIjhF3lI6PUgZUnrUVu5wnnRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9LwchZRMPDMBwYdR/UyZEUOyJsnYWwvWVsX7bzkyeL7quBXasx0ntVB3tBkDjIlfbwr4YNe6cUA9nVH41WD+c/t9ytAZA948oImS0dFVtLul5VD5nXH9k2FzNa2upvkWWLdL02vAXZcDKX402GA7H1P8Heu5M1vMPUWdhPCHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=DEnUdyJy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163dc5155fso27196595ad.0
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 03:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734262046; x=1734866846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/a9Tfxy/Xq7V00h/JooH2DpdLFQxJY3+yj7aYYIlco=;
        b=DEnUdyJygvGSF5LMd2P7SaX7IEfAg5Ju2alekMQvdYSKftBRaf3sxZv7vEHeaeeXvI
         68g5hw1jefnS3gD+feDMdbLEqigER9KxLed3HdRaAPwsv1U7OWaZadNS7GzCMHuyEPIY
         TR7qwB6jf3r5BJTw50L1g1g301MjTz8T/sCuJCKJ1dhmn3DMiiyny1OyHfkRUu2Uv37T
         3QEky7CrB49V1eW3lcA5sxSHiztytz0KPqHtg0RyuKjxAJz8iRynpPcAWAm2ByWGSkXO
         Txp9/YrXfzy5euxXjhFUbXkoo0W1+PvYhQZxuQdLZhgo+2EKaIIU85WRncxqpCIHGvcH
         QveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734262046; x=1734866846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/a9Tfxy/Xq7V00h/JooH2DpdLFQxJY3+yj7aYYIlco=;
        b=hKi7HnbGs3ItCtGtNeLSXWYT2S9YEFVGtUsLJT49M9jfUqz6IIkMnRYi7zIQDhZ1uE
         HAqHtf/NnMN/fk6I0wmYVN3wZqlxa8o7NO+BDbOCA3ce9EeJU8BFIcbJxeLhXOG48aZ+
         vsWG0VKOlna0ZTpwWfIi/rzt43y8UPosa1//yoqXGq7IQ4g9xpp9+NMDo3is4bO4Sk1a
         Zr4XVATqBEJfvmlseYiZIjCYZkWPn7Z4DrRpHZFAvfQI3KeB9ZlXho/hD/qOC8e+NSZO
         VgtCijUboiJZICE2CaaSZKDz2DO96n/waUQpKsf1QqVEItIkSxYvNzsZGmylIsegBcR6
         BM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBeC8+9llR0vfs3IFzom3pVgxjc/8jIf176DeQTz/yUEFbDCwCNj4tWLfXnE8ovR0XJ6jYyz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Ls77LC5Ki25zXXXwVWga7vElSFufsREUr1Dxt6gacrifCZU8
	2RWMPLiSDHz7Ft4Rs9iQni+bWBk3XHZS3WdT2qLx1e4SCCt3jiC4eBzks4VBBcY2+HRRdlIW9bd
	1PsHU4g==
X-Gm-Gg: ASbGncttSmw8WTstmitgbRlzAbS0OAjDJcDKaPaIhvmgk7NePu/sYU2KLhzwi3luHsm
	hI58cpPUBJ1G5K6Te+9xRVlg0rKdLMoK5JOGqo0vU31KjCN7k1ccIVF3zxE+rElG9LHeiBZvXfn
	X9bHvB1BZki+sD4H0PMFcAjKzI09RkgLTt3eNJimz/A6w9DVr58jhT8LwuolwBaFQ1Tc1gHj3+3
	Jgnjs3Au9I3b4oXln0UkOKyBJO/nfUPd/ZIyXuhAt06w3cJvHQ855DTiFUXLvP3PUidwv2A8bhh
	hOcqDFYh3Klo253QnHTlLhF0nriIAu/UjQ==
X-Google-Smtp-Source: AGHT+IFkYpop3ZGokw5KkWoFiHRw/ip2w9tkufnO3O6JpM/TIqGUo99wp93dueP9ms43x8i/t9Wr6g==
X-Received: by 2002:a17:902:e886:b0:216:59ed:1aa3 with SMTP id d9443c01a7336-218929d8431mr99725215ad.27.1734262046247;
        Sun, 15 Dec 2024 03:27:26 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db531bsm25027135ad.56.2024.12.15.03.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 03:27:25 -0800 (PST)
Message-ID: <e188b451-5f74-4b37-b7a5-0027284f4c48@pf.is.s.u-tokyo.ac.jp>
Date: Sun, 15 Dec 2024 20:27:22 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mdiobus: fix an OF node reference leak
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20241214081546.183159-1-joe@pf.is.s.u-tokyo.ac.jp>
 <1e1c4c67-3e18-4364-9311-c9ba36a5e2b9@lunn.ch>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <1e1c4c67-3e18-4364-9311-c9ba36a5e2b9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Thank you for your review.

On 12/15/24 20:03, Andrew Lunn wrote:
> On Sat, Dec 14, 2024 at 05:15:46PM +0900, Joe Hattori wrote:
>> fwnode_find_mii_timestamper() calls of_parse_phandle_with_fixed_args()
>> but does not decrement the refcount of the obtained OF node. Add an
>> of_node_put() call before returning from the function.
>>
>> This bug was detected by an experimental static analysis tool that I am
>> developing.
>>
>> Fixes: bc1bee3b87ee ("net: mdiobus: Introduce fwnode_mdiobus_register_phy()")
>> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
>> ---
>>   drivers/net/mdio/fwnode_mdio.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
>> index b156493d7084..83c8bd333117 100644
>> --- a/drivers/net/mdio/fwnode_mdio.c
>> +++ b/drivers/net/mdio/fwnode_mdio.c
>> @@ -56,6 +56,7 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>>   	if (arg.args_count != 1)
>>   		return ERR_PTR(-EINVAL);
>>   
>> +	of_node_put(arg.np);
>>   	return register_mii_timestamper(arg.np, arg.args[0]);
> 
> This looks wrong to me. If you do a put on an object, it can
> disappear, because it is not being used. You then pass it to
> register_mii_timestamper() and it gets to use something which no
> longer exists.

Totally. Should have realized that. It is fixed in the v2 patch as I 
moved the of_node_put() call to the very end of the function.

> 
> Please think about what get/put are used for, and what that means for
> ordering.
> 
> Maybe you can extend your tool to look for potential use after free
> bugs.
> 
>      Andrew
> 
> ---
> pw-bot: cr

Best,
Joe

