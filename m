Return-Path: <netdev+bounces-129555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBCB984700
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 15:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0F81C20A7B
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCBA1A7279;
	Tue, 24 Sep 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSSyV5Ww"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6B14D44D
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185595; cv=none; b=K2E0+dUaeSZXlVAc0NcfA+GGMpfksABSCdKR+teQyM3J91Lasp5vjTjUpf9XUV+mQWe7tM0PQlEtWX4q2yOYz/gzUkTZeMxqC2r9QNOST6bOr1VhCgXuFnALlgznR7iVT0rx2yU0NypM1f1zc9cZVWN8Vd7vh34hhreSfX0IN1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185595; c=relaxed/simple;
	bh=QVtL+3KVFqPq/oSf1Yw5Zipj+SQqfOMkPscBopyOfok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTF0rReeRtxlU/nqqky56wVvdNteWmaapVVwcVfzX7Ki8dSK0TyBcmtUBYlvQyBK2Y40OKdpanS3lDkK6qLqDgJjtRPtrE1GmpKA3djmgR9uKQ3YvzLVr9XTGUFvszb7lFu+xtCNBCK04rORi4cA/EJXU/L8Wa2EQm0gx7A7lIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSSyV5Ww; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c5b954c359so3624447a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727185592; x=1727790392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS+n6lf0ewZ4C9NqB0m2FPDZKb3ZOgpjWOZUUqgRpHA=;
        b=FSSyV5WwKsWT4W2dWPZC7Sfjqy0F/4Lc5cdwV+Q/Oo+vrVxpZqn5p36Ocum+X9PeMl
         P4PIEIy0RSNQYiml8OoK6fC/oE+wO7MC+zyi0gKk/JJs4+MexcuT508F35XIP4JzCBqS
         bPPbSDhDDE62FKsv72O7Cy9U1LP9T+oQz9mKsAuvwXkWfTN/qKETurejsHp3Ad+9WS1h
         sJgXx6utV/zynxTxzAoG/nvYCfmryHVFszDc7LAtj50GTsyOtEP4fsWaYtMkrB05Rdxk
         rwL3nJJDcdAYMCN5CSaHAL4oLILlzX7ZB1Y7GLUEEL2eBGudD3eVfiV/r19gO+vMnIXJ
         aLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185592; x=1727790392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS+n6lf0ewZ4C9NqB0m2FPDZKb3ZOgpjWOZUUqgRpHA=;
        b=j3OVAFaQyfyREV8vZkUlJk/Fwn45AgNCVcA8mu0xukzoV7vXB57dBoZMxSu7Sxfzlg
         UtCI5vqEr4d2pEDfO+2WJhDROL1u5ifdOxorAiLJpKEpZD1Li1If9ItyVhIv4mHNjcZC
         h2AVNN5ngig32TSTbXVweGegfK8BR3diXrzaP6KOhrxTIOwTIBwufAW+Fz3I32aBmUHB
         Ep0EQHxoFl9jI/13AoTO8+mIaFAZsizKgfNML3Vwvr8ZjoUUWdlFVQ1mZ0ncByBZ5ho4
         5qMyQxOvEoCjYxn8p7vQ0eHkXuc/OYf8iTiIw+2maLYv4GHLfjN7lNVBGSW8hZZkBMGJ
         SqHg==
X-Forwarded-Encrypted: i=1; AJvYcCWB2i54CWLFTEhDZNEM1+suBy1szX9P+WbO8i4+MzqI5Ne5POZAk4e0uZNQu0MeYmf+M1kNqdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyk1YdjX6o4gnfxsuga9QzJGizyGVHvbGK9FfYWI42dE4oJfvb
	mPS3C5O58NR9QJF+7Q2g3WQtyeIrT9FtUrZvapYdDvePbiX8WqJx8cBqTJa0kod1srNNhBBXicW
	PviOxQjI19D9ugVG5wxHCOQp3ZRWufvbg96S4
X-Google-Smtp-Source: AGHT+IFfDvU0QoxZl9U8yx2iVrPx9Ckr9pP18sGwnClBif5QuPOwDAhR+U/DPatMes1QIHSjN3FU6qPJ59E6u4F8PNU=
X-Received: by 2002:a17:906:dc8d:b0:a86:ac05:2112 with SMTP id
 a640c23a62f3a-a90d50e1eeemr1406536066b.51.1727185590419; Tue, 24 Sep 2024
 06:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14BD7E92B23BF276+20240924090906.157995-1-yushengjin@uniontech.com>
 <20240924063258.1edfb590@fedora>
In-Reply-To: <20240924063258.1edfb590@fedora>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Sep 2024 15:46:17 +0200
Message-ID: <CANn89iLoBYjMmot=6e_WJrtEhcAzWikU2eV0eQExHPj7+ObGKA@mail.gmail.com>
Subject: Re: [PATCH v3] net/bridge: Optimizing read-write locks in ebtables.c
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: yushengjin <yushengjin@uniontech.com>, pablo@netfilter.org, kadlec@netfilter.org, 
	roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 3:33=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 24 Sep 2024 17:09:06 +0800
> yushengjin <yushengjin@uniontech.com> wrote:
>
> > When conducting WRK testing, the CPU usage rate of the testing machine =
was
> > 100%. forwarding through a bridge, if the network load is too high, it =
may
> > cause abnormal load on the ebt_do_table of the kernel ebtable module, l=
eading
> > to excessive soft interrupts and sometimes even directly causing CPU so=
ft
> > deadlocks.
> >
> > After analysis, it was found that the code of ebtables had not been opt=
imized
> > for a long time, and the read-write locks inside still existed. However=
, other
> > arp/ip/ip6 tables had already been optimized a lot, and performance bot=
tlenecks
> > in read-write locks had been discovered a long time ago.
> >
> > Ref link: https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehalam/
> >
> > So I referred to arp/ip/ip6 modification methods to optimize the read-w=
rite
> > lock in ebtables.c.
>
> What about doing RCU instead, faster and safer.

Safer ? How so ?

Stephen, we have used this stuff already in other netfilter components
since 2011

No performance issue at all.

Honestly, this old link (
https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehalam/ ) is
quite confusing,
please yushengjin do not include it next time, or we will get outdated feed=
back.

Instead, point to the real useful commit :

commit 7f5c6d4f665bb57a19a34ce1fb16cc708c04f219
    netfilter: get rid of atomic ops in fast path

This is the useful commit, because this ebtable patch simply adopts
the solution already used in iptables.

And please compile your patch, and boot it, test it before sending it again=
.

