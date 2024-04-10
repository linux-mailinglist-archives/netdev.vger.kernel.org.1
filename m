Return-Path: <netdev+bounces-86787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F078A043B
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 01:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE77B24F9F
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9E0381B1;
	Wed, 10 Apr 2024 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJHVGoyh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F633F8F1
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712793059; cv=none; b=gShVJj6AVxH60Qxf0lqWT9OOkwEe/Seli9nA8z4s1ZwSlZ5QFBkIBdvtoxff9z5TRWT8QA1CcRuxAoPqfAhlgO66oqJ/ZFm5abeHKspGR2CKWirLpeBXc0LVPoxgPpL5fdaVkK0E/E8s1Ym3kVtMfVWXOkw+D0Pj40fSqaBHak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712793059; c=relaxed/simple;
	bh=R7GLHASk5lrra9DDaXvA4iPJFyp4IhEgQo/7mH1HBlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6FYeCIwyn7bUh502MzNNP3kp3gSBz1naRwL3QhunS6WHvmgJuPAXO6fFCmpw9EDBTeQtENmFY1lJ0a1R1E6PjPuNkcNWkfWHhTg9KPlQ//o7kNk4lybJNYb/P0Dbe+OfGWVMuZ/sq6uoerfPxJ0sRxY1Pd1UuxT+VzPwffg9ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJHVGoyh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-417d73dedb6so772565e9.2
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 16:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712793056; x=1713397856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Es3XA4to4YejteRCMUbukyMW+UrEfmNKzT+xSe16LG4=;
        b=hJHVGoyhgBcnG3wf7d1edNLFOLvjB2hFoCBHRABnbSUkhTJsSyGhy7pqk9j0wZHPy9
         teYkHvyoJv7YF9qa1nn5z0Fa4VyFepQgDcSN1RojuGXQDIPi2FAh6CDNnkHUaBqiJfCm
         qaW2qZQwEjv/cFSHzX/hhLj5r+G/MF0JN1FKEfiwv9MSVij6QbjF5mRQnFtH1NNtutYm
         K3DINPBVP4pBtkvlbGGXQcqjoNttHvVlEPfDewsJKlxgk3bDWgzCRyC+0R2JeOTcZm3c
         egz7AGDJtxvQrz12FIAKcnJG/vZgtonS8HkCBd3Hf1I80Qaux0tTMImgqPxigZC8Hs2k
         OkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712793056; x=1713397856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es3XA4to4YejteRCMUbukyMW+UrEfmNKzT+xSe16LG4=;
        b=P+GXTvsHss/QGYYh28QwMZm/cHQ61ntZQKJatWlKHNbettr3YGHFYfSiz4WK1usSUV
         oJTxI0vHSP70yfGQm6ST6iK83I7nILoJregql1oVG+LL5alHgBK9w8NZPF6c/yOEwapE
         Syhslb7WRhQG1FG4FgzaSTYFdYaMLe74vD6WypsYKGd1K/NU8QlLHNvO341Kn+XD5KLK
         rg5u5GXIaX8y6hkBeOozOVCtqisFfc2/X4whsvvgAIH60X9/o0SlAt153MRjbHGEvSL8
         6+s4RUTa55xFlTRas99/3HrZviJY9lEhUchizP30/8wJ9oK9CqgzIbYWovea4es/7LOO
         Dt7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe9LpXoVuWwtHit0mXrNiy7xJfKBna+rAL35ofSuaP8eOURFUNJP0/lqMtS7PmfFO2WDRs8VamXFm7rMmo7P0CcF5YpTpa
X-Gm-Message-State: AOJu0YwFXz3GiaV69u+2I2gkobRpp1MhIcWmcWXx+iJTRyE/DZOE4IC9
	ce2BO3YmN3QCtODIqnHUzaS9DKcivUDm4idNljL4Nn6ddQLveTHN
X-Google-Smtp-Source: AGHT+IFBd+sxzw42AM74xrecBf93O/8djx0rLTBaeFxvcZ0qs4ug7Twlu/NQN7MFvTxY6bv0jI6J6A==
X-Received: by 2002:a05:600c:4ec8:b0:417:c34a:c42b with SMTP id g8-20020a05600c4ec800b00417c34ac42bmr1439893wmq.3.1712793055507;
        Wed, 10 Apr 2024 16:50:55 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id m4-20020adffe44000000b00343e760c637sm376527wrs.84.2024.04.10.16.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:50:54 -0700 (PDT)
Date: Thu, 11 Apr 2024 02:50:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v4 3/8] net: dsa: move call to driver port_setup
 after creation of netdev
Message-ID: <20240410235052.utn6c2ryyfxgo4zq@skbuf>
References: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
 <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-3-eb97665e7f96@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-3-eb97665e7f96@lunn.ch>

On Sat, Apr 06, 2024 at 03:13:30PM -0500, Andrew Lunn wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> The driver-facing method port_setup() is a good place to add the LEDs of
> a port to the netdev representing the port. However, when port_setup()
> is called in dsa_port_devlink_setup(), the netdev does not exist
> yet. That only happens in dsa_user_create(), which is later in
> dsa_port_setup().
> 
> Move the call to port_setup() out of dsa_port_devlink_setup() and to
> the end of dsa_port_setup() where the netdev will exist. For the other
> port types, the call to port_setup() and port_teardown() remains where
> it was before (functionally speaking), but now it needs to be open-coded
> in their respective setup/teardown logic.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---

You can keep your author name and me as co-developer. If I changed your
author information it was probably a mistake.

