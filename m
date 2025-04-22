Return-Path: <netdev+bounces-184674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731EDA96D1B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C71400E55
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F0227BF74;
	Tue, 22 Apr 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNNU1xZD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC23B20D51C
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329024; cv=none; b=HtmI+wVT02zPb89hOb1xpWxa3j6B4ev9DjJACbGHKoeZIUrFvqHLOkIpZFghhKY42UXaaIHCsjPZMpRWaGrQREozzYBWy7qjDencazf+kqlXldOKOOktowTg74kAy/PY+O+fDsv4ZacreDg4H4nI5iNx0MtjQNhxYXwar6RPt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329024; c=relaxed/simple;
	bh=qqYnk5XrxGLzZLkCL3wTaRUPbFdR2fhEIlck66k8r7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/OljnMPF2ftrpzTRwibkmXOVgY+YvwFAyVBPo2kOsKbpGrB4eIzZTnDpn8MJczzVwWkFvb0SQP3uXbK/hftSrtvX8ySf+MRhdVeGtZFdSbmRjwrAFpTxSvi/M8DIr+FkzcxpfxAdseyfBnm1ZLVYlV6Py2SdcAXt6LMETMEJx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNNU1xZD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745329021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zUewcCAfKjSAtX3UJYdMN8CFjSRLSUT1k8cvjFFQcBY=;
	b=MNNU1xZDj9xEhkPwsp3xihqLyqjW2U8hSI35EP0OFvfZovoRt7663HTSfGPZWqWdshKEff
	pdwwJ2OHx2HINwaGJzn15kiKcu1Y/RaluBnSOvAAA2/VTyqgzRfiUsKYXj1PxVjAHv42+O
	t84aS8rDa2rZzyuAM5+YnlKeKP6MZUk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-t_UQM6dQM564JcYBUd6rvw-1; Tue, 22 Apr 2025 09:36:52 -0400
X-MC-Unique: t_UQM6dQM564JcYBUd6rvw-1
X-Mimecast-MFC-AGG-ID: t_UQM6dQM564JcYBUd6rvw_1745329012
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5f63ee41315so2324532a12.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 06:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329012; x=1745933812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUewcCAfKjSAtX3UJYdMN8CFjSRLSUT1k8cvjFFQcBY=;
        b=h/4oTunjAx1lOtS6mjjI/h9PX5DN63/+sM3g9/Aa/rxMPyju+FN/9KTdMdDeGRcRzm
         vMexWpAj1qmr1MR5VPsHUg260uylnfIGawfQ+MkPSbD4nDUe/Th7kon+UQzGzNaLa+Hw
         7dqnWxGOPxnYzl58x19shOrqqaeBuZ1d8D0Gq/TI6ZV8zz2xMGh0N3FiuaVL3NcRmXym
         gxfvPS94jM1HiR9fphSHsnpnSg1U0AqMH2yXXf6P0tSwlQaPYakyWxfRT2nkYKWobqjt
         ONimSFmXI+/lBAPMcVTZSeJDZC9q+t4BbZLY1PNuckapfURvdlfV46BSM4urPQnvdh1Q
         wntw==
X-Forwarded-Encrypted: i=1; AJvYcCXp/556YDb7E1WwInsiC+fFcbUleF9Bef6qwxZWR4/0cx6ead1vshVsXBXRk6aScGnDNRNxFVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygJJQUxsiltKxibAhFTREcMpUMLAYVelc5CRxO7ZJ0z9B4TkQ7
	prSotQsH/TMdyuTp9O9O54JKoULie26WpD83dXCDCaV3BKR9LpyPAoriR/AP1ncgNA6sqOfAWqe
	cLjTP8f+bGIYt0f1oEPw+kpvIn+pDv6yuM77c+joGm3hFufbLKYN9bw==
X-Gm-Gg: ASbGnctOKJmugZn6ecxdNWc8OF6KcEyZ0OHGM+MEZ+b90N09vyUQv3BXIPYvDTyYRfm
	S2TjxH1pxn5aD3B07cdPvqO4szOSEhUgzk+WDiyhDguOuofys5kv287GZm4Wx8QDMbCsdnEnxwP
	gQuz8T6q8dcQqTddQePJzbvk2b2tt9ffGwVhQC+p5z970hUlG+uJndGUBbThZYNopgt/8k7ya/5
	8iBgxJ0QYLmB8rg31wJxFEuD5jRMml7TepRlsXK1HjzqiouAyEPbhRJkwW3FMCW+x4O6cEBv0gK
	eqoodFOshVKMjF1O
X-Received: by 2002:a05:6402:274f:b0:5f4:c499:5508 with SMTP id 4fb4d7f45d1cf-5f628535a3amr11578546a12.9.1745329011721;
        Tue, 22 Apr 2025 06:36:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLWfcUfsxB2IzKkKV/CizBO05VIu+DXGm+L8+NKFCuGMypvZbpTLcet5RlzVieCOKekjSNxQ==
X-Received: by 2002:a05:6402:274f:b0:5f4:c499:5508 with SMTP id 4fb4d7f45d1cf-5f628535a3amr11578522a12.9.1745329011142;
        Tue, 22 Apr 2025 06:36:51 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625a4aed3sm5887654a12.80.2025.04.22.06.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:36:50 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:36:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 1/4] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
Message-ID: <feelu5lubmz3syms5nkjnzdzoygwnbnldms3hzbhkenpu3s4k6@xwzjct2xo6hq>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250421024457.112163-2-lulu@redhat.com>

On Mon, Apr 21, 2025 at 10:44:07AM +0800, Cindy Lu wrote:
>The vhost now uses vhost_task and workers as a child of the owner thread.
>While this aligns with containerization principles, it confuses some
>legacy userspace applications, therefore, we are reintroducing kthread
>API support.
>
>Introduce a new parameter to enable users to choose between kthread and
>task mode.
>
>By default, this parameter is set to true, so the default behavior
>remains unchanged by this patch.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 1 +
> drivers/vhost/vhost.h | 9 +++++++++
> 2 files changed, 10 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 63612faeab72..250dc43f1786 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -552,6 +552,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> 	dev->byte_weight = byte_weight;
> 	dev->use_worker = use_worker;
> 	dev->msg_handler = msg_handler;
>+	dev->inherit_owner = true;
> 	init_waitqueue_head(&dev->wait);
> 	INIT_LIST_HEAD(&dev->read_list);
> 	INIT_LIST_HEAD(&dev->pending_list);
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index bb75a292d50c..19bb94922a0e 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -176,6 +176,15 @@ struct vhost_dev {
> 	int byte_weight;
> 	struct xarray worker_xa;
> 	bool use_worker;
>+	/*
>+	 * If inherit_owner is true we use vhost_tasks to create
>+	 * the worker so all settings/limits like cgroups, NPROC,
>+	 * scheduler, etc are inherited from the owner. If false,
>+	 * we use kthreads and only attach to the same cgroups
>+	 * as the owner for compat with older kernels.
>+	 * here we use true as default value
>+	 */
>+	bool inherit_owner;
> 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> 			   struct vhost_iotlb_msg *msg);
> };
>-- 
>2.45.0
>


