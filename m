Return-Path: <netdev+bounces-184759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A882A9718C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5497217FA5C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1B728FFCF;
	Tue, 22 Apr 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8i2foHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C561E87B
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336953; cv=none; b=JehjBweghqe9ml80ucNPhTro2r+refAQoI4hiMHm7/tZjpCQ8yjc8DKjHa2zMr0MY5KIRezsDRNiQvHpGoZZ/E5YwBw4sUMX4RuZ5r14qAQoSRAq7GSZOkBnjPVRCAdDVDoQ85rczB8sklp/ViWRr8o1C/mqv1myd1KVDjK/DS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336953; c=relaxed/simple;
	bh=63GQlQ0+0Oiv4dcu5SlCNgfs/FH8kUTyciHdZQVza0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv8OT48XhDaAa6Jl3NsF5yoSpHFU1xZjqVcbWoS4p4SeXenyyHEufiE7r7TZkPr7amDfPwFWxGFvl8lWNp4OpqkpuQHo+eXK/u9laHAf7grTssd9EJGMu5XVHMAEm9I1CTEHnCXz3p84n6zHvjpi7yR6wdDC9JJ/tDQw/uGcC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8i2foHZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2295d78b45cso84711805ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 08:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745336951; x=1745941751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=il46F/HnJ22HaEBCHcVK8g1y4IYHHMTN0YQcgIGD/os=;
        b=b8i2foHZkfb9gFV5zYyx3cZFS7/TIj0mhppeZkSRNjHcl27jtXtXkFi2xXUgTtyNvA
         vo//kDeWkYxQM500DT9atAL8l7McIly7f05//nY90FNK+BKwSf0XL509AJ957FLcWmso
         9+atvgGEk1YWU5q/x7UNJqX+ErC8FXGcM41UzQXw4cUe2RlAxReHOen1Ny3ayzkCnpWx
         QGrDAwlvijOunAQsJ7tkA605cObjGkz7oqGMhwrlGX3gyEjinxVTyV7A1729xxhlmWZE
         LtmCxXjR0xY+G/awdXMnrY0rAfLECbEbqk4RVrNzqcSRpZeLwUtN/0nqCQpQvGdzSU3Q
         GKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745336951; x=1745941751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il46F/HnJ22HaEBCHcVK8g1y4IYHHMTN0YQcgIGD/os=;
        b=nEG5RNwHBGpUZy3c9xkHgAA9fVaP+AQQ8t8L4Nk44dt4MbSLVXaK5OURWsdqMwF2JV
         9TooXf7UgxeZZY18pXzrDlMSS5fYb+4uilP5EPlcNV/8sUQ+i/Myf98G8Rx+55evdVbT
         pil8Wvy5p92IIYAayvS3VTwBmWyHFYPMU9uINxF8ouPH+ytVvCnPHfQ4RrE9T5EPP25N
         CayCOKYK1upvogrbm94LFk1he7piHY04hVJ7xDRCiFUZ9q4BZ1VY4FclrT3SDo5h4fwq
         B9EfRw8kA6Nlt15ZDssprzR3w4pZ8nkDS3FEl5jPLTLi7DiWHKSohhfVcvR5467aJeSx
         2UqA==
X-Forwarded-Encrypted: i=1; AJvYcCV8SxLQZmy8PfgI3AyY3GNL0TYO64KWy4kGqEm6Wv7Mrm+BV5NwQ1C6n/CjBKwAJc6Qe0uLduU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbP4+UebO8ZUQSSvFQHJEjH4fQJkkhPwCxiKec/zUetpo64h+3
	ToLWkRk4wfwCZ4Hd2YcHvRFCIhQPIRvAcW3JtKFFTGNKKpTcis4=
X-Gm-Gg: ASbGncswto0pGIX6/EjnZcJuCTC8qB/mAgllm3F2xvEbae7mfHLJWUOhz4qUT1eU4NQ
	MpuvpDW49D758zS8lIbAfhv94r8x2DFnXlxaMFaVByN9oiLqARc5eMtk2TCH2kl6RdznUq+bMls
	dCSzmDjFghRlsfAJTyGGo36CyZJIPDPnUQt4iuX32Gqkiw1shph31h4hRY790Q0REL6LZg+l8vw
	tgNoe2ukUiJchgPUe0T71W9Q4AVt6mj++UKfiSBlNGAIfb7BCYQnWa5Ji2owUDgQ083gozT+IaN
	EZsPIgl6wIBYsaCmNNAndngdCpVooi0wChC20hCl
X-Google-Smtp-Source: AGHT+IHQ0vvS7PTN32Ez7vhSMLCA065mVhEE2F+YgLiVhJtJdt3u7BYmbO7eEQQsgk54pS6dyKU3AA==
X-Received: by 2002:a17:902:ce86:b0:220:c143:90a0 with SMTP id d9443c01a7336-22c535a7254mr235028295ad.24.1745336950764;
        Tue, 22 Apr 2025 08:49:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50bd9954sm87271705ad.20.2025.04.22.08.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:49:10 -0700 (PDT)
Date: Tue, 22 Apr 2025 08:49:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 13/22] net: add queue config validation callback
Message-ID: <aAe6dW1pU9wjAvem@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-14-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-14-kuba@kernel.org>

On 04/21, Jakub Kicinski wrote:
> I imagine (tm) that as the number of per-queue configuration
> options grows some of them may conflict for certain drivers.
> While the drivers can obviously do all the validation locally
> doing so is fairly inconvenient as the config is fed to drivers
> piecemeal via different ops (for different params and NIC-wide
> vs per-queue).
> 
> Add a centralized callback for validating the queue config
> in queue ops. The callback gets invoked before each queue restart
> and when ring params are modified.
> 
> For NIC-wide changes the callback gets invoked for each active
> (or active to-be) queue, and additionally with a negative queue
> index for NIC-wide defaults. The NIC-wide check is needed in
> case all queues have an override active when NIC-wide setting
> is changed to an unsupported one. Alternatively we could check
> the settings when new queues are enabled (in the channel API),
> but accepting invalid config is a bad idea. Users may expect
> that resetting a queue override will always work.

[..]

> The "trick" of passing a negative index is a bit ugly, we may
> want to revisit if it causes confusion and bugs. Existing drivers
> don't care about the index so it "just works".

+1, someone is gonna be bitten by it :-) Separate bool might be as ugly,
but more explicit, idk.

