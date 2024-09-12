Return-Path: <netdev+bounces-127917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B09770D5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D3F2841E7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F20154BEA;
	Thu, 12 Sep 2024 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcQnmABf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C02BAE3;
	Thu, 12 Sep 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165832; cv=none; b=IvUvnFl1f8yIREtOqqvIiU9zaqj6wIcutyK13OJDFyteR73O3AfyMeaePvxnqhBWi0OMQQVl04fThZLuql43iLkByQ6zz4oXixweKpeJnbrUwjdS0apiPovXcHU0RbLNWUszjPsnJrQ/1ReGuYTGSPe7zGlnSnMjyCTn+/iAMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165832; c=relaxed/simple;
	bh=MT5KHTU8WR3Lh8HyRqCKb/WSBh/7HuIcNHL+nSm7P4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rU9QmLdsN/uShgabojEqEaYMsucET7BpsX761m6AUbgLmdhrp5hcn6umT2wYdJG8tAwmz4ET0qm4Eu3VdF+Xu14705clev+PHOJNek+dV+bfdsI9EVgnDPTRQsI84W294UIYUqspxShgs1qnoP6kg/Ync2oJ5g2YsgMq0GVJxx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcQnmABf; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-457cfc2106aso604831cf.2;
        Thu, 12 Sep 2024 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726165830; x=1726770630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8kAPGqrsaGxGyW2RkQBExyp9b+qbaXCkJ9biAhcsg9U=;
        b=kcQnmABfAzamGYVM/riKrU/YbRJ66KCENS5X1lfaqawC39P4cGyBXeEJ7wVGHKLRKc
         m5OinedwsWZmRWIMxeVv23OzFXQDP+CcVnS8WCnA8NFzVPnx4FxqJVgEXx/5a/cH4re9
         50gN5ki3L98XrCJpoymQ0fvze+WOXtW+D7B2YxiN/5nCs5md9Bs5SkjSyHVxIIRjUs08
         EKmCsVf7KwI4yGrBhk8VE5hDbSrOSNa0fIMQkyxl/y0a1Ihno9KmBFbbQUj4/etMRRFJ
         Xl4HKll3T8AXjNYRGFRtDmHtdb9a/Ywkn3qLYJ0YZPocQ3H7tT40zLc7Q3bW1UsK2tdJ
         engw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726165830; x=1726770630;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kAPGqrsaGxGyW2RkQBExyp9b+qbaXCkJ9biAhcsg9U=;
        b=Z1p1bBYArZuXVj0REg6rGmhwy5kwRow74SwnjoY51ZWur0PV8Te0z2yZO89JccLLfh
         EN9OPg8RePGZICBwMU4Q8BFYFjPIIvikGOKK5batAOdXOPS6BjMC+4foY078k0WKU1tS
         knfFHUSU9BARKRV6g5qAeDrZZTb24OW5qyQkDXL7nzUbQ6AdO+gr5FKKHjt69Fl82i4K
         3JjUF5JKmiETy/hCeVWV+pvfJHaakP2P6DvBkJoWHxpHByDqS/FrrS9kvbUf5DR22cD8
         FFYAQ/VJpQndn7FJG4KRJKLWVvjkB/Q8TBOoFVnYlA/P7KhSd9eECFKE9bYHU7qmWQ3R
         2O5A==
X-Forwarded-Encrypted: i=1; AJvYcCX871JgmDc3obBdkBjaiQ4Q98jsLNODlumdg9aCeCfRCFGs2XObBUubnxpbgGcuisWSpxuDyulNTQzDTdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzizPP6/ezJtBMYCNK7xijsFWjtJIL2gPxi0UAPXF7RjQuw39PU
	a2xjah5W8+LWKiOcBkUKUahjvwpMc6p0MA18BVsWfM/BWt5MjQU3
X-Google-Smtp-Source: AGHT+IHvjweDt4gwowcrHz7d1Nh2Onzk4zDJ35JKD/AOU27y3GTFI54WS2V+BQf4Utn8pRA4Kd4xww==
X-Received: by 2002:a05:622a:4e86:b0:453:7634:bbfa with SMTP id d75a77b69052e-4599d237db8mr1580331cf.21.1726165829962;
        Thu, 12 Sep 2024 11:30:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f60a4csm55521151cf.62.2024.09.12.11.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 11:30:29 -0700 (PDT)
Message-ID: <7736f0f2-8a99-4329-b290-089454d56e36@gmail.com>
Date: Thu, 12 Sep 2024 11:30:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] net: phy: allow isolating PHY devices
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, =?UTF-8?Q?K=C3=B6ry_Maincent?=
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
 <20240911212713.2178943-2-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240911212713.2178943-2-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 14:27, Maxime Chevallier wrote:
> The 802.3 specifications describes the isolation mode as setting the
> PHY's MII interface in high-impedance mode, thus isolating the PHY from
> that bus. This effectively breaks the link between the MAC and the PHY,
> but without necessarily disrupting the link between the PHY and the LP.
> 
> This mode can be useful for testing purposes, but also when there are
> multiple PHYs on the same MII bus (a case that the 802.3 specification
> refers to).
> 
> In Isolation mode, the PHY will still continue to respond to MDIO
> commands.
> 
> Introduce a helper to set the phy in an isolated mode.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Not sure where that comment belongs so I will put it here, one thing 
that concerns me is if you have hardware that is not strapped to be 
isolated by default, and the PHY retains the state configured by Linux, 
such that the PHY is in isolation mode. A boot loader that is not 
properly taking the PHY out of isolation mode would be unavailable to 
use it and that would be a bug that Linux would likely be on the hook to 
fix.

Would recommend adding a phy_shutdown() method which is called upon 
reboot/kexec and which, based upon a quirk/flag can ensure that the 
isolation bit is cleared.
-- 
Florian

