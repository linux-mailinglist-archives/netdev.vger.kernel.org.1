Return-Path: <netdev+bounces-131862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D08DE98FBFC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 03:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A010F282F40
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B12710A24;
	Fri,  4 Oct 2024 01:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNku3cZX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6663D512
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728006179; cv=none; b=jckTOVK/uzLFnsh1WWnCxJlqSGjvAdyxyitU/uDVb18zDpEj1fqUXenQHpzy9DFeijL0FARVUHWKGddowyp7IQt+6r3WVTEXLbRCfqMLrUbvCIS71+ialt5ukU6ChnalIzY7PjzYo1kHJcBiSpy6ah/kcUm/dD1mAo4p1Jk/k0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728006179; c=relaxed/simple;
	bh=FTExebH6ftp0nirM5hs/l+/6MTtIE2Nk43ftCL7bbNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUXdjC1F0wcXcLtldromqzvGCPtniUjO8SuxnWw4fmT9cLOg1CNTAC24t1Sg3VDGjhfw3Atpu4pnsHj4lyKMRFbu/Y2XXdlUafvRbstAY0KGQXBoiT24XxD1jFZrP8/4DDTZqacWnp2ZBMN0Us566a6qzlRqs0MFUQT4xuOUos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNku3cZX; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45b4e638a9aso88061cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 18:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728006176; x=1728610976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEPHjVPYTRS635TMPRvM3o3uEqSHOMOOYJSBADVEz7E=;
        b=jNku3cZXB9YvNKLQ9StfWvUcQr35r+ULY01r2HsJI/wrs+XAF5IaNFiUEzTbIko6dM
         v+FFkr9GX0BBk6MpwwV7SnwcrETThmfSrD030HzW0tozIUgOn0F+AF+6rjN7Nj4jg0+S
         t57Elx/l7ZKqMqca1owMCd3xVenj2KAJe0ZTeNSWqtEXEWJI3z3FdYpDqnfesdPBL9nq
         1RZdHs19iT7xc2/U3Gw18tbxlaPxLZmNMzsY5ctUH3r9WBN0ipNaMWcm5Fksc2h70ima
         sdKuWiEnfuNoWTpiRhVS4pmfdiSV9iNquAQguC2WCduJMDPjAPl/ISooPn6qwwrAqRF4
         fV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728006176; x=1728610976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEPHjVPYTRS635TMPRvM3o3uEqSHOMOOYJSBADVEz7E=;
        b=uj+yUUpkidvJCWVGKpobZjlLdH9/omETjTneILfPelV2uWWqvkWI5Oa0IZ5r5xA4aZ
         Ig5NKMEQ5lGjieTzuCrQgrwkLqRQrj1miEtAXfqWzBmwlt5wu1P4zDsN+wERDa7fNGWp
         X+/BJnXt07ntg6psopEfi/fccVLeiuceKIqJBxq+Tt5YHo1c68s+VWLyIwmUYYUHr9MG
         lZjk4pkUobviRIwJBbMwip9aznjYi/pDNOXF8LXkjhMwaD8Wn0QFJEmDbyOLYvDr573p
         klLOD3MbKoSszFkYwBz2zxOWGM7zezxsb6l+ds+F0la9DRrVNfb90+Ep/RhmDKQR4CCv
         08pw==
X-Forwarded-Encrypted: i=1; AJvYcCVHwUHKDZ51hlVxQNKPRCF/mZ745rmXthVOvW+BtduOBhiKlY2r5AgKBxyd2fRVcXFrV+zujcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkeiWtHu+n9FzmRnXJMN1E3iboKxWAkIonqn53YImp9jA/Bhhp
	2zcLsvrBbmsWThn4yOljYedhF3LP+ueFJzX1QOJwwbyBGdSjkOWqKppS2+GGm9HQ/e63NIx9zAS
	+nzHwT6lKqRFcomRXKbo/tu1UDGhOQvtd5Q55
X-Google-Smtp-Source: AGHT+IGaIjUTSPSTGMk3Zthh2IcSNwa4Pd3YDhnuJTpE8LzRij24sDiWW0FdpVD6QlUQylmPBBuhvJGmdp4o3OlHW/Q=
X-Received: by 2002:ac8:64cd:0:b0:45c:9bb0:64ab with SMTP id
 d75a77b69052e-45d9e00cf74mr627561cf.29.1728006176466; Thu, 03 Oct 2024
 18:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-3-sdf@fomichev.me>
 <CAHS8izNGphJPD6-PkATnOETj-LFLadSAKTe_A+FiJ_3Cax35ZA@mail.gmail.com> <Zv8VxOJiEWHmcWpj@mini-arch>
In-Reply-To: <Zv8VxOJiEWHmcWpj@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 18:42:43 -0700
Message-ID: <CAHS8izOdh7iWbhosGmsffG09=to2JYJ-aQGOS6vuRqe1f6gdUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] selftests: ncdevmem: Separate out
 dmabuf provider
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 3:08=E2=80=AFPM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> > > @@ -464,14 +515,11 @@ int do_server(void)
> > >  void run_devmem_tests(void)
> > >  {
> > >         struct netdev_queue_id *queues;
> > > -       int devfd, memfd, buf;
> > > +       struct memory_buffer *mem;
> > >         struct ynl_sock *ys;
> > > -       size_t dmabuf_size;
> > >         size_t i =3D 0;
> > >
> > > -       dmabuf_size =3D getpagesize() * NUM_PAGES;
> > > -
> > > -       create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
> > > +       mem =3D provider->alloc(getpagesize() * NUM_PAGES);
> > >
> >
> > There is some weirdness here where run_devmem_tests() allocates its
> > own provider, but do_server() uses a provider allocated in main(). Any
> > reason these are not symmetric? I would marginally prefer do_server()
> > to allocate its own provider just like run_devmem_tests(), or at least
> > make them both match, if possible.
>
> I wanted to keep them separate in case we end up adding more to
> the selftest part. For example, not sure what would happen now if we pass
> a udmabuf with just one page? Do we need some test for the drivers
> to make sure they handle this case?

The size of the udmabuf (or more generically, any dmabuf) is the
address space for the page pool; if the dmabuf is too small, like 1
page, the rest of the pp allocations will return -ENOMEM.

--=20
Thanks,
Mina

