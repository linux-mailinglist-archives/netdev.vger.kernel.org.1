Return-Path: <netdev+bounces-105947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D78A913CE3
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 18:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE00C281611
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA2B18306F;
	Sun, 23 Jun 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gqu+qL/Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C891822D4
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719161519; cv=none; b=ct7OJMjP7rlX4YTBo8Vo7tDkYq0h9lh4xzKbIEVC2MSgX8IB1Eys6qAEufI0ejmyeWQSSkbVnmcQKrRII1icnZ6DaHA64Q0AzpOexB7EAWN1l7pwZzKh452D9CC7ryl22AiUhwcnvthUjZ+qh3TlM79xOzByXdEcru+MjHj+74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719161519; c=relaxed/simple;
	bh=NZQyaZf7FOnKMjA4vLphHGmCC8OBy/rwt7kqfFcNkaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCNLn8P/hzvNlTULa9R1zTvpiKYycYOrMHSZ6OFCvj2+mJWBKNLFOlfk5JDJPeOeKqYt2iH4J/2aaHXLfjhPadRKGtybz0bfeIIA9LGMzpUUOAPlUZs3QERjdaWz8EFJcPu3KbON1B0iVRrQ/y1LKxpgNu76laHNW155fXp3+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gqu+qL/Z; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ce6c93103so154449e87.3
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719161515; x=1719766315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JZK30fVnygMHCN0lsNw1v+SdKhqY12DdFDA/r56Sx/E=;
        b=gqu+qL/ZNWXS7B3rbRsGaz3CHTpPWfBcS/BNBaNskJwkJIRUsyrXGkRDX+gzl1N0HD
         8BAO4vOHWkZrirVQI6cxslHUEphnJ07yAP6Qpo6Tvl4nl4NzPrqWbL9Qc/hYXfP6kelN
         GclcE45np3k2e1gFfvnv9hPTHMvgD6Jl6wcIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719161515; x=1719766315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZK30fVnygMHCN0lsNw1v+SdKhqY12DdFDA/r56Sx/E=;
        b=A2g6UY9+Yrjgmw4JLS83PEWC/EDwPCKGGqgcn3Dj5fM/lxpZ9Lfc8U2LFl4wYN9rA4
         QVAFUZMWqjmt5gtkbKTUBKAFUjF45TsclhKkKKn9G1hVrCl5ol8/CU8p8VPOpFsYBIRb
         HSL7Sli3zq9d1hQJBlwhIk9RSpg6e0L8Li7EFUhxuLdqT0wGAXDp3xsekXrpLS+HQqIC
         f9AuAKDZiKSAC4klouBK1XgyDPnqL/Bx4pSz6nHsZR+2fWccXwnrrtrHq3coyJszCzID
         2XyLNS93naBX0jyQaGztrAdUuDFud9FjyiJxsDJlEREr0FWTXTA056W9GV+B2l5rxuSL
         mEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvF+PCeSZGn6TWLXMbYAa2HxOuBLplUgJVMBDmd91EwWecL6lr1nTUfsM3T3JvQ8Lfg1+6pML06vJ4GVpvSujQjx6/xOHI
X-Gm-Message-State: AOJu0Yzf3hk8mc6RRQ+qvjISFvpLANdQnYcYPgzpelv43tyxnNoJ2DoS
	8eCGm99X1D8piU5nh7Qq8ebkReRcrwMolPmyJwVMwu/KoP3IiWqll/J7umX+XAZUF5uja2exR5h
	I+rHqnw==
X-Google-Smtp-Source: AGHT+IFKlXpBaM3Gu4AENvNCx+oO/5TF52+t9XJqBtDkJea6hzA1ZM3GwPuJyDuopY6RnVyM7o8rwA==
X-Received: by 2002:a05:6512:745:b0:52c:8b69:e039 with SMTP id 2adb3069b0e04-52ce182bd0amr1677316e87.4.1719161515327;
        Sun, 23 Jun 2024 09:51:55 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72546ac874sm21970366b.103.2024.06.23.09.51.54
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 09:51:54 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a725041ad74so17741166b.3
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 09:51:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4o/mrbnmovqWk2wLdP/ku0RClurogaGYpCdjYgqkFhciSOAkC0peu5RnKQbZIde2pxhRKqZwcPBkkSsphC61YMSVLBxIq
X-Received: by 2002:aa7:da99:0:b0:57d:5d68:718 with SMTP id
 4fb4d7f45d1cf-57d5d6807b3mr89557a12.41.1719161513740; Sun, 23 Jun 2024
 09:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620181736.1270455-1-yabinc@google.com> <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
 <ZnVe5JBIBGoOrk5w@gondor.apana.org.au>
In-Reply-To: <ZnVe5JBIBGoOrk5w@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Jun 2024 12:51:37 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgubtUrE=YcvHvRkUX7ii8QHPNCJ_0Gc+3tQOw+rL1DSg@mail.gmail.com>
Message-ID: <CAHk-=wgubtUrE=YcvHvRkUX7ii8QHPNCJ_0Gc+3tQOw+rL1DSg@mail.gmail.com>
Subject: Re: [PATCH] Fix initializing a static union variable
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Yabin Cui <yabinc@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 07:07, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Jun 20, 2024 at 12:31:46PM -0700, Nick Desaulniers wrote:
> >
> > Can you also please (find or) file a bug against clang about this? A
> > compiler diagnostic would be very very helpful here, since `= {};` is
> > such a common idiom.
>
> This idiom is used throughout the kernel.  If we decide that it
> isn't safe to use then we should change the kernel as a whole rather
> than the one spot that happens to have been identified.

Again - the commit message and the whole discussion about the C23
standard is actively misleading, as shown byu this whole thread.

The bug IS NOT ABOUT THE EMPTY INITIALIZER.

The exact same problem happens with "{ 0 }" as happens with "{ }".

The bug is literally that some versions of clang seem to implement
BBOTH of these as "initialize the first member of the union", which
then means that if the first member isn't the largest member, the rest
of the union is entirely undefined.

And by "undefined" I don't mean in the "C standard sense". It may be
that *too* in some versions of the C standards, but that's not really
the issue any more.

In the kernel, we do expect initializers that always initialize the
whole variable fully.

We have actively moved away from doing manual variable initialization
because they've generated both worse code and sometimes triggered
other problems. See for example 390001d648ff ("drm/i915/mtl: avoid
stringop-overflow warning"), but also things like 75dc03453122 ("xfs:
fix xfs_btree_query_range callers to initialize btree rec fully") or
e3a69496a1cd ("media: Prefer designated initializers over memset for
subdev pad ops")

In other words, in the kernel we simply depend on initializers working
reliably and fully. Partly because we've literally been told by
compiler people that that is what we should do.

So no, this is not about empty initializers. And this is not about
some C standard verbiage.

This is literally about "the linux kernel expects initializers to
FULLY initialize variables". Padding, other union members, you name
it.

If clang doesn't do that, then clang is buggy as far as the kernel is
concerned, and no amount of standards reading is relevant.

And in particular, no amount of "but empty initializer" is relevant.

I *hope* this is some unreleased clang version that has this bug.
Because at least the clang version I have access to (clang 17.0.6)
does not seem to exhibit this issue.

              Linus

