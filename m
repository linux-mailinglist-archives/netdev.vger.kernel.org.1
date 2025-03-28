Return-Path: <netdev+bounces-178130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9681A74D66
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1841899EED
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769911C84A9;
	Fri, 28 Mar 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJJ9tpZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11D1C5F29
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174438; cv=none; b=RySis3zzx7j8l5j8i32Xtr+GbKIp3Gkwiozz1pSngp9OeVYEEQkbA5sEJ8MnOXmRQafn8LgORSpWoEdqgUKWUAuo7KplSpuTxSWoZ4SwD/MOf/TEvmEyvOw38fqEUcqzK21hTxvQg8lh4VQ9u0ywwf3VkaB/PB7EY75OsKp9frA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174438; c=relaxed/simple;
	bh=bjg6F6yDZ6BrdBi8o776+9cALlJrYo3Msv+eIUVm1lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+naNlg8MFAS59Etb4zdoq5Y9SJPhiK9iBSOHa0c6Wkj7P3jFXBnXXLuQvsSanNpBFqGFa3xL36tPjeG4YEDOJkHQsXTKwamBNcTkZ7Xr2Hnqrypww7Jrkk1KGP7m3LjPXyTO2CGo+JsOQwGTayufLWNCfD5/DXNFoXk6eSDYW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJJ9tpZL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224171d6826so6241375ad.3
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743174435; x=1743779235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdhnyiJpTmcaAAdBhHeVd6mnElE1m+IPxlVkqYmezsk=;
        b=ZJJ9tpZLZ21SJly08C+siZLIVHtDGc56mL+Ub4hwf5dj7G3RBypcNkM5PbQs4/KUf8
         rsogxgnZ/0UtOYmYQ2MFqPOa8GAzN7V6//XYlcyv8ezvCy62qLHpsflWRO+aWk+AGPyA
         vMtEkXQkK4BpXQzQ+j1PeUzZjUVTARHI2q6KL3ScYJWooZnPMJl3hrMtoYB0jGDxMSX5
         day+t7VPEnAbLqNBaTlpxZWqmTGKTreCOL5rjBsiK0beo53BJAhymqxflXjI+YW7V6sL
         nHZmeMJItUIO2qtm9sby7QTl+RhFaKQMEXHaBUwbPxVIxCS3CU/jVkgCTyWSefegZJ5V
         DzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743174435; x=1743779235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdhnyiJpTmcaAAdBhHeVd6mnElE1m+IPxlVkqYmezsk=;
        b=nfD1ieNK1YonmRSsUJssjXKGqM9BnpkOpHUaAcnOmDB+iCyjRnJNIzQCoPqhIijinK
         SRAhq5JattFaETF9f3Woswbou2RSELT5P4YEad1udH6Wz6wm6NrK8nHRgWjBcUpwxVDz
         BBeS44etxmtRU+Hb88A9MtaY/JZTFca3K2DgwzaraSReYj3shhnYCSwPToaMeeqZYsJG
         6Cd4jcFhL8x5WO2tNuOwermUx2AwNSzhsYmyJw2BhlgiVMH1Z5bxMJ3+yEz/E2bc6frA
         nega2XjHrBVsNcUL25HYMWcYilTtUcsF9ZpqELAXKtRkXD5silBHN42JTPGrReM4GvLL
         va3g==
X-Forwarded-Encrypted: i=1; AJvYcCVAwWwf3XBZdlYszyRhbVapfof+8ACKzGpx/7Z75GCcs48mutp6w/ws/rfwSvDDBRJCqz5vkwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypMSKegt1DKqWLM9Fnboj/F5016X+NWjGb4ftFw1b2PDaQlt+p
	9ghHdhMJIhDAeH25AQWDCEODNjAeJU1MVZNd91D1jaZ0H54P8hPoWeXToPLRcw==
X-Gm-Gg: ASbGnctG7Li5adRUBiRwtA5CtKREVsLYwAQY2iQC77RmzU/trx7VF5QCHQzjDghp2zD
	UTC2kXEVcYfNLn4u0Zzisdn0lTAVCzHNurbmsHfcH/LWff2RaAGoONaeyZg8PlJtwCwRj0fgKTD
	UR4DGYeuATsKwbm/zkfXNEahpPGAYGQyqI3YBry6eIi7w2skaWba0EDoPyk5DxrPUZsJG/CJmJc
	rQTM/L6pdSAS/MVC8ckxknVTe2KSfBZWki/XL/HibjUc022o6fHU9SrVuVwU/ggS8CaWetxTBjv
	GkejYNFcJL8/hxZ4pSJ30GPk5dNz0swwt0eK7EDCnyRs
X-Google-Smtp-Source: AGHT+IHKuzZ75oh/Gb+WqzRGSBFmcysBvIX/cC1k0uKhfJNlFmgJ5VCccBOFMCck6WL6lOISEbo17A==
X-Received: by 2002:a17:902:ebc3:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-22804958326mr139960325ad.46.1743174435073;
        Fri, 28 Mar 2025 08:07:15 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eec7bf9sm19263255ad.20.2025.03.28.08.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:07:14 -0700 (PDT)
Date: Fri, 28 Mar 2025 08:07:13 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me
Subject: Re: [PATCH net v2 06/11] netdevsim: add dummy device notifiers
Message-ID: <Z-a7IYYTC_XEC8B6@mini-arch>
References: <20250327144609.647403fa@kernel.org>
 <20250328060450.45064-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250328060450.45064-1-kuniyu@amazon.com>

On 03/27, Kuniyuki Iwashima wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Thu, 27 Mar 2025 14:46:09 -0700
> > On Thu, 27 Mar 2025 14:04:06 -0700 Stanislav Fomichev wrote:
> > > > Can we register empty notifiers in nsim (just to make sure it has 
> > > > a callback) but do the validation in rtnl_net_debug.c
> > > > I guess we'd need to transform rtnl_net_debug.c a little,
> > > > make it less rtnl specific, compile under DEBUG_NET and ifdef
> > > > out the small rtnl parts?  
> > > 
> > > s/rtnl_net_debug.c/notifiers_debug.c/ + DEBUG_NET? Or I can keep the
> > > name and only do the DEBUG_NET part. 
> > 
> > I was thinking lock or locking as in net/core/lock_debug.c
> 
> Maybe lock.c (or netdev_lock.c like netdev_lock.h) and move all
> locking stuff (netdev_lock_type[], netdev_lock_pos(), etc) there
> later + ifdef where necessary ?

That might work as well, but will require move moving. Maybe I can
start with s/rtnl_net_debug.c/lock.c/ and the we can move the other
stuff separately?

