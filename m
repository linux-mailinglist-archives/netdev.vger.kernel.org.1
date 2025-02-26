Return-Path: <netdev+bounces-169726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13563A45640
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 08:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2937A6C64
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC5826BDB4;
	Wed, 26 Feb 2025 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OKmELaet"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CB726BD83
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553432; cv=none; b=Ed4hzrSkNeq0gJyAamWy7b/yqBmONQlWePk9sRlmjl6sOiIGnYoMoj/ysf83GEehO2LeI271sujYxoZ9mBtgzyePNDxroZbv/HJm7yZ88Up6fSWB13KavBt/T/DUqxH5q2j2NwMaInJYBxZhsb7AAi3IZV6F2PX82AuDysxELMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553432; c=relaxed/simple;
	bh=z6heYyB34e5sZpWLcZTTXP7GOoxA1DRiUP8PXaKKXJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rv2m6Q6JQukQikwvc0cx987do2VjMrfkRS8pB0zPEt4yvreDLiN/iAmQxGm30ideCTHlDArxsiZ95gB0eHML7YL4vBLibsfkxKoinenvPbSKJCD47dmlXJgUhuc6tjMmnCzdxP4RZOcM4d+/ifUf0e0mL+nmsJknF2bUq1HNX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OKmELaet; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XiEEkwHssvqmA0EpOGIk9qYrwE5+eV/L9HQKxzQARoY=; b=OKmELaetydp27UG7fZv8Y8sYwv
	8cdOKDQud+AccAP1i235fAXGxmKvHykpEkFPRNEmIwyz5OeEa3HXJbZtlJYZMMCmf4WpIy7I4EPqT
	s/iMYXNj7DLqvMg4gk07Np9nQhXQwtgmQHKG2rAHYVI2V/GaukSzpkprLMXHe/Z+py8y1mZRI2j9n
	AGBJHFR+ZtFpF9h6NptK3sKWTQnu4dVPKSMD54/mZlWHeR7m3NIjcucz81VLP3PXQm0rRSuLSqCz+
	ZG44PgBYDcYb2QwzuHPFJ1LlA+Y1s1IZcBNWt+Ck8Z05RwiHW/HafZeNGjXeXkFydvm3aDI2cMC7i
	nh1rSDng==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tnBSN-000Jny-25;
	Wed, 26 Feb 2025 08:03:47 +0100
Received: from [85.1.206.226] (helo=[192.168.1.114])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1tnBSM-000ICX-34;
	Wed, 26 Feb 2025 08:03:46 +0100
Message-ID: <d98fe9b7-6206-4be0-89e2-312e25909a04@iogearbox.net>
Date: Wed, 26 Feb 2025 08:03:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] geneve: Allow users to specify source port
 range
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, netdev@vger.kernel.org
References: <20250224153927.50684-1-daniel@iogearbox.net>
 <20250225182647.486772df@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250225182647.486772df@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27560/Tue Feb 25 10:44:40 2025)

On 2/26/25 3:26 AM, Jakub Kicinski wrote:
> On Mon, 24 Feb 2025 16:39:26 +0100 Daniel Borkmann wrote:
>> @@ -1083,8 +1087,8 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
>>   
>>   		use_cache = ip_tunnel_dst_cache_usable(skb, info);
>>   		tos = geneve_get_dsfield(skb, dev, info, &use_cache);
>> -		sport = udp_flow_src_port(geneve->net, skb,
>> -					  1, USHRT_MAX, true);
>> +		sport = udp_flow_src_port(geneve->net, skb, geneve->cfg.port_min,
> 
> nit: we do still prefer breaking at 80 columns if it doesn't make code
> less readable.
> 
>> +					  geneve->cfg.port_max, true);
>>   
>>   		rt = udp_tunnel_dst_lookup(skb, dev, geneve->net, 0, &saddr,
>>   					   &info->key,
> 
>> @@ -1279,6 +1284,17 @@ static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
>>   		}
>>   	}
>>   
>> +	if (data[IFLA_GENEVE_PORT_RANGE]) {
>> +		const struct ifla_geneve_port_range *p =
>> +			nla_data(data[IFLA_GENEVE_PORT_RANGE]);
> 
> nit: would be more readable as fully separate assignment
> 
>> +		if (p->high < p->low) {
>> +			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_PORT_RANGE],
>> +					    "Invalid source port range");
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>>   	return 0;
>>   }
> 
>> @@ -1450,6 +1451,11 @@ enum ifla_geneve_df {
>>   	GENEVE_DF_MAX = __GENEVE_DF_END - 1,
>>   };
>>   
>> +struct ifla_geneve_port_range {
>> +	__u16 low;
>> +	__u16 high;
> 
> I agree with the choice in abstract, but since VXLAN uses byte swapped
> fields I think we may be setting an annoying trap for user space
> implementations. I'd err on the side of consistency. No?

If this is preferred I can change it, it's an odd/useless back and forth
dance for sure in vxlan, but if consistency is preferred I'll change it
this way and note it in the commit message.

>> +};
>> +
>>   /* Bareudp section  */
>>   enum {
>>   	IFLA_BAREUDP_UNSPEC,

