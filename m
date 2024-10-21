Return-Path: <netdev+bounces-137633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842129A9035
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ADA5B21305
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83531CBE8E;
	Mon, 21 Oct 2024 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jtbl5+uN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89BD1C9EB9
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540323; cv=none; b=VEfnJSxzN4g+oeK/HdJoBuL8C8vEEho2aGB/p3f+LwZ30IqtX/j9DGK7Vlz3fwqW6xOhXmBXKHoz761zxEDtXurv7CF128o3y4F+jYiP9Uv/7fSG621j5oCehBkbs0wN2BzEDzgapH3i9M3JalHLUEpDJ2kUYtnFCYh8PqNoz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540323; c=relaxed/simple;
	bh=iKC1ZShbTwKFOjyE32rfAwbAHqLbahsqO5Inf5R1kpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr5v60FHT5KX6K+Mn1KZt3CHLWbm1G8IWwo8a+v5JLw9+Mg7qXZd07unJtN0vwyfsGrG0G1rUpj+7Qaemo5Q4WR4k+RqjzRu7L9Qgjr3pZyYetoxlPizUFYkyJOyxlFGxOE7ATTRpltvLyKigLotT0TRNkLKfJG1sqP7RbKalMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jtbl5+uN; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e5fef69f2eso2425849b6e.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 12:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729540321; x=1730145121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIawkHupzHJ7yxtRL3rNvpTlhte1WQaDTMnKaAu1dz4=;
        b=jtbl5+uNCMkkaO5bWjwsOtNf8Yi5lbPIG3osVvjUWtQPBz58GWc2zw5EXtyellOP2i
         IrzzKhZXLGxJgW65SulKRaNsAdGqsf/qHZB+qPNtsYaw34fJ2YhotODu3IcRntAX+Z8/
         FJl4d5AKDxOumAVv6wCwMkx6oT50jengtUJeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540321; x=1730145121;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIawkHupzHJ7yxtRL3rNvpTlhte1WQaDTMnKaAu1dz4=;
        b=Z7G8vR7ptyfwGuuVvMjdJHokKcqV9qPVTr3PuRRqL7daCRkOIN9L6raGWOpnrWnbSg
         f8u3e8kqkt3lPmEUQtwELyzHA1GY5U9qguov2eWOvzw3DgaioA9LMEYYd/cBP7WV9lbV
         FAPYtz5Ybw+PzW3C7pRMvHd0HW8IX76azbOkVuq1PHlZACFC8LlhCGRDta0VbFI9oGom
         bJ30af7IAWLa86XvmY/OyPuP5clyvFqbo/VNI16XXuX9QpST3ZW0Vn+0qSIsUG/5L4Wl
         ajhb+89XEpZwj12JkoT72oEQoqKD3OqlUgoqMJAzBe/1IxkFEcR/QZ/4iOrVODcGGGgr
         U+PQ==
X-Gm-Message-State: AOJu0Yxz8124Jy/mIAovlbfhsR7UoZ8SVBdDTnMsMp3PT3DaSXLPUF0/
	9+jpMbcTZTd3mLkaatH5e4oVox7vjuKHjsz9YcR82XruopcDXdJAkcIokMs6w7g=
X-Google-Smtp-Source: AGHT+IHlC0X9GD9TbkYZ5McU9pSLCLA2UnU3uT/DNGTh2w3hDR6D2QT1baeY7B2vJTV9tSDLqMbf0A==
X-Received: by 2002:a05:6808:23ca:b0:3e5:f412:56e6 with SMTP id 5614622812f47-3e61d0371bdmr335798b6e.43.1729540320815;
        Mon, 21 Oct 2024 12:52:00 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabda222sm2990202a12.86.2024.10.21.12.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:52:00 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:51:57 -0700
From: Joe Damato <jdamato@fastly.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH v1 0/7] devlink: minor cleanup
Message-ID: <Zxaw3TRLc1wab4VD@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
References: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>

On Fri, Oct 18, 2024 at 12:18:29PM +0200, Przemek Kitszel wrote:
> (Patch 1, 2) Add one helper shortcut to put u64 values into skb.
> (Patch 3, 4) Minor cleanup for error codes.
> (Patch 5, 6, 7) Remove some devlink_resource_*() usage and functions
> 		itself via replacing devlink_* variants by devl_* ones.
> 
> Przemek Kitszel (7):
>   devlink: introduce devlink_nl_put_u64()
>   devlink: use devlink_nl_put_u64() helper
>   devlink: devl_resource_register(): differentiate error codes
>   devlink: region: snapshot IDs: consolidate error values
>   net: dsa: replace devlink resource registration calls by devl_
>     variants
>   devlink: remove unused devlink_resource_occ_get_register() and
>     _unregister()
>   devlink: remove unused devlink_resource_register()
> 
>  include/net/devlink.h       |  13 -----
>  net/devlink/devl_internal.h |   5 ++
>  net/devlink/dev.c           |  12 ++---
>  net/devlink/dpipe.c         |  18 +++----
>  net/devlink/health.c        |  25 ++++-----
>  net/devlink/rate.c          |   8 +--
>  net/devlink/region.c        |  15 +++---
>  net/devlink/resource.c      | 101 +++++-------------------------------
>  net/devlink/trap.c          |  34 +++++-------
>  net/dsa/devlink.c           |  23 +++++---
>  10 files changed, 83 insertions(+), 171 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

