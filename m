Return-Path: <netdev+bounces-228668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8774DBD18D9
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 07:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0FB1893EE9
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 05:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D42DF120;
	Mon, 13 Oct 2025 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBx0NxsD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DBB2DD5E2
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335036; cv=none; b=W5+zH4amiudJlTs4+9TjlQljbcngW22/7PUGp92ifzSppZ8xAULZUdzJF38UASdPstL/2yLpcBjWcPc50DuotgXzwnGqOB/JzFsxxVarKIFGgNysCVhWmEEJAyJbQMjw1rWeCKTr3rbLBbSufSBpe1q1peRwUpGXzHJ7hrwo1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335036; c=relaxed/simple;
	bh=GNr9HIVCO7ET2qTQE2UUyDNtrbTlpLvWSYXgJNwgEz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcaUJkTjL1ecYdRGCT4D6/5NY8PfK54Qzg7XpXfvxVtxMLtpS3BTGf1MZuF+dQIpnXP7eLPguXXqv1pyulD7aXFJAcK4LYE5F4Y2qS5gejU11IziQKhawzwEe2NEVIMBzmmb0ikgB+Xh7ESbuoXkLK9Qz84yvDuaq4RuwXz0cpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBx0NxsD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760335033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTBbY4ERQzfsiR/UCEXfoNcgIIzJ1jIibSchJTMZ+g0=;
	b=SBx0NxsD7GTa7x3T9zHXsOLho8lL3DQxEQFpuGu0V+nC5Cwm4fGj1c0NQGTrOtXNbRMl/x
	oMYMZuxq6H06yYNGXmi4F32dkLQgu3t1HKZJ6Jc2AjHSKOZxCnnKgZudiMFC7GL+KnxVrT
	xY+CZijVXjGp1YGIjbb+wnR4BRgkdOg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-jNXp7bi8PuWrFQH_jjjSRw-1; Mon, 13 Oct 2025 01:57:11 -0400
X-MC-Unique: jNXp7bi8PuWrFQH_jjjSRw-1
X-Mimecast-MFC-AGG-ID: jNXp7bi8PuWrFQH_jjjSRw_1760335031
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27eeb9730d9so84071265ad.0
        for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 22:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760335030; x=1760939830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTBbY4ERQzfsiR/UCEXfoNcgIIzJ1jIibSchJTMZ+g0=;
        b=B4fK9qJ7zI0CHTA9vMLpf4kMX38c2/7mTSmD4c7MvrdNwtcEQwx6bL1vpJxUr6CwRl
         Ac5FQKws9MKfjXDuN61q3CcU+KbxRMeivPFLGG4XDEVAjG8kYUVTLfu82a/YQB1PtaeF
         YjQ60xjwmMRMdSLLal80unNpEqYsEnjpCCJvBvR/LA1Cax5clmSEAgaSqAqWPWjIvg0h
         2Xds7EX+2uzq1sTf3G8Xk/5RxiXIUTr9C2lPCl/Fe9QGGyraNDPewCmyhPCP4X25D17d
         LX5BfVweJQcjGc/KWn13I0X2ySPg5f9qS8FI6aXRhpX3GSMoiOM2BKh4tCZs/3BR3zHM
         koEw==
X-Gm-Message-State: AOJu0YyRQL/FMehuAgpYRop00S3vDy6bbjaPs8XB6D4TMt8SXmCZd9q8
	hHhUxM+FMM3eRPVEimZ3mamJB/3zSSA2i4UPHY9mFTKgn6QlsCYYH8kD6+nQqxa8TziB1AkZBZD
	5eMvK8otm8Ar/G6+aik8wPqy0/O0pYNG5dD4uyYCjosk5BVF3ent7MAYgZposfiz1woXGwlPQS3
	C5NT+ODFEicbEzfbRAzV9C57ZwmLvZyw5r
X-Gm-Gg: ASbGncu0YaBtfSIaTWm0iP5wDFzO7Mo1m/Yr6IEMXlCByA86xT1NBP+z/AUssrb5upC
	sU37CXCQRABbOQyxVjFmk8mHm9WD+gH2ihp0ekmhJR90ETOMx5SbrQplTk/KH+ukc0RID60FwNm
	mDnQKArSQK8B7xiq5mOw==
X-Received: by 2002:a17:90b:33ce:b0:32e:ca03:3ba with SMTP id 98e67ed59e1d1-33b513b233cmr25472474a91.22.1760335030540;
        Sun, 12 Oct 2025 22:57:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+1ASVfPg+lv3jSt18c0CP35x0+AGwhiwZAYn/wCujwDEfGVeBA93XTgv9bz62fD/SkCCE1X0vWwbHFagz8RU=
X-Received: by 2002:a17:90b:33ce:b0:32e:ca03:3ba with SMTP id
 98e67ed59e1d1-33b513b233cmr25472454a91.22.1760335030144; Sun, 12 Oct 2025
 22:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Oct 2025 13:56:58 +0800
X-Gm-Features: AS18NWBMAKf3DfwXNPEeWec1id0-xVBudV2t5aLXFJknu5e8GZOXPWDvpzof4kY
Message-ID: <CACGkMEugrT0K3LcJsPaN6FDncvBgXRLkG6By8scm8PyABF2BUA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/3] fixes two virtio-net related bugs.
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 10:06=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzh=
uo@linux.alibaba.com
> Commit #1 Move the flags into the existing if condition; the issue is tha=
t it introduces a
> small amount of code duplication.
>
> Commit #3 is new to fix the hdr len in tunnel gso feature.
>
> Hi @Paolo Abenchi,
> Could you please test commit #3? I don't have a suitable test environment=
, as
> QEMU doesn't currently support the tunnel GSO feature.

It has been there.

Thanks

>
> Thanks.
>
> Xuan Zhuo (3):
>   virtio-net: fix incorrect flags recording in big mode
>   virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
>   virtio-net: correct hdr_len handling for tunnel gso
>
>  drivers/net/virtio_net.c   | 16 ++++++++-----
>  include/linux/virtio_net.h | 46 ++++++++++++++++++++++++++++++++------
>  2 files changed, 50 insertions(+), 12 deletions(-)
>
> --
> 2.32.0.3.g01195cf9f
>


