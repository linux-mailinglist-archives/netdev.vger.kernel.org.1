Return-Path: <netdev+bounces-122198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB1596055A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722AF1F22400
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2F19D06C;
	Tue, 27 Aug 2024 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJwcNmlG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B51199EAC
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750272; cv=none; b=ELPR3Luv2LMcxAKegwGWQLU4SK9ApY3W/FORSkmtnbImtxSpjsJLwJk7ncpcd9AC/RiEn6Jgbbp/I97Elrb6jlk+phLaTYgUku3fVGTK7kPHX13DTtnDGwi+Mdg9eCf39EG7Y3rX1AHebMqNEafL9uPWeCJHg6NQqZQXVyP2Oj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750272; c=relaxed/simple;
	bh=rmnmsb9mQG1EcrAiwREtpEzcJgjxBrXKFUL0rHsmsMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMz63GcRI2WZA9zhMD2ckAs83adw7Sny/R29ZN56nl/dxSqfgfEos/dDym/5YyaRBRZQ3V2/cHw+q3Q2HF982QpO184UMCaFwk7EfQ4Xi7J2fD+G254U50lj6xoFotTBOgDGOyDVSUdenkY8EiQYgZYS8jRGyR0AaqC6HfRq3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJwcNmlG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso7845745a12.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724750269; x=1725355069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1sasEf6dQ1biMySeoLzxw40J5UVWylbFqr5WcoeyDA=;
        b=tJwcNmlGoFQAyLVyPVePwnXXZ+MWnxOtRnoa9ZQl3x1p9wBABkglHxNOfvcEs/Jm7/
         f4YzzlKZY/t+nedy1E9Jc7WSiF5yEHgWe42I8pYamqkYTUMnYrKgqZJnUr3m6H1QrSDW
         Gt8fX8fuRCiDfpCPG+Zc1QfxKEXSoopjbuAGATIxYLbeccEfriiUwAiUg/CWQqqvSw4c
         qu0ZqIA1vUaLnhyD+8PIkZpPvTffLOHirmRvhjlFOXAMB6Pr696eR+CngneuQMHiqdNf
         uPhMoScONWYzJ3vM2h/cKLuZ9Etv0UKx14jJDKA6uGG0C6Y7UBg5mtkCCM9Ap2WXSYZF
         PcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724750269; x=1725355069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1sasEf6dQ1biMySeoLzxw40J5UVWylbFqr5WcoeyDA=;
        b=ds6T0XJcS92OOjqKthc05DR+JD3tOVsrDMItI/EKFmI/sqSfjGsvFEF0de4gkNaxfM
         p1iQUk6f/U6o0vHR24qxWRN0O5vEzXMoVRWdKnNEIlH7IiBLXBXmU4WyC6gxRXpYL+E2
         om1X45w7JEtfqNGL0c5sl0L9mT72aStFU0qGuqpaZfcSJU5xXDxgTMNE7lIn+MaEz+dL
         EVP0f9EbRkEu4hUO6q4ekJ05F8u4317nEM0LNGnsqT4sQsGMIRyI8n2U0KeXIDjH/GYG
         I//QV3N6jDBzYd3jSYLw9N+rck3qrNPef57GHPWMAcCtHgm/2KUzuEP3JDU5l1A4V35d
         dliQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxWOai0PfwJVz05FF/0ayHboFggqxyOt41rdiTfyajesqNr7TMrDKSWmx7K/U6fzR7RmCufY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDsYugE6bfltHT87Xjk4Hsg8jiTgD+RyRWjKWtF9UHhDVayGo3
	SkH6n5XlD8UZo4CPD0FxiQVu9xcsLbw+J3afDvot9y11mBK6OaZFGjihE/8Hghg=
X-Google-Smtp-Source: AGHT+IFDcpOw1cf172ngEbl72Djz9SK7kIbETgguQZnpf+BgWO7feOp0diqESn2LrSOa7+a2O2Po3Q==
X-Received: by 2002:a05:6402:d08:b0:5be:fa68:a239 with SMTP id 4fb4d7f45d1cf-5c08916910amr8427516a12.13.1724750268593;
        Tue, 27 Aug 2024 02:17:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb2156dfsm780695a12.53.2024.08.27.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:17:48 -0700 (PDT)
Date: Tue, 27 Aug 2024 12:17:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pengfei Xu <pengfei.xu@intel.com>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v17 11/14] net: ethtool: cable-test: Target the
 command to the requested PHY
Message-ID: <d9131fb7-a6fe-43a4-92c6-5577700e34bf@stanley.mountain>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
 <20240709063039.2909536-12-maxime.chevallier@bootlin.com>
 <Zs1jYMAtYj95XuE4@xpf.sh.intel.com>
 <20240827073359.5d47c077@fedora-3.home>
 <a1642517-366a-4943-a55d-e86155f51310@stanley.mountain>
 <20240827104825.5cbe0602@fedora-3.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827104825.5cbe0602@fedora-3.home>

On Tue, Aug 27, 2024 at 10:48:25AM +0200, Maxime Chevallier wrote:
> Hi again Dan,
> 
> On Tue, 27 Aug 2024 11:27:48 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> 
> > Could you add some comments to ethnl_req_get_phydev() what the NULL return
> > means vs the error pointers?  I figured it out because the callers have comments
> > but it should be next to ethnl_req_get_phydev() as well.
> 
> Actually I replied a bit too fast, this is already documented :
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/ethtool/netlink.h#n284
> 
> Is this doc clear enough or should I still add some more explicit
> comments ?
> 

Ah, I didn't see that.  Thanks.

That comment is fine but we normally would have put it next to the function
implementation instead of the header file.  There are lots of comments in the
header file, sure, but those are for inline functions so it's the same rule of
thumb that the comments are next to the implementation.

regards,
dan carpenter


