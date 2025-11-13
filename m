Return-Path: <netdev+bounces-238180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D3EC5567B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 03:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D19C34E2A7F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 02:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7032F49FC;
	Thu, 13 Nov 2025 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUjVfOvl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C3E2F3C3F
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000208; cv=none; b=n8caDypnOuP4aLqsDqygYFFzfHaeSztF3MNjdypM3aftnDzEyDmaEvzANYgL/CN/d7jNxn0FqrRamxH3AyYawLXisPkiLcbMmKHCRuD7cT6IIL6NP8et7EmYOKRAvbUfFB7iaxcPMZn7Pg+5nZqT3lgmXQId7MHn5xjWmslfU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000208; c=relaxed/simple;
	bh=ZRaD/fmerrjCeoqkuiGO/IO5MiZ5XDL7oIGJfPfg9Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdKtqfZ1SozXcmioODdU5bIkvt5wlrFFe0SeSnMzGs0QyLtCNWw5UD+w6OH4kh3Eg5u7BgevAGmuAwVlhSUMN4E25hwOsjDnEGq+5NsJpCMSeAYkeYqcZSmuviCk6MC8sb7lv3t0rlNviN//d6SCDKS6TlYiz6hz4x8idwUiVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUjVfOvl; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-787e35ab178so3749717b3.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 18:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763000206; x=1763605006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRaD/fmerrjCeoqkuiGO/IO5MiZ5XDL7oIGJfPfg9Ao=;
        b=dUjVfOvl5mUO87tZtRc81Twq5ZvwfdO7PA8zJenEtNbv22JWMiROpkY6iNKzPwwdWo
         kk/IFPOFdyrZhuXogOBTqNaf4xn8U9Pwa6iSt1k6uAgTmVPiP7f/f8zHFcwlz2J4FqRS
         v9DXpPki6a82nS1TDFR/LnDnGGMowihGxAsY3CvdWXIkTYNtIkoOtGJJbVzCr1DyCE6L
         tJVxdKSkeHDAg1WCH5amh3BfQsdnx+0qWpelocUvNV5JDkJhizghjORUkWWhJtnC9c/P
         zCzzHP31HyEU/SKDzxPQNlE2lfaxKaPMYhMmA3XbkCVYI5anA7Pm77NrIxDV4k/nYEyN
         H3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763000206; x=1763605006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRaD/fmerrjCeoqkuiGO/IO5MiZ5XDL7oIGJfPfg9Ao=;
        b=VKCKGdC7X5kXFPQbKVOZ+Ua6oTx5arN1ijgEVkJV/PxVO7h4wlGepk1jYlr0Vx1Qvy
         zf+6FTiiJLsiSrkosAbbk+5/hT88O8wK7X49MsiAxok/lLhaBkWrNeqneeJDUnXZMrc4
         M2Gyz4OYSe7rjRXtcGf8HaV2r+gCogE0xD9VyWJ5tGzScOIEfQ50WP72rYzlEEhTXWjE
         doK6Cq3CcNeW7JyEnGMVCJGVOR60PJ9zm2ForThQQoV3SFWhDVN7MRoslI5F+edZO5Yl
         ozgiY7m0VtPUlvTJQC6b0mQfEi4UqMI/mmcvLEDF7TWRZKXGBDe9FL+u8YrX0CCRkxa4
         ftug==
X-Forwarded-Encrypted: i=1; AJvYcCXOtfuK9zsl/YXh2U4fM+t7g/j8VwABBDaCQCICgg/unlXSxbaXWT0rkyEvw6fEKdTFMY6ThM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPrvxiTzfnr1MRjnL2fEXPN/k8T4TQQ9gzr//fYmIC6SoQVTY
	Q0gfS5rV3oaqlZIqpTKNwNWiJWEznkeZDYnDtdYzNosqYcbfSQfxsgCqgeAmN9oyCSOiLsQShRx
	6323A+74AQWqZCbsQNReYI6K1CGNIQRc=
X-Gm-Gg: ASbGncvj4Za+HbrQDX9E8f/3I+/FGY60/8SH6jGaDPFavRJ86xY//u7dhJ3M06lQ0Zs
	LdxNzG39CRcl8nL8o/QCKd3B9GKvnzjN09DPW7Dj3mZifev4CP5NDVyzF5XIX2l2I6Nje5ZKb8T
	8bdbuyE63ejqK6d9UPvTqoZMgNiLFVtLthgeUs9DxOBf5CH4ygt0B0E0KW3btC7XbX9Ni8AZPgx
	9ZxugxQ5kivFHL+prz+gWl6jV/BK9NMRGMOAkK6xef96c9MT4eNndOz7LGyR39Cz7DUQfwrQL9Z
	d9jncpOxTcH2vaHUTJTpB4W4/A==
X-Google-Smtp-Source: AGHT+IEoQGXbDOXpCMV0uLppel/d5OJBdh/BTOE0WrwFdCg3bNRboPUEkEHpLZDtG4hlmvXsyGaHqhvMoipnvR4oKDg=
X-Received: by 2002:a05:690c:5301:b0:787:f72d:2a57 with SMTP id
 00721157ae682-78813626ef9mr34068247b3.15.1763000205991; Wed, 12 Nov 2025
 18:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-5-alistair.francis@wdc.com> <3438a873-bda2-4a1c-af8c-76e31a200c79@oracle.com>
In-Reply-To: <3438a873-bda2-4a1c-af8c-76e31a200c79@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 12:16:18 +1000
X-Gm-Features: AWmQ_bmGVjeLJyvzqCH0oIhjJJEC9KDxsd28wVqF9yRjrr2nfAiVpGZrrJdTjQw
Message-ID: <CAKmqyKOj_vB3dwy2CO2JacL-w6WSm-2HYHuikndsLfYCQvwZNA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] net/handshake: Support KeyUpdate message types
To: Chuck Lever <chuck.lever@oracle.com>
Cc: hare@kernel.org, kernel-tls-handshake@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-nfs@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, hare@suse.de, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 1:49=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > When reporting the msg-type to userspace let's also support reporting
> > KeyUpdate events. This supports reporting a client/server event and if
> > the other side requested a KeyUpdateRequest.
> >
> > Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>
> I was not able to apply this to either v6.18-rc5, nfsd-testing, or
> netdev-next, so I can't adequately review or test it. Is this series
> available on a public git branch?

You might have missed Hanne's "nvme-tcp: Implement recvmsg() receive
flow" patch that is required, it's mentioned in the cover letter.

You can find this series, Hanne's patch, a few other patches that
are all on list and some extra patches I'm using for testing and debugging =
here:
https://github.com/alistair23/linux/tree/alistair/tls-keyupdate

Just remove the top commits from that branch to get just this series

Alistair

>

>
> --
> Chuck Lever

