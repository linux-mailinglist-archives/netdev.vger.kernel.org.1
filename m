Return-Path: <netdev+bounces-91683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36EC8B36DE
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 14:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC99B21F59
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC262145B04;
	Fri, 26 Apr 2024 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTIOmvUH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B49145B08
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133117; cv=none; b=I/+BlYNPXFJLPgKQDcumClhwU6V6tGWSSxcFiEL9bZcwX5w1/McB3eUeTrcWzcTeRHDGJfIyg/iJS+GCqr6T884+9H/k4hteV8VY2Aqaywo5c8Ojb9geouzHQ9QDf3PN6G4yFlGD/xgNfG5ZPpfuZAhEbBY9BjNbhsu2bBVV4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133117; c=relaxed/simple;
	bh=r1E79nEG2G0/aOYL7SjrP43Oau3fXMrL0uYYhXjNjkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxCkNDYpK8JjiDopSf/2S1GaLJbQqPjO37I963ZEmwv5fPAlcX0AWWW82R4iQa79C5Fle+6zrhnD6eoNm8RidOVU8P39teuK95sLvyJQPl8jSuFwitvERhd/Mi/VybuB1qzElAMXA+7s2PfFC1FO+GscaPS8mEAjzoPWu+8Mbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iTIOmvUH; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5aa362cc2ccso1307306eaf.3
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714133115; x=1714737915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r1E79nEG2G0/aOYL7SjrP43Oau3fXMrL0uYYhXjNjkE=;
        b=iTIOmvUHJwGmk0Z4Y67dF+vraktLEezx8e1tGLUDNgYP1TzGcnBrghKndnoXerwpyV
         lYhC4ewd6o/Yw/rlOgyrhuNHA53bGaHFoAw/QMB7jISgEqyYcBNeFyfdfKcwLttIM+q4
         EUZ/3YSvOWVJ0pVaahVWWvu8qJ32zxlJ4jJDKRFenMvJtuHWCv5/1/kejdjSkaQGvR40
         aR//dOCvs5pKfCMqDykmYoge7BPUtln0IdK7kPvz/a/CjqsltP0UE/1yorAwsQ+TNoKD
         oyKQnKFbTygXJxsEPtsONfMPatglVsfsiTUtkERUhxFrhhUcr8aYAk3YTZ2ivdIFH2QZ
         iRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714133115; x=1714737915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1E79nEG2G0/aOYL7SjrP43Oau3fXMrL0uYYhXjNjkE=;
        b=ZDZVM89iVz5bwdW6UQLtrR47OT8kGe3Q3cTjtGrTta6O26X7rGMxvt+2U9Q0qDZSW2
         LvPxHPkS0caRTIB3i/6Ir3JEogN3L8JweamJz2mast4Y1gF9kWTTafc+6EqxHkUzZ/0f
         1zqIe+kBTWi53KTqVGx56zqG+Y7+QQEbsTxVGCZlN729xOhfbfp7Nu4tveLz+8bJ11bY
         sGOv1nWt20T+0sYoBdtNKU8YbuP7wbtxoHG97upGZQpsRPr9vAY8o2HN13tfxBzhcOdU
         QfuUY0LkhIPA9epNyJAHCJmbVKwTUrLIsPQI2Tqyr9L41OrNy9TfDOC+iQYsSrRcA3iF
         5sgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP5u2j3avV0lqDyXLyliGibS/nVgmmZsT2DGnMeU0/eZ85LghvVIwFc5JRGznTa0TWBraXoh+/p8wF9vFGwwdBcSqqxWbA
X-Gm-Message-State: AOJu0YzNnbATRN3kEk41d/dvF5kehxPgSAcFDf9vDH8Xr81PgkPY+I8R
	hgiTmiBQqaynXJbhVSzvmI30XdweNOx175JUf5y9AWwkPjO6fWGyeL3bx5SqZnisBXPe8TgzdBy
	T8+8HhuuGPhDnBS57ID6MZtpRMrl344E9uX3WIg==
X-Google-Smtp-Source: AGHT+IGca8B9KX/Ii5lYQ3b9rLayT5KL2kDMlLOYI4c8cu6nOAGG3+yCexdUphLn8bJqAkemhCy6Xdc55amdXVXO+4M=
X-Received: by 2002:a4a:abc5:0:b0:5aa:4d23:9114 with SMTP id
 o5-20020a4aabc5000000b005aa4d239114mr3138536oon.3.1714133115172; Fri, 26 Apr
 2024 05:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426092444.825735-1-slark_xiao@163.com>
In-Reply-To: <20240426092444.825735-1-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Fri, 26 Apr 2024 14:04:39 +0200
Message-ID: <CAMZdPi-VNEUJK+AUcyCXii5in6OLfKjxrNM1KHwQf=9QV_cqJA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: wwan: Fix missing net device name for error
 message print
To: Slark Xiao <slark_xiao@163.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hariprasad Kelam <hkelam@marvell.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

On Fri, 26 Apr 2024 at 11:25, Slark Xiao <slark_xiao@163.com> wrote:
>
> In my local, I got an error print in dmesg like below:
> "sequence number glitch prev=487 curr=0"
> After checking, it belongs to mhi_wwan_mbim.c. Refer to the usage
> of this net_err_ratelimited() API in other files, I think we
> should add net device name print before message context.
>
> Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")

This is more a cosmetic change than a bugfix, you should target net-next IMO.
Also as said in another feedback, the commit message does not match the change,
since you're not printing the device name.

