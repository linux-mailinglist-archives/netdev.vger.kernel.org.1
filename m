Return-Path: <netdev+bounces-103900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E290A1FF
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 03:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D391F22623
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 01:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D2117B433;
	Mon, 17 Jun 2024 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9qj6foo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487DD17F4E7
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588916; cv=none; b=Gyr+xFe4bjNvh0VylogR4ZxEHnQDUd6TDDC1Z3afny+I9p5HJ75XWWu5vBzRTvxt4rfo1tu8NeCjYuY8wgm+yMkFSNIN5WmuuepFml/0QGU0Q7W0/57AzgIJejNuB4r0Ppni5EsQSQxyJD8OwSY8d3zhJzrWFKEVbzpu+XusLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588916; c=relaxed/simple;
	bh=qwH5sb3vw4u2639u+bU4F9qqkIWaZ2UhByObXQ3U8j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azg+0Ib7Tode4GDD/74Io3xUDdLPimULvumZlBmMP5E46gUNb+iNZ/Hgpsw7Bh3U03ggRBybycXz4sKmp5w1nDiY8CQrOAAQRiNRzC8lwWEB5X04S5BtETE+n0romLz6dW3qLHa/iX0rzMvbc/Bj6bFKBEhLOsclT1gmKn7fg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9qj6foo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718588914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwH5sb3vw4u2639u+bU4F9qqkIWaZ2UhByObXQ3U8j0=;
	b=B9qj6foott3WrrGsrXh3XsBfCQnr1QuN73X7FjVu1qqpqHgpiFNINgzrBOHnRn7tpaJIi2
	kAS21pnDgqR3gcOqG8yA3zhaZJyZXUVL+e/z9BBggLukrEcGixpPaUdCyrzcFHbxrf8ODG
	zymK6EbM7UCDlEBzic6c+iGcxchkQew=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-Iz4vS3m6Pa-4ufDyx4e8jg-1; Sun, 16 Jun 2024 21:48:30 -0400
X-MC-Unique: Iz4vS3m6Pa-4ufDyx4e8jg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c2dfbc48easo4185883a91.2
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 18:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718588909; x=1719193709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwH5sb3vw4u2639u+bU4F9qqkIWaZ2UhByObXQ3U8j0=;
        b=VpqxbvuaQAvMX4RLezHMNQv23XM1dGylfFvBlSy6h0E+w0SPrtay3S8ouhayv/YA0H
         TwbgssxAKoWIF/abm3bVKdqujRLNPb9HVzv2EkOwQtODB4LNFyB9KipW4PWSZbLfDhRt
         ZWXPKvVYeb5nXJEB1FxVZU5OWHZG+1QGo1ORRECYNjKJxEjr895UFbVHNbirmY+8kaUK
         uh55Ibqc6juomzpc0JvNvantkyJupChx+m7/q29Bv21WaktuQJt5PcqM6NcHpnDaoqbz
         Lda3DvECBc3ZZ5O3rb7hxMEZk1oYKnBttLiQOs9JEu34GTXfdGjGnkJcIVwyCtE0ZHOY
         8Siw==
X-Forwarded-Encrypted: i=1; AJvYcCXOK0ySh8l2omstG56X9a2kzMxBDT4da8ghWnR9Sb7VVCFXS7JBO5gz9eBKvA/ricBuksK/V20yBHAMV2Uxo6dpWbyB2yYd
X-Gm-Message-State: AOJu0YxAjazSF7QWOOOEZe5AN9wZzLBXi8PKpNHMxYb5rcWvRGmoXWWY
	lLF/9lRIauL13JxdnNiEnJNNcIDAM9CcCtaiE8qOnmfoJ+/jO1w5Oqzwb7+vRQDmuJRGNyZSMth
	RhlfPND3ohRY+G6es8YDMQ7d3LKbgxhlR0s+2nkLGbXllHdKlMJ0LvNwdChYFNSnAN10zw1lVrY
	4Lk47jQH1ryzFEthfkSf7HDQf3CtaS
X-Received: by 2002:a17:90b:803:b0:2c4:fc64:6b81 with SMTP id 98e67ed59e1d1-2c4fc646c13mr5027225a91.31.1718588909235;
        Sun, 16 Jun 2024 18:48:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj+RTz1EYy7hweDAE1ICq45L/lGIK63DQpX9VOBUb8HY2SxFjoa3c8mAZlpi5oGyIBYrcUXdO1Y9miqAIgA9g=
X-Received: by 2002:a17:90b:803:b0:2c4:fc64:6b81 with SMTP id
 98e67ed59e1d1-2c4fc646c13mr5027209a91.31.1718588908759; Sun, 16 Jun 2024
 18:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611053239.516996-1-lulu@redhat.com> <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
In-Reply-To: <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:48:17 +0800
Message-ID: <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, 
	mst@redhat.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:30=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> Add new UAPI to support the mac address from vdpa tool
> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> >> MAC address from the vdpa tool and then set it to the device.
> >>
> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >
> >Why don't you use devlink?
>
> Fair question. Why does vdpa-specific uapi even exist? To have
> driver-specific uapi Does not make any sense to me :/

It came with devlink first actually, but switched to a dedicated uAPI.

Parav(cced) may explain more here.

Thanks
>


