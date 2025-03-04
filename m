Return-Path: <netdev+bounces-171757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBD2A4E7A5
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49AC7A40C9
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1B325FA36;
	Tue,  4 Mar 2025 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T16fqhd1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D29281522
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106573; cv=none; b=b4pHLoWCdOt+5jL7Qjz6RJoSztuqDkE3NXE6MnX7KClYO9ja2UqVLYJ98o1Ogi2a6BNoqEZ4VUVSedTG4vdUsGkdOUx0h/aTDoeAj5xmPGxGh9+hVlGSGM8wx+hyW5pkcDuM05YINL1XVELPYniixqEc54Bu47xPloGA9zPTutg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106573; c=relaxed/simple;
	bh=5UVxCkDZ8kO0WdIGN4l3YmIwJxfc54njR/FGmzU/SBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8YKIJ5yc7UprPp4PrVKmkl7S5koakWRVEP9mv7nCoMh7iJBEodGiC3F414bb2ETEtd4mfUg4w5/h5NhoybrPdVVqjs/4/ogItOLtHJLC0iFATcHDr3J2YUQlTi3JgHMHf0CVxDYJwvLsgNyPbNNtyOSO4aqlb+D0rI1teelH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T16fqhd1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741106571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=irwE7UbkTJ9sd9IPUMpAepIHZ3K24G0lYRCeT1RBeVE=;
	b=T16fqhd1n14J/dqUr4OhsSUE6NrVQ69F942xDg1OM4Suw2auxjnufylmq5idwgxPL22+/Z
	W/oJaeE7uMSHzQZ/jec6vyrOyXFiVSUJC5iDBh6nIJ5s5kBNVtJ/bcgY1H1VmSKdC60n87
	2FuR2xMilpIW6vYcLosA1bEruogZceM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-LMlOLCbmM4aj_pyoVseOeg-1; Tue, 04 Mar 2025 11:42:49 -0500
X-MC-Unique: LMlOLCbmM4aj_pyoVseOeg-1
X-Mimecast-MFC-AGG-ID: LMlOLCbmM4aj_pyoVseOeg_1741106569
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e6bb677312so106628496d6.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 08:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106569; x=1741711369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irwE7UbkTJ9sd9IPUMpAepIHZ3K24G0lYRCeT1RBeVE=;
        b=TMtdNwYDYISnLUGaQJD9DbYWWbRW4TZhWaPMR6r3v6skWxSE797f0xLlAK2BNifwLx
         7mPg4KoQqAwq9ZpOi8XQ7wt34fPMOuOEv0bbeVTvMqfQAsNG15IUdyGFhFMS864D7pm1
         ax4cWGorPKwbualT8xtYzFXaua4Cld6b4WBCQaNUzIyNJiJ79uv5wot6vVxzqzjpk69K
         o/z0FS0j48zahNp/D/g1nGCJAZamiEYTBkUDMreLWsyXtS5Wfy0LHgOLiGvag2RvGIQW
         wRyB+D7k7btgINTHYKS9YZJjB00UPHzJrjRSeCgujOX3QEG8WfPJq0U0eU+jAFx+6fuu
         fRHw==
X-Forwarded-Encrypted: i=1; AJvYcCWzoli3mniCifR84vSuAdlFidV2eAVgs3gzCofEzB7EmorIoVYZghXsuBZf+UQf+WIMsKgQh1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSLR4+QjzS8wT6n7jasrX6bPIyT9ZyHLVinyCHzv8r9Y0Kwyxr
	iMk6i5tu4Gj13KJGNNQBovJJzY/Zv5KNuA4Cj6c52p6e1u0QbxpUlSUtAL6HO+jCSRkW9jSL4HE
	Tz9134um9G+gab+mSZNkC9zBxnqIbHiRvfFigg0ZjUTrphBiKzS/qFQ==
X-Gm-Gg: ASbGncvUJkNQlOKQgYKQi2FbmYAPve2seRihuCJ2jkDktvi9Wkp0ZvhP2oNg7Dj01Ok
	So2CTARddX+JDdn91bd/O1QcF2z4lejuCkRQssX+rWNKFmePhiOLco/RpXXwOVCJmkOVPPEiyJq
	s+thUIwxQeywU3Y9W+/w7Imu6eaEAV9UdM9law/9cf/o6FbTesYX6vaHzieGyiLOEFwMnW3KxL+
	mq3zVRbl5YcaMaevq1LPlU8feJAqL8m9pwlf7d3mDLJcIZwz8IAESzvXEN87MVmgIbT/O9fUGfe
	1Klbx9/V
