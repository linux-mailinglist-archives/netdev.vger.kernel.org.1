Return-Path: <netdev+bounces-75062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83B86807C
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001E429153A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 19:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E8812FF71;
	Mon, 26 Feb 2024 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B3XZR+6t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83913540C
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974255; cv=none; b=lFLt80FhiC2rdfz7J9cagMYlh/Eqv6HzEZMLeRTdtL3bZYmiVyzhlTXpO1qYUQ+JaWtCrVTX6y1cBgNzDUjIBGBoUj8C4gG8LtGlpES7en2rGpMomzxOeEvAepKdLO8KGADYrfC+yfJaCmJ2xjOovbUKhB+kfzq74QgQWmmbTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974255; c=relaxed/simple;
	bh=JIqIxUB3Ayzkf/mD0blka6O8DKfFWgrE9WEYSScIHy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTfRAS3+rHtTuMZjUIaOhiHSsMFpRR9pO5yRlwX0y7xfpgwsy4u1xekBGBCySvhwN8zZudY/E/V5WbWFM3W4ZWR0sVOjEhy2hcmQoIdI7wHHJBAcYtL6FZqd4A05pjvkYU4zRLx3RGcFym2wfYc2UPljohs/FhhxdVjFU7cl7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B3XZR+6t; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc5d0162bcso29022255ad.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708974253; x=1709579053; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rqEaslcv+csbSpF6YQBGR7kuM3sWH8YoMpbM5vrlm2I=;
        b=B3XZR+6tYaiLmvO0ormzojOJS7q2VNS3VFHyapT0mYeCoLK0DxsW42E/Fyoss/kqcp
         mLiKMAOlbl9wyTCPu5nS79QgEgum9zDXpFi3SNMTipdU+yE37Q/xZySU6Z2PWb7019Hi
         5m35Vb5iqfIONp2TiVTpVr5BtosabOcNFViMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708974253; x=1709579053;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqEaslcv+csbSpF6YQBGR7kuM3sWH8YoMpbM5vrlm2I=;
        b=UwiRiNMiVJvem196t5GvdvdJpDfF/QsXaRs+N/8fw0JOoSOYLjP4Q33klUNoBeie4q
         uQky27Q2pWkw8QuU8sno/xrAEXScjOFUZ2osumJEjSagODSartzHft0qJsdk8J1t2geU
         9Ia3yipKJxSLLWz4HyItLjuq4Ya+7UGiBAekYwq/tzamNAARTkIitWGz+vWfYBImiIxw
         FlwiCTY6ZUVKyDoFe5VUU0W667WpYvkl8f7E+03JazGOovUsVIPAY60G1bLWi6oyEYtz
         KcBbbrsiyJX9fzsKmS4dFbYy2M0nlGd89RQ6r486WKfPByz9wsT/EEodKTUsT9sx8Zco
         xpug==
X-Forwarded-Encrypted: i=1; AJvYcCV/WXeMdiZN5E41IMqErNiqgIQ4xRDQQoWZKrO9Gx92GvwVN1NPmRvM3MdXk+utfk7Kx0PH583OQuqaHTydg0y/ji6xTReA
X-Gm-Message-State: AOJu0YwCLuRkS20uWMP515L6N1oJAC3IvmqtqI5lxa4PJQsU8vY9HeIe
	UUAt9yLSHoorrLimgoX4osfN0+6maOGvNVIeNY/SPKNqNxBSuznM2HzLJYUWEQ==
X-Google-Smtp-Source: AGHT+IGFFetjjHPW/ivkyZlW9eIrIhfwZbvoWRltu7/bfVEDnv3KZmmFg2wZd+UfH3HTAx1gx80+dA==
X-Received: by 2002:a17:902:d2cc:b0:1d9:7095:7e3c with SMTP id n12-20020a170902d2cc00b001d970957e3cmr8949703plc.57.1708974253283;
        Mon, 26 Feb 2024 11:04:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902b28600b001d8aadaa7easm31822plr.96.2024.02.26.11.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:04:12 -0800 (PST)
Date: Mon, 26 Feb 2024 11:04:12 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	davem@davemloft.net,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>, edumazet@google.com,
	jakub@cloudflare.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/harness: Merge TEST_F_FORK() into TEST_F()
Message-ID: <202402261102.3BE03F08DF@keescook>
References: <20240223160259.22c61d1e@kernel.org>
 <20240226162335.3532920-1-mic@digikod.net>
 <20240226162335.3532920-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226162335.3532920-3-mic@digikod.net>

On Mon, Feb 26, 2024 at 05:23:35PM +0100, Mickaël Salaün wrote:
> Remplace Landlock-specific TEST_F_FORK() with an improved TEST_F() which
> brings four related changes:
> 
> Run TEST_F()'s tests in a grandchild process to make it possible to
> drop privileges and delegate teardown to the parent.
> 
> Compared to TEST_F_FORK(), simplify handling of the test grandchild
> process thanks to vfork(2), and makes it generic (e.g. no explicit
> conversion between exit code and _metadata).
> 
> Compared to TEST_F_FORK(), run teardown even when tests failed with an
> assert thanks to commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN
> for ASSERT failures").
> 
> Simplify the test harness code by removing the no_print and step fields
> which are not used.  I added this feature just after I made
> kselftest_harness.h more broadly available but this step counter
> remained even though it wasn't needed after all. See commit 369130b63178
> ("selftests: Enhance kselftest_harness.h to print which assert failed").

I'm personally fine dropping the step counter. (I do wonder if that
removal should be split from the grandchild launching.)

> Replace spaces with tabs in one line of __TEST_F_IMPL().
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Will Drewry <wad@chromium.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

One typo below, but otherwise seems good to me:

Reviewed-by: Kees Cook <keescook@chromium.org>


> [...]
>  			_metadata->setup_completed = true; \
> -			fixture_name##_##test_name(_metadata, &self, variant->data); \
> +			/* Use the same _metadata. */ \
> +			child = vfork(); \
> +			if (child == 0) { \
> +				fixture_name##_##test_name(_metadata, &self, variant->data); \
> +				_exit(0); \
> +			} \
> +			if (child < 0) { \
> +				ksft_print_msg("ERROR SPAWNING TEST GANDCHILD\n"); \

typo: GAND -> GRAND

-- 
Kees Cook

