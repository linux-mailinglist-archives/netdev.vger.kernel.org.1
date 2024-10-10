Return-Path: <netdev+bounces-134426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C94399953C
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 00:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A25B21B6E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D971BDA84;
	Thu, 10 Oct 2024 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="uF0Ukg2N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82B1A2645
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599478; cv=none; b=T4Yqn51ngkVrNq9L1jConF917mZPsJDb8o+7ylOsfs5VNjtk9WXY4gJPk0qgatGX0KFwYXVWghJnTgWPnWKoMB46cvZPjGVk9BEnrY5laRx9wcMsuxgJ2LctyzfRHUQzMTeCvgFIywZZIbLz5zyfj9BHJ3Kk+KEkWl8uqvhHbdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599478; c=relaxed/simple;
	bh=Rg1n58rARGmZfxH7hxO6NsktVN7TRNQ9NRohKzCue6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5Cae9fx6nv+tQb9V1eIgYmiCDBmp/zVmW6ory7HhZ0QhQFXi+8GiwsNsjdlKn/fpQyF3sZDYMfREvrtwBhy6uOL3AlcjB7mlQvRdZuzgw4aET6f2vwLV8a9b95/iIqyYW620JoMEmbLsFI3MDr2SYt5+9KJOQda2VCSsKDXRyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=uF0Ukg2N; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1187912a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 15:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728599476; x=1729204276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmu5gEA6Us4z+8Z2DQuxXdFrH/rStjUSKKs4Ex+KNnw=;
        b=uF0Ukg2N6qdczgWVWkitqoC8UUwgLCY80a12HfDab95aYFVtxn5oQYuKty8uLhmhZw
         g+aKffI5IzxYpoFvdZrwnwqDEQIF7VBOZQMuMzzBwUS9MXLOoM66iYMUlC1QtWbIHTm5
         MomEzcN5T0abuDHxR1eaEc0lhdrhcsif3H0Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599476; x=1729204276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xmu5gEA6Us4z+8Z2DQuxXdFrH/rStjUSKKs4Ex+KNnw=;
        b=oXdL837c2F4C7w4zXQI6rwOlIJOoj657oeAPNNhaMwc0BUcYvdZrTkwuyA+JVsAir3
         KQdMx29pDycQG9a0huCepZYQoH8bNTUP7U5g2WVTlS7lkABsADTA5g7BcK/Zq3xqyMZc
         VQepKhAR9xVHX0Pd8/692LfeZHCXufJdwJ6dbJ6hELG9YnVewS0jGSXGMrUxJ8unqROC
         tYj4IhQpUSs3/6vH5oyUVt+qorm3PHLa9ryXYEkdBlBP3RAWPNBusDZShWv+T35JYJc9
         jUTDQQ8bgubmAqzyjdODQVBaXojpapU6tSDW2TQfBBVOSRavJdmnFlf1AothWqgSyJW9
         WKRw==
X-Forwarded-Encrypted: i=1; AJvYcCWaUEtcoPrZ9PHt/RkjbkARO1qRPBWVgdT0wYrjgRMwCKCkHo5A/sOGn8HSbNuvPkSGDS2E2l8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/oyIujlYaENQhOKElS02xq0Swr2oL2HcJBofZv3imnRqVilkv
	zSLp6K4LJckVrQuABpUtV6Ywg3NcNR2R/9/9cT9fHyWKcH/+Jhxn+XnLUhIIWXI=
X-Google-Smtp-Source: AGHT+IHthjdAH2FjU762emdTgGH5LMrLF/wccJ1kh1TX3MBSD+vVuLqe+8a1Yd59QLBK0NgIlm/ahw==
X-Received: by 2002:a17:90a:ce83:b0:2e1:89aa:65b7 with SMTP id 98e67ed59e1d1-2e2f0a62d34mr992578a91.9.1728599476161;
        Thu, 10 Oct 2024 15:31:16 -0700 (PDT)
Received: from cache-sql13432 ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5dd2b65sm1887281a91.2.2024.10.10.15.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 15:31:15 -0700 (PDT)
Date: Thu, 10 Oct 2024 22:31:13 +0000
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] selftests: drv-net: add missing trailing
 backslash
Message-ID: <20241010223113.GB260524@cache-sql13432>
References: <20241010211857.2193076-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010211857.2193076-1-kuba@kernel.org>

On Thu, Oct 10, 2024 at 02:18:57PM -0700, Jakub Kicinski wrote:
> Commit b3ea416419c8 ("testing: net-drv: add basic shaper test")
> removed the trailing backslash from the last entry. We have
> a terminating comment here to avoid having to modify the last
> line when adding at the end.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 25aec5c081df..0fec8f9801ad 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -9,7 +9,7 @@ TEST_PROGS := \
>  	ping.py \
>  	queues.py \
>  	stats.py \
> -	shaper.py
> +	shaper.py \
>  # end of TEST_PROGS
>  
>  include ../../lib.mk
> -- 

Reviewed-by: Joe Damato <jdamato@fastly.com>