X-Received: by 2002:a05:6214:20aa:b0:6e8:916b:8c49 with SMTP id 6a1803df08f44-6e8a0d70112mr295550796d6.31.1741106569247;
        Tue, 04 Mar 2025 08:42:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX5ng0/gzjf07ZxLghdOiyfeivk23lbOTEm0x8eqXcyer5cXGbRjEi1aQ8MlIa0yV155gJFQ==
X-Received: by 2002:a05:6214:20aa:b0:6e8:916b:8c49 with SMTP id 6a1803df08f44-6e8a0d70112mr295550436d6.31.1741106568919;
        Tue, 04 Mar 2025 08:42:48 -0800 (PST)
Received: from fedora-x1 ([142.126.89.169])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4750a4cdc78sm554471cf.15.2025.03.04.08.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:42:48 -0800 (PST)
Date: Tue, 4 Mar 2025 11:42:37 -0500
From: Kamal Heib <kheib@redhat.com>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: Re: [PATCH net-next 02/14] devlink: Add 'total_vfs' generic device
 param
Message-ID: <Z8ctfY0RQ6IFm-G5@fedora-x1>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-3-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228021227.871993-3-saeed@kernel.org>

On Thu, Feb 27, 2025 at 06:12:15PM -0800, Saeed Mahameed wrote:
> From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> 
> NICs are typically configured with total_vfs=0, forcing users to rely
> on external tools to enable SR-IOV (a widely used and essential feature).
> 
> Add total_vfs parameter to devlink for SR-IOV max VF configurability.
> Enables standard kernel tools to manage SR-IOV, addressing the need for
> flexible VF configuration.
> 
> Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Tested-by: Kamal Heib <kheib@redhat.com>
> ---
>  Documentation/networking/devlink/devlink-params.rst | 3 +++
>  include/net/devlink.h                               | 4 ++++
>  net/devlink/param.c                                 | 5 +++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
> index 4e01dc32bc08..f266da05ab0d 100644
> --- a/Documentation/networking/devlink/devlink-params.rst
> +++ b/Documentation/networking/devlink/devlink-params.rst
> @@ -137,3 +137,6 @@ own name.
>     * - ``event_eq_size``
>       - u32
>       - Control the size of asynchronous control events EQ.
> +   * - ``total_vfs``
> +     - u32
> +     - The total number of Virtual Functions (VFs) supported by the PF.
> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index b8783126c1ed..eed1e4507d17 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -520,6 +520,7 @@ enum devlink_param_generic_id {
>  	DEVLINK_PARAM_GENERIC_ID_ENABLE_IWARP,
>  	DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE,
>  	DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
> +	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
>  
>  	/* add new param generic ids above here*/
>  	__DEVLINK_PARAM_GENERIC_ID_MAX,
> @@ -578,6 +579,9 @@ enum devlink_param_generic_id {
>  #define DEVLINK_PARAM_GENERIC_EVENT_EQ_SIZE_NAME "event_eq_size"
>  #define DEVLINK_PARAM_GENERIC_EVENT_EQ_SIZE_TYPE DEVLINK_PARAM_TYPE_U32
>  
> +#define DEVLINK_PARAM_GENERIC_TOTAL_VFS_NAME "total_vfs"
> +#define DEVLINK_PARAM_GENERIC_TOTAL_VFS_TYPE DEVLINK_PARAM_TYPE_U32
> +
>  #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
>  {									\
>  	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
> diff --git a/net/devlink/param.c b/net/devlink/param.c
> index e19d978dffa6..d163afbadab9 100644
> --- a/net/devlink/param.c
> +++ b/net/devlink/param.c
> @@ -92,6 +92,11 @@ static const struct devlink_param devlink_param_generic[] = {
>  		.name = DEVLINK_PARAM_GENERIC_EVENT_EQ_SIZE_NAME,
>  		.type = DEVLINK_PARAM_GENERIC_EVENT_EQ_SIZE_TYPE,
>  	},
> +	{
> +		.id = DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
> +		.name = DEVLINK_PARAM_GENERIC_TOTAL_VFS_NAME,
> +		.type = DEVLINK_PARAM_GENERIC_TOTAL_VFS_TYPE,
> +	},
>  };
>  
>  static int devlink_param_generic_verify(const struct devlink_param *param)
> -- 
> 2.48.1
> 
> 


