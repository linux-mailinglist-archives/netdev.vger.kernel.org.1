Return-Path: <netdev+bounces-195105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E302ACDFEC
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090C1171739
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE984290BA5;
	Wed,  4 Jun 2025 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIj7V4Ul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391852900B7;
	Wed,  4 Jun 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046258; cv=none; b=ohsEZu9JkreNeQnRm+ocTKeowX+q6zUYbNqc5JsHQtT8n0Iy5mc1YU8L1/gJ2wPKxzFIG+NE5pwFJQ1LaoQwD+KZvb0Gd9E+xIbEZGsWdzaQz3S7JGFY3sDl+1y3CpBb6Hifo8Fo2cIaQdWSNPtuF3tm3PE3+SNjC6OvH66+His=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046258; c=relaxed/simple;
	bh=gb6i8ixhdEJTCsrYUor/DxYu+KnWObvlCHIlRhFnFY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOkHLa5YSyEcxI9KRmAqsJVA6FdtFx3QsiwsBFQ2E/hg0G2ryaVZddEPVBt0Pb9YtVXjd40C5q5XlsowqmkkUO7RqwKTsqydEt1vILqig4nhn/Ykec8jfAJ6NPEE/grhDUKQ7paASY6ex7BaSV9pQB644ZCMPFEMS3njGVixrtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIj7V4Ul; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-309fac646adso975937a91.1;
        Wed, 04 Jun 2025 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749046256; x=1749651056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gb6i8ixhdEJTCsrYUor/DxYu+KnWObvlCHIlRhFnFY8=;
        b=MIj7V4UlvgzIklIYTK7TvnQ5OkhxBjzOMoVmZDGHboTlqLlhXVnwsW+sYRs98yX07D
         1sceRB5S9FAMLj7KigRfc4Z8nfsAWJKFEKD8a8QOg54LUpspahRhj6BXS/iJW8+C6Ju+
         4m6lWw1Af0bsgGrGkDkWeMRW4ik/pJz9PU4eIPqVaOTJ9rMwdzFkcS1pf2MqVWVnaCn8
         hmCzOi6E4znpxV0dsfGh7yVzjQG39kgYbhx1icjOWD3fwsMcyDJKY6ixM9En3cTZZWZE
         A5T8YBJQ/+6+98tPWDfjoxGLuLDfekjL0nYzg0OnsnOIBb++C7lxSj2l6PPITAgL+rvA
         aOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749046256; x=1749651056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gb6i8ixhdEJTCsrYUor/DxYu+KnWObvlCHIlRhFnFY8=;
        b=cW2AOry4ywiPfkdnHEt18VGQQLAMM7vFh3pQQGEJwLhwKi0O5D2EgROqjkNt846+pz
         F2LHH01B8ZpVZsFXryQXUWzkjx9hTTVIcedGWnF+F6F8BHsC3vYmGAFhjZ3BHSdE0RhC
         9p3DG27+5e0N/LOiIkXeph1yrD9onNcZtQzsesPXLDUjqeFey4WhIYJKEzZz2J5S9A2F
         PhJVsttbFgp7Z6OSNlsSM9AF6jAI5VFGzYs0K31IXCJ/wxR+HqH+9s99R3TDq0EPEfEp
         9s9hT0wkSbq5fC392yRXryZLPeT5eJgaCe3G5j9otI9KaD3RFV6hNK082CjOvwtZ0ZLV
         X6ug==
X-Forwarded-Encrypted: i=1; AJvYcCV+fvq7BBoBVXNwEP6qtS8GwMirpd4IXu4eWKF+MPstK1TAXuYlB7qbU1qSe1MRMVqWAAr/OLch@vger.kernel.org, AJvYcCXnrP27Uvx5e8qblMcHVBbC5GvAY9cUIXF+LOeJpHK6O3IUMbsuL/IEWl7pqpG93waBI7sNJ6rCdz4YPtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy45yDVS1G5nSVgyucVgzdbubGr10D+QY7MhwGXyfALFJtlk8ac
	46f0kvdxMSLHUyPKwN8MPm8YdK3c/+3+SHDsCAYiAWzbNB5vWBpvYEVqEnu2kmc0W06nRh72z99
	wjuIOQ4NPUnHHhkoGtZFW57Y2QQ594Zs=
