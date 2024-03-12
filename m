Return-Path: <netdev+bounces-79571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD6879E58
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5551C220FF
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DE4143C55;
	Tue, 12 Mar 2024 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="uVj+TI6N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB07C0A3
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281963; cv=none; b=ZczX0Hc+FqKb//aJzyTDF8jovWa1ZBxmbqpXdYb68P1Qb5+6E4ZqEf+MqpPdI+bMoFnJq/lZpkQdIp5toRkz2bVGcPqLVWEtJhL8thfOHV1/DW/eSShkPh7Lgg88W0BaayVQ3iwxJMfxj47BrOlSJV7s3iVHrB0u5cUtGeMAUCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281963; c=relaxed/simple;
	bh=dDX3w6pevZ+N3rpwCrIQX5O+PUeVTrY+3VNSQVU0JPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e97y9CQrl2xxDnFZWR5TGFCVk5Jf753qAenxJhjJc7AtX70vL5rw+mBC/ZfWf6ei7md5gdp6EaniZieeOjWwd+WydPR+zjGAK2z/m7GCyazLqs0meULpxEkvM5r2FFnhLeLiBhQveAvhlNMY/ouRoVADV3Mq+g+ghvv45epqFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=uVj+TI6N; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dbd32cff0bso46324975ad.0
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710281961; x=1710886761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5mUIRBHiP/yCigb6pXOoWKfC710903ai8JtseKLsvs=;
        b=uVj+TI6NN8nfyM3Bj4uqjjbku9Lz7lz5dI2aW0LhCvemXbL1R2KInGb/66mOgO6oZn
         daX9Xzr+6TT0kV3PIrfbvxWWT6C2lk8CwMhvp7F1Iw0dwxkAib54RVNvQBYjUZKIMCH5
         RRrJTdmpe0KnXh+DMtMRF6HYYQug73wJKBy1uRkIF+H1Zp5l4pOvgDzV8wv8jjZ9hfpM
         lp+LvQIlZ+lA3PdkH6A3g6lPLEp96kEQgt+oVNno4d7rfwxlvOgI8+smHmVC+9mTP6Zl
         7fQK0n/r5insgW0esRUBLIu/29aNj1GGULKeQAV5iJG2x2nj+6Zii0A5RG3TGJ6BMvEU
         RBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281961; x=1710886761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5mUIRBHiP/yCigb6pXOoWKfC710903ai8JtseKLsvs=;
        b=c4ztx6StAMYbfiX3zafdJwAYYE+LCC5cYnso+hNpA6P3m0mjUH+OFvgngBk1tdRPNi
         03ncvdP4lhdMeSl6unCHg4Dwn2ml4mrH3cSgiPu+tTsZcc4oFx/98RNnER2kfvNj6Cq6
         XZEugjsjaovxqLO6of9rqT8p0Gzv0cV+DnJClP8zXAVQwowX5RjAExnjxrfIJEnhFC7r
         mNPuEIprC6RiTBB/zY/ayD3qochrQ3ne60jzN79URZN92Ofww79dOs9Oi8SUK/qedUEv
         m9AJwMuDQ0a1GIboyauKqXfAl0w9Y9JTK3jHCFCTeoZEWJ1/U3VeliDzjQjhcDltOWLL
         TItA==
X-Gm-Message-State: AOJu0Yz8KqK7YIn3ccQce+Pi1oj6O6MeKp9+X3Bpl+JmAt6WjMBvutoS
	gzQwFm7eqLg/VWsrainBx+3It5rbsU7zZcG4Fq0xM19gSGDxV1BXrfx9XrkJR4KlFjVLewnS60f
	z
X-Google-Smtp-Source: AGHT+IGq5kGeb1BTgJ+EtqPu2JBW/oFF+ZhLhYB+W/b52A5nxPpIR2TrGc8sSs+XkWHsJ513Tk0IxA==
X-Received: by 2002:a17:902:ec8b:b0:1dd:a314:7349 with SMTP id x11-20020a170902ec8b00b001dda3147349mr7601727plg.7.1710281961077;
        Tue, 12 Mar 2024 15:19:21 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b001d9eefef30csm7193578plg.6.2024.03.12.15.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:19:20 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:19:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Max Gautier <mg@max.gautier.name>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] Makefile: use systemd-tmpfiles to create
 /var/lib/arpd
Message-ID: <20240312151919.4725e1d5@hermes.local>
In-Reply-To: <ZfDKg3uKqy3T7BW5@framework>
References: <20240311165803.62431-1-mg@max.gautier.name>
	<20240311124003.583053a6@hermes.local>
	<Ze-Fj2RwYnM0WgWi@framework>
	<20240311183007.4a119eeb@hermes.local>
	<ZfAQvGTYe7eBcY3e@framework>
	<20240312142420.53e35ab4@hermes.local>
	<ZfDKg3uKqy3T7BW5@framework>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 22:34:59 +0100
Max Gautier <mg@max.gautier.name> wrote:

> On Tue, Mar 12, 2024 at 02:24:20PM -0700, Stephen Hemminger wrote:
> > On Tue, 12 Mar 2024 09:22:20 +0100
> > Max Gautier <mg@max.gautier.name> wrote:
> >   
> > > On Mon, Mar 11, 2024 at 06:30:07PM -0700, Stephen Hemminger wrote:  
> > > > On Mon, 11 Mar 2024 23:28:31 +0100
> > > > Max Gautier <mg@max.gautier.name> wrote:
> > > >     
> > > > > On Mon, Mar 11, 2024 at 12:40:03PM -0700, Stephen Hemminger wrote:    
> > > > > > On Mon, 11 Mar 2024 17:57:27 +0100
> > > > > > Max Gautier <mg@max.gautier.name> wrote:
> > > > > >       
> > > > > > > Only apply on systemd systems (detected in the configure script).
> > > > > > > The motivation is to build distributions packages without /var to go
> > > > > > > towards stateless systems, see link below (TL;DR: provisionning anything
> > > > > > > outside of /usr on boot).
> > > > > > > 
> > > > > > > The feature flag can be overridden on make invocation:
> > > > > > > `make USE_TMPFILES_D=n DESTDIR=<install_loc> install`
> > > > > > > 
> > > > > > > Links: https://0pointer.net/blog/projects/stateless.html      
> > > > > > 
> > > > > > Why does arpd need such hand holding, it is rarely used, maybe should just not be built.      
> > > > > 
> > > > > The commit introducing the install of that directory is quite old    
> > > > 
> > > > The problem is that build environment != runtime environment for embedded systems.    
> > > 
> > > That's the same for anything detected by the configure script, right ?
> > > Hence the override capability.  
> > 
> > Configure is mostly about what packages are missing from the build.
> > It would be better if arpd was just smarter about where to put its
> > file.  
> 
> What do you mean by smarter ? Trying to found an existing directory
> rather than a fixed one ?
> 

Isn't there some environment variable that systemd uses to tell a service
where to put its files? If that is present use that.



