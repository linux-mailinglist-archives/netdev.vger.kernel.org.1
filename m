Return-Path: <netdev+bounces-185489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DF4A9AA16
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED986462DE9
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851E224B08;
	Thu, 24 Apr 2025 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i28B6GdT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5B522330F;
	Thu, 24 Apr 2025 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490291; cv=none; b=jlk8wNrL570pUUzLqHt43v9vK9Zprx3sCaGjrYA8TwxMA4zwUDLvIbrHwnY680dzUPzB0IlYnclvazJtDOYk2CGdBY9p90sJE+A/zdekh6u3fbqnVCz46edhpwH1uKLiKB6tRSnUfoMUXpsEIk1+uIwokE6FOfHuy6Ab1HkrE2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490291; c=relaxed/simple;
	bh=IlIOMdYHJ555cWzmt/zQ4blnbGSKrIpEZRcdBetLLXY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=RySQBOdzfHCz80ReOPNdEodADXdsAo5ZdTZ3/hc43dc6r4DfCEP1FG69Jq2WEDy2dztOiN1R4sFWwV0dgpE+iS4twW4yd0GsbcKIE+UhIQo4VI9VnH0B00cIZcsAaLVxX/WjhbDWG3S5CkJZmVeNO1s3k3JkqmPxxwuFct5NPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i28B6GdT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c1efc457bso557301f8f.2;
        Thu, 24 Apr 2025 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745490287; x=1746095087; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNRkChMGDnmCH0tbjwsRxL/MLXsmw5IBK1Xkg2PwUx4=;
        b=i28B6GdT6t9FvH4L2p9gLhw+Akv+/OSwhX7e1GqfZACqdP2wf7rM0qS4EDyDBHO/FR
         QrKqUVeK6WnOFCkcG9lVeHWhh8P8VI8+c9x6+oKT9fGhy8BOF3yklCDvzEz0Xcb1auVN
         JeexpOQUoTm451WEfhu7UfQHLPg2djAW+fX8q+ETqR+AsGOHdGiIeFFTcIeaXqfML98U
         4Ml54PHMsBkKRTb8jLizaG3JkbR/15BVk1hSmfFSIfKLnPpw3AcnTPX8WHc9n9nE3yd5
         rI2Q2lVyCaKDkujslMo0VR4mBSRfvIJniwxXH8Xntqxeq4DLMAEKh5LIc2jY77+1T0LQ
         CGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745490287; x=1746095087;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNRkChMGDnmCH0tbjwsRxL/MLXsmw5IBK1Xkg2PwUx4=;
        b=fZp75mzyE2RjJEpXO8xCrqqWO9CqNkUIexLWVY4NsktH6eky98ozvhnqH9Cq5oALOJ
         3Q/02ndFAPYLMy7/aQSqCbQ+2RFRmb0LB+AZ9xQ7ZKwctHNujDpe3Ux08+Iy03lSEfq8
         Ax5GGnkOOg2foJeUK7cWzWdM7hBc4L7OyQySqLuaEJrIkoka+9CFymBFGMVIN24nn+fT
         V74EC/aYL/D7UpKbqcM4pp8DDcICtzokjmZq4HGcXsGhEBGlPV+0XOgEjfZ7cxNGSXfL
         xH4HQsnfGU8fgdQAFKU9V7/uJGda7xwhXnTI0P0h1Kqn37fHqotl2AdAOrhwHEZot6Fl
         2i7g==
X-Forwarded-Encrypted: i=1; AJvYcCVOURfVRZlyhPGJlT4YJT7lo5WRxc6mvMbK4qgthVhiymtlehvbWN9lIYssVo54sEXcq+QWDyOBld9up2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFeNN9cpLD3EMsgwdl1szmmz9NOz6UZCQ3HxMn1/aF2/xkdIvO
	iBFuRoZ5rhSLb2q1AjozQUmj/M6uJrcLHtOKbdhckQLEX0q7P09+08u0VqlQ
X-Gm-Gg: ASbGncv0jGev/fC7Tx8WHx/AP/+TfLzUdSmPAta6ZknSmgRtuDVHddLiUHpeJpveu0u
	VEeqXv4ldZH0+WQSFqTbya8a+ogiQ4HPMDCW8TXdIjaGC6v7twg3Xq82d4Zdnc1tCDpZrVjaxXu
	Rwi+TYwcQ7xpVRMBxqK9TlRxbTQx/fMpL2LfX7b6wW/RLbJGz3WD169KB9hFN1w+rhAzH3QOzgN
	BCrddSrrLHzLMslcsAs1bHD9F4GzPo+E2D23fd/Nd2IEFMAM9mzQya1mVgzRiRgTAbK2p1x/8ou
	pVzIX9QFG98e7XqyCFk/6YgIwNLHOuYcxjkoigWs8ia1bsQtDi/HVfk+euY=
