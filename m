Return-Path: <netdev+bounces-75730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDC186AFF2
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80551F24894
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23B2149E01;
	Wed, 28 Feb 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xHRF6XNQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB0145341
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125777; cv=none; b=QrV8g8hFyPBI1c7zZlaC+AFV51rzndr1IDnyOBMpeUpr+4XWvJ2sP+ZGazY8DPl8EiEozvcTqwwbc+vb5TD6mnii7isRwx3s3fklcodpeE86iRUJUy4qF2xRtSNvhDOtgfvJTIqb1MMuC6Hw8oqQYNd6ildSYh3ff3j+nyv58jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125777; c=relaxed/simple;
	bh=2Ft3bJiWKb5wT6iuIPDRn0E5KDZP5tR5xY4D5h4a9ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7tp4juVyRew3l+gGOV4Lx00D4L2gAkdPYg2mnsv6+z4oObvZcvjo+Sb8QdpQEIyU8oJietoEoK98Mg40FWFymYKu4Uv6C9DvSFGk6ZkJYDcULIEc/c5ztLUoxA4uRsQW2Vs2K0FdA9e04tjrrae6RTRvEDmzGZazTHM9PtF9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xHRF6XNQ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso84118671fa.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709125774; x=1709730574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ft3bJiWKb5wT6iuIPDRn0E5KDZP5tR5xY4D5h4a9ZE=;
        b=xHRF6XNQAxY19zdHQdOUBCXhFqvg9nw0+LncpnZg/0WCV1tFKM2DxOf4CiqN0P15Aw
         bF0OlGn6NEd/eq0BmVJqfnCNKsMS6V2uTTYGp/mPPzK4lTlol24rUygt9M5lsn/OqZ1f
         hbRRklnzvqTyxX9oQGpjEY0/EfSee5cS8UHfRy9+tvpjeqgrMLzTDtVMe7ywPA7axsVG
         fivU9MKwltu8QhEUujK5P7fdWLynqYJAIE5Ovn9OSiTBVZrjVRRUGk9ey1990QeJmkTx
         gkKa+Zsk6KzmZMDLgmSFBAfHqOrPEfFHRlf9z6JOHuRoqymNhujXFiucULye1pVzTqY3
         RmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125774; x=1709730574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ft3bJiWKb5wT6iuIPDRn0E5KDZP5tR5xY4D5h4a9ZE=;
        b=YbuEoKP4UKq7/5rBBC2Fmfg0TJEsDct9QxTh69vak8I2LYzX41IWUg3QN16aJGrPkk
         Dlz8y+jVt8yOLnY6xUYrK56A8WS80Um8HceaktQhb/v8jSPpotuQPTUhDxrm+IijzFQW
         UicqDMDjz/zcLvOEVUi3QD1ad5LTC7d1mpG4idfYjqZTUki26yfqDEGQbo318MPscGoi
         /LjVCZPzyI07QOA/3KSJe0KctZLvk5UWpDJEtHU2pI/tPqucaWATGkHI8M7H3YRtbj8w
         ndpMZB+lLBvGEDFLiKvM/yeQ13ZePVHMtYfKHDsEzCWMV/2LHel6rBC+qIpqO2NMQ3lD
         Kfsw==
X-Forwarded-Encrypted: i=1; AJvYcCXpj3SJV6ymrA0KQZ8Zb/0DRIqEH9mimWAEdZ79KKiz3iELpK0cYwbJheBWaanF7uM7QOceval71VCA9/smjJkd26L/tMpN
X-Gm-Message-State: AOJu0Ywx5c5cU4R3PQD3MZLNY/HMS4wX+JSM72XyRDp4Bj99D/YaYPbq
	HLSN+2n7U/AW6yti6kRWEJR2v8KuUE4BuUzTQ+il9ovRqBAWnvsDTd+D5NSv9AU=
X-Google-Smtp-Source: AGHT+IEXjIeaqkm6aDYE/p8eQaQhxLsM4l93SBBtG4gumRuwRAuP9F46ubbWmhhXEYGUD/OSV2vyhw==
X-Received: by 2002:a2e:860d:0:b0:2d2:9b00:2289 with SMTP id a13-20020a2e860d000000b002d29b002289mr3237613lji.29.1709125774294;
        Wed, 28 Feb 2024 05:09:34 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b00412b0ef22basm2091407wmq.10.2024.02.28.05.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:09:33 -0800 (PST)
Date: Wed, 28 Feb 2024 14:09:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next] Correct couple of spelling mistakes
Message-ID: <Zd8wirexgBacmsv1@nanopsycho>
References: <20240228115707.420200-1-pvkumar5749404@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228115707.420200-1-pvkumar5749404@gmail.com>

You sent this already here:
https://lore.kernel.org/all/20240228082416.416882-1-pvkumar5749404@gmail.com/

I don't understand why you send this again. Could you slow down a bit
please?

