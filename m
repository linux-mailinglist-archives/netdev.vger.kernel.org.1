Return-Path: <netdev+bounces-174483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFCDA5EF49
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643821701B6
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE267264623;
	Thu, 13 Mar 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COfY+IkA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C975264A69
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857238; cv=none; b=SAnN28rCMflOo1aCNRH3OIY4Udz7ynzvwFxREUy12f13JHVkzRIk5w2PElj8XhaPAA1SDWEG/pgQU2Ylc1JPEeZLg9a5e1qEeu0rlYNPNAJyorsu9ll2PupvMHJkpcBOJxnY27rV1o4s40+0izmG+fzJx2818j4/FwMtaQbaH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857238; c=relaxed/simple;
	bh=B8z3XxDcPYT3TwJe2u7bee/oFX2rHWkSq1iClzFBhvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7kVZyPK+nGLkbKV/VSMTpYO9ErXL5OevToITVFjz8DL23lHVxUmlJQD4PaVGQFt0EaWO8ZJXlPx1/6LhcUJ1lhg2Hd3pX0UjWbQaCfj9BnVm3emMQpwbgXqefnzwRmCkZs5qhQxTPxCZkP3OwLoh+LChYJYxrpmc5VpTSgl+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COfY+IkA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741857235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVZ0tLlG0gxUYcMK2sjB46xw1TF5VnAEq4UYGXh3mEs=;
	b=COfY+IkAM5L9hhxWAY3Kw4nIJBJlO0qgoM/O/bvxRmwV9MXYVOx4vAcNi0fl6/U3uPtuOf
	D36e823QIXMav57ALcI9h1vgrJS3Moq1bIU1XNPv3T9Wt94OYLT2EEVJKirbIT3MEuwBmW
	td9r19E/9Ed27BLKoBWsgsrotoGDgU0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-k12P9uA8OmCnlezS5ZHvyQ-1; Thu, 13 Mar 2025 05:13:54 -0400
X-MC-Unique: k12P9uA8OmCnlezS5ZHvyQ-1
X-Mimecast-MFC-AGG-ID: k12P9uA8OmCnlezS5ZHvyQ_1741857233
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39134c762ebso285123f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 02:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741857232; x=1742462032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVZ0tLlG0gxUYcMK2sjB46xw1TF5VnAEq4UYGXh3mEs=;
        b=JiUyolv64bc4iRAue9HbrTU67rZ7/KETnBxtiWKDpr8Nw7vLweDauwCyS3how2Z5zR
         zqA0HCMZ8BEPWu/veALc7zaw450limXHBl6c57uxn2UAurwHz4LX+xKaozEv9jrtqRa8
         TT9Kd2yAj8jUf16xrZCn4Qzys58/YoTRCe7wVYmCaJ/3hb4DZ1aJuEu4VFWC+hiQvCp/
         RZNx4Ie8ln9RHHEYK0e0f9HrAkebKepMszo+5jKWyyOXYfOjnZ0FXuay9/J1Wc1RZdGR
         kjq4gR5bCFRRCPZeo56yuX5WZywmUB7xfGm/J030i1l89Jd+Akp92xYYTFnZMpWPorKh
         hH/g==
X-Gm-Message-State: AOJu0YykDGHR50IUjmeR9bWs3ZerMqn0URr1aVzd1LBYbrZIDrbF5YBw
	bcZLy/nHN2a9g4hrr+0Sq6eoVnf/mUZ20iSLpTV8t7wUaSAkY3ti/w9Rmo943IoAVJpqL1/W2sT
	7RzBMQSuOHluCkvjkeu6xIC9inMEzQWWddq60FUND5vmeowR+aM1d60ttaWIh3Q==
X-Gm-Gg: ASbGncse0BZkr+DQacJzKMUSyFslwfPYBObPdPBqg8S8kLOMsg5BvyGyFrtVpEGWJlC
	5s+c0uf/otFRL/McAml12N3q5QdW++GgLjZXsVR3DlZxV9VF2WZRC0qollgr0V9O1xTBqafSlTL
	oTZpJ5G2soYRZojxJntS0ubREMVWUYmQt687WRJLmun2uLmdvd/pk4FBXGUm6CbucBmBpQuIXYm
	SkhIAq16QaBNWnHB2D/Zd9U5wX/bC0KnqaGF8F5/OK0M82/QXX+yP7LPvnt8zfZE3B/XN1CYr0H
	qXa1jI2hhSbesJJHwIoet/PH2iQkZKyXgB4GyLccTHc=
X-Received: by 2002:a5d:64cb:0:b0:391:3fa7:bf66 with SMTP id ffacd0b85a97d-3913fa7c415mr17065937f8f.31.1741857232647;
        Thu, 13 Mar 2025 02:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbjX4TBW23c/gT1Ykr54Jxw9IBGriCcPT5Lz7WvNJIWr0e0qiBIFuFczS2FQTDIKFEENThyA==
X-Received: by 2002:a5d:64cb:0:b0:391:3fa7:bf66 with SMTP id ffacd0b85a97d-3913fa7c415mr17065917f8f.31.1741857232262;
        Thu, 13 Mar 2025 02:13:52 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-237.dyn.eolo.it. [146.241.7.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975bdfsm1423712f8f.49.2025.03.13.02.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 02:13:51 -0700 (PDT)
Message-ID: <92a9cb8d-fe6b-4389-9d65-64b668f1e221@redhat.com>
Date: Thu, 13 Mar 2025 10:13:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/13] net: phy: Rework linkmodes handling in
 a dedicated file
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 6:35 PM, Maxime Chevallier wrote:
> Hello everyone,
> 
> This is V5 of the phy_caps series. In a nutshell, this series reworks the way
> we maintain the list of speed/duplex capablities for each linkmode so that we
> no longer have multiple definition of these associations.
> 
> That will help making sure that when people add new linkmodes in
> include/uapi/linux/ethtool.h, they don't have to update phylib and phylink as
> well, making the process more straightforward and less error-prone.
> 
> It also generalises the phy_caps interface to be able to lookup linkmodes
> from phy_interface_t, which is needed for the multi-port work I've been working
> on for a while.
> 
> This V5 addresse Russell's and Paolo's reviews, namely :
> 
>  - Error out when encountering an unknown SPEED_XXX setting
> 
>    It prints an error and fails to initialize phylib. I've tested by
>    introducing a dummy 1.6T speed, I guess it's only a matter of time
>    before that actually happens :)
> 
>  - Deal more gracefully with the fixed-link settings, keeping some level of
>    compatibility with what we had before by making sure we report a
>    single BaseT mode like before.
> 
> V1 : https://lore.kernel.org/netdev/20250222142727.894124-1-maxime.chevallier@bootlin.com/
> V2 : https://lore.kernel.org/netdev/20250226100929.1646454-1-maxime.chevallier@bootlin.com/
> V3 : https://lore.kernel.org/netdev/20250228145540.2209551-1-maxime.chevallier@bootlin.com/
> V4 : https://lore.kernel.org/netdev/20250303090321.805785-1-maxime.chevallier@bootlin.com/

LGTM, waiting an extra bit to allow explicit acks from the phy crew.

Thanks,

Paolo


