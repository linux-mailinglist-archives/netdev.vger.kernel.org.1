Return-Path: <netdev+bounces-230880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA24BF0E5B
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72873A8A46
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DF629B778;
	Mon, 20 Oct 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2dWDEkm8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1294024A051
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960627; cv=none; b=uMfso4RAvx9diMvpJg74FviO8w9PwI3Ql5pqe18f7OSRZvblKubjWBO0qup1IizbuKUtAABL2sIgvUPqbaetv96V4vXXncZUsBS5upXwpgezFfes3ugcfNyYgKKzofZUl9AlcCQbzEGHCRj6FflZz6kz1C+kS7emlPNBPPyFMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960627; c=relaxed/simple;
	bh=pMMT+NFQAw8YQlojwE+3/hqOc35pLc6fawHj7FcAuIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNK0bLpBkpBcUG3RixkDWQEUpGQwK2nsAbJhkWUYWf81PgqC6VLSfxhOerwgvXAYbJuLqZE5DrKdVlo+N+MYyooEdUQoNktSdQKFgCR/DizbQS9iBEbk5+1mmh4J6FAnoLuE6G+LSKR/L8YjOkBbSZ1obUZFOlswGZkzMkx2gfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2dWDEkm8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so27618135e9.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760960623; x=1761565423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HRJhF2QeFtBMt/jNmGmAn1LuRSW2NUXyYDeijTIeUhY=;
        b=2dWDEkm8IC0Uv9CYyR/enmFZQNR3vR8FOf5G/G7ZiQAI5FRuBy93PMB1IkXZzwThif
         h9nrju0B5dHD+XgClUyJVG30AHu4ooUacc2DNoWYuWsHDj0i1wDYN2R1sdiDXW/egQBJ
         D0zjcO20WRXJpnlxGoZkIOm/xxNmD1QW7isrRf0yjRXyNJXwbeZJSwW6ijOFIakCJQEI
         IQ9BhnyB7lXbgzOnC/DHgkO4aCkB9gJ4QKwfc+xe4x6N1p9jDH1zMb6tnIK41VVUiNi1
         odDi1Gqx0NnPz+mYUkU7Qpu16zgapQDO5sq0Mt9B99Eb42YCXIQzH8i2EnWfu5Wba/p/
         vl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760960623; x=1761565423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRJhF2QeFtBMt/jNmGmAn1LuRSW2NUXyYDeijTIeUhY=;
        b=DJKAOYOwcRfFjWvCXnmrbHWXC+Jg0+IWoM1UqUUhC04tfpqa2oHvvbLGYqgbGUGvF5
         pw2ULP0uoCBrk+JSNituHYaH2+uUpM99txaqIt4Hv0O7pKvAbkRLs5NRzz6VkFW0YuqH
         3dyiHyynt+M1jwZejHH6mSlQdG5iyltEwOkXD83fqpwXmsYGYdDI9PbkloKxrKpoKJ35
         h8649fsSopB0yAOvs2Eh+LtOWs8Ebp9PSGXd+USWDyIXHsFEX7egtvM54B5GKpBZsasV
         gepBqQcWa22qWYzKgAN623+2F/G3v6mpMQ9bRb23xqyUkbxPUAjvJmko/KNaGHmpATY/
         YbsA==
X-Forwarded-Encrypted: i=1; AJvYcCUGb/oeiTdjrnumpJjuMefZ62nfXVs8sE++jRKA1M4q7kInKsVR7K6dDdtfabE0fUUx4ey61UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQUUmdd3rq/4cAElJnBWU6FrMSsszoMPcUzE3uYj7gnh+V5J7e
	v2pcEjXQHruD1hJKWHLoyEjs0DF/MwvB7YKOltCFAAb8l7HgVsIrWSyz/HhQzPFu+Ag=
X-Gm-Gg: ASbGncsw16j4ezj2VrDmTnMXiAyYVZmcngxgT8+RxT6CEABGAfUS+NdkMP30OcUjdzs
	0XEUO41voXUEePCY/IjpcmQfqDroLTlZOP+dJL3xT1+/c2i6T0oWqco9CvfRMRNLTQtd4eoLAw0
	dZz/7xhMGjrX8O7I53cFbPZRVPvYSdjc+BQ0LXqlJqktUpDZeB1XgUmpsy0PuSP6FslLDQepAmP
	D7Zf8Ie2DyZbOOtX2VIbGQP3JOEWGFH3/N5BD5u9TQPLRvK7/zPIioPKjEnYdU7OIcrYpib/vFx
	C7pVDgtD14AuRN2hmvQj/z5S3xJK7lMH1z/Amnt/AYsKh8UT2o/cizILWWYAdZvAfXJld48oKY7
	gvQfYjUtIOqtXNv5sqF6npQoqWLh2yFTSRzhy9i6W03ETj75tyRuPcGhVHMYoo+siclHV/sGmvx
	QBU2Qc3RdEiAZqp5G871HyVyR3Ud1LWuDML5Hhzg==
X-Google-Smtp-Source: AGHT+IEWUkoTyuAFHTFL4+mmxZYEymTFLv71RaNHyUom7XTb7VfxCYy2ipxhLHoJ4h4mvgJD3oPU1A==
X-Received: by 2002:a05:600c:811b:b0:46e:2109:f435 with SMTP id 5b1f17b1804b1-4711787dc36mr85037205e9.11.1760960622778;
        Mon, 20 Oct 2025 04:43:42 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d38309sm143024145e9.9.2025.10.20.04.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:43:42 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:43:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] devlink: region: correct port region lookup to
 use port_ops
Message-ID: <hfc4vawmkduyqmsbuuebrjrbnzkwuqq6ylpm3molh6zfnvgwv4@jyc52nrejlef>
References: <20251019161731.1553423-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019161731.1553423-1-alok.a.tiwari@oracle.com>

Sun, Oct 19, 2025 at 06:17:27PM +0200, alok.a.tiwari@oracle.com wrote:
>The function devlink_port_region_get_by_name() incorrectly uses
>region->ops->name to compare the region name. as it is not any critical
>imapce as ops and port_pos define as union for devlink_region but as per

"impact"?
"port_ops"?

>code logica it should refer port_ops here.
>
>no functional impact as ops and port_ops are part of same union.
>
>Update it to use region->port_ops->name to properly reference
>the name of the devlink port region.
>
>Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


>---
> net/devlink/region.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/devlink/region.c b/net/devlink/region.c
>index 63fb297f6d67..d6e5805cf3a0 100644
>--- a/net/devlink/region.c
>+++ b/net/devlink/region.c
>@@ -50,7 +50,7 @@ devlink_port_region_get_by_name(struct devlink_port *port,
> 	struct devlink_region *region;
> 
> 	list_for_each_entry(region, &port->region_list, list)
>-		if (!strcmp(region->ops->name, region_name))
>+		if (!strcmp(region->port_ops->name, region_name))
> 			return region;
> 
> 	return NULL;
>-- 
>2.50.1
>

