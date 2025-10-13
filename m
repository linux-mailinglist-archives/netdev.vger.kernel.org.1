Return-Path: <netdev+bounces-228669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 920F6BD18FD
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 07:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8371893F25
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 06:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D631C2DEA7B;
	Mon, 13 Oct 2025 05:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjjhREQy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114CC2DC79E
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 05:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335184; cv=none; b=QstYk6ZaXdGqcbZIZp9UpIocS97yDqipbF8me15D1Gp+xXf+TEKpmdAfL/UHemdYXh3V6t/BicFGnVlqmrc7O80aYFIJWIJXpJ9o1+V+a6NHHVwMBD2bZiqsg4tt6DlJW74P5Oelx4dgQDANBlSOE9TyDIL2S4MZsH6TrAFg6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335184; c=relaxed/simple;
	bh=Bd28e7IuOcHibn3LLyPlNz4Tj23RtsGOy6jtLQP1y84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9ThUfcMxaum00r4HGcyszIb6ggwPh9GktekInOda2FCxm/qcuanVDEm4wfA3+o+oZLMzi2BDGXSdqnmqSuQQOA6xu3zxgEck9nSN/SExxB4JSYJjenh2DpOa7TORxFb9NfiGSumrNgd9zROdsXOtdDRiIHgQUzskY37oSWzzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjjhREQy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-639e1e8c8c8so7299890a12.1
        for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 22:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760335181; x=1760939981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQNzxcG14jNClBvMbrCumaocAylKfaLe9L9Jz7gjInc=;
        b=fjjhREQyYvIXooCRS2QdQWl0TXKyOm2CeFRLd7GTQXju/WgHUwxKn4LvU56cUlLn6j
         QJYVeIL/grccyAg7uoIsfmBF31uiGo7t4+ikxUvP6ONxd9ShP3rCk0ni8m6zZCgCNN8o
         xsXJXhCLaFzyvbSDSnphwExdRjtxEUTTardYk7ebvF3+bHnCtFpCZ6LgYRfCYVJib9x4
         8Abeqx6fXkD5nL/8UZkWXZCUKeiEObmoLd8YaSwB9VDLjH/JYpd4yKH29xdQS+bM1b5G
         ObJ2Zeu4gLUEvfOIEtvHbd/maQHP8qsQTA9k9p5QG454ybF93eQ29piwxwO48OBhVNpi
         OwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760335181; x=1760939981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQNzxcG14jNClBvMbrCumaocAylKfaLe9L9Jz7gjInc=;
        b=nW2JxEqOYW9SpmEDHSewF7oUhi+Ht5wGrtNhm575br1M06EZUlFv9CaDxJRK8OfkPs
         1WS8ITDNjYHrOrmEtZsQmfj8aEdRsdDIHTRn7iTefHwVZkSenHWLivfb977kn4ERIeDd
         gPZqIW83PXCh/slKRpQAXATDjF0HW/LfqGrVL0hSATDh1YEONnQaISFTdEFJt9EybZEl
         SB4p0zdOoxbPeXjWQbdPj60nKlgCjN8KnDzq2VDMqid4z0GnlVNyJHCkWTu65IKNZ/ut
         643+IQyxLvwQ6dllU4gonr2t+aRqtPYdQbSIvPGCkOWUvIVwsNs7MRSdO8H0KvzcnQXu
         +fEw==
X-Forwarded-Encrypted: i=1; AJvYcCVePYnl5kWtc9y3L/UuugHXm+qkWXTPUf3e9Dv7r8e4CEs8aEXhIYNBuHj/PS0eHrqQslfUAQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk0+5t/mYrXHs8PUuTUO8vl4yLci2KLSuHf6v68mIIhf8pMSWz
	jduiy882N/Li/KEgGsIrYP2wEWfQsQBylpb2Chr+xNpJWXg3YEwz0Ev+
