Return-Path: <netdev+bounces-77955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 543288739C3
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2C0B2132F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571C71339BD;
	Wed,  6 Mar 2024 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FgUWU6Ym"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43758131759
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736570; cv=none; b=dQ4iTsi9fB5lhOFECN3CzkeLQKQcnEiGXWvSspta/L/dWqW1EOCFgvKiVuAHMiJSdmJHAjJ2DOKUBSvM3i3kGgMfWh6VG+TDSezAb7UBsRhMZDklMRpcaRuBsc+VHkPMqV7Px1UV0UU+OO7xP1CYx/g95tETswq+WxDBYsTnBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736570; c=relaxed/simple;
	bh=OcLy4qWUv3XQeKPbE7EhcFh8gmkytE86Kp4x0HYsWwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTKgzZZwRQlwlhoKfZFzlEzvBM4+hGFFDSQufntktdd8UDpH5y6Y8f6rYNdz9fIOjhtzYzk2y23LwVIuRABWUB0z4/w+CeRUzXdARLnUawJy4gSDz6sCJ8SaoLPJg/MGjk8dE9HQo9jVOm7xbPExt2r7mu/gWAstGky+KEnRpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FgUWU6Ym; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a450615d1c4so164176266b.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 06:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709736566; x=1710341366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PaCsQjKaMKozLjABx9NmyW356RPw1NJW6oP9lHb8f3U=;
        b=FgUWU6YmEAFoqaxZhLfNbijxxKaeD5YITQqjy89U20iHYB4LHaGPAz//J2EyozGa52
         3/cwRnxRn7coBUH3LMemlDYPbNRS9euYX1cyE2SbDJZofTEvDicpkJVfpJnL3llgpEJ7
         CHiJ/dWy5kjIv58abeKL92I6usmuPUciXMgcZg2dikSEwJRYyqvP9LP2siny/vHRgY5C
         YQk0lW5vt/CaKXdUzHmr2cldyQVsPLaFV8BsPhAJOnxp12nX+Ff7/FXC3Wh0DWtO3dGb
         znpkQnSmEp7cbKeXYibsnRk19zN8XeR5MLJdCfP+/sCsMALKQSXcseK++YTU4Ua7M6i3
         twug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736566; x=1710341366;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaCsQjKaMKozLjABx9NmyW356RPw1NJW6oP9lHb8f3U=;
        b=ma4VrD9ZmwqrtvVKm+8YFeGVpK/z4sYVgmfnN9tnjOfpWmpE9gkZtX/2pHfCYWdomC
         oatoQsj9+uxQJnTAYxPpzVnvheimQ+IuarUabnvKiLpZBvo25YVw+ahIuxObQ80R+z/I
         lyVVOCF1R/zpfOq/t0pS42jDxppAH5eDrBAulvAVM7Vl6dsWbjPEOstRdz98jVx2gu70
         Zi8alBuMw7wuGaltpGWmN1euAKQ7E4+wyjlt8mCvHZLN2TMVKOITZ2yWOmowJysMfnNb
         WIH+d6kOctgeEx3D2H9javpMzbREEXDAIxWRtc1zEzaVQd19crbbYQnQYk6Co356Qsb+
         Y7Tg==
X-Gm-Message-State: AOJu0YxHEfBz6PXcoq/+N5xtycfxOB5OZK4cPlQ/QN5B98szTnHh+C01
	ZleTddrk55OfpB63vsm8vNxg40Ag2qvb6OfxxU85ZDhWBbJbDiqes37ZxM2BVo8=
X-Google-Smtp-Source: AGHT+IFNZtpjQUrLR9pSnZ3s+ByxEqvKXhz7OLiW+qmmGLVIRVHb0dqF1zFwZaTwCaB57ko9ADvKhg==
X-Received: by 2002:a17:906:57d4:b0:a45:a2cc:eb93 with SMTP id u20-20020a17090657d400b00a45a2cceb93mr5903041ejr.4.1709736566580;
        Wed, 06 Mar 2024 06:49:26 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:2746:4b81:593e:203b? ([2001:67c:2fbc:0:2746:4b81:593e:203b])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b00a42ee62b634sm7152373ejo.106.2024.03.06.06.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 06:49:26 -0800 (PST)
Message-ID: <a9341fa0-bca0-4764-b272-9691ad84b9f2@openvpn.net>
Date: Wed, 6 Mar 2024 15:49:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/22] ovpn: add basic interface
 creation/destruction/management routines
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-5-antonio@openvpn.net>
 <e89be898-bcbd-41f9-aaae-037e6f88069e@lunn.ch>
 <48188b78-9238-44cc-ab2f-efdddad90066@openvpn.net>
 <540ab521-5dab-44fa-b6b4-2114e376cbfa@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <540ab521-5dab-44fa-b6b4-2114e376cbfa@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2024 17:27, Andrew Lunn wrote:
>>>> +void ovpn_iface_destruct(struct ovpn_struct *ovpn, bool unregister_netdev)
>>>> +{
>>>> +	ASSERT_RTNL();
>>>> +
>>>> +	netif_carrier_off(ovpn->dev);
>>>
>>> You often see virtual devices turn their carrier off in there
>>> probe/create function, because it is unclear what state it is in after
>>> register_netdevice().
>>
>> Are you suggesting to turn it off both here and in the create function?
>> Or should I remove the invocation above?
> 
> I noticed it in the _destruct function and went back to look at
> create. You probably want it in both, unless as part of destruct, you
> first disconnect all peers, which should set the carrier to off when
> the last peer disconnects?

I think keeping the carrier on while no peer is connected is better for 
OpenVPN.

I will then turn the carrier off in the create function as well. Thanks!

-- 
Antonio Quartulli
OpenVPN Inc.

