Return-Path: <netdev+bounces-149250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4375D9E4E61
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A5B1684E6
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BCA1B0F29;
	Thu,  5 Dec 2024 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8hM8ILs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243F1B394C
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383869; cv=none; b=iAAGENMGc3rBkueiE0su3yar/Qzzy6EdBZQNCHRY1y8+yWhcNCQsEJLg3QHhJSzTjDDMT9lSWiNBEA8qUCQ2UUJTvrIzVoI+RaQPgBVudHEMfu9oG8Km5iiVKiskKaXonmUOxY3In8km/OiF2SyhQwrD8sTIXiekY75KpFGxv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383869; c=relaxed/simple;
	bh=gBsazSA+2P8jNheF6Uy8VcoZ1wvAMnui60NL3/2jmLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRGwAVbZBb9Io7+KMjefFRKfukg2NgolSpyd/4Q6tGuV610wZr4gVBG5Ern5r7AzUkc9UsfsACPYTRyQRBnFdOoQ2I4ESlQF2tL0EmhWZGze0+DdR586t5wVUt2sBikZe1P3PJaVvezhQ1+HyfPA599710C8N1sVidN/5w33Snk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8hM8ILs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQByPnPwbfne/yS8JI9pQTP84ZOieAk2em/vkGbruFk=;
	b=h8hM8ILs0QcVx/5i+U5NETWgJYuhqo4sFwPEnPgUEpVR6XyQC9TWkEnvnSXmb4UztUZ4J7
	j0nEVROJijRTmcF85X/o5UlzAJhwPJmonXKN/xZudnj8P57nxPdgKllFtAZpXJbGAZFqyN
	elAFfYztChtLjvYGq2nsktOAN6y34QA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-WdZ66HluNTun8oNLbzyccg-1; Thu, 05 Dec 2024 02:31:02 -0500
X-MC-Unique: WdZ66HluNTun8oNLbzyccg-1
X-Mimecast-MFC-AGG-ID: WdZ66HluNTun8oNLbzyccg
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee4b1a1057so1153868a91.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 23:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383860; x=1733988660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQByPnPwbfne/yS8JI9pQTP84ZOieAk2em/vkGbruFk=;
        b=S93bL5VwlLMEr6Sk1t6FaOyD5ErjIh//Qc9o5N8R7V5Ys4FW6umeP4Yw8PULFKfNtI
         JarQZmlHiO0v7QFzeWQbkbU7YFc9So0MtBCNQkU5kS7OAGTIcV2pPzcEsXcw0jPpfLPg
         QJwt1Lqv1a+6uNwINWadwOoPmrDbgrbq732hSO1797GxBmd9NyYHXPenKM9GusdagJlj
         aV+idFKjO0fliHezz7p4kfiMvzX1WDuUhG8OtarRdrhIXkPX/dqALJ7gX5bauLP+zN73
         t2VrEKdPO9Cd5tlUx/R0NyPA7aEGa0zq4SCCUrtPKS3QeK89CrimD+Uym0WaXgyijINH
         Ng+g==
X-Forwarded-Encrypted: i=1; AJvYcCV0c7URYPPTjemwPPzGDPd2lQwH/+sw7XMcPfwfPaRxK6DMH7mOP6QOID8sDzHRHJRczuHz5wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhc/SPJImWPvtEYobRl4ooxoGGo3Fi+lTiGe1UwK0bKrnogPpQ
	T1ljpyTmYNOelSNmq97nAPLrKYYJdtUso1aUE5TB1STFReGsP/FSvhy1iwVJUZ7OEYWAVPFPDvI
	nw4iJ68PLWX3QvpT26uSwUkynhSeiBacC+JmRNIr6MF1P5eXdT6mgQAcs7w5V4KxUBXJr66jnG3
	5nUdJD2jlBMAIVS1zsOYEFgXDyN37b66xkej5Piw0=
X-Gm-Gg: ASbGncsSfOEhX9VJP2WcGJ566WVJBe2WcxKgJ82OoVxXzAWMf7kRNp4NeBH2AM4H7LO
	oQ2bm+uNfB6peKJzcovYbOnd10ZAkzIhI
X-Received: by 2002:a17:90b:4a41:b0:2ee:a127:ba8b with SMTP id 98e67ed59e1d1-2ef012730dcmr11339452a91.36.1733383858963;
        Wed, 04 Dec 2024 23:30:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgjvvMf7JapTRuI1SObNMq7BvZhIqMSi6SZblyK6LzMeh4bpcCn3KV3lIBqaI+D6cczvydNaQWvE4gxNRWDj8=
X-Received: by 2002:a17:90b:4a41:b0:2ee:a127:ba8b with SMTP id
 98e67ed59e1d1-2ef012730dcmr11339393a91.36.1733383857900; Wed, 04 Dec 2024
 23:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-3-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-3-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:30:46 +0800
Message-ID: <CACGkMEuhhgNWZst2LAWStw+agvLjPrV+c2ZHe8JL4zLej2ZzGw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq
 where appropriate
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
> While not harmful, using vq2rxq where it's always sq appears odd.
> Replace it with the more appropriate vq2txq for clarity and correctness.
>
> Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


