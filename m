Return-Path: <netdev+bounces-142327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E709BE475
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0DFB216B7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432A81DE2CC;
	Wed,  6 Nov 2024 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="W4p6HqXC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3A1DB92C
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889617; cv=none; b=HWg6pfMt3TDFnDKYIyT67Vl0idJjcPHm7mIjl/nMk6qNapRyQRfsSRCO8ll+79yErqEf3Oj96QB8RXnS3Q1tkjKhHZxYZTnTgRJJUOGeaA3++vaHZbvgLDYciMhZxq0/Yqs5eLVXZ0eDRK2YSjku4NyuNNZ9hqLMkzuiZ06LT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889617; c=relaxed/simple;
	bh=tTbFt1OcFliLbY0Bwwq1r+4g/zNSc71S6GCpL91PCFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEXYL6tWy264zo34X1W2FqsCZrKosIP1LM04EPwkLxKBZXOObni9UmG9ZlFPCHc86GYqUKYrQwRX05rs3APt5LFEDBeMPettxfQT1odr7++D8WndncacxG0tx8nuihjlRaaR1DZmKvszdY5TXIjiiP13l2al2/9psEWdFi/SoAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=W4p6HqXC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f72c913aso10464314e87.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 02:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730889614; x=1731494414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAr9vtNmZglsCE4Wbo3UI8jpsfHW8bkwEyn79fj22Ck=;
        b=W4p6HqXCeqIK0l0UDUq/m9iywjbChgTSmohRmtr4VMaPjNjStbHvazTrkXVLqIc2K2
         x/DacqyzrxbsKwGjVa/z+3XKSQYjbGBvFhLCbHtOxpUimA264ltZwsBa3VVK+lpjzDnc
         gjNMlU0UR8wFu+ri6tKPUlT6v1DOpfNb43T20IPUMb2ff5K14ul0ESsdUvjzUsfrAMTB
         FF3fYeUZZ13pb6mjOnaCOAXmoVsNds+jwpysigzfW1Z5H93q/51dIvk7UVe0sea3U5XV
         PP7vj9XH3epltYrpD/zX0Asl4EmGaD1mTS2mt9SBmi58EV3v5TudsABvZZd4+CHkggRe
         aSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889614; x=1731494414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAr9vtNmZglsCE4Wbo3UI8jpsfHW8bkwEyn79fj22Ck=;
        b=BB8FxvTEPbgrFrM58oEo6JhhPzAfZU+BoULPoy94iO72Btp/Ey67VjKHnXF2hOnYbK
         umF0PEiLuOX3W70LyW7AauQfESjIzDappnH2GQwt2UKvBytjWuI1HmE1nC825qlq4boP
         R33NiKmMfQhlfmF4Qgih+FdlUwWwFnBDhmFv8cb4lW2Qgouloqu7hTMNcOXDkSEG8/Af
         eBTKKO7boEjB5PyFtWQh4jGYL3oi06Iz43992rG837R4Z1eEymYfB9kGLmTasclFfUvQ
         efPFZnek7AKfCgCgtTQ49s5j1xLuFoozoJgQMsvIXGsE45u0nOYP4k+GIll7t3GXG7t3
         TVRA==
X-Forwarded-Encrypted: i=1; AJvYcCUP3hKRW/85qeX33DRjm8/fDeWiV39SIRTUbSGt/lLRzFR1tpWINWq81w05fQ2YSkIBIGG/EoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLAPmEop0p9zDRxXWCMHZe3BvQ5Uy0yNwbeNh3Ab49NKrF5WGZ
	RSc9vee9HF9IoHM1FC/JynEiV4Vr0/8lkOwj2cJZC1CncPskkj4S58rCBxedlMQ=
X-Google-Smtp-Source: AGHT+IHG5ZucvKvW/quOVquQY/hoZv+YWVqqYyz1AUNa2frkTsaCE+3o5nWJuMHNzV2cZ6wgHpRd/w==
X-Received: by 2002:a05:6512:ac5:b0:539:fda6:fa0a with SMTP id 2adb3069b0e04-53b348c382bmr19778686e87.9.1730889613582;
        Wed, 06 Nov 2024 02:40:13 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce373sm2479439e87.134.2024.11.06.02.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:40:13 -0800 (PST)
Date: Wed, 6 Nov 2024 12:40:11 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 6/7] rtnetlink: Convert RTM_NEWLINK to
 per-netns RTNL.
Message-ID: <ZytHi46t3kbDKUBK@penguin>
References: <20241106022432.13065-1-kuniyu@amazon.com>
 <20241106022432.13065-7-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106022432.13065-7-kuniyu@amazon.com>

On Tue, Nov 05, 2024 at 06:24:31PM -0800, Kuniyuki Iwashima wrote:
> Now, we are ready to convert rtnl_newlink() to per-netns RTNL;
> rtnl_link_ops is protected by SRCU and netns is prefetched in
> rtnl_newlink().
> 
> Let's register rtnl_newlink() with RTNL_FLAG_DOIT_PERNET and
> push RTNL down as rtnl_nets_lock().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
> v2: Remove __rtnl_unlock() dance in rtnl_newlink().
> ---
>  net/core/rtnetlink.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
 
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

