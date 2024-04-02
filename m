Return-Path: <netdev+bounces-84025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8BE89556C
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59DC1F2254A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078C83CBD;
	Tue,  2 Apr 2024 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ApkvIhzQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6F60B96
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064733; cv=none; b=rXXE/Othwi3bMs2l+iNutuNTvo6m0uwE534scqJJZuZrg/1Y5VFchb/CRpdDkfJI3N5n66YN+2EBgYkFr8K3Nu7gHhcZI3icJd1SIKMhzWuCydV6FsrLJALsRFtzZACbdNZSkshA3cBl3/cHRcMg2v8DS7yUNv+uhBg4ZARS/Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064733; c=relaxed/simple;
	bh=vt8ENw/sbIfgx+FXUrXEU1kweibImEwbBfAgPZZiwAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/u2uO5YOrXdzw5Vmv9qkkIS9yfH85cHoTj2o3l3gWfnFEpYm2ojq2SFim8bpW3YdXAbuNgrYpTCTPjBOYm4mi4QLB2wfVJf0ofwkHBm5C4iUj6YFiGYAL+7qihoRP5ZYKopWg1wSrMuYfN2l48Q7Y6902piQbMoVGZ833+vC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ApkvIhzQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so62670a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712064730; x=1712669530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gV4qcB9U1t7ZD/USMguTYciLEDxoGET5Yrs0ypF47IM=;
        b=ApkvIhzQ8SS4pAHVkK5bYtXbCRyBrPVJL+IMXfxXpTCeuSQpQ9FaBQ5NKhpzgqEIBl
         M18kSQWs/vlP2wbL8KacMe1VkgFOcujvkkwNYsGWCHHBp40uQHyMIwWbjB28pwsV6Z1V
         WgVUMZpZv+0yeI48LmuiwPq0iJpHD23zlW/lfOQW74f09zOWEmvVkWsTm/cQMPrQUBfu
         4J34CI9ymxm6ga7bDaOhfunWky4MZRFEx+lGRJtWp4dOz/tId1dJX6amM7cHGWtONd0x
         F1RPIR0k8K3V82EjmQ+0vV65R4JbvFtcrMIAse+wcuZPtNjEI9NuanfAHVAg+KnkIY8H
         mBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064730; x=1712669530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gV4qcB9U1t7ZD/USMguTYciLEDxoGET5Yrs0ypF47IM=;
        b=pg767ESLmlrT6ZtHpx/F48pMcWwZD6KRg5gL12mKlrkRr3p8MlVPxQ6Z3hu03D/C2D
         O9hB/M9JKVIyCVHSclGBx5P9/FQXlqtlRCKQDEczmMaEGjULSPMdA0AB47CMEgJnEW3v
         zrXzupSSlDRRn39pRjMlyqyZc2pzVRgELIBCcgjA3+Mz0fupVwi0Y8lWl49CEFINN6cg
         WLN2PiOX/+2hxUfgtZ/XWszLKURGTaqGgdUKAsPKhkKJrCnTV7nMgndNhFktUT8pUTZJ
         k98TJ+yoZ+hmo1yzYG+rriq24oVze5R5z7+rPlaAjrNCJyY6gedY/R9mf1VnzFP173nW
         DKog==
X-Forwarded-Encrypted: i=1; AJvYcCVtFq8diRQM6JqrHTsMsoeDDD0q6MOqlQGEr4kWOaMXJ/PNBX9hMJQNBvMjCLjaiMQ/bDxKFqQ4fbSwQaQ/KRaX+VbiAMxS
X-Gm-Message-State: AOJu0YwIkiNwbrzAQPaph4BhEF8PYfchbZouVzgBFK+4t74fDffM9gsp
	G0dihMhogfiH2iWQxmNuBVYRgCpKgTF8HxZo/6/J5uj8HVxp1+pS/bOiniT4FUufE8VNQ6U0iuD
	i/eTyRFu/NUzEc1ckiZMIJJ+jpRjBmFouuz0qcIDFcJs5IiMbsA==
X-Google-Smtp-Source: AGHT+IExw6QNYbh7bakweJzzuhZ//CfCoPfMea0nzWVoVNnm+pR+4gm35Ilk56Zpj6B8X5krhILIvdqaUMO6zM7WwdA=
X-Received: by 2002:a05:6402:716:b0:56d:f412:c42e with SMTP id
 w22-20020a056402071600b0056df412c42emr75183edx.1.1712064729859; Tue, 02 Apr
 2024 06:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326133412.47cf6d99@kernel.org> <CADVnQymqFELYQqpoDsxh=z2XxvhMSvdUfCyjgRYeA1QaesnpEg@mail.gmail.com>
 <20240326165554.541551c3@kernel.org> <CANn89iJDxv2hkT7-KCaizu3r44HpT=xbvRtMXjxd-LUQS=Br8g@mail.gmail.com>
 <20240402132137.GJ11187@unreal>
