Return-Path: <netdev+bounces-207338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00CB06AFF
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 03:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F043A2030
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801A61A314D;
	Wed, 16 Jul 2025 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQTX9yTB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6BA219E8
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628392; cv=none; b=VCpU9+Z8FLdeudlDJsYQ2OP6kshTHCWE9TNHAYdWweB5eFj1UftVyhZBp6AmOMyZEnjXIBJh5rTttE+ksyMiPFqL6E216B2iCbCmwWFAE/hi23a9ZJ4EDzs9FWX7o7R3nAY1zrC0fX1rCw9zbG33gYchQ2eH1r+BHsaI4nc+QTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628392; c=relaxed/simple;
	bh=BKWyQDlgpduqK70y5bsJ48SQyWbfCqQEOJF0Pjbu2y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNq92iSlVcSOpfdiKeDCuiQQnW3KdwAEOv95rqQSXGEcJIQI1ASD25KyV/CEenNZ1IuvzKIl6v0VZFbry5/wQ/SoYKFr/6BbIFNXbtwKGy2tDUW9AwnxqQAXZj+IiMonmXPs9uqweTQwcW2p3qDLFbLNx3OzW5mZt0YqaN0bTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQTX9yTB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752628388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/keS/EUkYyBiSPiys9/nqLBkkMQLW+p9NKDLAaBTJK4=;
	b=jQTX9yTBfriMp8K91jFO7/OZravKDjCnq5yLcEG0qMOnqf419WKWdKjt4nDJ9s2pfrv9yu
	7bxX8XUopEsd1m00QbxYf281lkdwXv5Wg3/phvImqJoB/nn0cP/aGKywZwOR0Oyu4+rY+0
	OkSPQOrE5xZsCiDdgZkI/tiUDyslIkk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-h6zDP2EfNJK5P-N7I8kT_g-1; Tue, 15 Jul 2025 21:13:07 -0400
X-MC-Unique: h6zDP2EfNJK5P-N7I8kT_g-1
X-Mimecast-MFC-AGG-ID: h6zDP2EfNJK5P-N7I8kT_g_1752628386
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae0a3511145so421768266b.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 18:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752628386; x=1753233186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/keS/EUkYyBiSPiys9/nqLBkkMQLW+p9NKDLAaBTJK4=;
        b=euEHSdOMmDgNzqoOP2tcK71uismtWyyJpWSiahR2dZ7QcIdTqnE6B33cGWg25rq6Wf
         e/5bkukdL8qnKvFgFyG+Pgw2EqwJB5npL5Oz9nBCmw/KmRZteNxx8TZoHDcr8gnG9Y+H
         bJY2OVreUJFJqf45xtJHPpUsUt4+2DwpnkWbPM6XZ9aKYN+9QaX2Y9hmVEmA0zAwhJ6z
         XuP0IcJTiYrbFibvKa5gwXGlWogk5ObauW7Gw+V7Ezj3uPfDWOZ4QK8K6yrN3kAoxi2d
         s9xmNRw/XOoJ0cT/Cw4vm4HXBsbWT7ovKKC2ioG+S92Aaf7QDfbVbFZsk0me+GxBQt20
         ykdw==
X-Forwarded-Encrypted: i=1; AJvYcCV8ULq8qStLZ0Bf1Pa/rfkhu2UHjoUeJLfNzkHIpOICR5iD2MCglfb9Lmq4m/bHzF8zBO8OCHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJplmSRQB2It40YQr/PzW2MqKlPfKFYqeSAdrGkY2Krk7yjRn
	w+lwPKl67ZiT/ekl+lPzDTxZgHSuSVRSp9vORtw18vx6IF9jPXfzg/BbRcxgyUK15DJSW620TJi
	7/KnJs/FmD14+XsLkcKNnvD6e4LG5ZjJYPbDXXt2fvnt3Ys6ZQmcRodNv5iejZrEqWikvWQZQ3k
	tFQoqnZi8a7uyhjsH5l4N0GRvCgW8gJst8
X-Gm-Gg: ASbGncs4GNb4mJ1IqyHnnU4kQYqyoQyEqwaBJLl+ZpbBUCHWBDtIIpTShbRKn1nQJrE
	imk20wTSUoE2r8Le0rPHUXu78aeeKx4Ls5Fo6PSLYkZYpNyE4s0sGvKQeygUFf1+EJGID3UxSGC
	gj6mgdjkS8a9huwX2EvYod8g==
X-Received: by 2002:a17:907:c89d:b0:ae3:6cc8:e431 with SMTP id a640c23a62f3a-ae9c9b6c4f7mr138675166b.57.1752628386134;
        Tue, 15 Jul 2025 18:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUD3HiOIYDUW7hX6g4mjiRwOrmAALXXgw8/ypx88cvn2L6gXAwS9h7hC+qro3T7N25vt1Mq+1Ot39s20uVR1Y=
X-Received: by 2002:a17:907:c89d:b0:ae3:6cc8:e431 with SMTP id
 a640c23a62f3a-ae9c9b6c4f7mr138673666b.57.1752628385746; Tue, 15 Jul 2025
 18:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714084755.11921-1-jasowang@redhat.com>
In-Reply-To: <20250714084755.11921-1-jasowang@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 16 Jul 2025 09:12:27 +0800
X-Gm-Features: Ac12FXzEZyLhkQ-ZlRuaRJizHbPzC5U2b0INYQwKCqtanE6LNjchFHQweOloptQ
Message-ID: <CAPpAL=zo2nom7=nL6y8g5N+7qR3oG+bVip1KFxCnJCu9V-M8nA@mail.gmail.com>
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches v2 with "virtio-net-pci,..,in_order=3Don",
regression tests pass.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jul 14, 2025 at 4:48=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hi all,
>
> This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> feature is designed to improve the performance of the virtio ring by
> optimizing descriptor processing.
>
> Benchmarks show a notable improvement. Please see patch 3 for details.
>
> Changes since V1:
> - add a new patch to fail early when vhost_add_used() fails
> - drop unused parameters of vhost_add_used_ooo()
> - conisty nheads for vhost_add_used_in_order()
> - typo fixes and other tweaks
>
> Thanks
>
> Jason Wang (3):
>   vhost: fail early when __vhost_add_used() fails
>   vhost: basic in order support
>   vhost_net: basic in_order support
>
>  drivers/vhost/net.c   |  88 +++++++++++++++++++++---------
>  drivers/vhost/vhost.c | 123 ++++++++++++++++++++++++++++++++++--------
>  drivers/vhost/vhost.h |   8 ++-
>  3 files changed, 171 insertions(+), 48 deletions(-)
>
> --
> 2.39.5
>
>


