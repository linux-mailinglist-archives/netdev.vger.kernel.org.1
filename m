Return-Path: <netdev+bounces-203298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DBBAF137E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F261C24963
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BEC25D1FE;
	Wed,  2 Jul 2025 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqQCzHEv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2125BEFE
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455042; cv=none; b=HPfb3bX/JvKjwyYhmwlEAMJRRtUFW5FWt0DE2YVu0FXET++zhfPlJtoL5ywOi43BO1WquA9/uexiKVXHUFCE9ozXmrlAIPdvacwhzDAlMhqLW9r8ZBJjPho7mu+xWNE8+jTPvuVWX6AUgQb0WTMgrFk1ZyXWCRn1mElxRLW/TE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455042; c=relaxed/simple;
	bh=8N56+TGylsQY7gFnKtTRVknM2MRo5gOpmc2AwA02aio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEVgInLwJUcO9uP1y0V6iqDztz/EWYGNWY88JxrrtAy3ieTBfRzkZDqumTAj+svlFFKrrOQKVpdAHKloKQuJmpcBHco39wGXq169FaZp3dUPFFc2FSrWilsf8lmpXycoZD63f6SqpMSVs3vbj5WmIgNBei7Xo4hYcjB6xJpfRGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqQCzHEv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751455039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wldKfbxnDfMUjnGQMZxO+EJVdKQ4uPilVamWozU75kA=;
	b=cqQCzHEvG+iM0sARLX+TdDMredoLHkOemHdMXfh3pUH2QCDc1Jop6MUVsP8SrejOfCRc9l
	jtWBMMBsimcQ9kwZhAFzlCHwKZ7gWvMFYbGbjWD8Gk7P6SMowOK2cVqu87A2AzX54jVC9S
	i9oF8QADAPhdGRBOzPSW+U8j3XEKKPg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-JIOwGCcMOlOsQ-phqp34eg-1; Wed, 02 Jul 2025 07:17:17 -0400
X-MC-Unique: JIOwGCcMOlOsQ-phqp34eg-1
X-Mimecast-MFC-AGG-ID: JIOwGCcMOlOsQ-phqp34eg_1751455037
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a38007c7bdso106314471cf.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 04:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455037; x=1752059837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wldKfbxnDfMUjnGQMZxO+EJVdKQ4uPilVamWozU75kA=;
        b=INjT8casFCzWOf1NGnjZMPdPiIW5ZhZj6BBwvf+wM5+4G8iJXg8iNdsDGcC/BP6KSn
         ZDxmn2K8BZrDsPp5eUfN2dpfGRhO2Y3Fmi9+T/AqeBdeEMcGkIWrNCgo+55qYSU7afCJ
         koVc2kgZ62Ficjd0aRN2028f25P3LvkdEFCrD1NU6d7ZlH+jE3/XJ3OplTLHimcBCtR7
         bke1l3uwwp+38U7yjlrmJQiU8YmuPUxw3LVCp6Uy4rjPWBtNZ5YuJ7BEPbd45cScbiSg
         90yz85ZJKiKP4l5BXU9lU7GZbEL+7Xq7LMUkIRGyetJlFh92WTzSYPff9ff3E7sa+Yv4
         nMuw==
X-Forwarded-Encrypted: i=1; AJvYcCWZPugdZDKGgcx48nWDQXPWZSN1E67yT6VKdW6MnSK5zfAwuQMq+mvcIUfRAbfxjD4sffwsfQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxduvVVALv10HCeAtWznDZPy2xQVR+zAE0S9onGlVqCEHVmKtZE
	8yYb6D05puzvLkBEwsph64bxsmx3IoW7EQyzVUYCUJMMFw27/jpW+moilwXNGuMIf2Fb5nGK5Rc
	9rqWMEOxUiovRtpnW3x/n6msQhncp7XVGn665AJZw4kHGbOA6zHK9RK12Tg==
X-Gm-Gg: ASbGncu33VAxUNQ+Man4JIkqtlFqW11UB+80VQUH9eoTh/U8QwTaK3IUNmlOkXsZRMq
	N5mmERbE/Rw3EzXOGTGXqemQ4LKbwHJ2Ln1e6/VFW++XTkmsl3BtD27SY9L49i6VNT5uerY5YvT
	Qm/FLgBXlafEtVXEi6LHFQciN/YmFCKhSIvh4fmxfcYTUWCgRuBLoeSd662Rf0ojg5WHisOOJQj
	Oakiqo/rSlgFUGJDIwxbzwcq8DQPhuUSQsGE2QxRFTLCBlKGhhevw/+NsAvLlQ7eR593ahLX7Lv
	a0yDyDacO2ZoLs8cNM0fDUZCMwwK
X-Received: by 2002:a05:622a:4892:b0:4a4:39a6:93c4 with SMTP id d75a77b69052e-4a9769152aamr42028641cf.21.1751455036630;
        Wed, 02 Jul 2025 04:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyX529Bjf/JHbkZ9z4pNDGbh4lbiaMrqb6Gqb4GFhbQWEzxXEP/dakYHu4BYJfkNuEVi7vkQ==
X-Received: by 2002:a05:622a:4892:b0:4a4:39a6:93c4 with SMTP id d75a77b69052e-4a9769152aamr42027891cf.21.1751455036019;
        Wed, 02 Jul 2025 04:17:16 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.164.126])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57d8acsm89956541cf.63.2025.07.02.04.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:17:15 -0700 (PDT)
Date: Wed, 2 Jul 2025 13:17:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] vsock/test: Add macros to identify
 transports
Message-ID: <hv4ufpmyuyzreh4n4tofco4mlbge3cqvuvfnpadek4scov3jyi@f72cscihqcsw>
References: <20250630-test_vsock-v5-0-2492e141e80b@redhat.com>
 <20250630-test_vsock-v5-1-2492e141e80b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250630-test_vsock-v5-1-2492e141e80b@redhat.com>

On Mon, Jun 30, 2025 at 06:33:03PM +0200, Luigi Leonardi wrote:
>Add three new macros: TRANSPORTS_G2H, TRANSPORTS_H2G and
>TRANSPORTS_LOCAL.
>They can be used to identify the type of the transport(s) loaded when
>using the `get_transports()` function.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/util.h | 4 ++++
> 1 file changed, 4 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 71895192cc02313bf52784e2f77aa3b0c28a0c94..fdd4649fe2d49f57c93c4aa5dfbb37b710c65918 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -33,6 +33,10 @@ static const char * const transport_ksyms[] = {
> static_assert(ARRAY_SIZE(transport_ksyms) == TRANSPORT_NUM);
> static_assert(BITS_PER_TYPE(int) >= TRANSPORT_NUM);
>
>+#define TRANSPORTS_G2H   (TRANSPORT_VIRTIO | TRANSPORT_VMCI | TRANSPORT_HYPERV)
>+#define TRANSPORTS_H2G   (TRANSPORT_VHOST | TRANSPORT_VMCI)
>+#define TRANSPORTS_LOCAL (TRANSPORT_LOOPBACK)
>+
> /* Tests can either run as the client or the server */
> enum test_mode {
> 	TEST_MODE_UNSET,
>
>-- 
>2.50.0
>


