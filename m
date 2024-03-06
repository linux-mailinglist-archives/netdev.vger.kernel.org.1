Return-Path: <netdev+bounces-77979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B85873AF1
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826781F29B04
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BC81353FF;
	Wed,  6 Mar 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Q1P5apdf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D861350DE
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739703; cv=none; b=D3OArGPIsc2ImqxkWHd7PUjooPVEhYgyAfHPglXBkBDG08gobjFQQncGB+bYxstK9bWycGtUZIYyZq0LQxFZEe1aLsBR+g7YHQf6kPOmBH+Vyq7xYRfJa3oDmOSdualvnKjtxhU0Gy12MJYdBjmjnT5hdNfQS5zclMH4OmQPHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739703; c=relaxed/simple;
	bh=irfB5sNc51cmKkv4ekOxJzW6umvgRZJRmoYWJsdKmno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zz5KI//ChOR7KVSyMdeo054UZRkeycerpXqWZLFa5v9NkG5Vn+s28YYq9dxeZ9dPeH7cs+OcSZBPUNebyl7hCIxMjXJYV67JgJiGJeTd6JhLOA7zGAtgbA3CJQULstHpzsOTWTfY4Gxl4GDk3sELIGhohDw98ht8aqGNKAAdz64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Q1P5apdf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44d084bfe1so590075966b.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709739699; x=1710344499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6p3705fgG5spcJJCmt/zGAtfFPKrsHhWDL+NxRal3E=;
        b=Q1P5apdfv8/jMIuhJsb5VL6r9Fnl41uIHr/vDtJdWeC+rH7YvhaHbiB6vEGLU1aTnE
         3nrtBL4VGu0I5Xf+0s3XpRH313O4wmTot5J4udPFinxWJPNX6RZ0/GmQsDP29JRisNSn
         oPwSWxTurOwLO87G3MvpcGqh1tbtVkbyF0kHW1JKp9GfiXmsZDrRC8k/t47APThvMGdc
         FtuY/nhu99AnRJejEnF39AdWoonS/LsRtBLa78WbKsSsQWHV+lifEYx01QoKVTNwtqQx
         hq257ihED8UVOcJI42OM3aAL0uJArVfJdLpv/Zrbf4AII4PuIMAlWXlCcZAoW8ERrYKp
         R6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739699; x=1710344499;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6p3705fgG5spcJJCmt/zGAtfFPKrsHhWDL+NxRal3E=;
        b=Q+DseA/73wVD6MVpbxh22le4JOBtew6neiZjcvIrBnk6xhQ965qoW0ac/exfsyVhqg
         WRI2/kFceB6bXR9ulcYocXgT2/ayOPJREjNjwFKohmKrCdWBU80Gh/WWZDaZw64ThHi1
         +kzNp9nwksl8vBJ8Vv5z3vlCE0+97DFtKcl0Ms7Hl8URsbdU0YuCr6Iiu0YLfVJDeaJh
         Hx60UFDuQFa59yNHYcdQdGN9I/qZY47cKnB16CBEq018iuwmXXq8zOLijgiOVwQps0QF
         n5ipB5n+z78ptdBFTENAvyfRAhNjGbtt+KigI+pcC/UN5zkEMuXWQRunI33olrM3vOQZ
         uIlw==
X-Gm-Message-State: AOJu0YyPncIyrgxpSRfHRZpH4ZlawAKJX8nYMbZto1jhsZ+PV7FZ+iAn
	O2JFrc+l/mMzt7a1DwEdiwBqlnKn4YVFNx4M95gB2tPQqR/NbZ+QLYIzowU+v4A=
X-Google-Smtp-Source: AGHT+IE+kqIMu8UQMugqOn5GCbot+haSkhXmNeHBh74QR3i+/1fIymvuWpPu9gNheP+SDbokvR6SMQ==
X-Received: by 2002:a17:906:d20a:b0:a44:505f:bfa9 with SMTP id w10-20020a170906d20a00b00a44505fbfa9mr9602377ejz.58.1709739699566;
        Wed, 06 Mar 2024 07:41:39 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:2746:4b81:593e:203b? ([2001:67c:2fbc:0:2746:4b81:593e:203b])
        by smtp.gmail.com with ESMTPSA id pv13-20020a170907208d00b00a451dc6055fsm4105706ejb.212.2024.03.06.07.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 07:41:39 -0800 (PST)
Message-ID: <25cc6fba-d8e5-46c0-8c16-f71373328e7d@openvpn.net>
Date: Wed, 6 Mar 2024 16:42:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 22/22] ovpn: add basic ethtool support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-23-antonio@openvpn.net>
 <57e2274e-fa83-47c9-890b-bb3d2a62acb9@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <57e2274e-fa83-47c9-890b-bb3d2a62acb9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2024 00:04, Andrew Lunn wrote:
> On Mon, Mar 04, 2024 at 04:09:13PM +0100, Antonio Quartulli wrote:
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   drivers/net/ovpn/main.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>> index 95a94ccc99c1..9dfcf2580659 100644
>> --- a/drivers/net/ovpn/main.c
>> +++ b/drivers/net/ovpn/main.c
>> @@ -13,6 +13,7 @@
>>   #include "ovpnstruct.h"
>>   #include "packet.h"
>>   
>> +#include <linux/ethtool.h>
>>   #include <linux/genetlink.h>
>>   #include <linux/module.h>
>>   #include <linux/moduleparam.h>
>> @@ -83,6 +84,36 @@ static const struct net_device_ops ovpn_netdev_ops = {
>>   	.ndo_get_stats64        = dev_get_tstats64,
>>   };
>>   
>> +static int ovpn_get_link_ksettings(struct net_device *dev,
>> +				   struct ethtool_link_ksettings *cmd)
>> +{
>> +	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported, 0);
>> +	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising, 0);
>> +	cmd->base.speed	= SPEED_1000;
>> +	cmd->base.duplex = DUPLEX_FULL;
>> +	cmd->base.port = PORT_TP;
>> +	cmd->base.phy_address = 0;
>> +	cmd->base.transceiver = XCVR_INTERNAL;
>> +	cmd->base.autoneg = AUTONEG_DISABLE;
> 
> Why? It is a virtual device. Speed and duplex is meaningless. You
> could run this over FDDI, HIPPI, or RFC 1149? So why PORT_TP?

To be honest, I couldn't find any description to help me with deciding 
what to set there and I just used a value I saw in other Ethernet drivers.

Do you have any recommendation?
For the other fields: do you think they make sense? The speed value is 
always debatable...The actual speed depends on the transport interface 
and there might be multiple involved. Maybe SPEED_UNKNOWN is more 
appropriate?

> 
>> +static void ovpn_get_drvinfo(struct net_device *dev,
>> +			     struct ethtool_drvinfo *info)
>> +{
>> +	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
>> +	strscpy(info->version, DRV_VERSION, sizeof(info->version));
> 
> Please leave version untouched. The ethtool core will then fill it in
> with something useful.

will do!

> 
>> +	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
> 
> This is also not accurate. There is no bus involved.

Should I just leave it empty then?

My concern is that a user expects $something and it will crash on my 
empty string. But if empty is allowed, I will just go with it.


Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

