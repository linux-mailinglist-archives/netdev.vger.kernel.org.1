Return-Path: <netdev+bounces-211265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E3B176AE
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 21:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1507016B2E1
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007D2222D7;
	Thu, 31 Jul 2025 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTwxR9K7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4F22A1E1
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753990473; cv=none; b=c3YisDOpD16p4/xbQm1bP+YrYIJJxc6cYtExQbK5CqJOb2kxZfKF+/GnD4rFD9ggroyr0GFo0jE7G78V+CUwKdR9uK/Jrz0Yh9ICKPx+eeJXBAm/YG4erM5CbBsB0J419eMeopQPK07eaukWymscBIYlQKGKVvrFDysKLPPftDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753990473; c=relaxed/simple;
	bh=Kp8+2naWJ1N4EH65MCR9LXz422pGMuaIyGeeJog46NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaeXSSK17jv7oluBnQbyNZUZ77rkE1Af2Hez1m4sVAWM/JeuiBMMHjL5kzjET5lEQURUma0WUJfYyaPxi+MNcD4ODAhPb7huTTu+5/8XOR2YqY2ddCp2eRbYdsjUtSHV07ZIVyEzCSE+HV3NdYS+LnwgwFBWE23Lf+p5uYTrHA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTwxR9K7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-240718d5920so38105ad.1
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753990471; x=1754595271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T06R5HqpDwsoDzNyfd2pgCLYo7gUEXK5DmZqcx9THVg=;
        b=MTwxR9K7MDlnlsD2K+1Va74EK9xAzaBc2T3xjLiqd0v5OsyBloQWWsdt2oxEICBDuA
         ZlXd6SGsmbCcFhFXI3ogvTFvd/2SR5nFCdblqECFlPlHjEz5Qq2kq1iEWjd4JsTClw2x
         wW7bu1i94K0OPH2JwGlvDefPE0KvaWH/gHfnOOiO5VSRFsrZP0MguclEjFM0ZFfUUHvS
         nKEhuti47f5xL8Tasu9uWCQoYm5C26PCHX3Ly3kvP3Qujhg4g8PMQzkuu9o8yyxOgd3x
         zMWzSk+x6masIzEVsA8y8KTGcbdPRSzSBlOn4G3iOOYKyL9oTcFHKz/B1DE/GPg/BjqA
         Wz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753990471; x=1754595271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T06R5HqpDwsoDzNyfd2pgCLYo7gUEXK5DmZqcx9THVg=;
        b=VqNMb6+i2bmsNng/yZk196rKzWApDM1CnvWAPlvEfBouCvpu8qVCVU2Yw51VuQFzve
         83VWKnLhn/Ths/EztnR3v9SUn6PD2ZgRnQc5RqWkp3GAqGs3p7COtFfqxRKXgwArBrqk
         C5PnHHuxkVWJDInYFdAemU1UB/CuuuPVuFD62/X8683AxV5VfXuNW1izKPgrJxopHmPD
         kPRZZfucVMzPQn+fOthq93ZAEkDoA6E4xZrxq1MXPY7C1YaRF3vBSkybvDY3ljLqkyyd
         1SvyvhOU8Bs4or7OD8xoQ0Tq/9/TMHrFUX65jgAxmg/M0wrT73ZtkTVOHyXFe9SDo/lZ
         aByQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5IH0YYiE5XDmS3ILo1L6uU4/7M5t3ZSpzj/Kgd5OxjD9HStrSYuGHslHfl7sYLbm+ScByldE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweUjXavHbMxLOQ67kA5WpCM0T5QzK/R2qb6bzsMZbe1euRrglr
	zQASQuqmoudGxHCdASaVkb+iI3O3SB8dk3w4hxKQlRnIBYhUD+1v2Y4IDZaF8IXcd01WHGqlh0A
	BAoQTBoY4p0B838ekDgtaEDLoutqWjq8TrWxdXGNh
X-Gm-Gg: ASbGncuMdXvmX9QWHVi/jvLM5jkKSF+f8d+FOgjaWHJNHfsr95Wbamv/oqkf0mFAUEW
	pKjd14Qea5UHr+niCONrxO8Tz52Xr1cQehrELqh1lG7Jqzko7Jw4OcbYQpmpATuob6IJ8MH6Muu
	bGKSmahRPGu5QR+A0L1X4dTBDLeL6cFTt26AaYO47d91iHL/e3wGZnnq05fEqOABbi5J/fwK5Rn
	D42+5EMKyKsgG1wFuv0DE33iLqoNACXtco=
X-Google-Smtp-Source: AGHT+IEh5BMcpRAg5aLbK0lkZX7HFQ/+58C+lSOdc6FR/ZI+seKQlN1f232UGbxPwvovEJfv/LITvZUnfPDDi5YxVFo=
X-Received: by 2002:a17:903:2352:b0:240:4464:d48b with SMTP id
 d9443c01a7336-24227bc725emr668465ad.16.1753990470602; Thu, 31 Jul 2025
 12:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753694913.git.asml.silence@gmail.com> <aIevvoYj7BcURD3F@mini-arch>
 <df74d6e8-41cc-4840-8aca-ad7e57d387ce@gmail.com> <aIfb1Zd3CSAM14nX@mini-arch>
 <0dbb74c0-fcd6-498f-8e1e-3a222985d443@gmail.com> <aIf0bXkt4bvA-0lC@mini-arch>
 <52597d29-6de4-4292-b3f0-743266a8dcff@gmail.com> <aIj3wEHU251DXu18@mini-arch>
 <46fabfb5-ee39-43a2-986e-30df2e4d13ab@gmail.com> <aIo_RMVBBWOJ7anV@mini-arch>