X-Google-Smtp-Source: AGHT+IHI3Jwi5rsbBtTyPyfz1rQCpzMHD+eGtHPy64ax+ON+GQRz3pu4mezK2hfis4H+kAk/HBzt5g==
X-Received: by 2002:a05:6000:4202:b0:391:40bd:6222 with SMTP id ffacd0b85a97d-3a06cf5c719mr1526065f8f.22.1745490287395;
        Thu, 24 Apr 2025 03:24:47 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:7d34:7f0d:292f:fa10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d532958sm1643367f8f.62.2025.04.24.03.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:24:47 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org,  kuba@kernel.org,  Jianfeng Liu
 <liujianfeng1994@gmail.com>,  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,  Hao Luo <haoluo@google.com>,  Tejun Heo
 <tj@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] tools/Makefile: Add ynl target
In-Reply-To: <20250423204647.190784-1-jdamato@fastly.com> (Joe Damato's
	message of "Wed, 23 Apr 2025 20:46:44 +0000")
Date: Thu, 24 Apr 2025 11:17:34 +0100
Message-ID: <m2selxsw1t.fsf@gmail.com>
References: <20250423204647.190784-1-jdamato@fastly.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joe Damato <jdamato@fastly.com> writes:

> Add targets to build, clean, and install ynl headers, libynl.a, and
> python tooling.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  tools/Makefile | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/tools/Makefile b/tools/Makefile
> index 5e1254eb66de..c31cbbd12c45 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -41,6 +41,7 @@ help:
>  	@echo '  mm                     - misc mm tools'
>  	@echo '  wmi			- WMI interface examples'
>  	@echo '  x86_energy_perf_policy - Intel energy policy tool'
> +	@echo '  ynl			- ynl headers, library, and python tool'
>  	@echo ''
>  	@echo 'You can do:'
>  	@echo ' $$ make -C tools/ <tool>_install'
> @@ -118,11 +119,14 @@ freefall: FORCE
>  kvm_stat: FORCE
>  	$(call descend,kvm/$@)
>  
> +ynl: FORCE
> +	$(call descend,net/ynl)
> +
>  all: acpi counter cpupower gpio hv firewire \
>  		perf selftests bootconfig spi turbostat usb \
>  		virtio mm bpf x86_energy_perf_policy \
>  		tmon freefall iio objtool kvm_stat wmi \
> -		debugging tracing thermal thermometer thermal-engine
> +		debugging tracing thermal thermometer thermal-engine ynl
>  
>  acpi_install:
>  	$(call descend,power/$(@:_install=),install)
> @@ -157,13 +161,16 @@ freefall_install:
>  kvm_stat_install:
>  	$(call descend,kvm/$(@:_install=),install)
>  
> +ynl_install:
> +	$(call descend,net/$(@:_install=),install)

nit: I'm not sure there's any merit in the $(@:_install=) construct,
when it's only really needed when there are multiple targets in the same
rule. For ynl_install, $(call descend,net/ynl,install) would be just
fine. It's funny that the existing convention in this Makefile is to
mostly use substitution for the _install rules, but literals for the
_clean rules.

Either way:

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> +
>  install: acpi_install counter_install cpupower_install gpio_install \
>  		hv_install firewire_install iio_install \
>  		perf_install selftests_install turbostat_install usb_install \
>  		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
>  		tmon_install freefall_install objtool_install kvm_stat_install \
>  		wmi_install debugging_install intel-speed-select_install \
> -		tracing_install thermometer_install thermal-engine_install
> +		tracing_install thermometer_install thermal-engine_install ynl_install
>  
>  acpi_clean:
>  	$(call descend,power/acpi,clean)
> @@ -214,12 +221,15 @@ freefall_clean:
>  build_clean:
>  	$(call descend,build,clean)
>  
> +ynl_clean:
> +	$(call descend,net/$(@:_clean=),clean)
> +
>  clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
>  		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
>  		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
>  		freefall_clean build_clean libbpf_clean libsubcmd_clean \
>  		gpio_clean objtool_clean leds_clean wmi_clean firmware_clean debugging_clean \
>  		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean \
> -		sched_ext_clean
> +		sched_ext_clean ynl_clean
>  
>  .PHONY: FORCE
>
> base-commit: 45bd443bfd8697a7da308c16c3e75e2bb353b3d1

