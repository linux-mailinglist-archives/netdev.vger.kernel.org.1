Return-Path: <netdev+bounces-122464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B330A9616A9
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AA31C22B8B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843BF1D31A7;
	Tue, 27 Aug 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez0OFoKF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D131D1F70;
	Tue, 27 Aug 2024 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782620; cv=none; b=gDQljJ/8/qNI91udi0GLDek3NiWer2RWEKYu7e/T0PRLBMWfnnQidWBY8VBlUOqhSS6Wciy2hA+J9TVTGdV1RHr3jEUn7Rs9l7o5nLc0KUx+7TALXidtkNAMeoEbD54ojAZi6SN4oXMo/66B2g7kj1OqcwHrJgq/Ds77iHSzwvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782620; c=relaxed/simple;
	bh=wENg9M1mTCLG9DTei9fg7wyJPouDKzJF0AV1TbCvcs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMhTnL0KMROD+SVXvpMdJjwuAB6WAI1fTa34MFmN2n3j3qk+Hfd8n9Gn6dwBc1PWnygsOnY+Nik9uVF/+d0NwkRdO/99VrycfQMOdYz5a2TSLq2lY3CEcAGt2A2l/bTTLVqaWotmuPFNPTKVPmKQVtXA1UP5hpS1mIGnRINXO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez0OFoKF; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7093472356dso4334484a34.0;
        Tue, 27 Aug 2024 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724782618; x=1725387418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7wTbxXV4u9wIUZqkNbsPqFqHbsr9atSZCuro+rt3qU=;
        b=ez0OFoKFG3C96p290FnaVJVQk3ELJKexs9B3g2qfgf0RS5IvUmosVLbkXtTNITVJQp
         21vlsIf2HmmYaeH12/C+cRXepHGhHBzFxegob3W+nt+i/um0BTpPHJCJS5P+Gj+i7TCd
         Iawl6crFcenVIlAp3E8QcL0vUIWBfBLZiF9DyHh6jugWRu8gmjrNpSibWUDNkchPKEHi
         12kzdA7W0P6ai/iiI2TAMZaPDKWNVakhYD81bRo5nIOmZuEqNZMUd3KROEvixSknVuC9
         wxzwL881Gv5DMyap5Sk0f3DcT1uAR++faJdCwyNU7HGLVWRqRugn1cD8A9GnsgdOGhKt
         7y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782618; x=1725387418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7wTbxXV4u9wIUZqkNbsPqFqHbsr9atSZCuro+rt3qU=;
        b=fvyVhNsdG6JX7Or3fB+bSs8Z2xqkb7UlpmwAKNxVXLcNC3BgKxLKO2uaoJPDtcaS+z
         TS2DSUBu4xYjY1He4cRxgdxemFPcTWHN5FyQjiZjFy7MaSBDTRkGBKIlZ2TkVztixIQj
         VzAUwYyVlCbXZBHG1Sf/kX3JiBmObJUYq7kqlm0e57dw+yMpxolp6VwJYP8O9RWuBVdm
         HIWsqavfOhfriKULvpJ4SCoJSHDzT76fz2s8VJSu+TiImsSG4PdMoG3Jq3NCbU0UKOsZ
         DwnPXRriCu6pQaYI/XEh2mgwiwmgesxVKLTGA5jhPWAGBu0mwpFWsBumpdFtOx3CC/eB
         fnnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5wKbFgNLfrMTd9bxJukC4gmX1fiyfYBOdDRjYhtY83xXOyL8mEFf221NUIxPid1nacCyQcpE5w9Y4FEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBB5iwZfK7nJ9FPhA3JFvyQOtcKctuIGdv5e/6Mm0dmm0z1xB
	5Htw41lquX9HHUJsOnPadQjCdZO57Y8exu7BvUEnBW7/IjxixUbF
X-Google-Smtp-Source: AGHT+IGq7zGUZVAjEK/FHGK81dTpOpXi8mb4tQfiAL4nwIswAacojWfQIog396Xtm6RQuvjj83cFJA==
X-Received: by 2002:a05:6830:7008:b0:70f:3973:1236 with SMTP id 46e09a7af769-70f397319ddmr11554103a34.26.1724782617868;
        Tue, 27 Aug 2024 11:16:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6c162d216fasm58104436d6.22.2024.08.27.11.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 11:16:57 -0700 (PDT)
Message-ID: <94f46a7d-638c-417c-b2f7-917be48bac96@gmail.com>
Date: Tue, 27 Aug 2024 11:16:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethtool: cable-test: Release RTNL when the
 PHY isn't found
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20240827092314.2500284-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240827092314.2500284-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 02:23, Maxime Chevallier wrote:
> Use the correct logic to check for the presence of a PHY device, and
> jump to a label that correctly releases RTNL in case of an error, as we
> are holding RTNL at that point.
> 
> Fixes: 3688ff3077d3 ("net: ethtool: cable-test: Target the command to the requested PHY")
> Closes: https://lore.kernel.org/netdev/20240827104825.5cbe0602@fedora-3.home/T/#m6bc49cdcc5cfab0d162516b92916b944a01c833f
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


