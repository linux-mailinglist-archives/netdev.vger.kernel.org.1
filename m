Return-Path: <netdev+bounces-247199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2040CF5AC6
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 22:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A702230AD372
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 21:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C92D6E64;
	Mon,  5 Jan 2026 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaSktb+O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447D2773EE
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648626; cv=none; b=qfLpC0H/9xMbV+/XXMXuAOJZ6LXJFQxgrZunML9LzaVxT2G63paZMWL44o80gOAcF/xw7h8myQHDebRLRQ+vR5CMa6UHXC3oB8EZXRBRjoBczl1Tb5EKcI92joVa5Kr8KhdvZBbKRK4EytcrponSU8xiE4rj88DGLmZqIQv5ieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648626; c=relaxed/simple;
	bh=3n2vCisThVsOlragyGDay+6tW9w4bEoSHR5iRUS9Glw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBXiUt7ELyL0/77/aMJ4jwgEWFYzlPxeKMpQ1cFvIdrbEQezaAlPx/+xkQkC/lcjYAXwe944d0Pyew6Ky7AjKTAL34FYyfT3jDLZZM5bOGwBVK7zwiczbVM9XNTEhaO6ph6Hh4W+t30Z+o8+gt7TxcJ7UfyfMIWInRdnlV8AaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaSktb+O; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a1022dda33so2805425ad.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767648624; x=1768253424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNQTNhTvb1y3r7Npal158k3hpZgaWnE9Tjsv4NEjAEw=;
        b=kaSktb+OJP6e5Z/3toUd+sSmSOlSNCL93jQuFV3yrlQ0CV7cgturJMM0BWhFgwashz
         jMTQ/4eY8JBBDKFchuubNoH+NmkAtmPMcaN7FR4c5c40SW3Ef2AJVgpl1QYiLL+Vk3aM
         N57R6rcOGTm2Gnf+LGNa0x63kRQirS7J2EK46czy98368ESGjbwIaM7BlS5B27dH+bpV
         8Hd4v8/EUsstTftlZ3Xre12EUkTaQP5S5sABlT6q+m5QBaqfNwiOYGqtI4Sn35GVQsr+
         ebmkU8iuszfXD/kHYZTd5B2U1FPnDom1VGbZxHxdxVEZit7fAJcWGvkoCqTqB8GmyM4U
         buWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767648624; x=1768253424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNQTNhTvb1y3r7Npal158k3hpZgaWnE9Tjsv4NEjAEw=;
        b=L/4KjQRdAxaapMmniCimCWoYh09NxOmUCfU3wNtf8jKvMRBwDNO/1iuV/4/v26/gFB
         IdUq2v/v+Nde0XlD94gYAoW+hKuXsCBQCgUDSB78nypqwf+wIKSaA5tbMItLOwPE1HjC
         7HHM6mZLP8MR6+ZDfPxewMqoAPuHP5vCSzMb7eOqSq0RNtl6ZxTmSweuLArQdRmbDAtc
         Xtm/PAQ/88L/pDTk3hSqzt/Vv7lqfbxOqzw/TqMr+IL4gbbs19fwPMeS5zyjWTV7w1wf
         oQHcUsM8Hm8z+hwrpZorKw0hEBsJh5LW6bapilhVU3792Ea6MT50HRD4XRYWVJWOfR6E
         bNyA==
X-Forwarded-Encrypted: i=1; AJvYcCUXvHLBLKWm+Q0xX/aMKNyZAcrL4pc3BcAtDBLN45v2nEI/+NrRSaGm+GqCKwRCOmJmswKYdtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYv17sjZEkFAL2EHrvfGyQYNmSpP9DuQcA3341crzNvJ93aBD
	vC5wxQyWP7F48q/Ist1za1Fn+NkPU1++21yf7OYf0C0NdjEotJIHm7yzDm6PpK91n9gkjF+i7FH
	RbxEduqcvqpnSUaLcZKBZgqwhPCqpoYY=
