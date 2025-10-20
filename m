Return-Path: <netdev+bounces-230967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C65BBF2707
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E9774F853B
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C67299950;
	Mon, 20 Oct 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yOKa8aiK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B03828CF49
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977872; cv=none; b=c3BREsxsKTJNOUEaZBhM7SvDVq8m+UBApizWuj+jU9447Tn6QPn/8qQ1JUR824FD6n0hRXqZUI2fuTs8FzhPWCfpplt+KMsXzIxuFcNuNinQjNTN/YYlHMEBxBqqvljPkoDSYUSdillaFNeFO25WBIeExI9yVd3cJCfW/dZe6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977872; c=relaxed/simple;
	bh=dPFovmpKdroGd8354LpU5WRnCZYAnDz9cnOhTf5IUnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxmVGHH626aQmUMD92jJrgHa+AgWlfsdXk6vsAmCa9SKPeq2GyHLrb4pS+ixiwgAq4h+ynCOx0Loben3WkJ2ykLkVtPaB2qCj/FKC7AiAMbvRy1U/PTRuWy1IuzoZErz8mua9YfqNxZoMKb71OFA4BHyajCD6bVj6C0rHyk6YPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yOKa8aiK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4712c6d9495so1238825e9.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760977862; x=1761582662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgGhFAo2eru4JFVMxvySKBBUict2gGij38PNLAiiQLQ=;
        b=yOKa8aiKBvjk/2NndJ4JVxY7S0In/TeNa/BY8SF1ZovlM17amkmLkGwvItkCBh7ESt
         z4eR19hk56D8Jw68w+xrEThCjlNsdAvR4nZyf1tKV3dfftJ9fBh59Em6GPBRJayoXa/L
         7h503RIGbTTDu/XQXdXOe57brxbSLwnKphBBbhmryL7eO6IN9vMc1aLNPIF4DmkPBDZ7
         00tjrmIvpKihFk/Wcg1KcV7CLlYnicMGajWxHUu1bMX02iIRQ5rHpzxkDMzbuNVhyW2j
         TGWxoWMBDHk16LfkPRELxTriAJStttc3dY1R4ZAlmQ6BQf/d5kqCo4EO+bypvYn62VaM
         kfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760977862; x=1761582662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgGhFAo2eru4JFVMxvySKBBUict2gGij38PNLAiiQLQ=;
        b=ZQOPHNDOnzRY+cRfjt+1JDb7YaD6T7q7hnNO6aAaEqj8YwBKYpnABI4gchVilUGwmw
         dJGd9qLoWJwhphn64V+F3yytXAfx9Jf8gvgMAfc9VTf+DDYs6bi8Gfl9/o+Y/VpB4Tdp
         caECFtT/nUd+UdWkzDQHkjA4KSKAv5bCKQ+IAY6Z3yn4HDRg0yNXzNbpxA0qeub3pXCt
         GWvKgSAyMHWqVNr664r3helOSJ7t2RCAoZYwVaNytehiyBM5f9HNQUcF64YT+yMJ3taR
         gCnYeoA1G3Oi2iogwd9Kzymc9AaGraPyjNu3Lo2go+zBShoynwChCtu/xS3T/SUHwYjp
         vFDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrAZHsL6aCRUi/rA6J1Vrm2NQNWIEkdGbANpBsnldMZWWePbjx1kYz/Wtc7gX024PYWX2q1AI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz06AFLZU+cwfnM8+25hI4FzJyPsZ2gyMPCRzztrB3ywGa6MyaG
	9s6kSC2E+0Vn2gDxVg88I6kJX6q36QDRDCbcA4+1Ceggp7H6nUUaidQB028pQvOelL8X/rJDp7D
	NGjVa9jYSZu708DLaLuuIyJSaIJjn8EOdC5hjuaxP
