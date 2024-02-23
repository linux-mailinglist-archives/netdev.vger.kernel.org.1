Return-Path: <netdev+bounces-74513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16989861A94
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 18:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAC7284D80
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAAB143C50;
	Fri, 23 Feb 2024 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PaqJkDVN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963CD143C40
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710539; cv=none; b=XhXSQmI6QVlekldaFTaLaVFWGB//19Z1Cqo6n38LuiqOdYnx0CiNiAdE6Cs8oZOnufav2U37qwAyUskk6wePsUN4A10taV4a/P9Mz687jdHrgVWYkzFKZS+UgbxWBA+bxCOTd3IQ3c9vMBYNqFx2VJ6V827FSGUtoY1BVXbHBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710539; c=relaxed/simple;
	bh=J9CJg+f2XESx0EE8EOWgy7TWOEQmNvNe7CTVEAvMpdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPCddVq3GEh5DYPeAQOmZ8I2sKaIiSElqQhlpPLIOhm4FQhKHTtERojsBm/PURR8R0Nr8Hr3QN5jtcYjprBGbSWSpIs4zhmjIfRgHJBkL9L1MT3yWJBnhxMATdTm3+5NEp7F3SKUOqV3/gWLZf+geD9Hsa2hAM1Xeg9e8l13nqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PaqJkDVN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-299354e5f01so444354a91.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708710537; x=1709315337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xniysJokrJSL4kA+7xMXMFdpfM5voHW8xKXFN/4z3Q=;
        b=PaqJkDVNUvhAcZHYjyaXXhlR47txCPW5nwh7UvN501VLusznbTi0vhhkvcVwVUe96y
         hF9onaV6DcaczNiwnv7KhPHQPymZZRCFIjHroVVHqbkLd0KJRfiRo+86fPpFhLQrtQZE
         gLAV3WtKX9IYx4fP7TZjdHyZMZ5ZsVGOH12c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710537; x=1709315337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xniysJokrJSL4kA+7xMXMFdpfM5voHW8xKXFN/4z3Q=;
        b=JFY0zGZ3rY80MErRw7RTe+ZnnJVZlI0jZWIMVezaPffEubi66ElGcnqAP0irJ1RiFl
         Q9dtTkS10K/QVBQ9gtg6KUOg6EnFahqBHsS7REk5v3SZi/tMDp7RctoC+HM5/0Oj37dP
         IFMfWUEB6ug/nZWtW2fhRFrdOqrKYKLZQf8M8+gDYVksB8GkDOolJ70WFCu6+dMSSXC1
         YMpzNXJodD78bj+4RxHIxhusHZFCNaJUfxPZ9RhNU/JPODtXINrmyYOZRNMTnr6+XGLZ
         qUUf9heDnnbBCXY4H9RqwrkeuNsBgDkst9QLQ2FRZG5g8qAhN5WeqF8dzv3Ajzk90umO
         W3lQ==
X-Gm-Message-State: AOJu0YwtHtjxpu9n5P8Yp5ZFdEfdwkkJ8WSvhA5+cnVUVmmys26lX4ox
	oQMkPkMBEz8VQGGajH/XgKw2JZPk+Wu8+UZ7lU7HlHLiScyIqz49fFK46qW4Fw==
X-Google-Smtp-Source: AGHT+IHPn7Lo2ZZEfv0egVA1U0588A9KlqO0T0qP4pZBiF5v6f+M7qkLa0yUFIE4yhmkeXZ+FjLDCg==
X-Received: by 2002:a17:90a:ad97:b0:299:41dd:95c0 with SMTP id s23-20020a17090aad9700b0029941dd95c0mr619373pjq.16.1708710536866;
        Fri, 23 Feb 2024 09:48:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090a72ce00b002961a383303sm1742861pjk.14.2024.02.23.09.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:48:56 -0800 (PST)
Date: Fri, 23 Feb 2024 09:48:55 -0800
From: Kees Cook <keescook@chromium.org>
To: shuah@kernel.org, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com,
	linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Subject: Re: [PATCH net-next v3 00/11] selftests: kselftest_harness: support
 using xfail
Message-ID: <202402230947.614061ABBB@keescook>
References: <20240220192235.2953484-1-kuba@kernel.org>
 <e0ce5ab05a0fc956ccde61686d7c6c90026e3909.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ce5ab05a0fc956ccde61686d7c6c90026e3909.camel@redhat.com>

On Wed, Feb 21, 2024 at 01:03:26PM +0100, Paolo Abeni wrote:
> On Tue, 2024-02-20 at 11:22 -0800, Jakub Kicinski wrote:
> > When running selftests for our subsystem in our CI we'd like all
> > tests to pass. Currently some tests use SKIP for cases they
> > expect to fail, because the kselftest_harness limits the return
> > codes to pass/fail/skip.
> > 
> > Clean up and support the use of the full range of ksft exit codes
> > under kselftest_harness.
> > 
> > Merge plan is to put it on top of -rc4 and merge into net-next.
> > That way others should be able to pull the patches without
> > any networking changes.
> > 
> > v2: https://lore.kernel.org/all/20240216002619.1999225-1-kuba@kernel.org/
> >  - fix alignment
> > follow up RFC: https://lore.kernel.org/all/20240216004122.2004689-1-kuba@kernel.org/
> > v1: https://lore.kernel.org/all/20240213154416.422739-1-kuba@kernel.org/
> 
> @Shuah: it's not clear to me if you prefer to take this series via the
> kselftests tree or we can take it via the net-next tree. Could you
> please advise?
> 
> thanks!
> 
> Paolo
> 
> p.s. if this was already clarified in the past, I'm sorry: I lost track
> of it.

Given the urgency for net-dev and the lack of conflicts with other
kselftest changes (AFAICT), I would assume it would be fine to carry
this in net-dev (especially since the merge window fast approaches).

Shuah, any objection?

-Kees

-- 
Kees Cook

