Return-Path: <netdev+bounces-80145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C5487D2D9
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 18:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CFA281D1D
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 17:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E198487AE;
	Fri, 15 Mar 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UoknpB3+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66314CDFB
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524040; cv=none; b=cIN01t4ngSzxSJ2+zufnJmey7gGCPj5nza0bX5T0TBdLy1hQ0fK/1Iu1SOszrZblJEclg0q69nGPJsgNWDmFEHVL5xXTnzVAg060gKesBaUo7bjKk0HJYd4HRRRhTyUevaI3D7btqXyclQpAWDDu0P8Kbbw3v+vqlvA/RzDwMKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524040; c=relaxed/simple;
	bh=zW1RW6GM8CBpvandVLUsZHvOh+bfZo24Q7rRlPrBWN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t93ZjL0niqzKkzmXweyjpBJzFlu5rdmgqJ5XYCMo8HvOCAYMNgsqF7T10A8MrZZgyWrB9fHz2i5NcPFNkJMJ42B2wIk/GY8dSWP6ymX8da3KhfX44Cv8sp9K3hNLo60S1PhYdTDEx3nKYbNZ5Z8+TtCUYQPUmPb4HOdSJkxJBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UoknpB3+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd62fa1f9so23591497b3.0
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710524038; x=1711128838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zW1RW6GM8CBpvandVLUsZHvOh+bfZo24Q7rRlPrBWN0=;
        b=UoknpB3+AMmuO7KAvTwvXNf3SzOtXF1VYlryO2UoVoPnW2tRn4AmLrryAlDXweS55t
         aS1Xx+0KEEFumqH0wHksJGvO0q4kDCjQdIocWwptOaYNHwF8viSz41XxGQ4Thwtnk1EO
         SJlpGYA2kOHjagZ2FB51o4UmwYn9ccegpYYIzps5+od4TKv/s8V9s9jzAgQXr4k9NIz+
         SJpqG6jB0VVMQ1laoTH7tCIl4B6B7TMym6aHQi/1wqMZRZ/vbqKSCPwgg8Iyj3kldt/q
         +OFbbQX1vy+vQGe8NnF4Mwe8OfglZ5zQznkjGlRBeR0cSl/yXrkHYQtp74OG35CatpJE
         haaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710524038; x=1711128838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zW1RW6GM8CBpvandVLUsZHvOh+bfZo24Q7rRlPrBWN0=;
        b=jxKDtnjm914cBeEGoJERQW2L+MXmN214LC/r6C9mc5WM33ZQFBUnUImiyYj5tXC82o
         HvLTYrFynQbZ4wZ8ctR0LjClflCPn6yOKOIWR4AGmvvxU/mcY9qbB5JDOCvxSVwlmWCH
         GaAG+Ud3S9m808dEFKG2GacYmqP9cHh5QLjndRBQwQ4Tw2nhzeuYwAZ13nN3nAdm6QyD
         rbRg/K3Qeb5eIfaDmLxd/JSTLRVQghqYfgyJXUmSyACRsVaOMZ7NGTYTdpJCo1DrAlfZ
         vIXG86oHEXMOZ6Qh1ddsA//DPsdD/yYXALVC7aG7pu9Ry7asYr+TUoqY0vS74xIBiUsN
         5T1A==
X-Forwarded-Encrypted: i=1; AJvYcCVcqID42xXxPw+SDTKyk7s84T2e8bdMXLaWcXY9oG87D80fZFZccy5MxmrRZKKohQMAN7rYgnu4RNZQGfEObI8rw1Za3gCG
X-Gm-Message-State: AOJu0YwtIRFi8Ry/b9BCDbtLUfPD94X7c5HN1rz+962voOlpvLP7ZYyZ
	TvLuxI5dY4vpc43zugLLzeV0RsXZZE4TiM7dJ9+kJlCIvVObH0lj5CleH0bIZ910ag==
X-Google-Smtp-Source: AGHT+IFxgCQ1Ymh7RTMQXWD/v9pxu5S2EZE0x98PfFjPfmNQVP1yNe7hV2Sl7mJynhtJKQYJ+k0nge0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:6dd4:0:b0:60a:562:d3b9 with SMTP id
 i203-20020a816dd4000000b0060a0562d3b9mr960614ywc.4.1710524037980; Fri, 15 Mar
 2024 10:33:57 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:33:56 -0700
In-Reply-To: <20240315140726.22291-2-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315140726.22291-1-tushar.vyavahare@intel.com> <20240315140726.22291-2-tushar.vyavahare@intel.com>
Message-ID: <ZfSGhI9hu_Yat9kI@google.com>
Subject: Re: [PATCH bpf-next 1/6] tools/include: add ethtool_ringparam
 definition to UAPI header
From: Stanislav Fomichev <sdf@google.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="utf-8"

On 03/15, Tushar Vyavahare wrote:
> Introduce the definition for ethtool_ringparam in the UAPI header located
> in the include directory. This is needed by the next patches as they run
> tests with various ring sizes.

Any reason not to 'cp {,tools/}include/uapi/linux/ethtool.h' instead?
Less divergence should be easier to support/understand.