X-Gm-Gg: ASbGnct6R+cg6s9PQeo38BFG9t/q53jCEolQyTNJAUAvFLK8W4iBYBH4NShJshk4J64
	qOy7CRTYercduH5VbThyqjuvtBnCH93RMlMFEishDMELECF/uah2u+art/beiZ0AFSaHkxYNK69
	Q78jKjdIs0Ef9BnmeCaz+pYGF/p/PY/AhtnwrAn45s2z491W7EGeb3lTpswMror6b6JBgQKI/8a
	IMbYfHI17FRM1WnsUF4hL2Q+6xqZlgNWwbTsdxQAhqDonn4DRhfaah/SIGYMqjd1BxD6YaU336y
	VLaoDz1j9XoMPP+QM51ei571Ig==
X-Google-Smtp-Source: AGHT+IEM/TOueMIS9qydvuvtchlFF0wK8cgOc/KXjEJfj7OOC9BHA3+7SvHKRHzkiADi+n6n5wTpWmB5bEJD1IPvStA=
X-Received: by 2002:a05:600c:8b62:b0:45d:d97c:235e with SMTP id
 5b1f17b1804b1-47117876bcdmr95871475e9.12.1760977862456; Mon, 20 Oct 2025
 09:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016040159.3534435-1-kuniyu@google.com> <20251016040159.3534435-2-kuniyu@google.com>
 <CANn89iJnQErC8OLoTgnNxU8MURKANbiqXBYaUHsNaTO3m+P54Q@mail.gmail.com>
 <f93076da-4df7-4e02-9d57-30e9b19b3608@wizmail.org> <CAAVpQUBD5nozg1azwi9tBHXVWgcXBSV+BXSgpt455Y+CweevYw@mail.gmail.com>
 <80bb29a8-290c-449e-a38d-7d4e47ce882e@wizmail.org>
In-Reply-To: <80bb29a8-290c-449e-a38d-7d4e47ce882e@wizmail.org>
From: Yuchung Cheng <ycheng@google.com>
Date: Mon, 20 Oct 2025 09:30:26 -0700
X-Gm-Features: AS18NWDudlq-087ieqYbDOL44pGINaeRCWOwXxD-qtT1E7Qh6rGQr_9FQLQyXls
Message-ID: <CAK6E8=d1GjRLVuB0zmydAepvnZs3M1w+2tCVwdhAzL6rtseJ1g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/4] tcp: Make TFO client fallback behaviour consistent.
To: Jeremy Harris <jgh@wizmail.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 2:17=E2=80=AFPM Jeremy Harris <jgh@wizmail.org> wro=
te:
>
> On 2025/10/18 9:56 PM, Kuniyuki Iwashima wrote:
> >> In addition, a client doing this (SYN with cookie but no data) is gran=
ting
> >> permission for the server to respond with data on the SYN,ACK (before
> >> 3rd-ACK).
> >
> > As I quoted in patch 2, the server should not respond as such
> > for SYN without payload.
> >
> > https://datatracker.ietf.org/doc/html/rfc7413#section-3
> > ---8<---
> >     Performing TCP Fast Open:
> >
> >     1. The client sends a SYN with data and the cookie in the Fast Open
> >        option.
> >
> >     2. The server validates the cookie:
> > ...
> >     3. If the server accepts the data in the SYN packet, it may send th=
e
> >        response data before the handshake finishes.
> > ---8<---
>
> In language lawyer terms, that (item 3 above) is a permission.  It does
> not restrict from doing other things.  In particular, there are no RFC 21=
19
> key words (MUST NOT, SHOULD etc).
>
>
> I argue that once the server has validated a TFO cookie from the client,
> it is safe to send data to the client; the connection is effectively open=
.

Thanks for the patch. But indeed this was the intentional design (i.e.
empty MSG_FASTOPEN call triggers server immediate accept and send
before final ACK in 3WHS). It's allowing more application scenarios
for TFO. Now some applications may have taken advantage of this design
so this patch set may break them.

But the RFC could be more specific about this edge case so revising
the RFC as an errata?

>
> For traditional, non-TFO, connections the wait for the 3rd-ACK is require=
d
> to be certain that the IP of the alleged client, given in the SYN packet,
> was not spoofed by a 3rd-party.  For TFO that certainty is given by the
> cookie; the server can conclude that it has previously conversed with
> the source IP of the SYN.
>
>
> Alternately, one could read "the data" in that item 3 as including "zero =
length data";
> the important part being accepting it.
> --
> Cheers,
>    Jeremy

