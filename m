Return-Path: <netdev+bounces-136886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142F09A37EF
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1924283DA4
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7082018C333;
	Fri, 18 Oct 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+5lIWQi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB117E473
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238531; cv=none; b=uUFs489GOAQ4I/HCtkQpj/bcsBwmsDtQy98JvxXnVp0nPHBBJqefUBKiEkGWcj2UWE35JECObyaqYwHz4+1wlZHxegY5PXC3+akEKlxOeuJX75tfM8E0YgvFnsla1DjwbNKQqjnRrqTkixgKW4+Kmx4V+Muo6c4KHtkEipkNhe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238531; c=relaxed/simple;
	bh=l8Ud2Cwib9TqAGzWPugTVoMsn8A3Gpr8ya8dAh2p6Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkU71Lmxj4W1DLqFW3HCKByeFSfTaEPmlCbeENAyFZ30rqAo8SIwHIIzXl8URftf37nfKocCFQGdup2lcwt7a7cCKk8PvDPjU0JINouyX0wB1GHozAYu0S0qBkKxHSEC2hIEn8SyDx7wRLIiLsnjbHXvofUxf72zVFylJ4QhXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+5lIWQi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729238528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8Ud2Cwib9TqAGzWPugTVoMsn8A3Gpr8ya8dAh2p6Pc=;
	b=f+5lIWQithWuHsuJ7m3eGkpnptFVEuoo0YCoNosp4/II7WhODTHUKV/uYlgY7zHv2+UnZu
	1EEL4aqZ1aXLE+cLBeURChgnsVzHSf4JcT61Ivwv6g4DjlLJoIdRQpmlgqvDVPaGuAv4dt
	T89YytRDAW35bMYws8wEL/lGBTyK2Uc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-zZkGJUHXON6pcnKdvoQp7A-1; Fri, 18 Oct 2024 04:02:06 -0400
X-MC-Unique: zZkGJUHXON6pcnKdvoQp7A-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e3984f50c3so1710006a91.1
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729238525; x=1729843325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8Ud2Cwib9TqAGzWPugTVoMsn8A3Gpr8ya8dAh2p6Pc=;
        b=l0Mo6JfdHk2z2KxKfnDlKYICFq0kb5UUWIKQwWy7f/xyv6wnV6uv10SnGw6inHdcKu
         JGi1BbpTc7jdBFCaCv5bZX8BfBlfV1KD5zwAgJ+dCb/PPtSYUZxHQsQG9aHDvLXgh5os
         e9stO1VJ3qrnrl1ra9bxpccJaerF0bHA2994qD56+kSMvs7D2u6nlW/hHQc0avC2jB5h
         1rAtrJiNPRsNwm2k0Sk8hxRW4Byy9m8N1a+fUlR83igPwjmH4iarAh//jR094QgEm1y0
         UiwKkk6oXb8qr3kGH8+N9d37HFz/0CyOieJ9Ay//a+EZq3p9zYCpEkXe6Y3GAQxPmW/E
         skEQ==
X-Gm-Message-State: AOJu0YyLMRKwIN1N01LN1YprkPoUGRpZ2G8MftpTADp2K0cWl/trkey2
	zNwz8kEynmMOeiGziJucxxTkq+fqUXJhLYwL80u1m5SRo68O6EtP/7utlnw7rXSi+htN41N+1aT
	3l5Ut/AUR+sL0rxOKmx2OgE7cEL5IN7rJiFuP8EgYbzoObsU8IG/EGRHU8qQZ/Ze5IRQlOo7tOR
	esqJVbgo/m56degf76yb2WuXqN8G6n
X-Received: by 2002:a17:90a:6f84:b0:2e2:bd9a:4ff4 with SMTP id 98e67ed59e1d1-2e56173c1e7mr2127769a91.24.1729238525545;
        Fri, 18 Oct 2024 01:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQg5ad50z5TJT0Vz61miNpBzAGlHXC74/vab5FUTVCqiuFjBxtHJhtJuueIWOvHHFw+GQZP77hMr7YozQ9XGI=
X-Received: by 2002:a17:90a:6f84:b0:2e2:bd9a:4ff4 with SMTP id
 98e67ed59e1d1-2e56173c1e7mr2127748a91.24.1729238525123; Fri, 18 Oct 2024
 01:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com> <20241014031234.7659-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241014031234.7659-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Oct 2024 16:01:54 +0800
Message-ID: <CACGkMEsa7wQdc4FqN0uKu8jSzsTAxwbL_w2MXg0ML4W-qGavHw@mail.gmail.com>
Subject: Re: [PATCH 5/5] virtio_net: rx remove premapped failover code
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, the premapped mode can be enabled unconditionally.
>
> So we can remove the failover code for merge and small mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Let's be more verbose here. For example, the virtnet_rq_xxx() helper
would be only used if the mode is using pre mapping.

And it might be worth adding a check to prevent misusing of the API.

Others look good to me.

Thanks


