Return-Path: <netdev+bounces-80747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68C1880E83
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 10:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB8DB226AD
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAB93985A;
	Wed, 20 Mar 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcGUZ0du"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B153A1C9
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926745; cv=none; b=Fwm/EbHiYSUxHuQOZxM1dOBR04t3BnilEhBcuC4pWfWHdG+Sai+/cNtfoJn7+OY5VJ52Amq/u4O2ICkuL4KUQRxzM2INFuHEjWCl6B/E9X/X8WVV6j/jI+88X4yNOR8tirnxa6tETfLE6902dCh908lHlhWVDWOnPELz96pAKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926745; c=relaxed/simple;
	bh=56rDbNCxI2vOSQbDeXQzX5eiAqbmjduUur3AvBWEm84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtP1UI5mBNXQkCXGbyDvse52KaK7pxEtjwPXB4R/0vSLkg09Tno4BFBijpHMRQT/EwZPpY/8aMuLYGmKekPK9m4NEHLrRdaM6TZyyPuQLrgrFWzNLI0Mjmp7I+9cl4RljKemZWMxbwdI0FmixLVqwI73AORFx1GcywLv1DrivZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcGUZ0du; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710926742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56rDbNCxI2vOSQbDeXQzX5eiAqbmjduUur3AvBWEm84=;
	b=QcGUZ0duC3FRAqMOPpr3TG9rBeD2cxr8zRLgSl4KQnqg3EJqVYB7r8qoIV0LjFBHbRCwDK
	z9EtGHcWisQVwwbFQG9KF4v9KPLQDCfWJJayimUR5m97wlywtqUbc6sjOdpNX+G1v6pcrd
	P8NBFlzRj0bxKJdbkNucJ8QgE11ZZdc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-1IM9ZUayPbW08lPCw0rECQ-1; Wed, 20 Mar 2024 05:25:40 -0400
X-MC-Unique: 1IM9ZUayPbW08lPCw0rECQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29ffd8d4ba4so274871a91.0
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 02:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710926740; x=1711531540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56rDbNCxI2vOSQbDeXQzX5eiAqbmjduUur3AvBWEm84=;
        b=CSJ/6zbwAQvcZTytnsfedb31LTdSRpdDGEQ02wE98g50LbOza1iP9mo04VMP1q/tbu
         OEWltQnrdzPEthANKNzXia/w8FeZPUg7XQnmG3ALZ+pTT1OqEaLwN3zBqwnVu/m7crr6
         n1gVW3Czzf9/GtWuizuHOK0sRJI29NC75fCeTcd7PtzdwHwwlkq194aNYeplAhmU74aY
         /Oh7p0ta1p2XgcNsqvX0HwSEBjox+kwde5EmrZ/hFbgvwegNhc9ClK74vYlxOmqmMw6C
         RYuKUBzPAuwfjLT9tTS7vXjlkcsiG6tcnGX6P4luF7WUs00jSsxC0kTX+40NvMC0PM7o
         B/1w==
X-Forwarded-Encrypted: i=1; AJvYcCVOFq6x4ByBWc3hLLYfltgQ9KIoqLP+Xd1GxlrE4aCodE0zgCcO9sLwThxjcJvarExwfw/XHtBjacr8D5EzRmJ2GpBIresF
X-Gm-Message-State: AOJu0YyRLcm99XW9IqwCB+GWe+L5IVHhNiWARrj7q3IJkYS68/HVpkdc
	eYIMV+R6/5jilVqE3Tui5ji7mVWx5VkB2ghJCbacwglDwFiq8hXkE7VUvIdXgGNNwpRYkQlLpyG
	cdJN9olDy2O+WjDMMLagWaYzCGGhb2ubMSoF2ZGTZl92VlKZbSlWoHX/zl9KShhe7cQysQM3HOf
	epMpQlr3jKw3gEfEila4vXl2H7edUt
X-Received: by 2002:a17:90a:17a7:b0:29d:f2a4:e634 with SMTP id q36-20020a17090a17a700b0029df2a4e634mr7459312pja.19.1710926739664;
        Wed, 20 Mar 2024 02:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYQGKoaDn72eJo80nDHf8Qb569J1Tx6XzB9bumhyiEpIYi7ZoXTwtMeJQLvDU+wGiP8dnwl3Smsj+VIVEE8uw=
X-Received: by 2002:a17:90a:17a7:b0:29d:f2a4:e634 with SMTP id
 q36-20020a17090a17a700b0029df2a4e634mr7459289pja.19.1710926739348; Wed, 20
 Mar 2024 02:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com> <20240319025515-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240319025515-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Mar 2024 17:25:28 +0800
Message-ID: <CACGkMEsELwxC8sqRfNkVQbxHj9RL8aWV2z5qV_Tw6Ln-GM9Kzg@mail.gmail.com>
Subject: Re: [PATCH vhost v4 00/10] virtio: drivers maintain dma info for
 premapped vq
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Mar 12, 2024 at 11:35:47AM +0800, Xuan Zhuo wrote:
> > As discussed:
> >
> > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rH=
YqRZxYg@mail.gmail.com
> >
> > If the virtio is premapped mode, the driver should manage the dma info =
by self.
> > So the virtio core should not store the dma info. We can release the me=
mory used
> > to store the dma info.
> >
> > For virtio-net xmit queue, if the virtio-net maintains the dma info,
> > the virtio-net must allocate too much memory(19 * queue_size for per-qu=
eue), so
> > we do not plan to make the virtio-net to maintain the dma info by defau=
lt. The
> > virtio-net xmit queue only maintain the dma info when premapped mode is=
 enable
> > (such as AF_XDP is enable).
>
> This landed when merge window was open already so I'm deferring this
> to the next merge window, just to be safe. Jason can you review please?

Will do.

Thanks


