Return-Path: <netdev+bounces-79535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 176BB879D66
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DFA0B21F44
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F6114372B;
	Tue, 12 Mar 2024 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ZpwdpMAM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECBD13B2BF
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278665; cv=none; b=h4O2jEgBWlAx6aOSMZtjVJGHnHIpuEkIMYm44ywL3j4lz77RIbTYaWnvBn71J3CdEnej8S4JAdLeFPEL7IHbcc0NAwlCM7t/J74vokTe1BNMqtGdmGgt/WRxDDHup0cqMGx3pmKHwu8TnGpdFFtG1m7pg/u1ksXf3PIOkez5cIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278665; c=relaxed/simple;
	bh=jqRuHlvk8282jitSnT6zN3OaaQEXZ7K+lpFcLqhHJpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZlR3iIRKWjoaJ269F9R5VpLzvw+c8U3u0Mpkmf/4JsC0WluMlDYPhcRx+Bk//X3mu8wUfBuN0nllZcuzvRfXRUgIVpRsplyizlCUHF+wnO249sLunXg3663Innx+aC7CbCb9LVAYfNDfmr+UIvxx5WKNCooU7J3BAFO5brVTUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ZpwdpMAM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so212414b3a.1
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710278663; x=1710883463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFWJ9PtrzyIghWzMgQaovxj3t7pTObL0uEHzrgMizXk=;
        b=ZpwdpMAMtC27Cynmqug2SYT/51qMwSSlRUcwzh5hTk4qtBzos1Z+syOmgST9w3lgJk
         6j/qFe1KEKutFcQmd6AWgGtiLMXvQnorYsK8wCY+y5xp9dGm8g27dNwolYo3nk2LnwkV
         S+zVwy0SvgbQsxmwhlGZfWYBx7dhZ4RD1MbVoRmkdSEPtAGvXuUuHMZ5Gx8o2QvDFCLC
         9AVhjFEzIvuat1Zp9HTlvAeh1E9FsgWO5Z5QAuZ2Pp5ys3rt0uxzCOaOdRCGOqivnyAt
         t3aGfHje70gJZXWdXTMm/Pk5txbVfO1e/iXKXONrbcyaNG+6YJlXYAUKJyv0S0Ez8UyL
         6wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710278663; x=1710883463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFWJ9PtrzyIghWzMgQaovxj3t7pTObL0uEHzrgMizXk=;
        b=a63yWV9V9yNEmqvJgadaWu4ZlZ0fMOMXb6PtvOJQGdIB08VIoy8ZKShl7VzA/1XzVS
         ERy/sjvXNqJdVgbBFAX32ZdoOT3AGWfwj0OAF6oi7DbRd6AjXHlblkcLNBz01urhxmNX
         Zvc5sxlINZ1iiRM1a0EiejlrRF9Dk4XrfCpOUigvv93y5z7R4EG00YZzRe0K3mLtcxLS
         gOMCAkvH0XuzYVGrVS3GFDEgi7CjUEU8JiZojQlDZTvGQGmiINXsNbkXdD9OttuPAPtS
         Wg9JGoItXhOskmPobl4MNhmDSFTcAfEOTyvK7kU9R5SFeTr6oYJK1swkl1KQjjnTduTd
         e//Q==
X-Gm-Message-State: AOJu0YyEApm/LLV9XqugRNvo2PFaJ6n+8dXRywT+/ZVixd6DUMtTOWeh
	X+jkK4tFPSGxHofMBZRLeB8AJ2Z2FJjC27qk4eefZ0Zt7xuZzEvnCPZS6gETIy/2qKMR2S2pjOR
	w
X-Google-Smtp-Source: AGHT+IFkKeIc81XHNf75GS/Oe7ZgZFgDfPwpYb+faDqz32IFVvPtbmilTslB4PDXrAu4Ag58k5+6cA==
X-Received: by 2002:a05:6a00:22c2:b0:6e5:7ff:53ff with SMTP id f2-20020a056a0022c200b006e507ff53ffmr746456pfj.6.1710278662758;
        Tue, 12 Mar 2024 14:24:22 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ka22-20020a056a00939600b006e6795960d5sm6386853pfb.192.2024.03.12.14.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:24:22 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:24:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Max Gautier <mg@max.gautier.name>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] Makefile: use systemd-tmpfiles to create
 /var/lib/arpd
Message-ID: <20240312142420.53e35ab4@hermes.local>
In-Reply-To: <ZfAQvGTYe7eBcY3e@framework>
References: <20240311165803.62431-1-mg@max.gautier.name>
	<20240311124003.583053a6@hermes.local>
	<Ze-Fj2RwYnM0WgWi@framework>
	<20240311183007.4a119eeb@hermes.local>
	<ZfAQvGTYe7eBcY3e@framework>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 09:22:20 +0100
Max Gautier <mg@max.gautier.name> wrote:

> On Mon, Mar 11, 2024 at 06:30:07PM -0700, Stephen Hemminger wrote:
> > On Mon, 11 Mar 2024 23:28:31 +0100
> > Max Gautier <mg@max.gautier.name> wrote:
> >   
> > > On Mon, Mar 11, 2024 at 12:40:03PM -0700, Stephen Hemminger wrote:  
> > > > On Mon, 11 Mar 2024 17:57:27 +0100
> > > > Max Gautier <mg@max.gautier.name> wrote:
> > > >     
> > > > > Only apply on systemd systems (detected in the configure script).
> > > > > The motivation is to build distributions packages without /var to go
> > > > > towards stateless systems, see link below (TL;DR: provisionning anything
> > > > > outside of /usr on boot).
> > > > > 
> > > > > The feature flag can be overridden on make invocation:
> > > > > `make USE_TMPFILES_D=n DESTDIR=<install_loc> install`
> > > > > 
> > > > > Links: https://0pointer.net/blog/projects/stateless.html    
> > > > 
> > > > Why does arpd need such hand holding, it is rarely used, maybe should just not be built.    
> > > 
> > > The commit introducing the install of that directory is quite old  
> > 
> > The problem is that build environment != runtime environment for embedded systems.  
> 
> That's the same for anything detected by the configure script, right ?
> Hence the override capability.

Configure is mostly about what packages are missing from the build.
It would be better if arpd was just smarter about where to put its
file.

> 
> > But arpd really is legacy/dead/rotting code at this point.  
> 
> Yeah I can see that, not touched since 2016 (mostly). You would rather
> just drop it ?
> 


