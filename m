Return-Path: <netdev+bounces-141607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B79BBB35
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0BC2818E0
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD05D1C3034;
	Mon,  4 Nov 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hz7n0cAM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DAD1C3306
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740371; cv=none; b=RaoNhxcbywvJBQajiKeyE2DIMB93qjUFE9dt8gCtRS+dJPCDxxDghl6SBVEPgXyDX5skhDn1q375JC6vWrYqwOY8r7JIsACxRzNUaH+WVxZWrGRu4+fgougBouq45XFMhVNIxvzAkvp5aNroSpLcbrP5PAbafmHh9ARxSl/0KhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740371; c=relaxed/simple;
	bh=2yDeCwWeanhRfjDcg3QZSEc/Uy0EkHEvsV/TrF/rvl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O42Xne+JZqyhHzTq4KZgyaZ56C44d2i07oZZy4I/LQa2hYpkWPV/EQKozN6dL6PbDq63CMiJTV4AfYOJhedzD/kq7OUUJYKLOuXpdu66rgLrqXLeJry8IiLKvibyqQDEfKimZKLZqmDVeArsDYa9AZBGpb51hpb0iBE4wMj1Sxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hz7n0cAM; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e13375d3so4575842e87.3
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730740368; x=1731345168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yDeCwWeanhRfjDcg3QZSEc/Uy0EkHEvsV/TrF/rvl4=;
        b=hz7n0cAMJzvaCd5LAUAMmtMAoJFN6Qwse0QIK++5Rcuv/RVLV2QqyIKi/bnn/i2tWp
         LuHqf4BY9CHJYIhnIKacRIBcDTpV4mu6Gs6euajF7OEVnpUEWaGSfBXZSMbrIdABsw/W
         vW0PyKsCtuwzp46wuAmhWklMGghFc5h4cNwxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730740368; x=1731345168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yDeCwWeanhRfjDcg3QZSEc/Uy0EkHEvsV/TrF/rvl4=;
        b=rfq0WxuUFj2HrJNb8nH38yjuW9yNwNCFQgBRca1EClQgcY2IAaGhc7ez1p8w1lnHIz
         /pA76Y7ak+ZOjOaHRr5sz5B7VFKYfihiJyN9CRHkzNrhxyg/aylKLsxdYquS2x/R9gl3
         7y4jOQlgW/etII37WOvdi2SR2qqPfFqAzyI67KZ/XWy/HLCaOPbe7an0+gnEskxQOzsV
         nzjyu0qdcaj2gEpS/QWfH0kObXOBoKdrMKp1yBg7YaJGV4iOB7XYy3t4pGbCIM2gq0GF
         5uYtATaDPUVtpQEQdBVSWi8dFyM535zFanFR3KZEdWcqeZAMqZDqQ3yfhDXSb1s+VIPn
         7oDA==
X-Forwarded-Encrypted: i=1; AJvYcCXznhrcJ7TAiixR4a1TbRHN/+Lqekb2pbj2yEdLH08JunLO5Dr6UIhA5uDnOhvqnTyCGW/TWYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUpqLTzFVcR9r8obRvceioL1mLsXZ/cBerjsV2yr+wAPAwRqR2
	FPsLrARrIH2G+yjNDtPLsY/kXiw6I8zLjp6bPiJ+dGrfx9WVFBb5ffePHD1CVh+owGPwHpiHOav
	CHjBTDfnvdlB0jqcwjUN+d/AVi8UdFxe+X7p2
X-Google-Smtp-Source: AGHT+IEjX0KYihsg5M12Yt94xgwDXRaw8vbt/BnR8UnvYMxv/mjOptO88w2Qrs4232astMC3NZm9KHekpOYU9jnJJKs=
X-Received: by 2002:a05:6512:239a:b0:533:4b70:8722 with SMTP id
 2adb3069b0e04-53c79e2fa52mr7351705e87.15.1730740368184; Mon, 04 Nov 2024
 09:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031092504.840708-1-dualli@chromium.org> <20241031092504.840708-3-dualli@chromium.org>
 <20241103151554.5fc79ce1@kernel.org> <CANBPYPj4VCYuhOTxPSHBGNtpRyG5wRzuMxRB49eSDXXjrxb7TA@mail.gmail.com>
 <20241104081928.7e383c93@kernel.org>
In-Reply-To: <20241104081928.7e383c93@kernel.org>
From: Li Li <dualli@chromium.org>
Date: Mon, 4 Nov 2024 09:12:37 -0800
Message-ID: <CANBPYPjo0KKm3JbPk=E8Nuv05i=EeR93PHWjSU8fcH-GVWV94w@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/2] binder: report txn errors via generic netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com, 
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, 
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org, 
	cmllamas@google.com, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 8:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sun, 3 Nov 2024 22:25:44 -0800 Li Li wrote:
> > > You're trying to register multiple families with different names?
> > > The family defines the language / protocol. If you have multiple
> > > entities to multiplex you should do that based on attributes inside
> > > the messages.
> >
> > My initial plan was to use a single "binder" family, which was more
> > straightforward and cleaner. As Android uses multiple binder contexts
> > to isolate system framework and vendor domains[1], Grek KH suggested
> > the netlink messages from different binder contexts should also be
> > isolated for security reason[2]. Personally I'm fine with either
> > approach. Please kindly advice which implementation is better.
> >
> > And I'll fix other issues you mentioned above.
>
> Greg is obviously right, but using different family names will not help
> you in any way. There is no action of "opening" a socket for a generic
> netlink family, one generic netlink socket can talk to all families.
> The only built in checking netlink provides is that you can declare
> an operation as requiring admin privileges, or network capability
> (namespaced or global).
>
> Unless those are good enough for you - I think you should do all
> the security isolation within your code, manually.

That's why binder genl uses unicast instead of multicast. The administratio=
n
process of the OS (Android in this case) always runs before any other user
applications, which registers itself to the kernel binder driver and uses i=
t
exclusively. With a unified family name, the same userspace admin process
has access to all binder contexts. With separate family names, each domain
admin process can register itself to the corresponding binder context.

So, do you think the current implementation of registering multiple familie=
s
with different names acceptable? Or is there a better way to do it? Thank
you very much!

