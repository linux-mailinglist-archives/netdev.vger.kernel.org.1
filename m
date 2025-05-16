Return-Path: <netdev+bounces-190910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A4EAB93A2
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 03:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894614E828A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDD6135A53;
	Fri, 16 May 2025 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bw5rO1pn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175BE8BF8
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747359119; cv=none; b=BxbTjBVD7mtH6UTSg/b4f2a7VXKa9nX1iU5iohetEF+cXSKaJmM8AqcV6KB4uZXw5bwGhekO9Cka1YIEkmza1lRJdxxKRvf4IML8CCYTXC6s2XxKacunw6PHyCEPa3cXpOwXZAKsXYY7PLQ4QxC1keskKgnzFOWN9uAF+MzRJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747359119; c=relaxed/simple;
	bh=dHG8gFthP6572iwZ9voMYp5Nib09yecuPF2Kb1mF4Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sg+HafNjiGoacq/c9yxE/ASTNxQKrxx0gvrdO0YH6GPFvr8ETQoNMNQ31/coaKyiZXGmga1KbeMQ16oG3GOGVl/zcpbjzNwIjd70wYIa8ln6ialMhTVbxtZdTd+nK8eoBKzaAGRpRyR0LxiDIIeEeAsfS4coc8BeP/bfukcGK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bw5rO1pn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747359117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHG8gFthP6572iwZ9voMYp5Nib09yecuPF2Kb1mF4Lk=;
	b=bw5rO1pnZ7Wo4/tkIcgtAs0jimnAI2iXR9u+RcBTXYjlP955tYKXr/VZ8j2ZpCnbUXSquy
	z4cr+5q1rqH7PVqLDifS3I2mUjaGkM60qEcBxrsNKnb7w437z3qd7WgwzdKbWjYvdP7heF
	MVvnBw258OOW0wXyrnenhsoUiwCSd3c=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-FPTPmqhTNkassZ-Bsc8IDQ-1; Thu, 15 May 2025 21:31:55 -0400
X-MC-Unique: FPTPmqhTNkassZ-Bsc8IDQ-1
X-Mimecast-MFC-AGG-ID: FPTPmqhTNkassZ-Bsc8IDQ_1747359114
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b26e73d375aso1089740a12.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 18:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747359114; x=1747963914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHG8gFthP6572iwZ9voMYp5Nib09yecuPF2Kb1mF4Lk=;
        b=RXOMaL6ct/vZwIUUiw0k6MHF0zR7FpcP/rswPmhJ/y0UN9v2hrnzyOKJeNi06lJ3aN
         9v4v/a77uzMwonqWt/ZljIsza1aqM9P2/atKU+jlJc/rjZG1ekraEEGEjQ6wwoS/KaCt
         pp96zyhI5n79D1AW8okgwVL2NsTwa/y1TSRuMON/3Ro9ajHyduWVT6XieHeNcSyBamjG
         Nkfi8oDPa/IMX9Q6VmHozMsAXlsOv1PRNg2Xesd2h0G5wt4qfZPmPlz9c7nXnPkISqW1
         f1fuaa/VsXrQTizr/N33oLUuOOtV4irBr4+7OgUoULYYrbKTR88zpp6cM63wl4x5KB7j
         kMxw==
X-Forwarded-Encrypted: i=1; AJvYcCUcOzoVrNlVvTPT0OQgb3vi5as2PqAeJPIrwSQuKDL7PesIJuSD8o193OX5IfNHkBTknS68MvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5YHzGldCnTvdS63A5EnX+/UA3RsseJ/vIKQ8GvsZQ+876AyJ
	ZT7IvWirDzPdTmPcy+SYcYnv8KgMdm/54Ve8W6V/GbW04yv65pag6ivnyUwAflOJFlwNbl2EFKy
	vhCcyRIby5i3Yf/IuJudZ0HQuEVljWYs4wWUtBe3Oh51aFwYyYzopkDcjRt5Gy0qUFESqqoYGp8
	NZxSzJz0gH4ipS0/DxKBHJIEcovbSqIT5l
