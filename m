Return-Path: <netdev+bounces-123533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D61D9653B6
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 01:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4A7284172
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8108618FC70;
	Thu, 29 Aug 2024 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YFRPe8F1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDBF18E379
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 23:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724975945; cv=none; b=ARmg5LgW1Q+iwC+QlSwINakr9lQ274Km2fZjBkhXXdcuLrub90JHZd1PyKQ9U6XfRTJXL2Q4ByEO3nLdhRukzUp8BxD5OwwqFp+nCxco8qRghkkY6aChyBghu0yDeqMW8w09U2F9RJo63hesYdZVTSPNshjdCxAYIMNkKvHZORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724975945; c=relaxed/simple;
	bh=XclOCsfb32kYv2Q1QdH56wPRiRVAkbIsdjvLha2JOAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Espr4vlZrZZZhZeiQqXMQm96KHV5rja8iKqTOe5mVpcB+p3kU9gbEfhXvlOxW6izupDJnrfLWUQ+0SdMHdczHQhr2l57Xz/7+jwWYVAW/OCA42YGbSmaW9ssFChp4Vf8/BMiCAe61MzMWlcdctZDyeiOn3fovJoML+DKEPpUh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YFRPe8F1; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27020fca39aso807790fac.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 16:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1724975942; x=1725580742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sVDarT+YBpMc0tM/iiIBCg69BPAnD6PYDjpxTLZstk=;
        b=YFRPe8F1KsvTjvh5IG7zty+92AJD4bNv1tg6j7KbSE1lyYq8e7qJG5ah0IBc2aPZ86
         JG27bRa0JaBkbDCDPCcbsm2Y/Rubzd7FnwIT98GSMf/nU5cmee63/toTlMYbIeTefsgc
         tsD1STlt1EyqbH4NW0kc7sTYSyvBvrt2QQWOP5htIi0OUCTmtN1p6mDX2IaY6Z69flpz
         SEEKSqbYWcYC4B1BTMiYJtahPagkD/yiI5mGiQRVP+qxY0DeJs2m+caKtvged07OtnTT
         bDDhIa32wvRW+MDlJRjPrxe5j5GPxtd9L1Z4goPB+Jpb9/XknqJHQmGI9Loy2WjthvRr
         3mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724975942; x=1725580742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sVDarT+YBpMc0tM/iiIBCg69BPAnD6PYDjpxTLZstk=;
        b=mkIz8Z86ehzjlm3OP9ewebRqunyW+JqOyzYu1XY4VuB+iBpUVf2ikXkB69R1C9KWNW
         tNtMs1ppAjoV6yiikWk0HvNQoMF8jDqSrKEvIhBRc6OkVunDCEctzayYyvilU15lmBZh
         ioJN8/KiYnAHdrTuYBbur32IwKkx6ylhImFSs15sczKiwGVlh8WDwr2v2/WLH6wBrGgz
         gkm45fmcYBBwqRbMujvG+m4+leyAgYx5elKi7rPeXaJloAJYeLNnnvQpKb8x9OKN3rkn
         3e7KyG5Zd0DGrBNhyOaMaeXSi2URNRnCTg93E8sPEbHrh758FO65L17hk3jqplbT/b8Y
         Y+pw==
X-Forwarded-Encrypted: i=1; AJvYcCULw/mEBnBs+sN0MFfITWkKB5khATl/TAuq50YCBqUAlPepHU4er5aiz59G5o0agjzLRYlCrtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4sbXZ40NU0YNoHPc7Hpu8EHZWvosQcjyhV36Y0Idar9Gzt7eQ
	+sXoKP1p1xIXPPveJMA59y/dWQ2dRZJRnrfHvNJDMzsGUxjZxJYDLiVrYVmptvA=
X-Google-Smtp-Source: AGHT+IHW1kv2lb98eFYM9ktQm2FMitO5LGgZvZ7Jpad1iX5A9OthzVlVte4R3M6av2jwRquUk5XaPg==
X-Received: by 2002:a05:6870:d209:b0:260:eb3a:1b2 with SMTP id 586e51a60fabf-27790076f0bmr5086253fac.7.1724975942034;
        Thu, 29 Aug 2024 16:59:02 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e55a5b93sm1688579b3a.76.2024.08.29.16.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 16:59:01 -0700 (PDT)
Date: Thu, 29 Aug 2024 16:58:59 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: yzhong@purestorage.com, Shay Drori <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] net/mlx5: Added cond_resched() to crdump
 collection
Message-ID: <ZtELQ3MjZeFqguxE@apollo.purestorage.com>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829213856.77619-1-mkhalfella@purestorage.com>

On 2024-08-29 15:38:55 -0600, Mohamed Khalfella wrote:
> Changes in v2:
> - Removed cond_resched() in mlx5_vsc_wait_on_flag(). The idea is that
>   usleep_range() should be enough.
> - Updated cond_resched() in mlx5_vsc_gw_read_block_fast every 128
>   iterations.
> 
> v1: https://lore.kernel.org/all/20240819214259.38259-1-mkhalfella@purestorage.com/
> 
> Mohamed Khalfella (1):
>   net/mlx5: Added cond_resched() to crdump collection
> 
>  drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> -- 
> 2.45.2
> 

Some how I missed to add reviewers were on v1 of this patch.

