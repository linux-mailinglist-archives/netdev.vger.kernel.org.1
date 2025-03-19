Return-Path: <netdev+bounces-175979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CBCA682CE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 02:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6021219C5793
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B995A24E4D2;
	Wed, 19 Mar 2025 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+vwL8TR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1224E015
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348600; cv=none; b=TizY2YltBuYPIUuIWxBcPjEXcF0WVb1Jh9Sndt04IG4RRZBuYMYq4mBRJWr+13xfRgiHeTj3CuLpvmavGA5jlm0oCUAv2M/capgaCH2GGzbuGmcGk3Ndd3/rJlh/vCMNYGPGDpPjaE7V7/K2bzFsGsQcEY1814XGn8XDpUaMc1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348600; c=relaxed/simple;
	bh=sEvW/3fRIipJyIkYaSgv0QvsMLG7ce2z83i1k4YqcJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSFxkYg+tgUKVt3GUpO+rlKT22haV9cDa9rOyTfO9DLujwhpiJL562X28kXQ1Zi4DUXIcOkKs3RBEce1Nz32PFxpVj5FZygp21jTzuZBoks9fHP6DuJSRUvgozDDfDQuzSmFPqXRcfgjxW93g7RVOhcevTxLpzqqeMSxlg+7wcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+vwL8TR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742348598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEvW/3fRIipJyIkYaSgv0QvsMLG7ce2z83i1k4YqcJw=;
	b=d+vwL8TRffSwzd71bLweoyRhT/du8ygPuFSSLXitGIKZdyYBH9L/6rpMTlKimqZk00m9YE
	OnLUJUgZv3lc1xnOVZFTynOeGYTYp6nRwJaAWIitC3E3IqbKpVzXeoBohIOLJ4WwHEHe1q
	zyrUJJqWsTnpcoK6H9zzwywLU+DWCBY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-S4Qdi2QxNuS8-1lThsQKXA-1; Tue, 18 Mar 2025 21:43:15 -0400
X-MC-Unique: S4Qdi2QxNuS8-1lThsQKXA-1
X-Mimecast-MFC-AGG-ID: S4Qdi2QxNuS8-1lThsQKXA_1742348595
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff69646218so10039137a91.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 18:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348594; x=1742953394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEvW/3fRIipJyIkYaSgv0QvsMLG7ce2z83i1k4YqcJw=;
        b=LoF+4QuHWHoZDGwv6sXCsc+BatcF4OCk2j5ZKDp7MQ5Ms/oh5aC9MdV6kU9Sez8C5X
         SuJnd9vniZIvRuSkRb+gBfr9BWfbrSH/ZqG6eTJudfuR+6ey/fzl3RcMpWq/LlYRV4de
         tDWhmkuIWym1XcnnOw7sTKRpH1oLLB7Tbnpc4G0U2wyf1v0I/5fxjof6Afrde7f4HDVa
         Pi+5MwRUTHttytycojFM34KAgT+pasXZdYhaWTS+F/r2TURPb3EGLW3E4aOD0lkkOXfU
         ixZdMeAd4wFfn1utFhFO3OYQvoJQcM6U3lerSLXB5/AtYNUdo3rFWOO46HwxXo8kGCYS
         edgA==
X-Forwarded-Encrypted: i=1; AJvYcCVH1c8n8PpUqhUnu/kq40C8Qbn6u0llv8jxy2gKwocnpBA7LL1ksV2s9DQnRmsJXy0hxlUfE9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0p91dHJdIm/OeBsv/zibbZVn+A7csHyQ5dI4jixbMDh97kE3
	C98aTowxZjucZWokwixvuzr5ZutI1yE6mkPreb+XPCM18l6FPTqN/ODiefacCJCcyd4z5StxSz7
	7Dwyh/GXA5AIx8LaGlu5vm+ibdJPTKVFW99lP2D6xc6/gUMsGPbsbdjZeU+pUtLQMnVul3L/kTv
	CHIIEl1/JyUBGh0r5rshXpMgslEc/e
X-Gm-Gg: ASbGncugcCcAg5eTNA/18YjZ2OODvd7pmrn+sMK0eviMie5o6JyfOvQOVJO7GwPDlR+
	QLrVcSGNvzMF1Gc6MMgvFMakeOCpeqaey7ieR3KWfm5rDDcvfGYa5vfeMp3vczrLqggJrvOIp
X-Received: by 2002:a17:90b:268e:b0:2ee:9e06:7db0 with SMTP id 98e67ed59e1d1-301bde6cf1fmr1638680a91.11.1742348594701;
        Tue, 18 Mar 2025 18:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpFcg4dnJHM1uCFM2u2csupiktItuJlKGJc6MgtbCrZ17gemZAB1I9mrMnZFW3Wp0mx2Q/1cpCGqJkfDvMKT0=
X-Received: by 2002:a17:90b:268e:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-301bde6cf1fmr1638665a91.11.1742348594429; Tue, 18 Mar 2025
 18:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-2-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-2-344caf336ddd@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Mar 2025 09:43:02 +0800
X-Gm-Features: AQ5f1JoMSQNYtVIT-ODL08ptBsIoNK10KPby88nDSI2xd14NsoDQzDvBrBl4FY4
Message-ID: <CACGkMEtmzJpWQjAD1FoYwH0HF4+y33Kjf-jUwagnOP3wg15oqw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] virtio_net: Fix endian with virtio_net_ctrl_rss
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
> Mark the fields of struct virtio_net_ctrl_rss as little endian as
> they are in struct virtio_net_rss_config, which it follows.
>
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


