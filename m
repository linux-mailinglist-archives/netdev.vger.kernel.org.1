Return-Path: <netdev+bounces-106911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4519180C3
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353B8B26CE3
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0BA181326;
	Wed, 26 Jun 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKadWXRu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D8181D11
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404172; cv=none; b=MatgOd+cobdAyJiOLzryzZh0WmFlS3FSdeltzZP5Rv6lKUrakMElColjhB5oEoUctp8t1ujdzpLWZCnHB15X1P5IM+n1BcrkMuAvX+spL6A6IqaQRJ1N+vrsR6hHQakM/JwY+Td8F54/X7NFMYhqCKYZ9voR5VlMh3DIsk0p7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404172; c=relaxed/simple;
	bh=0MF4D4IoKYYW5zXgUIpt3WUaNZVZzVQaehQc9UIMvRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkpYYqmIlkPggWz9qxvrP+NEu1Yu+gf43xBnlS0AzuH3x5YNZIpnrSrnWbvzKIMsCBjxw7YcUTSuCvf6KFk7VpoXXKgq/8i9wrB3k3VaXW1ez4fK0w9N0f9RL+UhBcnpwk4Na/l7OYiuyKU3g/ouMiGDQkCkiiMTtkiv7gsIgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKadWXRu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-424a3ccd0c0so13595705e9.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719404168; x=1720008968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GxRfeBXcgl3CMa9atlsXWjYEAsD+1+oLRnTXXbXATgA=;
        b=mKadWXRub4CYF53ZGtiAtp/Al0/+F/FuZ2uegKJVhgfZB/8oaUOr6lcUBcfrH80Stq
         g/9csBpJMRy8UnRDuHqCEXFAUU/3775ayWOSOuZdr0pd/DJX9rlCWV7jWEVh6N05Tcm1
         ErD456/+nh1kn9SknzhaAl+ssUvR9w/57vgb+MauFGvD2tKNwXBopIRtlMDrrI7HVoqg
         91R2x0qB3RNX6orPXCYpLFS3KJteXzRPld9FL6j+q/RviBJhGdqGwxUhVfPdOG4TTzA3
         +t32y22zumUCq326VVKE+5N8PYQlEFwf1nijob2DH8SMMYrhCRDEPdXAQjwgh9fBgDCC
         fycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719404168; x=1720008968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxRfeBXcgl3CMa9atlsXWjYEAsD+1+oLRnTXXbXATgA=;
        b=WTOXVDud4utT+mQy6nFR4iQSNUTcfPxHT3ykn5Ty2+uxKN/2SW7OudQxn5q0A7umh2
         IEUDgEJc/nSJs8MF6Kg8j3+zMBfZLCVnELQs92xzXUEkyPFHLBVGTNG556+JXNMfOFai
         N/v8ssPz6UKCDLy67TvPswAXVOF0eooK+8gZvxYhXpRMsHGhHm5LtRpeES1XvcHI5dKl
         8w73c3cSopc7s5h/ukCqfeSM/1Xek0vmE4vCRwMMVA+Shq6T4UAYmXZlQDh5Q/1RDJZT
         v+4k7EGqtZyOOxoXOCSoADSg7pDqEI93K371DG8jXFztNk/+7AIxDtzVAy32xlEBYh4N
         Sj8g==
X-Forwarded-Encrypted: i=1; AJvYcCXxAbA8qU++1TijXALhFH8hsYUddC7oepI2Qou3/Ms5FnciAOticBmJTv8UJboGvLIh9Uosm4LBrVRlM1SJNKZ6bMhgYYh4
X-Gm-Message-State: AOJu0Yx1ztTKbm2S/BNffQelZHl8pZzvmf7aOQ1fOX0lFajErp+YEOKm
	5pXaXbz3dhO5alwFBiautZ06Lo3TWNjnxnvOtJsf1qNrghB1dKNY
X-Google-Smtp-Source: AGHT+IEMyXfwq9vToWTvkpu/2EXbbA4WocFWVwJ4/u1coqB1ZPcDZ3g9jiBIjnTFApGA3+pmaOnJCg==
X-Received: by 2002:a7b:cb17:0:b0:422:9c91:a26f with SMTP id 5b1f17b1804b1-4248cc3426bmr69652155e9.19.1719404167907;
        Wed, 26 Jun 2024 05:16:07 -0700 (PDT)
Received: from skbuf ([79.115.210.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8475aacsm23867835e9.47.2024.06.26.05.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 05:16:07 -0700 (PDT)
Date: Wed, 26 Jun 2024 15:16:04 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v4 0/8] net: Add generic support for netdev LEDs
Message-ID: <20240626121604.ngzfumr7bom6ilwu@skbuf>
References: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>

Hi Andrew,

On Sat, Apr 06, 2024 at 03:13:27PM -0500, Andrew Lunn wrote:
> For some devices, the MAC controls the LEDs in the RJ45 connector, not
> the PHY. This patchset provides generic support for such LEDs, and
> adds the first user, mv88e6xxx.
> 
> The common code netdev_leds_setup() is passed a DT node containing the
> LEDs and a structure of operations to act on the LEDs. The core will
> then create an cdev LED for each LED found in the device tree node.
> 
> The callbacks are passed the netdev, and the index of the LED. In
> order to make use of this within DSA, helpers are added to convert a
> netdev to a ds and port.
> 
> The mv88e6xxx has been extended to add basic support for the 6352
> LEDs. Only software control is added, but the API supports hardware
> offload which can be added to the mv88e6xxx driver later.
> 
> For testing and demonstration, the Linksys Mamba aka. wrt1900ac has
> the needed DT nodes added to describe its LEDs.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---

I stumbled across a circumstance today where it would have been useful
if the netdev on user ports was created at ds->ops->port_setup() time.
It is something that this series accomplishes, but I think it got stuck
here. Do you plan to resend it, or is there any blocking issue?

