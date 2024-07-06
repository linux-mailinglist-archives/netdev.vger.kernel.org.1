Return-Path: <netdev+bounces-109600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E51929098
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 05:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA01B21CFA
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 03:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA71E552;
	Sat,  6 Jul 2024 03:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="lXRx5bHD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF454C7C
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720237760; cv=none; b=Qmo2fMh0NZvBJ1wsRIYMDcmVowq6AfYFi5d+weAiPLWBybFppHj2qmDs+3ZVITPe4qXiLZM0Uwjxlj0KKgz/wpskDvwC8gA22gFAWkloYsfziFForsUiMnd/cqD65TvM5STRhTUy9ChF9eMJTLFO6gwwhUim5yMc2pgAHFvRVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720237760; c=relaxed/simple;
	bh=Td3ciUT/XyAi2M1puJRtzByKWLl3qhelQxxg+L6wW4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQwkpvCpY3hjdwzW/bK9DV+XqxdjpQm0kgInLs2HHE9ZFrz/ruqGRiRZvYQ9U1CZjx0aDpX80LYT4wHzL8zDzf8Sgc9yJKPlG8IAnx3/cr0am0t55yDQw0u8OhrKl5iPUiOlrj+p7JMk3IAHOC54R5w+y/Iu1n75n5nVaP1ToyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=lXRx5bHD; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-380eb36f5ceso9095535ab.0
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 20:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720237758; x=1720842558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnOTAnErmcA1qOpFILyzTLPVRfVLxD4gpoXVgZ59Snc=;
        b=lXRx5bHD2DPreMDGA4HHy9Ml2Ep5S6F5j71qjnrosQepM+Kta8rrhw5bv910RoUeLq
         ODpsBnLrQ97QXveB8+jRosABLGcnXIWqTEqvll9ijelGrkeRp7+BRxqOZ9q/4a5fyZ3g
         ea5VymVl7yLCRyYqlm4xRq3GY3jdgIGhfHuuI0EmcQsToPV8bq+ndudfgcbLjoKOMmog
         qg+wXfI60KFhCXmJU4Zxj4c+j5+jc+h4rS7JJ1TIrbLfQt9xDi8wt2VLkao1TdveyRhC
         FD/q7MVgORKJ3gqHmOfcpTnOl7r6fspKVDPb+z139aH9CaZDex694SehLf0R63ZxkWuR
         +9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720237758; x=1720842558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnOTAnErmcA1qOpFILyzTLPVRfVLxD4gpoXVgZ59Snc=;
        b=FuHo/ippQWFm0l2/K+O4ISY4dvgqyETGZKZViZp2KK/5/0jaCpk74K9jX4h9SwUNHb
         b02ZZoYcfmxYysLf5Lsf8FBMpqXnxyCa5xlLJ5OWek8UQJ2tBHiU+BNnszxN145gplme
         RrG96XPfRKlmi8I5ywv+uQssfxn+JNIFizILm/gEEhbWxvqd9xukruIaCBf1kAD+qV9K
         +ZnKXaEidNsC+q15QdwrOsi8UzoU9DBfyAiFJFZUP9ixNzoLLr40UuE4QSoxzZT4EHmS
         L6SSY+e4zPvb7zZHzeZne6xKW6u0Uycb5Ff/gMXFb6TqLOeffx0DZ9tDcVap6l5n+fEW
         3D3A==
X-Forwarded-Encrypted: i=1; AJvYcCUhEyHGK1or7xHeK7lNUpaLnz1T4dIDythz4RY8YkKJqAQYrUfJK87Dk1lPJiDqp0JZV1uOUo2LvukAUVG+5cfstPDsTwJL
X-Gm-Message-State: AOJu0Yx5VdJqDJDMPB0klewzuxRIFKSVp7nI/kRiKjUJdXGlPMrO6p/y
	oMc0fgkG/VaVGlCytDjWoqRiLUpUPD1hrwyNPnijxIlz2pE180xzLiz4BlH47h0=
X-Google-Smtp-Source: AGHT+IEJT8B3fp7ZbV3Cscazd5MmRHLxO+U0IJP191tISQn9KRLT/SXoY7slWuVukOvYMOuX6NcD3Q==
X-Received: by 2002:a05:6e02:1b01:b0:375:da94:e46b with SMTP id e9e14a558f8ab-38398430abcmr73667595ab.5.1720237758380;
        Fri, 05 Jul 2024 20:49:18 -0700 (PDT)
Received: from hermes.local ([84.39.151.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb3e542ce1sm31958695ad.153.2024.07.05.20.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:49:18 -0700 (PDT)
Date: Fri, 5 Jul 2024 20:49:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@kernel.org>
Cc: roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, liuhangbin@gmail.com, Tobias Waldekranz
 <tobias@waldekranz.com>
Subject: Re: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
Message-ID: <20240705204915.1e9333ae@hermes.local>
In-Reply-To: <d6e8ce6e-53f4-4f69-951e-e300477f1ebe@kernel.org>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
	<172020068352.8177.8028215256014256151.git-patchwork-notify@kernel.org>
	<d6e8ce6e-53f4-4f69-951e-e300477f1ebe@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jul 2024 18:53:47 -0600
David Ahern <dsahern@kernel.org> wrote:

> On 7/5/24 11:31 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> > 
> > This series was applied to iproute2/iproute2.git (main)
> > by Stephen Hemminger <stephen@networkplumber.org>:
> >   
> 
> Why was this merged to the main repro? As a new feature to iproute2 this
> should be committed to next and only put in main on the next dev cycle.

Because the kernel support was already added, I prefer to not force waiting
for code that is non-intrusive and kernel support is already present.

