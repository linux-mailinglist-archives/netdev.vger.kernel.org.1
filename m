Return-Path: <netdev+bounces-105177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF16A90FFD7
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738C21F213BD
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F850288;
	Thu, 20 Jun 2024 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6BntdGI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B5628;
	Thu, 20 Jun 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874137; cv=none; b=ibhUtGZjAReu4seLssfvPQwdYwbZnWgy95J53WdorqYaLeEcSbUNbbeUPD5Nx7gWW+OZ9vEcl3yOyIf5hk69AyKpw+sUsbYjAIGz4qKyQ3f1FKfg1jbfGlzRj4AJoKWMsfD9DOna0FNvgieypus0U7xzDduz8TAO5Yn/jnDzfoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874137; c=relaxed/simple;
	bh=DcaHCutLUcucdupDruVjpYkFp5GMrRUdppVUXPcovpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjTk5uXMIvzDCoeFnptrA0QHIz2cUQ9Jb6A3ksOvaGVaNuQh9PSk8ycFA0BtASR830srpZ+ICiRqZqS/a5T+UfnVSlix0Au2+icX6Zsxvf7zKsk/rBgceX+3oUD/Bc0E89nx+h1oeJ7fFf+AnirAm7xXb8VBh7V/5Ul9TdYergA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6BntdGI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso111610866b.1;
        Thu, 20 Jun 2024 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718874134; x=1719478934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=reqi4o36mn4qzlSpM+6S4dwkZbNZu42ZTuDIZ+8NfZw=;
        b=K6BntdGIb5ZcK1eceWEIpguIQRg/QnF1PNYTzc9f/q1KzaVGpfhmxDw4bfJQHv2U8k
         eRUE3IARQ8Ud40afix6vHroi1e1pHUN5Tsg2yIGj/bVUL0nCdFJbC1OMUKOZ0QPqteOU
         toEW39xJVbHJMn9NOmFEI5MaPoMY/vhcUD4gBFErCXrYVCqb3KdBMPSXuSXvJ0kZWMsD
         xl9x4Boyf0F55v+OUmvI3IKYy9AIY9uqs0OD79C2F7JB3ptNM7oHvWrup9jxGjZ/x5cD
         aaNbcGbggLo5M4IBO5YmhTCtRXBluMuhAz86TU2L8o28pQBlJbqYnsrVoVLRZr+F+DrD
         hb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874134; x=1719478934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reqi4o36mn4qzlSpM+6S4dwkZbNZu42ZTuDIZ+8NfZw=;
        b=ZFpSLc90BJIzrrUjUZ8tq020xJvTDfm4qEKHqGWqnX8C1El/9QhBPGrnDf8tm9I18b
         H2efKVQ7TVsZM9jxjgnAiWH1KUBSsGtDwGOf1no2YzeCvNIbXBhJoDCFlE+08svbuWMy
         Qgd/P6deXvl8lYV0lfen3AoHjJtKZs7P0fjL2K5mrM/RfzEx/lmD+BzcFJFQ9V9fMR80
         GEoysYR+4zs2nc3TeuKUJsN+RbNlP8OP3NW6cWCMQcNeECeuO/zqlzciPIZg6rWckbCF
         11V+RWvPHslOMjtXmJFuRtL3h6QBzfWCsoGynMQJccLT/Tbx+DvDD8phjHMLCRHysCvh
         1eIg==
X-Forwarded-Encrypted: i=1; AJvYcCVe60lByYhdD28m5PA1BpKUCV2w6xRkzhCML0EoCPdpHFh4E9INUuoHbd8FeVrkucwvx7BCfGK3OqbkdDu29batWDWXmQ2XtRDRz3vjUGcWkca4uwABDFy1HQROirWNWCqZcI9R
X-Gm-Message-State: AOJu0YwqbrDcXq3k4pjS6zAPYTlgzVWpTjUR/H/Og/ZENXPi6kbFvXlJ
	mhFWA6T4dt6pvYCCYa6c3PYHZl8uIlfcVJLGOkQdW019QVc9N06W
X-Google-Smtp-Source: AGHT+IGwq23nKii9zi5kusaPYSdgYJYSMCNAoo2+QGm3mZizaU2pqisyJqgmA7CUbFPyDyPc9iVDmQ==
X-Received: by 2002:a17:907:a706:b0:a6f:1600:62cb with SMTP id a640c23a62f3a-a6fa40d42eamr331477966b.3.1718874133969;
        Thu, 20 Jun 2024 02:02:13 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41a85sm752988366b.179.2024.06.20.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:02:13 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:02:10 +0300
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
Message-ID: <20240620090210.drop6jwh7e5qw556@skbuf>
References: <20240619134248.1228443-1-lukma@denx.de>
 <20240619134248.1228443-1-lukma@denx.de>
 <20240619144243.cp6ceembrxs27tfc@skbuf>
 <20240619171057.766c657b@wsk>
 <20240619154814.dvjcry7ahvtznfxb@skbuf>
 <20240619155928.wmivi4lckjq54t3w@skbuf>
 <20240620095920.6035022d@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620095920.6035022d@wsk>

On Thu, Jun 20, 2024 at 09:59:20AM +0200, Lukasz Majewski wrote:
> > It will return -EOPNOTSUPP for port 0, 
> 
> This comment is for xrs700x_hsr_join()?

Yes.

> For the ksz_hsr_join() we do explicitly check for the KSZ9477_CHIP_ID.
> 
> I do regard this fix as a ksz9477 specific one, as there are some
> issues (IMHO - this is the "unexpected behaviour" case for this IC) when
> we add interlink to SoC VLAN.
> 
> I don't understand why you bring up xrs700x case here? Is it to get a
> "broader context"?

You have the Fixes: tag set to a HSR driver change, the fix to which
you provide in an offloading device driver. What I'm trying to tell you
is to look around and see that KSZ9477 is not the only one which is
confused by the addition of an interlink port. So is XRS700X, yet for
another reason.

> > falling back to
> > software mode for the first ring port, then accept offload for ring
> > ports 1 and 2. But it doesn't match what user space requested, because
> > port 2 should be interlink...
> 
> Please correct me if I'm wrong, but this seems to not be the case for
> ksz9477 - as I stated in the other mail - the ordering is correct (I've
> checked it).

I was never claiming it to be about KSZ9477.

> > I think you really should pass the port type down to drivers and
> > reject offloading interlink ports...
> 
> As stated above - IMHO I do provide a fix for this particular IC
> (KSZ9477). With xrs700x we do have fixed ports supporting HSR (port
> 1,2), so there is no other choice. As a result the HSR Interlink would
> be supporting only SW emulation.

But there is another choice, and I think I've already explained it.

        HSR_PT_SLAVE_A    HSR_PT_SLAVE_B      HSR_PT_INTERLINK
 ----------------------------------------------------------------
 user
 space        0                 1                   2
 requests
 ----------------------------------------------------------------
 XRS700X
 driver       1                 2                   -
 understands

I am bringing this as an argument for the fact that you should pass the
port type explicitly from HSR to the offload, and use it throughout the
offloading drivers. The hweight(ports) >= 2 happens to work for KSZ9477,
but IMO misidentifies the problem as having to do with the number of
ports rather than the port type. Because of this, a largely similar
issue introduced by the same blamed commit but in XRS700X is left
unaddressed and unidentified (the fixed ports check which is already
present masks the fact that it's not really about the ports, but their
type, which must still be checked, otherwise the driver has no idea what
HSR wants from it).

