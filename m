Return-Path: <netdev+bounces-97651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3958CC938
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 00:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5801C20882
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D812142E6A;
	Wed, 22 May 2024 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="U/Oja42c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CA87CF30
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418358; cv=none; b=Rwjg5jaS9zhePYKfMUDmNkGcvfyfsbvX7q5aniwnzvsozriuL9stCuRMq14FSzJ2NuDOXITtZXsw+7ICUuCBSUCAWyQCFt2l2fOtM+xAe+Erk9ftBxX1+i/UJ3jWIJdsvbyEL9e70d6jfTXXl+hL5ZrEQYo9srttr8m1lrhHKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418358; c=relaxed/simple;
	bh=cFRdLFaevS9bWalRikXd1eyGXzkLJC9PISdDtQe+jGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SF1MWe6hzDRAkiyAgMij/ZBLai1ke/ExOZvIRRQADmD2Nifh8GFRa8uyrm0A0+h1WvJnKmuGHhhKg5kfdrGqZRSX8qQtPGD4h/GYUCriEooQMKeuDLdzMQnMN0dF/U4dyjx13r5iZAdSO4ygh6fQGFloWZKsaaiyDzke2vTiUpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=U/Oja42c; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2bd92557274so1481375a91.0
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1716418356; x=1717023156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFRFoJEqCNrI2NLCGghOrh61xUcnB+0q0h1GFTb+6k8=;
        b=U/Oja42c9AQD0/IRO1iySd9bYuZVp9HIsyk/jEakw/cu1rpAucpByfHn3IcChdWoru
         exOd97UJyCORvRM8MJzU0rFSTwrsi23x3MeM1M7CNvk1Jfis7FfH07RByxiOiZc8oZmK
         f8W/tSGbGq7YD3lik7o/gT0tuajptMWgG/BWfD0go2JHRVbyVrbqO4ZhnvguDjcKnspA
         Wq2/V/kGu17DkKetCaSkEGa2RtSD/zNjfAg1oGfgMBXdaLfY95qfpMAsqKZalHt/IH7/
         XomDBOzUnKbFJuDpNXcd/NLOGse0HHEbhdN0dhXZDnV1Dzg8bTVE8lqMGXbwtyY65d//
         Zraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716418356; x=1717023156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFRFoJEqCNrI2NLCGghOrh61xUcnB+0q0h1GFTb+6k8=;
        b=BBMjrhnpzrlUV//XhB9Oil9Iay1rjeXIqB5GXY5JgwilmQds3qvB4XBzs6LnUG1BaZ
         Nu/axWt5oxMCe3liYeu6HuyT/GZdk7r1J0+PkxlaFGs8WwI84FlqHcrODGIAgsOrsCiY
         BTjyfFZqE/5sYchePMYbDGMtM9WilBaQaiSNlWwz4m7sDmsXxYudqUQkz6eBJc/Gek3Z
         hpvj24qTi8qfl5kKtIyAF+/6EAXNGW4MSsVFZkGbD0Go3syishBEf9498YUlm0KwP/8b
         I8DNTpb+dX9xcpZNf00WRT4EqBsatZc++swaVachbEXHOMNs0HQFrH500+t/GQ8nhY7U
         IHWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIzk5WDCUw9Dy8d+//f0apiIp5UIpWfpyMa3An/Kmz5J8Xks4hKgfVU5Mh8gQSfHvW3s2FME7K7pPiQLthK/aq28aBVzOg
X-Gm-Message-State: AOJu0YzZjUCNRSjFOwPBZesbELeujz/q+izZ4AMWBWkcRU2ShRoN8iIr
	x1OyqwtgugOKsrj2trUjVhgUte4LoL4Gax3v7ScrNXSl2bVNVYL127KJh+CdQN98XDE00sBquMF
	Mv1w=
X-Google-Smtp-Source: AGHT+IHaBGSyUJWb0z2FAPWz0FumA89cP5OYV7yWE/mJJ29/1j6SSyuLxcSe1jntcNExRuy1LFBYPg==
X-Received: by 2002:a17:90b:10e:b0:2b2:7e94:c62f with SMTP id 98e67ed59e1d1-2bd9f479dc8mr3685221a91.15.1716418355559;
        Wed, 22 May 2024 15:52:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9f1b10csm301770a91.39.2024.05.22.15.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 15:52:35 -0700 (PDT)
Date: Wed, 22 May 2024 15:52:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gedalya <gedalya@gedalya.net>
Cc: Dragan Simic <dsimic@manjaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] [resend] color: default to dark background
Message-ID: <20240522155234.6180d92d@hermes.local>
In-Reply-To: <5b8dfe40-e72e-4310-85b5-aa607bad1638@gedalya.net>
References: <E1s9rpA-00000006Jy7-18Q5@ws2.gedalya.net>
	<20240522135721.7da9b30c@hermes.local>
	<67841f35-a2bb-49a5-becd-db2defe4e4fa@gedalya.net>
	<2866a9935b3fa3eafe51625b5bdfaa30@manjaro.org>
	<20240522143354.0214e054@hermes.local>
	<5b8dfe40-e72e-4310-85b5-aa607bad1638@gedalya.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 06:11:56 +0800
Gedalya <gedalya@gedalya.net> wrote:

> On 5/23/24 5:33 AM, Stephen Hemminger wrote:
> > The color handling of iproute2 was inherited from other utilities such as vim.
> > There doesn't appear to be any library or standardization, all this ad-hoc.  
> 
> Looking at the vim code, and playing around with the program, I have a few observations.
> 
> The snippet you quoted isn't doing anything brilliant. It just assumes that certain types of terminals are dark, regardless of the implementation and configuration. All you can really say is that terminals are often dark which is what I was saying here in the first place.
> 
> I'm not seeing any justification for assuming dark in certain cases and light otherwise. The code just happens to be that way.
> 
> More importantly, vim does happen to actually work. So far I was only able to get it to show dark blue on a black background by setting TERM=ansi.
> 
> The results are what is important. Vim has its own various color palettes and it's a curses app, its support for terminals is much more complex than just two palettes. One way or another, we need to fix this, probably not by linking against ncurses, and "assuming terminal backgrounds are light" isn't the nugget of wisdom vim has to offer.
> 

Overall, I am concerned that changing this will upset existing users.
Not that it is impossible, just need more consensus and testing.

