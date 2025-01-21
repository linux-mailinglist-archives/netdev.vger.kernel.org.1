Return-Path: <netdev+bounces-159981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F422A1798F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744FE162ECD
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 08:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5810719E968;
	Tue, 21 Jan 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELZoXtCg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE0192B63
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449450; cv=none; b=EHdexaPJCPSB3Ugf9nhaQakeRuBdndCWh35TgYdhMcrdInhqH/pz6mM6fUTHkO7uFH+sQ/V1Qqw0Of+RHYOssZACqORGkg0N5rYR8SJXzseCGLRh5yfI1/PCjrnZGNifaQ6aruP/zgAh4Py/APzL5M0lHUW4wCZ26FTqM9ZIYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449450; c=relaxed/simple;
	bh=w9unddRytQKAdni+4q53Wse+OuvT/3eeZNeY0oFm3ng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sybMNBUNKaVMoVKCS827XtNYKf7pwdG2m3St7KSoTcNrYjfDTCKiYfAwprWsE6s9hnw5K8dTndJB9Nm4aTZZi3zQ/+FPLPo5PbJuJeA1snepxGwJb4sHSpKyJn3oSvi/qWdyp6a86qRxVpP5g3thXW2hKImsN81UOPRvXHCv0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELZoXtCg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43622267b2eso52882755e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 00:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737449447; x=1738054247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox0wdlY0cj4xJv2bB345pIgtvKXgvbgqteFCBiOSqI0=;
        b=ELZoXtCgqZZuwlzyVkuJbprMGE5CD3qfWU8i9YHnLAHlH/88siYh07Im3g4CZQGv/c
         uDTfRGxnSaUk1s2P5hwTfEtHIKHbUYx62vL0Qhnpl0Z8v++IfPe5L/+zIil9LQ11RdwZ
         hGn68viqRiARFx2ZbQS/E3KavWMql1LH5ECd7aclxe9Hrd38xavbshMllq08Q4ySf+rW
         44pr6WECbLJpBYcnVFIr1nnzkpe+RXfUB2jz5CF1RlFOnEKw5g49k2k61G8vCEGB90jF
         BznAwE9tbJAybHYarZhhOpN+ZtRkgzcJa7tbP6buEe1SSDlgUa4eMhGuJf83RVpESjXf
         E5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737449447; x=1738054247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox0wdlY0cj4xJv2bB345pIgtvKXgvbgqteFCBiOSqI0=;
        b=whqVVYUu4xDFK8TzNLS3jq0WAuF7Vm8if8VGuV+bs20aDOX0XWY/2NnybOXNhlzbph
         Du+mRog++0ESLMSKwKHh3VcDERcZAqVAc4Uw8dCu1k/LvtI6CjQoGbjyU9Ou5k7WGfBG
         gtEOuH1S36QypNCJvABrv/KF3hZEN5mKXaPF3f+Rh0MeRpXtLDbJtUPxD5ONXm1TlEaD
         LB/nc94Cl+rvb/kexzko57Hki0EO0d3NIbng4RNr3Ff7D3MSNgT8hG4rMlPIsoCs5jQD
         YNFxSjHA3jlWw7rg3+gmCYwZm1xn1iedJGGAoNnwN9yw8ZbBOnzmRym8Mg3Br2hAdtZE
         JhEw==
X-Forwarded-Encrypted: i=1; AJvYcCXHtYgHffId1jY1v+6a7cPlZKj3vG8k8v9JVZFkFvoKeKhVsUrC9o+FIvLDyjXyV13FXld03VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD2D2m2SUG2qU4tyfthEikhYuQVhWtfftSUA9T/I7M15leQuls
	favB3Hk9Pu6bQaA9x+LF26Ebp46V5U4wizOxQKA0BZZCgo2tk1yk
X-Gm-Gg: ASbGncvoVtREURTyZQzaL2QImo6Il6UgelCN8C81f5ZYnAvaNmxWuJVE02BKmNKOSdE
	EJLPuhwhGQfXgGvP6mWvu2oDi5VzEJDEMwAmhthDKgcbVcMO1xfaOzrz19fvcda1RG39XC5DoRF
	yVonAx+5zlB3C+Y91NudK0Ou1y2YL2kOCPcyTRLceQRenxRijmhrDv+5rsamT8hjlBgTaQ4qkP6
	QHSmVXIeBh80mBrV9H42q1LoE/GadeSSuKFpQnGZ0dl5EaDH8+J8Q+8//29fcWRMyv7kL+/59Dr
	czMwrsb9LvLSEpiVkJnayF9iOfnyWH01
X-Google-Smtp-Source: AGHT+IFL1Jz0qpvHxZpq7oV5+72E7F6dEvJWDy/pA7wdB5SA6UplWgep3rqG0L6ijs7z8YJvBXRDjg==
X-Received: by 2002:a05:600c:3114:b0:434:a386:6cf with SMTP id 5b1f17b1804b1-438913bff57mr154748885e9.2.1737449446583;
        Tue, 21 Jan 2025 00:50:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c73e7140sm233769725e9.0.2025.01.21.00.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 00:50:46 -0800 (PST)
Date: Tue, 21 Jan 2025 08:50:45 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com, Francois
 Romieu <romieu@fr.zoreil.com>, pcnet32@frontier.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 marcin.s.wojtas@gmail.com
Subject: Re: [PATCH net-next v2 06/11] net: protect NAPI enablement with
 netdev_lock()
Message-ID: <20250121085045.480c2e51@pumpkin>
In-Reply-To: <dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain>
References: <20250115035319.559603-1-kuba@kernel.org>
	<20250115035319.559603-7-kuba@kernel.org>
	<dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 11:32:24 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Tue, Jan 14, 2025 at 07:53:14PM -0800, Jakub Kicinski wrote:
> > Wrap napi_enable() / napi_disable() with netdev_lock().
> > Provide the "already locked" flavor of the API.
> > 
> > iavf needs the usual adjustment. A number of drivers call
> > napi_enable() under a spin lock, so they have to be modified
> > to take netdev_lock() first, then spin lock then call
> > napi_enable_locked().  
> 
> You missed some.
> 
> drivers/net/ethernet/broadcom/tg3.c:7427 tg3_napi_enable() warn: sleeping in atomic context
> drivers/net/ethernet/nvidia/forcedeth.c:5597 nv_open() warn: sleeping in atomic context
...

Looks like the whole patch is very fragile.
You really need to keep the existing function names having their existing semantics.
Add a new function, change all the code, then delete the old function.

It also looks as though drivers will end up holding netdev_lock() for long
periods just so they can do a napi_enable() much later on.

	David

