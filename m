Return-Path: <netdev+bounces-200472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ADDAE58DE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BE04A2C6C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEC3126C02;
	Tue, 24 Jun 2025 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRIw+K3K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7062F2A
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726703; cv=none; b=gRE0rMFXzt4qzrDuB8UUuAgZKr2dlT8MpnU5Dyx6ja5x5prP5EtWmJL8WUuNVDvPlHcFq8dziOh6dGmlLekvgJFnFF2sfK3A/H14YALSaA9AdMmaElr0/wkqjvebiJrAoyyfImsuAkF75lsC2zj8DqwCsG3yXtBaWVdvhgu2S1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726703; c=relaxed/simple;
	bh=crI2KdpBxTyiOor4cigyt5k0bB0F42uVbGkqQawR4mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TElLUTEdJ64Xr2y7iJ7YM29L7ve7p8J1XJ7/ywM0WdT6h3uLYKDKZtS/fvbbXvULw3Nq5WEEvrMi30GpHWpBN4NoAez39eBQ1g5f0xSXzltzb/+pdwUb42avZDExFLYo+f9cOqa2GE9uk7g9Sf0nUi4CsLytaOqtqi6BH5ZrXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRIw+K3K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750726701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crI2KdpBxTyiOor4cigyt5k0bB0F42uVbGkqQawR4mQ=;
	b=iRIw+K3K0Yeann2JRnRZuOSSPnCfbmFIZyrjKVh5IKxAB7EuY5gw3/gVzkVm4oYHyut5Tx
	PRpw1+ygTMySN470ZFnIGoo+GdRo0HOWIj3JhXwDI8Lg9cMPsP5a8GoQSCOlxujTNlHo9z
	iFlbRlSbfJKx9ZrTjP5VxHm9KGqvilI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-QKAmsryDPGi5itrCI4kfxQ-1; Mon, 23 Jun 2025 20:58:19 -0400
X-MC-Unique: QKAmsryDPGi5itrCI4kfxQ-1
X-Mimecast-MFC-AGG-ID: QKAmsryDPGi5itrCI4kfxQ_1750726699
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2358de17665so40403275ad.3
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 17:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750726698; x=1751331498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crI2KdpBxTyiOor4cigyt5k0bB0F42uVbGkqQawR4mQ=;
        b=wN/KiubbaeNEj+S4FiKWCNlsVIk/ir9LDrdQubYThGreZQtGxWIZjOmlfwRofD3a8p
         ISpWb9N6qb5Gt5hIGWajp+Vp4UCYjepfP2csO4uARZETDbGQ+UQJNmK6td6GGj+G7GDd
         fZqTjQXXpIN2oyNvMrG2CC/BtDMJ54RkL6oMqAQHCgAtLC2dlDOioXhB0VpQyjoUAw/Y
         CHEMBvdz3ivJgymzJvyDoPrl+mcTckzZMC7L9xvNAIMSfFtpV7tpulX4xn00eqkzoSgr
         kwHQ44LkkwgM46U0JLB892T4oJznBrOKi8kZEqDfPFB1plpmNPQUMAbWuy+aIPHZfijs
         KDdA==
X-Forwarded-Encrypted: i=1; AJvYcCVa9KXX/QLSZYaSHFrwNUXDFr1iKDlKLKq6pXZ2f/bO7WRMiZZe5RX3NfVFg70aJL4EbAR++OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkscIQ4RZsnU/GzBoVcETwJWHzrUFfSYea3YIxfdZbQ+GTsgR/
	RCTJzJHrHvy9cs3dDopvb8lAFtWqNUh6kWyKP7tyotTxRvH7sD+SEy9tuaDt+g8mWw1FHn4iiMk
	pFxOT9FlhyVfGnC6jnkQ0le0ccDNCqaSRfSiD+szLR7hcdATT4W6zS9KihoCvFQWq9yiLy7JdT5
	BPX3CjiH2q1KIrpAIQlGw9zxrHy6Hdfbu9jRF9oL/MHxhKHw==
X-Gm-Gg: ASbGnctFvtI3WwykxfBQeU/Nqb6IyzIfVDRaSVQ9/K4Sb6nxbEO8BWpqh/0KG6t44iX
	fgn9uVEsUhET3PXp6wH+LqV0kkY6h+dPC25D3gRvZMXecVKFb4HXPbI+WSZK4mZXiGTo+yCP1FH
	0aWO18
X-Received: by 2002:a17:90b:4cc2:b0:311:abba:53c0 with SMTP id 98e67ed59e1d1-3159d64288cmr23066002a91.9.1750726698233;
        Mon, 23 Jun 2025 17:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0TL53ZDwgeSV+DD2GcU3jEI4r/eDHq4FmfUZ/GvS4kXkq5suNbkCfKDj/NwxqjwgnsrCmWvLCvjsuEvH74OU=
X-Received: by 2002:a17:90b:4cc2:b0:311:abba:53c0 with SMTP id
 98e67ed59e1d1-3159d64288cmr23065951a91.9.1750726697619; Mon, 23 Jun 2025
 17:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612083213.2704-1-jasowang@redhat.com>
In-Reply-To: <20250612083213.2704-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Jun 2025 08:58:05 +0800
X-Gm-Features: AX0GCFtX40pdquUIKQa4dMm29AUMnV2mY-tckRUEDH3MEDY23niQa4wXLvV7Jxg
Message-ID: <CACGkMEsphawodd-9XTg8KfYotdLri-3cuSV67F23AOscAHQs6g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tun: remove unnecessary tun_xdp_hdr structure
To: mst@redhat.com, kuba@kernel.org, pabeni@redhat.com
Cc: eperezma@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, jasowang@redhat.com, 
	andrew+netdev@lunn.ch, edumazet@google.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:32=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> With f95f0f95cfb7("net, xdp: Introduce xdp_init_buff utility routine"),
> buffer length could be stored as frame size so there's no need to have
> a dedicated tun_xdp_hdr structure. We can simply store virtio net
> header instead.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---

Hello maintainers:

Are we ok with this series?

Thanks


