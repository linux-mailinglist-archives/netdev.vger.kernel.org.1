Return-Path: <netdev+bounces-82493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CC688E62C
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C531F3081A
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F87139D10;
	Wed, 27 Mar 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYSMlrF2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D47139D05
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544734; cv=none; b=CCjrzcMiEtoWa3QPDIclYsuwzzSbUPbiRigRuEN1d29yHtwdDnpa5thZ9QwC4HggFk6Yw3lhgyA2otVB60rOk5Bajsp91C/Dfgh9S/NnpPNavUYafJrWAjxQOENEDdlifetskyJ5jYQQaBQjcpDhQp3dHZjplqsGz0LiTddLkyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544734; c=relaxed/simple;
	bh=6OywkV+f7o0OgA406yHPrQDvuUOJCUtns0fRF1Sioko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MH4G/MPuVR/glawxXrjDq4ap3kLOfZEDTlo3xFAI53dWuv+tKqr4Nr0VvOihJKRMiQc+TdXPkX8jBXGnX0+QGKewkWVjOZZdNoKt70T+3Rbqsm8FkENVpSWc2E2/+oJk7qAocPwmCYnpkDb9gu38rwbd/jmiSuIptSKLrd66z6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lYSMlrF2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4146f72e2dfso69875e9.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711544731; x=1712149531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKS6PrEySMHF9Zxcg2g7pHWm3h+ybRiVTjtthpaGx58=;
        b=lYSMlrF2nQorWlm4BdWdY8jyFnth+FW1QHQCgfJm93GHuLzdPaTchFIge56ezOUtV9
         ME+afKw99qtQ2l5RTxwvwgMG78H8GGnDrLZHQi0+v5dEWzX3VGBxvgcCW7C1Te8MeAYW
         nx/MtDJ+h+PJUtIhDKUjlT9LMxrqYGi8htpYbOVA1QIJbLj5zPXFdfr2i5I18B0owHMS
         w6X4JoQHvrEBVG2qzvPeoQop0s7J8h526WL9dIEzKoFXGqRrtUqq3Dcz5pgBgnGpvdw8
         gDImLlE8uJsSvyW84OhUkqFCao5Rur6kyv9dCTPQRtVh+k4HWKzL5mDBXCw7eYumrC4g
         97IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711544731; x=1712149531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKS6PrEySMHF9Zxcg2g7pHWm3h+ybRiVTjtthpaGx58=;
        b=MYjeJtOFiUaOJatTarpyi4I+RgoBhOQ6i8bISjDRhpM42lcr1Sp5k31yHdseBLwfFX
         PWNZV/15deH+vKzqK4hUpVdG7zrtizmDEsXnFq8fSbDAusWQa0pN8dRZ405fhEzOUzuo
         bXEtNL4SsrLgpprxhqQoTIUPnl4/wCGP5G4bA7hJ+AI9HSWZxO1lzg6ASqBztIU0E/Mh
         LBD8v30dHJ0e0uTx9DAau+jc31ErSSKAaw4NqK9WNQ8fxCstHADYsBu7SawjN6h3b/kJ
         m8GNjW9MnZtfE+z5Gj98ArPTH7ntvErb66E4pqa/vV6wiOcQ7FZpLOgYfEoTW3+frjpI
         +ixQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMS0V+Xizo/oulVGcJg8EHPZMl6efkeygWgzoVP4Ymjg3Y16au9bJnh4tt2kL97HJueqAHYNs7vrlrc46PY/1BrUXCCd4w
X-Gm-Message-State: AOJu0YxkvrULKlVSEsj52Z/OBuECxLlG9qNLedDFt5KgeWr37vul1h/L
	BveVgn47ifnBYJGrZVoPtzbiUvTNstolidflLIu2+JNAUQ8DVChdzbm+UcbvtaCATaE57dMP46o
	PyYsZJ7pfHqK2iFg8Kop7E9XYDDQvOFeQNHNa
X-Google-Smtp-Source: AGHT+IEJQojKRQ4623RVf8T8SHhVFd6XE4htI6xpx3tVDCgyltzj8g0Z9RaCXXlHi6GAAbMsAcguOPcrdA5yYPZu5Q0=
X-Received: by 2002:a05:600c:3ba6:b0:413:f41a:ed1b with SMTP id
 n38-20020a05600c3ba600b00413f41aed1bmr118217wms.3.1711544730916; Wed, 27 Mar
 2024 06:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326133412.47cf6d99@kernel.org> <CADVnQymqFELYQqpoDsxh=z2XxvhMSvdUfCyjgRYeA1QaesnpEg@mail.gmail.com>
 <20240326165554.541551c3@kernel.org>
In-Reply-To: <20240326165554.541551c3@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 27 Mar 2024 14:05:17 +0100
Message-ID: <CANn89iJDxv2hkT7-KCaizu3r44HpT=xbvRtMXjxd-LUQS=Br8g@mail.gmail.com>
Subject: Re: ICMP_PARAMETERPROB and ICMP_TIME_EXCEEDED during connect
To: Jakub Kicinski <kuba@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 12:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 26 Mar 2024 23:03:26 +0100 Neal Cardwell wrote:
> > On Tue, Mar 26, 2024 at 9:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > Hi!
> > >
> > > I got a report from a user surprised/displeased that ICMP_TIME_EXCEED=
ED
> > > breaks connect(), while TCP RFCs say it shouldn't. Even pointing a
> > > finger at Linux, RFC5461:
> > >
> > >    A number of TCP implementations have modified their reaction to al=
l
> > >    ICMP soft errors and treat them as hard errors when they are recei=
ved
> > >    for connections in the SYN-SENT or SYN-RECEIVED states.  For examp=
le,
> > >    this workaround has been implemented in the Linux kernel since
> > >    version 2.0.0 (released in 1996) [Linux].  However, it should be
> > >    noted that this change violates section 4.2.3.9 of [RFC1122], whic=
h
> > >    states that these ICMP error messages indicate soft error conditio=
ns
> > >    and that, therefore, TCP MUST NOT abort the corresponding connecti=
on.
> > >
> > > Is there any reason we continue with this behavior or is it just that
> > > nobody ever sent a patch?
> >
> > Back in November of 2023 Eric did merge a patch to bring the
> > processing in line with section 4.2.3.9 of [RFC1122]:
> >
> > 0a8de364ff7a tcp: no longer abort SYN_SENT when receiving some ICMP
> >
> > However, the fixed behavior did not meet some expectations of Vagrant
> > (see the netdev thread "Bug report connect to VM with Vagrant"), so
> > for now it got reverted:
> >
> > b59db45d7eba tcp: Revert no longer abort SYN_SENT when receiving some I=
CMP
> >
> > I think the hope was to root-cause the Vagrant issue, fix Vagrant's
> > assumptions, then resubmit Eric's commit. Eric mentioned on Jan 8,
> > 2024: "We will submit the patch again for 6.9, once we get to the root
> > cause." But I don't think anyone has had time to do that yet.
>
> Ah.
>
> Thank you!!

For the record, Leon Romanovsky brought this issue directly to Linus
Torvalds, stating that I broke things.

It tooks weeks before Shachar did some debugging, but with no
conclusion I recall.

This kind of stuff makes me not very eager to work on this point.

