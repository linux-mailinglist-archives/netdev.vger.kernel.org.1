Return-Path: <netdev+bounces-55475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991E680AFB0
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036742818CB
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769CB41840;
	Fri,  8 Dec 2023 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCd4l3vY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFDF1724
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 14:33:53 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-425952708afso14611721cf.0
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 14:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702074832; x=1702679632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8WoaQeLMdTQfUXg/gg1Cuu2QuOGuSWWOQk6xE+ANyc=;
        b=eCd4l3vYejwFhLTmGKo8l8hrcQCbiXqekO1NziiFBoXWzrgJC0IgHTkTWygHx1SShN
         R1+SQZqB9v2oCCp8Ew60OEGXDLJY6eelgQjSJPY5CP97GKwILlUbw4y9/oPNPNk8qs49
         a3dLOgOdvi/HxSWTYZp+ZlCzuWzqvW29metbxm4rIoR4TrybAju1DNNGx41r3wdMqslu
         ypfMFfk6hK4uj7qYhY9NEOH7uGWzoT/dUqsdJ4PAt37DcXUZzSVfVL9xDu6zbaq2Ylk0
         RZJBvATNbgnkoeEv7BSFatImtmA9u60EITb5EvLX+nxv9G85DQCU2bFNws761oRC6ld2
         /t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702074832; x=1702679632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8WoaQeLMdTQfUXg/gg1Cuu2QuOGuSWWOQk6xE+ANyc=;
        b=Sq/ZhQGFdb5O2KLrvl96Je+aXq0W8fbHWN9eFRkfhObXpgfcLHme02HgNs/kyBYkAe
         gJo5E9VIDLq9YBK4zhivvsN0UqipazyQpsX2/koUbXJvHR1koQl8L3Mio/2pWXYcIbCY
         1LbO+PV58woDiqpcS7+rJ/OiO9Xys59GYdWq4kPbh2LCBD3DDwZWHtyirq+771QNMqX3
         5nzKgdlSK5O+W+YiPIwZsJE1o64eB4aEwOeKLksMfRLYiuR5LHQdqvN0hLX0VMqoLyYK
         GFbTZIEsfYZjVasInPfX511ESFNP7DWmip0Oq3444vNQDAwLhSATuRSinVIy5+vNRSbh
         c3lA==
X-Gm-Message-State: AOJu0YziDSq4HsRNYfHm7+RZki9xRuLMpJ2LKR+pdoZ6BOCDKjqFgSmq
	hCuLRacGVf4W/woAwZjhaWg=
X-Google-Smtp-Source: AGHT+IHmGArnLfWaqqwDcEU0uZ6HXin2uyvMLfJrX0qSVN9+ny6BPuwvyJkNOARuWFeyALh2yPVjWA==
X-Received: by 2002:a05:622a:104d:b0:423:7be1:7bf8 with SMTP id f13-20020a05622a104d00b004237be17bf8mr2735426qte.9.1702074832085;
        Fri, 08 Dec 2023 14:33:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fj26-20020a05622a551a00b004181e5a724csm944185qtb.88.2023.12.08.14.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 14:33:51 -0800 (PST)
Message-ID: <ed1911a6-f7ab-49fd-a198-d1cfca77f7a0@gmail.com>
Date: Fri, 8 Dec 2023 14:33:49 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] docs: net: dsa: update platform_data
 documentation
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Madhuri Sripada <madhuri.sripada@microchip.com>,
 Marcin Wojtas <mw@semihalf.com>, Linus Walleij <linus.walleij@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Jonathan Corbet <corbet@lwn.net>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-3-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231208193518.2018114-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 11:35, Vladimir Oltean wrote:
> We were documenting a bunch of stuff which was removed in commit
> 93e86b3bc842 ("net: dsa: Remove legacy probing support"). There's some
> further cleanup to do in struct dsa_chip_data, so rather than describing
> every possible field (when maybe we should be switching to kerneldoc
> format), just say what's important about it.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


