Return-Path: <netdev+bounces-86855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A683E8A07C5
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D2AB2658B
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 05:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC8313C822;
	Thu, 11 Apr 2024 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TP4PAKx7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D513B7AF
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813650; cv=none; b=NzbT7jKnc+cr0kcV6bN7dbRHnIaWuSlF/DmhtVPQMAbYtbOjYFxFlzCv46FjxLrJxkG4nH2bPyZnBTNrHSuNvt792QCLQpr7lmkrXeSyreDd9437PlbAYq2UPTbGssrd3RG2tqXKlXIRUfUTdl75nhthWsvMzoOBoyUC7uobYRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813650; c=relaxed/simple;
	bh=LFlguVofDYdRl5k8QFYkOYTqKyM2pmnSWcBNlzKCsL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIA4Xw7M8CByznDtwTVfmcDm8eg1HCoUzwHGZlqpIliMvIVlSeAuZPNztVF0DjCC4h01MSpDisqeDxEkjJaGL0eD8dYbyMiJbAG8O1Izd00SnwLcNwHO28HjCHUe6j2zeoVqg7v406J+istpwTqBhiXN5ELvlkj7YFQdFViHxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TP4PAKx7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so4643a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 22:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712813647; x=1713418447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoLeOvleS63QL/53nwHusJLw1VXP8N1r3LMnj5ShWO4=;
        b=TP4PAKx7sJuWtWnM1km/RrIgwGNQQ8DJalCY01a8T/Sn35Ts1XSgkjdPCf46rNiUtr
         Bg1MNkyeBp5XQ7TI3cY+Emx4DLRN8DusoJ/E/hwHA1o1VL9o4HhkLTd6MTnihKwu8VGR
         JsnP5aARo+rzJKBkpqFdiBywqavIFoA5UOeHIJJ+9IzzvcqHYCQ7tL+WrngI+7LpZtgz
         ZJwaViR0/o0V980cJRCIZv36d0pF1+5vcsD1kDskGc8D9fOhKoxUQNWxCvJJmyKEs6sx
         vCcqWnHo+qAwhYdyLM/nTdBeOP9PaH9U6PP85SsKz45ivjAHEn0JbIJMyg6cjzx0OWqo
         C3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712813647; x=1713418447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoLeOvleS63QL/53nwHusJLw1VXP8N1r3LMnj5ShWO4=;
        b=Rk14LIOpL+Tgx7kKsrmkdq0gD9k5OW9AFnn04QE/jZhtWHxXnnd/YgaTABYWPQl5IS
         Ubf1qOuWppFlPx6GEE8ZzkzuAGbZFsMFjo7O3KK9zkcK+Cr51cbms0PfgUxURXxMWyDm
         62LvXq/59u0cdzmOuJLaOS1rWEC6yUFYh95gnv98pny6Da+v+827wV5cehJxjRmBolVx
         bL8OfBWcq7/bV5MxTxEGzwF8JW9r/tcLQ0CWsx11isTumKs5XmkHVUQ7SuHNDuKCShVe
         ryZGif0G/nzbchnWOLkd1/OecUuq4NwZRZlRVj93Sbe/OCfv1CE5GR5vF8bOYOhVN5pd
         1y1w==
X-Forwarded-Encrypted: i=1; AJvYcCU9LfAK37ajTDRsS4yWMHvcbkQRJKTXnsHm+LcdKkXpnpW+GsLfdlUiCpb+shzhHESI4XlhQqaUTcpMiuyt6KXwcZgt8hw9
X-Gm-Message-State: AOJu0YyO658b1s1praNnT2YtAhkjuilKbAmlhNt3OWeAuEP0nMDFng2Q
	S5Heo0/HNk1AB40iCummuobQhnb5Ze4ba8XuSzCVADkt3GgwSB6bXER5guauYis6wEDZDTW+Ttn
	n7JDH6cN8UksMUFovU+fiSsXJzXQRKvVwU7zZ
