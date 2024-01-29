Return-Path: <netdev+bounces-66770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BDB8409AA
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D191C23576
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFFE15350B;
	Mon, 29 Jan 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtI7OV3K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951CB1534F9
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541553; cv=none; b=mrU9gmHsLC09ixOItx+n0/3CTkCeH0SsulITmGRt2zJORcqJIAGcbw22nvnHy+sxa/t6UzLzNvfN4QRQiKtCzj9uAL1WRlAWpCM2B+Z+dh/R8aU5xAjoNQl1dzsTU1alIevwPT46XKTq03tpZaPEJT9wELe12DzyJPCHYSYpOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541553; c=relaxed/simple;
	bh=FHvl7OkjMdJ9ONk61j/M1LHWFH72kpB12mSVLjU0l0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTtHboSJhdTYWIDe79as5NG9stl5x1bZ4hbZ2QQheRM0CUwx7VQ7jtlwTCYRybfDvmYE/4/3sXcZhluPhKz/snP5F6BJqIkjoRXgSL+sjmn/zgl3B5UuUqanaX06BAbmMPZUpCG6LMM9c+7VMV71VQ3PJSAZcCDQLxvsM0m6RQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtI7OV3K; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf1524cb17so35065751fa.2
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 07:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706541549; x=1707146349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=11BFmQjC5NqBQHAKxyodJb3OBiyAzJ3FtSvWbAQgMbo=;
        b=ZtI7OV3KfcSgvlaXdWyxiM5CKyxMN2kpxLPsoaprPsqVhSow55p4LlITHYJk7qBWxg
         sVtm6wRpnFCLPDp/oOfmABYtdROvCFX2hCd9vWFckZAFA0v5ef1EsH5FnhAgfLLG4QVb
         1Chwj2unUaMz+p9fec5OkSTUCPmARmbaa4Typw1E7IyLMoWij/PbAjA2cmDnoml4s33U
         SX6nZ8AXm98GpdR+ePVQFzHgtC+BEEVuimldMQxvq+Om523y4c4YT6Wqhm79veg1hZJx
         yDQKYmMrJeS0E6SuUjaNwLfWfAU+bs3f5ktFOMbc5pOl32Vha970bPyBvLUvyLAlC+hn
         w5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541549; x=1707146349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11BFmQjC5NqBQHAKxyodJb3OBiyAzJ3FtSvWbAQgMbo=;
        b=VA2SILba2Af94gkxrNbL5I1ZJWdat9hAHLiXKZPKOEkmC1GqAvhlNkJLfBKdPkAdci
         RiTNmW8YfyRnuqSVuRqhDvtdEYlaIfrLVaIwsnwu55bHsbk/n+6BE0PBs9Tokdp/cRyg
         58uBX6+TTbm2u0Cvap3GADjeqBrHvq+8fRbiytce/gGYThyyB2cpmRR4W6amAoPLY+bd
         xncUpkCcmgvCqZUEAo7s3NjEzSP6kB3Dtn3zR75d2e4xKT/ZZNcNO84IQPrDhvi1ieHX
         GrTD5uLztSp+JlsWIN7XSEIMADxegLulV/cwdbbXCP2b07i1Am6PYQdnakvWLxCM1/6y
         slOg==
X-Gm-Message-State: AOJu0YxMzGI8GnKAafT5GcEX17Dq+SeRa5zLhdQjDogvij/lQIoy3bJY
	PCLJA2EOqSjvy5Dz5FGv9PQ3wJwRXRVbe0+EvVt1p+fCldwZdfT57mCj113HH0o=
X-Google-Smtp-Source: AGHT+IHg4MijYyqROkJU+ZQUlJHAR+uo/QDKqyeS2tFsaUOMGkD+0Oct+degBc2qBHyLHB3C07W5rg==
X-Received: by 2002:a2e:3819:0:b0:2cf:1b96:5af5 with SMTP id f25-20020a2e3819000000b002cf1b965af5mr3448982lja.17.1706541549382;
        Mon, 29 Jan 2024 07:19:09 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402195300b0055e96290001sm2944030edz.27.2024.01.29.07.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:19:09 -0800 (PST)
Date: Mon, 29 Jan 2024 17:19:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 09/11] net: dsa: realtek: migrate
 user_mii_bus setup to realtek-dsa
Message-ID: <20240129151906.a6oeyh7qyq7c3ow4@skbuf>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-10-luizluca@gmail.com>
 <20240125160511.pskpwroyrdmooxrg@skbuf>
 <CAJq09z5KJE1D=gCd5WX_B26FxYN_eGn7LwENwNQZ0BSe7aDwOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z5KJE1D=gCd5WX_B26FxYN_eGn7LwENwNQZ0BSe7aDwOA@mail.gmail.com>

On Sun, Jan 28, 2024 at 11:49:42PM -0300, Luiz Angelo Daros de Luca wrote:
> Using mii_bus will also prevent an easy way for the driver to query
> those registers (although not used anymore after ds_switch_ops
> .phy_read/write are gone)

Exactly, there is no other remaining call to priv->ops->phy_read() and
priv->ops->phy_write(), so their prototypes can be tailored such that
they need no extra adapter.

> I guess the best approach is to append something that identifies the
> other mdio bus, for example ":user_mii". The result is something like
> this:
> 
> mdio-bus:1d
> mdio-bus:1d:user_mii:00
> mdio-bus:1d:user_mii:01
> ...
> 
> Or, for SMI:
> 
> switch:user_mii:00
> switch:user_mii:01
> ...

This looks good.

> 
> It is good enough for me as these switches have only one MDIO bus.
> 
> We could also bring up some kind of a general suggestion for naming
> user_mii buses. In that case, we should be prepared for multiple mdio
> buses and the mdio node name+@unit (%pOFP) might be appropriate. We
> would get something like this:
> 
> mdio-bus:1d:mdio:00
> mdio-bus:1d:mdio:01
> 
> Or, for SMI:
> 
> switch:mdio:00
> switch:mdio:01
> 
> If there are multiple MDIO buses, it will be mdio@N (not tested).
> 
> mdio-bus:1d:mdio@0:00
> mdio-bus:1d:mdio@0:01
> ...
> mdio-bus:1d:mdio@1:00
> mdio-bus:1d:mdio@1:01
> ...

SJA1110 has 2 MDIO buses and they are named:

	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-base-tx",
		 dev_name(priv->ds->dev));
	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-base-t1",
		 dev_name(priv->ds->dev));

which I think is more descriptive, because in its case, the indices in
"mdio@0" and "mdio@1" are arbitrary numbers.

I don't think we'll find a way to unify the naming convention across the
board. Let's use dev_name(dev) + "-some-driver-specific-qualifier" here,
and hopefully also as a convention from now on.

> I also considered %pOFf but it gives a more verbose device name
> without adding too much useful information:
> 
> !ethernet@10100000!mdio-bus!switch1@29:00
> !ethernet@10100000!mdio-bus!switch1@29:01
> !ethernet@10100000!mdio-bus!switch1@29:02
> 
> And I'm reluctant to add those "!" as they may not play nice with some
> non-ideal scripts reading sysfs. I would, at least, replace them with
> ":" .

I'm also not in love with the exclamation marks that the sysfs code has
to use, to replace the forward slashes that can't be represented in the
filesystem.

