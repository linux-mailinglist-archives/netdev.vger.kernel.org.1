Return-Path: <netdev+bounces-150009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB51E9E8819
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 22:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1D31884775
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 21:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243614F12D;
	Sun,  8 Dec 2024 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZhXlTKF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782081DA23;
	Sun,  8 Dec 2024 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733693718; cv=none; b=qM8xScoAwKPEDwIeWdivtYAErt+gEG3vgF6uouV9enQQvqbsZz0nN/k3l5861dcag8KCe2YVgBbM0N8UziEw0oLxaYosa1uGa9PSKtrltxBTZa/wd/k+w/g13iwjKm1rEqzRsNgpuFe1MO1fitK+A+wRUfpJ3RD51ASMmo0DgjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733693718; c=relaxed/simple;
	bh=/kHw29dWI8Jh8neB8uAALi/SMJ13nsCSSY6PHsawVpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ud/zoBBKav6uCnE6gU3LyH36vVdJD0y6isHe1BQLFEH0jN47zil/BeSFr3HdEGK11p9ATbfwVUFTFO7hmeuYahwtS+d8a4CQb49+bp+iqEbpvCPqCexeU3u+sRpD1zjh4UQgtW3mVPT2Ap0WDgh9fRu+OoTAK+7D15vWjKK+ilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZhXlTKF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3863703258fso579821f8f.1;
        Sun, 08 Dec 2024 13:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733693715; x=1734298515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FT/XI9a4IlI8yhoJOXSguOkbtT9kvc9FGR93LWbKUw=;
        b=aZhXlTKF3HDr7xMKLg2fEyFWFrX4z+Sl4VVyE56Gcwu2LUFgqZyLxfkZNJ6DBp/LAe
         nnxiXNLS5ufCWgilDs6XwA5Jb4ioVfBovdJjTHjTT84dgd0DgbE61YrvgtnnXTHbjFui
         lA9KlfoY14W/avAhelAjO+m8tpJviguLO+uLFuRxhJCcWVP5nnbBWZRVro3yTmAyLSvE
         fzHOw24ocZFg3TABTAPH6AM/9af3qHTINCmsyc8LPsStD66AVtt1cECoqEGz81WPlgDK
         m7f8aK+X8txk38TzhWtZ+8vRrfvlDJjTUszZg7gMVLgEuzPyvm1QClf9b0zqRQh6Gd9c
         4UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733693715; x=1734298515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FT/XI9a4IlI8yhoJOXSguOkbtT9kvc9FGR93LWbKUw=;
        b=pl6yi7hWqetivI5VUV3pHbZxHX8yaBEsQOrBvBZM/xv5+5vS0YlA4/E+TV9YfFRayu
         /ucu9xm4s2IAyGX6XA0EgAQGOGxMgv7m1Im6hCHNfUTmUjWsbYhMvr9bcr+KXWyFktJ9
         Su7/7b+RaeuD3w2ITlHQOHYt5U1oznZ8pXvlu+Lfsf/UvkPC8vMSktfBsLekxD4RAtlz
         nQS4Km6h9S+Yx5cM/VODHyznOEH9yk8bn2CZvmJIIIC6Wwd3XjPfYGpHglY2A1oXmF6n
         dvj2vScrEVJUSKsDihzbNkKOzU8UzbRML1srvIhQFpW4GQ25ojupUloHBVSExfNluoah
         bPAw==
X-Forwarded-Encrypted: i=1; AJvYcCWckkuW0mwsDMD3yTTFi6HidFfYZ4q6JBTLChhJ/HD96abKxFZU1gmF1nYKowTkAOuFDbtPFh1b@vger.kernel.org, AJvYcCXbCJlh/Q4m1rDTB/qh5X1UexERpAdahyISHzCno7sCm6ccSTKPurjOnyOg/X4RQJw+EJSJeqv3xHyVKP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiRQD/g4Sdg5PUXbTE8fdTZufhgpB4QcBNd9YBFFxDnw/AAr0p
	rNzKx0ZeCMZOzl8cIToB/1cLq1TPp2Hgl62ep1HrGIMFzcbcXHgDAEsEiwIqZOI5qnUrl7HjuY2
	5d3WfpPi+QL/H1FS8Q6OleSKjemY=