X-Gm-Gg: AY/fxX4s2LKBWDPkJtJy4HH5p1ZLqK4b1oUo+JzIdtdFTTnbLD8zSWc7Z7SfTBsEBrC
	jLDCb96aTeqZaZ7V2HxRONiJ5Uw5iT9C3JnJeEepWL4YYR54oRLAlJOcPg5vXSNuA6hTfLbZ7MA
	nJVDbBdkHCOw9EDeDXwNJRuvitOI20JT7VkfdMOHdXYSEXDkrRSxv2MfxKBl8M5aC69ixI5ey5A
	P+CIG4DssoxF7H2fglErIQ+Jtmn3+rRf47Q5FUFxZBGh1ph7vqiJUVoICceqvttVIi7Tyce5XW2
	z1Bgpa/KT04=
X-Google-Smtp-Source: AGHT+IGhvOS6mcpN4NPO0ujazhU5nslDD3kJzFAVysyKpRaxl9lOdq/Dh+NTy2Y+4Opk4T8XqoGTf22bJdbaV7lJ22s=
X-Received: by 2002:a17:90b:3843:b0:32e:a8b7:e9c with SMTP id
 98e67ed59e1d1-34f5f32c24bmr465278a91.29.1767648624076; Mon, 05 Jan 2026
 13:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net> <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
 <aSx++4VrGOm8zHDb@inspiron> <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
 <20251220173338.w7n3n4lkvxwaq6ae@inspiron> <01190c40-d348-4521-a2ab-3e9139cc832e@hartkopp.net>
 <20260102153611.63wipdy2meh3ovel@inspiron> <20260102120405.34613b68@kernel.org>
 <63c20aae-e014-44f9-a201-99e0e7abadcb@hartkopp.net>
In-Reply-To: <63c20aae-e014-44f9-a201-99e0e7abadcb@hartkopp.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 13:30:11 -0800
X-Gm-Features: AQt7F2qB98D05JFXrn5jIaSNXe0Wo-ByX8IsQT-ZSn0gRMHCve1bRDNsBexvBSA
Message-ID: <CAEf4BzaXNbzsVhLLk2brJn0duyRTjxoiofisEQOv=y43hxvFag@mail.gmail.com>
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Prithvi <activprithvi@gmail.com>, andrii@kernel.org, 
	mkl@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 4:21=E2=80=AFAM Oliver Hartkopp <socketcan@hartkopp.=
net> wrote:
>
> Hello Jakub,
>
> thanks for stepping in!
>
> On 02.01.26 21:04, Jakub Kicinski wrote:
>
> > You're asking the wrong person, IIUC Andrii is tangentially involved
> > in XDP (via bpf links?):
> >
> (..)
> >
> > Without looking too deeply - XDP has historically left the new space
> > uninitialized after push, expecting programs to immediately write the
> > headers in that space. syzbot had run into this in the past but I can't
> > find any references to past threads quickly :(
>
> To identify Andrii I mainly looked into the code with 'git blame' that

Hey, sorry for a late response, I've been out on vacation for the past
~2 weeks. But as Jakub correctly pointed out, I'm probably not the
right person to help with this, I touched XDP bits only superficially
to wire up some generic BPF infrastructure, while the issue at hand
goes deeper than that. I'll let you guys figure this out.

> led to this problematic call chain:
>
>    pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
>    netif_skb_check_for_xdp net/core/dev.c:5081 [inline]
>    netif_receive_generic_xdp net/core/dev.c:5112 [inline]
>    do_xdp_generic+0x9e3/0x15a0 net/core/dev.c:5180
>
> Having in mind that the syzkaller refers to
> 6.13.0-rc7-syzkaller-00039-gc3812b15000c I wonder if we can leave this
> report as-is, as the problem might be solved in the meantime??
>
> In any case I wonder, if we should add some code to re-check if the
> headroom of the CAN-related skbs is still consistent and not changed in
> size by other players. And maybe add some WARN_ON_ONCE() before dropping
> the skb then.
>
> When the skb headroom is not safe to be used we need to be able to
> identify and solve it.
>
> Best regards,
> Oliver
>

