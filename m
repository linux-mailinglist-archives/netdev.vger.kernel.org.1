Return-Path: <netdev+bounces-112503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22227939987
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 08:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D44281F35
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 06:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8571B13CA81;
	Tue, 23 Jul 2024 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8F5qb6B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A2632
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714515; cv=none; b=S76Zfkm63NDmzqarHp0LP5v37W1ekC5V1lEwt4y4bjMgOYIvUa6Sa5fyyplCYWQyipYep8LZlE3O6dpT5nTugc8gHzfDHeGj8exO3n0WZAlnZX9YrV34laP42t/0jy+BYgc8j1LuPGl6kX0CPzgkkeZrOzEFxYfT/AHy9Rieey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714515; c=relaxed/simple;
	bh=9xwqJwDsGR3pFv2mlR4oUH8gkzfpSSnRrp+hDPttC1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGD3UTJTU6O9lmJ5jsSLdCVMxrSxsoCPHWvy+ofBwYzh2UJgN2mCDO2BrVbhK33J6d2GfPO81jg7ZcrOCtpUs58Pu/E8Z+kIVb80ZG3vjDFsdLGQX3nEx+B98qtvNmgdUfxN6bTtFXS+UgHWhth1uB3x+kfMYXwoUkG2pdVcIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8F5qb6B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721714512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xwqJwDsGR3pFv2mlR4oUH8gkzfpSSnRrp+hDPttC1M=;
	b=d8F5qb6B93d9OZC8c5LcIYNd1bOknHVofyjdXcJLiGwEf5V43sTqZFRdPAfGR4PqMwtYyf
	wupTLYnWHbzjllUDxSaKYSKfiGdrcbWAQpFS9NzPTNAU9KDi3NfdjGej93u9g5oQw+oky3
	dJehTBGf35eTfyvUgZHImMLC4iY5Uc4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-k0jqj_opMHGhsf2VIeHjSw-1; Tue, 23 Jul 2024 02:01:49 -0400
X-MC-Unique: k0jqj_opMHGhsf2VIeHjSw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb576921b6so4484381a91.1
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 23:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714508; x=1722319308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xwqJwDsGR3pFv2mlR4oUH8gkzfpSSnRrp+hDPttC1M=;
        b=bV78r6l3pzuIlDzpxI4xLMn634MmGKYNfwqQQvb98yAEXK8RqnpvGRAjr4ytfNbwrn
         n+dixYvuHDkD6vRs7nUxUvjX+CLDbiIT4Q9mdEO9KnETD3bjb7Qv8ZCgD/pNXbtGv02O
         FOD2SnvlaECA/0Wr861y939FHxYD+1+8mkq5x+j4ImJqGMXjQHA5N9yzRmPG+rBmY5LE
         MqugPcr8MCmi7+HW8w1QX+DD52Tldsr2JeeZQ/mdPQ1hXcF/XGndHcdSAP/hTs0NFOnU
         m4fLh3Pd74zeue71f7nm0pBQmSK1+6PHxEAs/LMuhmNuRx1q5MP9gjOHFbq/2yMKSd4c
         ll5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYLLv+Ax4el6Oz/fpGciicWcIDwdFFbLyMydM8fAZLp24CYGZMKAIVZIFo2dwJeoccebfv9X5kSTC2fM8kP170nyBeJ8Iy
X-Gm-Message-State: AOJu0YxGc/TOPSD5cDxVODR/ucvGkaZ0B72jVjXDfsYlnDBLjYrwF6Ok
	BfYzOFjXW7f35Bi1Y6URQORZNUvKX21xN7mRZ8klCNtGQlE9ztbM7f86LJeKNHaO0CDgzmUTjZL
	UaMYlbjDUm2h8HGmjPTuy2ti0AxH02wbpjqhTx1MTg7+2w6gJpT6S8iOp1gDhUrm+FRu3hr34Ax
	kFnCFDFINK1VqLAjxrajRPUl/ajU/H
X-Received: by 2002:a17:90b:1e4d:b0:2c8:7897:eb46 with SMTP id 98e67ed59e1d1-2cd274d48c6mr5248611a91.37.1721714508222;
        Mon, 22 Jul 2024 23:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoEpwALYUFixu5BsTTbuOhYXcOpaanMm+heueYUhW44DeZ/5YttPO4b63Hy50iMiec8ZUd1PMvKMmbsaX93RM=
X-Received: by 2002:a17:90b:1e4d:b0:2c8:7897:eb46 with SMTP id
 98e67ed59e1d1-2cd274d48c6mr5248585a91.37.1721714507652; Mon, 22 Jul 2024
 23:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-3-lulu@redhat.com>
In-Reply-To: <20240723054047.1059994-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Jul 2024 14:01:34 +0800
Message-ID: <CACGkMEv5-Hn+LNKNT9ObCaT8xBv_BKrhoJjBA9RShGgh3Hwq3g@mail.gmail.com>
Subject: Re: [PATH v5 2/3] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa_sim_net, the driver will write the MAC address
> to the config space, and other devices can implement
> their own functions to support this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


