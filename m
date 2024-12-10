Return-Path: <netdev+bounces-150788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF89EB8C9
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0735128321C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CB01AA786;
	Tue, 10 Dec 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWqit7l3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CE1B1422
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853269; cv=none; b=iaN7a3JcYCO6+Oo8Md23wG2PEbjAOq+gJMe61XmbhgAHBj7ByKt1eUCHRVQoKVhTdirP9bT5nkR7bWsbqXE/n24C7mNQ9pyhZ/uE3jObB466DHpIthy5fLe0akkmWZpSA9dFgKJ8GLiG1uIWmQN57QO/FcocuVWu97oHD5WfeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853269; c=relaxed/simple;
	bh=K9ByPjXthNnzk4FPK877f5xtZOPcLGkA29sc86con5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsHQDRZTCihbNlwREUE1lULQb122ibiqBZLkMv+hLye1A/iasMa0IL1oSG7hMNWhdEga8YI7u9/ajONK/MMfEtAJa2BO3WlXmqUhiZYNrdImjT2eu074LNt9dL6jMo0sBT1i5DZyIhqZgkpfhr+qDvt6EVgx5+UO5cl0KEDZgIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWqit7l3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rRzY7/WWXd0NQuWwIWH9kGuyMdF7tM8qRG1Uei+GbU=;
	b=HWqit7l3UP4KcTJ+YdHQB+HvIaFD+QhTXd56KNJIY5xIuHKhWYfRaKeq1kJrhNOsKo703k
	K1NbWqU1B1RBhouEs0C7ZPkvuRPENYyl7o+fmi5waIH3TqON/CjhJSOD6WOdOEgKOnccPS
	C3Vh8Dxbbi/PZSbog6OhTc/XfwCyCMY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-OOvNasZ9OQC_feJAlGdyfQ-1; Tue, 10 Dec 2024 12:54:26 -0500
X-MC-Unique: OOvNasZ9OQC_feJAlGdyfQ-1
X-Mimecast-MFC-AGG-ID: OOvNasZ9OQC_feJAlGdyfQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434fe2b605eso12522555e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853265; x=1734458065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rRzY7/WWXd0NQuWwIWH9kGuyMdF7tM8qRG1Uei+GbU=;
        b=EmRFPkqfF8oNtlEXuuvt11EPRU3C6JwCnH8gWwBU8f1UOZ27YQ3h3gaOtGP/TIgacN
         8gb9UGiy4D6rHNrkUhKkp+TGOtm3l2I+P42lC0QETe2MSNUPD0XDfkcHAYnUHry9HsX6
         yrG4yqiB5C7PGfVX0Q2DqHKGxsbtIswm7Rdxl2db6gOiDcwl2HeDaBoxHvMAwEHqH8YI
         OFnsOLtS22M9LfQQc2EZ+QfLkknaeH2U1z8VrLjuuIXpinkaDW0yazUBVpJWrzFF6M6a
         SZbrfCrLuUPUOEN2JWxfM6L+dkvUaS//LbNigs8I1001VSAcjd0/bpwTIbTmYxWKRUX8
         QrQw==
X-Forwarded-Encrypted: i=1; AJvYcCUYiMiBcBCqbw+y9cLzt11yobe6bVWbnsjpoLs5QP8lD97RbcrMbJZch6NvK6+w7AxmPnsZr/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoMid1YBjdz84j0KM6jBxoHPhjge+72SI4pjH6d89NWTVIAfCN
	95xx9XTl7jmr7EtuvmhmSmNBHgseFu3NB0W79MYCOpRGRlP0B1vbw67cmNpDHydGlkbFqUDNYGK
	RYzrStoh6FTDdjzaCX4wjaKTEMPMSBRWCva21L+z+IcfyT+ZAwnDmGg==
X-Gm-Gg: ASbGnctoxbmC7xktr8JfG3UzXFVQPyJN/ylDQxfTglVibpiwsmLwoh7Uh2yAiEWBX8I
	c20FCpM8b93CwhJOOS3Bo42qBXbUfCfB/2wy9+2V2ph8fFGLArvtp+oo/aqTyVQmvyyT2JkzWDR
	FC01JOk7AvTj+U1XTdik/RDyaJbr5J5YY/mh1pcpbYYJ9t+xDQjAKEVjbLOElFbbFu+ox28Hzhe
	HW2toZoI2qOErUhs/faflBcWAJ+AcJ4zULTNbwa6MGWK4qBH3tUuftyYSlYlJOGVKp6FE68TP5B
	Gk6OfMplx2LD00zJWDUBkkcldEW/5g==
X-Received: by 2002:a05:600c:3d8f:b0:434:f131:1e6d with SMTP id 5b1f17b1804b1-434fff41b82mr59305255e9.10.1733853264785;
        Tue, 10 Dec 2024 09:54:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPWoOUzyZKPwP8dqnFSdgd5moePBZMHqB64BaKkDl1ZXBJyZATfPmpsXV2IUepOobQ2Kj0XA==
X-Received: by 2002:a05:600c:3d8f:b0:434:f131:1e6d with SMTP id 5b1f17b1804b1-434fff41b82mr59304895e9.10.1733853264190;
        Tue, 10 Dec 2024 09:54:24 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf42b2sm16120454f8f.12.2024.12.10.09.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:54:23 -0800 (PST)
Date: Tue, 10 Dec 2024 18:54:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 5/8] vhost: Add kthread support in function
 vhost_worker_queue()
Message-ID: <e2wooukn372tdfx374ffs54cotb3y3cy3jn7gn34u4ztnnrxw5@eio7rllodou2>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241210164456.925060-6-lulu@redhat.com>

On Wed, Dec 11, 2024 at 12:41:44AM +0800, Cindy Lu wrote:
>The function vhost_worker_queue() uses a function pointer in
>vhost_worker, which is initialized based on the inherit_owner
>value.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 0175bbf4d8b3..d1aec41bcd56 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -237,13 +237,16 @@ EXPORT_SYMBOL_GPL(vhost_poll_stop);
> static void vhost_worker_queue(struct vhost_worker *worker,
> 			       struct vhost_work *work)
> {
>+	if (!worker)
>+		return;
>+

In which scenario can `worker` be NULL?

I would like to better understand why it couldn't happen before and now 
it can.

Thanks,
Stefano

> 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
> 		/* We can only add the work to the list after we're
> 		 * sure it was not in the list.
> 		 * test_and_set_bit() implies a memory barrier.
> 		 */
> 		llist_add(&work->node, &worker->work_list);
>-		vhost_task_wake(worker->vtsk);
>+		worker->task_wakeup(worker);
> 	}
> }
>
>-- 
>2.45.0
>


