Return-Path: <netdev+bounces-190291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5E9AB60EF
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 04:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F75863B40
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 02:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD351DE8AF;
	Wed, 14 May 2025 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKljr2X0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092611862BB
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747191195; cv=none; b=NlJH0Tp6nWtDMksFO+VoCrQTLdndnxNaUvxLEzUA09zQx68NCRWSZNVjG8huFZVE4DDROV6MNriz6i6AEwRBZpniQ41UNi4OBHm0ptli+wyf/Qm9ujxMDd12s49kds2qEvZK3+1p/x5T376LbRO5+jX8mNn/duN/2ke3kL8yxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747191195; c=relaxed/simple;
	bh=xYePPpPHItj0zqjq4MOZdgAxeW4nYpts1pf20lbhHIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjwUUDUva59it6bLQmSfvLHF+Fa2RecWocPxFpr5hr8NqZNSGZK3TTjuR32KuZDKitvZToGCJlXnfANW5DOYJz7VWkr3/ldIHNK2mjFH3m3ybpxG+4/AFJK9V01a19g7+yznM38ceWCHJbgdfErP5LXX8IkhDbbJBP1/4MVFFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKljr2X0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747191192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYePPpPHItj0zqjq4MOZdgAxeW4nYpts1pf20lbhHIE=;
	b=gKljr2X05hpo2MZUkwvznELECYemO2XSW9nT4xj/lBN+rp3aqGH0DcGSYIvnd4ja1w+eD0
	IRzDMvVaqgP68AiWPEHx3l/7b74O60u0TgNeWXIqmTYq9McINSpuzMkg9b6VqckiTQe6EI
	DqE68A7/0TtetMpOelAlgiIbfKf0SUQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-H4Br3NT_PE-pe2AgQfKb1w-1; Tue, 13 May 2025 22:53:11 -0400
X-MC-Unique: H4Br3NT_PE-pe2AgQfKb1w-1
X-Mimecast-MFC-AGG-ID: H4Br3NT_PE-pe2AgQfKb1w_1747191191
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7425168cfb9so2909330b3a.1
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747191190; x=1747795990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYePPpPHItj0zqjq4MOZdgAxeW4nYpts1pf20lbhHIE=;
        b=u+f19K2guHzJ2X6P4MzlgbJVw0GBsLcfC6Ml62eZG89rVg/Juh2zCeauXL1H3CDqqa
         eOOWP/db0EztmCoqXDxRLsClQZt4mnclD8XtBhfGmwjvqmvW1093g1n0lIVlnsP3BsJV
         wO3DmmZQ6TOgyWRyPzl2HILtrHXJvx0d8YUyEK8ZjY74Nrj6+izStaAxrohx+OAN5MnK
         c1iTKmiwfQ+I4YEQnvtBwlNZFDwki1od0100HeQME3yTum67EIsnU+BseY7TJu7qo80u
         feqNF2x2AAcLSU5iBTTr96oi4P03TsZm1uFdc2bPbBz4VuMPxXyASwiCHAEucy1jKMOn
         NTdw==
X-Forwarded-Encrypted: i=1; AJvYcCUTMX1eRz9iUifki9ARfvoHQr0DabfSryep8lzAqKYEvlDuQ7+EtQpugwX1JiGQ03TYqCU7rNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPpYs/etvEziao4X0sVoN0MJ0z8K4Mtv0QbdU1qLsE77P52Zn
	2PDYFWi1efJ22RPVDgzHowqUU+cVVbUxjLEkr8xq8Zwn7clJBu+Tkb7kNPEu8H4RRH2JL1D+lLq
	AUUp/RGyJ+vu5XT6bJV9zAvbNdHgs5nK7+z2hnFx3IOve0eZDiXqcQtYzDLHocX5pR3CXHGL4YH
	uy2L+qvunKEbwbKw991rDMFf6nUd1O5kMm9YvKAmD9Pg==
X-Gm-Gg: ASbGncufnBlvAEsdeTWPFIeGxoMez8l19mzZYV4XzCDQy/EIq/nltGF98rvjuOEbuGx
	LaiGQJ1FbxKsHCnMzaWDnv4t+0Gj5cWQCWk1o2cLX3XICpLonuozhFVEP3StJXjneBmzv
X-Received: by 2002:a05:6a20:914e:b0:1f5:591b:4f7a with SMTP id adf61e73a8af0-215ff1b7394mr2148411637.38.1747191190493;
        Tue, 13 May 2025 19:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2O008aj4wY4jbfsuG0wQx0LXJQV1rEC9uHaXpFHGz1hfmWDBVT1BMyztM8wnp7Gb2O/DG75zfCtDsXFNVRAs=
X-Received: by 2002:a05:6a20:914e:b0:1f5:591b:4f7a with SMTP id
 adf61e73a8af0-215ff1b7394mr2148385637.38.1747191190148; Tue, 13 May 2025
 19:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org> <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org> <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
 <20250513030744-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250513030744-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 May 2025 10:52:58 +0800
X-Gm-Features: AX0GCFtQFTgm4lfPZmx2Tv2n376ohKx-feV8h7AANGb3bjp34mVypcbh1YB90e0
Message-ID: <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 3:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> > On Wed, Apr 30, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > > On Tue, Apr 29, 2025 at 6:56=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > > > On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@red=
hat.com> wrote:
> > > > > > > > >
> > > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWN=
ER_IOCTL`,
> > > > > > > > > to control the availability of the `VHOST_FORK_FROM_OWNER=
` ioctl.
> > > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, th=
e ioctl
> > > > > > > > > is disabled, and any attempt to use it will result in fai=
lure.
> > > > > > > >
> > > > > > > > I think we need to describe why the default value was chose=
n to be false.
> > > > > > > >
> > > > > > > > What's more, should we document the implications here?
> > > > > > > >
> > > > > > > > inherit_owner was set to false: this means "legacy" userspa=
ce may
> > > > > > >
> > > > > > > I meant "true" actually.
> > > > > >
> > > > > > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > > > > > applications need to be modified in order to get the behaviour
> > > > > > recovered which is an impossible taks.
> > > > > >
> > > > > > Any idea on this?
> > > > > >
> > > > > > Thanks
> > >
> > > So, let's say we had a modparam? Enough for this customer?
> > > WDYT?
> >
> > Just to make sure I understand the proposal.
> >
> > Did you mean a module parameter like "inherit_owner_by_default"? I
> > think it would be fine if we make it false by default.
> >
> > Thanks
>
> I think we should keep it true by default, changing the default
> risks regressing what we already fixes.

I think it's not a regression since it comes since the day vhost is
introduced. To my understanding the real regression is the user space
noticeable behaviour changes introduced by vhost thread.

> The specific customer can
> flip the modparam and be happy.

If you stick to the false as default, I'm fine.

Thanks

>
> > >
> > > --
> > > MST
> > >
>


