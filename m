Return-Path: <netdev+bounces-152050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B43B9F27D9
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 02:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55BA07A18E4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4B2481B7;
	Mon, 16 Dec 2024 01:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="fGaYbsZi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958323B2BB
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313319; cv=none; b=FYrYJdnqBwt9/ffUiBlyEdbUQ9jkAtlKCfaE3QPox/Ucuqtv1y23CtRWF1uZ5zgWjTyC/srICgZxn0sXuWdg/bvSEHi2pjRIdHjU/W/iww46iXnpBgGCtZ2/AUOftwlAhmSmCNdzxBa2cWCWOQe4L4jsaTcrf35e7jORIA+p2mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313319; c=relaxed/simple;
	bh=KAseietMcSd1cqIE/m0Ppz4h0BFe9RHtdsYjXvu4vWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTBoOArdptNJ4zoptBqIRNdX3dQbZzZ5NPHfLgAfWEsg5gjsMg9Ri7Lhu5mrhariALVR7P/u74J9NlODnkQ+FhSVYXehXuEttbE2C9A4fgmxYW6XhZQLYhiQMz0/ZA69Mayj4WtYtL+zUVz0ltK0chgC9VTok4GsirjfOlp7l9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=fGaYbsZi; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728eedfca37so3697078b3a.2
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 17:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734313317; x=1734918117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tgt0LVWkio+MNnYLIWnc2ELHpe9XP+OcFWoogaiEoKI=;
        b=fGaYbsZilaGSYiFwIjUOZSjbf9+OqIs9sQDca8ojPSFvNHDFDR6LeWWrjZb5yY8QyL
         jCFP1GQVfKbXd5ggQLnkwQaxOh9M5Xhq/ygydbKmWDoMAGSRQy5wc+h/qW5zo+cfm5BF
         D74wue+cIFlUMHpfM5zw83wlVnLQo2UUJqVI6e428115D1WTBe2t2+H5zeo38Tx5OlRm
         eItRH1cQnF+k76xJfyy5F3K0ZWs/JVhXazmZei4iPr2CuCL8awZ929cmJTMDHySL4v91
         2tbI10J2elvZVLCSve4ZSodXn0744Q9CI4McjEtYzaKSFoUMS4jdZn4NvePU2Sf4b9hO
         UEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734313317; x=1734918117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tgt0LVWkio+MNnYLIWnc2ELHpe9XP+OcFWoogaiEoKI=;
        b=fUvmt2VgngYoS4hqAGf//ugy361U/ihqjiS9aa90DR80RF4jE7ixb6jbHotirTszL1
         C1oRMdbhAu0PJEOhrRoZB48f/BZ0VVgysAB9AtoapZ4l5MDwEs1ugS3H/s1NHx+Efmjb
         ffqgmOzvgqAr57KjHJ4uYv3qEqGZN5ZRfJcrek4H+IDRTyi1rTrfgePymVA7WY7tXDGP
         dAYspikc25SwgctXoYQr40pw9PnI488dAukY3GlTnUsP4uBKyGQIHnOGxyuPvq8AgVbA
         sKFL2XWZmb6TCVlUVY7EADFGbbYPbvZwMjiz1A/VGwZqOF8ODt3FjGdv5im+32k39G9N
         D2DA==
X-Forwarded-Encrypted: i=1; AJvYcCUmXDt8RH6dYbzZeoCR2wPyjtYwuEwivMEF52CHW6wOLBMmYwm9u1lom1oe4BqrneXbqng+uF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7WygejBy6/IbwjPXHWzlvKvnT8H8mMSK5daOv3RRm7IEXmJph
	CF1Etl8KbCHauUSVhd9RQfOJVz0qwDYcAMdZpsF1rfwRk7GQhMNuDp5cO54SNvo=
X-Gm-Gg: ASbGncvLz8WeW4VOCRr0H5ofg8Rf+j9Jjsalp73fixY5O/yHwZUBrF4/8NwetWtTnuZ
	aE4HbNDyk3PbeW9pHxaZCiyNrU64buXOV5iCGh2E2EN2R0dTO7RPOVHDL/dhMJtGq6Xf7N/Q9hD
	JEegeftrFD6x21HmgCShABluY3o/OHEvhiP0Q3yAPrJdSy4UWaiYUhlC9sYtbAIRHH1stgX3OSV
	fxcIDsn3iOH0yAqM1T6KmOlYs+GP6+U5HwQIRpsafsEdW3HKGfANOd3jPTiYoccZXRtS9G6frOQ
	YhHTs+JwhV+xQEQ+e/JkDK8NDVIevz3KFQ==
X-Google-Smtp-Source: AGHT+IE8QmKtKjDPvSQJMTh8vfYdLI2NhbYM1GJb5cWIvipOSJrrrU+ZctrPtdFA8QwFFEqPRXTfoQ==
X-Received: by 2002:a05:6a21:3396:b0:1e1:f5a:c027 with SMTP id adf61e73a8af0-1e1dfe5c22dmr14699745637.43.1734313316807;
        Sun, 15 Dec 2024 17:41:56 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c3662csm3104530a12.71.2024.12.15.17.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 17:41:56 -0800 (PST)
Message-ID: <af6056e1-8cc8-4f2a-a94a-061cba63a2ef@pf.is.s.u-tokyo.ac.jp>
Date: Mon, 16 Dec 2024 10:41:52 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mdiobus: fix an OF node reference leak
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20241215112417.2854371-1-joe@pf.is.s.u-tokyo.ac.jp>
 <f68d5c96-ac9f-4042-8f00-c6641d06eee4@lunn.ch>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <f68d5c96-ac9f-4042-8f00-c6641d06eee4@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/16/24 01:06, Andrew Lunn wrote:
> On Sun, Dec 15, 2024 at 08:24:17PM +0900, Joe Hattori wrote:
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
>> Changes in v2:
>> - Call of_node_put() after calling register_mii_timestamper() to avoid
>>    UAF.
>> ---
>>   drivers/net/mdio/fwnode_mdio.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
>> index b156493d7084..456f829e4d6d 100644
>> --- a/drivers/net/mdio/fwnode_mdio.c
>> +++ b/drivers/net/mdio/fwnode_mdio.c
>> @@ -41,6 +41,7 @@ static struct mii_timestamper *
>>   fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>>   {
>>   	struct of_phandle_args arg;
>> +	struct mii_timestamper *mii_ts;
>>   	int err;
>>   
>>   	if (is_acpi_node(fwnode))
>> @@ -56,7 +57,9 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
>>   	if (arg.args_count != 1)
>>   		return ERR_PTR(-EINVAL);
> 
> Is there no need to put the node when arg.args_count != 1 ?

Yes, should have caught that. Fixed in the v3 patch.
> 
> 	Andrew

Best,
Joe

