Return-Path: <netdev+bounces-135463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CAE99E052
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7645E28201F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAEB19F420;
	Tue, 15 Oct 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9Zl2U+X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA03A1B6
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979567; cv=none; b=hJdkmggbS5ZuEO2WLTiMDfbdE41UCKF/BQm8bILYkobGsZ7FzFJXfWpyTHIeYxvpxWtkRq2gqYW9kinjTZ5bcUSsUItvCP3kmsKKSc5RhkGPuA2NvjaL0uhOxnRqZhp1urExLkfIyJdVdlsXp/WWpjXuECh+fXOG5jH9aovk1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979567; c=relaxed/simple;
	bh=Hf5sbom+1tJSI+T1tEa2calPUSzRvUp/AGZZU7Rgx/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2sd75hRXX05qhKT0ZyFTxOntTiBM/roTacxe+vkzTtW950IBYdBy/74UltbsSFd4UYRN+5WFqoLM565QFjmcswR3NzeQ2UzaA9SwL5g9KA/qwdcQEfTX/a+Er35nxFLW8nIyMrAQnO/QII79fZYF9AtRDv5zsPQeyhjTRr8Caw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d9Zl2U+X; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so6720386a12.2
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979564; x=1729584364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hf5sbom+1tJSI+T1tEa2calPUSzRvUp/AGZZU7Rgx/4=;
        b=d9Zl2U+XIX8HvOqOtB9RPTbB9ELvQpwUMdvdX5i3nA30JeUPanSOBGcbmCDDjjlOdM
         jgWU3G45BB1rlUDXBhf+/J53PYVhKfAhkLuTwSQ6SE021uffG2UMle5Eb9Hc/TbgJcvz
         eUlMNQdgCaYUhfwrP+9vekLQW65M7GiT0x3lKg5iHwXaUc0Fb43zuobundYGZRErWvZ0
         mQTX5G+n2Tq7eZctRJtFp3RhvNJqHGB0QjWWBx93Cx11YyyD4prCRb86O+nJO17BI9EV
         KmWkQx9YYxlrxCKpbj5TNHiChg7jU09ixXNiRx19eaB1xlgM7hnoXqTAh+YSdqiPniol
         TTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979564; x=1729584364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf5sbom+1tJSI+T1tEa2calPUSzRvUp/AGZZU7Rgx/4=;
        b=axDLjsYynEqcIQVDV9elvQhBwSs1BGk1kJVY0mv6db09i6PV5J4qFTQ8dRIDKrnoo4
         qp7bo/BP97rwRPX+ev3hAaujzELfiP/8p6iu+bLIyzj1V/KqtkORR4l4p6mJ0lAgJSRH
         6zuK65d9kr0t4yB6e1zH68lh7a+hE33m9ZhD1Ds2bWJ99BgCqTmTHVtUvcXaf02HqpsO
         gGyReWVs+B6FXiqY12frSnGcFKPyqOkmOlzDqCkdQMB3RnQCi0su/ekXjoAeFWwLIm0i
         JuUcreZ4DTIvXUiU27Du/r0h4s7UoIMHHOS30aTffGsVrRTHYsQ8qAmZFpu0NjmLAh6O
         LsAw==
X-Forwarded-Encrypted: i=1; AJvYcCUc7+6XO07EHnpQoWKkiIUTtt3UuPjmiYQJXKM8u1GIzrmVXXnLvX9DERMBAKSvIDtByrfmhbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2EkWGfW90H4DUyP397Bc4d/eJL32Cwa4yL04nJSus/zoVOJ9q
	hpODuret+TsZr7bYtMD++uNy08c7hBNPXBg0L4Sti3ZB6wsiGCjSRr7KAImha5WbAeuTeg/8ODp
	Ber6iMP9PHWG8IPqN+EfWQgvj48dWZuFIFGhh
X-Google-Smtp-Source: AGHT+IF0xxh48FLIEsnDmDAKak+sCF3RjcMU7ZWLhjOUWb3x23/TajMFkARYnF26YLJz7ZmTIiE7WFXReASZlV8NFgM=
X-Received: by 2002:a05:6402:2690:b0:5c8:9f3d:391b with SMTP id
 4fb4d7f45d1cf-5c948d4faa2mr11526448a12.28.1728979556044; Tue, 15 Oct 2024
 01:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-7-ignat@cloudflare.com> <20241014213705.99272-1-kuniyu@amazon.com>
In-Reply-To: <20241014213705.99272-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:05:44 +0200
Message-ID: <CANn89iLMgdebS-EZHo4mcQtgrG1AmvK7xKTmPL4PNEmK1PzDVA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/9] net: inet: do not leave a dangling sk
 pointer in inet_create()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ignat@cloudflare.com, alex.aring@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, dsahern@kernel.org, johan.hedberg@gmail.com, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	miquel.raynal@bootlin.com, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, stefan@datenfreihafen.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:37=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:05 +0100
> > sock_init_data() attaches the allocated sk object to the provided sock
> > object. If inet_create() fails later, the sk object is freed, but the
> > sock object retains the dangling pointer, which may create use-after-fr=
ee
> > later.
> >
> > Clear the sk pointer in the sock object on error.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

