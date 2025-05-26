Return-Path: <netdev+bounces-193411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B960FAC3D58
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7695F3B8DE7
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360861A4F0A;
	Mon, 26 May 2025 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TfYnXwRb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4572566
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253201; cv=none; b=SkOTk4HlBUcdfiwDVQo3J4GUj6F6DgF1yDpUwO4AbfbCb7BA/eeZM8WVUQYYrJXWFelZ72VvGeVJSZYdbbHyWP6OSH4x5lDtxxxtrRVilwi03DAH6ZVeGQgdM+VXNuGoSA/h+piSEsslyGTVPSZM5zYo10FSZWH8MwVeuajXZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253201; c=relaxed/simple;
	bh=e+DfFhgOBSJtuw2zo2ARXXf8M66qPnicImFZ8qM8/WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvWgko6BA4edush1HZdLiz7vCmNzaqlO5PO6xO+MXFDTvD+zZY7A0MYPO2yxDIQbgEHxCzYtao1NYRHrt7ixN44ihnhRx+ph/6vo6q3ri2+i9VzbfJOMJhZP54H3tthD1OIeyWMZSRMwC8XDoFT7Aq0nZSY65Umzs1/FXjXbArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TfYnXwRb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso12185105e9.1
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1748253198; x=1748857998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvtjkWTFpxX0l5YExlhc5815tcEgJnDVqTj5UPyY0DU=;
        b=TfYnXwRbCjJRJWOiET0G54ldzbfnJ+VLyBlhAOtGMFSfYlRjchPkQh25KnueRhEtSp
         zsgrLxtNS/OBTmGiWXfBBhV0tNL01gI4prP06NvWbVF/O8fLGeN9H5LZaYGfnD80zB72
         PWrZUOm8Ji+JxQ7NsvDPuY5rn7GiNIPkc8OMHO5TY3UKJSNWl7AlyA0JFokfbeQ0hu9Q
         1KzwXyM3Mmb6gR+IRn40pGF9XyzFuzvL9Nux5tnF+5nYrUGfZ6woVvgQehzmQEvUMN68
         uN7vNueqiq46fg8yvXCbsCf/3GWwuyXXaLALi2L6cNldjmnRlxseL8CslJgy5KRMYE1A
         pt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253198; x=1748857998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvtjkWTFpxX0l5YExlhc5815tcEgJnDVqTj5UPyY0DU=;
        b=Gs9FqwbRtsBw7NISgvKST5lczd7cRI54fQNoCnFK/4aJyBstFyUiWAQ0vNsj8JQyoH
         9Djxi3VeumMiUovZEYyCrdEKkruuxYc8Qdr5zQh8xGYdyO/nnTqmVPSWZ66VHo8HUe39
         SNOpt5ZyvfCOB+i+gc1slcNfmX5PEUErKLXtJBWpHQQY+5Zml/jg6I5vL7tqaWVaUW1n
         EmwkMi4O5x991Od+W1ADP9m2mFOJZqRiVayl8mko5Gc0zq7MYSg4caT3MvZO3A4Jr1Gn
         G8dDOfdoICwIXBwPaupSnGLaqcjAiYCOfxFj1ha+W88gQfIhKgATrqYB91w38vrR+hnt
         z4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUamj5o9PEyTJJl8uTMPwngvCCDaB6qmdmjlNzSNqDQY+3g5TZOnLlnJOy1renZoLLn1uO9Gd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkG1U9OwSFJP0VUin4zcFZ12s4FgyVRAoKmJztFlzltj9RWC0E
	YVZEbkaHMPVd8XAaUHQZ7rz8+9GEGYUAMqVjw0FOlH0LIXtqc91QmUpPFWrECAfc9hI=
X-Gm-Gg: ASbGncsc0OuaQFPIYjl9Hcz/DgCj92OAHLXxOSSiOPItPq0MC7rH2oziR/F3V6qqEVw
	NXxMzT57D/LbzeREGai8Ep0+T0E0yrsWzZ0dFuh1j2bwhFLUV9YSh4SPb22DUXLNzLxIkUGPa7R
	EqrI6tNRU6qZkQRRVagtx2rxv/kYm9r0D1kWPsLDGLnJkl/oWFxnQFbHeNR3SNTSQeji0YFmB5z
	E2ZdZuU6uspPb4ZhUYe4GxCFvG0Ci36jQjE5HTs/rvf/zjO02s+xZ/ODM+718Yn2XvzibD3+dmu
	Da0Qep+FMxAf3b/n9rp1z7yEOoSV0073zGb+eZENYqVVflUiCAAm7hIU4WnYY/3+KbTtG0If9bS
	B7Q8oIhp38M0eBw==
