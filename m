Return-Path: <netdev+bounces-172106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE77A503F9
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AED1886FF5
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6938A2505C4;
	Wed,  5 Mar 2025 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Ooxxxohv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4124C668
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190226; cv=none; b=gO4iCne5PYhQwlj2pWXQYoDYPG4rG/DwYglZkkevGmge1AaCq9z7B2fVwTsA0tfsR/8OGa0q/wPPW3X/EtZl00TdPk/kB7q+CDhdMJRLlD65LoauoYh4MygADbqs9QmaG5lbSLI/F1ds6yE4CVToR6LBC71Um7fWD6kmotQfYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190226; c=relaxed/simple;
	bh=bRxUtaUk0u2voWoajB4eggtyrghl5vl1a8lOJlOU1hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMOJ/cLnS7Afc7tyLeVcyqA3chLdB1JgnO+FMNv5wICqS2+oE7yUBE6yKJ4lU6/+wZ/GqvUUznIiUlWgxxaW1a+DSrP6VfQQS5/j1Ol+wTgQ5BPtWYvY0hOC5rSsrXg0VkwwLWTxzv6XkCSaUDhdetzini54w8YQAhYv3Q4xn24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Ooxxxohv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bc48ff815so7054985e9.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 07:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741190222; x=1741795022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3T/3u+j7/Jo1rfv0A0TN7eDrmWcMEwwVKj9zMBqnPs=;
        b=OoxxxohvKHBDnuiV+kQaQejRiNhbvBkJgWO1j8K25gSVH1hu9pJeZTQzVDbOUCZD+E
         ZDwH8v8Xg/OK4uHCp4fGdKb8eUS5bFis55Q4MtsIr8dugKpkYmTv8NfaGioVAnh3zPNJ
         W9kpwOQA7dyTC08J1pDtrLfAk5xU5rsOHRl3MUedfuflys5ebj7MQ28C5o9ExXc/sgFp
         ivUkwq36G3G/O4zOrTXC+A6ScM3Ed9O0iD745NghrsPLgWU4+MZ6GmfZr2/IbbtpN282
         TbA7avN6O3JSTkY+olAy+lmyIGdlNyTsdBK8/+J+OxY+CqYpti3AZ6Vnn1abZcUswWxH
         Voug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190222; x=1741795022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3T/3u+j7/Jo1rfv0A0TN7eDrmWcMEwwVKj9zMBqnPs=;
        b=UZ22RnFfi1TDRv8coVViNqjCX0E+oheOIZ5b0qaLG8s3SFPSE77fjaeaECuZhBwrX9
         pMewM+3o/F0Gez8yvvDjYWJcpGvvq6OZ8o9WyelN5da65SyzKSgTROhl5+YzgkxV3IgK
         2m12T4DqaTeLA3VRze7hbxyzBy5thoQdhc+oaOYlVB4/7STIchbEbOUFedrs3WHrdw1Q
         3nVTsj140vC5ZHnEBnsbxgtinAkX6chZCCNT7wp/0Wuw4wvfRUOPy+m+eAa5QUETSUK1
         Aevb9epUyswSDGYNwYedou74jf3kAZ8FfJl0oNlnFpcqYJg8qA/KTRjlpHVTz4fsE3Rt
         b7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWBE2I4Sn5fsWZfOndHPb298JhaGf9uXc2mBLNfLY4XgznMSGlwYL8IPHtBA0Dqseha+Kq0Aww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNNxlsyOIPLvhOoOKuF2yBXOwFqhLVKMusljpm20+70vKhrqBi
	ZDebUT/ixdfOvsJfsdb2fDMCiEdqvsJHzX1RKuN5Vt1U+yZesAKjqvzexWT0QwM=
