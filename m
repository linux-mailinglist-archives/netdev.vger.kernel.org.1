Return-Path: <netdev+bounces-96380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D9B8C5838
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442C02844F5
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91E917BB37;
	Tue, 14 May 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEq5DbUv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F026AC6;
	Tue, 14 May 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697875; cv=none; b=ZbEaVKerur8BYu8lCVN5EkVMqblp1IPBH1HcQESyY17qiLr6DZSj76RrTQMhxvzxRN8a3gETj7O66jOvy0y2PjdbmINOdDW+EVOWxGfwkBG9/zJEwdMxIVfF9RRjlbJZ4xuFBvY1kPa3rnhfSWu43PVr0iXTWy/85FbvkNa46+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697875; c=relaxed/simple;
	bh=mKUx7XqLsr2OSa2jdDCXHSMFkPyGb9MI+ayaFjLz75M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMwcST5R30Y1wsy7TE/c6nXMT6rbrZnfCMe19YWogURmucGqkE1QlGePqbe7tZo6eXEELhWdKuVSNhYzOAHBoKXkPgEqzSkhIvIr/7d6hXhrubXl+OV6NAsJGLwITLS7J8DzuRkOhbECwCwA5MmUO+Fn4MN9LX7NgWZKY51XpEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEq5DbUv; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e2b468ea12so49001441fa.1;
        Tue, 14 May 2024 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715697872; x=1716302672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKUx7XqLsr2OSa2jdDCXHSMFkPyGb9MI+ayaFjLz75M=;
        b=YEq5DbUv5CNrAKZWfQsBGvVucIWhS8UcimODnegPrS8jEmNFjUDOXAbtjvPwpT/+d1
         aaX4f6TOybOuLIw/kymSSe2yNozidy3iylzGUTdRe+WC+9hE6uTtMxWlQEJK3EKFqHTg
         sK6RyHvX/MOK80fUV9vMVJlaajHz/zADDA8RDLShaRkDQyCmY9xHDfRch4qlUCvdF8Uu
         3y/F1PSQNzpj4XEdf7LmjI+j+hyFDR+wyhY3SvnPcNxM3OWqffEh7vAEAYlOFURPf+7x
         AzTWWzhVnVxaauf+3dzv8o1k1aBhwukq3Xxlym+g7sBLtpZVGwfybfAO1NeTgeCz8uNu
         mQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715697872; x=1716302672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKUx7XqLsr2OSa2jdDCXHSMFkPyGb9MI+ayaFjLz75M=;
        b=gz7z8vg/qtX0XdNtNPEhX8XW0luQagp8+jI5wLse21V0THDE0fIBLiYA9kdMYbU33v
         ewyqbt6Kgw965QEtj75M62iJKMvPDrsIVFrtVTG2bzXD9tfLXcd4WM8Vw+WLbCuVwsP2
         9ul2h07IoV+fJCfLkMnVbtcqxSZqlbqQshcbF6dtxJHPIHIZSE2KYflHpUAEUMAMs5BQ
         RwnyAPE0MTYV7tF2sfYDep1Op+6E76gI7KkSIHV0VJIwRMAXgWgygaD2i6dOor14YNFQ
         aCHmQfggOWPZtLBuW/JYHFv7eMqtOMg/orNZShiD+Dhk0WndLPvdyUMwZz6pIqdac1sa
         YYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWexsvi6pq9sB6QuaC3lJ6w3RWlILxHUYLcJtkw/9MZsR08ihyaY0AzsHXsoIiM6EvjlHYPWqMPCfrpOVuLGZA9vtvDXyLzAX51wl4obGptFnatdn0GoiZdVgVYQJBXa5p04CkhyiwM
X-Gm-Message-State: AOJu0Yy94HtGLzsUv9s4V45lIlCpa9jtjq2gtz4FWdfkLtzlyIgLc9mQ
	plUYK5tFXwh1xJiArtaGl1/sBjyM0417BZv3kwBBYtMmH71Am++uziNfjideXj7TXctUsGWinJo
	vYh27s2zRMgswO2Psr/up6dgsF5I=
X-Google-Smtp-Source: AGHT+IHX7IKBXxotn/TKiULx6jjaFm7E0R+pAYRGWkwNahOiXC7uTRAgRMEH1GsKbGGod+iczxn2Rk25wAMZ8KsJMsg=
X-Received: by 2002:a2e:1319:0:b0:2d8:4892:bee2 with SMTP id
 38308e7fff4ca-2e51b17f931mr47659181fa.20.1715697872127; Tue, 14 May 2024
 07:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
 <20240513142641.0d721b18@kernel.org> <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
 <20240513154332.16e4e259@kernel.org> <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
 <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
 <CABBYNZ+f8L946_=6RyGvsN3bmu4EwJ2tTgxPg9YmNxckJTc_iw@mail.gmail.com> <20240514073402.72d2887c@kernel.org>
In-Reply-To: <20240514073402.72d2887c@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 May 2024 10:44:19 -0400
Message-ID: <CABBYNZ+M5FYzGe6xLM7uThwNrfRs4-hN40-LYiwp_249NKMomQ@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-05-10
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Tue, May 14, 2024 at 10:34=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 13 May 2024 22:12:04 -0400 Luiz Augusto von Dentz wrote:
> > > > It might be safer to only suppress the sk_error_report in
> > > > sock_queue_err_skb. Or at least in bt_sock_poll to check the type o=
f
> > > > all outstanding errors and only suppress if all are timestamps.
> > >
> > > Or perhaps we could actually do that via poll/epoll directly? Not tha=
t
> > > it would make it much simpler since the library tends to wrap the
> > > usage of poll/epoll but POLLERR meaning both errors or errqueue event=
s
> > > is sort of the problem we are trying to figure out how to process the=
m
> > > separately.
> >
> > @Jakub Kicinski I'm fine removing these from the pull request, or if
> > you want to do it yourself, in order not to miss the merge window,
> > then we can discuss it better and even put you and Willem on CC to
> > review the upcoming changes.
>
> Sounds like the best way forward, thanks!
> Could you drop them and resend the PR?
>
> It's going to take me until noon pacific to write up the PR text
> for all of net-next, to give you a sense of when our PR will come
> out.

Perfect, will also make sure to include the btintel_pcie fix for the
warning and drop the entire set implementing support SO_TIMESTAMPING.



--=20
Luiz Augusto von Dentz

