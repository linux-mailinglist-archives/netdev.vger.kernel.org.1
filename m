Return-Path: <netdev+bounces-177002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B9A6D370
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 05:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EB116FC4E
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 04:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0155D13A26D;
	Mon, 24 Mar 2025 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEyw/zzt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974510A3E
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742788907; cv=none; b=OlqsvzuBPyz9XtHo1ISDtV3JbJw7VkJOvO4vE/iQarM9i84gfSohYOk0+ts/qr294Qs8xzY1NXPCsYYkHMCuz1/QTr/hRTcLAo/JYChJqHnjE03d5tgaSNSVZm4eufNG/9nKyodj42UHVYFhZMl8fSqGBkMCdFFWTi2Qhtisufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742788907; c=relaxed/simple;
	bh=CGSlvFYaKu2MQWRWu1e9Hm6aB6LcidbseISLkc9BRNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odMUqMgOzU1l/xhgHlRr/egjCktNhcJagnxiQ9Qx7M6LGlTXu/BR52gXnJmvy1jcSBal514EJgfND+mTWm+9oZJl4IYbRJJq0SIVNenkA/VJcbKr6rX8aFNTMXn8cDXQYfu6ebgfEfBfTrRA7P63QBiU4yMJjVQqcN2nIX6oPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEyw/zzt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742788904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+OhXmPoo0DLljAU0TDjoAu4m1RP6jxtWb9wetcQgFs=;
	b=iEyw/zztLouPWu9M842ApjmGz9+lACErNKQVM4qLccJkaVYtVCtU9waw0HukS1HhoNAOdS
	dTKJVqNSdIBXLZgD4dKRiUZ0PaLvBZFL/2AiNebwQiNUYcY2nCjap7RB8qCW7CKsSw3X3S
	VjRtY5sV9mUsAJVr2OpPT1wQLZJCiSQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-RzvDOWo4OQqZ1LA1eT13Rg-1; Mon, 24 Mar 2025 00:01:41 -0400
X-MC-Unique: RzvDOWo4OQqZ1LA1eT13Rg-1
X-Mimecast-MFC-AGG-ID: RzvDOWo4OQqZ1LA1eT13Rg_1742788901
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so6370533a91.0
        for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 21:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742788901; x=1743393701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+OhXmPoo0DLljAU0TDjoAu4m1RP6jxtWb9wetcQgFs=;
        b=e4iBTp6w6mLKZ3ilSdUzzls/efxMPFjTW0rmRqwkeqWpqB04J5uALdz8nb5RkL0Wwx
         5pYgMtJJM2THGPKLAyVXLOu7hM63Uryij/UD7eYzMDNshcp/yDubew+YAtl51ATlNd7H
         hfA5QI8fiHJx4EK8OMwoa28oPAtLuXWrLiSsJMdlcE4wOus796B2zzw/0uq/9nVNOstj
         wSbcqMiIG5zDWgRplGTtMfUEbQhySNtE+tnsHktcTuvMNTsBIaGyV6btidKfRGUUjLnm
         s5J9pvYqG6U0Ryaoc1RbgOHGJ54Q+ZEib17+pSX7hpq45Lu2DIepBzNkkEPfXcdv0b1i
         WcJg==
X-Forwarded-Encrypted: i=1; AJvYcCXqCSycggZ/S9Yf52l+rBQCkoIKHW9k9Jl2JL0UX8zjgxJJJJh93eMg1nLyP4TEIbk04IXkK5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaCjuGgSnkky4Naxo3V/Nev+DpPOaTBM8jNrzMsSPzPoIhglY9
	puKzDqAjqz3qUSNxc7qFkxLQx7zuhcT7VT/T5lidl1NGIicSct/7jtq33UvRGvfUopCzd1mTftI
	GkPjU0VshPeMKojW0RUiBLwlAfjmbbNXPluCs+cGRol+BKhwfO6gyHSUL46ZLwnqMiB9hE+aE0+
	cXySJsuBoI0Zr/DhUYZlKy4yabnnXK
X-Gm-Gg: ASbGnct5aJ7xlYiEsWzJ6iiEU+e+7UKDshMOOC+mpvn28ZiIYgRN4YxrQ57VKVP1wEY
	3v68RF9Z7T3mKBmvcZL6ulHV0hSYowOot5o45oSGjlY52xOb2P22T2FdvFP5RBm2OlG99CVE=
X-Received: by 2002:a17:90b:4a45:b0:2fc:ec7c:d371 with SMTP id 98e67ed59e1d1-3030fe56af1mr15735741a91.3.1742788900688;
        Sun, 23 Mar 2025 21:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtwyi1gJ0zaQFQsrBomqFHMj2VHAekCjI+gMhb1MAOqbuMYR3u5EZtG37zC0QeYxAC9WJADhULBbYtaVCZnck=
X-Received: by 2002:a17:90b:4a45:b0:2fc:ec7c:d371 with SMTP id
 98e67ed59e1d1-3030fe56af1mr15735694a91.3.1742788900080; Sun, 23 Mar 2025
 21:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com> <20250321-virtio-v2-3-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-3-33afb8f4640b@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Mar 2025 12:01:28 +0800
X-Gm-Features: AQ5f1JrJp4r4sxi_4HFviIS8ywunUbKIEpVHOsgca9dqLM3KIjeU47-OoEZtJNs
Message-ID: <CACGkMEvQr=cj2iXZTH8qwjByVcWwsAowOqpDy+n14sxyvQw4rg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Use new RSS config structs
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com, 
	Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 2:49=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> The new RSS configuration structures allow easily constructing data for
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of data
> for the command.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/net/virtio_net.c | 117 +++++++++++++++++------------------------=
------
>  1 file changed, 43 insertions(+), 74 deletions(-)
>

Though I still think hash config should use a separate helper, it
could be done in the future.

So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


