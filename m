Return-Path: <netdev+bounces-125353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3020696CD6A
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 05:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E3E1F270DE
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB6148FE5;
	Thu,  5 Sep 2024 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OuBN4fxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4AA1442E8
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507421; cv=none; b=Qm7auM2FjM3d+RKHqDV83Mjvelk/NI2mB6IKwxWHsMuXcvL3tsjQtm7H9THhgf8YQyVLrnED9LVBnNV/hmnqPDY5YoDFfHsyGCV95RrkFKrMlwJ03iP000G15tOxP2g0ml7Rd7OMb0BIJx4vkUdFZc2tD4nDLOS3t0Kub7/mItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507421; c=relaxed/simple;
	bh=eiDwd18L4MBS4Bj7MKCAM06FoS+0UCoF0CD+B+adO/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYRjl+SAIx1d4zFQaZqFU1bqaBDbhQ+UPARo95IRgJVT1nHssEJNe8fZ6AZ0TV6QDipzqdB8mrwWN2qv5mXh+j8EoTWBjo1ba1YYW7TogExIv+AicbkTc7IqcmJ72yBti/tSUMQRsY02x06Py5qolRu7q+ViFK1HeQtyjQg5Iyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OuBN4fxR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso254885a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 20:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1725507419; x=1726112219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jbfc98t5OtGLuNINYKX6Z52cv1pgsj90rLeg4M2pXfA=;
        b=OuBN4fxRqtRHrTyXiUQxiVd3gC82OGT74anauPbGeoDaxXJbCb5yTpZ/87FIDbWY1F
         ST4+KHzq6RH0Z+G80JH5Mc28d4XqHOf+5Xllbj77xQtrRwPsg0E0Z9sObC1QKWGKchXI
         aVJ4NT4pa95ddMP1ddVS+1Avs9sAdLH/SmsdyOXyoGOyxqLbvkpdkGAoPeE/sufcQCD2
         qP/s3vZVJgQqxL77YtO3Cl3TA6bbpabxOru3IFadxsxVjY7jYunCvAeROlSTxaitw9cq
         H+o3jx/OKtdF2DD+gvSuQQpvRy/wtfZ8OJdYN3H5mfpGQQEdMqntb8cmi4hNc/+WFDsr
         YiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725507419; x=1726112219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbfc98t5OtGLuNINYKX6Z52cv1pgsj90rLeg4M2pXfA=;
        b=tURlpEVp+8bxzQoLz5u1Q7TpRCxXQqNBYmeRbx6/trHJdIaVRWgdsc5JUC6e81rRGN
         2R3G9ws2QC3L5REUVlHqzP2l2avR+iqIYy8xO/RVjP+ljv/jt2J/ioHW/Goj0lFQwIUp
         aZUEyVHIFML7gWyjG43wUjgVqviJG8RZqdFHZBZSX8SYsteOwhEcz8WLXRJ22xOc1BhQ
         EP/n8NSMLYJyB93irutXHw1jnsG5AgguHD4gwu4X+m7QHYHLsZ9sjp4ury2/qnO1WNJ6
         a5CXPuANB0tJJFJKc1sWy1Ua1BEX4wMZ066mN8eCJ+n3ddX6a8eBRmIzdbj/+fCI2J64
         ihQg==
X-Forwarded-Encrypted: i=1; AJvYcCWFyq6+fBpmVXUokmjL14M1ha7XH3B3QfhqKz7BMZR4XJwMx3LmNnlwq6NO3oQU/K8SvAhEmfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrjzpm41Fy2cj9tbs8O35qhRY+wi9oHY5eMJ1ePLjMvqbglfYs
	buddzAdxLeyXe4iyovixMuv+lwsGT7wSbNLXzUgesSD0KHJQUfUDjM5gbnJU/RSBCvQjFodhgCl
	+o3A=
X-Google-Smtp-Source: AGHT+IGYhG/19XTuh1osoL6kTMpIu9yVGa1obLYLUMIJszPnRbOcE6BZN29HNsTzTrX+UGxoXr8zbQ==
X-Received: by 2002:a05:6a20:d043:b0:1c4:bf4a:6c0e with SMTP id adf61e73a8af0-1cece5192bemr18171590637.26.1725507419250;
        Wed, 04 Sep 2024 20:36:59 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d8d38ffff9sm7733089a91.39.2024.09.04.20.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:36:58 -0700 (PDT)
Date: Wed, 4 Sep 2024 20:36:57 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	yzhong@purestorage.com, Tariq Toukan <tariqt@nvidia.com>,
	Shay Drori <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] net/mlx5: Added cond_resched() to crdump
 collection
Message-ID: <ZtknWffvKCy6JjXS@ceto>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
 <20240829213856.77619-2-mkhalfella@purestorage.com>
 <cbec42b2-6b9f-4957-8f71-46b42df1b35c@intel.com>
 <ZtII7_XLo2i1aZcj@ceto>
 <519a5d22-9e0c-43eb-9710-9ccd6c78bfe3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519a5d22-9e0c-43eb-9710-9ccd6c78bfe3@intel.com>

On 2024-09-03 14:14:58 +0200, Alexander Lobakin wrote:
> From: Mohamed Khalfella <mkhalfella@purestorage.com>
> Date: Fri, 30 Aug 2024 11:01:19 -0700
> 
> > On 2024-08-30 15:07:45 +0200, Alexander Lobakin wrote:
> >> From: Mohamed Khalfella <mkhalfella@purestorage.com>
> >> Date: Thu, 29 Aug 2024 15:38:56 -0600
> >>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> >>> index 6b774e0c2766..bc6c38a68702 100644
> >>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> >>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> >>> @@ -269,6 +269,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
> >>>  {
> >>>  	unsigned int next_read_addr = 0;
> >>>  	unsigned int read_addr = 0;
> >>> +	unsigned int count = 0;
> >>>  
> >>>  	while (read_addr < length) {
> >>>  		if (mlx5_vsc_gw_read_fast(dev, read_addr, &next_read_addr,
> >>> @@ -276,6 +277,9 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
> >>>  			return read_addr;
> >>>  
> >>>  		read_addr = next_read_addr;
> >>> +		/* Yield the cpu every 128 register read */
> >>> +		if ((++count & 0x7f) == 0)
> >>> +			cond_resched();
> >>
> >> Why & 0x7f, could it be written more clearly?
> >>
> >> 		if (++count == 128) {
> >> 			cond_resched();
> >> 			count = 0;
> >> 		}
> >>
> >> Also, I'd make this open-coded value a #define somewhere at the
> >> beginning of the file with a comment with a short explanation.
> 
> This is still valid.

Done. See <1>.

> 
> > 
> > What you are suggesting should work also. I copied the style from
> > mlx5_vsc_wait_on_flag() to keep the code consistent. The comment above
> > the line should make it clear.
> 
> I just don't see a reason to make the code less readable.

<1> Now I am looking at mlx5_vsc_wait_on_flag() again, I realized the 
code does not want to reset retries to 0 because it needs to check when
it reaches VSC_MAX_RETRIES. This is not the case here. I will update the
code as suggested.

> 
> > 
> >>
> >> BTW, why 128? Not 64, not 256 etc? You just picked it, I don't see any
> >> explanation in the commitmsg or here in the code why exactly 128. Have
> >> you tried different values?
> > 
> > This mostly subjective. For the numbers I saw in the lab, this will
> > release the cpu after ~4.51ms. If crdump takes ~5s, the code should
> > release the cpu after ~18.0ms. These numbers look reasonable to me.
> 
> So just mention in the commit message that you tried different values
> and 128 gave you the best results.

I will update the commit message in v3.

