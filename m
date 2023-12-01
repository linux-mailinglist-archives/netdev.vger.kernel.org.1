Return-Path: <netdev+bounces-52875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D03800806
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD49282589
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C213208C3;
	Fri,  1 Dec 2023 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Q51qxlaz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA13FA8
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 02:14:30 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bd4fcbde1so1479627e87.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 02:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1701425669; x=1702030469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AMu5IPkfVo7BuJ/Yzz3jeji9DxkRSml1elfyJl/27Z0=;
        b=Q51qxlazfsAX/gPIoBAuYj4pm6A0wblVSluULb9DAZYKe/XnmJWtyHN0deqGQuD6Ax
         Cu4G2OpSfe77I/NnV327LdfsCvdKe2VwFsVUOnYLdI2JjOSp+PpNx1JeAhFIr2YOnmar
         SnA1YFotw6xaeldA6tY3jgAUdV7yX5b4KThvhuRQpN6qi0NDyh9M93XoOXFbFV/i6MKn
         u9YiQRtg3a2Fi0xmgUejr26Oam33jPiiA08Dl8O3Wgr3kxdrprEM1NOPnMoJmOAkTn5T
         Zpc4HeCwk4juEIIHg9Y5u3VtSq/oEwAdyAXLTTC4GuCMITCDqmJDfVHggUl1WYBRnQ2l
         20dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701425669; x=1702030469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMu5IPkfVo7BuJ/Yzz3jeji9DxkRSml1elfyJl/27Z0=;
        b=LnBs+hsh2rvKus8sC5hyrlsVNuK3ydPsfbH5RXGcBFwr1sn2heJcL3VcIEyIJLhJvT
         wVk/HEuP6+K0pTh5RsfVxl2NAOcM3WXlQG0SX7OXesl69vwa5BtcseP7RrkvV7S4WRMH
         QpQCimXI30ePDYvBnLLLKjU12BXeh6/f2zO2XtV1LJ2/9AwDErqFiC0CYYxx1FUJOyrL
         VV0NfOPohS7myVVJhUCulm4E4POEB/MX2frgt/xPcans5HbOyFoLbwpKMbSyKJ0qwodz
         l1sQIbIxNhz0FGTRkLOIhhEmWewKMMiY6ZOKZlmPPV1GWtplj8/g4cSwzFJPp+bJyPkk
         Xpvw==
X-Gm-Message-State: AOJu0YwK26g3K/f8903KZGKp2dg+n1RKGDfxOIw4jlo4MM5j1pTteMma
	4KWPVEjWvt6G2hn6JLwFSLTdJw==
X-Google-Smtp-Source: AGHT+IEfpd/34GiEXl5IjizTxEgLqnzADydqF7YqkFjNwkKZ9mJ3k1GAR+WjN4JU2zaSTn186Ok1GA==
X-Received: by 2002:a05:6512:2c95:b0:50b:d764:8013 with SMTP id dw21-20020a0565122c9500b0050bd7648013mr586232lfb.70.1701425669065;
        Fri, 01 Dec 2023 02:14:29 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id y17-20020adfee11000000b003330a1d35b6sm3806063wrn.115.2023.12.01.02.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 02:14:28 -0800 (PST)
Message-ID: <5f428744-6ade-aa40-d879-7a98fa16457c@blackwall.org>
Date: Fri, 1 Dec 2023 12:14:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv4 net-next 05/10] docs: bridge: add STP doc
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marc Muehlfeld <mmuehlfe@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
References: <20231201081951.1623069-1-liuhangbin@gmail.com>
 <20231201081951.1623069-6-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231201081951.1623069-6-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 10:19, Hangbin Liu wrote:
> Add STP part for bridge document.
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 101 ++++++++++++++++++++++++++++
>   1 file changed, 101 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



