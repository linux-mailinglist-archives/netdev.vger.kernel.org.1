Return-Path: <netdev+bounces-147785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5A49DBC96
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 20:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17B2280CB6
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 19:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0D01C2432;
	Thu, 28 Nov 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPFPBd9+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625EB1C1F2C;
	Thu, 28 Nov 2024 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822540; cv=none; b=G7xMXaSZAr0hsiSR8hFiVQImL0EG3jcxfd0XiuBQJzQS6XXOlKb+t/BUJnMYJraT619zIGq/J8mGfzH3Y+YYaHt+5joeZBlXiYguO4tDoBEfRlDaJTvpcv+M28abFOcOE2lmbDOBHEud+rESw5MB9xG+I9IO7ORdQKO5CeM5seA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822540; c=relaxed/simple;
	bh=8wiOmAsjNwl8fiT9mRB1qAIMR+940eqpfQsk3U7i0w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBbQWlWfbh0uCf4vws7d3TIhu4Y0zDe2K+hCh80Szzox9e3Q0eiPGSA/TzpicbHhdnzT41faOzAjFCMhgfTfcXF7fetc94P1lpjA32fpi6Zd3UM0MmKpLmCpByezK8AoL/jkpa3bQRXEE65L0GQArWjrnV2Eyh24Os49Vqq//CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPFPBd9+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so1235884a12.2;
        Thu, 28 Nov 2024 11:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732822537; x=1733427337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KeDAASwBlHDFGa4xcwgP3df7fxHSJQd2gy8hnUBpdAs=;
        b=VPFPBd9+k4XI0VRdhajTQo83eNXn1GlIJOJ19uYUTl3ON5whBMTysJSecWaweOR7ax
         ii9wYy5Jze1NnPp0bLTtY9aUzfzVHo3ZlcCKND0UeO6ppDedyRi2M31d5Cq+ddXqyfQV
         WRo9JxKr/Pw33Cslyug8nKgq3g+epvy27vTmlKwAUa2txGvwnsmPN7b9sBpWl3sflbON
         LGkWmmX/zD0WETdlMAGg08aV0CV5r6jU5QirRfLXrQjDUKWvfI4F41S/gcVO1fYUvYOp
         hkhAkJRrRN6nC5J2391UIkQpcM0mBcSXGnTNgfxQbsvmRORxFQDmpS+XOS8/lUHS5eHX
         DYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732822537; x=1733427337;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeDAASwBlHDFGa4xcwgP3df7fxHSJQd2gy8hnUBpdAs=;
        b=PFj8xouwVJMA85Oh6ZfcAyZVqlQLKkhDe0P/uK9UxOyPU/+4Ng3NUwH3tQLnx29Uxj
         5ygIMo5vbBM8i+6LKLvyGi1/xch5XJsrQUlbq8qPOi/MK98Ynmi7x5lyuAAxdvDAIQ93
         /71BtNmrat1skSXc+acNmLLa+O5MGe2NpAudkU8rQlqDqo62Lnj3NDDZA8814bgoo8v7
         TwvyCKZ6y44hzHY/LAIscAHdNZobFZkRcE6wld1g+XWzc0tSHoI9kMJS/GcaYSOOaG+f
         7Sqy1uC6bOqKN+XaCYxjI7znZ//9FPiZTUOak3fNjd5Szs+X/NJLvElfYfJd9IkvfcIH
         a6ug==
X-Forwarded-Encrypted: i=1; AJvYcCViQgrsFBioAh0EmGNY7kqrEbY9mGZ8aGwwCIT3N167+f03W05lq50ziJTDHcrCrmr4aGLo5K8/k0fa@vger.kernel.org, AJvYcCXbsFqxG7Hhhskm4zkmv160RnUhHPg/NZ/599kn+/Xf9Zhg09zcS7Q+6WUIIpWeGjUEo4MlNGNLlyHzgJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2TF1R9iwiUNiyb1PPCDPs/Usv3RtNiXus0F/dPMxXaLq4Kq2n
	n8zjHo3Btx+52u2zGYaizO/yzoHu42hQW9v/AQRSd6Ct8848MZa0f8cjIA==
X-Gm-Gg: ASbGncsvVG3mX0HsjCBNHNMZVzK6RwRTGodhyHuA+URptvLQIa+68SN06Ql2yNE8Utf
	mbfSKrNjkio84vgStQJoFINrhEpnLnCK5oPH/94vVDQGL2WgnrIDhXU1GlEpLnF806pqtsZxNXh
	nmCit8ABtHnG+PQpyovpsvdy6hLkdd5UXOEGOsOuTurvzXRJLqzh/Z1v7oVIHaYo+UCF7/G9Z0+
	auq7K8zveYAPMuUlLQCbOFogQdC+EDGwhPWFhq5ihBGsjF+TZA+FJ0sA9qTI1oMZpGiU4rQnTbr
	pw2GqRPlHTciBXEqtnjbVBLVtCauwTta2KUJe91q+xkB0Ul2APt6GcN2wmzMoiuOaGFtj7M9QtJ
	lzZ5UgQl2tg5bxKY2YMLccuicVe/ftDcsyPheMis=
