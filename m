Return-Path: <netdev+bounces-92092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA598B55A4
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B1EB20D47
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320613715E;
	Mon, 29 Apr 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="HF/UUzj9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3645382
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387509; cv=none; b=fEzq0PY5oHAR3lk3ngSAeG/onWzcrzcKD9pLI0zXyz1GJjbJcnddonPeKGy+ldMpwKoVrxCPwaTLcw/NO6/VJOxbZY2E48zp+R/35irqJGmAI6bYF6mfashYDswSjzJdYdWYWqPU6RCI1nSXU1tkAfj46Kd6pGzowANGew4Ae38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387509; c=relaxed/simple;
	bh=21RMRAHr62HOzIUOgv3ewkW9+VGicSXGvye8BW7fsFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYcQ8bpfuFyvi+rp0TwwaDU5YwIEovbQqQoyB53Hnwj0wx6/tVuefgTRrXcaIDsItSckF8K/TA/xdHSjQ7EvPNSPf0dL1tqPojlEpVgG51ODdk7J/seyQXIlCxOspdeOcHF/i3wadZdTQ172upKSbCv8ePMQD4FJ5k/BDNNwXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=HF/UUzj9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d2600569so5129132e87.0
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714387506; x=1714992306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIf87VobpQBzjXayRCky+XzMmywWO3o9vJ/C9lYT1FU=;
        b=HF/UUzj9jQKszUJcR0Duu5ROyJKt8w6ns5XLn0oNpmiWN9MVNOv1ltC5hh8YT9NBtP
         rmn0TpGL1tmdj35hYby7+pD3YHZseO8RRsZBmGrYXVgb4AD3Qm4JgX3eyEcMrImsmgHC
         HgM8dBuEtu/MCGBBfTi/6TCf/XOb3pFxBLFP+t8p/NEeGYFURJDHXowrmO3/3M+dELRq
         qqRddpLk2QvrRjur/oWEWqZvLI+CHvC80kJtE7nLVdU9zyUP9OQB/yHlkPbEDStjShbl
         Cdi8hiunbd87DE1ul2wfN35uP4XuYs88ZwGCn38WyOG7+a/6HihlN4tJ0FSV9TS7BcGa
         PhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714387506; x=1714992306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIf87VobpQBzjXayRCky+XzMmywWO3o9vJ/C9lYT1FU=;
        b=Fe+7dxrCPfiseM30I0p0JRMTOgCVQoWwErnV7svZLyimCG1Q35cCGUVXYosFlzeEKt
         Shi8EAyD4Kxy9todXflNQUthr7jglB4GYxjEM7aGINsguQtOLkif2qGcINEugexvQ9tf
         s/7wvEWQHMqit2Pp0D7Yh61bN0Q0x/FXkMgAnZd2ceeL1+mUo3OoQMyQUz6FHY4XHh+9
         AfgzYeVOQOtcSw62wUUvMaTeGUpkCQI+Je56nl0qHY5Wa4yBzojzJM0SV2kp70WAqZOj
         Vr1XppKcCnAl9Cg5kWqQzaJbxf1dhzgnvnZnW+Ar2NL59kXvUxvoIzpuhfpJFwaGpT6N
         Q84g==
X-Forwarded-Encrypted: i=1; AJvYcCVefyG449KPGdF+77RYIxNqv5ry3FjbqjyEPlgTILXh1uO/e4Ns4bGqbkHF31jbWobDYl/9jb8pvcj2itZJPsARsTfbLYFy
X-Gm-Message-State: AOJu0YwAVR+LSm9VobH/WtpeSYWNKUptBtZ3i53iONDoDHvmLJ96jOYP
	O2D6vl9f6p+dkUwK05zeruLHJ4zsdZ0jQckOpcXe8NBhF3v2Y1iWur5atsGQKt8=
X-Google-Smtp-Source: AGHT+IHE9ANqur2+1+XKhc4MrtY/BD5yLizVMOaJPlYSALAtWsYgzCwhL67JKEMz5AyB9A979d3WUA==
X-Received: by 2002:ac2:5dce:0:b0:516:d3ba:5602 with SMTP id x14-20020ac25dce000000b00516d3ba5602mr4811351lfq.16.1714387505986;
        Mon, 29 Apr 2024 03:45:05 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id k8-20020a05651239c800b00517746176ebsm4055614lfu.49.2024.04.29.03.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:45:05 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:45:03 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Message-ID: <Zi96L3WDCwLz-2_O@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-10-Parthiban.Veerasooran@microchip.com>
 <Zi1Z5ggCqEArWNoh@builder>
 <b82a3006-05cb-43a3-bbe1-4f2f81113bab@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b82a3006-05cb-43a3-bbe1-4f2f81113bab@microchip.com>

> > To avoid an additional copy here?
> I think, this can be done later as part of optimization/improvements. 
> Let's keep it simple and optimize it later.

Sound good to me

R

