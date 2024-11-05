Return-Path: <netdev+bounces-141861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111119BC8FE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD492832F0
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9010719340B;
	Tue,  5 Nov 2024 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i15H32ef"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAF82C1A2
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798572; cv=none; b=C2Cmqv46AVmtsZPAJn4WM0mi627jtLqshakNQGuWBVgD6vKe138tyvm5BSMftcftDask3oUO+p9m+/l8qyUYs55jjIpwTqQBqC7QitGyLEGsqfCP0VbUbohxniY+Do/maQfbWtETpPwQ89D5nEIKsx/fRxSIjRD/F0Ini9jkPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798572; c=relaxed/simple;
	bh=EF+cUOkjIhI0I2fV5fEeBbZvkl9AhwMOu/7bTG8aM+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnGHJ/aLEGTIvXT1p/ed6NUUfzfXh+RKY+mJGn+hxT8y2hE4Hzpb8pJtuNQtqDy0Lny4s/Y+XdRwaEQZcnmiyCrBfPNZ9xnLnagSJw5ubdnuMt8e5m7kMUvpS49wXIOTQGYdGDrXt7M3sw+OBqtYb4jFfGcAi5uGNHAhIGeh15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i15H32ef; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730798569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EF+cUOkjIhI0I2fV5fEeBbZvkl9AhwMOu/7bTG8aM+c=;
	b=i15H32efDnL8HD1a5b2r5CCZHj6H8HimN6wyE5vMsbWsN/r3rzG4jDucZHaFy+bHwlW+44
	cDUA4Pu3yg4oV5RGtvwm64/88pew9W/HXeEIcGx19Dxa8se88RViTxbKqCO9OVm6MLc/VG
	7Jp3keUlzy0eO/BJfnw51yxFShp+J5E=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-V0p2WsWVNsGfksWrmnLJBw-1; Tue, 05 Nov 2024 04:22:45 -0500
X-MC-Unique: V0p2WsWVNsGfksWrmnLJBw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71e8641f2a7so5566482b3a.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798564; x=1731403364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF+cUOkjIhI0I2fV5fEeBbZvkl9AhwMOu/7bTG8aM+c=;
        b=c9WZyoeJfaRQyKZ+Mdk9eU4X2u9RaW1h+53hS+D/O3ZytHVydgLvqF2eUNC7owUigh
         wVdKZxGx97zIQBi8OrmNcMV4h8x2RTrFxH2B81U0+xTuqSdUNSWXQghfDIMlQymtoOFp
         t0xlqGpi410n4dweX86d33u7MTZdBoC3soPE3yfNlNCLCIaXx0tRGBfb4cTxgr+vifW8
         3qTYgMJQ1cE5VqfpVXeAqDFI293228SQ8V9JeLoEcC8smxf852yur/xBlnOd8IBmuVqM
         VKrgtG3B5IotVGs1q72/0Xh5TG3X5OLIxE87qTiMrlBWhqOVIiauwzRHUKJhz1BjYjoL
         ULkA==
X-Gm-Message-State: AOJu0YyjuTtjzqvs79SAutRDxfC6aoBhQ+48xAEUZjd3mWdqCWqGUG/z
	LBN/JOZtG252owOj/m+y0Y3s6qZr3QWW7DHxy1pzaGhkorzEU8NFQUxCEROkNw87Ri44boFY8Uf
	s0fpYqQlEBISS2M+BE9wmmw1tyedXxPHxnQ0nufF9h3zSX49ho4YDo0oQr49jDpbtKJzJSLhtzb
	wxL6emWXMufFhKBWfxYhlqrckynw7T
X-Received: by 2002:a05:6a21:3a83:b0:1d9:282f:3d16 with SMTP id adf61e73a8af0-1dba55ab06dmr22782424637.32.1730798564195;
        Tue, 05 Nov 2024 01:22:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUF89/hihdswxOtAb4byZStyWXa9YeJw2bT+DRtfOsSJAEuOSAjJDBwQX2nvxNHlBrXE1XdSe3ApulAMDdAps=
X-Received: by 2002:a05:6a21:3a83:b0:1d9:282f:3d16 with SMTP id
 adf61e73a8af0-1dba55ab06dmr22782407637.32.1730798563750; Tue, 05 Nov 2024
 01:22:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com> <20241029084615.91049-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241029084615.91049-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:22:31 +0800
Message-ID: <CACGkMEuo7ADSJg-gv_qtiGt=M3VqVjR76Q4baqkDmNLsb7OcAA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/4] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:47=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> When the frag just got a page, then may lead to regression on VM.
> Specially if the sysctl net.core.high_order_alloc_disable value is 1,
> then the frag always get a page when do refill.
>
> Which could see reliable crashes or scp failure (scp a file 100M in size
> to VM).
>
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur.
>
> The commit f9dac92ba908 ("virtio_ring: enable premapped mode whatever
> use_dma_api") introduced this problem. And we reverted some commits to
> fix this in last linux version. Now we try to enable it and fix this
> bug directly.
>
> Here, when the frag size is not enough, we reduce the buffer len to fix
> this problem.
>
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Tested-by: Darren Kenny <darren.kenny@oracle.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


