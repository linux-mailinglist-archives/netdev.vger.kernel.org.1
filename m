Return-Path: <netdev+bounces-99161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2086F8D3E26
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72057B26279
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4706B1A38F5;
	Wed, 29 May 2024 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="205YPd3w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF3447F7A
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006287; cv=none; b=h4nJW6aLSKiWdptvnlEAHSI8z4lEWXaTHpYeY3q0LfxmOyC/YSeu6qq2qg5Wg4XCL7ogNnDLqe5siN5wF5EarznDhTKDjP/2dha318IFDE8Tn7loSEsLmrf8qbBcQ+EMdxuCvssap5l2LeWuTP3t/g7FYDz1huGJjIPu2wtLz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006287; c=relaxed/simple;
	bh=+qENlzS+uKZu/DE90S37+bSKcPVKI5RM+p9Ueif/OGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHicpWMbEb6SoKZ1XDEex2xNdLgDoJmT8wZaptvJJHgTgSxFKvPCgyYCBm40Nvouzo4yEGeCIYgxU62TRRGrNg1yy67dt/JB7mVxDkVOiMLwDjRXCdGhsE3SlSvOUDSuplitVVGzOMJiD7pAioON0YgPOYqFdgtsV8843Zb+Lqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=205YPd3w; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f32448e8fbso300185ad.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1717006284; x=1717611084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1tmgbbVW6dBMh4b4Dr/IHkG1DsfDFnZhKbjKRbaO34=;
        b=205YPd3wpuQHjqEjk62Y8+C2310l3G43E/wn3sON8kvi1BpO87kFbPKeSrYQz1ovmT
         ozYwhN8E8CLtAbpJHxQwGHvXqJBsTHwogW2UtLj/UoTmpYVvH55pK9DVIvhwtpiMbEPy
         A3K9ZulBce8LpSZHorebipL+hNKv5GGoCpYXQCmiMgIj6TiW8kjeCa4A+xSrEw2Z0cbb
         UOCAf6NuB+V8yHVYs49akthHLbMDqCZDt+OS33rrwMN+37qipU01wdlUWvIi2ZKdM1Lv
         GQ+ydZkoD5WPq8VAI23tqJqyGJrGxB5ojR2/6ULfu2+IcuXfW5ASFIJeaiortK3CURee
         jUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717006284; x=1717611084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1tmgbbVW6dBMh4b4Dr/IHkG1DsfDFnZhKbjKRbaO34=;
        b=hNEPa3hZnG+f/LalvPp22UsxVgTUj7V6sbHKN13+pW2hoMk4/erXVBr7RfW0BpEBv0
         EEdXs5uOL7XA2Nbc47iaD4yCxPsQ+UzMEzi0tlf3kTYFTUtCv/djbCG1CPx1wlwoQAE5
         fd9nTLYGymoAZLGu46kuK02wlwrAEKnnIC9y3PLBjS9kdtRcnfKW3TZ50huKFdmqiuJO
         a1RFZXbxrf9O4Lr8WWmsZ+fXi/Iil8/ZdYOC21LJvVjzyjeY3F6J1SX0Q24Io61cBCbi
         r629v3tI3A2FNFpIwHFcG8A2PGahkRVqgRnsFT8copfw97kRIWktxvBPTAacKgpqTwlk
         uHow==
X-Forwarded-Encrypted: i=1; AJvYcCXQHlLdj2d4jR0125acAi/13qVt7J1nIZ1j5OnYlnaRE/HgLFRMNg02WCKAaPO2OuBKWliObhxOGw7qmCwdmd7rgmKttlTa
X-Gm-Message-State: AOJu0Yz+bwrr0p7C2MphPeZGQ33qkAmUv1/XygTziAB53nqRsSqXpZ5y
	D4JIUSprjGewg1eXvOEYE4Fhzm4fAwnpWUdvyZTCoHwdwNTZrLV0H6b0/aRZGo7ksW7r3l0NsXd
	4
X-Google-Smtp-Source: AGHT+IFoKwe5Y/4jWiAsaqXfQCIeSBkcvEeEdnbkkkJmugjs//itzjgGBHpGZ6em39SwAwVQ7p4iAQ==
X-Received: by 2002:a17:902:d4c8:b0:1f3:1e1e:cbaa with SMTP id d9443c01a7336-1f4486db822mr161392675ad.16.1717006284555;
        Wed, 29 May 2024 11:11:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f48d5c96b9sm67432845ad.85.2024.05.29.11.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 11:11:24 -0700 (PDT)
Date: Wed, 29 May 2024 11:11:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Gedalya <gedalya@gedalya.net>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3] iproute2: color: default to dark background
Message-ID: <20240529111122.7d384ed9@hermes.local>
In-Reply-To: <d8b4ae7b-4759-06d0-9624-7edb93caa09f@gmail.com>
References: <E1s9tE4-00000006L4I-46tH@ws2.gedalya.net>
	<f8dc2692-6a17-431c-95de-ed32c0b82d59@kernel.org>
	<27cd8235-ac98-46dc-bac8-3a72697281d5@gedalya.net>
	<d8b4ae7b-4759-06d0-9624-7edb93caa09f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 18:51:01 +0100
Edward Cree <ecree.xilinx@gmail.com> wrote:

> On 29/05/2024 17:36, Gedalya wrote:
> > That's not possible.  
> 
> Then in cases where the tool can't determine the answer, it
>  should not be using colour at all unless explicitly instructed
>  to do so, either on the command-line or in runtime
>  configuration like dotfiles, /etc, or envvars.
> "In the face of ambiguity, refuse the temptation to guess."[1]
> 
> > The fact remains that the code currently makes an
> > assumption and I don't see why it is better than
> > the other way around.  
> 
> Because changing it would break it for people for whom it
>  currently works.  That's a regression, and regressions are
>  worse than existing bugs, ceteris paribus.
> "Assess[ing] what is more common" won't change that.
> 
> -ed
> 
> [1]: https://peps.python.org/pep-0020/#the-zen-of-python
> 

Debian maintainer decided to enable color by changing source.
Therefore, they should carry whatever color fixups they want as well.

Upstream will stay as default no color.

