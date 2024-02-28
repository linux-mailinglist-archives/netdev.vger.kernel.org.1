Return-Path: <netdev+bounces-75789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B133F86B2DF
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A5B2833C9
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F42F15B119;
	Wed, 28 Feb 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNFKI7S7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2B72D022
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133281; cv=none; b=H92n0DsCF1ybI7ZXXvnesmoXZLqwDaAPt5BxSE7ZDlhIr4XL3l2GFbr83XCXP3/n7eyWowbvuf/9unm04u0hXY7qi4gtPru3V9Rx52innMeczIZaaZdcHVWTn0JQxiEpzDriXAU6C44wWnGVW8wauv3aWPeCdOY+aaEztrPUBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133281; c=relaxed/simple;
	bh=ieBROfWhPxETfKhmMF5nmZcAVnRfchTbkrjAXIBbE9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YITn2syc779q956sBreDErvRtjFqL0v4nKEbIShZL+1pr6LnQkaa7PVCG56P3h5FWBrUkGwLqjlOP5Lpfcmpzi6GQXvC4cvXSy5QMD33Vd7/U3LAC8dztn/ZvJv9fZpjb3hDHz75wkrF0WhBVBYhgdD9/+meNK2MgduNKtzpG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNFKI7S7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so11493a12.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709133278; x=1709738078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieBROfWhPxETfKhmMF5nmZcAVnRfchTbkrjAXIBbE9I=;
        b=RNFKI7S7c4CYlVJvw9HtKTrRIM+BTNgIOLFyL/MtY5bbB/wajxfMpgtU28iFKFJQOn
         VPuC9gLV8orirN+72wCbofS6e6dPRn5xFmFY5YASH8kYb+TQ9TokrILBe9ysMdN1JKGG
         gxHJr1JsPknOsQPCI0mCAfcBr2dIHz3vWUvSD+STMI/JxyEdYT8GfX3EfIGd4rkljoNY
         4VdnoJYI6kq6vGQruf/TPm1WivRd53HmnpK666dTo/FCUPdoR4VGwksYm/IBdZtS0CHq
         bQRxjB5zv0FOkEDlslSPb7hu9nEwwKzL1mPZof8u7wU3oKqOb42fZKb3T2jQqKHpdN0f
         m+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709133278; x=1709738078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieBROfWhPxETfKhmMF5nmZcAVnRfchTbkrjAXIBbE9I=;
        b=a7IfwvCi7H2Lb/7v2MyUToil8F/qgssuqssZRQhP5IV4uxEUpVjzHSOLFkPQwA9mgI
         t6vE3DUJwOY8kt8rGHx0uxxb14qC9eWO/5Fl8QuAqCilzf0sZuPHLVNWb+60M3eh3Osu
         82+4ub+D8pilDCu2xBUIl9L7F4auylA5Xd/YRYYrpT24+f8ei68UzdktKJbjXoUaSeyt
         2BOuoj4JAlaAO9/3KqEHx3tqdm+gkUbHglcBUans5hHIWLFZZHhO9Kjy6bAYUv3cnJhd
         H+w5afu9t3r6sNwd3oIvU2/lg//0l8PiU8M4cIe0oKgh66yzxWmEEYf1orgQucqhqhRp
         oRCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBACfUlza2JYMUzMbMtAUu8pWFMjWICVT7xT9hddm2ZKnsEIDdO8ppXlAtXFelxFyhz9NMfPaPgbmV8lNA3IeZlsGws3h9
X-Gm-Message-State: AOJu0YxhqhbYZqpRA/ZR7I8i1yy5DXylq5M7iZxwzhftCbRuekRyVdCY
	mJTIIdpisTlhiO4KVINdwjTEht2cUs1qMfKaExfZkV6k9klt0zf7Zd8uVmzM6Xq0HyLb7cC3R9d
	TP1SidGgiLfzzckKiOgfP0VQaemsL0Hzg8UNH
X-Google-Smtp-Source: AGHT+IGR4x1xL9YiRg5y1bQMA3uFP1zMEH9T2cwcAa4qm3alfl0EsW5WcMz5ZGSD9VYLJwcy9cjcq3QmFZcVTZQwsrk=
X-Received: by 2002:a50:9349:0:b0:565:4f70:6ed with SMTP id
 n9-20020a509349000000b005654f7006edmr49543eda.6.1709133277593; Wed, 28 Feb
 2024 07:14:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com> <20240227150200.2814664-4-edumazet@google.com>
 <20240227185157.37355343@kernel.org> <CANn89iLwcd=Gp7X7DKsw+kG2FHA1PzwG3Up8Tb2wjA=Bz94Oxg@mail.gmail.com>
 <CANn89iLefNuOXBdf2Cg8SbwAXCm=X+qZ-Cqkx8CQ=vESv-LYSg@mail.gmail.com> <20240228071142.29c8fe1c@kernel.org>
In-Reply-To: <20240228071142.29c8fe1c@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 Feb 2024 16:14:20 +0100
Message-ID: <CANn89iLEC=Eb8nHtk8f4YOY6zzoaDrbzorBu0yF5dS2-5KeHiA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/15] ipv6: addrconf_disable_ipv6() optimizations
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 28 Feb 2024 10:28:28 +0100 Eric Dumazet wrote:
> > > Good catch, I simply misread the line.
> >
> > I note that addrconf_disable_policy() does not have a similar write.
> >
> > When writing on net->ipv6.devconf_all->disable_policy, we loop over all=
 idev
> > to call addrconf_disable_policy_idev(),
> > but we do _not_ change net->ipv6.devconf_dflt->disable_policy
> >
> > This seems quite strange we change net->ipv6.devconf_dflt->disable_ipv6=
 when
> > user only wanted to change net->ipv6.devconf_all->disable_policy
>
> The all / default behavior is a complete mess, I don't mind changing!
> I commented because there was a flake in TCP-AO tests and I was trying
> to find any functional changes :)

Sure, this is a change that needs more investigation if anyone has interest=
 ;)

