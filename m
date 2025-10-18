Return-Path: <netdev+bounces-230700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39167BEDBDB
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 22:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F39ED4E2444
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 20:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BDB27A103;
	Sat, 18 Oct 2025 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CH0aNq0q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF261922FD
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760820998; cv=none; b=ZajdQ8RFAQxjUvlYLrSTDO2OmfoGoSR2zoluq8xH9cgMedkcCVvNcs066QcNbb56U9BOWAiPmAInoCJZdT4OIZpFZJsiz67wsmQfAUIUxLJWYefXyw9tL1nih5y/FlTk8cIQh/7rRCqN075IsWMPPUbNadGZC8wqCjEDO5W7PrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760820998; c=relaxed/simple;
	bh=mx87aQaoG7YEPe8W8M290a73Mwy67hpak3CS5HQ/kiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taBKr+T7yaTd6yKmYCq+4Po6pWSrGMZ9p0y9H2OtheF0WeAICxPVDkqYXS0eDfYN0538U607eP2CZ2JOf779oQ6gyjFitP0fwRbo4/mLlE5kIhsjklI/+8SCFjdq91qpHVjojCmECGQFEsM4UGRq3zBBEqYvr8ocsmU6iFp/ROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CH0aNq0q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290a3a4c7ecso32965085ad.0
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760820993; x=1761425793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHTVjfWqnmsKW24xBByKvc9ue3Owpq7XiidAEoNCrbE=;
        b=CH0aNq0qSdPutJb3hjSqcgDKmRbDGQriz9XUy8pV2WRf5AZZHdM2+Vto9tAJIe1j9g
         Hp0IijFAlhPca7aCVjhCaQlZZpWO+//vlkyG5m13J852r4Fs6WPbBboXIURDOqujwNi4
         sK84cmiRGXWmxRb0pCTEVohC5/7dEi9+yQMfIac5f5G1IW10iHteaczkXFQtyQG94+/P
         khieA2x7ToP5dH+XnSZmGKebmivPAybNWWFnFAFPWxPeo0bwyK91BXZvUIMyiRyBkFf8
         RTenI8P32ZSNCEVjsi4fY5P1qI7ecJqxK7i2xRXe9oBIwlnID2OXcHgmdMCyC5Z4+J+4
         bOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760820993; x=1761425793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHTVjfWqnmsKW24xBByKvc9ue3Owpq7XiidAEoNCrbE=;
        b=LSIHo96tjbv5JuNbxLMuMMjdWRMUOpeCo281VJroy5UJrp05CrY8lovYqmHy7pDGzT
         nXszs0lkewQvvQhTr9p8rL5Gx++zaJ56j28YXOmjjnwlG99/f6ZB716ir1GIthAy1gIz
         OeEpc9X0oROceWWufTmA3+pzf7cP1cihR2DzJuVIN24Nsn1sSfJ73nnpOLHtSwJe2su1
         pmNkRRILJDQk2cWqnbR8JbjjtXOEqSzSryGR0nr+KAShTsevI9EOJjij9HdCVLT1h+aW
         i0zpHSxL6jJU8X9u9Ee0u+c9T9c+jpYYG47Bbsqov7ZEG3BHeaGgpHz3D+g+9boYM4U6
         Ypzg==
X-Forwarded-Encrypted: i=1; AJvYcCWmOVbOTS2diagsxE0v5olVqT9QKjwY+1rpNMVci6p4nQmgUfZG5OMY8exNZBqAYYjza69DHpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK5JHc/EgeQWBuJKA+zV4MFs72ftQ0/VNUeX39MvcSTmUSMthW
	/mOW60kWuaLDiQBe4fRaGdIrY4YnQzi/BQW7fRAAi922jm53PaYFfD8zC1oOom3w4q3+autf3QN
	6kuHAWnXVChwPWAMc1bm3UsWL1Gkrytd77gBxIQ2B
X-Gm-Gg: ASbGncsCQ1o28/ecoaW/h3yakORJigYhnrzKfclZ0DaS3atdY1Jb7dKR685o3uo6tsf
	OUq6gjj4puT04Hl532GR/h/l24T1RhyyAkM3qRTOVbyrzNG88riKOR07C2uh8sGWWySTLJluANA
	nAd+5pDWupSlBC0o+OOLBzSjgfMP+WsqHz1N8tUif+R+la3BgdgIGxIxH9vLRWdrFDcfwdX8bIB
	f6LVm9ZjDB0qaq2IUzkbZdCmuS1m2AGfneE9+hm0MinGEgXKCpW2a7KdYJQ3sxAW4Ddfb3+3O2L
	dY6Utx+faD8Ix921
X-Google-Smtp-Source: AGHT+IELz3ZUDAwIfAz2iwJby/PrGvRbwT+Bp22CE9pgmFNg/lc8xCstawwdUtN/HglrlpUWn9GxGjsigROBg+a4Vs0=
X-Received: by 2002:a17:902:d490:b0:25c:8745:4a58 with SMTP id
 d9443c01a7336-290c9c89c8emr86800625ad.3.1760820993315; Sat, 18 Oct 2025
 13:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016040159.3534435-1-kuniyu@google.com> <20251016040159.3534435-2-kuniyu@google.com>
 <CANn89iJnQErC8OLoTgnNxU8MURKANbiqXBYaUHsNaTO3m+P54Q@mail.gmail.com> <f93076da-4df7-4e02-9d57-30e9b19b3608@wizmail.org>
In-Reply-To: <f93076da-4df7-4e02-9d57-30e9b19b3608@wizmail.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 18 Oct 2025 13:56:21 -0700
X-Gm-Features: AS18NWAX2a9ZvXersvQ198xrTts_Ayj4YTl4r0UFDRg9f8CYZ8GEa9X5q5qQCgw
Message-ID: <CAAVpQUBD5nozg1azwi9tBHXVWgcXBSV+BXSgpt455Y+CweevYw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/4] tcp: Make TFO client fallback behaviour consistent.
To: Jeremy Harris <jgh@wizmail.org>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Yuchung Cheng <ycheng@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 11:41=E2=80=AFAM Jeremy Harris <jgh@wizmail.org> wr=
ote:
>
> On 2025/10/16 5:10 PM, Eric Dumazet wrote:
> > On Wed, Oct 15, 2025 at 9:02=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> >>
> >> In tcp_send_syn_data(), the TCP Fast Open client could give up
> >> embedding payload into SYN, but the behaviour is inconsistent.
> >>
> >>    1. Send a bare SYN with TFO request (option w/o cookie)
> >>    2. Send a bare SYN with TFO cookie
> >>
> >> When the client does not have a valid cookie, a bare SYN is
> >> sent with the TFO option without a cookie.
> >>
> >> When sendmsg(MSG_FASTOPEN) is called with zero payload and the
> >> client has a valid cookie, a bare SYN is sent with the TFO
> >> cookie, which is confusing.
>
> > I am unsure. Some applications could break ?
> >
> > They might prime the cookie cache initiating a TCP flow with no payload=
,
> > so that later at critical times then can save one RTT at their
> > connection establishment.
>
> In addition, a client doing this (SYN with cookie but no data) is grantin=
g
> permission for the server to respond with data on the SYN,ACK (before
> 3rd-ACK).

As I quoted in patch 2, the server should not respond as such
for SYN without payload.

https://datatracker.ietf.org/doc/html/rfc7413#section-3
---8<---
   Performing TCP Fast Open:

   1. The client sends a SYN with data and the cookie in the Fast Open
      option.

   2. The server validates the cookie:
...
   3. If the server accepts the data in the SYN packet, it may send the
      response data before the handshake finishes.
---8<---

