Return-Path: <netdev+bounces-83354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D36892068
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4CD1F2DDAC
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43346179;
	Fri, 29 Mar 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCo6U3KG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7C1429E
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725871; cv=none; b=PmqxPWUrCgT3wnRaf7uj8Q9JX2jk1Z6wKq1WfGYZcxsuNyDuxOeIdysfFBJrbtyFikYfhqMr4ZxmD5cGJV6gmIKi6ry3ALu+kVNLBNickgh0zvj5ddHacqZb7rTCsFzSmQcXWSCKdz5QEf6YwJ6b2/ayWu5w0tlq4MAkmjXrgPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725871; c=relaxed/simple;
	bh=IBimiI6tAiSlD4YfGljtBhFFrHuKwZ/11/w/4ZhJrLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+vG0pnjbpUdCgTADkyiHwWWwNY+Dc5V/vjQzIWwkSFzdl+e2GDbiyi22061n726TkFE798gFivaMskrOxGSGAuG17A8JbL8xiPjYAKMRwybbIqUQ9vHruoH7ovNHJ76/EEer5nHGJNVti2iBP+keWdI7TydXWDDyQB+b5RI+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SCo6U3KG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c63f4a468so6887a12.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711725868; x=1712330668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcpavSa7UqgoYGVhvr3xwe7cZIb4gbqfujram984oxA=;
        b=SCo6U3KGPAnB1fE1Jn4a/H+4Kv2nuDuA5X5R7/X/jqbBfDFASBuUYwlRetfrfIXw/H
         f2z4ZMepT2sWf40JJZslcSKS1UcCxDkirQmaRjhTsARe3gpiw5k9JFKQhSCDew8Z0xCY
         0jxQKBL4rVctOM5mm3IUFMgo+eBAcRTf/6MKywPNIkM8myLAf057nYcXdu+WsSQQnkuI
         PjDSypFqk6QIfqc0FMf3pRVi+poKcZAyBtS/Nu0PvQ5rG+SoWaRDWgJffbfsCjVWP0vw
         CNPkP3v56d9aTb+DkMgM/H+sx+wSs6iSZcgW6iQrWsaXweciTk00MDj3IxuGumLyhL5d
         NzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711725868; x=1712330668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcpavSa7UqgoYGVhvr3xwe7cZIb4gbqfujram984oxA=;
        b=a8ho0qOdbPUuXX7YSWsSCoSNQ75PCnVgQ8D1yPSLtRfEPdb6RT/oeKZw0PrczUSTw/
         KT1gTa3hu7AFB//Fc+Sm4lgmAMXa9W3q3/jpJIWghS03Vd6IBzO0NEcpYZmIXvs2JsTV
         bCE50om7ttkjFJofd4wsQz02ye6gEWFV9FlSSnX9hSWM7b9KBSAmmGmHd9UZ3SMtwhT2
         nttyiy5pMtsX+Io2jfyrDUffUnjAcaRLz0uWnpryqochczIpsOaX8ngZFr4V6Cva1DxC
         f0naIOVL9pl7d7S5lKRWzpIe7+sd8invJz6No5SQxzKpJ5O7n445PAtZH0W5gA/ElsVT
         rL0w==
X-Forwarded-Encrypted: i=1; AJvYcCWknL8EmghsS4xVEJUWidyVhUrXLYG6aNbF4cxcz2hnjpGWTuyYLyXUxVneRRWbblQ8KEIR9DCMPjiLMSBfxFUnE4b6BxTm
X-Gm-Message-State: AOJu0YyhcuPo/TMxkyzbeo88pMGioysyl5d8aTMMq7huzaYg7gOPhf3J
	zhsnHtS99+lLpubRLUlXFWwzjTRyckEnMbLFBHXu5TghkHVL0Gr/I6p+1Eu7ZEM05bOvYVVTe1c
	FTmw/QGL3vBF/0aeuyEGI0LIUe0EROcNiiFnT
X-Google-Smtp-Source: AGHT+IEjJobdzUQujc7lspLpBDoYzKyL5aHDDPFMDT2RBz7BGyrKKKfqaiDEQaW4++j/K7tofI0CHZw4WSl7yAyZElA=
X-Received: by 2002:aa7:d784:0:b0:56c:cd5:6e42 with SMTP id
 s4-20020aa7d784000000b0056c0cd56e42mr178052edq.6.1711725867743; Fri, 29 Mar
 2024 08:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327191206.508114-1-edumazet@google.com> <20240327192934.6843-1-kuniyu@amazon.com>
 <20240329080648.3cd12eaf@kernel.org>
In-Reply-To: <20240329080648.3cd12eaf@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 16:24:16 +0100
Message-ID: <CANn89iJQ2HGbeufp=Kx3BketFt_D4u6sRo+qJae2syyzUricdA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp/dccp: bypass empty buckets in inet_twsk_purge()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, eric.dumazet@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 4:06=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 27 Mar 2024 12:29:34 -0700 Kuniyuki Iwashima wrote:
> > > -   for (slot =3D 0; slot <=3D hashinfo->ehash_mask; slot++) {
> > > -           struct inet_ehash_bucket *head =3D &hashinfo->ehash[slot]=
;
> > > +   for (slot =3D 0; slot <=3D ehash_mask; slot++, head++) {
> > > +
> >
> > unnecessary blank link here.
>
> I've seen some other core kernel contributors add empty lines after
> for or if statements, so I think this is intentional. Not sure why
> the empty line helps, either, TBH, but we have been letting it slide
> so far.

I will delete this extra line in the following patch, thanks !

