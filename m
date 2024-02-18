Return-Path: <netdev+bounces-72758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D6085982C
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 18:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD332812F0
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 17:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28176EB56;
	Sun, 18 Feb 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy1tUovI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E38335D8
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277518; cv=none; b=l6fBXfq65KkHCMtRqtMggXzU3tWxA/nL0QNBzCcKlF4+/9Y0AqNAmvy9yW+MkulsFVcA/3P9Hgi64eLiRNBsY0uMEeQJ2WxZBD1NnGKczNs85oi1VHJm6GtmDaXV5iHWIyp2p44l0SGCf/12fxHS1lL7OTMWqY9pnLImY11vpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277518; c=relaxed/simple;
	bh=93+hCgmDYsJj3s1oLfv74p/ijjjqcRXJ0g5oa3HGDnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpJuYApowNwq44RzXrD0EpKbAy0eOVXW9jt6cbfMABYnR0dESRi4y3lRoA0kASdFRI9C206f5niwYYgUHEVRr16lUnxl3LPrAEjzf2pnuHznlGvcP4mgsKLwdo85ENXWcGti7tiSykVEMC6KLNJkcnLO3NFY43WWhyhOH5FpYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy1tUovI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d21e2b2245so27330961fa.0
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 09:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708277515; x=1708882315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XukI7iUOGfixb/AepjRX05CG00Un6vBhI4ipHZHzQ70=;
        b=Hy1tUovIIHAZ/65tUXOMNsNlJwGVZa8Dk8ND8oVt8rxzYUauhYGbaIQ7YAnuoXj5wn
         lkRsKWlIN0VKOuMelcOslOvZTE/oNa+pVS5Iytk/fszGvO2IeTUfGMC1NmV9CuMIxDdY
         Rr/bV+HVXDo+t1iz7W0nmQP0zU7TH4HKch9LYQWchtoP/sve2gnyrftdHU9NImnoIv//
         VhORBvhJ6Lo1bZtPlm4GC8pwYI/CVYkxbIamcgmWJshS3ePGjs6xpq1A0xyvSN0U0+n6
         Y8D7ZqX3m80DcBNuAbHQCowvG+OzL9GqTV+HCm4fzKHzICI+5cCv6CZi+OMPt2SB2b3P
         AASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708277515; x=1708882315;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XukI7iUOGfixb/AepjRX05CG00Un6vBhI4ipHZHzQ70=;
        b=MlYAJVt/l9aZcnC/XrdmH3NvmxWwXnhTItDsrAlNgd3MA+cgMMVmWqyKwTf8DZWrVQ
         0XX4WTgvPxtZJDMI2saqm9u/cqDKKXzU+1elBEccSoL0mWCA31P8PZ7oawCdMfWz+VH+
         0JenzC9+U+jce1bGY8lUZSX8sgT4Q7qOLpo3ypKkOOJCwCFQblOe97wImG3k20CeVq4g
         8MpaHozCQIWDGwtSaaZlqcdCWT8JdT9SWUmqyLdzFZsq5ZD2Jp7kiprD7dskJhd+5Uvk
         EOewEXOqX+wNlLbPyv5YezZDWqOqstRfAEpwTvKn5WGVUymZb7eacfKQNfO6qZT5gyJ/
         Lvyw==
X-Forwarded-Encrypted: i=1; AJvYcCVFlI3UguAG9JbcIcrFFsQnnQwicw2J3S4V0Hfuvv409SBcfhxX+pNxgxStXcb6vKVg+GuC3tf9JdiFq3xHp+Rf8Jl28ekx
X-Gm-Message-State: AOJu0Yw+fFWzlEAlHMI/Ff7gb0aq/sQjuXDc19JnhW3DNbSs1PFrXeTX
	X0xbFq4vmA2kJsKWkX/MEWM8Hld/7PbPq/goSA5htT63SF88ir3N
X-Google-Smtp-Source: AGHT+IF0TRH4fUtPCB4+TVxXeV2cJsxh8kvr5VoKq4P7hDQ215Hha1ew83XcaxISu5BDv7t6XEoWbw==
X-Received: by 2002:ac2:4c81:0:b0:511:acd2:e627 with SMTP id d1-20020ac24c81000000b00511acd2e627mr6041891lfl.67.1708277514853;
        Sun, 18 Feb 2024 09:31:54 -0800 (PST)
Received: from ?IPV6:2a01:c23:b9e5:d800:2cda:54d5:8742:3de1? (dynamic-2a01-0c23-b9e5-d800-2cda-54d5-8742-3de1.c23.pool.telefonica.de. [2a01:c23:b9e5:d800:2cda:54d5:8742:3de1])
        by smtp.googlemail.com with ESMTPSA id g30-20020a056402321e00b0055c60ba9640sm1927105eda.77.2024.02.18.09.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 09:31:54 -0800 (PST)
Message-ID: <90952624-d473-45b1-8bae-8fc31d36213f@gmail.com>
Date: Sun, 18 Feb 2024 18:31:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tg3: copy only needed fields from
 userspace-provided EEE data
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <59bd00bf-7263-43d9-a438-c2930bfdb91c@gmail.com>
 <14978af2-0b94-4677-b303-da7c690abcca@lunn.ch>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <14978af2-0b94-4677-b303-da7c690abcca@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.02.2024 18:04, Andrew Lunn wrote:
> On Sun, Feb 18, 2024 at 03:49:55PM +0100, Heiner Kallweit wrote:
>> The current code overwrites fields in tp->eee with unchecked data from
>> edata, e.g. the bitmap with supported modes. ethtool properly returns
>> the received data from get_eee() call, but we have no guarantee that
>> other users of the ioctl set_eee() interface behave properly too.
>> Therefore copy only fields which are actually needed.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> This one needed some time for me to understand. I missed that when
> programming the PHY to advertise, it is hard coded what it actually
> advertises. So there is no need to copy the advertise linkmode from
> edata.
> 
Especially as we have the following a few lines earlier:

    if (!linkmode_equal(edata->advertised, tp->eee.advertised)) {
                netdev_warn(tp->dev,
                            "Direct manipulation of EEE advertisement is not supported\n");
                return -EINVAL;
        }

> I suspect this driver is broken in that it does not wait for the
> result of the auto-neg to enable/disable EEE in the hardware. But it
> could be hiding somewhere in the code and i also missed that.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew


