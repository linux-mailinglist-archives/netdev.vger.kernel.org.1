Return-Path: <netdev+bounces-148422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7C49E1934
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDC1B44203
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7E71DFDA7;
	Tue,  3 Dec 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6xBdlZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9F16FF44
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218750; cv=none; b=YkH5PgfZOfghdjXJOqog3wSyXmk7CkNE7tx1wI7xMH64Ft3uPmHNhbjiCzNujadlOO1ZF8ie/dLNIeu9zP4kNCAjrTdc7nJwCrmJIlrplEdPFcjw+YMKHLENRGQ0hv2PObnhiy03rpqhu7FeQ2Y0mKeJnKM0YJyg18ZInmlfOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218750; c=relaxed/simple;
	bh=f4yo24MCyvcNw5BjdCp4RT4JHWYru/YdElzMFQMZDkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XszsBSwM+X3bL7N+ODTR/XreJIEjGBw1VRXpbToPLQz5z748GRZuQjWtcUE5/1aAufz3xRk0k8dx+/Wjkk4g4u4ASgJ48NDXKqNzArsq6RHfDKyWkCC4IGRwANyRW7MvkaYRmJmyhOiSHOojOPgQkrePOhkPZaQkqv8bmxyFOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y6xBdlZJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so48727165e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733218747; x=1733823547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kAfAbX2jpmVWuMhv4f3fZGpU5CJs4ntFjeUeVvna/QY=;
        b=y6xBdlZJDIxUvbRYDMQ3a0rvI04pw8wKHjWx+Sn+fwkgPJn9t5rClPcmRiln8vUCev
         BDTlovrblcX/vAZpPXlOi9ca72C8bCYZDILRjYPZ+OYi1XFOF5UhBnjjxo19D3iIvsyc
         k8rpKomDLIq1Tt8RqsQ9LF4lNtBfOod5E/M1yfLs+V+jdPZRHiEE7AHSSq8eL4a65RDu
         oKExQJk5pZRLpNpdp+/Jyl1T4zemAJpHCWFZ+/G9xXL9kl9Ul9vimkviYkZipVlgQVS+
         ZNN6+YSNsB/S8n8IML5GL9zWM0i0mLHGwjP3+jTjct1gG94M5EAsWfYYlmmHca649/9V
         JrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733218747; x=1733823547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAfAbX2jpmVWuMhv4f3fZGpU5CJs4ntFjeUeVvna/QY=;
        b=kU5TWJmx5cMsdo0wRkTcD6fS4TKlxVQ/VjVdOU6kiCB3jb4oHlQS7akka2KTymq1IJ
         gl5rhvG4UeDZX4n/WzBF53dCxmIBvLgysSaxsSvcHw8+NVdInD4KLQIWHiGEUl581yCq
         gsB1TcODHBeArb6gVGDMnbcDz1WVprCFnslg0zOFHD4hkGVd742/PBtB3pLeiECKNOSw
         +5Dohm3YZOSjKYrMUVjuqzMzwxe94KHISfydSAG/cQ86NpNZFOemtVUH9ILWpTTUQErI
         JY4DX/7FbASUzJL3wspgWTf3r7xYxG0Q6cLKp/VARHedHWwt8ZBTQ5e2glCjj8eEDbwE
         qMtA==
X-Forwarded-Encrypted: i=1; AJvYcCV+wHeYHof1Oz3I9lgsyUgZ+VsUO7ne9FKOLHuaywZ1vOgfYd7Zk5nZJxIZ8xHxLTC1IokcuQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAfDjpXbI3PYTkFkjUeOte3Ow3xjZOvM8ThP4CN6QU1ZpgUub
	Ij4JfFKmmaQxzAug1VCraAz2VO91v7tuQAb24Kmwiiomype57G69H0crS0yD5s0=
X-Gm-Gg: ASbGncvC6+ZWL1zDx3eWL1U93BzX+9evuiPko64abOEKFp2tY0GAmL2mOKvb3jiNVWd
	F+pkP5l8T6Flm05EOWtxZLpyyWXr77MsZMVVPhxqnA4Ftv9xM5yhJpaIXNCjXHm4idtInFVTHDn
	4WU6GFpAGNwbj6sNef5XMvvYnWy7/1csc2gkRUfpq0MVWWJd347hvAHh032///F5FDR3nt7HZTI
	YgHdNOPf3cv5VBZHPiaw/Gu6eCgX90zhN4XqD2jByaWWeg6+8Hkqvs=
X-Google-Smtp-Source: AGHT+IFuW8hsbnPhok9NFkBE4GSNLWnfGNwEuWOJe5NvY0AGJzwDm00YwQeKFz6uXex+mAAN6s/h6g==
X-Received: by 2002:a05:600c:138a:b0:431:52da:9d67 with SMTP id 5b1f17b1804b1-434d09b1831mr16625405e9.3.1733218747389;
        Tue, 03 Dec 2024 01:39:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f32589sm186562195e9.28.2024.12.03.01.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:39:06 -0800 (PST)
Date: Tue, 3 Dec 2024 12:39:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5: DR, prevent potential error pointer
 dereference
Message-ID: <bf47a26a-ec69-433b-9cf9-667f9bccbec1@stanley.mountain>
References: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
 <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>

On Tue, Dec 03, 2024 at 10:32:13AM +0100, Mateusz Polchlopek wrote:
> 
> 
> On 11/30/2024 11:01 AM, Dan Carpenter wrote:
> > The dr_domain_add_vport_cap() function genereally returns NULL on error
> 
> Typo. Should be "generally"
> 

Sure.

> > but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> > retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
> 
> Please remove unnecessary space.
> 

What are you talking about?

regards,
dan carpenter



