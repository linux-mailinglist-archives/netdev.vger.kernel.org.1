Return-Path: <netdev+bounces-83954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E61895104
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E622884F2
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC55D5FDD2;
	Tue,  2 Apr 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeC6+46B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C75FEE6
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055419; cv=none; b=qcz1jA1/zhFzAnui0Rw9EG6ET0vcS09evin4hGBUEmTJbgvuzkVtdIKqOqmN/ePKT5bm8TFEcxlJPkM13KKw111AMTFjO1e7t4BlFpIePhCmWcMXtgs4fhjxoc0Yq95nCYG94yZxqmgQdIZVoHRQlS///ENDS7PSJ5/+dsJf0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055419; c=relaxed/simple;
	bh=IO2tkqv1Zs8EyEPRdC2Q78iV1b4Foh/OsNuppE3OAyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU6KdiRMIPM3ePY5xS28gPVt/yLPncUexa5DinEjiZmmyKIruBheaWQSHUTn8Zv9KYIYk/rMGPXATubMK1lkDDURP7nKsLqYXukGmkXHb5vfW5meH2bIM6Lfg1k54lBKX2jW/RqcgfYcytyp5vzPam1gKlxss0KdgCt/dVNCAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeC6+46B; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513e10a4083so5728541e87.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 03:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712055416; x=1712660216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=enkxNowixkX4EyjkX+wdueAQozT+eYKZfKpPEePVWrY=;
        b=LeC6+46BzxlR52syVBHV16x+ruiJ85c+VR2w8aLvl9oZ4LA3p5IKmSMgIauc3A1S0/
         76p1r/6mCNA5k7KDQkqiVaNUHjjcHfjq8qSMIWQnCYNSrMKE9r2VGg/1aSmQVc2ocgmc
         bzukY7O7DLDjc6mgYr7k8vbhWmwvp+Cr3ZPxqYmeQACUlvwJHbeJsMhpZY7zg/SRJ1Uy
         Iddl1wRo8ghgXlHnIYk+CF9yL7vl4bjYfBMX3HWBoqV941fqd5Bi+V+rtdjNyex51ypq
         aI9QYiR4ihQj2ZsJwZ6QI+vFtosjTYcVS6gqbH6gh0tm7WtFbA+BVDZeZ75H7Ck0FmsU
         oWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055416; x=1712660216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enkxNowixkX4EyjkX+wdueAQozT+eYKZfKpPEePVWrY=;
        b=wNGtF97OKmOKIDhqnPkt9f1PK5EcWyyvC5A73s2k9aBs2838C+rVJHWY6uxGVyw7Ot
         wYsYu8E3PTbRKgrTtSvk3YyAIgmIhxUODXU/FNurMg6payt4Ny8rdR4MU9rajXg2ecmk
         YRs3ubuHLKl4n4vnwI1qvg7FOSs8dw8nBEVXOSe0L/5hWwZrgdbvFDzd2Up7E4DBzDG8
         sEeImrV/VtQWgzjA4hFNDzhKWdgLK/4DtMhfnyTOhXn20BPOTZ3sJfXvnmeHEk31EWT7
         O2ScHIqb2Xo8bKGtvg7TJ8Dony/dmjBYUkuZtWmJR2prlmVaY0C4I9MjIc86AQKdpaGW
         ncmg==
X-Forwarded-Encrypted: i=1; AJvYcCXNlhRrjxmIpRIiXs2pZrAJJP/AI0fJynoE/usmA05qKB4bvARNuwGtmDDagN9irOUKyIluGTDrmSjymdk5xDLY3evwbzp7
X-Gm-Message-State: AOJu0Yyj4yi8mGSGWt2nikKRTTVZ/8sa1P9+kJhpcotIIVXdkn6wJD9+
	FdCH4ShT1JM9Ze1OezRLHauNGhbLt5QM5j5JMaVfIObATClizVPX
X-Google-Smtp-Source: AGHT+IFzMPlZ87YSktIkxh00MBCAV4KZ96l2f5xfcHrZkzp8tYpHBuW0saDZBV9ncYNblWCQjOpnjQ==
X-Received: by 2002:ac2:5f73:0:b0:515:9eaf:5c21 with SMTP id c19-20020ac25f73000000b005159eaf5c21mr6652705lfc.36.1712055415720;
        Tue, 02 Apr 2024 03:56:55 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id bu13-20020a170906a14d00b00a46aba003eesm6377211ejb.215.2024.04.02.03.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:56:54 -0700 (PDT)
Date: Tue, 2 Apr 2024 13:56:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/7] net: dsa: Add helpers to convert netdev
 to ds or port index
Message-ID: <20240402105652.mrweu2rnend3n3tf@skbuf>
References: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-5-221b3fa55f78@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-5-221b3fa55f78@lunn.ch>

On Mon, Apr 01, 2024 at 08:35:50AM -0500, Andrew Lunn wrote:
> The LED helpers make use of a struct netdev. Add helpers a DSA driver
> can use to convert a netdev to a struct dsa_switch and the port index.
> 
> To do this, dsa_user_to_port() has to be made available out side of
> net/dev, to convert the inline function in net/dsa/user.h into a
> normal function, and export it.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---

I think the API we have today is sufficient: we have dsa_port_to_netdev(),
introduced at Vivien's request rather than exporting dsa_user_to_port().

Also, I believe that having a single API function which returns a single
struct dsa_port *, from which we force the caller to get the dp->ds and
dp->index, is better (cheaper) than requiring 2 API functions, one for
getting the ds and the other for the index.