X-Google-Smtp-Source: AGHT+IF3VVGIw2+q+0jTV6Z0WIRw6WZLoc5nFc//iAs9oZ0JhrFo2N8L42N3d5kHL4MMMCqA2QpvYA==
X-Received: by 2002:a05:6402:3711:b0:5cf:dfaf:d60e with SMTP id 4fb4d7f45d1cf-5d080c3d972mr7627847a12.14.1732822536377;
        Thu, 28 Nov 2024 11:35:36 -0800 (PST)
Received: from ?IPV6:2a02:3100:a4d5:f200:38b3:54e:f670:c62e? (dynamic-2a02-3100-a4d5-f200-38b3-054e-f670-c62e.310.pool.telefonica.de. [2a02:3100:a4d5:f200:38b3:54e:f670:c62e])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dafd48sm1052032a12.22.2024.11.28.11.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 11:35:35 -0800 (PST)
Message-ID: <3912e9bc-b51c-490a-8d64-9d4eb91db7c5@gmail.com>
Date: Thu, 28 Nov 2024 20:35:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PHY: Fix no autoneg corner case
To: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?Q?Krzysztof_Ha=C5=82asa?=
 <khalasa@piap.pl>
Cc: netdev <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
 Ming Lei <ming.lei@redhat.com>
References: <m3plmhhx6d.fsf@t19.piap.pl>
 <c57a8f12-744c-4855-bd18-2197a8caf2a2@lunn.ch> <m3wmgnhnsb.fsf@t19.piap.pl>
 <2428ec56-f2db-4769-aaca-ca09e57b8162@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <2428ec56-f2db-4769-aaca-ca09e57b8162@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28.11.2024 15:54, Andrew Lunn wrote:
> On Thu, Nov 28, 2024 at 07:31:48AM +0100, Krzysztof Hałasa wrote:
>> Andrew,
>>
>> Andrew Lunn <andrew@lunn.ch> writes:
>>
>>>> Unfortunately it's initially set based on the supported capability
>>>> rather than the actual hw setting.
>>>
>>> We need a clear definition of 'initially', and when does it actually
>>> matter.
>>>
>>> Initially, things like speed, duplex and set to UNKNOWN. They don't
>>> make any sense until the link is up. phydev->advertise is set to
>>> phydev->supported, so that we advertise all the capabilities of the
>>> PHY. However, at probe, this does not really matter, it is only when
>>> phy_start() is called is the hardware actually configured with what it
>>> should advertise, or even if it should do auto-neg or not.
>>>
>>> In the end, this might not matter.
>>
>> Nevertheless, it seems it does matter.
>>
>>>> While in most cases there is no
>>>> difference (i.e., autoneg is supported and on by default), certain
>>>> adapters (e.g. fiber optics) use fixed settings, configured in hardware.
>>>
>>> If the hardware is not capable of supporting autoneg, why is autoneg
>>> in phydev->supported? To me, that is the real issue here.
>>
>> Well, autoneg *IS* supported by the PHY in this case.
>> No autoneg in phydev->supported would mean I can't enable it if needed,
>> wouldn't it?
>>
>> It is supported but initially disabled.
>>
>> With current code, PHY correctly connects to the other side, all the
>> registers are valid etc., the PHY indicates, for example, a valid link
>> with 100BASE-FX full duplex etc.
>>
>> Yet the Linux netdev, ethtool etc. indicate no valid link, autoneg on,
>> and speed/duplex unknown. It's just completely inconsistent with the
>> real hardware state.
>>
>> It seems the phy/phylink code assumes the PHY starts with autoneg
>> enabled (if supported). This is simply an incorrect assumption.
> 
> This is sounding like a driver bug. When phy_start() is called it
> kicks off the PHY state machine. That should result in
> phy_config_aneg() being called. That function is badly named, since it
> is used both for autoneg and forced setting. The purpose of that call
> is to configure the PHY to the configuration stored in
> phydev->advertise, etc. So if the PHY by hardware defaults has autoneg
> disabled, but the configuration in phydev says it should be enabled,
> calling phy_config_aneg() should actually enabled autoneg. It is
> possible there is a phylib bug here, because we try to not to kick off
> autoneg if it is not needed, because it is slow. I've not looked at
> the code, but it could be we see there is link, and skip calling
> phy_config_aneg()? Maybe try booting with the cable disconnected so
> there is no link?
> 
If the PHY driver has no config_aneg() callback, then genphy_config_aneg()
-> genphy_check_and_restart_aneg() would set BMCR_ANENABLE.
Not sure about which PHY driver we're talking here, but if it has a
custom config_aneg(), then setting BMCR_ANENABLE may be missing there.

>> BTW if the code meant to enable autoneg, it would do exactly that -
>> enable it by writing to PHY command register.
> 
> Assuming bug free code.
> 
>> Then the hw and sw state
>> would be consistent again (though initial configuration would be
>> ignored, not very nice). Now the code doesn't enable autoneg, it only
>> *indicates* it's enabled and in reality it's not.
> 
> I would say there are two different issues here.
> 
> 1) It seems like we are not configuring the hardware to match phydev.
> 2) We are overwriting how the bootloader etc configured the hardware.
> 
> 2) is always hard, because how do we know the PHY is not messed up
> from a previous boot/crash cycle etc. In general, a driver should try
> to put the hardware into a well known state. If we have a clear use
> case for this, we can consider how to implement it.
> 
> 	Andrew
> 