X-Gm-Gg: ASbGncu3vKbkO2UwkOrvqxu6UE6+wVhZbnI5REXFXArr5+goOdVFETB0pKEimlGooKx
	rWna97SnUjcP8wOImG6kZ7v9qjZf2ekIvuXAZUeVfg4kmgLndXZs283Mcv72fqea2VEDueg==
X-Received: by 2002:a05:6a20:7f86:b0:1ee:ef0b:7bf7 with SMTP id adf61e73a8af0-2170cc8f33fmr1031909637.19.1747359114244;
        Thu, 15 May 2025 18:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF/mXKGt3zwINJmfa+xjHZQcL10bzBEwpDZkwgSC7ZysZq48EWkzUMi17HyPYSwG2Bt/eIh6oHKkky9X9+jac=
X-Received: by 2002:a05:6a20:7f86:b0:1ee:ef0b:7bf7 with SMTP id
 adf61e73a8af0-2170cc8f33fmr1031878637.19.1747359113861; Thu, 15 May 2025
 18:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421024457.112163-5-lulu@redhat.com> <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org> <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org> <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
 <20250513030744-mutt-send-email-mst@kernel.org> <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
 <20250515021319-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250515021319-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 09:31:42 +0800
X-Gm-Features: AX0GCFv_WBgAJTVQmI2TBtXitRDIMCU2f2R8aDmTo2xnqxFw0aP_mhb-qMjj5ag
Message-ID: <CACGkMEvQaUtpsaWYkU6SC=i1tXVbupNrAVPBsXm3eMfAJHzC=Q@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 2:14=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, May 14, 2025 at 10:52:58AM +0800, Jason Wang wrote:
> > On Tue, May 13, 2025 at 3:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> > > > On Wed, Apr 30, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > > > > On Tue, Apr 29, 2025 at 6:56=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > > > > > On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <jasowa=
ng@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jaso=
wang@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu=
@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK=
_OWNER_IOCTL`,
> > > > > > > > > > > to control the availability of the `VHOST_FORK_FROM_O=
WNER` ioctl.
> > > > > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n=
, the ioctl
> > > > > > > > > > > is disabled, and any attempt to use it will result in=
 failure.
> > > > > > > > > >
> > > > > > > > > > I think we need to describe why the default value was c=
hosen to be false.
> > > > > > > > > >
> > > > > > > > > > What's more, should we document the implications here?
> > > > > > > > > >
> > > > > > > > > > inherit_owner was set to false: this means "legacy" use=
rspace may
> > > > > > > > >
> > > > > > > > > I meant "true" actually.
> > > > > > > >
> > > > > > > > MIchael, I'd expect inherit_owner to be false. Otherwise le=
gacy
> > > > > > > > applications need to be modified in order to get the behavi=
our
> > > > > > > > recovered which is an impossible taks.
> > > > > > > >
> > > > > > > > Any idea on this?
> > > > > > > >
> > > > > > > > Thanks
> > > > >
> > > > > So, let's say we had a modparam? Enough for this customer?
> > > > > WDYT?
> > > >
> > > > Just to make sure I understand the proposal.
> > > >
> > > > Did you mean a module parameter like "inherit_owner_by_default"? I
> > > > think it would be fine if we make it false by default.
> > > >
> > > > Thanks
> > >
> > > I think we should keep it true by default, changing the default
> > > risks regressing what we already fixes.
> >
> > I think it's not a regression since it comes since the day vhost is
> > introduced. To my understanding the real regression is the user space
> > noticeable behaviour changes introduced by vhost thread.
> >
> > > The specific customer can
> > > flip the modparam and be happy.
> >
> > If you stick to the false as default, I'm fine.
> >
> > Thanks
>
> That would be yet another behaviour change.

Back to the original behaviour.

> I think one was enough, don't you think?

I think such kind of change is unavoidable if we want to fix the
usersapce behaviour change.

Thanks

>
>
> > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > >
>