In-Reply-To: <20240402132137.GJ11187@unreal>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Apr 2024 15:31:58 +0200
Message-ID: <CANn89i+=MOmFzLzdwTX4k8Bc1mrXXzpOzgpAe8KSnjAmuX3kLA@mail.gmail.com>
Subject: Re: ICMP_PARAMETERPROB and ICMP_TIME_EXCEEDED during connect
To: Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 3:21=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Wed, Mar 27, 2024 at 02:05:17PM +0100, Eric Dumazet wrote:
> > On Wed, Mar 27, 2024 at 12:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > On Tue, 26 Mar 2024 23:03:26 +0100 Neal Cardwell wrote:
> > > > On Tue, Mar 26, 2024 at 9:34=E2=80=AFPM Jakub Kicinski <kuba@kernel=
.org> wrote:
> > > > >
> > > > > Hi!
> > > > >
> > > > > I got a report from a user surprised/displeased that ICMP_TIME_EX=
CEEDED
> > > > > breaks connect(), while TCP RFCs say it shouldn't. Even pointing =
a
> > > > > finger at Linux, RFC5461:
> > > > >
> > > > >    A number of TCP implementations have modified their reaction t=
o all
> > > > >    ICMP soft errors and treat them as hard errors when they are r=
eceived
> > > > >    for connections in the SYN-SENT or SYN-RECEIVED states.  For e=
xample,
> > > > >    this workaround has been implemented in the Linux kernel since
> > > > >    version 2.0.0 (released in 1996) [Linux].  However, it should =
be
> > > > >    noted that this change violates section 4.2.3.9 of [RFC1122], =
which
> > > > >    states that these ICMP error messages indicate soft error cond=
itions
> > > > >    and that, therefore, TCP MUST NOT abort the corresponding conn=
ection.
> > > > >
> > > > > Is there any reason we continue with this behavior or is it just =
that
> > > > > nobody ever sent a patch?
> > > >
> > > > Back in November of 2023 Eric did merge a patch to bring the
> > > > processing in line with section 4.2.3.9 of [RFC1122]:
> > > >
> > > > 0a8de364ff7a tcp: no longer abort SYN_SENT when receiving some ICMP
> > > >
> > > > However, the fixed behavior did not meet some expectations of Vagra=
nt
> > > > (see the netdev thread "Bug report connect to VM with Vagrant"), so
> > > > for now it got reverted:
> > > >
> > > > b59db45d7eba tcp: Revert no longer abort SYN_SENT when receiving so=
me ICMP
> > > >
> > > > I think the hope was to root-cause the Vagrant issue, fix Vagrant's
> > > > assumptions, then resubmit Eric's commit. Eric mentioned on Jan 8,
> > > > 2024: "We will submit the patch again for 6.9, once we get to the r=
oot
> > > > cause." But I don't think anyone has had time to do that yet.
> > >
> > > Ah.
> > >
> > > Thank you!!
> >
> > For the record, Leon Romanovsky brought this issue directly to Linus
> > Torvalds, stating that I broke things.
>
> Just to make it clear, Linus was involved after we didn't progress for
> more than one month after initial starting "Bug report connect to VM with=
 Vagrant",
> while approaching to merge window.
> https://lore.kernel.org/netdev/MN2PR12MB44863139E562A59329E89DBEB982A@MN2=
PR12MB4486.namprd12.prod.outlook.com/
>
> Despite long standing netdev patch flow: apply fast -> revert fast, this
> patch was treated differently.

I was waiting input from you. I think you only waited for "revert first"

>
> >
> > It tooks weeks before Shachar did some debugging, but with no
> > conclusion I recall.
>
> Shachar didn't do debugging, she didn't write the bisected patch.
> She is verification engineer who was ready to run ANY tests and try
> ANY debug patch which you wanted.
>
> >
> > This kind of stuff makes me not very eager to work on this point.
> >
>
> OK, so it is not important at the end.

I certainly do not want to waste time arguing with you on a valid
patch, which happens to break some buggy user space.

Apparently some people think RFC are not important.

You won.

