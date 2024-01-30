Return-Path: <netdev+bounces-67179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC37D842437
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 12:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B23B280C1F
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41ED67A08;
	Tue, 30 Jan 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VC4t6p99"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C406A679E5
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615821; cv=none; b=mK1mUZn8ysqnBFf5n5oxY9PVUAM6LdjrUIzBFQL8BdMuZ7zGU9S8WMB4BE+vjUsekq7sZ09IZbk3LZBLW6tgP4eZ0k6jZtY0+A9oxa/9+qhlez9iUT7KHHNeCAdc5bb7nVLqZ4DHPMg72HcpFnH/B1HUHBYNRF3nxun55O5LYbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615821; c=relaxed/simple;
	bh=kxu6tW2jTYqp5WE2lddKdlY6JOuLuq5QUr15fqWfl70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERP+ODR1fNS/M9Nt04iI1rE+Gp5bLWCxEdCE74qzkL2UBJEs0CblRDEZXpUFnEJt/1F3HsVu71DOjmtSJn/5RkBvC2hvNQWXZZkchBsTtI+NvIV74O9BGORVK1WwUGtU+KZECCjE0RBoXRl+XgjnySFCYOPpY1JWCeizQmdFXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VC4t6p99; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5100cb238bcso6922197e87.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 03:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706615817; x=1707220617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2f5R8+qQhYrWwi4tMPJyVPek4Y4qGxpleU/kY0/KlOs=;
        b=VC4t6p99bGoJpgV6jRIEiNeo33xDUcRigb83DNvjos1IU6fStpwGm1rDqwGUbsKd8v
         A+tMqGp+9tOIYi4/84dBlIbyeI/aXt8J3ZRrur1hNPcQI+WknEqPhmPDgzEBLglINdZW
         IRSiWe1XpdBcP0d8LRSU2RHOGlr/1wadC7ZNhv1YccpyPk5HAn50jtNI/9fH0TGdUbI7
         f90SFGiGSiiz6eiiK/faF2WZ5KlWlLw9l/Gp5aguakMW8qH1I2uBhapSg2/GT0IYHF/O
         b9C+N3NNit/MySyTcte2rmh4pq92LA8fHaKCDneqf+epAu0P46ypeRGSjEbzXbcPqopB
         WCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706615817; x=1707220617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f5R8+qQhYrWwi4tMPJyVPek4Y4qGxpleU/kY0/KlOs=;
        b=eIZCcS3xR9kLHbXfwJGJLwZkYgO4oE5jGI0I6PfeYq8H9Xbof458yw5630qIqLJDfo
         Gy7CkajjZ0H7hXOvE69D88+Cv7/x2b8e1jg67d4c/5BCUEnokGxbxFGIF4LMCJp0Y6gc
         3A0g2JZ90BhfiEsPUw8mb2/ydOTFN8c0FOlJUJlUxq9GwoiswRTWTEgwwV4R+ljxf3hE
         TdB8GzimSuF53rWwsKqQgsX0Tnk3BMDHuFzQ8aJFD3BubsuUu8s+ons9pThNfTDXOZN4
         buSc+onUWvZDIW+72ebGfLUVKGCJfqQxuf3q9Wae81n4GuJrSSOnDxfDuEy+6TIc/zfR
         KxdQ==
X-Gm-Message-State: AOJu0YyeQF/hE15IZ6bUeY+k5WblDMzi4RodsbOSJGopi+gvgOSzVxCs
	d76B8V3Yj2UfhcHOqNrgFow9oc6Ym9EYVNYTpo+XhD3sbrJcu345HKOyy/64u34=
X-Google-Smtp-Source: AGHT+IGT1ZVs/XTIkUnf5LKiWUWtImeVKnwvdQKgeiIhVpJ19qzmwNqjpl3rH4RhFwsFAY3gDfjIig==
X-Received: by 2002:ac2:4a65:0:b0:50f:1ac5:758c with SMTP id q5-20020ac24a65000000b0050f1ac5758cmr5317458lfp.17.1706615817516;
        Tue, 30 Jan 2024 03:56:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWD64XnRnHMGcqjeCYDWUa2bp2iYNculuA6wV6p5m8jh7BIVRIBQ4fYxDvTfHDt8H1HxiYSxCS0XKX5xI0/F5UCcNpoYaVhbCvTG7s/1wT41yqjLInRGAlHnQkInpVMKAh4mtscZdW7QtsyN9sFqGNwB9UeyIfUkXyd8Cp9uec62e/9x2VDo5a9cHXYyc6cvPnc0XjvJB4uvlbAv7e+/rZYMyTGBYeStYUP6Q813h6CLOvZwQRII/2enhM45rsypzEcQejZglZYXHv03mOOhWYUFpymYWngmhuTB8kuhMtHBsjlKsB4OWRrhfqB3i5RMwTcKV0ITQpN3rzBBynoHjdeYQLR4YklV/ZNATiwKi2r5XkIT/IA7dXrSCsu26w0tf1OfQ==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b0040f02b92e95sm1683484wmb.22.2024.01.30.03.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:56:57 -0800 (PST)
Date: Tue, 30 Jan 2024 12:56:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com,
	arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	rrameshbabu@nvidia.com
Subject: Re: [patch net-next 0/3] dpll: expose lock status error value to user
Message-ID: <ZbjkBhAQLf4UZcGb@nanopsycho>
References: <20240129145916.244193-1-jiri@resnulli.us>
 <b213297b-53f6-4c66-8c0b-5b3fbafdbccd@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b213297b-53f6-4c66-8c0b-5b3fbafdbccd@linux.dev>

Tue, Jan 30, 2024 at 11:28:56AM CET, vadim.fedorenko@linux.dev wrote:
>On 29/01/2024 14:59, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Allow to expose lock status errort value over new DPLL generic netlink
>> attribute. Extend the lock_status_get() op by new argument to get the
>> value from the driver. Implement this new argument fill-up
>> in mlx5 driver.
>
>The list of errors shows that the focus is on SyncE devices here. What
>do you think about extending it to PPS devices too? Like loss of input
>frequency, or high phase offset?

Sure, lets add it if that suits you. There is certainly room for
extensions of values here :)

>
>But the series overall looks good,
>
>Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>
>
>> Jiri Pirko (3):
>>    dpll: extend uapi by lock status error attribute
>>    dpll: extend lock_status_get() op by status error and expose to user
>>    net/mlx5: DPLL, Implement lock status error value
>> 
>>   Documentation/netlink/specs/dpll.yaml         | 39 +++++++++++++++++++
>>   drivers/dpll/dpll_netlink.c                   |  9 ++++-
>>   drivers/net/ethernet/intel/ice/ice_dpll.c     |  1 +
>>   .../net/ethernet/mellanox/mlx5/core/dpll.c    | 32 +++++++++++++--
>>   drivers/ptp/ptp_ocp.c                         |  9 +++--
>>   include/linux/dpll.h                          |  1 +
>>   include/linux/mlx5/mlx5_ifc.h                 |  8 ++++
>>   include/uapi/linux/dpll.h                     | 30 ++++++++++++++
>>   8 files changed, 120 insertions(+), 9 deletions(-)
>> 
>

