Return-Path: <netdev+bounces-229582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D09BDE899
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A81420EFB
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A799757EA;
	Wed, 15 Oct 2025 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juRd+fdA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2533199237
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532582; cv=none; b=uvyes7ClzRToLqAoRL7aXonQFZbRuKsF2vH0obd3qvctyfIJVyClFp4/Ew3iawTwaGtMD86kx3u99fEvQL+OKYiC3qTfcKIH527TWbZ0uaWexHsgolzWLwis3ufnVmMLusERtlMS50YsiId6xhFrrpEItHy7cArtEl1+Ctl4whM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532582; c=relaxed/simple;
	bh=g+5ElWkl0w/afEHUinFvhqaLs6c1Gi3/Qess2jnJ/Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixT9Ng2VYJJ1yfJfgAE+FrUHnMYfaJYoEe9cozZTx1rfTLd96k90OKBr/7cZwWrBHdlcwxCDGn+1pZV0q3Lfj/0yaoiKfO6KLoe0G2JNrWX2UPxYBVB63l58QFJAF02jV6c98IZDV+1i8E2JVOzkUVj9f7fBd92PPH5QDgqgQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=juRd+fdA; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-81efcad9c90so95285036d6.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760532579; x=1761137379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+5ElWkl0w/afEHUinFvhqaLs6c1Gi3/Qess2jnJ/Xk=;
        b=juRd+fdAJG5OggHF7n48QECPhuxj0MYweXxbjF98qFws9kx8XV4MDpS4OgPeRKnMhn
         nMQ73yfAmRgOAHghsG8xp6V/vcdmVwgs/V664L8gczc0jmOvAC1YVjXDFuOvYJEzj1uB
         wbVyJ57WrAFwAlBOtbAjgnVPQUaEIqSniKQoh3djLGBCu1mBqNHzHib1dU5wh0VgHmyv
         oKfIyuWo7JR0awLNdkW0f+fNe0LchC+KTcZ7j0uvXPym17v759AjE4j9zZiu1yCiusVp
         gIvUUmWLPHPHXIJKzzeeir85yCL3Ya48phzrRSGURtMgRoSDn96AoA51OmqHmpTxUWuv
         iXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760532579; x=1761137379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+5ElWkl0w/afEHUinFvhqaLs6c1Gi3/Qess2jnJ/Xk=;
        b=DfM24+f4aKur/Nutcj85sdObwr5p00RG6HxFRALgq/qVDoWaYmi3xeWd93spy2JCh4
         0gGp0Ke4rVldMUHPySwS3zAmFbhAujjiKLdaWneaJAH8Ez60H3SxewdgFwTtq2X/gSvq
         kCXg5UblWrMGuYxf9RqF/plm/poUlgop8VopM79WJogv/GiT+T1tKTDzW/4Y0DFKLweU
         n9944MJJmyfN9/MfsRkloAfUj+c/k6C1uG8NOOGNapmBYmrFmxKonMvYFKsZqJEJvtfH
         jnlCMm3SszZoSq7p9W1dFSwILekjFcAA4Z4vCQ1Ohkhj6IgvRKxSycsDX5e5O6ut9KCw
         nP4g==
X-Forwarded-Encrypted: i=1; AJvYcCXnLIuQGztN8ruQaps+ViV1C4opjs061IrxmnfJ9UZqiMyfkSHyDeazHDuD77gprlqBLU/KQFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/Qq1nIoPe5IT+M/G2k9dDYSHsAwe2di2XIIt2I09fcRU1RIn
	1yPnLNS1TmUw7ihk07yJrG9LB5iZydOAtxVPzTYN6Yutcor7IzVC6fpcE99mfTTIRvi81o0QQ6T
	gzY7yHquKS0OKRdMexLstlO4HpK5hx+dI0bCuIHAe
X-Gm-Gg: ASbGnctTzXheo8rOsDeoVYvcpZBoRL3WdrPpA1yyb/zIjzp3oFMjqeMzDxZgmtY/ZEc
	QT6LYN2L2rVZwAVZmrr2nCLv5oOgMAecNfSEH7VT7mHvrkuEXNCaCbmLVq3poRZ4VykszUCF0HX
	twVcfn1M7UT1X09qHqSMM6vkVMGyyc/Dp3ld7+JrdForENqsyZaafJ3AukQQVcpgjhRTr2/d1n4
	EM+PIQIBY8bRAi6uE8LvPfU7UhufGIOSXpPsVxBiBol95bmscR/Yn0=
X-Google-Smtp-Source: AGHT+IEDMAoG/EivKMoOaWiv7RyeSeftGdLgNtyGwOC3ncdCvsa6TXxRJdLh/LuahVttgWRwN5PTExBQSz74us5RtRg=
X-Received: by 2002:ac8:5fd3:0:b0:4dc:cb40:7078 with SMTP id
 d75a77b69052e-4e6eaccfec2mr367064371cf.19.1760532578972; Wed, 15 Oct 2025
 05:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-3-edumazet@google.com>
 <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com> <CANn89i+PnwtgiM4G9Kbrj7kjjpJ5rU07rCyRTpPJpdYHUGhBvg@mail.gmail.com>
 <f51acd3e-dc76-450d-a036-01852fab6aaf@intel.com> <CANn89iLH4VrGyorzPzQU66USsv1UP3XJWQ+MWMTzrceHfUNYVQ@mail.gmail.com>
In-Reply-To: <CANn89iLH4VrGyorzPzQU66USsv1UP3XJWQ+MWMTzrceHfUNYVQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 05:49:27 -0700
X-Gm-Features: AS18NWC7PQDd3rD30h19-qWwWBWo50zMw5PFSwmCFmHh9o9Di2OtpwHKFemEl9I
Message-ID: <CANn89iLkFPgT8Si9TQGc4VVAW_V1v51pQQaiAXWSACba3jHzsg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in skb_release_head_state()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>

> I can not test what you propose.
>
> I can drop this patch instead, and keep it in Google kernels, (we had
> TCP support for years)
>
> Or... you can send a patch on top of it later.

To be very clear : my Signed-off-by: means that I have strong
confidence on what I tested.

