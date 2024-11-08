Return-Path: <netdev+bounces-143405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A339C24A3
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F621F2141F
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 18:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF68233D7F;
	Fri,  8 Nov 2024 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V569nbY8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE7233D64;
	Fri,  8 Nov 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089263; cv=none; b=Oh3Qr/MPIs9KBir/vKBGBib4FZUiar6UpiYREfkwk14pkFyPdHX7skkU3gMDngSLsysNAvtcEotqMfe/gTvUTURtdXWbjJ3OQln6UkteMyrE6UrRIwH4qTEZdmR/w9QfIWQwmvYTP6m9UxA7qMFZTxHvD7D4o7KkgQ3Xp4uC5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089263; c=relaxed/simple;
	bh=XdUEhrjiBr8GA3ZORbMFZtmKhtOKS6QBlaBZ1x6dEas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XifB42aaAtrm6j/W/InaDCRi9dPsFpfharYvd/5pBan4A2DgUuvplHlg4SCiws+VprAi4kmaDQPkyIIaDqvjEw75vjZuMMg5dXu0TowZe+frmZxX8BqxREtH1AzMYWsdoMp4G7p0Gue9f2PxwzwX9BNlV4bVNmW+qUDFZtscMxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V569nbY8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso2060714a91.3;
        Fri, 08 Nov 2024 10:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731089261; x=1731694061; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iWG253LXGIdckUNp7GPNkeMy7DZwES9JtBx+EINqA7g=;
        b=V569nbY8EBxvMxbptzSfzHOBoFQgYnV+fhz4b25K01KRLaC+n7MyyWAbq5OzISP6GL
         vfQb3hZ9EsmaxmSsLHF+CoD1/1b3dyvAdQmV5jnDqxgpbiyqsZCnX6LPv4hbQDOV+eAl
         oI0aMeMRz91jBdOn6HOIOINaTOpd9cWwJmc3yqcxr1rGWSanwldGWtCEcwJVBbGhulDr
         JQRr2IRrplZrTrlRXWW6vHa9cAmEMxbb2inmu3zA9E2l3Fnl1C55evbouglDK7zQFEJG
         AIqbqt2BGp3y6bJX30ltBnyihQIsb/BeMVpmP8JjXC0sYy/BtYxy1klHXBUEjyJ0HbNs
         JHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731089261; x=1731694061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWG253LXGIdckUNp7GPNkeMy7DZwES9JtBx+EINqA7g=;
        b=kb1Ft7PGvHo1HyVilyOnDNBKBJ2qT2Hsbuj1HSxD1Ad98Re9PvoGnn1F7badfO9hNv
         dSkfsIs0gajkGvCoXs7VlPN/hbxwceJ539sgnbZyp9mHLbOnvodCSJrLkiO1tonrP2SG
         SlDzsWvYm76+t+8r+yDoYYJfFWlpfwZFLQqzlZzrlBlaEYdjOCVyI/EqVQXJzq7grqi8
         1p1jAzj4m9xO3gPPrqd6oLQ908sQXcy/a52Hr26i9bDbND+UE7tdJnGJGiB2dIwKfVfh
         4OlinpQYlwmxBMlPwQWJxNp9X8+EULc2X32o4JXAgEpPZV+fCJRqFGjAx4EcOFHjEd/q
         M5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVNADDD/jBe4PcGBKPQYk4wnSggTIIvtIVvX1JX/Ud+dE/LwxtR812PfCLst6hjuwfXtPFZSNFO23AvLxVJ@vger.kernel.org, AJvYcCXuC6Gu/oF+xb1MDsvAOyIeIGm/VASEDjHhkyqLou+f4OW3YkyJ5FUWavrSPYkFNPQXVJ4fjXV3KaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmv4ZD9lq/ChRUjR8nIrba9J/hcnG9Gn7qs1bzn2+04DjaQI1
	l9R6SCcx1RFhb8dnHiSnkeHqSbcxSDF82nP0rgEJUd4XThxeieo=
X-Google-Smtp-Source: AGHT+IGciwzK4siVd7UDmayJfNQ+szleBk1cUJkTGmipLn0sYGF96zPfDNcIcZst4NK7X7km5tCHvw==
X-Received: by 2002:a17:90b:180d:b0:2e2:effb:618b with SMTP id 98e67ed59e1d1-2e9b1709a5emr5061658a91.13.1731089261140;
        Fri, 08 Nov 2024 10:07:41 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a55bf2asm5877152a91.31.2024.11.08.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 10:07:40 -0800 (PST)
