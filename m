Return-Path: <netdev+bounces-165229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5B1A31218
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363977A2CA1
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C37261368;
	Tue, 11 Feb 2025 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrsSCmMH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A02260A54
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739292707; cv=none; b=NKIb3wA8ZXkeMEmacwksa3kNQJBfbWXnpt9Ep2BHyZafsMi9Spgs12QYFgTlZt+CNDY04TZ5HEu36JWQLBc49DBmk7WWXcNGk6RGL0FOqpHlTA9kWCo+KCvEUEbOaQEoV0ylzXrEosLr1hvNf8/VcARdq/yrgpTO60C9D6ogpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739292707; c=relaxed/simple;
	bh=x5+xjWNWTh9REXkNYHGPPc9qq+75Uf2w1BGQTD9Zo5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKW+GsA6PwYzAjyATLjmSpz79+xwSelQOrT1N0tlYNM/YdUcTt4hqDUWtyqaioz3AukjlFIuhT/1Rqb5+gxZ+GkkxdaHcDkKTKx+EbqI8QZyE4/3oO9rBAuea5zLvZipw5VsO139ccHZ0OkPDo7LWCqKcrG8TgKsUW5EvNf6xSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrsSCmMH; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e3005916aso1921473a34.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 08:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739292705; x=1739897505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jeOLkvXSX/3yyawkvkux+FpiuZ0BVxT20BXs4vBBVTE=;
        b=BrsSCmMHQevUVXKbfOrtmSTPGvh5ABHiz+gOhOUpCM72F50LD6lAEL4+Th80BRAxVk
         S0u9IGW4bsklquZfAZpBK6D0fce54tCQTWM+Ej/Qey0iR/07EJqCM+AaI9DeCK/8fbOg
         iHLo41Dsq7AIUUppECYDGYZfLk6ru7D5tUZPU0EOzKEzZl98zSoRxPklLPdpg9KUkKXs
         D7jXiV70n9PhWmu5M5epleaU5kPlAzOaAEylKqsQNEErnaM/UMzXNb4FtQNbu+5JK0Sj
         GqTc7sYfwgJN7LagozmncQUL03t24Aee/Gi/9dXPMPvta+edG6euAIMytYnVz6mf8qRI
         9bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739292705; x=1739897505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeOLkvXSX/3yyawkvkux+FpiuZ0BVxT20BXs4vBBVTE=;
        b=kwIYbi6Xzk4TZxgiSHhZjsepnRXEo5C9WVDZ1mCYgAl4clqzWZ4YI92HEreconA8HY
         eCp3cl6XzCmuGE/mzkKPQ99JVm3Q1lOsBO1H0qJgRK7pbhSFQiP0ql7dI2eU6GtCp5wg
         gD9jBKIBi6LGo5NjE0ak0M+InVB207OUMRiCPIkPXCluU7+QEvccML9BhE+6/a7EWBYD
         MftAtNq7y/htbOPGcIpLaZtsp/O2uA/6cgmt3SPPgHVuJQLzkznWlavlKw0/HFQZe9Bu
         gI2xYsvG8ZXhEq5KFji4Ok+A/etpAAw6koQSpBbXbCw4odayAoH6+ohayp+0I4lbVTQe
         VplA==
X-Gm-Message-State: AOJu0Yyc9vT4w4WWcIx54TEjt1xezRCbH7odwqMQWcfHb/YAp3o3AUKW
	9Vagsp1SinZ9MOHB1gU3hcGbA0Ne9C3XwHOjEa+ShvUjtJkHidTy1rf6RA==
X-Gm-Gg: ASbGncuMDcvuZdc2tFWDhnRkKl2FUouftIEgsLCnNg0a88bHywvNDOmDKtKlpQMURPv
	9dLuxii8Ug5DN9weLVkcUrINkR6lWzL6xMwhhMbcoHMA/XQkNgaWgN7aGYU5tBUysFWg6ky7oOS
	18zD1nRV33e45LlnmtU9/MgSh8zTPnTSP6TGMR4hLpfCdkg9vL5Lc6rw5Esiqq79MPN6plhO3Y8
	wm5DEr/kW4zL65cfPxymErnCGak1Tp56CTzAsy0HG4yo2RLHuEfVy+8ygdftcp6K4DWeG6HO8nq
	JmaJBTUp3XqDZwdxZblNDqbUfB6jrIZfa2I=
X-Google-Smtp-Source: AGHT+IEZ1GbP8Cmey+DIXEBbFg4pQi5LMadsjtg8mnUZAAGFvIxifZjj86dMX2SjEUhA3R41JhOo6A==
X-Received: by 2002:a05:6830:6615:b0:71d:58df:3277 with SMTP id 46e09a7af769-726b88cd88cmr13090475a34.24.1739292705058;
        Tue, 11 Feb 2025 08:51:45 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726ef414317sm338108a34.3.2025.02.11.08.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 08:51:44 -0800 (PST)
Date: Tue, 11 Feb 2025 08:51:42 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Wojtek Wasko <wwasko@nvidia.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, kuba@kernel.org,
	horms@kernel.org
Subject: Re: [PATCH net-next v2 0/3] Permission checks for dynamic POSIX
 clocks
Message-ID: <Z6uAHp-FDsXS3EMf@hoboy.vegasvil.org>
References: <20250211150913.772545-1-wwasko@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211150913.772545-1-wwasko@nvidia.com>

On Tue, Feb 11, 2025 at 05:09:10PM +0200, Wojtek Wasko wrote:
> Dynamic clocks - such as PTP clocks - extend beyond the standard POSIX
> clock API by using ioctl calls. While file permissions are enforced for
> standard POSIX operations, they are not implemented for ioctl calls,
> since the POSIX layer cannot differentiate between calls which modify
> the clock's state (like enabling PPS output generation) and those that
> don't (such as retrieving the clock's PPS capabilities).
> 
> On the other hand, drivers implementing the dynamic clocks lack the
> necessary information context to enforce permission checks themselves.
> 
> Add a struct file pointer to the POSIX clock context and use it to
> implement the appropriate permission checks on PTP chardevs. Add a
> readonly option to testptp.
> 
> Changes in v2:
> - Store file pointer in POSIX clock context rather than fmode in the PTP
>   clock's private data, as suggested by Richard.
> - Move testptp.c changes into separate patch.
> 
> Wojtek Wasko (3):
>   posix clocks: Store file pointer in clock context
>   ptp: Add file permission checks on PHCs
>   testptp: Add option to open PHC in readonly mode

For the series:

Acked-by: Richard Cochran <richardcochran@gmail.com>

