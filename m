Return-Path: <netdev+bounces-86996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E58A8A13B7
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65D8B21363
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA114A618;
	Thu, 11 Apr 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcdVqbyg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300D143898
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836624; cv=none; b=LJ5sf81hpGQNmKwNadNXzvbLjyDw4GOkTbccMrEcA6phZ6v55ZsC2qomeNFjka/e9P5xZVdkM4rPsHj30IIsmlQi7GOgi7ZSZ7/tt94FJPApGSVRvI5ht8AuQxZhOi3ktPmfMQq35Y9roa+LCrpqkOr+bEEdPBOI6We+KOCx4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836624; c=relaxed/simple;
	bh=syv1En7U2Yu+ENBSNDGrohx1QA2O/GZkshamyp4tLcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCBSZmyY3+ZQmwhnNZKQjP5FLmJ8npFSrOoYGosF2greiQvKGQy5IjY43AlL5heGhOj5TXydZWoH96hrIYAR4IlHI2lQVNBWZI5EeieszSJOUg834rJ/+JQcijf0yGLmI6exUhchYGqPBiWd2Sh2k8aXnI4rvkTFccKm+JBE5m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcdVqbyg; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-346b09d474dso693593f8f.2
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836621; x=1713441421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KFpxRcXtEx9rSXu3ni3ScChBwv5sQJISrCeGXW3+gFY=;
        b=hcdVqbyggC8G7jSk+oRbhv82YnfPJFMZ4t5inpv1tZ3JddRWrTygDzLoFGqFIa13eQ
         iasOqj3d1eknYtowDNmJcfhKGefLntQ7+RhU4P6CT3CMpx5VSyjAY5i9tukt9SmAGDxY
         kbpXWlsIHqhk1VT5tqRBVSceObfHvc+8ASiBrF42sZ6wmvNAO084J9T51I4GkzbAOKCb
         mGnxwW+KkP+jnNioZ+vtV3zEIJMyR497JzAotfYMLemXiqCYxVS2igK+bXG8lci20aI4
         5GENd4pVGD+yrMl+YjynipCEQmugDIekUvGMlTQOVLtiTQd0gqTOzLeb+f703W3zluWJ
         VmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836621; x=1713441421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFpxRcXtEx9rSXu3ni3ScChBwv5sQJISrCeGXW3+gFY=;
        b=belR4LJy9FAXDsq/Aq9orGMiqKHrhwebmiceY8gFEJke0TMbZ2MnrpCQVgUxvPfOJG
         vQg3F7HG55DJd8lI/BBexyt/AuoJZ1BkH45bqPsb4q49vcSzuE93tW9RMehqyPnlNs37
         r0SwWs2JAx6R48cEr1yhw3JF8YeVmXjTTLygxRqzGlEnKofq53P5C5YZiMRwwYAhQPuk
         n+UAl3nIE/RZGjIfOAYzLebkB0nhtumefNKEKyt453tuekiwqu1lAetW2076BorRsJ8K
         HFT/A9tzLH7uADsrj+ipnhoAs9Ir4JAgew+adNFiiZopx5mk7WEL7v8IKGfBXLS3xrU3
         zZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1OxNsPfiZvtiUwtWXqc0dsHC+kQloc+VxeXIdvOjxX7lHUNMTtIfdIB2gT6hOrDKYv6+ZayhSoY6YRqveAIcDq35eF3fj
X-Gm-Message-State: AOJu0Yy1RJBbtMywqu17yV4eKfA2VRPxS3KAxMJu3p+31S39HM9DdJwp
	+A8fFe2FnGwIAoGYV5yG6vPgXM0PITsUXOgipOcSfptewCbYmYXt
X-Google-Smtp-Source: AGHT+IE+xrM481MoLoRPXteX7tTrEohfzcPACoiuvh9/e3L5IBuf0gfdbhjOMkcsnXUlSJjUm3xVkw==
X-Received: by 2002:adf:fd11:0:b0:343:bb82:dde2 with SMTP id e17-20020adffd11000000b00343bb82dde2mr4882736wrr.11.1712836620487;
        Thu, 11 Apr 2024 04:57:00 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id iv18-20020a05600c549200b004174ff337f4sm2128334wmb.7.2024.04.11.04.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 04:56:59 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:56:57 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 1/3] net: dsa: introduce dsa_phylink_to_port()
Message-ID: <20240411115657.62namspzfwytyweb@skbuf>
References: <ZhbrbM+d5UfgafGp@shell.armlinux.org.uk>
 <E1rudqA-006K9B-85@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rudqA-006K9B-85@rmk-PC.armlinux.org.uk>

On Wed, Apr 10, 2024 at 08:42:38PM +0100, Russell King (Oracle) wrote:
> We convert from a phylink_config struct to a dsa_port struct in many
> places, let's provide a helper for this.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

dsa_user_phylink_fixed_state() was another candidate for this, but fine.
It can be handled separately, this is not a request to resend.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

