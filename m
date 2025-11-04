Return-Path: <netdev+bounces-235515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 214AFC31C00
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 16:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B94B18C6A02
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 15:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655AA24C669;
	Tue,  4 Nov 2025 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmVKbJdp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0A244679
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268707; cv=none; b=q+X6S71VSgRYlVPD7yO82+rrm6u/5cjEXbYkvffZtxmsi5nK8mRm1AlGqcniCWFi0lGIWiTCGi6m7cJHPqfaRqxwJhr5iVpUUfuPglN26jlVfDYMoPpkyi/cKDaI+Wu8ut3bFL8nSf+D3TXaNiktSxRQ+u7RrFaIfBsOtaj4igg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268707; c=relaxed/simple;
	bh=cwPu1H4ZKjGzPG+km20RpnlT5kiz4rAex8/UOBoTR2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKXtaG+lfojYLgFIUmQBKmI8if775tRwHoZYoIXHRb7GiPNuy9FQKULChfNe7vtS1Q1F4+rBXIIJtovT2Tmz7+NwUE2+pH7s5AdZufbAtSd3BweXEa6T5s0IQCm/9eEn7fIlEc4LcyN80nTgdQW1F6JMeNZ6aRd++260vwn+ZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmVKbJdp; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-89e8a3fa70fso463970485a.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 07:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762268704; x=1762873504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwPu1H4ZKjGzPG+km20RpnlT5kiz4rAex8/UOBoTR2U=;
        b=RmVKbJdp0HhYl0K4Y7Mt2NEsl9vPeBEpQx2PiLlEKoLdC0gAfcGG68HLMeZk/dKJ1H
         I4H6su3VUhhOPp7LaUzRthDSTr0J4GHU/rUsWSbMhv/oiT8a6hL0uTvkwZUFnBpurhpA
         j6ege8XAYUI8iwdBFQqGYAB1lWzx4DC/vQ77/K2y+xvmRJlWKUImO7IMjAyvagtqEgR8
         NaXoF/NHTQLZhKBGNQZrJs6emY6GMJfEI3gwUO4113xfFCVEsfJKm1ruJtXL3UwFDlbT
         tfI3YtN035hw9q6AZLN09yvC1vEqAf+9JTh8yNE/qZDRo3j3OtlcxBPvUw0/Ct3A93GX
         tr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268704; x=1762873504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwPu1H4ZKjGzPG+km20RpnlT5kiz4rAex8/UOBoTR2U=;
        b=rV7RPjq/7n9CW+L/01fmtgwM25T0VAppmFLzxtEv0gp9yBTRpJuK9sg58gRO8f8IV6
         uo6iktnrfcZSqQCpaMci8QuyWBtL39unKuAQFAEqxU9dLpgkjjzsXZ+z3fMCF7Y7xguD
         O2We8uWI92JrS3TJKP2ccV9ZTCaEUKqcNDnGEmyWDsduYHHAnfBAMqDrpFvxXlVIXVMs
         dvI0a+u6+eHXvyQ8YQnZMJCMBc5CrYb5NZ1LRbTxKxRTm+qxFZWY6klUpdFEktaJOo/f
         YUGBO761BXeTZix7RGO+VfxMDh8rkJ2xHa8P3OCxaIru32WBGTGXE57rvvBhXNOb0lKt
         aGDA==
X-Forwarded-Encrypted: i=1; AJvYcCVfqN1eOguzP1p3Q3ENf+OGMwPk5zCgYnMcy2rpdSq4FrHAfjoUenUU2LlLXcObxOU0LTpRr1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywimq9HdrN+rvKaHpkN5irfbkCfiAxGfS6qdaYo5eDbcvYABoXg
	S1qW7nyDzaadOVHddIsTWwBe6ub/v7Xw1tY7rJRuu6zcQtKOoqlmgEGEL+M5O8D5VbUTW05v8W+
	wuSb1u5Bu6ygZGcXIRyk2bf/fTNnZB/zlpl5EBkCecUIGaGnXAXlpIvkbCNo=
X-Gm-Gg: ASbGncv7wWUhUalAFbxkdWW272qiUaslaS39B4eYPTJd1CctgxX37mEIz/91A9elA0Q
	60iV1B1S4pXe8mFSKz0drd6CGRg2NVYiK0IuDUVGK6VWbbRpigjF5weIvtCR6EAmZuS9G3m7AgN
	dfojD/R0Px4vOzVRa5atydV9w8bnXKdoXyEj5Mumd+6b0Uypgtk/TTqQUM9qZC31UvEQnxeiVgB
	Kmn8/n6tA4auTyh1pZ//Wg4OKKHH7xvg1pxpT9HUk0fiG1vtiNbT6Kuuwke
X-Google-Smtp-Source: AGHT+IHSrTtiiSwZoyqLSYpCgA6kSquvnXQeGH7yjihO3hWS2cXF9MlyDir7aymiAMp2pn8urxoEpCz+a67PZV3to1M=
X-Received: by 2002:ac8:58d5:0:b0:4e8:b980:4792 with SMTP id
 d75a77b69052e-4ed30e12cbcmr196277331cf.37.1762268703930; Tue, 04 Nov 2025
 07:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E3B93E31-3C03-4DAF-A9ED-69523A82E583@akamai.com>
 <CANn89iJQ_Hx_T7N6LPr2Qt-_O2KZ3GPgWFtywJBvjjTQvGwy2Q@mail.gmail.com> <aQoQ9pEKia_8Uuzi@krikkit>
In-Reply-To: <aQoQ9pEKia_8Uuzi@krikkit>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Nov 2025 07:04:52 -0800
X-Gm-Features: AWmQ_bm00Y4lDc2gvkTLAB0jD-NSXdm47k6eRZMtTSeg9FQHqj3mihN8Xh7NFiY
Message-ID: <CANn89iJaUgXMApeS-+Tbq4-48dOUESmpzEMW21mGkQi-0CahpA@mail.gmail.com>
Subject: Re: skb_attempt_defer_free and reference counting
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "Hudson, Nick" <nhudson@akamai.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 6:43=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net>=
 wrote:
>
> 2025-10-31, 04:43:19 -0700, Eric Dumazet wrote:
> > On Fri, Oct 31, 2025 at 4:04=E2=80=AFAM Hudson, Nick <nhudson@akamai.co=
m> wrote:
> > >
> > > Hi,
> > >
> > > I=E2=80=99ve been looking at using skb_attempt_defer_free and had a q=
uestion about the skb reference counting.
> > >
> > > The existing reference release for any skb handed to skb_attempt_defe=
r_free is done in skb_defer_free_flush (via napi_consume_skb). However, it =
seems to me that calling skb_attempt_defer_free on the same skb to drop the=
 multiple references is problematic as, if the defer_list isn=E2=80=99t ser=
viced between the calls, the list gets corrupted. That is, the skb can=E2=
=80=99t appear on the list twice.
> > >
> > > Would it be possible to move the reference count drop into skb_attemp=
t_defer_free and only add the skb to the list on last reference drop?
> >
> > We do not plan using this helper for arbitrary skbs, but ones fully
> > owned by TCP and UDP receive paths.
> >
> > skb_share_check() must have been called before reaching them.
>
> Do you think it's worth adding another DEBUG_NET_WARN_ON_ONCE check to
> skb_attempt_defer_free(), to validate (and in a way, document) that
> assumption?

Let's see first if Nick Hudson proposes a working patch, with some numbers.=
..

