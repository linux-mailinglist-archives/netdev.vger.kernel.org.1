Return-Path: <netdev+bounces-179498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D1DA7D211
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 04:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9343188ADA6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 02:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEAF1AB6D8;
	Mon,  7 Apr 2025 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwLcE8MQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A514212FBA
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 02:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743992107; cv=none; b=L97pWZNuDjhINoyAgUvSZoOV1lopvm2knmS6Aodr5RIc9gEfJO+NdosOsXt82a8AzFw3HVTXmGaSsYIl06fFcmPP83KiIJ+r6xbeIIMAl8Dr08FiWK4Oh8q2e938ijlo2m9TRycwT365ZwCTDiZHnss06E+mgZwizLchtXYzh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743992107; c=relaxed/simple;
	bh=5iGnaKTdh8qdUpTGBnIaXxXw7Npl7YWIGBbllmqoExE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieZFo3EG30r2hF0YkxW0tXZIXDlJE/6Lb8Yq34Xfy6E6aWPuUjXwI9BZT06cEYKjdek1Kv0fu2re5JXb/KxD6+HO5jUjiwkjcrm0AcxSK9DswpRzbWGldx3LD8vyFf1fngQKK7qxrN0OUvAR39vDESoKvzeLobzwqUAofefNsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwLcE8MQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743992105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iGnaKTdh8qdUpTGBnIaXxXw7Npl7YWIGBbllmqoExE=;
	b=JwLcE8MQsdv0WhuBZVzPSpW1luxfBlpUyqiMMZqIF/qQa3w40ziGZD4fTZTJJWYhccsJHo
	evyO5Nj7nE+TnglDmmiSf+QVfAtmKSm0HYxX9X+5B9twsenEj4xrrWKAb1xrk2bGSXRlqC
	Mk+GsYZI7xiKaie51GsWjMk3Y672tVo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-wjwD2JMvMH6wo64ImkPFGw-1; Sun, 06 Apr 2025 22:15:03 -0400
X-MC-Unique: wjwD2JMvMH6wo64ImkPFGw-1
X-Mimecast-MFC-AGG-ID: wjwD2JMvMH6wo64ImkPFGw_1743992102
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-73691c75863so5029812b3a.0
        for <netdev@vger.kernel.org>; Sun, 06 Apr 2025 19:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743992102; x=1744596902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iGnaKTdh8qdUpTGBnIaXxXw7Npl7YWIGBbllmqoExE=;
        b=vm0lp066rP0ImEnEpUvHvkOREAFZZN7Q5q+MFMu0Dvx6FTacp6ZxSIbASF9SQIbLxB
         GEVw+FsWoqV2dK/PkCPeyYV87oP4TRkwvj2Ak16ogpuXR8Fl36lToT1mCPOTdLoQ1ODW
         QDRzGfsNxTtJr9gybL/Jj33/9wAWPhGUdQM3rNLj1O6wWzwjTIRfEC7gqxkP7RtwAjoE
         bUxbR3zr6jzmAT0A6nGeZtOQjQBCObBSKnxC0D/5s0ADIgqRD5d1oJLqvSP6+3fwUt/L
         f4LpY1cIo9uLlMF1/Z3C8qZfoJQ70faenDO9cO3NjGiquCeuiFKV7QaSKbOVvnrqeaW4
         3Uog==
X-Forwarded-Encrypted: i=1; AJvYcCXbBkeO9/6SkKtwRhXe3LW5QbUjHWQVWHAGCEdkxwWc+08dKhm+RWRdr8Yr2bkJpBt0f/lCgTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFeJWrPmk3XfpAXUsFwhXUPFu+gOopcMWroY30SfasT8KXQSMV
	UjF5AG4h0iseuiCvttxZh9NtPqHP7Qqnsq3PA2ZhPVmo4FCmPfXqTHF13A2wcRJGo55kTqCdsgJ
	ujVvW9RlvqBeDljEB+Yrbluoa9O0MIyuB9RYjuiayS0iSXh9LcktbcyRkHRrQ4ff6t+TtijK4YD
	1kndQ1Rh6rDR8mxtdOcok6tNi5zeN7
X-Gm-Gg: ASbGncvCqi0gJywEBTH2KDWyUf8xjejgqw/YVUs0+ATati/XuqksnuONavIv7WnAwcC
	YmjtAPHIMzV4lyeJPF6V86ZO762xRn8Nf4q+s5Mes9duV2qNKUW/yhbztVq+GdeuQW9Dozg==
X-Received: by 2002:a05:6a21:6f01:b0:1f5:8655:3287 with SMTP id adf61e73a8af0-201081894f9mr15997601637.40.1743992102453;
        Sun, 06 Apr 2025 19:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2xrRUCjmDh8gU4TsrPWubO4RaHlHA1/mZMFsc3k0pvCi4jb3ExJetOAjK+ODkU/PKVNydcIKM1LkzsCQTKWs=
X-Received: by 2002:a05:6a21:6f01:b0:1f5:8655:3287 with SMTP id
 adf61e73a8af0-201081894f9mr15997577637.40.1743992102154; Sun, 06 Apr 2025
 19:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404145241.1125078-1-jon@nutanix.com>
In-Reply-To: <20250404145241.1125078-1-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Apr 2025 10:14:51 +0800
X-Gm-Features: ATxdqUHS0zfr8JGoyzsGJ5km2ABwTqNENhD1uX4yKsHGytOkPk4bkII2gJMMLUM
Message-ID: <CACGkMEsFc-URhXBCGZ1=CTMZKcWPf57pYy1TcyKLL=N65u+F0Q@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: remove zerocopy support
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 10:24=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrote:
>
> Commit 098eadce3c62 ("vhost_net: disable zerocopy by default") disabled
> the module parameter for the handle_tx_zerocopy path back in 2019,
> nothing that many downstream distributions (e.g., RHEL7 and later) had
> already done the same.
>
> Both upstream and downstream disablement suggest this path is rarely
> used.
>
> Testing the module parameter shows that while the path allows packet
> forwarding, the zerocopy functionality itself is broken. On outbound
> traffic (guest TX -> external), zerocopy SKBs are orphaned by either
> skb_orphan_frags_rx() (used with the tun driver via tun_net_xmit())

This is by design to avoid DOS.

> or
> skb_orphan_frags() elsewhere in the stack,

Basically zerocopy is expected to work for guest -> remote case, so
could we still hit skb_orphan_frags() in this case?

> as vhost_net does not set
> SKBFL_DONT_ORPHAN.
>
> Orphaning enforces a memcpy and triggers the completion callback, which
> increments the failed TX counter, effectively disabling zerocopy again.
>
> Even after addressing these issues to prevent SKB orphaning and error
> counter increments, performance remains poor. By default, only 64
> messages can be zerocopied, which is immediately exhausted by workloads
> like iperf, resulting in most messages being memcpy'd anyhow.
>
> Additionally, memcpy'd messages do not benefit from the XDP batching
> optimizations present in the handle_tx_copy path.
>
> Given these limitations and the lack of any tangible benefits, remove
> zerocopy entirely to simplify the code base.
>
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Any chance we can fix those issues? Actually, we had a plan to make
use of vhost-net and its tx zerocopy (or even implement the rx
zerocopy) in pasta.

Eugenio may explain more here.

Thanks


