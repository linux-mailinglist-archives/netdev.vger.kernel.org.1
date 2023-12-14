Return-Path: <netdev+bounces-57145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B48812420
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAFC282152
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DD939C;
	Thu, 14 Dec 2023 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSxKEnzZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D8EAC
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 16:50:13 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cebbf51742so86726b3a.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 16:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702515013; x=1703119813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGtSFv/k26mU91Xy5EV6ZunGPt9CESueDuplVzh3gMA=;
        b=kSxKEnzZfL4Cj6d0GRaJ4I6Pe3eW8DVF+rI27YLLEdBAJAe1T522XUGpV2bDLIODvN
         8OQLHCMVbIbdePUEWQ3c+XUl3OWY+7VQq104Hz1VA/La24fCSCXKKqd/7pxdEAngwJNo
         bQu6T5xgWlLdSW/R1NPoTzmuCwp/oWKmPDYPGrrQmB6jiXmv3YckeSn5Rxwdo014xGY5
         4vmOy5pHgABfD+NTOw/gegBUGPLwTrHOM6CQNn7248Lh30x0I8fAWUe54lDjVmc7YEW4
         rfvs3uV2bDOxb6uKmedALIphFwcscRwclRis56nEy1mD+GXo4bUHUnwMAcskN4QFjkoN
         gc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515013; x=1703119813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGtSFv/k26mU91Xy5EV6ZunGPt9CESueDuplVzh3gMA=;
        b=CV9m78WyghoWfr0/1ZUUKZ1IEvoAeNB7d9MLgpUb4eP0O/Pkd+i3StPWiqrUrJW1yF
         dfEN7/1J6Ik1zjhadDhAUwiYSjA0qp7YOumdOxI54D0laCp7RcfGuXymv1fJSe6qnEQP
         zOJ8f9oqiviggB2AoiPvZSXAV1DNVNUSC67N9ZJdHDb7ap4l3dhc8Ae4ASluzRPrzIla
         l8JbAC5WsO2xNq3BhObKcWQpX4gQOqQuvzacJK/R6H2vYX3o6jJVtBkvzZ4EsqFf007u
         SrItWzjoAsIgwcIDdh7DXtu8l69idiFoW7uHdrxi2Qyzq1rXWXlaEBMfrk7lnFujy+Vh
         L8Dg==
X-Gm-Message-State: AOJu0YyrGaFbk4rfhifD1CaIzp1gR3Q+INx8aadPjpQ92VINt4aNp4QZ
	oDfRMEUVooaTRRsIqtR8pPk=
X-Google-Smtp-Source: AGHT+IGaxq0i70w9kaiqTb9P+2lqBOmd9IUB/5vnxnz/h7z3QsonI6aDHhESiQ+9oMVx9b5/d9B35A==
X-Received: by 2002:a05:6a00:cd2:b0:6ce:54dc:2d0b with SMTP id b18-20020a056a000cd200b006ce54dc2d0bmr12895020pfv.1.1702515012566;
        Wed, 13 Dec 2023 16:50:12 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v15-20020aa7850f000000b006ce467a2475sm1762771pfn.181.2023.12.13.16.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 16:50:11 -0800 (PST)
Message-ID: <4a6aa3dc-2de7-45f8-8274-7f3f686df309@gmail.com>
Date: Wed, 13 Dec 2023 16:50:07 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: mscc: ocelot: fix eMAC TX RMON stats for
 bucket 256-511 and above
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
References: <20231214000902.545625-1-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231214000902.545625-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/23 16:09, Vladimir Oltean wrote:
> There is a typo in the driver due to which we report incorrect TX RMON
> counters for the 256-511 octet bucket and all the other buckets larger
> than that.
> 
> Bug found with the selftest at
> https://patchwork.kernel.org/project/netdevbpf/patch/20231211223346.2497157-9-tobias@waldekranz.com/
> 
> Fixes: e32036e1ae7b ("net: mscc: ocelot: add support for all sorts of standardized counters present in DSA")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


