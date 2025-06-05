Return-Path: <netdev+bounces-195314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B230DACF7FD
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 21:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC25217AAC8
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 19:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCFC27AC3C;
	Thu,  5 Jun 2025 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGYGP+v2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E94315A
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151842; cv=none; b=TNwqhiy/Tf/KhFyXKbp4pAKUMwjJGdzsX129KvexWFeHI3BkLmec32SGhmKh2B5AFQiX9290e1sNUmPFPZ9ze42tDg7WlnoqrmHDQffOuqV/4DEFT6fd9DBgn2HHBOUsOL1KFEz4zvFXoxZbcuPuT9fIsctQgc89VBt9y+B/R8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151842; c=relaxed/simple;
	bh=4bez/oFMMRphE1ZaETQJAwo7TME+jkXPNxEhPzOy0tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQbozdWZwZBuJXqrtPiCmtqZrBSGFYGZuZB/kNjZCvqCl/J0klv0DZXRv9nOfe7iUPWMoKENegfg/aZ2IsrMM9sg6guQ/DzqXobhRf7w4/WzjseonRRP46X58aZ32iiFqcoJ8zZLES9XhRnP10OZ0eVLFAHJ1Smtmg2a7/rAFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGYGP+v2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2348ac8e0b4so2885ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 12:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749151841; x=1749756641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pN1olzhc8CpHBBm4iUpbGCBLbnl4LANGlw1FJXE83E=;
        b=hGYGP+v2rp8lBIffCv+VW6n3O8Rweti5x1P/BVoChKJoNn91UkyR3LuE6SMUtQA54s
         SYH7bzTN2bDm8mEq7woSBRbwJ399Ip00zxZrnqW2SYQQhQjzug4CuhUoszlUp80bCAc1
         NEXvVOTTK9SThrxDj02ywQo4F/bO8HY+6Hpw6kmdiMPVahcxibZuJvBr4JbpxhTDlpZ/
         rbr0N9EoN/YONEc0l4K9ldbAxI1dBMHBLdgbZ9sQ0DLL7S6iAdj5BIDqBmpxAQ6rOfO/
         Z1fdXWFjjUTOgMKIDyNF+JYuje/KS/MhfPoywTV/w/fg19bm9FlNCLeXYsYdpUMrOisK
         mk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749151841; x=1749756641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pN1olzhc8CpHBBm4iUpbGCBLbnl4LANGlw1FJXE83E=;
        b=Xj2OrVXON2Sl9DNAJvM4fam0IMlJtQpc4qpgkToA5LMZr+rDi8WL6srnbRbUDnuXlB
         lAiodyT4XQKl4dMxpq8ZbKAb+ZD8NVCm5+oafBaoPepSGWsbyviUq7jZX0cH9ctvGg4T
         ibBnBb3RlkhubkFMHK/hFuBtQsHvf6oIX9lOdqCbh+YjR1XHSbpJfaGwQBG5u5VOwIKr
         xmFKGDclCqEvm2OohmDFa9e+sMaBS/QigHpVpVUt6+SxwkMqUtHyAbCn+Lh8gZyFHxOF
         Zmsh0gRGtav07MTU96DtPZP4jMJPki5/4kiOp+TWRvZ1OfzrruYilQOn9+X0/Hk3HsHR
         Q2Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXkc9QF6b3IOQBU6gFNInt5Y0zNDqKFfT+SM2cM6x7Wc0vbjiXbbO35S+foSWnyJxjZfgxBBk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKnZI2C4ufyaXtI1TEtjgaQoFPmjzgOIZzxQPA5fi6mnze5qsT
	G7OCG7Wh5mqci60ZHpw+wjv7O2rTzfM69/RXcBjjsHoZWER4XXmo2D01XcYF5aJpOfV1HRDPOx7
	Q0oacv522xFJD9i5SwVsEtVwcTmwChvVpuLlQYVgX
X-Gm-Gg: ASbGnctElnC4w+rnk91zrvbHnlpUgtqINOYjc1BvATbZLpQX/fEGUDrs5u+UfJ9DcPs
	eRbWOqPm9eCR4oCZHJ5zN7UMCy0n0nK4N4mWYd/ko8Or27BiQjzkOfNMEwJnikZ5blbtsBMaq3X
	tZ5a9Mf2s7v9C0p2Kdc1NlTYiaxFK1XmWzy0v0Or15zvgS
X-Google-Smtp-Source: AGHT+IEZUo2qBBR9yZ8J8CWB7wPiYJhomLFn0SMyc3wIzCJ11kpp39ohznAmygfJ0IG/GUGi77IY7bYTMNdUf1wHq7Q=
X-Received: by 2002:a17:902:e747:b0:216:7aaa:4c5f with SMTP id
 d9443c01a7336-236024df8e3mr312825ad.3.1749151840320; Thu, 05 Jun 2025
 12:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHS8izMMU8QZrvXRiDjqwsBg_34s+dhvSyrU7XGMBuPF6eWyTA@mail.gmail.com>
 <770012.1748618092@warthog.procyon.org.uk> <1098853.1749051265@warthog.procyon.org.uk>
 <1099957.1749052763@warthog.procyon.org.uk>
In-Reply-To: <1099957.1749052763@warthog.procyon.org.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Jun 2025 12:30:26 -0700
X-Gm-Features: AX0GCFtaQpHTxx8RriEcyQWAS8xO0zGQ8-djOws2dAzyDrQGK3gSIIJKsqf3Vq4
Message-ID: <CAHS8izPOonh6E3B+xHRSsfXpo_jHXymVyNOZOUc_1LjOtT9wow@mail.gmail.com>
Subject: Re: Device mem changes vs pinning/zerocopy changes
To: David Howells <dhowells@redhat.com>
Cc: willy@infradead.org, hch@infradead.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 8:59=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> (Apologies, I accidentally sent the incomplete email)
>
> > I think you need to modify the existing sk_buff. I think adding
> > a new struct and migrating the entire net stack to use that is a bit
> > too ambitious. But up to you. Just my 2 cents here.
>
> It may come down to that, and if it does, we'll need to handle frags
> differently.  Basically, for zerocopy, the following will all apply or co=
me to
> apply sometime in the future:
>
>  (1) We're going to be getting arrays of {physaddr,len} from the higher
>      layers.  I think Christoph's idea is that this makes DMA mapping eas=
ier.
>      We will need to retain this.
>

I would punt this to a follow up project. Currently the net stack uses
pages extensively; replacing them with scatterlist-like {physaddr,
len} sounds like a huge undertaking. Especially with the conversion to
netmem_desc happening in parallel with Byungchul's series. Just my 2
cents.

--=20
Thanks,
Mina

