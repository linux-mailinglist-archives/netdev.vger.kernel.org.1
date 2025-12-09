Return-Path: <netdev+bounces-244167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8099FCB0F93
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 20:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA566305AE71
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 19:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46EC307AE9;
	Tue,  9 Dec 2025 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zrfirogA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7D302CB0
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765310123; cv=none; b=r1+9xaVFeUlSflKXaw3Ia+NCyYSmac2z3iLmHTBbPPtsrP3NndEu4uY1zWVM98vG/gdyNBls9cWwMeweUweNVSaFyTyzy8jXLlJQbKB2v5Kw1fDbyuY/Fduzx9duRv6SyzRUWOQU8ak/yRxXbmY809yMkgRpL21AajzwdLAoIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765310123; c=relaxed/simple;
	bh=0eGrB3f7xFqga3zVUes14rwFnowv3DUJ5vt7vr9GRdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wuk+mhlxmtOV/tma8iIwpRGqOnPdlJY6VXcP+fGvYNnAN8CeXPk6PULPqmtDQGrgzTtB1gysKPAl+iOR6pj4Gkm/P4VSROiymNz99UZAOW2EFOCw461vGmP7fUBh0VHnIHWnfdWEybocDfOlWI4zZY1Bv4XBnS13r8myICWqpFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zrfirogA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5942f46ad87so1631e87.0
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 11:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765310120; x=1765914920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+RBf8HywqFOs8is8n1gYXR3AwZl2+4K5ckOabIP0pI=;
        b=zrfirogA8aazMPJ6++jdL/wIMZZKiMVvdMrp29NQQAz2kLR8zvLLUJ9hjXwsGY8vzK
         g8pABgqE3N0Q99FvMNHZGBHG5TkORREOHehUZLmM+A4zr8K425RRHe8c8dCQJmJlZbum
         OetkMVCBBEE87PR8Kck4iwDRrzjbzaiAcsPUU+SD6mic/mo9XEBuqWJZiK4mOvWdQZVz
         /yFOtTSb+kXfTKQe02OHNSCin2gdSQJCXuxQSyx1y2BBpHMzfMWMIMPJHoaMZLRoWLsW
         k+jHFfwqdo0c5tr4p4VHwuDuz5XKfQCLJKmyUot9QtNkn7wJ7Du2VBhPANEaShRRL9hH
         nazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765310120; x=1765914920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+RBf8HywqFOs8is8n1gYXR3AwZl2+4K5ckOabIP0pI=;
        b=FLEZaYzgqpopF0zzifOg+5LLCVi23PnoqGeE1xNqTuqGcoNvqsDvI+dvhrVUEc1CZ2
         nSsY1Wag0QsnF6zQmJSl1/nXJ6luXksl72LUIxV/QUMrHds9UVfa2M5wwAoGh1iUH4yu
         idQlUo8b8GveVZx4hH2lDc8ZsaFYYNVWJ1fU7QBIvo7jIbUaFt16I5ByxLwn8RH4i6bW
         ccmgzwnIV3QZzK6ztE7eprk7HJ9jqwgKpj7jRS21uabvrOJmVB4LASTd1HySWIUr1RmM
         RLNwPQTPLghyw26BsGKiob/z/fMiEhFff9ju/5E6mk8eyy0PNu76n6JCzZP91OEhVOP7
         cE7g==
X-Forwarded-Encrypted: i=1; AJvYcCWA75MGQirOqY0xH36ROQSClVwjQ6jFxc7TakEdSANFygU/zUgWI8vV5lOcSC68ruIitrGadZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywos58G8pUDj5MUdjf2yWhOdJqbuLoiTvd+j4cjyB8dTaWoN0jh
	enGvLWukNHvmDcIOI+xSfesLDc6Q4hoLthEfcbsVvKmN6sOwdAgisENLUwL+KnkaMwvFQDgmGxR
	gaWcxs7H3DflTb2fP0DYTTo6FxL4tS+hTz53CQPaS
X-Gm-Gg: ASbGncuEUpAeCY5xfC4xKGQfe68j/3xa8cwqgzQ9GrUiqNOf7ppBrlnielqrdXRHFp0
	/30bKkA1NVLD8O9pWul68vTEwRAXgJCCAeagUq1YKgkmo15bQOjAK9tPFs4O//jiPHzPGgKAwIg
	Sw/tsMhi0Nbbm6W/0+sJSuNeHMUFRXwFIF/21fmv00NNaDxjp+54yJ1xhE2m7GxvKdrLR6tV5U1
	BQDgKPTg+EGhm4IcatQpRuTaBpMgpz3hBsBgHJ/fNJ1bvrDLLSLDybriCr1j6AtJqkQXhYwwx6l
	EWmelHK6xtz45vN5MavD1JkAnxVfpjuOvXtE
X-Google-Smtp-Source: AGHT+IGuhy2c1WoNaDo9yFzzcMM4wWUTw3FFxFrVQBL+cYcgewzWi0uZXQ3wZXqyYkHB8UE1Pe90fyZ3dkNBjdEdl1s=
X-Received: by 2002:a05:6512:154f:20b0:595:9b2f:1dd4 with SMTP id
 2adb3069b0e04-598ee30927fmr562e87.6.1765310119583; Tue, 09 Dec 2025 11:55:19
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
 <aTh9/waV23uRZc9E@devvm11784.nha0.facebook.com>
In-Reply-To: <aTh9/waV23uRZc9E@devvm11784.nha0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 9 Dec 2025 11:55:07 -0800
X-Gm-Features: AQt7F2otnRUBenjt4JJtgI3V8rfSk5ICp-r1g2bzqOO9K4G5rKMrxzIjxam7SUE
Message-ID: <CAHS8izPm22VoGCv93q=_nGhqOUR3R0JzVpYW6u0EJVxJJB-5Ag@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/5] net: devmem: improve cpu cost of RX token management
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 11:52=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> On Wed, Nov 19, 2025 at 07:37:07PM -0800, Bobby Eshleman wrote:
> > This series improves the CPU cost of RX token management by adding an
> > attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> > binding to avoid the xarray allocator and instead use a per-binding nio=
v
> > array and a uref field in niov.
> >
> > Improvement is ~13% cpu util per RX user thread.
> >
> > Using kperf, the following results were observed:
> >
> > Before:
> >       Average RX worker idle %: 13.13, flows 4, test runs 11
> > After:
> >       Average RX worker idle %: 26.32, flows 4, test runs 11
> >
> > Two other approaches were tested, but with no improvement. Namely, 1)
> > using a hashmap for tokens and 2) keeping an xarray of atomic counters
> > but using RCU so that the hotpath could be mostly lockless. Neither of
> > these approaches proved better than the simple array in terms of CPU.
> >
> > The attribute NETDEV_A_DMABUF_AUTORELEASE is added to toggle the
> > optimization. It is an optional attribute and defaults to 0 (i.e.,
> > optimization on).
> >
>
> [...]
> >
> > Changes in v7:
> > - use netlink instead of sockopt (Stan)
> > - restrict system to only one mode, dmabuf bindings can not co-exist
> >   with different modes (Stan)
> > - use static branching to enforce single system-wide mode (Stan)
> > - Link to v6: https://lore.kernel.org/r/20251104-scratch-bobbyeshleman-=
devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com
> >
>
> Mina, I was wondering if you had any feedback on this approach?
>

Sorry for the delay, I'll take a look shortly.


--=20
Thanks,
Mina

