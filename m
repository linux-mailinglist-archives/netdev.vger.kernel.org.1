Return-Path: <netdev+bounces-175981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4E8A682D7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 02:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E1319C78A8
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC98A24EF6F;
	Wed, 19 Mar 2025 01:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfdktLqD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC224EABE
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348605; cv=none; b=ir/mHUvzRhoZ+ZYh78gf+QXItnTq09bCTsu0zBG+1RQLL0VaMtSFBLFaxVC/AJ2trpQAehCtJvhCTTsYP/TKJNghLBoCPY2jTdcAx7zoeMQc5OhYZz60cUbDseCJcwz3fKsWlh7cwfXxRRz7/7qRGSsF8A1FRmPz2QdhPrJ13zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348605; c=relaxed/simple;
	bh=vMQ1NxGAapHE6NnLtNfhVr4o56PmQKO6ToRg9ogrVb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LShygvhlPe3+pxlP/0w7UfI4lo8VXn4k3P/313Q0YIQvLRQk+Q7BI7z6IZCAxqZdY886Rtbc+I8MR7/yJtFtvsRorRMgZik0vvFuJJr4sNbI7LmKvrBmzQ2QOoHQjg5li8ef2bQnuKyKkY1JuqjnivAN8gJXVIjA/AHfzr6jhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfdktLqD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742348603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5sLlh9CAsq5ZwTK4lMG7v2tALwodsO/DfUbIpuQvGo=;
	b=JfdktLqDrSRI/5asH9v5Al0duVuB1FV21MF07iyMZqA+hJG7qpvpr5OFEh+ZL3+PCiUsV+
	FNFpZ3L5zd+vQzPKXedR91+HcZgJHmnJwIXBnp9Sr1SqUi09mNNmPzeytQ17skYd5xY2CJ
	QPp5qAzkpg3XMotBzyKu4kGcwzvRVI4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-pGAMMXZJMAGgepx2w8hPrg-1; Tue, 18 Mar 2025 21:43:22 -0400
X-MC-Unique: pGAMMXZJMAGgepx2w8hPrg-1
X-Mimecast-MFC-AGG-ID: pGAMMXZJMAGgepx2w8hPrg_1742348601
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff68033070so6040012a91.2
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 18:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348601; x=1742953401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5sLlh9CAsq5ZwTK4lMG7v2tALwodsO/DfUbIpuQvGo=;
        b=Mu5n+XmTi0s10Fwn8GGm0G36qDshj9hGFuZJbarAAPcXYrPywqKbYVxZoMBTHO67AL
         BJJSjUEXFG2/iVu4LY8gAVEg9NHq0u79G6jlFc/FFnWeN8NXFy78RbUK1g5H62Oy/PyZ
         YBnVGNtRQVNUbjFoU175gNdjKiLXDWs90RcGQjMezEj9TStoe4qFzKsVIUKONBfU55Lg
         JgTuQ0CFWoRbpZbIyESm0MyacCfN9JsNviPR2DPNgJSB5ZHO/YVZodn5YX7LXrJS6MmN
         Ba5X0rrnw+q7dbQPFILnpReeepONYW60W869T2fNed319EJzpxwCvdMQSTSfQwMrb1kx
         ncXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHOeWptTojBw2qMDjK9J/0OFPQ6ofW//cfVCb78iVrLn6ALCaMBTEo+vBuNqvgU2p3TotKyF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6aCgwDhDOhXkeWUzRWrnF1VwlPll5hD5ww7jpr94eK8Pg6IWC
	IfnWWU4Og7Jz5rl0W47MFl7O0Vws4kefRcevJ7Q1JHVydicmx+xGUgEclaqNSuAKPdeeiJ+AWk+
	BtJQgAzyMTQFNR2HwXqisGpmlyfk/QKX9KZSGECWgZyV+Rj7eydM8hw0Zr666alRp7RmUkyTavE
	vxk4fxPK8vbVxr09U6q54VGXjhNSom
X-Gm-Gg: ASbGncuAYbiSgCisTpuad4+4eQ/rpNFc784s28O8e7pLDIQg4WRrQ8nQXDKXqNSFqMl
	tvUGK/80fIKka6VHM179fzymPDj+J5iInD1Qtxhr0dUFcWZljIZVbKF/twvEysEPh61jw6Tug
X-Received: by 2002:a17:90b:1648:b0:2ff:6788:cc67 with SMTP id 98e67ed59e1d1-301be206e87mr990211a91.34.1742348601135;
        Tue, 18 Mar 2025 18:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0++cP7CuHsJuA4ykUqEhaO0hgo1XA+wkh7+TJ3CNVMbX8Xf+ByWZl4BacAg74fMOEy0eBKEoJ6izk1WeYfSI=
X-Received: by 2002:a17:90b:1648:b0:2ff:6788:cc67 with SMTP id
 98e67ed59e1d1-301be206e87mr990190a91.34.1742348600818; Tue, 18 Mar 2025
 18:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-4-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-4-344caf336ddd@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Mar 2025 09:43:07 +0800
X-Gm-Features: AQ5f1JpzmBMSEro2nh12X2DCr43bIWbmp32ijo_MawALr8QoNkwJtaJ_yge_7wo
Message-ID: <CACGkMEvt5A00kvw6=O5Q2qW2vbbzAnFBpUmcBVwSPJr0i9xmpQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] virtio_net: Allocate rss_hdr with devres
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> virtnet_probe() lacks the code to free rss_hdr in its error path.
> Allocate rss_hdr with devres so that it will be automatically freed.
>
> Fixes: 86a48a00efdf ("virtio_net: Support dynamic rss indirection table s=
ize")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/virtio_net.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


