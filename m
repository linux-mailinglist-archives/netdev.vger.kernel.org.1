Return-Path: <netdev+bounces-196407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 714A7AD4956
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 05:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFB71767E3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 03:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7A17A300;
	Wed, 11 Jun 2025 03:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCU1peVw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB66BFCE;
	Wed, 11 Jun 2025 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612572; cv=none; b=k5jSk3sSFJuVIeXk3f6MjAFS0J7BT10wk+cAdW+7ePnWkuwiphDBLRdWTbRW/cdNsBp1z6o6Rjw7isWtkvjb0D9/tlwNA/U1xpwQP2UY5DRcknN2jONx5Xz8l2dNLsQCIzkWocz+RwS8yjhrCkIJxd6RWfryB4ceqGezzqUPjNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612572; c=relaxed/simple;
	bh=ZmEIS0ewIEsyBe6SRYgcoDY9nHhjZrdFf9XsyDfIIxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW8n2B5e2rWU0ZBhZVjczyLoGaLdo8Gaqg/pOQULgILuLe8ogRx1i6aWrUQbRLBLr5VR0nsvrAmm5BjELI6eztu5S87fgpLz+eU7FPwdF+a5uy6pU1kC8mLm2jKV+kZOtl30CLoxANvPCBBHfis7J/QpB4dUjp76EDJ7UyWqIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCU1peVw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74800b81f1bso4808142b3a.1;
        Tue, 10 Jun 2025 20:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749612570; x=1750217370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=42bdD8KpWulugTYz5Jl9lO5/i14UE0R8FG/ItYTb/Cw=;
        b=GCU1peVw7uygQjaG3+Pilgww8lT2rjfDtRGtrZTiISFuH6HnIeRGvDRvK/gINlUU/n
         c6i7FUVpk9RoDmyLpT599/7mUIvf9kbkNniySFaYExpG2Fn2X6VXHM1BZbnEAg4kTL1Y
         AzeDR2LvFGUovEGo9Eu4SKkbrGGVMTHm+dFDfw0oVDHfX33evk5ecWY4XT6QBmWRoMiO
         1SrJFO7X+ER55q8ehuuhSeJWoEMbBzb09G1mnQFF/DdorK0ffOi0HqTP+n66AOz/aAIy
         MpVNwFCRZ/2mxv/eQW3vQCd70Y4mz1yqkSx+3lHHp9hqDP526Mwsw0/qL6KPhxb5b4O8
         aKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749612570; x=1750217370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42bdD8KpWulugTYz5Jl9lO5/i14UE0R8FG/ItYTb/Cw=;
        b=aJr7KiKOLlBpH3iOk2R/p/pxFjXUxFEHZXqs2LrEUiPmop64pldK3KyFmtZs1cJWjg
         4e9mNBZvZYVIBdWXogYLkpcsHBGqgAmmcSxIaxK+FIX+p/Um/dxyVlI5DSbaRJW0fdXa
         yCOcmxTgZqBlMeOYKWn64HZSQ1bVVivXpv3BqZaow2RPJ/nzrzEAhKC2EaT4Ru3OL39e
         7WeKWemvgL32x9wK5LVBlK7nWY8G8eEIa8p412flHecKdlCdtBnTvfwHDvmmOcr8t9V0
         +gXXi/pt+RnwM8LqawBBV3E6Lk878s1KsAo8fzU8+/ZELk1zHPiL03SH6FVaRDVY35f2
         eo6A==
X-Forwarded-Encrypted: i=1; AJvYcCUy7wXSqYnPF0evEvOGLE8W372axLFkzDZPRDAFxKoXtFAXrtodRPbXt5cWeLEMrSlVJOM9eZGK@vger.kernel.org, AJvYcCV+K59Awf43xQZcHH42ELyZWg8qNbfqPsyIuf0UbsgLJ4liJG8P+or/wPEJSFMjz5rYyjOKYrVtQaxQSUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36GxdNSNQzRQ6WjdqfoaskZI6/lV0zSwrpPVZmOWUuK5IFwlC
	7s69RtQ35S28BZivqluDvGqHjRbcsRbOJjdVvoqQveodvGyu4aYTBzz5
X-Gm-Gg: ASbGnctC0gBiuZkQE2Nm54aQ/YXl0q7tdXjwdk7mdl6l1cBreuvcph9qgYqMxVOUyqi
	s7KRAkDP3M/9iqV52A4rp6JK9vpYv7ntgrspeGvPN+QdNol0N5dtHsH9i3juez1gw1KxjUfvlQv
	Hnw79RyW4HKt6Mh1sU5IUPOb1sa/w561pULjakH9CC5/B5GCB2cYGr2oVXFsbBS9aInIXVwZMme
	eZ16BCY9m2Vz6XU/S99nfGcRNeYmjadampUFgBuXK0ujUZIf1nrNGackzYZkzYcz1NivopRA2Nv
	2Id4oV6R2x0KB+aekPEqTHyl198pJI8qOpkPTkHlO+pPaNYIFfWZBYLYEKY8Wtu7YCKQ6kCI7bY
	oq3BRMQ==
X-Google-Smtp-Source: AGHT+IGK6S2dXv+NJ8cZYRLHgfNM+hpO0P8zM0qGDSdEQ2oFP/EuSxTv9q/UxdtD6w+DUyf94PmblQ==
X-Received: by 2002:a05:6a20:e608:b0:21f:545e:84f0 with SMTP id adf61e73a8af0-21f89145850mr1798661637.40.1749612569755;
        Tue, 10 Jun 2025 20:29:29 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f791d30sm7557806a12.65.2025.06.10.20.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 20:29:29 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:29:26 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Bar Shapira <bshapira@nvidia.com>,
	Maciek Machnikowski <maciejm@nvidia.com>,
	Wojtek Wasko <wwasko@nvidia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mahesh Bandewar <maheshb@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ptp: extend offset ioctls to expose raw free-running
 cycles
Message-ID: <aEj4Fp05_lTdMgu3@hoboy.vegasvil.org>
References: <20250610171905.4042496-1-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610171905.4042496-1-cjubran@nvidia.com>

On Tue, Jun 10, 2025 at 08:19:05PM +0300, Carolina Jubran wrote:

> @@ -398,8 +423,14 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>  			break;
>  		}
>  		sts.clockid = extoff->clockid;
> +		cycles = !!(extoff->rsv[0] & PTP_OFFSET_CYCLES);
>  		for (i = 0; i < extoff->n_samples; i++) {
> -			err = ptp->info->gettimex64(ptp->info, &ts, &sts);
> +			if (cycles)
> +				err = ptp->info->getcyclesx64(ptp->info, &ts,
> +							      &sts);
> +			else
> +				err = ptp->info->gettimex64(ptp->info, &ts,
> +							    &sts);

ugh...

> @@ -86,9 +111,15 @@
>   *
>   */
>  struct ptp_clock_time {
> -	__s64 sec;  /* seconds */
> -	__u32 nsec; /* nanoseconds */
> -	__u32 reserved;
> +	union {
> +		struct {
> +			__s64 sec;  /* seconds */
> +			__u32 nsec; /* nanoseconds */
> +			__u32 reserved;
> +		};
> +		__u64 cycles;
> +	};
> +
>  };

This overloading of an ioctl with even more flags goes too far.
Why not just add a new ioctl in a clean way?

Thanks,
Richard