X-Gm-Gg: ASbGncsSlbRDKjDDww9NHozEfYQguHIcwSFBwp1P4g4nFGIer/VGkAHDGeAtKJgTMaM
	T+rhLfwco+l3ltfBMKSIqTcKqpsWGpqd9aTUFhHyz+flQvKT1afOgYDSca6w35d67
X-Google-Smtp-Source: AGHT+IHwAMsuFqDrdyEJ/KJqrCevVJeBoHHGs8woXmM+cTs5EnO5j/yEIYm8u/K9wJdl+o8mXAyyiIFcxhMlc7tMy/4=
X-Received: by 2002:a05:6000:1565:b0:385:e95b:bb46 with SMTP id
 ffacd0b85a97d-3862a913e1bmr6301512f8f.22.1733693714512; Sun, 08 Dec 2024
 13:35:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206122533.3589947-1-linyunsheng@huawei.com>
In-Reply-To: <20241206122533.3589947-1-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 8 Dec 2024 13:34:38 -0800
Message-ID: <CAKgT0UeXcsB-HOyeA7kYKHmEUM+d_mbTQJRhXfaiFBg_HcWV0w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/10] Replace page_frag with page_frag_cache (Part-2)
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:32=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> This is part 2 of "Replace page_frag with page_frag_cache",
> which introduces the new API and replaces page_frag with
> page_frag_cache for sk_page_frag().
>
> The part 1 of "Replace page_frag with page_frag_cache" is in
> [1].
>
> After [2], there are still two implementations for page frag:
>
> 1. mm/page_alloc.c: net stack seems to be using it in the
>    rx part with 'struct page_frag_cache' and the main API
>    being page_frag_alloc_align().
> 2. net/core/sock.c: net stack seems to be using it in the
>    tx part with 'struct page_frag' and the main API being
>    skb_page_frag_refill().
>
> This patchset tries to unfiy the page frag implementation
> by replacing page_frag with page_frag_cache for sk_page_frag()
> first. net_high_order_alloc_disable_key for the implementation
> in net/core/sock.c doesn't seems matter that much now as pcp
> is also supported for high-order pages:
> commit 44042b449872 ("mm/page_alloc: allow high-order pages to
> be stored on the per-cpu lists")
>
> As the related change is mostly related to networking, so
> targeting the net-next. And will try to replace the rest
> of page_frag in the follow patchset.
>
> After this patchset:
> 1. Unify the page frag implementation by taking the best out of
>    two the existing implementations: we are able to save some space
>    for the 'page_frag_cache' API user, and avoid 'get_page()' for
>    the old 'page_frag' API user.
> 2. Future bugfix and performance can be done in one place, hence
>    improving maintainability of page_frag's implementation.
>
> Performance validation for part2:
> 1. Using micro-benchmark ko added in patch 1 to test aligned and
>    non-aligned API performance impact for the existing users, there
>    seems to be about 20% performance degradation for refactoring
>    page_frag to support the new API, which seems to nullify most of
>    the performance gain in [3] of part1.

So if I am understanding correctly then this is showing a 20%
performance degradation with this patchset. I would argue that it is
significant enough that it would be a blocking factor for this patch
set. I would suggest bisecting the patch set to identify where the
performance degradation has been added and see what we can do to
resolve it, and if nothing else document it in that patch so we can
identify the root cause for the slowdown.

> 2. Use the below netcat test case, there seems to be some minor
>    performance gain for replacing 'page_frag' with 'page_frag_cache'
>    using the new page_frag API after this patchset.
>    server: taskset -c 32 nc -l -k 1234 > /dev/null
>    client: perf stat -r 200 -- taskset -c 0 head -c 20G /dev/zero | tasks=
et -c 1 nc 127.0.0.1 1234

This test would barely touch the page pool. The fact is most of the
overhead for this would likely be things like TCP latency and data
copy much more than the page allocation. As such fluctuations here are
likely not related to your changes.

