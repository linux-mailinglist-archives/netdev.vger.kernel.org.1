Return-Path: <netdev+bounces-95991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE28C3F4C
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBC91F21F1F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6749F14A4CA;
	Mon, 13 May 2024 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RLo707rc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64A52F9E
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597501; cv=none; b=hfLH9oQamqYl/NRD2LcZsbJ6ulTlR0/wvk5XudEd1OBAm7wdu7hq3dNlZaGEApJBJd1Nr8vkX0ug6UDjBw/vE+ugD//SQixEEZua0F/O4y67b9CIM9RtJyEYsx7CDNsCqngZ8+w4c5ylT6PwDNqhMWBe4Vo1JxV6uULuOHZt/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597501; c=relaxed/simple;
	bh=nyL5cq0qe3o6WCraDnrOSwJrqkbrfXxQhH3LWv4+b4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmcFgVVYl6u7D8yWBkU5xdgnPNceP8ymUB+PjxqVjPhjKPJ0JujfCqmzE6wdLea+HZ1oHWZxSFu7//CuZl8ZHNQ/sib64o43f6JHwEkRVtg7EJ/xDCjQ2Ac1QpE3ajqv8lA0mn1w3xojBuQ7C0gdXy+pQZrccjUPTIWduqI9L1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RLo707rc; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e0b2ddc5d1so59707501fa.3
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 03:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715597497; x=1716202297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyL5cq0qe3o6WCraDnrOSwJrqkbrfXxQhH3LWv4+b4w=;
        b=RLo707rcr70hGgPflutR5GOra73HeeRTrd85x7QhlBxpi1zKqwjsfrFebnRQbAu94e
         jgz0jfWywMVu6hTCQ33VjIWzMo+bOP0qdydGtjVXfGNZBQv+9vy3cWa5no9LW/+GIQX6
         RtODutxRSmcaAxOHRJCP595mPdgzkoGiu2J/wasZTpdJkTmBVMGnyfLWjAEVFzq846QH
         UuL6qcPwiEy9/51TmOXYUglpA1RuMAHCZ6izhhxL+BqOwaGxIcb0Ubo9LY6QFOV0o8wu
         DhRdbNvGTNLgadPeFjMJF6ixwoWAHzZqQTPqRk7HlEKV/Pjj8y2u5N4GVEdbgfwE7jS4
         eSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715597497; x=1716202297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyL5cq0qe3o6WCraDnrOSwJrqkbrfXxQhH3LWv4+b4w=;
        b=JjJtmi3N/J4inIShZ0/4EPoNTWbTuNUTx434NocpTp4TEZtbuTx5TK/kSqCsHjKMKj
         HAlnF8/QIIomGTy1OAnc9Q6uucuHrEimQfKj5+x2MjhUUfn+x+BFPb303k8tG4IhSCW7
         ncWM0j+Ja/WUGlcXnbBUosq03OFmfweXNTp73kGyUQhrKjgeAqblOU9CAgvvOahyO+Ei
         vZwfU3JchXAEzw0d7toGMzRDfTI9gzL8mrkWoPcIc8FNf3nVQNvPqVx/HGlQQVXsAaLj
         rgPFPJFRED30xs8Qpn07WPa0n+sNd4/YpETG64uSPKbuOfFQI5/qfZ+VSWv5mBRhJEvi
         UEkw==
X-Forwarded-Encrypted: i=1; AJvYcCVCn1J41mGrcBBtCV88WkNty7dg+dQlh5/PrZQ2WP3+pXC2HT8e7j5sUA5hCV1QZlIlbFjZXbrIk+1rKTRTSk9yH72M6k90
X-Gm-Message-State: AOJu0YzOyF9KDMIan/maICMyq944E3E3KRMCvyUG2KtyDEgzM2E2xl/0
	tGzLsGmjk9v5gxx3wXfSR+am0wWY5y74xE407RmE2L6T5mzqnx15ZXsgSSnFt10=
X-Google-Smtp-Source: AGHT+IH5b3wM3G/QzQQQQ1D+O7yic92VzTGPaU/uwpXl/w16JmgMhK/QcRk8EE0GdFymayjqLCFQyA==
X-Received: by 2002:a2e:4602:0:b0:2e5:59c5:34e3 with SMTP id 38308e7fff4ca-2e559c535e1mr40734951fa.29.1715597496629;
        Mon, 13 May 2024 03:51:36 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201088fe8csm72571635e9.32.2024.05.13.03.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 03:51:35 -0700 (PDT)
Date: Mon, 13 May 2024 12:51:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
	davem@davemloft.net, jan.glaza@intel.com,
	przemyslaw.kitszel@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpll: fix return value check for kmemdup
Message-ID: <ZkHwtKzNN8jlKMVA@nanopsycho.orion>
References: <20240513032824.2410459-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513032824.2410459-1-nichen@iscas.ac.cn>

Mon, May 13, 2024 at 05:28:24AM CEST, nichen@iscas.ac.cn wrote:
>The return value of kmemdup() is dst->freq_supported, not
>src->freq_supported. Update the check accordingly.
>
>Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
>Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

