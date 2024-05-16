Return-Path: <netdev+bounces-96689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C247F8C7276
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71223281920
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 08:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53E16BFBD;
	Thu, 16 May 2024 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUQEUtKJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F412E4120A
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847007; cv=none; b=RAWIB/fXoHOje4pEqCqSDwRZgl4yFsckO2YiaK29Duttl1xQgiulcsj/uU7Shcslic1N46pPUoDOZvDEfS4ldm++MhRb2ogmZV5AXlPtvicYHnKFwbIYuqjajagx63qlP7gF3WEmr0xlq+eC74Hxl3zqgWgLZoQ5C/nwut0PHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847007; c=relaxed/simple;
	bh=k4p6BZBD6f8DVa1WslyLTAjRuEA4N0NOBDUZFqG9OjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbLL32xekwxgnpqxlRAkEBYJOKsH7e49qmr2LrkmeP9Mt0ROEY9GOwIvRCK3qmw/N2yZdczzYSDrhJjykrBon+cLyYoFKOv1nS2L6cNJpqt4h+/u9/ZgShcUFxfY02AucO8ozqXlzVvINm0JbQV9ZDwMPfPJyUwRV7rMvE/kh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUQEUtKJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715847004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RA+jepTOChJ7+snqX+5DRaDKCp4RJQjDydrDRBP3COs=;
	b=VUQEUtKJu3F/YLx6cmBYIKg/4bw8mILi3LTj67TQfSfALzk6GzWHYLO1RgrPRUAwUZec4v
	VC63Sdm2AMRg4bWDzNCja/5Hhex4BHhjV4s+RZSU8olT9hsSeV6q7l0SZRiWUb+VUoGfZT
	EOkVKOi+JoU3pdBW751dzKLc0PttqHo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-GLkSrD_CMCunfWhCQRA6Ag-1; Thu, 16 May 2024 04:10:03 -0400
X-MC-Unique: GLkSrD_CMCunfWhCQRA6Ag-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a59ad2436f8so468101566b.2
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 01:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715847002; x=1716451802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA+jepTOChJ7+snqX+5DRaDKCp4RJQjDydrDRBP3COs=;
        b=D9tHmK1trktaHJfnYq8rLnJEGDJ7/x/2R/L9iUbgNalUe0melmc/l4budA/s9kIQR+
         cmZr0HBTxdyW+LxShatL4uxxbRugK7gRbtL62g7Q+yTyHlG0oMDz/LsDLXW4NtiZ/Qw0
         5pLEFvNOJbDBusquv6e3WQit+xiHKdN/vJltqwNzaPS1V0rCVWDf/jLuIbXgNSnOK2Lo
         Zyu7/mhR4PM5E1fhbXayfDi3UwDeL+s77lf5giRZPlhMdD8UsEB5RARGyJzsBp94skBl
         GIfRl6S7Vzmu5cFFOqHwEn+jsxOS0kXF9+m02XGe4V64CXggietV4t+GkjTaZ+Wvs6U0
         lk5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOG0YH6H/zwXAVmol7iLdMDLAIFwP9orQSPduOFnOmoq+uWAU8zS++TJE4LlqtjdwiLEk4LDJIsISM3mAhSSvoL3KQogI4
X-Gm-Message-State: AOJu0YyGmQYaGZ2MRCcACRnvaWEISubRXjUUWIwERas+Bl4vVfAD9VJW
	UbJsLAMUfETjaK0QT7fQn8M1pBn43hMY0NqHQ37NW8rd8UVygW+UUpX4t0tF2/HkhqylNhKKWGe
	YSuktn+oq6R6pG8HiM/O9FPUc3k3wQ+NYQTv2oulHKfTgOQqNeJLtUg==
X-Received: by 2002:a17:906:37d6:b0:a55:9dec:355f with SMTP id a640c23a62f3a-a5a2d676774mr1102993366b.70.1715847002099;
        Thu, 16 May 2024 01:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDQyscwxbqGC7a+Epkh0Xcy/QL4T1fDS/fLANmDq3+Ubkm9JOf+n6UBt4e0RPv0Wj5wD462A==
X-Received: by 2002:a17:906:37d6:b0:a55:9dec:355f with SMTP id a640c23a62f3a-a5a2d676774mr1102990066b.70.1715847001507;
        Thu, 16 May 2024 01:10:01 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-77.business.telecomitalia.it. [87.12.25.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01598sm963957166b.178.2024.05.16.01.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 01:10:00 -0700 (PDT)
Date: Thu, 16 May 2024 10:09:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com, Jeongjun Park <aha310510@gmail.com>, 
	Arseny Krasnov <arseny.krasnov@kaspersky.com>, "David S . Miller" <davem@davemloft.net>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: always initialize seqpacket_allow
Message-ID: <mci7jdezdtzgoxj7zgecf4zyvxk6jixy4jgcwwoxegzkjqqqtx@7zoborovztcs>
References: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bcc17a060d93b198d8a17a9b87b593f41337ee28.1715785488.git.mst@redhat.com>

On Wed, May 15, 2024 at 11:05:43AM GMT, Michael S. Tsirkin wrote:
>There are two issues around seqpacket_allow:
>1. seqpacket_allow is not initialized when socket is
>   created. Thus if features are never set, it will be
>   read uninitialized.
>2. if VIRTIO_VSOCK_F_SEQPACKET is set and then cleared,
>   then seqpacket_allow will not be cleared appropriately
>   (existing apps I know about don't usually do this but
>    it's legal and there's no way to be sure no one relies
>    on this).
>
>To fix:
>	- initialize seqpacket_allow after allocation
>	- set it unconditionally in set_features
>
>Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
>Reported-by: Jeongjun Park <aha310510@gmail.com>
>Fixes: ced7b713711f ("vhost/vsock: support SEQPACKET for transport").
>Cc: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>Cc: David S. Miller <davem@davemloft.net>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>Tested-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>
>---
>
>
>Reposting now it's been tested.
>
> drivers/vhost/vsock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for fixing this issue!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


