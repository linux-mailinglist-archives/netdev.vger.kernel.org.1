Return-Path: <netdev+bounces-105063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D0F90F864
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 23:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5130B1F218CC
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B5757CAC;
	Wed, 19 Jun 2024 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vz4yatCb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1BE433B9
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831831; cv=none; b=RsuGp+PFddOK2lZmgZIre7XNK9gJnTJoWaRcp1vTpO779SaSkHDkyUDsHC/hrjOmrdrurEU9jAx1Ty+FSKNfhJMfVfXGkzdGI9cMEOB+p96nnDgHKf5+5a7A9+q0WP112u2Sgv6juT2uRnSoqLe7X1xDfiGJ8Qn7IgEgxwgUNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831831; c=relaxed/simple;
	bh=o4J+VHpc8lgAhrOCF4h67qN7kjnABDSkF1ibvjkUMTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kS90sJpWsYXOVwr0YEnYej9e1D5GbXxw+9n6hOrGje82Kado+kLy09FtlVAyatmBqKEecc/3Qyqy3JEJhJ1O7pMpIuwD1ghsi9J3iSu8vI37Pz5Y+xrpiaedG3ZKiAHYstV7GGI3MYiodwEpqtnuqYI7oXMa9cOlPNePRdbLewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vz4yatCb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718831827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaGtl7xWmoOu9CHlxjaHn+EyI5IwHc9tV/Nn5bWYHYg=;
	b=Vz4yatCb2WXUktwen8ww0o0PtLRqa4Vo/HfaPBdPdH+wwK3GJfiPGD7ql5Wt3y1cqDrVGh
	YtAx2liz5biH3PHFU43hDn+6JR26pr/O5ngQUmjNWzpzYIbZaZ9GiCEPFdQGZR5OhyeE3f
	3o1rOUxzr1hU+z/NE+qZwZr/UZz6Kpo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-nyDg1-qrNfmC9mwYpOfX5Q-1; Wed, 19 Jun 2024 17:17:05 -0400
X-MC-Unique: nyDg1-qrNfmC9mwYpOfX5Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6ec06ed579so5974966b.2
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 14:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718831824; x=1719436624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaGtl7xWmoOu9CHlxjaHn+EyI5IwHc9tV/Nn5bWYHYg=;
        b=SLTVxyn90Sh5V/tVXr7PkA8fnVuHIC/jwYaJ5Qd84BUmXskMLAcZKr3AdzCPg6eLy6
         UoX2l9hDVPOrT4nMZDiCtI6ggmuByt8syQG6bunfKLR1jH4NKq3t0s5H0jDRA0OUq37o
         G3I29F9xzt3GILTK5N37FMt0qpHaFiWFlZZibmnXxBzokrwKYH7IOAP2rNTYuDIm3WGn
         QIVtRboShdGWqm566qx3FTrgCiOLO5gX3Ru9nf1qapPOF+hFdrNUb2ZGv2w6bz7GQ5Xj
         mrdhR9mFpFEsS1ucr/0XKMsZAPANpb+XZVVayeTD44kZoGnbp7Yj/PebN26/t05MjaDj
         7Vtg==
X-Gm-Message-State: AOJu0YyANOXL3nFEVNrTk+gN6OPhkyRr2gYSLpQtEeHma9G0fHDDo2RO
	9eOHty4Y5n3nggGTlZpm2qIL9OeiJa/z5JNU4I2Ne8fsyo6kNMZFujBq5za8VbQrn8g5hxguDcG
	b1sx8kNpFYRhHnLWXP14kPJOzD9IQvWhf9iif0Uk9TArWloW8dYRB/Q==
X-Received: by 2002:a17:907:770b:b0:a6f:7591:9222 with SMTP id a640c23a62f3a-a6fab77b448mr220541966b.47.1718831824574;
        Wed, 19 Jun 2024 14:17:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXs9jDkV0ByYLMnnQwvoYXJCd6WvY39C2Qk3xA2BJXIQlnCk+L822PM2Nebfis8IJiN1YclA==
X-Received: by 2002:a17:907:770b:b0:a6f:7591:9222 with SMTP id a640c23a62f3a-a6fab77b448mr220539466b.47.1718831823890;
        Wed, 19 Jun 2024 14:17:03 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f9982asm693979466b.202.2024.06.19.14.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:17:03 -0700 (PDT)
Date: Wed, 19 Jun 2024 17:16:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 0/5] virtio_net: enable the irq for ctrlq
Message-ID: <20240619171535-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619161908.82348-1-hengqi@linux.alibaba.com>

On Thu, Jun 20, 2024 at 12:19:03AM +0800, Heng Qi wrote:
> Ctrlq in polling mode may cause the virtual machine to hang and
> occupy additional CPU resources. Enabling the irq for ctrlq
> alleviates this problem and allows commands to be requested
> concurrently.

Any patch that is supposed to be a performance improvement
has to come with actual before/after testing restults, not
vague "may cause".



> Changelog
> =========
> v3->v4:
>   - Turn off the switch before flush the get_cvq work.
>   - Add interrupt suppression.
> 
> v2->v3:
>   - Use the completion for dim cmds.
> 
> v1->v2:
>   - Refactor the patch 1 and rephase the commit log.
> 
> Heng Qi (5):
>   virtio_net: passing control_buf explicitly
>   virtio_net: enable irq for the control vq
>   virtio_net: change the command token to completion
>   virtio_net: refactor command sending and response handling
>   virtio_net: improve dim command request efficiency
> 
>  drivers/net/virtio_net.c | 309 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 260 insertions(+), 49 deletions(-)
> 
> -- 
> 2.32.0.3.g01195cf9f


