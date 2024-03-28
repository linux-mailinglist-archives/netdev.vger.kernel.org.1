Return-Path: <netdev+bounces-82753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37E488F945
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423BD1F2BED6
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F5823768;
	Thu, 28 Mar 2024 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djRDraCR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232AC50A7E
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612604; cv=none; b=qkN0wk01P3cCBtH2ldIznDBet0Kg6DZqAF7o8LGmVhV5Bca//Y5k7xqbV5G2MiWbJMd6q5voUD+xsgBIo+MeY4a8WKj0okZInFj+otCRMjPn60VZiKKI6cAB1IrChzEdbKHzQ9NK5U7GK4wm4r6B6CO5nRoCsUws50fc/mL/N3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612604; c=relaxed/simple;
	bh=qMuY90RU06ldvXyUdfez/ncLT/9htamRUr37CGC5ACM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwMwJZOacPy7zT0Ib9j2dNAtQMpfAhGjSmYyoKC2lXhgh/iCODMoc+0z5zTqdCfGI755GUdbQJ/kbS5mXSkneI7MEUHflw/gOrH0Xjf8+JgtDn3AKfLtcmwnVEw2c/fqjIyr1BKHQtqopPIYdYY7qJs/nDzcjPaHJShjoKZMWqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djRDraCR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711612601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMuY90RU06ldvXyUdfez/ncLT/9htamRUr37CGC5ACM=;
	b=djRDraCR+25mJdx8ixCdjEjNZ0xipKMXxXIoDfFG6I2r6Irh3YclOXQ/I73HHHpxLz/YQn
	hPho69EPK1y/8IgQ7t4Vwyd/RWDlhMFtXP+oK53Kw5HPTM2r8vf2G7KqHbH9v9vp1p7d/T
	Isqgon23wdrtXJHGCQaHGk99XLk7mPE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-NNftgrlsP32gVWnHL7-NAQ-1; Thu, 28 Mar 2024 03:56:39 -0400
X-MC-Unique: NNftgrlsP32gVWnHL7-NAQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29905ac5c21so616311a91.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612598; x=1712217398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMuY90RU06ldvXyUdfez/ncLT/9htamRUr37CGC5ACM=;
        b=FP1C7knLdvc3o4KoUzkFGisY7gsNDX3RLCgw48BPQ1p9kw696CeL7kzzOJI2JpUFox
         mGnGDr2DHxKqAJ4DRvksHpvW+1PaUOHRygF3BbJpdDAlBma//ejE65mO+/IsQWsM3a4W
         AsOA+0ZzgIrb8m2qppn30eRYdetAZ9QqhRHrWndWYgvCol56cnfU4E/3rVZv1iHe5gTn
         1RS9WwO/PDahPvIRMF2xGOWgAJM0dXyb4OKkwaSMSa/CC2TlgtGCd3VNgtvFo3J1Wfzf
         c8M6NqbCs9YFkYkf4w/efse7y3lTGvOa9kxI7IxzqrP4RD7/9EBhW+ewGpIxKu1kY0/J
         YhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfGw/yBI2k8W7gNCqGHmuoVpjzUj36CXbXXzjxZbQQ9fqQLJlFhXJnKelODVLqgX+JNhRqHEoBlsCYjcCRy/JdgbAqxlks
X-Gm-Message-State: AOJu0YwotPyJWQqJSLxckVUwHYAoT2epcxtx5m9ksjdKesEUDVf8h0/q
	sG42ARjAyEngZ9DiQQrpVdmR/292yFqd7mY9fRSGqP46P8wwzQOTAtSDy01D+LrZuVBkE1yGTvg
	CODuOx4HFGsle6HCBJQqEQMpLKj8H97ST04mvjesSUiHa1Xlw6SP6NXvDnSlhFtVNeebHqPuhvx
	rk9Lt2XpUpkuRbw2INz/oOVoRKCQvtvqWgu6wV
X-Received: by 2002:a17:90a:6d82:b0:2a0:99b9:dff0 with SMTP id a2-20020a17090a6d8200b002a099b9dff0mr1686999pjk.16.1711612598236;
        Thu, 28 Mar 2024 00:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdfM9f+Ys19JA8GILgDnNKXIhVRTVPRqVS/fiSFTFwJ5Vy6BwFi+yHd4p4PtmjI1CNMZWR4yIxHQSKosoLrTE=
X-Received: by 2002:a17:90a:6d82:b0:2a0:99b9:dff0 with SMTP id
 a2-20020a17090a6d8200b002a099b9dff0mr1686989pjk.16.1711612597940; Thu, 28 Mar
 2024 00:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 15:56:26 +0800
Message-ID: <CACGkMEszXC=B3U05OsbMwEFcvSvU7AwPEKasmQa=VgjCz+k2ww@mail.gmail.com>
Subject: Re: [PATCH vhost v6 07/10] virtio: find_vqs: add new parameter premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> If the premapped mode is enabled, the dma array(struct vring_desc_dma) of
> virtio core will not be allocated. That is judged when find_vqs() is
> called. To avoid allocating dma array in find_vqs() and releasing it
> immediately by virtqueue_set_dma_premapped(). This patch introduces a
> new parameter to find_vqs(). Then we can judge should we allocate the
> dma array(struct vring_desc_dma) or not inside find_vqs().
>
> The driver must check the premapped mode of every vq after find_vqs().
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