X-Gm-Gg: ASbGncubpRHzOqIPoAab2Qpm1+u0hbmSNRFyNa/EpN4gVYth+df0zvRpcKwgDN1sxiB
	cdTSv5LkNquykNna1d1U8dU0ey6Lejgz/WFYXOVSPnhENlEdX+/gp8JbxNWFxoc+t1Ib2jmX6Fh
	QI70medcLZboebYKAbGN389sItdfwQdmFp5GNZTmL7iA0uxCYr48HWrCgLMJ8ddzkv+RVXX3VG+
	mzHmIoFqzt6LtoTzhT+z2aVa+G5S5bm8E6nJqiW0fFrSIl9noa/ET341xu+f9asGzq1lKpC8s2F
	Plk98xp6PlUhJVge6JDXPW8ok+8/bM5YgeQXeDXru+kmfoe37Q6DPd8rYoJa+bWGiK3xjWOr
X-Google-Smtp-Source: AGHT+IFtw0Hk8fmzbrtRVg0aHkG3EgoEbyDVivLKnSWP+zHu0SX579EPeM8VPDZakD+B9BVYslk0EQ==
X-Received: by 2002:a05:600c:3b92:b0:43b:c7f0:6173 with SMTP id 5b1f17b1804b1-43bd209da3dmr30654755e9.4.1741190222103;
        Wed, 05 Mar 2025 07:57:02 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c5cd9sm21217265e9.20.2025.03.05.07.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:57:01 -0800 (PST)
Date: Wed, 5 Mar 2025 16:56:58 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	Aron Silverton <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, 
	David Ahern <dsahern@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <3tp5h65qxje47nwg5u3dw6kp4ak735uj6g7ryk3vsf3qvkqosq@q3e6fx5skgyw>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <20250305152246.GM1955273@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305152246.GM1955273@unreal>

Wed, Mar 05, 2025 at 04:22:46PM +0100, leon@kernel.org wrote:
>On Wed, Mar 05, 2025 at 04:08:19PM +0100, Jiri Pirko wrote:
>> Wed, Mar 05, 2025 at 02:32:54PM +0100, jgg@nvidia.com wrote:
>> >On Tue, Mar 04, 2025 at 04:42:03PM -0800, Jakub Kicinski wrote:
>> >> On Tue, 4 Mar 2025 10:00:36 -0400 Jason Gunthorpe wrote:
>> >> > I never agreed to that formulation. I suggested that perhaps runtime
>> >> > configurations where netdev is the only driver using the HW could be
>> >> > disabled (ie a netdev exclusion, not a rdma inclusion).
>> >> 
>> >> I thought you were arguing that me opposing the addition was
>> >> "maintainer overreach". As in me telling other parts of the kernel
>> >> what is and isn't allowed. Do I not get a say what gets merged under
>> >> drivers/net/ now?
>> >
>> >The PCI core drivers are a shared resource jointly maintained by all
>> >the subsytems that use them. They are maintained by their respective
>> >maintainers. Saeed/etc in this case.
>> >
>> >It would be inappropriate for your preferences to supersede Saeed's
>> >when he is a maintainer of the mlx5_core driver and fwctl. Please try
>> >and get Saeed on board with your plan.
>> >
>> >If the placement under drivers/net makes this confusing then we can
>> >certainly change the directory names.
>> 
>> According to how mlx5 driver is structured, and the rest of the advanced
>> drivers in the same area are becoming as well, it would make sense to me
>> to have mlx5 core in separate core directory, maintained directly by driver
>> maintainer:
>> drivers/core/mlx5/
>> then each of the protocol auxiliary device lands in appropriate
>> subsystem directory.
>
>In my vision, the write access to that drivers/core/ will be given to all
>relevant subsystem maintainers, so it will operate like shared branch, but
>foe everyone.
>
>It means that series for netdev that changes mlx5_core and netdev code
>will be sent to netdev and applied by netdev maintainers. In similar
>way, series which targets RDMA will be handled by RDMA crew.
>
>It will allow us to make sure that every piece of code in shared
>repository is actually used.

Makes perfect sense to me.

