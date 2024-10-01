Return-Path: <netdev+bounces-130844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED83E98BBC3
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19AD1C221C5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560B2190679;
	Tue,  1 Oct 2024 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF0yTZ8Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00303209
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784302; cv=none; b=ldzoaMZFowwCTlu5sXH5boQWUI/NYzJuS7ZFJgsU5Wn/EsG3MvgV8QkpcFEydtiNbz0HMd7yqr9ap2OPqV4MTeYLM8OLlxuPEPsm7I+KGbDvqgL4OZgHebL1E1swdHaOuir6z7pAl7f3gghs/WPKhU6mpU31DF+SfD94Kh68A3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784302; c=relaxed/simple;
	bh=5I3uc2HxrSD+shdGlRdkwVoTYsdY9OdwijWp9sYXff8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G90DecRjt09LrWmcvnMRAqelbVfB4cFN1TtFqx0YEyzBNCtKgN9JDBcENIYhp5XijhKYAD9VbjHkKW2cOrreN2P9ctBepdM35f14FFZlXC0hBIHTqWMI814nWkzrFYF0XLAdj5M6efOZEuuGRWEb/qxmHOBNN4Y8DS6WxAwUDGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF0yTZ8Y; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a7dddd2bdso74039066b.2
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727784299; x=1728389099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tDUUkyiQMjP/XejllrxxlGweb7nNKtRz0Nucb6XdOXE=;
        b=nF0yTZ8Ye/nghOcQ2l7ivQCN7VLZO+B9hizVa+6Ex2DEV+YRzXszg9RAyAnmWsKhiH
         M2uoSX3qL4qqg29RKE2WLlHxgNSZDG4/vFbPSxZjybDjJNlBvmRtIpvrI1KpzlFblgd9
         tJO8IPbiPjzhjd3x365T/triKB2m80noA9mSx2Yvnsts8rOz32qxJEIqaQ5U7IaHPWUk
         NRxI5KFYjUjeBrivnBv3IlQTT/hmajv5lFzPTXiSERTgTt60QKdUwhdykXEUYurxXtMy
         XKCKyxjSDEvVbMm5JwUEVMRsa1qrSmEr6966et/ZZWj67704xktXXV1NIm5alFJGGSNN
         GC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727784299; x=1728389099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDUUkyiQMjP/XejllrxxlGweb7nNKtRz0Nucb6XdOXE=;
        b=EHoSKzti6bz32ejMSyPjktoN0UYl67gZTX+T1nsUk5OpD6tceypgR0tkC9Wt6Ah+Ss
         qC3inmZsWR+2DNRJMwlrrwOojViXq39uxSuvfTW+FQcOsvO7TZINveIXy6ApWrQvOW2m
         TlSH+lOQi67cEDX1md1MBNT9Bx0vM0nzFCWKlgTsC9167btks6bRWeyaQJoR5nWzl6do
         eL7d3bzAxTrqMsD0yEyWTlwOCW77eLgJVPdh2wGx68I0eNL8nI9YFfIICtU2Ah9JzYJV
         M1ehqwOkgAAWIOA9g9MRz4YIl8Uggb5EZ80Kt//ygJ6wOyau/6/3oUqfSDvhkH7n/Tdg
         S9pg==
X-Forwarded-Encrypted: i=1; AJvYcCVRv8RgXPoXnXuNEPg9ftVzIDsbZiCPng2nF7neoGnGZHTK3hT7SmthL+yjbtWSjTlva0oogFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPnGw0h2tuWUBC9HjZIUvH22L4t343GSNzbzCsdjTjRsGC2ky2
	P6vUQF0MyNta/w9MzaS3yyMxUXHVmnl4a/fAMYW19RNi9jfP0jW2
X-Google-Smtp-Source: AGHT+IEA3vfnyd3UYMG0BvM31Hsqqz97Eil6PWQFRWsWgOwj8jbTFx40WzbEolhud4Fc89BzV8JJaA==
X-Received: by 2002:a17:907:2d9e:b0:a80:ed7a:c114 with SMTP id a640c23a62f3a-a93d84ebc8cmr562010966b.0.1727784298639;
        Tue, 01 Oct 2024 05:04:58 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2998cb2sm699181466b.197.2024.10.01.05.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 05:04:58 -0700 (PDT)
Date: Tue, 1 Oct 2024 15:04:55 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"agust@denx.de" <agust@denx.de>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [PATCH net-next] net: dsa: lan9303: ensure chip reset and wait
 for READY status
Message-ID: <20241001120455.omvagohd25a5w6x4@skbuf>
References: <20241001090151.876200-1-alexander.sverdlin@siemens.com>
 <aafbddb5-c9d4-46b4-a5f2-0f56c58fc5df@microchip.com>
 <60008606d5b1f0d772aca19883c237a0c090e7d3.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60008606d5b1f0d772aca19883c237a0c090e7d3.camel@siemens.com>

On Tue, Oct 01, 2024 at 11:57:15AM +0000, Sverdlin, Alexander wrote:
> Hi Parthiban!
> 
> On Tue, 2024-10-01 at 11:30 +0000, Parthiban.Veerasooran@microchip.com wrote:
> > I think the subject line should have "net" tag instead of "net-next" as 
> > it is an update on the existing driver in the netdev source tree.
> > 
> > https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
> 
> I explicitly didn't target it for -stable because seems that nobody
> else is affected by this issue (or have their downstream workarounds).

Explain a bit more why nobody 'else' is affected by the issue, and why
you're not part of the 'else' people that would justify backporting to
stable?

