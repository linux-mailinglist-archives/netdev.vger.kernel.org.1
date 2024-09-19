Return-Path: <netdev+bounces-128894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE66497C591
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 10:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E1E1F21D55
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DDA198A30;
	Thu, 19 Sep 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3Ld/OtS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B1C192591
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733429; cv=none; b=VlVN+nzP5Dfc2FzBFrDDGOMk1T4gU0QkuMgL3LlNtVcN2n33lukY4kWMzeZv1nIaUGuFcEolBb3RUxcqZanMfvbL86In7uSZSfGz1dcmpUASSaWyjm1JG73ab+Zw/Fex0TdZ4Nsx6Jq3IAb2OUH/cfz3UQQF0le4N+ykhWdL6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733429; c=relaxed/simple;
	bh=IMr2sDS7aX2NzKbeHBTrELWlyEAyJZIdbUt1cIwyPF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeXZQMgT8OLhYnNy6+ynYex1buyn3T3d42BeKvd0OH7lulp3HoRtbZQ8q7Zi3wRGfhuMPzFymuxEdFoK1qKGQlWcBNFOZwuDBdSIYh9Ce0qtnH1QKOnooCTMoDPmHJ6xhJV2g+qdq8Bb/PhQwXAA8JHHI84eLU8YEmu8xFxrGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3Ld/OtS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726733427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOfIv+eOnxovUFA0Wsmzc627m/UT75AgIdbcTXT1OWo=;
	b=O3Ld/OtStTik1LuYxCLS05n6T417zGb+ZYvEGXKUB4hrOopE/2E658aB0TtzMZMP+MIV9d
	rYw51VDa0q3/dQ/AlaeaGpritwVncEE0p9veUZvmRRbix+GtHn9lKpeGphwps+coFnyTE+
	6CW5kEQeGhZiVwcxlpcuqGuf0OPhIbc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-ohYLuhalOc67Ui2Rok1sQg-1; Thu, 19 Sep 2024 04:10:26 -0400
X-MC-Unique: ohYLuhalOc67Ui2Rok1sQg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb6dc3365so3869885e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 01:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733424; x=1727338224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOfIv+eOnxovUFA0Wsmzc627m/UT75AgIdbcTXT1OWo=;
        b=Pa6xSiJdG+B3Gc7AXGRrCCajFZsz1Fj4LLAQJ+BZO52EIPuT0J9e8Jfb31MLlse5uP
         4qd7Yl2EB5YTKG6tNiBZ45t8MK997cQw798PKWlg3Gb60/f1jfRho5fhIBqc2sA+6jtw
         kG8xSio/BAn19bzgnOiBpc/7jizInXgqu2nbjD65ORo0Qhun2vnnZfpMNe3yC4552mvQ
         n6CoPgi2LDOskx/2QghQudyCsItSJlT4CLTNvREehpsZkm6ZOyLo/BDD4tWjn4TirvnN
         0K4AxffCaKhzSOQ5tR3vrb9YYj8NExvTFBwP7K2sWsSEcoltJpUHq2ZP1AlAkHLlnp+s
         cMpA==
X-Gm-Message-State: AOJu0Yz5RBdNIIHpBe+MzMPgTToj2CyX9XLyznJzDuJAgpykW1xACJwH
	sZyTkRUn9Ytwz/XmooxqjUiqwLdxRzrJDa7qflwDjbuIBJ8+ryZ1JhJO2xtrPvy7XA4+DKJGI0E
	SQjUpzN3WW3/WWw8gMllmzz0eAvWXdWYOlt+CI01M3HXZAK7muw5lqKfHXgQDfuxMxCA=
X-Received: by 2002:a05:600c:4f82:b0:42c:b1ee:4b04 with SMTP id 5b1f17b1804b1-42cdb586defmr203453125e9.28.1726733424217;
        Thu, 19 Sep 2024 01:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGT0SwgVzRIkY/MUx4n23L9SMHSHNhM8DLpk/EIjcBzZveCWuxQ4pMW0o7cv6mXWtvyMK74A==
X-Received: by 2002:a05:600c:4f82:b0:42c:b1ee:4b04 with SMTP id 5b1f17b1804b1-42cdb586defmr203452865e9.28.1726733423826;
        Thu, 19 Sep 2024 01:10:23 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75408abasm15477015e9.6.2024.09.19.01.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:10:23 -0700 (PDT)
Message-ID: <a2462a8d-97b1-4494-8bc4-c5a09eee7d1b@redhat.com>
Date: Thu, 19 Sep 2024 10:10:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 V4] selftests: net: improve missing modules error
 message
To: David Hunter <david.hunter.linux@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240914160007.62418-1-david.hunter.linux@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240914160007.62418-1-david.hunter.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/14/24 18:00, David Hunter wrote:
> The error message describing the required modules is inaccurate.
> Currently, only  "SKIP: Need act_mirred module" is printed when any of
> the modules are missing. As a result, users might only include that
> module; however, three modules are required.
> 
> Fix the error message to show any/all modules needed for the script file
> to properly execute.
> 
> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Sept 30th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


