Return-Path: <netdev+bounces-169700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17507A45511
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3620C17B7BD
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 05:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35815268C5E;
	Wed, 26 Feb 2025 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RN1KN7nU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9F267B81
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548988; cv=none; b=PoplllEETzc/nMlMZpH9wYn8rLvjuA+//NV6WbGHg9lDKV3tnxCDTuY7yn/4jzqN2H1qGuyutN3GZ3wL80loWCdG95vcFPKtq2gVLpxhItRKBvWRliPVb6wqv+OdOwAyoSsV09MxudNl5lvKsGuTGTUgBZfy0FkuUSowIKkvzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548988; c=relaxed/simple;
	bh=NTMJBEkTTrITvRfKZXpZ7+q/A6dI1WQ6+SsWAlHSdWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKNX60zSZ3trp51SKkN9LahkiTxea/s6K/Q9gLrpd75Wn6DHDug2lRyPTmzyjS+v8UgiicFl0o8626gRCoWslQgPKHE5C3v12NK/Vinmz2xnINj8nKV7+EIWjhKBbd1ZM9s+G9ilrDBFEprYnOc43AONCjAAtpvh6cff2dlI1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RN1KN7nU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740548983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTMJBEkTTrITvRfKZXpZ7+q/A6dI1WQ6+SsWAlHSdWM=;
	b=RN1KN7nUi3qvim2+dcKRCj5LqdVkmZswRSvN9kWLOnhK2/FnwdHHGtve4Od+F+Vskq0Mv/
	hq7bH+V5gdXnqi2OCvDeaNGfiXT8WUaZDqh6DGg7Reb79pfE/A9G+dUq6a4v/mlCICmd50
	LGl9Ui08VlR4b9figum/hReBoNY4/do=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-sMWNfnVlMCGb_sOGjkLYug-1; Wed, 26 Feb 2025 00:49:40 -0500
X-MC-Unique: sMWNfnVlMCGb_sOGjkLYug-1
X-Mimecast-MFC-AGG-ID: sMWNfnVlMCGb_sOGjkLYug_1740548978
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fce2954a10so18353691a91.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 21:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740548978; x=1741153778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTMJBEkTTrITvRfKZXpZ7+q/A6dI1WQ6+SsWAlHSdWM=;
        b=VKJf9MxxgPYN2+x/OKkNQq8nLpjsu4nuMd7OTTOHItx1j1TyGMmSsCXmWVsqlioL2j
         SWOmUKxxphpu891Hi0AcPd9gxN7ctvFcaH0WJYz6W+2tNVtddrCDSqrA9M4pDWRycnn2
         XzcrzRa7eIUzvbZm3vcHxjLzqCHV3x4M1QbZErWQqbX7GXoEL4fVjV6XBPdY0RLZkvIX
         maa9DKoExpj/40DYacRh84k46ETTvqzvDB6dl1obfOzSPKhNBLnCfofyqWn/ugfvWnSZ
         3+FQ98JOImhfCbwHKFWVJsMKBni153dB1VpNkr1TH10rRwDpjco4MtIz5HbXFG8VXIKh
         NGBg==
X-Gm-Message-State: AOJu0Yz+sZrXTQcI/1Xoi1fdWADcfP4I6uy16Xnz6WHp14FKE1UPSSMN
	2vDvqJL2pqwfDjgW7IPvGfI4wiX6HeHmfsjm0bxRl4UyCENJJA35Xe+Lud5tgeLCxcNT8QUUCE4
	iCrHA6Dt0tIG0WueLa+unB8BKgpTOuYITK/FImBPlC+n+qBmWYY9sRH6ysknQoECnC+JdgXzJ2z
	LFQKzex0y7HDdwQOL9tMz2JOUe9nnq
X-Gm-Gg: ASbGncvQ1dS+syto4YntThzAcI0YngwiPnVxlbH7RK5gbPU0ZrCNPhRYAktg65GMQkR
	qXIzxf44m1w2JQ6iivDa4bxyT8ie7cgXmLOYaw4RKJKGRm7BBWT2FR+5mmmisEdyrjsuARR8K/w
	==
X-Received: by 2002:a17:90b:2ccd:b0:2ee:b26c:10a0 with SMTP id 98e67ed59e1d1-2fce8724390mr34443316a91.24.1740548978082;
        Tue, 25 Feb 2025 21:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOC9QXoxJuOHEjlx+qZRYQH6fSlrUiM3+fVaJpf6dIZ4d2WAtWScZFMkzacVSmHtSzRdR+wj6Eo8xT/JNNSFc=
X-Received: by 2002:a17:90b:2ccd:b0:2ee:b26c:10a0 with SMTP id
 98e67ed59e1d1-2fce8724390mr34443288a91.24.1740548977777; Tue, 25 Feb 2025
 21:49:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com> <20250225020455.212895-3-jdamato@fastly.com>
In-Reply-To: <20250225020455.212895-3-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 13:49:25 +0800
X-Gm-Features: AWEUYZmvhQtj62SIihRDJMGEYtSPUe20LIQv6rcQ21elME2iuLu9IMnansJ-eGg
Message-ID: <CACGkMEsfSqE30m1oq14h_=VNavf+OVHmqW5aptEGBNumf4ALjA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/4] virtio-net: Refactor napi_disable paths
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> Create virtnet_napi_disable helper and refactor virtnet_napi_tx_disable
> to take a struct send_queue.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