Date: Fri, 8 Nov 2024 10:07:39 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Yi Lai <yi1.lai@linux.intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net v2 2/2] net: clarify SO_DEVMEM_DONTNEED behavior in
 documentation
Message-ID: <Zy5Ta-M868VvBme2@mini-arch>
References: <20241107210331.3044434-1-almasrymina@google.com>
 <20241107210331.3044434-2-almasrymina@google.com>
 <Zy1priZk_LjbJwVV@mini-arch>
 <CAHS8izOJSd2-hkOBkL0Cy40xt-=1k8YdvkKS98rp2yeys_eGzg@mail.gmail.com>
 <Zy1_IG9v1KK8u2X4@mini-arch>
 <CAHS8izP8UoGZXoFCEshYrL=o2+T6o4g-PDdgDG=Cfc0X=EXyVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izP8UoGZXoFCEshYrL=o2+T6o4g-PDdgDG=Cfc0X=EXyVQ@mail.gmail.com>

On 11/08, Mina Almasry wrote:
> On Thu, Nov 7, 2024 at 7:01 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 11/07, Mina Almasry wrote:
> > > On Thu, Nov 7, 2024 at 5:30 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > > >
> > > > On 11/07, Mina Almasry wrote:
> > > > > Document new behavior when the number of frags passed is too big.
> > > > >
> > > > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > > > ---
> > > > >  Documentation/networking/devmem.rst | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> > > > > index a55bf21f671c..d95363645331 100644
> > > > > --- a/Documentation/networking/devmem.rst
> > > > > +++ b/Documentation/networking/devmem.rst
> > > > > @@ -225,6 +225,15 @@ The user must ensure the tokens are returned to the kernel in a timely manner.
> > > > >  Failure to do so will exhaust the limited dmabuf that is bound to the RX queue
> > > > >  and will lead to packet drops.
> > > > >
> > > > > +The user must pass no more than 128 tokens, with no more than 1024 total frags
> > > > > +among the token->token_count across all the tokens. If the user provides more
> > > > > +than 1024 frags, the kernel will free up to 1024 frags and return early.
> > > > > +
> > > > > +The kernel returns the number of actual frags freed. The number of frags freed
> > > > > +can be less than the tokens provided by the user in case of:
> > > > > +
> > > >
> > > > [..]
> > > >
> > > > > +(a) an internal kernel leak bug.
> > > >
> > > > If you're gonna respin, might be worth mentioning that the dmesg
> > > > will contain a warning in case of a leak?
> > >
> > > We will not actually warn in the likely cases of leak.
> > >
> > > We warn when we find an entry in the xarray that is not a net_iov, or
> > > if napi_pp_put_page fails on that net_iov. Both are very unlikely to
> > > happen honestly.
> > >
> > > The likely 'leaks' are when we don't find the frag_id in the xarray.
> > > We do not warn on that because the user can intentionally trigger the
> > > warning with invalid input. If the user is actually giving valid input
> > > and the warn still happens, likely a kernel bug like I mentioned in
> > > another thread, but we still don't warn.
> >
> > In this case, maybe don't mention the leaks at all? If it's not
> > actionable, not sure how it helps?
> 
> It's good to explain what the return code of the setsockopt means, and
> when it would be less than the number of passed in tokens.
> 
> Also it's not really 'not actionable'. I expect serious users of
> devmem tcp to log such leaks in metrics and try to root cause the
> userspace or kernel bug causing them if they happen.

Right now it reads like both (a) and (b) have a similar probability. Maybe
even (a) is more probable because you mention it first? In theory, any syscall
can have a bug in it where it returns something bogus, so maybe at least
downplay the 'leak' part a bit? "In the extremely rare cases, kernel
might free less frags than requested .... "

Imagine a situation where the user inadvertently tries to free the same token
twice or something and gets the unexpected return value. Why? Might be
the kernel leak, right?

From the POW of the kernel, the most probable cases where we return
less tokens are:
1. user gave us more than 1024
2. user gave us incorrect tokens
...
99. kernel is full of bugs and we lost the frag

