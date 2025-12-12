Return-Path: <netdev+bounces-244482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD3CB8AD1
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 12:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E1730671C3
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2897B31AA90;
	Fri, 12 Dec 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iauBTHPB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB7315D39
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765537906; cv=none; b=GwTnMaFAEV4qmnSYD1aA/aOaw0b200x0MAQ0roj618zNeh6oIGwQRwYzfWCiouT1TJ1OliB5eGINY3fzVUJo1JLPOl/+10BkpIAWtN2qATGPS7EwFck8Re/xiB1qAFxtilpnrEvg92ZjqsCNjy1WBuIduXQ4bDfq9gkVdTvmApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765537906; c=relaxed/simple;
	bh=Qi0kf4DHgZSF0itXehy4M1IigW5Ye60xVK7z3FqTfn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ledHr+2BzCXSH5emz1dRDgKkyeX1RgZ6Ryq5DxeRkgQsJvz1fcJw18YETzdv0ZEV5Da1J2KcltNcdH9XQJBX7b8hbFwjgh5NUG0IsPjiBYIKJcO2B1VOx4YcFIrVDrdoGapazNzM0GYLk3dwZF5Val0vwCN+YyaFYfdSltIXWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iauBTHPB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7355f6ef12so196940966b.3
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 03:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1765537902; x=1766142702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi0kf4DHgZSF0itXehy4M1IigW5Ye60xVK7z3FqTfn4=;
        b=iauBTHPB/kYvCWaG+gZXix1aKPd5pH1a65a7kwwJ6jP83aNhh3NmmIqkNHieaJlPxy
         CHHRuGYMn80P9NSMicWru9MAm/JK+VgWsnvpeKN7RryKoIt2GRY/wMO4I9dPwc6HJ3em
         TLRhesGA2nCcanFaS6HPCBfFeZ5fiQr+Tm3JhCtLi8thlKri5u7WFSLiBFFkFjC76KI/
         60auXu7YE+369LsABH6c52p1jgLXPmvp/icXVNXKjeCNawb/Jm4/sI7Zemk1frAZzDBC
         /+G4GMq2lqqtJ7ll5bDqP/Co2IwwLb8aWl1sddFx7sTyxec2qNU9ri/d6Vw5oLdgfkGO
         h8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765537902; x=1766142702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi0kf4DHgZSF0itXehy4M1IigW5Ye60xVK7z3FqTfn4=;
        b=oGOB9WLZCvBPrRWueva1h4pejQ9W/grJAef0dluVVpJUKN7eneTvywzvVMC8Ixlu07
         lVr5rUPi6GTN6gyW9i2RbGw4wHXt/FP80nVFWbi0f/oWC1ltqsG1fY/9Pgwrr197Zn8S
         VBLwrng0Eqs6urpqQrPEPBMOzSbnMerUPJV6lgm3eND1yUg6gD/IWs1UhObeFzEgJLDI
         qA5WMI0YArcmOunTUDiFpIorgh8hPUw+ms7temeAviIi3U91AmF2jODBjJogpkwN9vq4
         chOH58cjhNxTppkhRCUXwAPwBkLE0Akf4NntFaFgt0akDing34S8GFSeYOAdx6ZtYYJ2
         JjhQ==
X-Gm-Message-State: AOJu0YzAzWPx/R1Q0LLm9HTPXuY15mem+pnoeHwriiRx7R5lEEZN8KZ7
	ieJKDqrbMN0Ocrs7mlXPp7kxvD187cQODXMLhgky0dN3DaxE5dIZobIxeL/efZokhEoyigweetS
	Jc/79
X-Gm-Gg: AY/fxX6ZptTC8SxQo88sTWzO3UO6zppUfBgJCtMLSwfchjXmxUhSIlSQOxk7Xm3EoBL
	P+cKo1K3mmIib0PCcl1cMuImf3HE7Gtem0OhZJu57DR4HpIq/mIrIer6cbEIGRLwtIoiYEhS5nc
	E3lOb3flF8Q37mkSDZYfHf1+MASSENcN9eD1z52JKTgfp4VsuWQDg708TZLEvzfZcJXtLLaOyDk
	2/pG6CZ23hS8gaDWhuokZyvGl69tKLwWdczX3oi4WTgaZfQQ04156uK59dnGPaXHpRQ2sYbRM3G
	0nY0JMtsebNz40y7bzvSfbQMTx6wAPWDiAB8ZB75fOaI80fcs2pCA+s5J5z9rWo0Rv8vpLypIKF
	PElh96r2r7z8T3NmSh0p4Vb+bkGJYIyuzAXiv9zAln0GQgtSyi8Cy9jY36rtbbYSV7J2E2zDYhI
	kkd2Xa16gdgaqGtc+ZPa8=
X-Google-Smtp-Source: AGHT+IFmv5COMcmA4FT2YaOWuFJZ5E1bCiuQtdXozfcy670hljn+VWTpNS9TuLAE+vRQXNnfHH9yBw==
X-Received: by 2002:a17:907:960d:b0:b72:ddfd:bca7 with SMTP id a640c23a62f3a-b7d23c1b1a9mr146070066b.35.1765537902376;
        Fri, 12 Dec 2025 03:11:42 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa570174sm530693266b.55.2025.12.12.03.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 03:11:41 -0800 (PST)
Date: Fri, 12 Dec 2025 12:11:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Richard Cochran <richardcochran@gmail.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Simon Horman <horms@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC net-next 11/13] dpll: zl3073x: Enable reference count
 tracking
Message-ID: <utlzkss7sj6xgur4aysi3wpt2v4ssxmh5rxsrk7hiqitjlx2qi@btkzluwtapsb>
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-12-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211194756.234043-12-ivecera@redhat.com>

Thu, Dec 11, 2025 at 08:47:54PM +0100, ivecera@redhat.com wrote:
>Update the zl3073x driver to utilize the DPLL reference count tracking
>infrastructure.
>
>Add dpll_tracker fields to the driver's internal device and pin
>structures. Pass pointers to these trackers when calling
>dpll_device_get/put() and dpll_pin_get/put().
>
>This allows a developer to inspect the specific references held by this
>driver via debugfs when CONFIG_DPLL_REFCNT_TRACKER is enabled, aiding
>in the debugging of resource leaks.
>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Care to do this for the rest of the users? Not so many of them...

