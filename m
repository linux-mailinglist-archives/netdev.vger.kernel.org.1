Return-Path: <netdev+bounces-77983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF817873B2A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688191F207C7
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FBE134CFA;
	Wed,  6 Mar 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KJwbupaz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9F5F875
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740287; cv=none; b=cQFt0rS58av5YTZmAmNccXhpebheYvRJRN9EO3IQgDNSBESR9YkXQaNNSDIcquMIfH/vRq+7cXrR7wjscnW+LMbCvy+iSpG3cTKQv39ndYvusj9YDo7BM5fz1d7Kykx0D4pWi0F9ZvlOBaWBXEztQbilOVfknxZ4XyUvtywPpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740287; c=relaxed/simple;
	bh=lT7DHS1+ZrIeoxIWf+5tmxvt7UaWZthd1lxaLMEZsVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3C9sLFoPM3GLpG96KNz8sjZi0MVukiR6yUZ0kmVRy+P2HQcVzSC5m5CbTng365/4CONahXhG7vic/UaCaD6KGqj6xAUbwsBuFbo3777/Fp1ZxQw3WMVWI1OVQ3S9R3dQk4mYdKmlEqD3aoOzqr5FxkpSWRp/wWapB5FK1912CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KJwbupaz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44628725e3so914424466b.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709740284; x=1710345084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1mCPWLvgATFDRDHDGKQS0sRiuISFFBwMzXPj3W81CSo=;
        b=KJwbupazdh0Mf4NejlRMxLfTMjm/Hh5xcyAo/qAcoiN+EQdMKPkzQ0GxjP7PWnUozu
         oD+N0tNeuj6o5tw5n8Tbc/3KtACr6nz3wzzML9YQd+gsxREEesgXYYBiz3Ja9JTthpgn
         neNPhB8RvmnLImm6v3gC5abKyqYmYERVOvGGNZzEL/so6lREWdfzcc9eH3hR8UiVnQqf
         TeKkdEJw422s/JvzYGynqdxLNwSM4XLkMc+msyCVmKEr9vry7SojQOiXraA2M37RyMI3
         KYHqoSvoGH/cGLgQTWL0n7a69Oz2acnNLRgyZSid7zQxkD3sJe8doQoMNqQs9NF8vv/e
         xRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740284; x=1710345084;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mCPWLvgATFDRDHDGKQS0sRiuISFFBwMzXPj3W81CSo=;
        b=m6/wrK6RLEiGdoB9tGvzIvrIBIDmqy0bg2P29H9SaUPi6z9QqPXe1UF2kCq1XuyLAR
         WZeo0EbL5fQIv1IvtxYch1ITp4rO4E7hK33nQYBUWoQvZHNBUYhoXLznrRiXs0Qj0JpZ
         LX4msgjIqTEhwEbqeeNCtLXS5zGe5G/VBPI4MMi7uyEcgA783WjFEtTNlgH1kVuxomFY
         vzueI2Hp9y69C5+vlcA0q4BDTZKj000llI9mnTLIkqsCzpmafCyWXNPbX4Iw9K8nDf79
         DeEtn2IPQBk5NIS8Io+vRFW2rPY22/7rBQax2yQNvizQMI/bMX3Pi+iu2YpRwZlejLtE
         MqQw==
X-Gm-Message-State: AOJu0YzQ6w2E4+ftm/BY8kzK9I6h/Z5fe60kPbBPzG+D+AkHvpT2T90h
	4jno5ICzk6xLTHQ9Ei86x5gTzV8b2y/Kp8DTKsLzKAVwZmbkWJH6FfCbVd+sIV0=
X-Google-Smtp-Source: AGHT+IHkTz80kULdeWVJJnjdPNr1mHVv1VLIKjwkvAUJUgLN5pnCyre7oc3JpRs2+nNV31R1uLPKJA==
X-Received: by 2002:a17:906:b00b:b0:a44:c583:dfc8 with SMTP id v11-20020a170906b00b00b00a44c583dfc8mr9233866ejy.48.1709740283742;
        Wed, 06 Mar 2024 07:51:23 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:2746:4b81:593e:203b? ([2001:67c:2fbc:0:2746:4b81:593e:203b])
        by smtp.gmail.com with ESMTPSA id jp19-20020a170906f75300b00a4573defc37sm2978222ejb.44.2024.03.06.07.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 07:51:23 -0800 (PST)
Message-ID: <f0dbd495-5d27-46e5-a615-3e6bdcd0948b@openvpn.net>
Date: Wed, 6 Mar 2024 16:51:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/22] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-3-antonio@openvpn.net>
 <1f63398d-7015-45b2-b7de-c6731a409a69@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <1f63398d-7015-45b2-b7de-c6731a409a69@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2024 21:47, Andrew Lunn wrote:
>> +		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
>> +		IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
> 
> Wireguard has the same. How is Linux getting confused? Maybe we should
> consider fixing this properly?
> 

I wanted to reply to this point individually.

The reason for requiring this setting lies in the OpenVPN server acting 
as relay point for hosts in the same subnet.

Example: given the a.b.c.0/24 IP network, you will have .2 that in order 
to talk to .3 must have its traffic relayed by .1 (the server).

When the kernel sees this traffic it will send the ICMP redirects, 
because it believes that .2 should directly talk to .3 without passing 
through .1.

It of course makes sense in a normal network with a classic broadcast 
domain, but this is not the case in a VPN implemented as a start topology.

Does it make sense?

The only way I see to fix this globally is to have an extra flag in the 
netdevice signaling this peculiarity and thus disabling ICMP redirects 
automatically.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

