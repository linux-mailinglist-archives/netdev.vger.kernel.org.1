Return-Path: <netdev+bounces-143702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91979C3BAC
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160DC1C21CA4
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D849176240;
	Mon, 11 Nov 2024 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK+aT1jc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905221487DC;
	Mon, 11 Nov 2024 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319551; cv=none; b=ddNakcaRMQ9PQCool/ruhmrGxU3q34BoSPSXt+aAPeu/vJRbbqQwp7woU49lLnUhvtb9bfR5q8HOI589ksTf0n4KyU6xPIcV/8k3eymWEJc6JMnEiql2YzuySWD6rAI/WDn4hvbgXAIXVRuS+KjdSeDlovMTXY48w+whu++tRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319551; c=relaxed/simple;
	bh=Zfe5DqoVix5jhLP1E1nVQV2CPcwNRrCNvsL8r70Lcc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNbkv9+/bz78KyeWLDs6jh5/zxneGZt5cJFnGyxlKbZg2XG7n8sD0JwY2p+B0Izs5YCtQFBXIKBvT+6XY/71FUNgcJ05xnjvfH0NNMyNe3xMGQkSX3kf15L9S0paGyrVvePW8AUOfHfYHUlBMK54JRQ1P82xyX9kNhzxPg3Kat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TK+aT1jc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c767a9c50so41199005ad.1;
        Mon, 11 Nov 2024 02:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731319550; x=1731924350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvPH2N3OAhQHoEMAlrZgn2gjzjGSexp2plsOz/L89/o=;
        b=TK+aT1jcLEOtUbkykUaxBh8WqmJ6jv+ZeUIVwzwEcKhIugJ+jCqd4UhTt5yYgReeRl
         GuMOkRP38duMaJfVc/NR9+g2AtbxfYYEoSQJ4YAR3QoOLZQ+YdWRepNcxJ4nfUBObKy3
         /mzhj3Ll1ZFZTW9GmhDrqZ2/vizvlny9xlN8Pjyqey6noG+TYrlD/gYYaYosBI3zgxWh
         lrzBdjj26UxZpsIAdLmafcsvPT7TFroXJxlGTHvyrQG/zdR77etATo1XlLjI71TneOEm
         dgPxsA6mSywOhBlgBficI1tDEXEAZc31oM/2eXPEevMz5Q5gqTkobKlXCuXoGQH6AUsD
         f69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731319550; x=1731924350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvPH2N3OAhQHoEMAlrZgn2gjzjGSexp2plsOz/L89/o=;
        b=HEEIFoyF3wYLF+vT/saYWZgnOhjt5lA2MSfcRkOM9B51K8sKfEd8HL0GMc54uZmAkd
         EYEa1qSF+Z91ohCEmDxnHudJUXzHyi/ghh4VPh1cidwfVl5Th7kEVm2lKwPlQldA8ToX
         ClE2ySyYpO+s7ihIHDOx19/EVcpZRRlhhp0i7wB6TgYHhoIqZ3VmhW5BmevQ0IcQUm1w
         nxfwpVVLsOZK0AXssCPNvsB7qq5KmmHIyTorhE0dTFfVgeQ4MsubRtZBBeEaaOM6+WrP
         ePeEDLGUAhiWh2Kitl6odiuD1O8ubxYUY2HPPbwYGfliJM8WStUUAwkwWwnk7JDCic7z
         aDSA==
X-Forwarded-Encrypted: i=1; AJvYcCXbHICEki5vnNIkwkfb7rLKcXjCPOJPaVAOhqJsKFMUWUR9dcHeQbYKoOJoGV94m+vUk09TYrAw/CGd4g0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7eMHkKHugEv3VAH7tmg3uKgIxFv7GpvqZta3fAfiZRkhm7qRL
	+mgSoLOa2o7Dsj0obxGLxttO7P7xvi3fzPLsQTtARWuKgkSPLQ6p8dQlLOZOWhHMtA==
X-Google-Smtp-Source: AGHT+IEiabOAJ7wISpdweL+1JDundoKuZoGfOQLtSIakO8qurYurwUN2EarAaFuij48zfW8FP5TsaQ==
X-Received: by 2002:a17:903:230a:b0:208:d856:dbb7 with SMTP id d9443c01a7336-21183d5552fmr165550465ad.39.1731319549735;
        Mon, 11 Nov 2024 02:05:49 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddf754sm73095645ad.98.2024.11.11.02.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:05:48 -0800 (PST)
Date: Mon, 11 Nov 2024 10:05:42 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net 1/2] bonding: add ns target multicast address to
 slave device
Message-ID: <ZzHW9llUizisMk3u@fedora>
References: <20241106051442.75177-1-liuhangbin@gmail.com>
 <20241106051442.75177-2-liuhangbin@gmail.com>
 <ZytEBmPmqHwfCIzo@penguin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZytEBmPmqHwfCIzo@penguin>

On Wed, Nov 06, 2024 at 12:25:10PM +0200, Nikolay Aleksandrov wrote:
> > diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> > index 95d59a18c022..60368cef2704 100644
> > --- a/drivers/net/bonding/bond_options.c
> > +++ b/drivers/net/bonding/bond_options.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/sched/signal.h>
> >  
> >  #include <net/bonding.h>
> > +#include <net/ndisc.h>
> >  
> >  static int bond_option_active_slave_set(struct bonding *bond,
> >  					const struct bond_opt_value *newval);
> > @@ -1234,6 +1235,64 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
> >  }
> >  
> >  #if IS_ENABLED(CONFIG_IPV6)
> > +static bool slave_can_set_ns_maddr(struct bonding *bond, struct slave *slave)
> 
> const bond/slave
> 
> > +{
> > +	return BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
> > +	       !bond_is_active_slave(slave) &&
> > +	       slave->dev->flags & IFF_MULTICAST;
> > +}

Hi, FYI, in new patch I only set bond to const as slave will be called
by bond_is_active_slave().

Thanks
Hangbin

