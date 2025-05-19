Return-Path: <netdev+bounces-191400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C5ABB640
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC6F1896558
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731DE266F1D;
	Mon, 19 May 2025 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbWxFEmS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CB265CC9
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747640109; cv=none; b=Gx9JCOJbtpgGe8ShEMq6RmsqnS66yh4d9APRFj1hMy23RkqpS5Kan11pe5jwULAUVzUA+IC9KiDzXMqHYL5izXSZwS5OBI92ZrNnZJQjL8qWVYhlIaezwvfOMDvF4i73ccDmQIpVCPKI2NatknWsh+M2AcK+tOde+ajB8twawhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747640109; c=relaxed/simple;
	bh=+GWWr5RiqW6nfGpNUOrgJWmEkayVvBy0v+dsRdLauRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQxD0uOkFd/qvE7hxIE8YmlNoeMX1bo5gpyhUIExwVYCjLriiBtlGS0c+8dchjPvVmVA562u3FTs/eP4aPXzdUY3RkMegKqr1fVmvmotPckiwzPm1WcZghQNX01v56rMUZATROFUbLiVbr4oUrYYynlvUm4XW5qlmfYxvLYKhkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbWxFEmS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747640106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GWWr5RiqW6nfGpNUOrgJWmEkayVvBy0v+dsRdLauRc=;
	b=HbWxFEmSD8gKg7tseA9mA6dg7+z1gVh22QLQDPG03Rw+rlMUHf6KXV5oWC/megZdw00u9S
	dB6GiUNT9c+NlL+hCwnoDhMhXqbo9LC+IjFe0AY5yysU2eyFLGS8bFkVcOXPFJBTnlb7Bb
	+WqYVK9z9pcSq0izezZ5bRO8AXOL3AU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-M1AbbX_2ODyrfmZfg-0fAQ-1; Mon, 19 May 2025 03:35:02 -0400
X-MC-Unique: M1AbbX_2ODyrfmZfg-0fAQ-1
X-Mimecast-MFC-AGG-ID: M1AbbX_2ODyrfmZfg-0fAQ_1747640101
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b26fa2cac30so1245366a12.2
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 00:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747640101; x=1748244901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GWWr5RiqW6nfGpNUOrgJWmEkayVvBy0v+dsRdLauRc=;
        b=WxxIA78GSfLgqR80pWvuArMqlPctwhzmAlIK0THW+fO8wHYhFyEXk2qNPQ0nqFRLTL
         P0kSGscNZymTP14cx574hnETsKp5wQgxdIOx90Ibig3GHiJltBjNluFY+aeUmkQ8WgIv
         /pKE+0xalyMg/TRhiSZ7v8YSHegDeqjyWz552P/QpDfr/1bdj2mi4MKgTNYLe725yG2e
         nnb7Y9EWIa/UIeW/t8K+bfs2BQGXnce65aYdZ9kmX38lG/70EnnJ06LP2rLXvfyx6zZt
         NsHUP/1sh5aaJGg0fW/L7wyrLqEGncilduEgYVQiLdDItBb6mmreHhnUBNr7ZNP9uVwB
         Ap/g==
X-Forwarded-Encrypted: i=1; AJvYcCWHS3r3NTIiBeAMShmmHUQ4L1RXbu7etmFi9HOnn5ucJpv+KGqNUHUuz3No1hNjMboVb297a0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX5toUec8g+7iZ/03fGrGm64Qw9Xcd0A+f50slipimRcHMmPL9
	VDZ7EkQVCLzhpgaxW4eETp8djcEgV9Cz6CUuBcjPMpb1111IVGdy+YyE4NfqxuK3VL3gDsEVdr/
	kRWwpx1efy86MI8SU6vNcz7z7eUJtnquXDONtdlc9LtINskBq9eLpVqcdBpHtrx8imVuqfdVGos
	eeXGuFBlPBvuz2u506xXBKkI0lKd0V44YEs/onlCICMmlG2g==
X-Gm-Gg: ASbGncseXqrvrcJwjPlXadLbD2HeLqDN3OeWBfLWhs0oTWP8tCuoK2ZxYgRLsVdeBsU
	RcERarXk3F8Fgv4S3OiKghqSLyoQCnFGUaxkj0VdfRwTy+BYGJueDf0RkTs1AKO3c6cHIHA==
