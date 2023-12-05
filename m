Return-Path: <netdev+bounces-53850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB8A804E10
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F521F20FC0
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA2B3FB01;
	Tue,  5 Dec 2023 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN82ohLR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAAEA9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 01:39:14 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9f751663bso31588171fa.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 01:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701769152; x=1702373952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtzpyzcVkuO9LwWE+PjYEaSMhazCYTfG2gax3rOjNdQ=;
        b=PN82ohLRjCfeh9wIzKkqrYx8morBBVuBq4E8/MkmC1M9vu7MR5UsepnWMEshR1Kz64
         aXNvJVbqJ+38Sd8lGjlpx+UIyuYqxImOFsxpUCP2RPnziigHn2Rx0+biYCRrBjS8IDck
         pbdEBKlT4dH/8cjltT3nfvrnd1Lvx3dhrP82IPr+CjsUR1sLzac89/8dHs1urJ1PADo3
         hCx4Lg72lF/ZkGbuZlT/ZRAZWndbpv3/eFiQMtuZX69b23PZxkcQy59OElrAK3GOSu1T
         h8GrjLdyUlFlugN9bhl5Wf5YTmUTE9d4gJJENYtd4YRD7AU+N8ZYXFoM/tPIzvMLLoob
         Z/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701769152; x=1702373952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtzpyzcVkuO9LwWE+PjYEaSMhazCYTfG2gax3rOjNdQ=;
        b=do7Ucc9rGeY5rKWcRvvapBXXfOdsynaYF9CJopC11PSbCj2Gt3MZiClN4Fp+xqOWY0
         U43FeeRrlHhDOHbVTDqEx0+oHJoGV0NWKAShVp2sermXg0bJvDwhfzWWJODrducPH4PC
         fevwmlEfvxyWjydn/Y/Eupm9cL/mmAnOlgBnO2dt9p607CceoWGcYdRK1+fL0meMoCnJ
         6DKshV/BSIhnKRH81Uefaz4Naq7WrhOgynKZkDTwjA6fIxGjcwU643xaHEq3VcQqwHbG
         oKU3qinh3A2a0wnPa1oMEm0vb9B11THzLNFKbL7diKr8DbDwy34eSyWT5PqIhUOaMkO5
         5YsA==
X-Gm-Message-State: AOJu0YzbO7XtY+TK7lakC3Bg6GLqJD+puqhZB79OsydA9dvoWxbRL38D
	UO2deYdrvMhXT0N+gMVgdh4=
X-Google-Smtp-Source: AGHT+IFJPg0sKIxF4bz9jeMEPTkTFrKHzfUXMG4lAod6JT33aUGWQjBapx0E6AZ35Zjw1RrN7ebKfQ==
X-Received: by 2002:a2e:a311:0:b0:2c9:e7d5:b39a with SMTP id l17-20020a2ea311000000b002c9e7d5b39amr1191626lje.109.1701769152183;
        Tue, 05 Dec 2023 01:39:12 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id u19-20020a170906409300b00a19b7362dcfsm5346949ejj.139.2023.12.05.01.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:39:11 -0800 (PST)
Date: Tue, 5 Dec 2023 11:39:10 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Danzberger <dd@embedd.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
Message-ID: <20231205093910.avpu5udgsahsahoi@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
 <20231204174330.rjwxenuuxcimbzce@skbuf>
 <20231204154315.3906267-1-dd@embedd.com>
 <20231204174330.rjwxenuuxcimbzce@skbuf>
 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
 <20231205083646.h2tqkwourtdyzdee@skbuf>
 <b309ba69b9e97f8e681f814fda1bb069e11e367d.camel@embedd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b309ba69b9e97f8e681f814fda1bb069e11e367d.camel@embedd.com>

On Tue, Dec 05, 2023 at 10:08:39AM +0100, Daniel Danzberger wrote:
> That module is just a way to instantiate the switch on a piece of fixed custom hardware glued
> together on my desk. It's never meant to be upstream. I just posted it as an example on how the
> switch can be instantiated via 'i2c_new_client_device' instead of DTS.

You're free to use the code in whichever way you want. I was just pointing
out that non-mainline code gets no attention in terms of converting after
breaking changes in the API.

For the networking subsystem there are 2 git trees: net-next for new
features and net for bug fixes which get backported to stable kernels.
In Documentation/process/stable-kernel-rules.rst there are some guidelines
about what constitutes a bug, but my understanding of it is that if we
can't point to some mainline code that is broken, then it's not a bug
and the change goes to net-next (aka work pending for v6.8).

So ok, it's not mainline, perfectly fair, but I want to be clear about
the implication in terms of reduced level of effort in helping to
maintain such support.

Usually, patches are designated by the author in the email title as
"[PATCH net-next]" or "[PATCH net]", and to help the backport, one
should also add a Fixes: tag in case of a bug (search the git log for
examples). You didn't make your intent clear, so I suppose you don't
have a clear expectation of how the patch should be handled. The default
in this case is "net-next".

> The pointer is only copied around, but ksz_platform_data is never actually accessed in any
> meaningful way. The chip_id assigned from DTS or platform_data doesn't even seem to be respected
> anywhere in the decision making.

The one assigned from DTS gets respected in ksz_check_device_id(). If
different from the detected one, the driver fails to probe. Incidentally,
that's also the snag that you hit in your platform_data case.
of_device_get_match_data() doesn't work, so the driver isn't able to
compare the detected switch ID with a pre-established switch ID that it
expects.

Your patch implies it's ok to go along with whatever is detected, which
makes the code paths slightly different. If there is an early error in
the SPI/I2C bus communication, it will be detected for sure in the OF
case, but it might or might not get detected in the platform_data case.
It all depends on what we read and the branches that ksz_switch_detect()
takes.

> Right at 'ksz_switch_register', 'ksz_switch_detect' is called and overwrites 'dev->chip_id' with the
> id read from the hardware:
> 
> static int ksz_switch_detect(struct ksz_device *dev)
> {
> 	u8 id1, id2, id4;
> 	u16 id16;
> 	u32 id32;
> 	int ret;
> 
> 	/* read chip id */
> 	ret = ksz_read16(dev, REG_CHIP_ID0, &id16);
> 	if (ret)
> 		return ret;

Ok. It would be nice to remove the bogus and confusing handling of
struct ksz_platform_data. If someone who has the hardware to test and
make sure nothing breaks (aka you) could do it, it would be even better.

