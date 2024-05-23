Return-Path: <netdev+bounces-97838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7489E8CD710
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5DFEB20E9C
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46BF9EB;
	Thu, 23 May 2024 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu4I1US3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DD7482;
	Thu, 23 May 2024 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478248; cv=none; b=YlRXlM0SBgs0RQwDyUafalta9J4Ut4Ua7otXiRmdtvin2llGr6QnzRmnP9yc6bf3YwVvJtpE0m2iZJmG1WMmi3y40j58B3Dj8o+ycBI3aTV1DHWL7qgrr4lJKv12yE/JPN6ukWPoH1brRQElNXU0hugIrA9kwhZgFxV6sl/7cC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478248; c=relaxed/simple;
	bh=+V3h8W+KJStcQS0bJvgI6ZikZdXVS5bHliBgARFsatM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SblTcHQEQhxGzgRlKrt9PmI4GHM+kU8t9muCa1zK/iW7xMDfkjbZXnBKJROkHA2GfswdkwhQnv8oxxdoRY2s0m14aHvFdWEVXrQgkN8mZtjO6x0oMOvfdNK3BJIXXu1A0SQCHCIkl0urCAnQphYBEkNGSqy/xH/3D19P0I4GyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pu4I1US3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dca1efad59so2947021a12.2;
        Thu, 23 May 2024 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716478247; x=1717083047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+TJ/vg4jZgddhB/QmYZWS0itIk/bB/u3eDv8r97s2to=;
        b=Pu4I1US3tWmAAWcVjpPxlGffdqLIBJ2ALOCahT761XleA1GHrrXgc3rA6FyK5TSYfI
         CedOmEJMzobSsMyQ71FXl5KdRHqofoATZgTblh7R/lDyJFTvfZ+sB/dS8hq4LXqHcoTf
         w8Yz/3xJS/b3+eO9+JJH2IomIPgfUg5egLpcFs5F1arzjB3spF5UcGTLBguiYgip+eSK
         317gjGaGLuv9+Pxiv41mZFdhHnjWIMJ/RKvCqQGZTC3OPy6loy6JW62xJg1uTzs8cc2e
         FL7E5A57UiCt4VacST6ZIi/aPw29a8ou2IHNF+XhurREalC1G/XZaa0kP2jrRIm9jRp3
         QptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716478247; x=1717083047;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TJ/vg4jZgddhB/QmYZWS0itIk/bB/u3eDv8r97s2to=;
        b=N7R1nasLBrK45dE2KKHHlcBgE9Hziq0NoswvOPfCWoLB6aViKnSLjEFvssfTsVWh6p
         LiAcijYhVTafBuafOjFqpPHkQPDUWxvLGDd3l57nPY1LdkzLKrlDjodz1N0BOV0NMTzL
         0bCVn543e9l3jI4VLwPTeQD0zarzRJQwUhDmFhBmELVud+/t40WDG2jNSsaUFHSq2+iu
         G41mOfuVUVy7oYXUwh7zrDdmIspMQ1y8u+5SHgDSTQt+6boc/fK6g0RH8wSg9ipIhiv9
         M0CERnUGdCzMGccDuRVUiMSMEHUMk0c+CXVvJj6Oi7/I1vf0z7eRzqDMxls7tcRPW9b1
         1NWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGeFQOS+rLk2I1c38v0wuBwdT4R0uIDVY8pDBAgbOFuf4kUUhp+/HS4DW/LJAUDH07xblHgtclbCcDE/1c7hM2QJjXPpN27kJC7smw
X-Gm-Message-State: AOJu0Yx9DyeQuTS5nLNS5sDbPyc0iIvOwiYZMnoRcJKdJmzsSkTIfMK+
	3Eh3RFXPDRrn22IapfpzrEZKIMQDTaDektj+8ZpXw1bkWTD3IFY9Z6sGUUGk
X-Google-Smtp-Source: AGHT+IHJrh81xzTofpC0t+3Be/hM4LaYvb7jB+O2cq/ubsGUArSBEkaGGRYh8xm1XWtp/wIeJLmZ/w==
X-Received: by 2002:a17:90a:8b04:b0:2bd:9bd4:359c with SMTP id 98e67ed59e1d1-2bd9f5bda81mr5246508a91.40.1716478246701;
        Thu, 23 May 2024 08:30:46 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a804792315sm58076726d6.91.2024.05.23.08.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:30:46 -0700 (PDT)
Message-ID: <1da4f523-aa96-40fe-9c08-06d5743a3f27@gmail.com>
Date: Thu, 23 May 2024 08:30:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: micrel: set soft_reset callback to
 genphy_soft_reset for KSZ8061
To: Mathieu Othacehe <othacehe@gnu.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Karim Ben Houcine <karim.benhoucine@landisgyr.com>
References: <20240521065406.4233-1-othacehe@gnu.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240521065406.4233-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/20/2024 11:54 PM, Mathieu Othacehe wrote:
> Following a similar reinstate for the KSZ8081 and KSZ9031.
> 
> Older kernels would use the genphy_soft_reset if the PHY did not implement
> a .soft_reset.
> 
> The KSZ8061 errata described here:
> https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ8061-Errata-DS80000688B.pdf
> and worked around with 232ba3a51c ("net: phy: Micrel KSZ8061: link failure after cable connect")
> is back again without this soft reset.
> 
> Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
> Tested-by: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

