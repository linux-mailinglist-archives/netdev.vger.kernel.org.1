Return-Path: <netdev+bounces-148429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407849E19C6
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2149EB37477
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229A71E1042;
	Tue,  3 Dec 2024 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Os4/fbpq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F91E0E03
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219349; cv=none; b=KHJHUYPzeXVH3kOVjGve8v+vjZB1KMpuU/MQgBm6MKGY9l1sLWVCenn+PyaXxaW0ez3DH7mYOyTn15jpN8kYVXOkMiwiW+jAI0VKHQFZsSXYcG1NJBXOQVJruDRyHrGbT1WXa/3309cSfOLqOchGpdjOpR7mAEs7HIy8lt2TuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219349; c=relaxed/simple;
	bh=66C7X0y5JSIvmxFiooKiDwrInLALIuU1cghHxsv7Mrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjthWnDroJ2WGWbOCRxU6lxZi4VbBE3BPD/79dl+jEAz/JjUgQ0tGpRo384kQ+C3vWc58r7Sd3jDazQT1WkxP+w0nTKYWkx7gBkzHhQPhv3mcp7gIkLuDqPXGw35Sgph/27ZbczU661OyhykeW1HUGE/LZkOU24k9U7yPk2WgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Os4/fbpq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so36492345e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 01:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733219344; x=1733824144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5m6hg1T/8NDguGzINl2AjokycuEBlMQVbW4nuTy6h4=;
        b=Os4/fbpq6FR4D2jx0XLq3ouYACEKaboZsV3uXhNT/xJhqFPFoyLunsdtORGF58ChM8
         MaJn26loszUFyLfcPYRkAIba5cWHzYOOPc9xWOVvSGpB64fr9Hmhcr3FjyVKFw91hL14
         hYvmmddyHfYzHLNWckwX8WS+WGINd1/4wEm55inotYVykwIFSIzHXhAwpvdY1WcV7P9Y
         Z6uqGPV4S3lBBFGAJ5ys3fhvq0ij6cpV4/FP3P3PaE4+Tq2BJXnJ5a5Vb5m8ujCyt+24
         FAfmipDS+n/qxQXyzd2/Pbu/T+AB6VIlCOSbavxepgTlStwtF77macYegLPA80Pr3QrG
         xWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219344; x=1733824144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5m6hg1T/8NDguGzINl2AjokycuEBlMQVbW4nuTy6h4=;
        b=lDLn8OID0YDzXfSyNkvDQdJKeM57qBPvdvTjYu0/fkchvojDexyAJLEiLIbyprNeRD
         xee+Ft7icBM2YRsIYXuUXXtJN6kbAnk2QKJnlDZ8aSpQiKe91cKD5+10OEQAnqnO0+S8
         Roi+Nduh9i8SknmdVj7rm6TSYImHysVI+4+x5D+SA/Ns4DF+IbAqCv6y/r2Gc2HK68dl
         DiUq6LUqdb+CbCgaSv/JOs1CevhoMqAi7bPWxA40bj9zW9rWK0/1+Hus2cEFPuuMoKO/
         qp4piW9hC3UZvbp3tiDATO7Nj+ABH0jDFy1DWsFjoa5sbACFmKZ41sR4BFMvuoUvyYMZ
         eGxw==
X-Forwarded-Encrypted: i=1; AJvYcCVUFE7MXEmh3SWzss9IpLYWQ7iBt6puaHQ+jsEBPp9gLY+txLJT0bFOY34uhIoep1YxLGmpYKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBcY8LZJ/5T9P2ACBIv2bSIDml1HksxVDdVmN3kET548FjkP9s
	cGtXjvm7iybZ+I+EeZ0a9HSc0Hdff+RZE58HB6PBJtQlBcJY80GiVB8qHM1yCIs=
X-Gm-Gg: ASbGncvIS9PaOid41SbAeJWbUDLS8DCJAZNQ/vCkrZ7iEU9q/5fMwG9Md2M48xTMh43
	b/tlXmg6Zuxo8Ayuta7TsXqQdPszHefkXzdhxSoauwYfGLqigzXrVWpZtS4M78cmqD4ajEBpy0k
	2fufhN0utlEMNZ7wI6npACQ+cwup2sgnAQfU/iuBH2WNIGeIPLb24gUlvG3DpPUKd/Pij6vL3yr
	LJf23ltr8HFBLCGH/SC/Da+va+7zAMtru9PQ2fyEKnr3skE9TFDVoU=
X-Google-Smtp-Source: AGHT+IGiq5MfIfBd9OA4L42VqbX8iZSuCB9pKeFGXwzXoQE5bTKyZlB+OEQ8WGkhd7IzIABfKHMT6w==
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id 5b1f17b1804b1-434afb9ecc7mr189287195e9.8.1733219344634;
        Tue, 03 Dec 2024 01:49:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d04e7380sm15910995e9.0.2024.12.03.01.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:49:04 -0800 (PST)
Date: Tue, 3 Dec 2024 12:49:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
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
Message-ID: <46a97b8a-042c-4903-817f-efe3be5afabc@stanley.mountain>
References: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
 <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>
 <bf47a26a-ec69-433b-9cf9-667f9bccbec1@stanley.mountain>
 <4183c48a-3c78-47e2-a7b2-11d387b6f833@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4183c48a-3c78-47e2-a7b2-11d387b6f833@nvidia.com>

On Tue, Dec 03, 2024 at 11:44:12AM +0200, Yevgeny Kliteynik wrote:
> On 03-Dec-24 11:39, Dan Carpenter wrote:
> > On Tue, Dec 03, 2024 at 10:32:13AM +0100, Mateusz Polchlopek wrote:
> > > 
> > > 
> > > On 11/30/2024 11:01 AM, Dan Carpenter wrote:
> > > > The dr_domain_add_vport_cap() function genereally returns NULL on error
> > > 
> > > Typo. Should be "generally"
> > > 
> > 
> > Sure.
> > 
> > > > but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> > > > retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
> > > 
> > > Please remove unnecessary space.
> > > 
> > 
> > What are you talking about?
> 
> Oh, I see it :)
> Double space between "retry." and "The"

I'm old.  I'm still using fixed width fonts in my editor so I still use
the old school rules.

regards,
dan carpenter


