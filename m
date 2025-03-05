Return-Path: <netdev+bounces-172095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F90A5032C
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42DC1645E8
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FBD24EF93;
	Wed,  5 Mar 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BZMDGDG2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5924C68D
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187308; cv=none; b=NqaUF69qBe1INfKVD0AXpHuVn5RcmP1qnfCXoVfvROpBtfitq4zXxKuQWduNf/L60CAK+IRUiY1fKt0cVngASDe+bf25/LiGJf/nO+JpBryAQy1imYk/yd8hHgVFlgfRKmFRKAkBroRyxzp0IVIAggPX8h3Tgq64sXX6vxAUFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187308; c=relaxed/simple;
	bh=qkk7BM6Tlh3hTIoRZk5iaAXN3AkN+GK8WjOtyMbuJ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVHmBidpb/l5VXu8YyZMC+/PdyUsIftcDcXmGA5wi49pR7owmp8zOVeDm8gwDeSpMLQpP4my6S5gPr6MQrFDzDhlGQf6d0oyJQl5Zkpa5UwMJr/yFK5v98lkPBwYKjU6kh4hREst8Dq1/peoekDKm4UVt7XnhZW+SXuyxxATn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BZMDGDG2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bcbdf79cdso14014735e9.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 07:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741187304; x=1741792104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdvXoLdUnuAJXkhm7GFBvnQ72ne3nL0Mv6leNbRadPA=;
        b=BZMDGDG22SgwNokwc78rztg4mN2Gh+yS6eUqWzvqIaqpoa6AqlcPIzgjELrehP8jjt
         A8u8ywQpCjN57FvixqII1W1/jEEb0+44mesGKtcB/vND5ENgyqFJrE3iHUU/P3ySXi2i
         o60pqFMOuUQufOGsdJHNvP0lVBbdDhjmMhWqWLxahBodefdv1YKmAuNQEV3fAbHf5UeE
         DyEOzenLPXMamb8yxhL8XS1UrK35TX1HwN038vkKN+9ZoTTWE0hTFhlgf65iymEDsqsR
         fJGbOFAEfIJ4TiKy39tKqE1XYgcWJI7XnVSeprfNo/AorFjYmMzYRxhRVgQkS/+9PG7r
         /dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741187304; x=1741792104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdvXoLdUnuAJXkhm7GFBvnQ72ne3nL0Mv6leNbRadPA=;
        b=eoh3efIZMwbF+oLsfy7sM45C04/tQaAwskHeFMPoaIN/RA4rHy8Mep66Dhd8RA67v5
         E7OtT2nwEpYyjImRbjcFGqsGY9KPGTtlrfWIptxL5IehMI7upKkLubcrz67oERFwOAiy
         5dpKCce0iNMh9iNBFv3dpgCkZSqYgXK8HQ0iCnYi8fX8K9t0laFCEz0UF14JSxd6J55n
         KBslE2XXBsxeOLIc0y6wxHjNACOA4eDT2bBLRBZTgbxf/0qUN2t2zeM/xed7P0UWzZ8g
         GSKe8lfIh+GYhSA0PVZ7LqFKz5VmxjpolirEuTjEzsWp9b93Fa5UdSdN9b3L7F+/bZ9F
         wghA==
X-Forwarded-Encrypted: i=1; AJvYcCXmnO12e/NGaSMKpmdlMSd6yzuieTOJTEQ133wZ5x/A71CaWefEor+qJYkfcfNPqINHoc1AhNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7W9AtvH/9KXdEWe5UZ39FOCnTq6mA5saKaO8BJAWQ/EE/uY2
	JQIt42DiX42jEHe+viCuL43C/ikMcyA8Ea+ps0fJY9SqgC3/hXJk7xARTQQdbgw=
X-Gm-Gg: ASbGnctfZqpyE23OGAXcz1bYg4gXI3TRWboufs3Z0gpkonlJH0CRYh1tWj4ybDvyPhf
	D/Fnyy+McNmz/xDSOuv1CH0+HevVysgBMRB8qjRsTE/PrMnRMyOxwUWOIkySeyNbV/NjUZLXmPZ
	Ji+tYkCzN3pJngSyWRXg8lKnxTbfq9+B9V6tEMthfwaaCLg0iopS0nglJiIGG+lJmEmr1nbePcF
	T/EkZotli5bzKjv2VsaoFGvshByn+e53NFk6npHuNr05DwA+1EVdnG1FZut5K4eyytn1jduK+ha
	QDyPkdjwO4Twf3b54n5SDLaxbQYFhbmtNdYMEcYGnNyyd3QzzyyPacptGDqCXPEGL8hHF3SC
X-Google-Smtp-Source: AGHT+IHHqngOXkEUDbnzih53IIYvud+CjZpBukJjI4zseJsAAFNb4EbCmZckikl17w1FCYOPaN0FHw==
X-Received: by 2002:a05:600c:4750:b0:43b:c390:b77f with SMTP id 5b1f17b1804b1-43bd29d557amr21862305e9.26.1741187303674;
        Wed, 05 Mar 2025 07:08:23 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4292eeasm19788315e9.16.2025.03.05.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:08:23 -0800 (PST)
Date: Wed, 5 Mar 2025 16:08:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	Aron Silverton <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, 
	David Ahern <dsahern@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305133254.GV133783@nvidia.com>

Wed, Mar 05, 2025 at 02:32:54PM +0100, jgg@nvidia.com wrote:
>On Tue, Mar 04, 2025 at 04:42:03PM -0800, Jakub Kicinski wrote:
>> On Tue, 4 Mar 2025 10:00:36 -0400 Jason Gunthorpe wrote:
>> > I never agreed to that formulation. I suggested that perhaps runtime
>> > configurations where netdev is the only driver using the HW could be
>> > disabled (ie a netdev exclusion, not a rdma inclusion).
>> 
>> I thought you were arguing that me opposing the addition was
>> "maintainer overreach". As in me telling other parts of the kernel
>> what is and isn't allowed. Do I not get a say what gets merged under
>> drivers/net/ now?
>
>The PCI core drivers are a shared resource jointly maintained by all
>the subsytems that use them. They are maintained by their respective
>maintainers. Saeed/etc in this case.
>
>It would be inappropriate for your preferences to supersede Saeed's
>when he is a maintainer of the mlx5_core driver and fwctl. Please try
>and get Saeed on board with your plan.
>
>If the placement under drivers/net makes this confusing then we can
>certainly change the directory names.

According to how mlx5 driver is structured, and the rest of the advanced
drivers in the same area are becoming as well, it would make sense to me
to have mlx5 core in separate core directory, maintained directly by driver
maintainer:
drivers/core/mlx5/
then each of the protocol auxiliary device lands in appropriate
subsystem directory.
It's not always simple to find clear cut though. Like for example
devlink and representors code related to eswitch orchestration.

The benefit would be that lots of core-related non-netdev patch-trafic
would go directly, which would ease the netdev maintainership burden and
would make things more flexible. This per-driver-serialization for
patchset processing bottleneck would become much more bareable.

