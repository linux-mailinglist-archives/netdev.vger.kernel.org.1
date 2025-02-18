Return-Path: <netdev+bounces-167530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D4CA3AAE3
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55CD7A39B2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381DF1D5CFA;
	Tue, 18 Feb 2025 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic3qIcXQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33214A09E
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914177; cv=none; b=tu7v5iz7ClkGLw1+UwIA26lV/xQ2SGhQSsEaytRk3X3eer0xT0cB+4UcFWWqiNqQ+7GpyAtjLd3lz3mNPEfqRx2uB37kTEtmAKzXfCipGdVPuQG+iBByffv80BMYiVUCyMxgRCPwGhmINiB549ev0TYWjVz2HEvStVa0GmDKFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914177; c=relaxed/simple;
	bh=V9WPVoRGEoNNDyHRr9omtiC5Xj5NDgSsCjQpUFAtxfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inCV8jluoqxnQ5LSd9HXkt1bd0DEvRhTeJEHbNM9LvzLG6KESfYxMJww6Q854mlkZ/KOIPcvWIsuC4ondE+SQroGsmr4MjVfb9obbImJVroPXUOJIrgXjjgs4sEA/LDbimJl1OcrzVXUQ63MMR6dO+iEdiClE/URhZfi5QKedig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic3qIcXQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220d601886fso80365075ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739914175; x=1740518975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ToaYPDs/49QWJTCUauzvQMxEr9mvqK4rebbhgTHvs1g=;
        b=ic3qIcXQQBNVFnQYvhtkE4/x+m/SHsfq0geO7+VwnrIaW7W8I5+Q2o+JPqnsw68Q4Z
         4HsWn4gYulyVkEzYocOfm0MkM5xOzmI9ZhZ6lVNL5C7OubH5GZohM06DswQFL2pe2oD2
         7Ex5rclbFzhf/KnPSXb9FwOKn0xbeCq4GSu4L1vqYPF9oEDWVKSdBpQGb2O2AJ76VudU
         xGvPOX6h5WNtneqcurHYhPgJCLlVYc6R2SdUzDUqo2sABlIoLkYXlSLi/UNiu6jVU5ht
         8Yr7HeYW6GZSFSbAcOkVsrG3Go+Kilmp81s4ummJTvPZMGcr6gPQVy1e3o3pLASqftnn
         ye/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739914175; x=1740518975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToaYPDs/49QWJTCUauzvQMxEr9mvqK4rebbhgTHvs1g=;
        b=PdilQiakLkyGhvISIFq1fx9pG9itCeeymwjyt/BFFA6WGJ9rbtgVzW0kDRdQeq+Uqu
         8NraZtr5+BbOIl9JIXD4cZIYwtJP52d1qeGDlFL5KCSITBHxlSNGpM8wAnSC1e0+YK3C
         xKEpey623XVG0/8zGWpRayKpiDuGhui0BQAn8aiTc5K8mCw8Thpmrg2V9dZhojm+LrX9
         +58gVV1VYSZiBCYL6/RsJCYECL5du648BSeJb49T17gYi6CQvFv8CTP2xCIacGjsrPwU
         JtpMIydfFzxHhunuAdF1oD9aQoOtv64zHrsk+Y3nHH5uPiTUvNEzszxLRgRQN3WaMX/O
         RplA==
X-Forwarded-Encrypted: i=1; AJvYcCUFD60p3xlkaYNKV/bPiiymMd3Ms8zgASPae94KTwtVuZbR7FxW4QCwMTh5SbebLGvohv2uumw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cG7gnYUOBDYabpr8bkDmXhymUSNrYnCiLn7o83SvFpJqi08P
	aqhlffXXnET1UuD7Q7mvkhyj4kXXF31WUvVpq71EbfXGlRBHcGY=
X-Gm-Gg: ASbGncuBAMK4vGiW1gULLpA4aT+Jfp0UR9E8XpSChods73ZV/xsta9/9+sVc+NHGy9j
	fUQjhRovH17AdTAWrgWtQtlywojCGcfT+v3CcLuOJKzAbaollOalU7612oGm2spxhA1PIzSIbdh
	0tCR9fmke2nUqpRiVMSkpG8TUVbQeKGSF5tY2bx1B5BBQ2gA8a4YMuejAWY0uQVEiWVHN1pMLev
	kweXn/qy8oGU8xRvgKw+bVonynvcp9/UhoIDGuQt3GF0pPR4L3xEf0JfHvwA/5Ovx3k1MqCVwst
	XaepmKc7TW7I9lI=
X-Google-Smtp-Source: AGHT+IE5f1UdaE2ewNWUnrHTa6K7AdRW2VyDgbuVf21bvu1h6RrmTCjBXzgpL6vDUGXV+PIOAEXVVQ==
X-Received: by 2002:a05:6a00:2e28:b0:732:5a8f:f51b with SMTP id d2e1a72fcca58-7326179ebd4mr27699606b3a.8.1739914174978;
        Tue, 18 Feb 2025 13:29:34 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73256997163sm8714168b3a.175.2025.02.18.13.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:29:34 -0800 (PST)
Date: Tue, 18 Feb 2025 13:29:33 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
	jdamato@fastly.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 0/4] selftests: drv-net: improve the queue test
 for XSK
Message-ID: <Z7T7vVZgvqt-DOVC@mini-arch>
References: <20250218195048.74692-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218195048.74692-1-kuba@kernel.org>

On 02/18, Jakub Kicinski wrote:
> We see some flakes in the the XSK test:
> 
>    Exception| Traceback (most recent call last):
>    Exception|   File "/home/virtme/testing-18/tools/testing/selftests/net/lib/py/ksft.py", line 218, in ksft_run
>    Exception|     case(*args)
>    Exception|   File "/home/virtme/testing-18/tools/testing/selftests/drivers/net/./queues.py", line 53, in check_xdp
>    Exception|     ksft_eq(q['xsk'], {})
>    Exception| KeyError: 'xsk'
> 
> I think it's because the method or running the helper in the background
> is racy. Add more solid infra for waiting for a background helper to be
> initialized.
> 
> Jakub Kicinski (4):
>   selftests: drv-net: use cfg.rpath() in netlink xsk attr test
>   selftests: drv-net: add a way to wait for a local process
>   selftests: drv-net: improve the use of ksft helpers in XSK queue test
>   selftests: drv-net: rename queues check_xdp to check_xsk
> 
>  .../selftests/drivers/net/xdp_helper.c        | 22 ++++++-
>  tools/testing/selftests/drivers/net/queues.py | 55 ++++++++----------
>  tools/testing/selftests/net/lib/py/ksft.py    |  5 ++
>  tools/testing/selftests/net/lib/py/utils.py   | 58 +++++++++++++++++--
>  4 files changed, 103 insertions(+), 37 deletions(-)
> 
> -- 
> 2.48.1
> 

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

