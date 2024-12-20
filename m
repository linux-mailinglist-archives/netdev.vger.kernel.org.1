Return-Path: <netdev+bounces-153746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584519F9921
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 19:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81B2196257F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1F21CFFA;
	Fri, 20 Dec 2024 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="nefljVlI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054721CFEF
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715577; cv=none; b=Sq4/hhXiKGU0mMGzOt6CBtdDZDpnghg0vkGUVujQ2BGB3FxtjGVhflVFA3uuY5YpxNRjwIvFKm7QIqVXNGJQWysmRoSu3zkGh/byBWxDe+Yi0LjcvQiGLHZCmh8IF0JXT0j8mc6vDdzqSzRCH6MfKuxJr+oC50//7/BSHdLbF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715577; c=relaxed/simple;
	bh=WkuG10G1XzQZ2zSDFqo9dq02+hIGGFF35c7yljo62zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiCtWgdfEgKv4RSu0Rs4xHeFe9HsJf0eLQHEPC8FlAO7EinArrlVlcb50Mma3TqmFB7tnDevolOZwxXS+C6QUvFxuKtTr5VGZSSwiIzvQZgcjyIRAXgO849ROrK5/5nOb+/Umg8b5El9qJASwt18ALURr01DiWZWmgWJrTPvwYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=nefljVlI; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WkuG10G1XzQZ2zSDFqo9dq02+hIGGFF35c7yljo62zM=; t=1734715576; x=1735579576; 
	b=nefljVlIudSaElWqlXGHJjM4NpiColdm1ZrNHVpkqC87fWQvsBNCq4OA326aYklznnIrj6mOMn6
	weW5qh+Rz2karlbcTnAjqhQE7ep0C+VfAwUmt9Sypiiy97DfXneBY6ZyuvnIqy5ny0NGjTi1w8/oa
	1N9TGYF7OeY9qytzcyRbeLcW2tKrh2QslsnBBvwjxvrzcjYQV2bwyB4JlDcd9dZAccoAIaq7YqsEw
	o2kQkUpePSb3NHeZdJQxzvp3c8JZGTvfdJhbSXHFcJXoG2GTAi9IsoJbMtJWxMJvmzJOjKu4FVL+R
	tdkOjyxXPlso0pCtxpJN1MFb2HFL6uqhUR2w==;
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43409)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tOglS-0002Uy-Oi
	for netdev@vger.kernel.org; Fri, 20 Dec 2024 09:26:15 -0800
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71df1f45b0cso1424609a34.1
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 09:26:14 -0800 (PST)
X-Gm-Message-State: AOJu0YxatKHEH31pyWieHDGHypnVVsA2aknEPIrP9SJEfoK3YC4lCaFA
	Jxk9vlIezG3kRQ2b5xYRS8jL33vhDT8O7t1599UdBmHSAHdnVkAje4EHUMxvEvuT/m3GcRYir7/
	M4de1UqyKwOy1hqHuHWQZrOoZ3zQ=
X-Google-Smtp-Source: AGHT+IE8+V7EvU6PLZEPnpkiHTwd6RY94YHXJtb6XvkFCEe4bcC95i1fE5vkZc2c/9sG/gaqaozuKTCYCkBlQDwZQfA=
X-Received: by 2002:a05:6871:b13:b0:29f:99de:4330 with SMTP id
 586e51a60fabf-2a7d10b0bdcmr4935872fac.4.1734715574141; Fri, 20 Dec 2024
 09:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217000626.2958-1-ouster@cs.stanford.edu> <20241217000626.2958-2-ouster@cs.stanford.edu>
 <20241218174345.453907db@kernel.org> <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
 <c606d8cf-4895-430a-b163-3a04b932736d@intel.com>
In-Reply-To: <c606d8cf-4895-430a-b163-3a04b932736d@intel.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 20 Dec 2024 09:25:38 -0800
X-Gmail-Original-Message-ID: <CAGXJAmyaF2UYH1ySR8uaV8WGPQR15G_R1WWOcUhk7N0Zfd+Vuw@mail.gmail.com>
Message-ID: <CAGXJAmyaF2UYH1ySR8uaV8WGPQR15G_R1WWOcUhk7N0Zfd+Vuw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API for Homa
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, 
	Jakub Kicinski <kuba@kernel.org>, edumazet@google.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: d568c20fab0e2ccae07d583947984559

On Thu, Dec 19, 2024 at 2:06=E2=80=AFPM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 12/19/24 19:57, John Ousterhout wrote:
> > On Wed, Dec 18, 2024 at 5:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >>
> >> On Mon, 16 Dec 2024 16:06:14 -0800 John Ousterhout wrote:
>
>
> >>> +#ifdef __cplusplus
> >>> +}
> >>> +#endif
> >> --
> >> pw-bot: cr
> >
> > I'm not sure what "pw-bot: cr" means; I assume this is related to the
> > "#ifdef __cplusplus" discussion above?
>
> it's a shortcut for:
> Patchwork Bot, please mark that as "ChangesRequested" [by Maintainer]
>
> C++ program could simply wrap all includes by extern "C" section
>
> not sure what is better, but there is very little precedence for any
> courtesy for C++ in the kernel ATM

I have now removed the 'extern "C"' from homa.h and moved it to all of
the programs that #include it.

-John-