In-Reply-To: <aIo_RMVBBWOJ7anV@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 31 Jul 2025 12:34:18 -0700
X-Gm-Features: Ac12FXz4pVwMESZ6NfAoxj_XHXadYmC5pDjsmNdtqD_xpVMur91xQMwYVfuU530
Message-ID: <CAHS8izPYahW_GkPogatiVF-eZFRGV-zqH3MA=VNBjw4jfgCzug@mail.gmail.com>
Subject: Re: [RFC v1 00/22] Large rx buffer support for zcrx
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	io-uring@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Willem de Bruijn <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, 
	horms@kernel.org, davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 8:50=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 07/30, Pavel Begunkov wrote:
> > On 7/29/25 17:33, Stanislav Fomichev wrote:
> > > On 07/28, Pavel Begunkov wrote:
> > > > On 7/28/25 23:06, Stanislav Fomichev wrote:
> > > > > On 07/28, Pavel Begunkov wrote:
> > > > > > On 7/28/25 21:21, Stanislav Fomichev wrote:
> > > > > > > On 07/28, Pavel Begunkov wrote:
> > > > > > > > On 7/28/25 18:13, Stanislav Fomichev wrote:
> > > > > > ...>>> Supporting big buffers is the right direction, but I hav=
e the same
> > > > > > > > > feedback:
> > > > > > > >
> > > > > > > > Let me actually check the feedback for the queue config RFC=
...
> > > > > > > >
> > > > > > > > it would be nice to fit a cohesive story for the devmem as =
well.
> > > > > > > >
> > > > > > > > Only the last patch is zcrx specific, the rest is agnostic,
> > > > > > > > devmem can absolutely reuse that. I don't think there are a=
ny
> > > > > > > > issues wiring up devmem?
> > > > > > >
> > > > > > > Right, but the patch number 2 exposes per-queue rx-buf-len wh=
ich
> > > > > > > I'm not sure is the right fit for devmem, see below. If all y=
ou
> > > > > >
> > > > > > I guess you're talking about uapi setting it, because as an
> > > > > > internal per queue parameter IMHO it does make sense for devmem=
.
> > > > > >
> > > > > > > care is exposing it via io_uring, maybe don't expose it from =
netlink for
> > > > > >
> > > > > > Sure, I can remove the set operation.
> > > > > >
> > > > > > > now? Although I'm not sure I understand why you're also passi=
ng
> > > > > > > this per-queue value via io_uring. Can you not inherit it fro=
m the
> > > > > > > queue config?
> > > > > >
> > > > > > It's not a great option. It complicates user space with netlink=
.
> > > > > > And there are convenience configuration features in the future
> > > > > > that requires io_uring to parse memory first. E.g. instead of
> > > > > > user specifying a particular size, it can say "choose the large=
st
> > > > > > length under 32K that the backing memory allows".
> > > > >
> > > > > Don't you already need a bunch of netlink to setup rss and flow
> > > >
> > > > Could be needed, but there are cases where configuration and
> > > > virtual queue selection is done outside the program. I'll need
> > > > to ask which option we currently use.
> > >
> > > If the setup is done outside, you can also setup rx-buf-len outside, =
no?
> >
> > You can't do it without assuming the memory layout, and that's
> > the application's role to allocate buffers. Not to mention that
> > often the app won't know about all specifics either and it'd be
> > resolved on zcrx registration.
>
> I think, fundamentally, we need to distinguish:
>
> 1. chunk size of the memory pool (page pool order, niov size)
> 2. chunk size of the rx queue entries (this is what this series calls
>    rx-buf-len), mostly influenced by MTU?
>
> For devmem (and same for iou?), we want an option to derive (2) from (1):
> page pools with larger chunks need to generate larger rx entries.

To be honest I'm not following. #1 and #2 seem the same to me.
rx-buf-len is just the size of each rx buffer posted to the NIC.

With pp_params.order =3D 0 (most common configuration today), rx-buf-len
=3D=3D 4K. Regardless of MTU. With pp_params.order=3D1, I'm guessing 8K
then, again regardless of MTU.

I think if the user has not configured rx-buf-len, the driver is
probably free to pick whatever it wants and that can be a derivative
of the MTU.

When the rx-buf-len is configured by the user, I assume the driver
puts aside all MTU-related heuristics (if it has them) and uses
whatever the userspace specified.

Note that the memory provider may reject the request. For example
iouring and pages providers can only do page-order allocations. Devmem
can in theory do any byte-aligned allocation, since gen_pool doesn't
have a restriction AFAIR.

--=20
Thanks,
Mina