X-Gm-Gg: ASbGncupw03WzI7CdpENmpvmk1IHkRvAk1RuoZ48YmxCoq7NpFKpxyRq7XMdwMBXsLd
	05vfVPLKvEmMaqzBYnfWKra7hSL+UF7/AnzVJ0I7luyWPkrJ8sWnKVuTxH/8VbkWEZYNt3eb1tE
	YfNLUp9jmHP1ny0GFfMhKgscVLRMwvisXXlio=
X-Google-Smtp-Source: AGHT+IEGbimpeZ4Qs+yGgWh6cNi2oO72hjcngLwtcweFhvIvhJH7pUzxZ0sWe052vRx5DrKFRVhqTJGUJMiwZNAU7KE=
X-Received: by 2002:a17:90b:51c3:b0:2ff:556f:bf9 with SMTP id
 98e67ed59e1d1-3130da33e3bmr4158050a91.4.1749046256255; Wed, 04 Jun 2025
 07:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520160717.7350-1-aha310510@gmail.com> <20250522145037.4715a643@kernel.org>
 <CAO9qdTHuDb9Uqu3zqjnV6PdX9ExWv24Q9_JfQ8FbKigipDrN+Q@mail.gmail.com> <20250527104202.7fbb916c@kernel.org>
In-Reply-To: <20250527104202.7fbb916c@kernel.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 4 Jun 2025 23:10:59 +0900
X-Gm-Features: AX0GCFuxsnioAEkavhQj-4D8j5tuc9AFppLgy6Him-R1TfbjP66-gtiNDfEjve4
Message-ID: <CAO9qdTEjQ5414un7Yw604paECF=6etVKSDSnYmZzZ6Pg3LurXw@mail.gmail.com>
Subject: Re: [PATCH v2] ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()
To: Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, yangbo.lu@nxp.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 26 May 2025 20:00:53 +0900 Jeongjun Park wrote:
> > If you need to check n_vclocks when checking
> > whether ptp virtual clock is in use, it means that caller function has
> > already performed work related to n_vclocks, and in this case, it is
> > appropriate to perform n_vclocks check and n_vclocks_mux lock in caller
> > function.
>
> Can you be a little less abstract in this explanation, given that
> ptp_vclock_in_use() only has a handful of callers?
> For ptp_clock_freerun() do you mean the ->has_cycles check?

There are two main cases where we need to check if ptp vclock is in use:

1. Check if ptp clock shall be free running (ptp_clock_freerun)
2. Check if ptp clock can be unregistered (ptp_clock_unregister)

In the first case, If I'm not misreading the code, ptp_clock_freerun()
determines whether it can run based on the result of ptp_vclock_in_use()
if ptp->has_cycles is false.

However, ptp_clock_{set,adj}time() , which calls ptp_clock_freerun(),
does not use n_vclocks . Therefore, it would be more appropriate to
remove unnecessary lock and n_vclocks checks when calling these
functions, both to prevent false positives in lockdep and to reduce
performance overhead.

And in the second case as well, there is no need to check n_vclocks in
every caller function. Because n_vclocks itself is a concept added for
physical/virtual clocks conversion in ptp physical clock sysfs, functions
other than sysfs actually do not need to check n_vclocks. Moreover,
since ptp_clock_unregister() is called by many functions, locking
n_vclocks_mux and checking n_vclocks when called by a function that
does not use n_vclocks causes performance overhead.

Therefore, after reviewing from various aspects, I think that the
unnecessary n_vclocks check and n_vclocks_mux lock in ptp_vclock_in_use()
should be removed to prevent false lockdep detection and performance
overhead, and it is more appropriate to change the n_vclocks check to be
performed first in the function that actually uses n_vclocks.