X-Received: by 2002:a17:90b:5344:b0:30a:b93e:381b with SMTP id 98e67ed59e1d1-30e8323efb1mr16994397a91.35.1747640100986;
        Mon, 19 May 2025 00:35:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt9F94wd/fVIMSOApEGXJjgSdwwxfi3SsRD6UvHPFqL4hZL+vGud5MgtJ7RZc3Wd0IkHVmn4mfL7q3qoCrYIg=
X-Received: by 2002:a17:90b:5344:b0:30a:b93e:381b with SMTP id
 98e67ed59e1d1-30e8323efb1mr16994369a91.35.1747640100521; Mon, 19 May 2025
 00:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org> <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org> <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
 <20250513030744-mutt-send-email-mst@kernel.org> <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
 <20250515021319-mutt-send-email-mst@kernel.org> <CACGkMEvQaUtpsaWYkU6SC=i1tXVbupNrAVPBsXm3eMfAJHzC=Q@mail.gmail.com>
 <20250516063659-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250516063659-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 May 2025 15:34:46 +0800
X-Gm-Features: AX0GCFvjL12yu5vbZKoZG0F8FRp_SpNIY-NCfrlEoz_AECElKDPTfAB5-YtQhxY
Message-ID: <CACGkMEscvjHyrWy1PgMOwz8Ys7s2ReX_xiu65WvLyShPubZvVQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 6:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, May 16, 2025 at 09:31:42AM +0800, Jason Wang wrote:
> > On Thu, May 15, 2025 at 2:14=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, May 14, 2025 at 10:52:58AM +0800, Jason Wang wrote:
> > > > On Tue, May 13, 2025 at 3:09=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> > > > > > On Wed, Apr 30, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > > > > > > On Tue, Apr 29, 2025 at 6:56=E2=80=AFPM Michael S. Tsirkin =
<mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrot=
e:
> > > > > > > > > > On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <ja=
sowang@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <=
jasowang@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <=
lulu@redhat.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_=
FORK_OWNER_IOCTL`,
> > > > > > > > > > > > > to control the availability of the `VHOST_FORK_FR=
OM_OWNER` ioctl.
> > > > > > > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set =
to n, the ioctl
> > > > > > > > > > > > > is disabled, and any attempt to use it will resul=
t in failure.
> > > > > > > > > > > >
> > > > > > > > > > > > I think we need to describe why the default value w=
as chosen to be false.
> > > > > > > > > > > >
> > > > > > > > > > > > What's more, should we document the implications he=
re?
> > > > > > > > > > > >
> > > > > > > > > > > > inherit_owner was set to false: this means "legacy"=
 userspace may
> > > > > > > > > > >
> > > > > > > > > > > I meant "true" actually.
> > > > > > > > > >
> > > > > > > > > > MIchael, I'd expect inherit_owner to be false. Otherwis=
e legacy
> > > > > > > > > > applications need to be modified in order to get the be=
haviour
> > > > > > > > > > recovered which is an impossible taks.
> > > > > > > > > >
> > > > > > > > > > Any idea on this?
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > >
> > > > > > > So, let's say we had a modparam? Enough for this customer?
> > > > > > > WDYT?
> > > > > >
> > > > > > Just to make sure I understand the proposal.
> > > > > >
> > > > > > Did you mean a module parameter like "inherit_owner_by_default"=
? I
> > > > > > think it would be fine if we make it false by default.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > I think we should keep it true by default, changing the default
> > > > > risks regressing what we already fixes.
> > > >
> > > > I think it's not a regression since it comes since the day vhost is
> > > > introduced. To my understanding the real regression is the user spa=
ce
> > > > noticeable behaviour changes introduced by vhost thread.
> > > >
> > > > > The specific customer can
> > > > > flip the modparam and be happy.
> > > >
> > > > If you stick to the false as default, I'm fine.
> > > >
> > > > Thanks
> > >
> > > That would be yet another behaviour change.
> >
> > Back to the original behaviour.
>
> yes but the original was also a bugfix.
>
> > > I think one was enough, don't you think?
> >
> > I think such kind of change is unavoidable if we want to fix the
> > usersapce behaviour change.
> >
> > Thanks
>
> I feel it is too late to "fix". the new behaviour is generally ok, and I
> feel the right thing so to give management control knobs do pick the
> desired behaviour.
> And really modparam is wrong here because different userspace
> can have different requirements, and in ~10 years I want to see us
> disable the legacy behaviour altogether.
> But given your time constraints, a modparam knob as a quick workaround
> for the specific customer is kind of not very terrible.
>

Ok, that makes sense.

Thanks


