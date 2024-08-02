Return-Path: <netdev+bounces-115269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 783D9945B0A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240DA1F223E6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16611DAC69;
	Fri,  2 Aug 2024 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8NpzUZD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA41DAC4A
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591150; cv=none; b=BGGRa+B05BemIaT/RmaGHa9NaVA2XRm+nsQ67TwENx7FLv97szl2+IIQVjJhFpv2BgmCcuQOU4U9lfTmf4uO+FdMoXT0VadzdsKliIa+qUoAqVY2TN6jIBM8FL9nUn8u8xrwBZM/tSxyfFNwuVd0GGJHzCuNpmsTf1KrYMzsgtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591150; c=relaxed/simple;
	bh=Ht8WFx2TeLWnZO0kKiIAoygzBLZP0VV7Ohpp1lnmA+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/X/I4ZwhrA2H3EEIXMLIraiZRZEUPuVvRQNr0TtRe/hjDaQDByjBLXW4Y1Y/1gd/kEzAOfnLbPCt+vBaAjtoL7YOFHhRa8qwvSOYbA+q80+h5HFXBtLG5vzAcsZrVwGH9FpzO7rCWJmSVWBODVe26q7YZV8q1+raV4Ede3fIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q8NpzUZD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so48429a12.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 02:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722591147; x=1723195947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht8WFx2TeLWnZO0kKiIAoygzBLZP0VV7Ohpp1lnmA+w=;
        b=q8NpzUZDbBacR8aih2sdjW0Un5DM4sW6CbIATp7vtK13PtmbxTXIb+Dg+aDsUAQuHX
         dklQ2XbCq7G0eQICSD9HRozmCxaT5/WxoOIK/cf6EpncAe+swATaYBn5DzXQVGaP8Y39
         bSKpSXocuR1kZVazdmsDDa+TPPiKUgB8o5LJZfOeL/GqNYltM8vZjKsUW1UvrHopRKpb
         +zDcN7Hacc4B/BgypZ9/5xxuVZNidAQe1KPUnkDcRNyRtZUTso7te5ogWz4y77jHZt+q
         5wnLkgU5vrYa6jBKkbLHKqRgf95AMW3e/W/fwApKBWSMpz1v9SsaXlxPTxeQWuZXnpno
         qZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722591147; x=1723195947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ht8WFx2TeLWnZO0kKiIAoygzBLZP0VV7Ohpp1lnmA+w=;
        b=Zh4Q6y8wY3bD/GE8CIz01BKcxUYaz6Y2QUJOGwI35px73uHbuCt1VFB1FE8abhMnT7
         eq/5hx4C2ivnUR5l59sN//Pp27nMYlimBNrjHlkI0zrIUh1er7YaO7ET3kisC+Xy6Vl6
         D08fFnjTkGtz+BWBdQHshIeyGRM7o9jyQ39J0xbyRaMzdp5lxHVHyKbBCBOLmcQKH48J
         ArrmoIFJgBjXJFgrtwVRwYLEcp6DJ5+bLt23cpwsPtKjVwZs+3IsZzTIUQhFKwewnmBS
         puCGVFKatrLXl1qKRj4jwr4Gy+Tw+Qhk9ker071Wy5dzUFcfHgFa25hO70//v8sa+OLP
         b+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIBDtQxP/+PipudJHWP91sFPNoa6RisRHRVPyeyZBvJXphQF+N4rdl4ODeMImiJ/XL727cWaP5O9j66Yrs8wzEY6m2hS89
X-Gm-Message-State: AOJu0Yy0i2qyknlddXqm8/30jzMYAUmmcn+2qh0/rK82k7Ol4TZlebm7
	pPibsjg+vzRDFIZ0WqUo00XULGf/f15IJYEXZmYrYZpXmJYLclW0HtwqqZ3tdScDGdoHQ6TUu6G
	BGLHwNN9c2bOAIcEAh5PZc8sbCjZ+/WCHqRNB
X-Google-Smtp-Source: AGHT+IFm/QssIgS5q4ehMvGXLeWrdhE34gzLLyzjNcimpTY3e6scwoA6FCkQmn+Xj3fogyASh/YAI9ZGUQnUOhabUjE=
X-Received: by 2002:a05:6402:50cf:b0:5aa:19b1:ffc7 with SMTP id
 4fb4d7f45d1cf-5b869f0a43amr106202a12.2.1722591146865; Fri, 02 Aug 2024
 02:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801145444.22988-1-kerneljasonxing@gmail.com> <20240801145444.22988-7-kerneljasonxing@gmail.com>
In-Reply-To: <20240801145444.22988-7-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Aug 2024 11:32:15 +0200
Message-ID: <CANn89iKzMZhh9ivV6V_outTaTxLLvwp4iE_GjDWvX+Q49Nw7jQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/7] tcp: rstreason: introduce
 SK_RST_REASON_TCP_DISCONNECT_WITH_DATA for active reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 4:55=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> When user tries to disconnect a socket and there are more data written
> into tcp write queue, we have to send an RST.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

