Return-Path: <netdev+bounces-104936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2407590F396
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B273328152E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE021514C6;
	Wed, 19 Jun 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faxPgzzD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D437111AA;
	Wed, 19 Jun 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812775; cv=none; b=neA/EhzOGqlWEgO1IZ25Ll9bmNasjTEv0Txb0bANyUgBljgrtMIlRvkT8Ffbw20XPBkCdeR0bn6LgeADMkrfJSTrW9ErbjWclE2iWb9n9clgJjP3ZVsu3tj+APVcNt8upVP4AyaKZFdmzMuAhvFgpKGiXeubgxKR/wyvIEuTuiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812775; c=relaxed/simple;
	bh=wxs+ur9+J8MZZSzMQc5JdvlOGOmrAYK2wljAKjbMBfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivJIBDck7O6kaKHEO4K50ZKPljdDU+7JRNRrAjrTiO9VtOgHXJcVA6rKWYgrA19tlDPj8GBk9VVfuaRxRQZmqIVUZ2ROepbZucxGuxhQ+3tRTAA9Fr3kPc5xNwwp804lrmMA3fMkOdNa3IlojO0dQkr1G4Ux/UDkLB1DcMa4w3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faxPgzzD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee6eso796265a12.1;
        Wed, 19 Jun 2024 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718812772; x=1719417572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxs+ur9+J8MZZSzMQc5JdvlOGOmrAYK2wljAKjbMBfA=;
        b=faxPgzzDfEnlE3m8+hPAQH8Sl+W8N0nUgY9bY5stUoz7OYKeKV7W6014zXOAm/hkVv
         RIbjSyFKRJcZy+7hRwRjQgVm0PWjbLUGxOzw85cZCOnZgYkj2REfoXzg2sX18NOOzY8B
         pNyfDVlizOuZuvJgdiWb2eZ+qZppJE4e/jbCPWfeS17/FNdpmp+ZOgAl1lqjbpOZwfpF
         7ZKcJf+amogmZssUCgHHUHet/FFFnSvEdbtSRmK5Tu3W5hjTbyjX7onL8cDvzTHeNrd9
         VA0/fZhWkXvvKJlocfrALnre0TpCcbKjvzOEipn6//VNSuBPXU/udIFXebd9tuU3ZlaA
         DQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812772; x=1719417572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxs+ur9+J8MZZSzMQc5JdvlOGOmrAYK2wljAKjbMBfA=;
        b=cYTtULUmRH156yqLtraCUzu6tAXCtd+4SisJAW0eqONWi5KtLaiMyYF593fJxgfH58
         WOKgLWfMB5emsRVHIgK9beyiDDrMtLicohIkigCMVlcPBR936PsRDlZuiMjmTECYG9nN
         xaFTYvwcLKg3yhBlwE9uo2HdKM3PikJ321tvjxHa77Za063TeNcGSYDqZM6aNBVED1K4
         isiwKlYBJIZYfkl42Vztw/98KSsKxKRfVnW714j+ed2WDU+R0agwJeFdaO2AIQ+774XV
         1JuF00dvpfo2fCDKW4fORhexN+7YnaMT3eQ9UAjOw5LnaE4JbJp2cDOzzmvveN1MTtnq
         8IvA==
X-Forwarded-Encrypted: i=1; AJvYcCUNDHU3iJ1q6Qik/aKdZJPrLQgoSqoauozh3g7i58FycsjSVRGjbsx+n9dfzRnSsi/30pvy6wlbMkpHPseTD8G4iu24EgaLE8EGK8pD+dAqFsGp46nclA8+beZ4FHrZ0TAMofcw
X-Gm-Message-State: AOJu0YwyVumzaXvPetpdPrE7jTWtQH9QsdZq9W7bDr5ZS//KPzUonRJM
	FBKu8ebITlmTgrn9nM9ctxinvdVf6jfjpAigCS8u1Bl+qFVekjWG
X-Google-Smtp-Source: AGHT+IFwiQl8gIU3T1jvSVIO0jUG+gbHoSBIa5n8WNL5c8DtlDKdIO8yoYHXyE6rnmwc0Yc+Q3YIUA==
X-Received: by 2002:a17:906:4903:b0:a6e:ab8b:aff4 with SMTP id a640c23a62f3a-a6f94e1f998mr356843066b.13.1718812771445;
        Wed, 19 Jun 2024 08:59:31 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56fa6a1esm675359166b.216.2024.06.19.08.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:59:30 -0700 (PDT)
Date: Wed, 19 Jun 2024 18:59:28 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <20240619155928.wmivi4lckjq54t3w@skbuf>
References: <20240619134248.1228443-1-lukma@denx.de>
 <20240619134248.1228443-1-lukma@denx.de>
 <20240619144243.cp6ceembrxs27tfc@skbuf>
 <20240619171057.766c657b@wsk>
 <20240619154814.dvjcry7ahvtznfxb@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619154814.dvjcry7ahvtznfxb@skbuf>

On Wed, Jun 19, 2024 at 06:48:14PM +0300, Vladimir Oltean wrote:
> Granted, this isn't an actual functional problem, but given that you
> are fixing a newly developed feature for net-next, and that this is API
> that gets progressively harder to change as more devices implement
> offloads, I would expect a more obvious signaling mechanism to exist
> for this, and now seems a good time to do it, rather than opting for the
> most minimal fix.

Actually I'm not even so sure about this basic fact, that it isn't a
functional problem already.

xrs700x_hsr_join() has explicit checks for port 1 and 2. Obviously it
expects those ports to be ring ports.

But if you configure from user space ports 0 and 1 to be ring ports,
and port 2 to be an interlink port, the kernel will accept that
configuration. It will return -EOPNOTSUPP for port 0, falling back to
software mode for the first ring port, then accept offload for ring
ports 1 and 2. But it doesn't match what user space requested, because
port 2 should be interlink...

I think you really should pass the port type down to drivers and reject
offloading interlink ports...

