Return-Path: <netdev+bounces-52244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655117FDF62
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9681E1C20C4F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF50A37159;
	Wed, 29 Nov 2023 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLLYtTUw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D32122
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:37:39 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54bbf08aa53so195465a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701283057; x=1701887857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8V/n3IAcBBWDWjFGEguMNl03ZrMsb52FkA/60whqu1g=;
        b=jLLYtTUwa27+cEik/YVI/AgIolgy5+Ysgd3dcknmX8pBvOvh/AYVXC1OhZnSe/FfuU
         6kl8HOwTWCJQmV9sqg3jl142Dc6ct8mnpghQGuinikV2lz1lVGuQoAXF37cJGko8pIBe
         2vA6g4hXbwFCtoGEtoW8/1M9gngZnA21t+aaaboh31t2MpQtXNfuBDQh78Kz8gpYzL1Z
         tiKWkJ7UfzwigBnJWsP3NGGk1U8pSKyGrvXZEv8YQbyXbPViGMSbKtIOdodhdnRJG4Ds
         8jJorvs9ajThb2FlKX+Ydq/VAZ4wodkifKiVTQs9s/nBOWaMXpj+N4sJxZ97oWLl6vtc
         rhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701283057; x=1701887857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8V/n3IAcBBWDWjFGEguMNl03ZrMsb52FkA/60whqu1g=;
        b=OP8vEAjCl2DkQYsFNhli/OI8EmkZt9pB4e5+KHLlZr4HVRbAx0qpmwaGEYQMmLNEI/
         5YJ9WLEy5RPII77xxB/nCln3YEbNUoVaxmPV3NkPpkZ7UCcy/W3Tl0zBdVehfGV8KgZe
         KTLGoNSWm/cOdXjxYrxJ0NMdVzTG2yncOqWmERvK3CRwQ2nwoFw9cWQPrecvou+i6Tmv
         wsFypaz4Vy7XJgwcjuJtrHIjadXseB0CZe5jVtIIzpjH6hcFqEef6kZynPPv/R6FUARR
         3Pn6mwtaLGRLlQTKwVm0adwRWl8t2UNDLKYnTgDNiQVkZ8PF0ZsL/dRaZYAldHeTPJJ9
         mh7g==
X-Gm-Message-State: AOJu0YwxYVPimjJLzvKOBMNRRpyXaFC5yPUIHWdVwGtJGa9jqACye51O
	U03S8zYTdVwy9fWUmfYKo/c=
X-Google-Smtp-Source: AGHT+IE+OtEdKkXwRzxt5IJzdX/nuYtjSl2punSKQznzZ0c10snb1PZ4cJBipl7L7DNEfSJnn7duYA==
X-Received: by 2002:a17:906:cca:b0:a16:313b:5b52 with SMTP id l10-20020a1709060cca00b00a16313b5b52mr3583277ejh.17.1701283057058;
        Wed, 29 Nov 2023 10:37:37 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id lv20-20020a170906bc9400b00a0f78db91c3sm3705147ejb.95.2023.11.29.10.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:37:35 -0800 (PST)
Date: Wed, 29 Nov 2023 20:37:33 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCHv3 net-next 02/10] net: bridge: add document for IFLA_BR
 enum
Message-ID: <20231129183733.pzdi3yqfuo5y6keg@skbuf>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
 <20231128084943.637091-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128084943.637091-3-liuhangbin@gmail.com>

On Tue, Nov 28, 2023 at 04:49:35PM +0800, Hangbin Liu wrote:
> + * @IFLA_BR_VLAN_DEFAULT_PVID
> + *   VLAN ID applied to untagged and priority-tagged incoming packets.
> + *
> + *   The default value is 1. Set to the special value 0 makes all ports of
> + *   this bridge not have a PVID by default, which means that they will
> + *   not accept VLAN-untagged traffic.

"Set ... makes"? Maybe "Setting makes".

