Return-Path: <netdev+bounces-149253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0639E4E6F
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA241282283
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DA81B1D65;
	Thu,  5 Dec 2024 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZwpdw+h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5971AAE09
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383955; cv=none; b=p4Su0JrJCY+0YaQ241LrurJyOO8qqPjF7i0l6R1PQ5BP0z49dKo9ycVDWEoqLjyKRMz1rYuqyIIn53XKrtS40tYoUY6pbBvtBZOkekKkjy8O3F5juQVr6XrF4nBoW8ImSXrrz/okG7VzoLYtojPolfadIEk5bTvaJ27zug9MirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383955; c=relaxed/simple;
	bh=ki6pIKSupwzYj6s/3NRHiuQu5GRhGkrv5KRSIGzJ568=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLmxcPH7GvktCgZrmya4wdmnXXDgrW9Wtu4cp2CKjMWiYWn9B2zMVxrixA3nTzeK/z2jbHdpOj28G6+5uH2utl66rYuFOheKTJQRNocT/BLNzMk52LMxpDUFqpc9PorvgAz+5ZTu4y/JTX2kXtWyZYyT9y6BEAjIyvI7rnmVWR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZwpdw+h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ki6pIKSupwzYj6s/3NRHiuQu5GRhGkrv5KRSIGzJ568=;
	b=UZwpdw+hxSeMcAegtnmvko+kpwfH5j5SXg2dEyrBf6BnxJjZIA/aGK0vsIZ4GAsuJaiClC
	1UWnyeG5KCAF3hN7Iy6MaewoMLLc5ifgZONonmLt4VkV7i42j85JPdhnt4wS6wc/J7S3Dp
	KoSksl0XJEiDGA66XOaCxKrGqWDwbJg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-ZxrjRVGyMPutJXTORSGoIw-1; Thu, 05 Dec 2024 02:32:31 -0500
X-MC-Unique: ZxrjRVGyMPutJXTORSGoIw-1
X-Mimecast-MFC-AGG-ID: ZxrjRVGyMPutJXTORSGoIw
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee964e6a50so816951a91.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 23:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383951; x=1733988751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki6pIKSupwzYj6s/3NRHiuQu5GRhGkrv5KRSIGzJ568=;
        b=onHWkYW/PPJ8H9WZck7vqHveVz+QDCsImGVeKRt3njUISftqT3mn6oYrbsOka7TTF9
         2OgJ2A3Zz7gHklW0AD+OJYhwv+YDzvnDjPIlpmR/8JGEcTTly6aCOmrJ3og/SXHQPezv
         78QxgJTdXUpzxIrXOv26nRfaQ4lwqcmzz8I7YMtBP32yKAqzu2FaODlPnz+2yeD7eZMy
         vUiDr3xVuEErMEty6r4jfhuQBGN3MoZPTNnKErWVPWEXAZJ2FA0cc2AzfGejMsUqigg6
         5nWluWCWbN07tiG94cEa+A3GKq6038lwKe76hAxOXn7HoNZn9PHHhOF2w5btmv5t1tUi
         RdgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl9WqtApbDU3BkAJnCsMDebOyYnBy8uAW6nM1IEIkX/JUAD4tfxqjviOfNo/hCvV2TSlyBfpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7miE6x2NdgE0G8mq7g4tMy4M1FbHiXcsF7aWxE/uy2tjue1+
	OxCXb/vrN2it4BEnpSjaOylnLbcDzmqm5R17E3smWY30QoHZzrj9y8va5sijptlv5lT0lhIJsWh
	KMNECz/hZHMWqiqcUBcmj3ZKW58mNkbehn/dN54ey9b6JE26x521iKZ4wA5Cz9PUNtyNrxCyxgb
	BTUHjPWoHsIh3yNcPm48XxBM3nHRQV
X-Gm-Gg: ASbGnctfBtoH1VJDp2wVyW/k2BsQLMqWTc9a0PJNIyFSjPj/2g5ovez6URQG52VbUoM
	yA+iRjw1Nstgd71cDDZ08vscQSGgScx/6
X-Received: by 2002:a17:90b:4b86:b0:2ea:4c8d:c7a2 with SMTP id 98e67ed59e1d1-2ef012446e8mr12752050a91.24.1733383950958;
        Wed, 04 Dec 2024 23:32:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH00pmkLuLXttemKJiKF9Q/OxhVoQePAQMlOpYi0wt7eK+3w9Uxtm8XqdoXThMNr2b4ra7bR0qWU9AsuFmRg/c=
X-Received: by 2002:a17:90b:4b86:b0:2ea:4c8d:c7a2 with SMTP id
 98e67ed59e1d1-2ef012446e8mr12752030a91.24.1733383950636; Wed, 04 Dec 2024
 23:32:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-6-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-6-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:32:18 +0800
Message-ID: <CACGkMEvHUQDfAjeSBdNd0iotrgyjkbXuZBH7ehs6dZ74prspdw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/7] virtio_net: ensure netdev_tx_reset_queue
 is called on tx ring resize
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> virtnet_tx_resize() flushes remaining tx skbs, requiring DQL counters to
> be reset when flushing has actually occurred. Add
> virtnet_sq_free_unused_buf_done() as a callback for virtqueue_reset() to
> handle this.
>
> Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


