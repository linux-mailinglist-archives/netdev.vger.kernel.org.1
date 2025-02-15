Return-Path: <netdev+bounces-166653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3001FA36C67
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 08:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC7818955AC
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 07:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1E618A6C5;
	Sat, 15 Feb 2025 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6rh+JUf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6FD2FF;
	Sat, 15 Feb 2025 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739603642; cv=none; b=gbo89OXfcoE5zMnkVWTwON4uVC8doMhV2RYxJzvj3d98dNU+gY+4jn3stFKhK/0LHIJb0EE51ZPlg/WGvrb8VSNTr+v0K3wE+/aW0hwsziGtssH81Aqk99OBXz87zL7ocbrfI4/jW0/3VZWKPo0r3oHXRqgiYTuNvEcYBJ7jihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739603642; c=relaxed/simple;
	bh=hZGOYluwocYD344Hp0YtYOSiK125EZ0Y1lL4SI0ewxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIgrkCSXmIm7+AL509BLF5tNcEU6nZDLMy1gxo3s60vpzMn3JYUnHsQznMc5H45Q2COmUwKpulFCbrR5HfkTXeG/J9fn1b+DmaKcHOaGEMvMwB2bFYYR2MHCtT9EJXN9LhqCGsCnd8ablho1vb6YdXEM/axotvnh1fHBrFGXKJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6rh+JUf; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7e9254bb6so409494266b.1;
        Fri, 14 Feb 2025 23:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739603639; x=1740208439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PLCsXJvI2pTlMZ5YkAh+Q9HM6I6MXWV7qOEpj3EsXpc=;
        b=O6rh+JUfsByg0G/HSit9w/p0yqaUKp1ccMDuDX9v/GsQdzFRPHBNWxSOi+5pPlWErR
         qs8YV3So04uGVTD1rWPE6n5yL5mWa7TVtI5gEQJyLuAqqIOC/9jjPhzThdUc3MWhfmf2
         1h7fE4agQdZ/SM9fNPHQWSKH5e9Xlnh+RfjGQvdYFQ2ViHiD9WKISrLFDxv4QOiFz2/Z
         MMYP87yQzDZVw0f4xH5u1QpkmHOJ6O46VtyuFK8ZfaVwo0MMPlHfeZFEZqDTghCfBDd+
         37+ZTnt1BMI6kqYMPvGcjhXZqysZZ8U+cRYN7cMxV69E5xZw1FYpxLdFnGm19g2tpKzH
         B7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739603639; x=1740208439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLCsXJvI2pTlMZ5YkAh+Q9HM6I6MXWV7qOEpj3EsXpc=;
        b=Xazw9gFu1aOo45mIA3QVk8bHx6OGEdP7V0oSK6zmTvOkrSE7w7vkUt7GPnvesd1RFq
         dbiD4j0wHeFJfcKpGF2Bc571gSPx7yWR41cB0STiM/N7qWrnRtQ4ICk3wo94SNewBGq9
         OYtnoqO8IVwmMOZZ1z3nv5TZaSALYWwgbh3h5gOOAUrhmPfeNbFXd11VKN/lIj2iFYXh
         f9Ua/o0JTovyjOFMLZo+ixx8rDtC2Qx5Zvr8RlxsnPdXvY39Yui5Iev5qH6/NzbMQ8eT
         L7uNP+i61Sb7vG9RpIutCeEXg/ItrefShfx5gPz5aHZq6RgMSDkz4vzrwyBJb7eYkVZw
         QAuA==
X-Forwarded-Encrypted: i=1; AJvYcCVlnAc070Zwy4ZUypRs7XXcwL4iYyCrUcrVeORX+5rnKbE4tI/i/Y0MVlrWdMRE6p+6KkkWdTIr@vger.kernel.org, AJvYcCX4YbQpD1Btd+w8n3rajtxJFp8FbOmWWXGm4qSba64U5C4qNGXKUEWnOHzW/PQ+G687WwO7m6tD/fRXMYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/ZBlzKDUpKC7AiY9TFeFTU7/4+f3YbNukWLalX+IEY/PA47x
	GqFxgN/on+XsB+yoxoUMmmKd9ASLlZSFEkgm38F0yNrYS4OTUpX9
X-Gm-Gg: ASbGncu3X/9YiCUyWPJzw0TzKNT+oQrsDgYqJJ4xr4KwR7By/7zNrFbblLAXjeL9pXJ
	mD9+56+RJ+3MZYFK34hFL6B7ROf5mZwN5mbb56Bs0OGWf592Jw2L2zKwmB4XOXPw8MYeEOrhEbe
	m6O5tjumk7Qg7UKdGXkWx7cjlzjuO16D6vAhQENHGVQ0zI1gL+0vGaapz7omqUnqd5rOTeArO6a
	tDO7GHDSomAiBIhRzgUAANdec2F60chFVUK448oFl3kCyHCJDgPKs7VXtfFoR+kIsQH3igdvSv2
	tpGFGAFEMVib
X-Google-Smtp-Source: AGHT+IF2uRFcFBDrStq+y/ucMkc+CpORFtGKrLDH1I6w9WA5PS7WZV5TjfRaAZ9vCKnj/U+tMdOdzQ==
X-Received: by 2002:a17:907:2d28:b0:ab7:dec1:b34d with SMTP id a640c23a62f3a-abb70de3fb2mr168850366b.47.1739603638775;
        Fri, 14 Feb 2025 23:13:58 -0800 (PST)
Received: from debian ([2a00:79c0:62b:1200:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bdcf9sm475099566b.163.2025.02.14.23.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 23:13:57 -0800 (PST)
Date: Sat, 15 Feb 2025 08:13:53 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phy: marvell-88q2xxx: enable
 temperature sensor in mv88q2xxx_config_init
Message-ID: <20250215071353.GA5691@debian>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
 <20250214-marvell-88q2xxx-cleanup-v1-3-71d67c20f308@gmail.com>
 <a3a5bd94-5bb7-4c65-85b6-d7876dca74b8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a5bd94-5bb7-4c65-85b6-d7876dca74b8@lunn.ch>

Am Fri, Feb 14, 2025 at 07:06:22PM +0100 schrieb Andrew Lunn:
> On Fri, Feb 14, 2025 at 05:32:05PM +0100, Dimitri Fedrau wrote:
> > Temperature sensor gets enabled for 88Q222X devices in
> > mv88q222x_config_init. Move enabling to mv88q2xxx_config_init because
> > all 88Q2XXX devices support the temperature sensor.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> 
> The change itself looks fine:
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> but is the sensor actually usable if the PHY has not yet been
> configured?
>
No.

> Architecturally, it seems odd to register the HWMON in probe, and then
> enable it in config_init.

I think it makes sense to enable it in probe as well. I just moved it to
config_init because of the PHYs hard reset. Before
https://lore.kernel.org/netdev/20250118-marvell-88q2xxx-fix-hwmon-v2-1-402e62ba2dcb@gmail.com/
it was already done in mv88q2xxx_hwmon_probe. I will come up with a patch.

Best regards,
Dimitri Fedrau

