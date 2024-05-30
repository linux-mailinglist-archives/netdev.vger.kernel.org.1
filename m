Return-Path: <netdev+bounces-99270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CFB8D440E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A04287CB5
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C0E52F6F;
	Thu, 30 May 2024 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbkL/bDy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4BD1078B
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039511; cv=none; b=jRNKdoQLEycHvMPLTEVQR3vyn7uLNh11YUu3a2i7GnPGJMbrMugrEP7FTmYd1Ozs/1YBJgtBFuRSX7OAdsRb6y6QbuTPvaStK/doKxKvV7IqJDRHJARVtCj4aO57jUfChdAtwjOx4aow3NsAu8mEKy6ejMnYyfAAzrzSqfxgdr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039511; c=relaxed/simple;
	bh=gvyjZd5IaiTDWjDUYVA8c6LUGBpslShBCIPBi4+02T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIoeAuc0YOaDiKQboTMI1WHKVgIs8cJWOvz16QY7Sc+RVNhqTzbmcmGs7n6cujfH8JO/fjlGtcrp7qlxm8NeVnMq9NwD2Hf36liPLxsv242ISrSYaUIk5UGyNC6Vhd94RzxjbkOMOe4z1JKTnJCWFrQIqYOQDlq2HVLoNYu6eQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbkL/bDy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717039509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvyjZd5IaiTDWjDUYVA8c6LUGBpslShBCIPBi4+02T8=;
	b=EbkL/bDyyCnbTlfMhKjg2EA73BKgum7OvOs7T2emyWNsFwqB7AhsmJ4SwXT9ieinCV5IbN
	cMoWjfLZX2crkONpqPKW39MC4cE+me8DofdxOCi9Sc7gVaYD8+DeMUPTTxpIp4vOowI/Z1
	fxpQX4UsB+I9B1u9Shx3s61Go73cH5M=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-UL4gELhMNom8TaljHMsU1w-1; Wed, 29 May 2024 23:25:06 -0400
X-MC-Unique: UL4gELhMNom8TaljHMsU1w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2bf57221fd2so453031a91.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 20:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039506; x=1717644306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvyjZd5IaiTDWjDUYVA8c6LUGBpslShBCIPBi4+02T8=;
        b=vCk/ht+fjJsZgg0tqyP7p7+Poi9IQNZcLRQKgDt4xkEEj2CaNzuOf8TF/HrZpkvDwh
         yotXc0/vnEpsk+/qCoZiqjF7tv02EXL11DC/8Hf+Zd37mUCJBpR6Y6W6f601I6gGRfQk
         KoGjPJ/hfjGFie3iJucQcYu0w7rSYfRnMucKsCalanRqkO4mYG0xCzAQElfx0Sxhy5/x
         +yUGGc6GfvUXsaJ/RjNM/q1paVp1UZh7kdwi3NZOPvEC3Gsh7so05sX9LtPNYssqj0mc
         ZI+AGPOPvkYi+4Jl+f9sC6HzTrDcIUBjGrEmnVv+JVWcGkF0bZAQFf73Ogj7KXk1v9XL
         hwsw==
X-Gm-Message-State: AOJu0YzyUI9qTzpO/vK7txIHn66D7sDCc5lYyKzQC5rM+PZwBgIKKrnc
	HCXS87ccrSK0tdbuQTFHz9vlZeYK0LAntC5Q3SbwDInrO0QtsXGHWYQDapqhwv/PHlYkM+Hh7Ri
	bveunY60Mms3gXMHB5C0emi2Jjf0hXUdb6AXqu/Pqyi/ne+aUH/s4kSPTuxFQiFrNc/paGJsvbI
	RwAuo9aCtp8JHDT+GBFMJh2HGOb16s
X-Received: by 2002:a17:90b:360f:b0:2bf:8824:c043 with SMTP id 98e67ed59e1d1-2c1ab9fb68dmr1011594a91.18.1717039505530;
        Wed, 29 May 2024 20:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG96xKooU/90RmHTSiFiV3oOPsdUF20/3dw7DdogIGRjKcpmQnv/lRyL3JORNQzenL8VZoz7eZ4oHhGnDiVoTc=
X-Received: by 2002:a17:90b:360f:b0:2bf:8824:c043 with SMTP id
 98e67ed59e1d1-2c1ab9fb68dmr1011570a91.18.1717039505002; Wed, 29 May 2024
 20:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com> <20240508080514.99458-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240508080514.99458-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 11:24:53 +0800
Message-ID: <CACGkMEswH8X0utO-ORZ8g-4UELfhxxDxdAaycwxUdVR2uxw_ww@mail.gmail.com>
Subject: Re: [PATCH net-next 7/7] virtio_net: separate receive_buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> This commit separates the function receive_buf(), then we wrap the logic
> of handling the skb to an independent function virtnet_receive_done().
> The subsequent commit will reuse it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


