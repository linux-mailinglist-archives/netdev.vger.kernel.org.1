Return-Path: <netdev+bounces-196770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 722CFAD64CC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66260189B2CF
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C565A450F2;
	Thu, 12 Jun 2025 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwZys+z8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998FA944;
	Thu, 12 Jun 2025 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689731; cv=none; b=Ex60NIP8GQFQ9xVLftAFr26dHktTjpq8y91uBAgrPZKWjOxT27UmKvJKfzqkkZw2HvNkoauKhtMgt3zCg7GrRaglGlwbpEP9wezvpU+d4moeXVcMxd5MNhpnBEMZwt3Qqlk0ANL3nbLzS0EewP99k/ig+izyUHmKkTTmKA6IV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689731; c=relaxed/simple;
	bh=02rlLGtfxeXHjsHmWjbMyFw3FRgqWLoxQIh0j2d8ovw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6uUlOuVofEMhTkCebrZmgaYaGGtnKt4pX4zek72fItMCaFxPyWsGThrOXrC+9nZ+CzxcclNmQ08UytSwElyPyrtGzxXKIcP/JXhdYg92vXEx0dF33LvIrEdw+ureEHX1aly07joRbkB7uLc+l18hPTM1Jg+2rXXgDKJTDw5SaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwZys+z8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32addf54a01so4086531fa.3;
        Wed, 11 Jun 2025 17:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749689728; x=1750294528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02rlLGtfxeXHjsHmWjbMyFw3FRgqWLoxQIh0j2d8ovw=;
        b=UwZys+z8Kdm8iMj27LntxT9mlaJiTKPb6LrDyO728mmF31Ge2Y3Esdv8/gzmntXUTF
         y/1PFTAciFx5Iy4m87o6YlscZ1qrIFtG08/R7F83A2Um6cbkMaa2yQTEkUU0QeopFOJ7
         1FTYtHLXI2BdBkSb8vjg5aRTP4imE8ezMqgziMdFVSKOu/WXBPREbODAcd0hrX9ys/Iw
         C674Ge+mqjEG6wV10HlW5SrbtD9lfP4KguM51zuHvNNcF3IRhfinOhFAl703JZjeGY7S
         Rix+HL+5F45B+AIS2HstYySBxfjuRAaapMLAcI9SFP9pqh/wqUbYUxyU0ggenY7j+ag/
         yo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749689728; x=1750294528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02rlLGtfxeXHjsHmWjbMyFw3FRgqWLoxQIh0j2d8ovw=;
        b=sB4M7ffr5LkNtDDpz+hG8av0l/ApPTvJRP9XKDF9PwqZ1VD+xwwg12JmSE1rYKYGWk
         qwJ00QJ1TSHNM5v1B0p/emSPdJx1kVyDgmBwjdRyG/STiIO68etAnCgKPSBeot/W6ApH
         r7Z/O+Y+81R8W8EX+00x0F9tmV8c/+4Ec4PMgclxubDHGfcWtCHF2dytrj7fl2ZCi1Fs
         VRqASo5/8M0M1pyKFUGVcr5S9j5tFvQwWi9JMALh8RN5/gL7wfOb8lTdPq/NxfJEtBbS
         1WS20gTxl23e+b3qRt9GqVB/JK55YhHilkxM4E4DFmiMx8snjqEDd7W+uA88SZkSgSKz
         G99g==
X-Forwarded-Encrypted: i=1; AJvYcCUZZz8lKg8flCrd5tXVWD1JMAEa2tUjsivPmp7timdPRgXGCG4msDYitcHu52osyWe7lY/DK4J83Dk+Sw8=@vger.kernel.org, AJvYcCWaNGdnyVEhtI0gpn6+PqKF7dvBskKE1nys1rH2L+y+TMd2PjwsqirI9alQ6SKNfNtLEF51yTVPIc91F+7KoS0=@vger.kernel.org, AJvYcCXXVVGohg3pR8HtASJw5SjgqRkiucTlvV2LhpUd793x/O12ga5achxUY6+5r9MfaILyAIDaypdt@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+B89i6mEt/cRDLazhJxeTlvKH5VsmqV7pWSpae9X5NyQN2ij
	RcjJLjOeJmPrqZDPuXsV2bifN7095FjPQpw4x+UP7kztDBhr9y/TdvKJIoSbr6xs7+i9DEx3cxB
	bet5Z39kN470p8m0ykpN1ngm26g12jwY=
X-Gm-Gg: ASbGncttIo3hJ2kBQeF7RWRdAZK348fOsDNAsZ8cDE6AU+HXdJjdG++HIB2wjRDDuHI
	3g/p/HvNXBrF0G/u0Cxwx8S5s3dgmkWo9A6lfIgS4+VHClYaoOFVorX4v+c3RPkzeDzkLS79caV
	mkW+7vKxntgbEd/oIp0JS9bkAkJ398v7MV7DL6kEbOYEufvQ0NYOXctAERVAS5GxAOYKFKv68eo
	/Ph
X-Google-Smtp-Source: AGHT+IEAjTVQc6gCBaN+fyy4OxpD8eXGujSQWQti4N6wm9Vu2YEJ5M4XkfBoxRQlrm4CA8G+lruEUOfQ0KMesp+X37I=
X-Received: by 2002:a05:651c:40d4:b0:32b:35e6:bc05 with SMTP id
 38308e7fff4ca-32b35e6ced6mr186141fa.32.1749689727738; Wed, 11 Jun 2025
 17:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com>
 <CAH5fLghomO3znaj14ZSR9FeJSTAtJhLjR=fNdmSQ0MJdO+NfjQ@mail.gmail.com>
 <CAJ-ks9m837aTYsS9Qd8bC0_abE_GT9TZUDZbbPnpyOtgrF9Ehw@mail.gmail.com> <20250612.094805.256395171864740471.fujita.tomonori@gmail.com>
In-Reply-To: <20250612.094805.256395171864740471.fujita.tomonori@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 11 Jun 2025 20:54:51 -0400
X-Gm-Features: AX0GCFtVbFawFEU3xKRhoK3eY3Dg6SyO8rvlkK_xWlCOPkYVxO4bSRJBZ8lWlUE
Message-ID: <CAJ-ks9nXwBMNcZLK1uJB=qJk8KsOF7q8nYZC6qANboxmT8qFFA@mail.gmail.com>
Subject: Re: [PATCH] rust: cast to the proper type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	dakr@kernel.org, davem@davemloft.net, andrew@lunn.ch, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 8:48=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Wed, 11 Jun 2025 09:30:46 -0400
> Tamir Duberstein <tamird@gmail.com> wrote:
>
> > On Wed, Jun 11, 2025 at 7:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> >>
> >> On Wed, Jun 11, 2025 at 12:28=E2=80=AFPM Tamir Duberstein <tamird@gmai=
l.com> wrote:
> >> >
> >> > Use the ffi type rather than the resolved underlying type.
> >> >
> >> > Fixes: f20fd5449ada ("rust: core abstractions for network PHY driver=
s")
> >>
> >> Does this need to be backported? If not, I wouldn't include a Fixes ta=
g.
> >
> > I'm fine with omitting it. I wanted to leave a breadcrumb to the
> > commit that introduced the current code.
>
> I also don't think this tag is necessary because this is not a bug
> fix. And since this tag points to the file's initial commit, I don't
> think it's particularly useful.

Would you be OK stripping the tag on apply, or would you like me to send v2=
?

