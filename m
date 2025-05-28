Return-Path: <netdev+bounces-193849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939C2AC604C
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 05:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EED9E750C
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B0C1FC7E7;
	Wed, 28 May 2025 03:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9CNlKvl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990C1F5402
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404188; cv=none; b=LrIPjj8ynQRLLl7B2MUmvpy1UrojuBibRC7+kIWgSatSf9pbFhmNDZp7MdEfs5ajZVGy1gk0Um4IReScRiHQ3N2Sf9cUZFNmfvyRQA44EDD21XI7rgwTbnxntCgzElDfAjpHOlIqx86kPPpNBpVAdBhTESCsdz60hRUxWlTZsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404188; c=relaxed/simple;
	bh=djgdSAqo0lPl/HQxOwsgy/FVp3+EiXLFi0SERa4skTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiN8SnJPXhQfcwso4wPoK97NAFClybN8ePRFtdoMUbJRJFnNJRC1TkiBUEBm8QREpSILqX3Zo6b1TKKJhqOTsEQZYj3vwX2MqnxwpC6eCrUhTz3yluokLGugS8DCA1mY8HBhAHY3lulVG0BMSMmV5FuS98pT5GtRZ1OaPaxPL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9CNlKvl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2349068ebc7so139305ad.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 20:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748404186; x=1749008986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIZ917XmidCIU+2XIPpmQyQty1mwxL1YD04GjAwgej4=;
        b=B9CNlKvl41Kxuc113WpagkzE9M+sDe/xnaBs2VeARYd+Zgyp82c9VM+ydGEpb0hFd7
         vmxq6Cnbjbrgym1zVKbmRjvkOdW32JHbkDUmrlS9rNf1JYkQPwCVWmGlO6/e0O9NklEf
         38JHk+QSsSqpH6we38dBTAmwjzrMIByMCBDXjNNR2ctpB/mT6H7QRLlx/+c+Fd/T1qY9
         VWnPPGENMMW/SCR4eyj8OHoV8rh4AKVR7LgzvNTQTwgZ+bsOaIWj4JHyrfboCI3KLL+o
         dGwNhsedWm6V9dOssnqKT1hmTOh+XITf9j9BsHyZZecBvrD3YEysWmi1Fkmwgk2K50zl
         yQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404186; x=1749008986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIZ917XmidCIU+2XIPpmQyQty1mwxL1YD04GjAwgej4=;
        b=Xk7J5WQAf8D4Wd+H+CA+M/zTafeJPyOG1dNQPs/R3SJZ6EX65xMfASOgQAKGRjXf79
         FBWb0FAboN0Hr4dgWx+gxhbwuLYhPb9xa6iGaVZau4/BadwNvR5Rl6pEv10+cn4RCxTL
         OeMOCBSSGesHM5LopNmBld29PvQiR0jP+5lmnRZ4jX7VUu3/lt2yHFmv6zGotshlFNN2
         XPl/wqXU5eXaAuNWdNJkXqgCvMhND6UAIf64kQy2NsuWsyW6CVpELL+jYoYVREbc2qqe
         Z9SsxmZlIWghiwvrWo5yorYIEJS1+8QYRRyxto+v0eNlzh3zKYb+9Sy3gFO5fOCErL6Y
         xHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4h5dUCVSew5NMElvcDdALFDda+U75mv8AvcyvTpYhil9vnwhZQD9rVqyki0hkjxnljYf1R7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9eBojQmAmFmKGJdiM8XTfr8UZUpQV4/SlB9ujnglyslYfLivH
	kMgYfauNGbmGyUlrfCOc7EnjGSycrYhGz/8AlS7O9QyeZYgxtIT9COXzur/lIh4bbBypody4OXF
	Q3Fh/pgKiTUguDAEww4N/TQG3SYfsoaQyOhMWAIMzrHUzWbEst4Kos5as
X-Gm-Gg: ASbGnctQEDkUE+0OL05591oBbQxuGpuJ8Aaf5WH08/2gUkCy1BjHnIXzXkil0sXV6Ab
	dlPdUEeF5M8SupJEuym1lbTcVOOHfnwfCWd+MpDXUO+GM5bW69uOOrLpn1mK39IAYBEd62mxReB
	YEZ8LSa5vTvsBAsSFnkq3lHZoJQfAuNfGPS2k388w3vw9F
X-Google-Smtp-Source: AGHT+IE0LA2hqEVRyMO5ehQLuMQWJISVX52TwhBqaChHomSUcjr9ODU+fXdJxaZJ3LyPuCydsHtGJxM8rzUNEZb9LPE=
X-Received: by 2002:a17:902:e5c1:b0:234:a734:4ab6 with SMTP id
 d9443c01a7336-234c55ab4efmr1948105ad.26.1748404186143; Tue, 27 May 2025
 20:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
 <20250520205920.2134829-2-anthony.l.nguyen@intel.com> <20250527185749.5053f557@kernel.org>
In-Reply-To: <20250527185749.5053f557@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:49:33 -0700
X-Gm-Features: AX0GCFvTxVjd0Vo8S2abHdtE47I2E4xaEIIdVVQqhBxVl76iI_vqc-Ts1BrIJUw
Message-ID: <CAHS8izPope_UOF7saHHxaJSgqHWJWZvEKmp=0x6sB2OJAghqUw@mail.gmail.com>
Subject: Re: [PATCH net-next 01/16] libeth: convert to netmem
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, maciej.fijalkowski@intel.com, 
	magnus.karlsson@intel.com, michal.kubiak@intel.com, 
	przemyslaw.kitszel@intel.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 6:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> > -     dst =3D page_address(hdr->page) + hdr->offset + hdr->page->pp->p.=
offset;
> > -     src =3D page_address(buf->page) + buf->offset + buf->page->pp->p.=
offset;
> > -     memcpy(dst, src, LARGEST_ALIGN(copy));
> > +     hdr_page =3D __netmem_to_page(hdr->netmem);
> > +     buf_page =3D __netmem_to_page(buf->netmem);
> > +     dst =3D page_address(hdr_page) + hdr->offset + hdr_page->pp->p.of=
fset;
> > +     src =3D page_address(buf_page) + buf->offset + buf_page->pp->p.of=
fset;
> >
> > +     memcpy(dst, src, LARGEST_ALIGN(copy));
> >       buf->offset +=3D copy;
> >
> >       return copy;
> > @@ -3302,11 +3306,12 @@ static u32 idpf_rx_hsplit_wa(const struct libet=
h_fqe *hdr,
> >   */
> >  struct sk_buff *idpf_rx_build_skb(const struct libeth_fqe *buf, u32 si=
ze)
> >  {
> > -     u32 hr =3D buf->page->pp->p.offset;
> > +     struct page *buf_page =3D __netmem_to_page(buf->netmem);
> > +     u32 hr =3D buf_page->pp->p.offset;
> >       struct sk_buff *skb;
> >       void *va;
> >
> > -     va =3D page_address(buf->page) + buf->offset;
> > +     va =3D page_address(buf_page) + buf->offset;
> >       prefetch(va + hr);
>
> If you don't want to have to validate the low bit during netmem -> page
> conversions - you need to clearly maintain the separation between
> the two in the driver. These __netmem_to_page() calls are too much of
> a liability.

Would it make sense to add a DEBUG_NET_WARN_ON_ONCE to
__netmem_to_page to catch misuse in a driver independent way? Or is
that not good enough because there may be latent issues only hit in
production where the debug is disabled.

--=20
Thanks,
Mina

