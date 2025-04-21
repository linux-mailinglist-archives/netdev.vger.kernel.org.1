Return-Path: <netdev+bounces-184325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3146EA94B50
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 05:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A19C16F0C1
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 03:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1972571B0;
	Mon, 21 Apr 2025 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwUxuK4h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401DA2EB1D
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204638; cv=none; b=V5Maugn4faxUgDuyOcmk7XVGon3zxAcPJYTnQCRXCl8FZk0wzM71+y2VRln0C86LG6MB2uxVW9LpprsLyzmDurcolA6d+OPf2FAd/qyHqcZkFtjsRZ3QzbJc/NlxZtobBSNkPZIZIqZbCn8oTigU8+5K+k4lR+aNI0bNjh8tu5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204638; c=relaxed/simple;
	bh=Qr8aYaNg+4LPUFYtFSiJL8vs/bYQwNhv1687v1mNwC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q33ZsHVsa+sQoTtZAtS+dWuMeLCXDQmQDdKKEpjE0zHJdrZtW/jqe4Grk3+6EP/UZ6u0SAMBNLNEHXD/LIhKtKQI5wQYIj1+W6wHQhaa1NE2vjtoG+S9CfpanVzb0rFyqHQcd7yTv9JS8r5QaU3xB0bPDHaIDxpWaPuZ10bj4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwUxuK4h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745204634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLXDtRgA6ayDeCz1Y6vWEq0hT6V9yJ+AfUHP97mEHh4=;
	b=RwUxuK4hO3q11StluSzGTdt4eZPi8wAAtYWR1KW7jlDQHhgn/JqxzMS4O3XF1s4kBPXaJK
	QuCfbipW2xzk7xj5Bk/zdvWl8C6VvZ5wZoCbKeaZ7UpeulPGj38hKPTJBtxo40xxVFIhXd
	ikt34FCaey9RCJsI6uVenaZM6Ep3Hqk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-zwoqf4xOMh-rOip3ku0oEg-1; Sun, 20 Apr 2025 23:03:52 -0400
X-MC-Unique: zwoqf4xOMh-rOip3ku0oEg-1
X-Mimecast-MFC-AGG-ID: zwoqf4xOMh-rOip3ku0oEg_1745204632
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so5334387a91.3
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 20:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745204632; x=1745809432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLXDtRgA6ayDeCz1Y6vWEq0hT6V9yJ+AfUHP97mEHh4=;
        b=NOAWDusWvY4J8zhollngTIfAPxpEJUKdU57/vEren986HkW/wQPgX1GCqDJLr6uucf
         7c17trW3GVLPBk410QHJAUsgNCBQVoHoovDfplj7CrWlMvJgzpMAF307Soxvu6K7lhJf
         HC2kc4W87qbEMsOP3461MSYv/yD/NvRCFSyFIZLEwtunktALm/o3g5PxxKF9ujEj+i42
         7jslchh9J4OPFg7WfekoH0IfUm7LixWEWGlaPJMm9ki/UJ9gL/uxVEYis7eL4yKTq8LH
         I0yfSKDDlyH3zFJdzXmk7WRl7TNicQO0iz6IpIuqhGQSlIaS2meWf/iG8xX2MW4m3iDQ
         l+4g==
X-Forwarded-Encrypted: i=1; AJvYcCXY2noLO4jr5DO21LT9jUb/LEYtIpJ6vJ9mZxnYTP8zvKXC+hdSwoCuKoFdIw/BsQepHWg1qdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYlWWXbL14OZfbjxKl0UXHUbYWUPoxQhrgbx3XbdcwaSPwYoF
	OhMRrlGKT+M5domr/rq5PznMymg5nZJaeNIq/qoFfnY25SS8NRxEVPo/KJiQO/UC84QoOYpPL2p
	5JSQTCdOwdpBxjXTRi/vGx7f6tTbBx5yx2b1fxWUOTLlc7emXj8VSvSL13j3pofwgIL3piUlKnO
	BEVt7zSootwpaSNUZrYppPe5PYF+OY
X-Gm-Gg: ASbGncuePlXTM0QEvySk9SFpeXlJnzSR5913MpTW4YwQu6I+T8WYRKpfyt80eVjGdoK
	vex/nbyFIUvFYazdVp3xb+S+lXjTqKpk28YTmIY6sv3N9/SHxkxVDmFgf0oYg0p96fye+Mg==
X-Received: by 2002:a17:90b:4b89:b0:308:65d4:9dda with SMTP id 98e67ed59e1d1-3087bb6e794mr16806365a91.16.1745204631867;
        Sun, 20 Apr 2025 20:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZtnoZd7x/9jpKNzZ+LTBMBCaS6scxdcgAj8rPFvVSJbcKlGfoHCLn1pYbSk8Af1Y6oKwZSBu3haMJ+dnfOJM=
X-Received: by 2002:a17:90b:4b89:b0:308:65d4:9dda with SMTP id
 98e67ed59e1d1-3087bb6e794mr16806325a91.16.1745204631397; Sun, 20 Apr 2025
 20:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417072806.18660-1-minhquangbui99@gmail.com> <20250417072806.18660-2-minhquangbui99@gmail.com>
In-Reply-To: <20250417072806.18660-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:03:38 +0800
X-Gm-Features: ATxdqUGyEA9DUKHVB0iflKLulL2Ewuk2b0N8F7M-x7RCvH29fTxDE_M5T6xkicU
Message-ID: <CACGkMEt5=r_JbfHeU=dpk20F5uE6TJouTPdKUUScYtQGfAw1tg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] virtio-net: disable delayed refill when pausing rx
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 3:29=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> napi_disable() on the receive queue's napi. In delayed refill_work, it
> also calls napi_disable() on the receive queue's napi.  When
> napi_disable() is called on an already disabled napi, it will sleep in
> napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck
> altogether.
>
> This scenario can be reproducible by binding a XDP socket to virtio-net
> interface without setting up the fill ring. As a result, try_fill_recv
> will fail until the fill ring is set up and refill_work is scheduled.
>
> This commit adds virtnet_rx_(pause/resume)_all helpers and fixes up the
> virtnet_rx_resume to disable future and cancel all inflights delayed
> refill_work before calling napi_disable() to pause the rx.
>
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

(In the future, we may consider switch to per virtqueue refill work instead=
)

Thanks


