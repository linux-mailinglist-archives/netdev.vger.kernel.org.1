Return-Path: <netdev+bounces-190619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F31DFAB7D89
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D91B176A77
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 06:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D0B28032A;
	Thu, 15 May 2025 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiuQP/5r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A251B3955
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 06:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289181; cv=none; b=S1ZKGeey1N3jCu1wbU11ZDIB80JSz7hKMaylcHvh8sOZjGcxE8feJWxGSReVn34Hc1GE3NdiMN4uOaqggX5dZ/PdmVQpKwejblZWBqxHJb7pWOmZNgJ5nKqNFiyqz7dotvMMJBo/hVFrF1KCpLzpjyoHRgSVF4w6TtrXs4Hc71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289181; c=relaxed/simple;
	bh=KgjVcgr/14LclEpcLsxeXxOySrceHDQLswBb2FensOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDb7EV7UO/9TFrUZDDHvL0quXbEOSKSAo2jii7ev/F0nOHA0iSXN73a3l/gPgArq5Vt/P43UJgUPfuPVtzWQ21zdM4TswdH15X0c+QxVm7ZmK1PIsv84VYQxIGd4LLjPRWkcQ9UxFMfydTEQixFM0ePCmatt5PlYzqRf9zIjcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiuQP/5r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747289177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KgjVcgr/14LclEpcLsxeXxOySrceHDQLswBb2FensOs=;
	b=CiuQP/5rj0Xq4u/c2uBBd54Y7tCEXOerKGd5Fii5z0fnV9bQFH3oM4OxGIqMstksOzV0Ox
	pjFMTVWuoqPoSU6gB5wN/bBqZgSmIcAk8SM5K6UTYfklFYy8ZthztaYTC/7xryU1rEojHK
	1AjEoaCXuhKwOudmQASqF4gqXQw+M1Q=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-GKRjLZgNOJm4XNbW1YQxpg-1; Thu, 15 May 2025 02:06:15 -0400
X-MC-Unique: GKRjLZgNOJm4XNbW1YQxpg-1
X-Mimecast-MFC-AGG-ID: GKRjLZgNOJm4XNbW1YQxpg_1747289175
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-87835c2ba43so44031241.1
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 23:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747289175; x=1747893975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgjVcgr/14LclEpcLsxeXxOySrceHDQLswBb2FensOs=;
        b=SWSfByUYphqyyu2X23BisirWivyjXQTaAZLXNGl/4PKvmihprpqxZyhgjLxCjcUR9m
         VcJAZVHgkEp4O8cktwBrmkT3kStfFowLRTGq+R315d+naIhOJQS3v628MG/j5Diw2HJe
         0haE2zNSRlVBcrQz73VLN4Q4RjNJKVVJq9ROSJcxBOhm5MMXQ9XvQmmPhTJ36lJ7+Lx5
         T4qibmL7jniLZ7Iw7B/O8o2dAoMv0xNk8klkqKtmmY0SUYd1lWexSjDRlljZ7nZte9ae
         W7rXn+c+fLM055ThGz7WdXOtCJdGcgUSH1oAu08cLMLmM5wSXm0hnQYAXXQjgmdg6+OV
         BPIg==
X-Forwarded-Encrypted: i=1; AJvYcCVyodiuB6vfBLuaKra5RlzHqrdyOmxSx4A/2K8oVcok3wVbn880vcjRpBqbCKNhH4/B+00q/hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyJND0+55GNdgudqwuaA8ogQr/DyQvRaH8RS7kFoE/h3+UmZi
	lDaKpSTwRrhUDXb3imBSzW0VQgcDP9HhqdCAPCGuMhX4ZK85SCSEk8172MyldBkVee828xXjqt5
	o6vD5lLgRXN4pN2FWhlBhAd+dAF22h0A6qWH+J/QddaIkgmYVvK3lPWLYUZ6/4aYdCtvmwX+mZE
	UcH9idHhW7Wl7pMK5kFlXa+g2zveN3
X-Gm-Gg: ASbGncuR5RiMl30EoCgFbDOihrHlMfvyJH/2grvP2FycpXkbemKcVPSKX2BCGSWWj9q
	Kj9JjwmU+1spCA/MH4bOO9NP2C/Zu24mR6/b8sR2Vcc9qs2IFpuX0BIH+VPSxsSw1zS9Fag==
X-Received: by 2002:a05:6102:3e26:b0:4d7:11d1:c24e with SMTP id ada2fe7eead31-4df7ddd4266mr6046454137.21.1747289174761;
        Wed, 14 May 2025 23:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIP+CRMt7SY3lS0FZeE06/dgVCIbatM2gkAuNCY5+ReAryTvEEPpoJydTxKcT2SH/Us6iz+8kk5C0x0X/14DY=
X-Received: by 2002:a05:6102:3e26:b0:4d7:11d1:c24e with SMTP id
 ada2fe7eead31-4df7ddd4266mr6046447137.21.1747289174433; Wed, 14 May 2025
 23:06:14 -0700 (PDT)
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
 <20250513030744-mutt-send-email-mst@kernel.org> <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
In-Reply-To: <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 15 May 2025 14:05:37 +0800
X-Gm-Features: AX0GCFsXKSChOXDfZIrQa40yvOWdPl0wYiICvr05EheIP_f5Oktdl93IFH2XEdk
Message-ID: <CACLfguVGmQ3FzhheCfe55m+SG-kvNXsJ-YopkiBAyLCvkp81dw@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the comments; I will prepare a new patch version.

Thanks,
Cindy


On Wed, May 14, 2025 at 10:53=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, May 13, 2025 at 3:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> > > On Wed, Apr 30, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > > > On Tue, Apr 29, 2025 at 6:56=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > > > > On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jasowa=
ng@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@r=
edhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_O=
WNER_IOCTL`,
> > > > > > > > > > to control the availability of the `VHOST_FORK_FROM_OWN=
ER` ioctl.
> > > > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, =
the ioctl
> > > > > > > > > > is disabled, and any attempt to use it will result in f=
ailure.
> > > > > > > > >
> > > > > > > > > I think we need to describe why the default value was cho=
sen to be false.
> > > > > > > > >
> > > > > > > > > What's more, should we document the implications here?
> > > > > > > > >
> > > > > > > > > inherit_owner was set to false: this means "legacy" users=
pace may
> > > > > > > >
> > > > > > > > I meant "true" actually.
> > > > > > >
> > > > > > > MIchael, I'd expect inherit_owner to be false. Otherwise lega=
cy
> > > > > > > applications need to be modified in order to get the behaviou=
r
> > > > > > > recovered which is an impossible taks.
> > > > > > >
> > > > > > > Any idea on this?
> > > > > > >
> > > > > > > Thanks
> > > >
> > > > So, let's say we had a modparam? Enough for this customer?
> > > > WDYT?
> > >
> > > Just to make sure I understand the proposal.
> > >
> > > Did you mean a module parameter like "inherit_owner_by_default"? I
> > > think it would be fine if we make it false by default.
> > >
> > > Thanks
> >
> > I think we should keep it true by default, changing the default
> > risks regressing what we already fixes.
>
> I think it's not a regression since it comes since the day vhost is
> introduced. To my understanding the real regression is the user space
> noticeable behaviour changes introduced by vhost thread.
>
> > The specific customer can
> > flip the modparam and be happy.
>
> If you stick to the false as default, I'm fine.
>
> Thanks
>
> >
> > > >
> > > > --
> > > > MST
> > > >
> >
>