X-Google-Smtp-Source: AGHT+IE2vdX3x+UI0EuHyzUFwDRbLiljWq0K171/JS/wtSWJrq7mlJacVHtolSWmD9csvXrVx2LIKmXBGjB/TXppwsU=
X-Received: by 2002:a05:6402:4304:b0:56e:72a3:e5a8 with SMTP id
 m4-20020a056402430400b0056e72a3e5a8mr86946edc.3.1712813646857; Wed, 10 Apr
 2024 22:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409114028.76ede66a@canb.auug.org.au> <CANn89iJyXNKycL1kd_KP8NH-qU7siv8BGW5PGLexjmqaXXGciA@mail.gmail.com>
 <20240411113835.713ccf11@canb.auug.org.au>
In-Reply-To: <20240411113835.713ccf11@canb.auug.org.au>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Apr 2024 07:33:55 +0200
Message-ID: <CANn89i+fZdLA_54GwsoY+UV+C=0KP-S6pF4hWmOQ8ajBKUC54Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 3:38=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> On Tue, 9 Apr 2024 07:10:40 +0200 Eric Dumazet <edumazet@google.com> wrot=
e:
> >
> > On Tue, Apr 9, 2024 at 3:40=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.=
org.au> wrote:
> > >
> > > After merging the net-next tree, today's linux-next build (arm
> > > multi_v7_defconfig) failed like this:
> > >
> > > In file included from <command-line>:
> > > In function 'tcp_struct_check',
> > >     inlined from 'tcp_init' at net/ipv4/tcp.c:4703:2:
> > > include/linux/compiler_types.h:460:45: error: call to '__compiletime_=
assert_940' declared with attribute error: BUILD_BUG_ON failed: offsetof(st=
ruct tcp_sock, __cacheline_group_end__tcp_sock_write_txrx) - offsetofend(st=
ruct tcp_sock, __cacheline_group_begin__tcp_sock_write_txrx) > 92
> > >   460 |         _compiletime_assert(condition, msg, __compiletime_ass=
ert_, __COUNTER__)
> > >       |                                             ^
> > > include/linux/compiler_types.h:441:25: note: in definition of macro '=
__compiletime_assert'
> > >   441 |                         prefix ## suffix();                  =
           \
> > >       |                         ^~~~~~
> > > include/linux/compiler_types.h:460:9: note: in expansion of macro '_c=
ompiletime_assert'
> > >   460 |         _compiletime_assert(condition, msg, __compiletime_ass=
ert_, __COUNTER__)
> > >       |         ^~~~~~~~~~~~~~~~~~~
> > > include/linux/build_bug.h:39:37: note: in expansion of macro 'compile=
time_assert'
> > >    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond=
), msg)
> > >       |                                     ^~~~~~~~~~~~~~~~~~
> > > include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BU=
G_ON_MSG'
> > >    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #=
condition)
> > >       |         ^~~~~~~~~~~~~~~~
> > > include/linux/cache.h:108:9: note: in expansion of macro 'BUILD_BUG_O=
N'
> > >   108 |         BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##=
GROUP) - \
> > >       |         ^~~~~~~~~~~~
> > > net/ipv4/tcp.c:4673:9: note: in expansion of macro 'CACHELINE_ASSERT_=
GROUP_SIZE'
> > >  4673 |         CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock=
_write_txrx, 92);
> > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Presumably caused by commit
> > >
> > >   d2c3a7eb1afa ("tcp: more struct tcp_sock adjustments")
> > >
> > > I have reverted that commit for today.
> >
> > Yeah, a build bot gave us a warning yesterday, I will fix this today.
>
> I am still getting this build failure.

Do you have the fix in your tree ?

9b9fd45869e744bea7d32a94793736e3d9fd7d26 tcp: tweak
tcp_sock_write_txrx size assertion

