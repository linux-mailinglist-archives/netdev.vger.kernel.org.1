Return-Path: <netdev+bounces-258906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIipLBo2k2mV2gEAu9opvQ
	(envelope-from <netdev+bounces-258906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:22:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B69C14573D
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31081301C910
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FB931DD86;
	Mon, 16 Feb 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYzaxfOI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4131D72D
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255039; cv=none; b=R6zDisFOZPBaOkJiyaq1XGJLUkta2rh0oevp0nUyzgJfo3ztF8uKlCC3DvK707sBR/wOcum+AcDvqJK2GwEgoTtxvAgJWuOP25r/ZGarvuLcwIS5tr0kjTv80ISnnJS6P87o1tGCVHTufGmFf+Pw9spnYuesFhZjnCBf5PcZWgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255039; c=relaxed/simple;
	bh=HVqIbhWqa2dWbzKPrO+eXBu0tIwhzEG5l+aITsm6uoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KM8QySlFo5T6IuS4GBMtBzfudWHfbZBdh1l5sSO8ezg9KsHfJvAodC/5EkTGPCTkseNRtFL7z5rjTDyFzN943JO4FEkRM0shpqW/vcha09XaKSp5FdTCCmboCUnKvFG3a0esEqaWrZ41kgGLGrEKr077shZ5tqKikiDGCnUKIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYzaxfOI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so32681445ad.2
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 07:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771255037; x=1771859837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dCE3gF12Qsuc0Q0S4BkQq+M+t5dj53pHezYMH10XfpU=;
        b=lYzaxfOI4Zr8wlkdwGOezn/+ni9zjEQwEoNrtDNJ8r8C9GQw5cNh4LBHKDc6jDfQqj
         BrITYa/dHg0zitjKuBiTjIy9T22QpLLc+GOHJAlobd67u7AIGFTXA9/B+PIL2/RUkxB6
         IXQE1TkGxinFNpDBotgx4PcpsgTbTrXpPkGIJrgn4NWt8XqpLZ6/LvNQ16nQoBEjIwF5
         Zl914immoAN7rAnMfbP8d5e3CK2Vsp6IgEJTz3V4LqMg4qW96w93vTMf5jCPYNv3qY83
         bnjpOSiUphLRoM+XdnM0zXzaOBjKBPO6teFy7Ft6Co782ThrPInSfQ9iCLX4o5TqJtdj
         P51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255037; x=1771859837;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCE3gF12Qsuc0Q0S4BkQq+M+t5dj53pHezYMH10XfpU=;
        b=cKpoNU4LOdKneGAvylvqkAKJamIOltfizCAI4AqgYxaKJwZtkgEE8w+s0VEYz62osh
         jBtLAUk9dsR2VTRdmltueZa9RYOSSD+b1x3m5Jp9DcIpgX7g/sxfpD++5M1wdcNRHuf7
         LjdsEwK/mczYgqmWzClAkCgh9l83ikvCgjhhpooJRdboAUfej/Jlk8Y20+GgTWAwpkCP
         vZkvQdbYYQWVjTTT/U14hYxuqRp2EpcZFLImrfAzhWzTBl7uQCQAcyO4VQhCEtPCgqbh
         5AOxWl3XvX6b/vfVz9RvXVkH1tPe6I6p13EaboOm96ufcn5P8nsSr75so3YRYWumGlUY
         BFjg==
X-Forwarded-Encrypted: i=1; AJvYcCWZbjEyQcMjCosQN52cxLfvDjxZQjhNcQnuXvnkCEOmLAXsI6t4uiZ2ptvHDWJZJHF1178spfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjhiqtwj00S47+tJUQpJ9YtTCztlYfPwrmRYeyXFXYuVG/GgPh
	c5aGzxO1nUb1WEQHL4bnDLlxZRP7z/dInf77B19Yr8nvOXR2Jgt1wg0B
X-Gm-Gg: AZuq6aJCa83YOIpfPP0njm7clj0pO3323KuqmFs7KLn6WpvuaYKHJm/lcfMNWaf4z+b
	IhwLLJd7yyY+yV3h+Xlf1a7GbO5jaWh4u07+ZXDlQve9UBKQk17koCsjQoLT7DBCXZJz7U//env
	OCtGX/0WVpFzyj2JtKqNcqTQF6JW9HQfmwlO10M2+9NN9rhDHVlQxTfn8DoGEJ0V7Y4vp5K9liq
	fz8JCuzQxdE1Cn4194r1gCj09LHV19EVTnVr0rNAyQawXp8Hf0E/v54IdQjdGZutkTl2+yjvDac
	F+GU+IDxlLZ3MOz1FRvOGI+rpyTYKXSrXpf7+zO11fTo+C3ppF09+dzROISOvtCijYc6M047MDD
	Y4r4JyzDGC90laDmewh3uyX1jyI7wSWL/jmH1P1AVN61u2Z+1lSBB/lIr6hBmn4f5wcqB95J5Hl
	qjV0e/E/E3+25tQdtxVqWjtEIxSBARQtnZzDI31SUFsjjn5/G75clatMi8nxRoneErjR+uegWv3
	nSjS6XZzVA=
X-Received: by 2002:a17:90a:e18b:b0:354:a1b8:24a6 with SMTP id 98e67ed59e1d1-356aad7a8f0mr9075642a91.31.1771255036757;
        Mon, 16 Feb 2026 07:17:16 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a6b17c47sm5781823a91.2.2026.02.16.07.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 07:17:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <306e79fb-f3ee-434e-a90e-547e97d2a5aa@roeck-us.net>
Date: Mon, 16 Feb 2026 07:17:14 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: MxL862xx: don't force-enable MAXLINEAR_GPHY
To: Daniel Golle <daniel@makrotopia.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20260216105522.2382373-1-arnd@kernel.org>
 <aZMKXavVQPelSXcG@makrotopia.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aZMKXavVQPelSXcG@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258906-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,arndb.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Queue-Id: 4B69C14573D
X-Rspamd-Action: no action

On 2/16/26 04:15, Daniel Golle wrote:
> On Mon, Feb 16, 2026 at 11:55:17AM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The newly added dsa driver attempts to enable the corresponding PHY driver,
>> but that one has additional dependencies that may not be available:
>>
>> WARNING: unmet direct dependencies detected for MAXLINEAR_GPHY
>>    Depends on [m]: NETDEVICES [=y] && PHYLIB [=y] && (HWMON [=m] || HWMON [=m]=n [=n])
>>    Selected by [y]:
>>    - NET_DSA_MXL862 [=y] && NETDEVICES [=y] && NET_DSA [=y]
>> aarch64-linux-ld: drivers/net/phy/mxl-gpy.o: in function `gpy_probe':
>> mxl-gpy.c:(.text.gpy_probe+0x13c): undefined reference to `devm_hwmon_device_register_with_info'
>> aarch64-linux-ld: drivers/net/phy/mxl-gpy.o: in function `gpy_hwmon_read':
>> mxl-gpy.c:(.text.gpy_hwmon_read+0x48): undefined reference to `polynomial_calc'
> 
> I assume this happens in case CONFIG_MAXLINEAR_GPHY=y and
> CONFIG_HWMON=m, right?
> 
> None of the PHY drivers seem to adequately prevent such situations,
> which in my opinion would be worth correcting, ie. by preventing any
> PHY driver using HWMON from being built-in while CONFIG_HWMON=m.
> 

Technically, with "select MAXLINEAR_GPHY", NET_DSA_MXL862 should depend
on "depends on HWMON || HWMON=n". That would prevent NET_DSA_MXL862=y
and with it MAXLINEAR_GPHY=y.

Maybe it is time to implement dummy functions for hwmon API calls
to avoid all this.

Guenter

>>
>> There is actually no compile-time dependency, as DSA correctly uses the
>> PHY abstractions. Remove the 'select' statement to reduce the complexity.
>>
>> Fixes: 23794bec1cb6 ("net: dsa: add basic initial driver for MxL862xx switches")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> As there is no compile-time dependency, this change is fine.
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> 
>> ---
>>   drivers/net/dsa/mxl862xx/Kconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/net/dsa/mxl862xx/Kconfig b/drivers/net/dsa/mxl862xx/Kconfig
>> index 4db7bab21a71..3e772298cc89 100644
>> --- a/drivers/net/dsa/mxl862xx/Kconfig
>> +++ b/drivers/net/dsa/mxl862xx/Kconfig
>> @@ -2,7 +2,6 @@
>>   config NET_DSA_MXL862
>>   	tristate "MaxLinear MxL862xx"
>>   	depends on NET_DSA
>> -	select MAXLINEAR_GPHY
>>   	select NET_DSA_TAG_MXL_862XX
>>   	help
>>   	  This enables support for the MaxLinear MxL862xx switch family.
>> -- 
>> 2.39.5
>>
> 


