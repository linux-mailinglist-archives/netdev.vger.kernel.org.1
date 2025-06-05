Return-Path: <netdev+bounces-195173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA20ACEAF5
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 09:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9CA177BBB
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71AF1FFC45;
	Thu,  5 Jun 2025 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHhplwcz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C111FECAD
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108976; cv=none; b=a8YgGxYLndaQ+vdKg0HypTOyA1pOyVMJqtGqFmKnRp2OGmhCI/ce2jh2QbmFGvBzTDN8O/Me8JQLR8kT/3Qqbzp3y6Kj1Rrjn+PBvsUDHSFoIVvt+X/wWyQYrWyjFgNXw3Tim5KNKsfwtjKPfIW020MeGpEaxu+HlKIeS36yjWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108976; c=relaxed/simple;
	bh=sbqnBmXp4Y55lx0p4/uF+T2QN9aG6Xvg1aq1aLpduzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7jRcEEYMprGgH/woDPLJeO8XX1hLEeX7lFMlYAEXUuErO6xDiibfdQMTOEiFxjFqZgiIFXZZ3dFQvyuaUmObB8lpEEGRu4ycmwL4JHBmuVAYMugdeU0IxnaalZ5DFNgVaamU164wnzUg6OcV46JJ8ZqPHW6QGYBZ8bNp/hviC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHhplwcz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749108973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UEFyEH5OwZcCtsgCpmVtI26aMMlVVtISZXT0NgO0q8=;
	b=NHhplwczOzNeNTMSuF2wghykH+UcEjwkxgmZgOnSV40deGPZol/2HZKAg7Xb0nkhG6O1HG
	0QA0PzryfuJ1MQrR5UlBGORJMXmDMQy5nViyl4xPI5642DSikk5cqcTU4TnZcSVoSSRwKQ
	0x3dbrD1MPRs05ZCdboGGF4HC/OtZEU=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-yrsR5-LlMAufuoKll25GwA-1; Thu, 05 Jun 2025 03:36:12 -0400
X-MC-Unique: yrsR5-LlMAufuoKll25GwA-1
X-Mimecast-MFC-AGG-ID: yrsR5-LlMAufuoKll25GwA_1749108971
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4e59b3940feso106145137.0
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 00:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749108971; x=1749713771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UEFyEH5OwZcCtsgCpmVtI26aMMlVVtISZXT0NgO0q8=;
        b=Jq1gZp//1+pwAYeB01MSJO5Zd/s0R75gdl5HvzizPgs/rELD7KytqAFL0kLhICgboH
         VJWgEVz3z97yW47IUfJuuUhCIik8M2OVJQp+f+xXVgp3aQN3tFnzfrDEEZ2Q1WMjcBRV
         2KoLUm9ZsGHqa9CdV6it4hWBWMcOkbj5RXXoXPQ3Kri+w32C+U+E7tD6VQk4YZd/1SdB
         FvFV2rYlw4kULnJ/uLCY02C8uVLZfxPaMPipQAme+uCah+faz/Z2+6N1Nu1OQCb/s6lL
         qaHzat+P5j/rmbrKxWO4cryCTJMaq2xAd4XqJCceKAN1eLGsevYOF4Mg97NOmLjO/wOz
         EvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMsP+VtdpEapQT7ZOz+8tNomK3mtt+S+EjldD7Icr1Md0wnESYTGGPWZheT/pjx2VeoTTgpv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxEOVkBmWsnvGN9WMMbcSWXsUjobKtmg1ra3NbQ0qSRmsNUIuu
	u/VGihzuaw3q8/KCgXUhj+qIQO/KfwN1EBd8arrwWTYhoYsGIQGp3yaOGYTbI8N/JJnXBz+8xyt
	Eb9PFqkq+AWmnhj/CArXTl95W0ARYVIjGazD0oEvBQhC7hDXi0OBrP4aFn0MU30Gx+lQdl7Ugas
	FEaMxckEaFsKXGLvbJtrcn0pO5l5LKvZFk
X-Gm-Gg: ASbGnctikSkqBOnXdZpp1pgh134QsPhRAxbqg1OsliS1xulxeu2Xy6YCLo7nZrnaX3t
	rnsASZBuz5FgLRwcEq9IPwAf17smGXVw+Rx1PemOoC9Lt3vZW7tVVvuNFjNb8jogOpw0dVw==
X-Received: by 2002:a05:6102:4192:b0:4c3:64bd:93ba with SMTP id ada2fe7eead31-4e746d2f409mr5002981137.11.1749108971349;
        Thu, 05 Jun 2025 00:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhmZvNcFSJRPa1f5R1qRbR6ezlxjfGxuvM5sbmFEDudxzciE5vcVcY/k1vcxfX+gPEARM47nbeOoiyidVDKrY=
X-Received: by 2002:a05:6102:4192:b0:4c3:64bd:93ba with SMTP id
 ada2fe7eead31-4e746d2f409mr5002971137.11.1749108971045; Thu, 05 Jun 2025
 00:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531095800.160043-1-lulu@redhat.com> <20250531095800.160043-2-lulu@redhat.com>
 <20250603073423.GX1484967@horms.kernel.org>
In-Reply-To: <20250603073423.GX1484967@horms.kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 5 Jun 2025 15:35:34 +0800
X-Gm-Features: AX0GCFvt-W8mHusNUhum5I6p4CStc_YDVayaIlpCDLj8gPpi1rBVSY1KA3nbyKQ
Message-ID: <CACLfguV_2Mhy-kxha5nK-GRRge1UZKYJ+21DWOhUFQ5cigeVSw@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 1/3] vhost: Add a new modparam to allow
 userspace select kthread
To: Simon Horman <horms@kernel.org>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:34=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sat, May 31, 2025 at 05:57:26PM +0800, Cindy Lu wrote:
> > The vhost now uses vhost_task and workers as a child of the owner threa=
d.
> > While this aligns with containerization principles, it confuses some
> > legacy userspace applications, therefore, we are reintroducing kthread
> > API support.
> >
> > Add a new module parameter to allow userspace to select behavior
> > between using kthread and task.
> >
> > By default, this parameter is set to true (task mode). This means the
> > default behavior remains unchanged by this patch.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c |  5 +++++
> >  drivers/vhost/vhost.h | 10 ++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 3a5ebb973dba..240ba78b1e3f 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -41,6 +41,10 @@ static int max_iotlb_entries =3D 2048;
> >  module_param(max_iotlb_entries, int, 0444);
> >  MODULE_PARM_DESC(max_iotlb_entries,
> >       "Maximum number of iotlb entries. (default: 2048)");
> > +bool inherit_owner_default =3D true;
>
> Hi Cindy,
>
> I don't mean to block progress of this patchset.
> But it looks like inherit_owner_default can be static.
>
> Flagged by Sparse.
>
sure, will fix this
Thanks
cindy
> > +module_param(inherit_owner_default, bool, 0444);
> > +MODULE_PARM_DESC(inherit_owner_default,
> > +              "Set task mode as the default(default: Y)");
>
> ...
>


