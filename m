Return-Path: <netdev+bounces-119601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553FC9564CC
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA811F223F3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DC0158A08;
	Mon, 19 Aug 2024 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="hhac+OE3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78115199B9
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053087; cv=none; b=jikLV2Xm30O8UVkpx9ipRQtd4yZo+B7cuyKMb2Fjf+vuzRxiKnhHOs4Vxem51MTBXRrWRYFaQY0pSH+ZqY43GtMD6qKWV+YvgmFcZi/jTMhDUO60El6tnwBbz3XTVjQESphQD8bc9kT1/TK3L7dhjp/QrpGktFYsSQ/R418i68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053087; c=relaxed/simple;
	bh=V1lEVvETwNjIZyLDWAA4Njm+Q3sV41imXfQMGfdJRUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U51J1VP4HMj1zLFWbITIMhgAbUyximx0n8M/5nFRdtgD05DiXuFAZoWtkuVzfJXqzQYx0w7HkWVs3PwJWOIo9uTIAUBXlyQ5AEz06uQW+HxmeZV3xR6AyS+TFYcPC3bTXTdsYpRnyhJyJkibsPF7gvYVlmccj3FkvhZjD3F4x1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=hhac+OE3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso604669a12.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1724053084; x=1724657884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3veWCWlL8+oJzpy01iHdju3FDCUySlMNN7oj10LfO4=;
        b=hhac+OE3ZSKiKBGSR2jvsx9Rkx/4/1HZmQMXr2IqWLDkpteOl38oalJQ7W4nDo52eM
         gqdtV32B3u14njeWboTvlI2WDezMse9uoV8ayt1IyH/9e49mVqAupUbOtYj0ApGQeGCj
         7bVTe061I0wHvotXtzpPdAICRq5t94smAHjBJE07OylwVfv0j6Ih7QZO0I3IMqahDaBw
         i3D0jL/+/fYlwDuNDFb8DlHnNZhmuQ4uWWKKbo+JDcoeNtknBsPeBeZKEozDRFfhDBwz
         dFItAe8XnA9HJS3+Be4vQbZyxtBDIZUnlXAdWFtBTZoeDpgnwxtoXChrMCkqtn4HpTzJ
         RypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053084; x=1724657884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3veWCWlL8+oJzpy01iHdju3FDCUySlMNN7oj10LfO4=;
        b=gCdBtymz83NdBpbzrnSRF4TccpJlQRmvLNb96uOrpvdHQz7k85O7wzUmOQehBiQo7t
         +rKPlCM+x1YH9zv20lVyt2AP2SDL7sLe3eyt3LhiaMlU6Uz0ywOL3bSDP1ot6BaNsWdH
         sbRb09eISjRIawQkhp2k8Ag5zlxTXFqUbKK96wA1EK0qE/GUhYZdK3bJPKzucudCkXMI
         7NLk1UZp3haUkjEKPrYf/6x629wkgw2hSK9Ub0lht0fdCmu0HRUqhNleqjVuz5AmoiA2
         SaUfp0R70mgJBAwA4QprvYQ9US7WdInpPItWFQTpNHvbaeZeq1Gziy6FlhmZ+vfxLdmW
         gaoQ==
X-Gm-Message-State: AOJu0YzdZGGunfa3UIpjPaWEJTlLGRCeFobLIrPb7ll/Z5jC55OytNPj
	5tGlpMAUoX+4x8vwkLajssGbTQxB6HCCJ1sUpp7qWlgvOvUJOOP6PqezYKU1mnmQPy8QoojYmcH
	xE8E=
X-Google-Smtp-Source: AGHT+IF0IP6+RTN0LOwKJCN30kA+qAqHRpeTkaSg8xIUc/V+6OwY7tlqJLkx/HdkhsbQ13jtDS0Ltw==
X-Received: by 2002:a17:907:7f16:b0:a7a:be06:d8eb with SMTP id a640c23a62f3a-a8392a03a95mr781934366b.53.1724053083375;
        Mon, 19 Aug 2024 00:38:03 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d0271sm598150666b.82.2024.08.19.00.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 00:38:02 -0700 (PDT)
Message-ID: <ff8d2230-245a-4675-aca1-775be6b03777@blackwall.org>
Date: Mon, 19 Aug 2024 10:38:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] bonding: fix xfrm state handling when clearing
 active slave
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
 davem@davemloft.net, jv@jvosburgh.net, andy@greyhouse.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jarod@redhat.com
References: <20240816114813.326645-1-razor@blackwall.org>
 <20240816114813.326645-5-razor@blackwall.org> <ZsK2hY8w6zP8ejUY@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZsK2hY8w6zP8ejUY@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 06:05, Hangbin Liu wrote:
> On Fri, Aug 16, 2024 at 02:48:13PM +0300, Nikolay Aleksandrov wrote:
>> If the active slave is cleared manually the xfrm state is not flushed.
>> This leads to xfrm add/del imbalance and adding the same state multiple
>> times. For example when the device cannot handle anymore states we get:
>>  [ 1169.884811] bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
>> because it's filled with the same state after multiple active slave
>> clearings. This change also has a few nice side effects: user-space
>> gets a notification for the change, the old device gets its mac address
>> and promisc/mcast adjusted properly.
>>
>> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>> Please review this one more carefully. I plan to add a selftest with
>> netdevsim for this as well.
>>
>>  drivers/net/bonding/bond_options.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
>> index bc80fb6397dc..95d59a18c022 100644
>> --- a/drivers/net/bonding/bond_options.c
>> +++ b/drivers/net/bonding/bond_options.c
>> @@ -936,7 +936,7 @@ static int bond_option_active_slave_set(struct bonding *bond,
>>  	/* check to see if we are clearing active */
>>  	if (!slave_dev) {
>>  		netdev_dbg(bond->dev, "Clearing current active slave\n");
>> -		RCU_INIT_POINTER(bond->curr_active_slave, NULL);
>> +		bond_change_active_slave(bond, NULL);
> 
> The good part of this is we can do bond_ipsec_del_sa_all and
> bond_ipsec_add_sa_all. I'm not sure if we should do promisc/mcast adjustment
> when set active_slave to null.
> 
> Jay should know better.
> 
> Thanks
> Hangbin

Jay please correct me, but I'm pretty sure we should adjust them. They get adjusted on
every active slave change, this is no different. In fact I'd argue that it's a long
standing bug because they don't get adjusted when the active slave is cleared
manually and if a new one is chosen (we call bond_select_active_slave() right after)
then the old one would still have them set. During normal operations and automatic
curr active slave changes, it is always adjusted.

>>  		bond_select_active_slave(bond);
>>  	} else {
>>  		struct slave *old_active = rtnl_dereference(bond->curr_active_slave);
>> -- 
>> 2.44.0
>>



