Return-Path: <netdev+bounces-172449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72B0A54B28
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFEE17047B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC181863E;
	Thu,  6 Mar 2025 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GCgb1+1o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716A217BA9
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265255; cv=none; b=NlvZsMyzuQS6Yqmy+OS9x/P/ikwmPX0Elb2ZGVgHxLCLcpox3fkb1bl/c3HQkXieL2CSkjwFWORtxczQOWYxCS/P3kZcNaGgdYJLKx0rLReIk/zCoA1Y50yeHCfTz5xLQ42/yeL5K6AzvtKdJHSF462uhKplXzEm+NDzV3Gzylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265255; c=relaxed/simple;
	bh=Up+aldGBaA00n3mn0fpGZ+nU/HjGiZgvNhtWaB0Brh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hI/CZysh0njtiSRNWBwbvgYOD8ezTWiPB8N63tXq0czMKvXWxPd+pxBzfcQ0/EilXT/pGdoZEI++KJIL4FGtfpwD5w8xSEo8p7vQ2ZHd9ylDjB98wU/9kCGPSeoidJDX5YHVM/VqAQKZSvMTp0ydru9rXlLJR5cKl2oI/av/47c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GCgb1+1o; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso6728805e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741265251; x=1741870051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5hZNm5FBtBQ8RgVFKxGhGMV35WiDPZm3S3W8QbGcDLk=;
        b=GCgb1+1oYkEp9j5sozs9muKAozHrUjmYF870MuvDryV2m1uDbu/5bkEfSOI97l83wb
         fW+RsvuTIK+gWjrAqgIhnNkg/ei5PqSePG7RtU6zwkWSSjHb6a74jf5jIuIXhyPP8RpJ
         Cu4UX+huu6eYIOGcziVvbujIgtnayHMX2hZRUB2hV+/bSG5EK7Dq4TjVAHpjEm7zWryP
         dG6k8FvYTiP41G34Lu4itaZ6MksWuRuap5J5x9fUNGeb2UovT67/ON5aumlmmBaqinzn
         rvOBKuk+STuzRoPulHwN0b8Y/+HGj+hA7yrBJTf73ETloyAswCfdQMyAXbE9HzCWjKmE
         z2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741265251; x=1741870051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hZNm5FBtBQ8RgVFKxGhGMV35WiDPZm3S3W8QbGcDLk=;
        b=DW8XxHQvgSgjI1y2JRQMAnddpA4lzgYGoVNuB2ab/UgeQFAHQVD36D1I+aLOAlqi2n
         to+/ki/rDDD+OV4ivcA+Mptb7lmmWFy5MDtPUwkDV81IR8jyCIF4Glpj2T71mUcLbkfz
         px7N/ueXiRRcDETfrsq2cgf7a7oinpu2eYt4/IdBDP4TMU0IgNJybR3MZDQn4ltmRKxe
         7DZXtZjwe2HZK8MNbK3xKByAHpOuzspHv0/6sL0tYhLWB1sRGTApwE4/0h9MDmx3PRGH
         j0Z8SLOdXpekLMp7ql/WguD9iOYG45tqRJNushgD+LPIYv2zRYskMHkh8DH7m7udlKQl
         dInA==
X-Forwarded-Encrypted: i=1; AJvYcCUcAVC8VJP5FtfbEI+e4hgCPuKP74fto+nLLaRP2NNkN+NyvVT0f4GOF/Sn1qZuGxChJGRBKr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykC05h1Rmn7Th6F73nFcDNZGOI586Xg3XIuBganrEdDM5dD7Yb
	PmRVeuCtJQ7BasvOBXw/wjj9aF88fMNi7JmCJMckGuWA5ardQfcP5iuxrdBtheo=
X-Gm-Gg: ASbGncsFDAv9/rMv2mXwcCWoL/wo/FU68cl8s6iGvlaGRC8NFfFFc54WPisQTO7wAUp
	Ct9yHojZcp0zKJ06mNb63YK48ovp2yRLVI6qtyjtbEqcbQeIMjyy5hoYRAStwnWS59Bmk4Gt2pu
	29G74cCPQKb2SRZ42rmUnjFYDEwOBUMh9uKP9hkKmAuy8wHkTNpUovJjd2zjD1mVRkVQXR8aysq
	UF+HLVYaKY3yKJtpBaklIArISOY1F0n5AGSme+POi8VdbkzhgFj+QmPXiscrPUhV9U7MYQJxOhS
	xxqhlYjkqWWM4mbv4VSZKShjmOoq5dYUvopNIwcCud4+tPNOTPidspMti0m25O0tpURVIHcp
X-Google-Smtp-Source: AGHT+IEFhNuYZ+z6bxKs94XD1T5cvtdGwqhGzhRcTFV4h7HNuB7NXh8n+T71Gn5iWt8ClaoNyS2TtA==
X-Received: by 2002:a05:600c:4ed2:b0:439:9d75:9e92 with SMTP id 5b1f17b1804b1-43bd29d239bmr56832535e9.28.1741265251345;
        Thu, 06 Mar 2025 04:47:31 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c327fsm19056285e9.13.2025.03.06.04.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:47:30 -0800 (PST)
Date: Thu, 6 Mar 2025 13:47:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <amselxwxk5wimldqon5pwiue2canabbbzebrtb7um3osmnjsue@immvwjergd5m>
References: <20250303133200.1505-1-jiri@resnulli.us>
 <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
 <20250305183016.413bda40@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305183016.413bda40@kernel.org>

Thu, Mar 06, 2025 at 03:30:16AM +0100, kuba@kernel.org wrote:
>On Wed, 5 Mar 2025 20:55:15 +0200 Tariq Toukan wrote:
>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>
>Too late, take it via your tree, please. 
>You need to respond within 24h or take the patches.

Can I repost with Tariq's tag (I was not aware it is needed). I have a
net-next patchset based on top of this I would like to push.

Thanks!