X-Gm-Gg: ASbGnctuRcmqEgfuYpSoy16RAvZGAWRuQUmq+7L/NaZZIoqlAv/yCA2Ak+aQLnAHQjA
	7LoShcHW+gnGGsSOnG27fkybtnwyiMGKu6ECGdwP0VGjdvTjsgmr68wqClO5lU1Sm48IRWwV2o1
	BnbEF8VJPKd0SQr8iEU/PtfteSApfZ82nw6s2/ZT5/N8Kg88Mk257Dt8gfZduHOMvLTcFLCn3BH
	/CQFHFgrJqdXrjBR664EhSO8qhieLfs4cp6Ii4tJZKbdwXUk/nPuZaLYXzMnvFpN/KEDQW2yOHN
	72Q8dOj+57oGdqP2daT//2RLWyzjx4pac/lcU5XpznvFPNgjr9/NDwgDO0Ue3KaMQ3F1HZf6Rrr
	WoHaT2XANfauv6W/YCzfP76J2beNLg0AmjptULlcB7KUGaXPIT0/WWA==
X-Google-Smtp-Source: AGHT+IGiGEcrsAYUHxU2I2SrW2lGOTNaCoPwD4SCwXuyD4vprrWrEyrI422ngQmr2KS9P8klCSJyjQ==
X-Received: by 2002:a17:907:86a6:b0:b45:eea7:e986 with SMTP id a640c23a62f3a-b50ac4db255mr2188162966b.43.1760335181143;
        Sun, 12 Oct 2025 22:59:41 -0700 (PDT)
Received: from foxbook (bff184.neoplus.adsl.tpnet.pl. [83.28.43.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c129c4sm862815366b.41.2025.10.12.22.59.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Oct 2025 22:59:40 -0700 (PDT)
Date: Mon, 13 Oct 2025 07:59:37 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: yicongsrfy@163.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
 marcan@marcan.st, netdev@vger.kernel.org, pabeni@redhat.com,
 yicong@kylinos.cn
Subject: Re: [PATCH v4 3/3] net: usb: ax88179_178a: add USB device driver
 for config selection
Message-ID: <20251013075937.4de02dfe.michal.pecio@gmail.com>
In-Reply-To: <666ef6bf-46f0-4b3e-9c28-9c9b7e602900@suse.com>
References: <5a3b2616-fcfd-483a-81a4-34dd3493a97c@suse.com>
	<20250930080709.3408463-1-yicongsrfy@163.com>
	<20250930080709.3408463-3-yicongsrfy@163.com>
	<666ef6bf-46f0-4b3e-9c28-9c9b7e602900@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 10:57:05 +0200, Oliver Neukum wrote:
> > +static int __init ax88179_driver_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = usb_register_device_driver(&ax88179_cfgselector_driver, THIS_MODULE);
> > +	if (ret)
> > +		return ret;
> > +	return usb_register(&ax88179_178a_driver);  
> 
> Missing error handling. If you cannot register ax88179_178a_driver
> you definitely do not want to keep ax88179_cfgselector_driver
> 
> > +}
> > +
> > +static void __exit ax88179_driver_exit(void)
> > +{
> > +	usb_deregister(&ax88179_178a_driver);  
> 
> The window for the race
> 
> > +	usb_deregister_device_driver(&ax88179_cfgselector_driver);  
> 
> Wrong order. I you remove ax88179_178a_driver before you remove
> ax88179_cfgselector_driver, you'll leave a window during which
> devices would be switched to a mode no driver exists for.

Hmm, what about registration?

I added msleep(1000) and simulated usb_register() error, then
cfgselector binds to the device and switches configuration before
the interface driver is available. But the module fails to load
(I fixed this) and device is left with no driver whatsoever.

Moreover, according to c67cc4315a8e, config switch is irreversible
since the device reconnects with only the vendor config available.
I can't test it because my device doesn't have a CDC config at all.

There is a gotcha. I tried to test in a realistic scenario: device
hotplug, module not loaded yet. I found that udev apparently retries
loading the module, so this state would be fixed unless the module
init error is persistent. Still, better not to rely on this?

Would it make sense to swap registration order?

Regards,
Michal

