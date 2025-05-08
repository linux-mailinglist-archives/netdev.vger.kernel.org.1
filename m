Return-Path: <netdev+bounces-189062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C5FAB02CB
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A17F7B002F
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B968286D66;
	Thu,  8 May 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pA+g1rAD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4320458A
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729092; cv=none; b=QA81zBVqDntsipJc1iZnpAMg22EmGRxRv6qHM+uSZmR794VbeuwxLz2znJ/rfAF+P7VxJHwgZZzIzWVe001OTHMzk/LcR9HAaH0eQQ8zOHPPZtkDLFD1rVNVrhODBrrd8Vl6QFRQ4Ipa1iBCpABYXjt07hq1wZqvh2u17kWHi98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729092; c=relaxed/simple;
	bh=9aAHHtYzORaC+b7x0nzKZADXZfswUgLFHg/izHYSkOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfXRahUTTbzynBpXo1xU4gQ1lVHio79PZ1Z5FWvv9PU7xwVohf5N1p4zu1m79JU2/Uluwd9LTteh8BpD7danKJtRvw2foOFeD1pijR//5wZlSATWMu5TI0FIRda1v0w7+r3nVnFk7curoCO4xtZZEhmlFL2I9X4Yro9e8Rgm7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pA+g1rAD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e033a3a07so16009235ad.0
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1746729090; x=1747333890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg04tVeUUBS5dXi06eM7vrV0jQzAk+ogiAGdK7KKQLo=;
        b=pA+g1rAD9vpQxfJtquC4e86IVpe4VgW4mom+sS4m7I0SIwwn2GoOp3zadgAnk1iT6E
         Phs/DaYO3mPfE9T9s3YhMMNcdDLQJG9/GzRVo92P6pNAt5i6eok3bRe37w24QzIBCS+Z
         wCLI1SYZB05+/MzLFMRASLLtFFeb85uNPcIG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746729090; x=1747333890;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg04tVeUUBS5dXi06eM7vrV0jQzAk+ogiAGdK7KKQLo=;
        b=f/c3edK1hhloWunAJwMEd+gFp/jKlCZ8Q4fN5hmEwKb5rQZWdymaaEWr8epg6caxD2
         GWrBBVQzd0C6Kss8ASdwUmcSY2AkR9JoXw2x9Iq8FTwbVlSKUWMXnqrCHtabOqmoZXjo
         qzNCAa6/upUOxY3D5rGEcCBuR34hfXfO5yM8cyvE8IwwLsB225qzPTeA3g1zxxK7/BMJ
         YpEkePS+oU4O0uvnebxeuUOSFygNvEK0xVT/oEWJtSPqRoaAADcnHQjyhx42GHtimw6r
         cU6473LB5S3z34o0xyRyZRjopKjxTX4XZgEBWxzn0BMjyYWUBjGOzJYrykMHy3e+//s7
         r6+w==
X-Gm-Message-State: AOJu0YxWrSKRpjjPNeN68jzNutsTSQmucpL74Rume6IrOKG7qBemfsJl
	5RapQM6JiKM+VNn6oQJAs+BPcklnRm3RHGYnhRR89nM3BSEcfrOeHGzxAk1h/CKSQs/mysNIKvU
	UnyU=
X-Gm-Gg: ASbGnctKI4LtCcVxGTpwoOn3mH1PlrYbRJYc5qQS2lnR5BGUC55oVLBYndLVfsnkR3T
	C1maYrt3TZYrL+hqCWreFMq91VikQioprwNz8asDA9IQVTqIZpxeCPIdyANcOY4BNY9Yt4J44+6
	IXbUa45EM+j59nw/Q1dKBk9yKVTZEYtBNBOL2gaQw7lTz4T1lpFhLYqHr0kL08qocv+ae84CGUa
	w7fMawde21auuFbtnZSqJwfvrisYHiPomiL//vwPXxV485zW7evqJThzCs/zdUG50nteRJfl8hr
	SEhreLL/X5Ud31fvLI/LOMvzrcXEfm+e0S8nkCbIC3QQLT4+iIBwS0hhwQL3Co46GelGDxHfzFH
	7ZebZkC8=
X-Google-Smtp-Source: AGHT+IH4KefNLXixBMhOc9uRK7GEz3GSp15CgKgObE9cY7IuFNks+EWNpWqPQxY3Ad8TaWjV7YiRlw==
X-Received: by 2002:a17:902:ebc8:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-22fc8b4f01cmr6696755ad.12.1746729089851;
        Thu, 08 May 2025 11:31:29 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc77414cbsm2712865ad.61.2025.05.08.11.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 11:31:29 -0700 (PDT)
Date: Thu, 8 May 2025 11:31:26 -0700
From: Joe Damato <jdamato@fastly.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2] tests/ncdevmem: Fix double-free of queue array
Message-ID: <aBz4fjK8bPKG3KLM@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kselftest@vger.kernel.org
References: <20250508084434.1933069-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508084434.1933069-1-cratiu@nvidia.com>

On Thu, May 08, 2025 at 11:44:34AM +0300, Cosmin Ratiu wrote:
> netdev_bind_rx takes ownership of the queue array passed as parameter
> and frees it, so a queue array buffer cannot be reused across multiple
> netdev_bind_rx calls.
> 
> This commit fixes that by always passing in a newly created queue array
> to all netdev_bind_rx calls in ncdevmem.
> 
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  .../selftests/drivers/net/hw/ncdevmem.c       | 55 ++++++++-----------
>  1 file changed, 22 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> index 2bf14ac2b8c6..9d48004ff1a1 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -431,6 +431,22 @@ static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)

> +	queues = calloc(num_queues, sizeof(*queues));

> -	queues = malloc(sizeof(*queues) * num_queues);

> +	if (!bind_rx_queue(ifindex, mem->fd,
> +			   calloc(num_queues, sizeof(struct netdev_queue_id)),

Nit: it looks like in the original we didn't care about malloc
potentially failing. Do we care about checking for that now with
this cleanup?

Otherwise:

Reviewed-by: Joe Damato <jdamato@fastly.com>

