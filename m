Return-Path: <netdev+bounces-196817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D1AD67D0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD7F1886AD3
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 06:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DDB1FDE19;
	Thu, 12 Jun 2025 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3vdphlO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE0197A8E
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708800; cv=none; b=a4dT/2DfUydZfk1XZNSW6N1aOjllczBCOwRh6nvsw7D5HaYNGTnl36ea/KQovltkz0DahgjobxSm3+npACwDOUs6VTwH9/5B2RzV72HoDBSiVS0Pyocoz7jDzq+mS+6ySltjLjV0tX0G11THaY32+nyPf+/+jErDDNNHUQVgMKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708800; c=relaxed/simple;
	bh=EJKWY9PXO9AEb/f1L2N3iMJtGt3gECQJ/G5K4KX8CuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGZtOsMEXSF+ECJnoj38abazuVnYSHrkvskwT7b61hEld3JUiXbBf1NJnMfYAzV9N3RJcp++zH/IYz9Mf7es/F2tlYwpvafRwgBpHM4LOBdK539y1wCuVSfW0kEYBQc4ewxWlLFgpGsE9kU53OyEWjODh/j+nxwmDUoqbBkuHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3vdphlO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749708798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=In8v1EfpVjcg2E248nCE4I3xXAAON+cdnDkylyyJFH8=;
	b=e3vdphlOWJpFjGXFpKUAtMcx/V+VC0ym47D+G6b7JPwLRlJ7T0L+gK4gaH5fMuUlLFnaW6
	c+GZ+t9UH2C0nX6ukMt/VL9QbBzfWsF/0RTRHdxtomComDq9QoWkvNQk6LTBxTO8+/JUwE
	Wm6k5Y/oUZrbo3ItclVaA/DGXgleDg4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-oPJ6HynXOPefQWYyuX0VRg-1; Thu, 12 Jun 2025 02:13:14 -0400
X-MC-Unique: oPJ6HynXOPefQWYyuX0VRg-1
X-Mimecast-MFC-AGG-ID: oPJ6HynXOPefQWYyuX0VRg_1749708794
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-73bfc657aefso506549b3a.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 23:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708793; x=1750313593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=In8v1EfpVjcg2E248nCE4I3xXAAON+cdnDkylyyJFH8=;
        b=pOMDeF+a4PhGphCKzmg6T7KB+esmaChsY7h8de65cqiPvZCqcA/5LPWhg6k+KT1CtA
         pGiwU7JhP5oeWMx5Ypka0YPXmJUyszXYiZ+E1gw3DisJH5m/u76650516tHcwTOKq9Nm
         FonX9IMuyP3w/Sj4DbKHrkrKKiBxKoTc8/6LrND/niH6aqUcywxSTA/kmWVdnv/aN3WI
         8n5yInO+YtsnD/QfCGm23Jgp7mKTshaMmwOluRl+O07jDLGysNNHGKLEA2XDGYUsh1P8
         BSH48LGX673N2g6no2t1jt61xUuUDB0dUt7C/pDZDSn5P0girtgtSI8aHK4uwOFlV2pe
         Cz0A==
X-Forwarded-Encrypted: i=1; AJvYcCU6ppbMbhOY2POTOmPju85sPizvTUiSdHjSGBIEJwIzLBpZplv/r2CH4eP9bnEn8p23hk0YSeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp43OvplJDXw2cMMONjdNmlsYzdTU9OiYsyuTOQjRz1VWQ1xqL
	e0DUXLpPMrf41kNb/9rBLk0QNFNyyqGO9IBvxy485NeN7ZjWE1qRrNmfyPJ+VwDeL47ml5iHPgo
	iN/woa4QdljKeedf/lFjjeVetoLtWagAm4lnE0iUplbnBFepVknzj6qCMKXw25glDKdwR5G+KNC
	aC0v1XaOwPwhlsR0nD35vvOK6lbew4MPml
X-Gm-Gg: ASbGncsVdg0l8uD6HUUvoOf1NImsBfaOS90xVvuvPw3DsvrgrPIB8MVvpyazRBYpNwS
	x3bL00iJ2vwWwcQSnLpnTcsDZZwypseGj1/jtLdKExT3xcsKGKFztJtl7REd+iv8HhSEM+ueM1W
	PISow+
X-Received: by 2002:a05:6a00:189b:b0:736:450c:fa54 with SMTP id d2e1a72fcca58-7487e10153dmr2269233b3a.6.1749708793576;
        Wed, 11 Jun 2025 23:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6GGvfSmuAQ9kMEV18/KRIrYuFrvcTgJ6zriYOViLm9mz7ikKRvCvtL51y/UBgyEUqoyUT9U0TXEnim8kM7c4=
X-Received: by 2002:a05:6a00:189b:b0:736:450c:fa54 with SMTP id
 d2e1a72fcca58-7487e10153dmr2269210b3a.6.1749708793175; Wed, 11 Jun 2025
 23:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609073430.442159-1-lulu@redhat.com> <20250609073430.442159-3-lulu@redhat.com>
In-Reply-To: <20250609073430.442159-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 14:13:00 +0800
X-Gm-Features: AX0GCFvcFRxL8oSigntqa1RjBnlkRGKNKVefC9UxsmF9GK_By08eLAA_95tszrM
Message-ID: <CACGkMEvargUzv3DpAYZ+wS1fi_kNVmXppcX0Qtmy85F22z=OLw@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] vhost: Reintroduce kthread mode support in vhost
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 3:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> This patch reintroduces kthread mode support in vhost,
> It also introduces struct vhost_worker_ops to abstract
> worker create/stop/wakeup operations.
>
> * Bring back the original vhost_worker() implementation,
>   and renamed to vhost_run_work_kthread_list().
>
> * Add cgroup support for the kthread
>
> * Introduce struct vhost_worker_ops:
>   - Encapsulates create / stop / wake=E2=80=91up callbacks.
>   - vhost_worker_create() selects the proper ops according to
>     inherit_owner.
>
> This partially reverts or improves upon:
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