X-Google-Smtp-Source: AGHT+IGnGKWV9KxYKawiemLctSpzuHD3Soaf9JzsXUDImngcbBtPIcnV5dWSUtTd1jWAfxc854Aqag==
X-Received: by 2002:a05:600c:64ca:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-44c935dcaecmr68966865e9.12.1748253197720;
        Mon, 26 May 2025 02:53:17 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d25b8sm238460235e9.17.2025.05.26.02.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:53:17 -0700 (PDT)
Date: Mon, 26 May 2025 11:53:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>, 
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, 
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, 
	"Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, 
	"Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, 
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>, 
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, 
	"Bernstein, Amit" <amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, 
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, 
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v11 net-next 0/8] PHC support in ENA driver
Message-ID: <jdkiblbwiut4x7t7gtpiatdbiueehvhuqdhn5caoj2ijiil2yr@6xof3oyhruxa>
References: <20250526060919.214-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526060919.214-1-darinzon@amazon.com>

Mon, May 26, 2025 at 08:09:10AM +0200, darinzon@amazon.com wrote:
>Changes in v11
>- Change PHC enablement devlink parameter to be generic instead of device specific
>
>Changes in v10 (https://lore.kernel.org/netdev/20250522134839.1336-1-darinzon@amazon.com/):
>- Remove error checks for debugfs calls
>
>Changes in v9 (https://lore.kernel.org/netdev/20250521114254.369-1-darinzon@amazon.com/):
>- Use devlink instead of sysfs for PHC enablement
>- Use debugfs instead of sysfs for PHC stats
>- Add PHC error flags and break down phc_err into two errors
>- Various style changes
>
>Changes in v8 (https://lore.kernel.org/netdev/20250304190504.3743-1-darinzon@amazon.com/):
>- Create a sysfs entry for each PHC stat
>
>Changes in v7 (https://lore.kernel.org/netdev/20250218183948.757-1-darinzon@amazon.com/):
>- Move PHC stats to sysfs
>- Add information about PHC enablement
>- Remove unrelated style changes
>
>Changes in v6 (https://lore.kernel.org/netdev/20250206141538.549-1-darinzon@amazon.com/):
>- Remove PHC error bound
>
>Changes in v5 (https://lore.kernel.org/netdev/20250122102040.752-1-darinzon@amazon.com/):
>- Add PHC error bound
>- Add PHC enablement and error bound retrieval through sysfs
>
>Changes in v4 (https://lore.kernel.org/netdev/20241114095930.200-1-darinzon@amazon.com/):
>- Minor documentation change (resolution instead of accuracy)
>
>Changes in v3 (https://lore.kernel.org/netdev/20241103113140.275-1-darinzon@amazon.com/):
>- Resolve a compilation error
>
>Changes in v2 (https://lore.kernel.org/netdev/20241031085245.18146-1-darinzon@amazon.com/):
>- CCd PTP maintainer
>- Fixed style issues
>- Fixed documentation warning
>
>v1 (https://lore.kernel.org/netdev/20241021052011.591-1-darinzon@amazon.com/)
>
>This patchset adds the support for PHC (PTP Hardware Clock)
>in the ENA driver. The documentation part of the patchset
>includes additional information, including statistics,
>utilization and invocation examples through the testptp
>utility.
>
>David Arinzon (8):
>  net: ena: Add PHC support in the ENA driver
>  net: ena: PHC silent reset
>  net: ena: Add device reload capability through devlink
>  devlink: Add new "enable_phc" generic device param
>  net: ena: Control PHC enable through devlink
>  net: ena: Add debugfs support to the ENA driver
>  net: ena: View PHC stats using debugfs
>  net: ena: Add PHC documentation

Could you please add very simple devlink_port instance of flavour
PHYSICAL and link it with netdev? Having devlink instance without the
port related to the netdev looks a bit odd.

Thanks!

