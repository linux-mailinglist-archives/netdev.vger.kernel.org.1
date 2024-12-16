Return-Path: <netdev+bounces-152264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C00B9F345C
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2101885B3E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5005E145FE8;
	Mon, 16 Dec 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNgIpy89"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00C13C690
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362506; cv=none; b=YxmpHRrhYkCElekHXce5UlhTOsy2IdIsInMqEgljsAUtm8SwyKHE0HSUja6X9trRXYTJlH69C/ZJ7Ol15BGfggq3/TBeOLX0JzJcKh7ElPpsZVLp2a+XYWXy53N1JQjKhrX35TtQE6OC1K4UM1oxONDfldbX85fviSO7NX8M1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362506; c=relaxed/simple;
	bh=z188Si8T0Ru5PV8sZYDN6BgZfXMwGHf2YtN8js8mFuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7SP6XNB94h3URa7vcPL7EjzgxaT8j8yCtxHoDTofjVy5zJeSPhKtB5W7JvYjcgNVsnjJRHli2bNcbHfRJeM26vi0O7CIt/Gd+7l37llmgZ6IH3gdDsjH4byXTHM/dvaaxI+SKVUS3JHJqkdL7V1CDW2gJp8yMuFAKXp1EO4QWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNgIpy89; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so7707775a12.3
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 07:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734362503; x=1734967303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z188Si8T0Ru5PV8sZYDN6BgZfXMwGHf2YtN8js8mFuY=;
        b=SNgIpy890o47j9LBhnSvW2ScwvQp5/J9gR7jPkvt+1UA+voB+JjrrNui+qz83YGoQA
         ovjSrAYVitpAz0jn3gw07OXVFr+UiEBGxvo2ZlunvSeGcxduTet3BG0X1DzJTIlcTxHK
         yfvkQMo6BeJrwT9WyIAADRR1PVWZaEtNSvcG3mu8PsVL/IkhiWwuIV0LNXGMEffKAIr7
         Mc7P+p1y1Nnma/F/V4qhez1xOLXhp8L7zlJszBIJlGLKXZeH85G8EvLlgfQkAKTnJeO+
         m3+yOSZpm2cdADEh6fyo0MBE5s6IxETK/5K1fn8E6vq+0OeCXK/04jEU4QzTPfuCbJxL
         Eppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734362503; x=1734967303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z188Si8T0Ru5PV8sZYDN6BgZfXMwGHf2YtN8js8mFuY=;
        b=pIt8yEwToIji0O6KePwfclFXSE9gydDJR3TAyYO5jw321VdLbXaxPDcUZE+paPYy3w
         2bs9iov9PfimzR+wUNdPEXEvCk2jrDzBN4k4jp3Mdit9idvuHQ95aySjdj6xLmilBCgk
         hgsWjG75nMS/X/ji+9sLPC4nVAnsCvOh+i9+34HnFbIzZGyLlo1qEkXNlp6sdFcGrKfW
         y+XccdSKVIxx6aaJCmTWi00YjjkLww13kSuHdG3HxCXOUEx2WGyq4bos5AfvOVZOBUaa
         NKpQDQrgLkeQRVCr7yI2IsX26Y6XbmF8bfHCNalHzMSSuWTVpzy1q6Jy1CI72PjFXuR8
         4V8w==
X-Forwarded-Encrypted: i=1; AJvYcCUKk+Jggkc15uKaDnyCafZ9ngGge7uYhXMiASXgVCuyAR5GPxhOqm6R6YRzj/W5No7k3WXP5kE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jUpQtvZGOXKb2wLN11zO74H/9Ni52Ku9TsGSHSNLUPZgCVwd
	xRmJx8cmrvCHm4OUAV9dWWf68HGA/yBboBQ316NTRehEOb9FebDo5oiKBQzWWRCQor5MgCdyZx/
	rMK+XUv+KTsKufJo1vOxxLwlCjaTrqDEyFejO
X-Gm-Gg: ASbGnctg+zIE3Kfq45WcaMTVZHoJdfMbaA3M7yVZ+PPa8n3xvcO3IzUb8Dg4m/XdmCs
	yptZny385Lw54+eRPkyb1DiYMHo0MpmQlQ1nht+ShPKejhB5oDqkY3of5OucaI4CKN9a4Fxm+
X-Google-Smtp-Source: AGHT+IErRaySefjeoozXAp2uokzsJxJJ5ZRV/keyf8FwHpP0qQK1xshaFXNGsEDy+VyhsI31pNrPMLtyCMm2WTBgrLs=
X-Received: by 2002:a05:6402:380a:b0:5d0:8106:aaf4 with SMTP id
 4fb4d7f45d1cf-5d63c3b3b3cmr10428703a12.21.1734362503018; Mon, 16 Dec 2024
 07:21:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CY5PR12MB63224DE8AEEC1A2410E65466DA3B2@CY5PR12MB6322.namprd12.prod.outlook.com>
 <CANn89iL8ihnVyi+g1aKNu3=BJCQoRv4_s29OvVSXBBQdOM4foQ@mail.gmail.com>
In-Reply-To: <CANn89iL8ihnVyi+g1aKNu3=BJCQoRv4_s29OvVSXBBQdOM4foQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Dec 2024 16:21:32 +0100
Message-ID: <CANn89iKAZsG=RepuJmStFTH2QK+N5s9Cu=OnD2GmQAb1JKCfeQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 4/5] ipv6: tcp: give socket pointer to control skbs
To: Shahar Shitrit <shshitrit@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>
Cc: "brianvv@google.com" <brianvv@google.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"kuniyu@amazon.com" <kuniyu@amazon.com>, "martin.lau@kernel.org" <martin.lau@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Ziyad Atiyyeh <ziyadat@nvidia.com>, Dror Tennenbaum <drort@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 2:29=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Dec 16, 2024 at 2:18=E2=80=AFPM Shahar Shitrit <shshitrit@nvidia.=
com> wrote:
> >
> > Hello,
> >
> >
> >
> > We observe memory leaks reported by kmemleak when using IPSec in transp=
ort mode with crypto offload.
> >
> > The leaks reproduce for TX offload, RX offload and both.
> >
> > The leaks as shown in stack trace can be seen below.
> >
> >
> >
> > The issue has been bisected to this commit 507a96737d99686ca1714c7ba1f6=
0ac323178189.
> >
> >
>
> Nothing comes to mind. This might be an old bug in loopback paths.

Or some XFRM assumption.

Note that ip6_xmit() first parameter can be different than skb->sk

Apparently, xfrm does not check this possibility.

