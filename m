Return-Path: <netdev+bounces-93076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8ED8B9F14
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADEC1F23768
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EC115E80E;
	Thu,  2 May 2024 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Cy6OGxhJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C015CD67
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669076; cv=none; b=gXcGsD/0+Lxsy3nxeASWgS+Zc6H8mO6pXgXGYDIhCofeN/ZU3bw6oueJmK8u1iPFM0EbJyEUYJyMnnyH0cG/ze7vTdWX0XN+RIei++JmjQCjmYNpZ3jGDJMpkJA7ChIEfOKk3+Jo7jwS4fV0NzS+yufAThnOHlEIyHsTvrc+jMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669076; c=relaxed/simple;
	bh=ydYmE9K6fN62hXvgfe1ng3MEZlIUiq6jNerHCTwmRgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqYDH0qDr2yzG5DKf4+p1TWr56npskfq4XVMMdZzM0kGbSsH0vz22+S0qCZTAXzquAEVb7OLY3Hl0vse6XefwIETpOAGcBuVyaoWot76yMGvBqKIYhIx43XC75jXynEaAxmQ/Oss/KigytK3TlHHojPgw56Dr2ETeqxTSiQMu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Cy6OGxhJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso40051385e9.3
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714669072; x=1715273872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qWxJ3pzDUTp/0WbBmFNqHX87fVAcfBpz2ZIjTjgDpsQ=;
        b=Cy6OGxhJDcwPawoSIa9e7/517hIQQJiyF7sE1AN3V8uaSr75SaWriu9epQgIuKws3Q
         IUCwu/48qgyTHWn5IVItdev4QYxMow1G25PZQrnaA27+HJnPPpIQOV/qhxwUrfr+uLmy
         NSLbAeLSVOpW6evLEbCp+3SjDXKAJWK1zxdxpMCuTuidMvqLrFL2cvMbYi9GpZy+5Dua
         uRecVBQavduIfWkUx4DOxnBA/WDtzVsTeYJXXen+PfP74UVdMoRAzx6AmyDdpEetAQBA
         n5oSYj2X833jVO5NlLIT1zlx+drzWmsIqYnaogKxQocuUTCteB8ROp6TXgQtbk5T9VNF
         HXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714669072; x=1715273872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWxJ3pzDUTp/0WbBmFNqHX87fVAcfBpz2ZIjTjgDpsQ=;
        b=mSIyjYf7vq5vCaf7F6auor6yT9RTFfvZVhFDT62QuNov1wTOSPHPzwC23UMNgDnpv5
         702f2wd1Bot7Y/lvEtSSBzlOV0ip5QMH5lbWriuXsdpUSDmN/L1/H6X9dQ+sIgZJmvIt
         B76yCoSlB2CTHrRP8QaExdiv9Ekb/vbIOg5M5VNnJUYIAR1BHJxjRbdTMsTZh5kt80h6
         NQV8kcq9ZQ0CU+v013hxXemZgGr6rkLaLOecon3Fvry/2E2wwr2mmsPD1C51cVowCfz9
         3pAFrnZwg1ajPbm0B0cAp1cCo/MaeN9igJ2QlMftSY+zDQ0sJJ8ZL7zkGFskYrZ6qkE4
         42GA==
X-Forwarded-Encrypted: i=1; AJvYcCVYMLgKgA41wF2pmn2x3ZndQd5Bic1AP3CJh1jhc/p+s7aNspZp3C57eBJeOaCB1PCg3BwGdV1ZKT5VsrrmKKvLnMykhrtA
X-Gm-Message-State: AOJu0YxO2rGtyUJirUxr9PN1uDpPkc2lSiYnSFYsHi8MHiOfQifO0kUl
	ol/H4IH4Is9w3P6CSEBe766Y8PI3SbrdwisS+WNhVVClQMLo0Kywg5dxdnDbCkw=
X-Google-Smtp-Source: AGHT+IHbP35CSdOpF9RfJAHKAKM6VXcYNXABFRukm2sgAdxnsksZgxomd1inU141os/Rw/FaHOjW+A==
X-Received: by 2002:a05:600c:1c2a:b0:41c:503:9ae4 with SMTP id j42-20020a05600c1c2a00b0041c05039ae4mr270345wms.25.1714669071475;
        Thu, 02 May 2024 09:57:51 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4d01000000b0034dfa33e8d1sm1666151wrt.52.2024.05.02.09.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 09:57:50 -0700 (PDT)
Date: Thu, 2 May 2024 18:57:46 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com,
	alessandromarcolini99@gmail.com
Subject: Re: [PATCH net-next] tools: ynl: add --list-ops and --list-msgs to
 CLI
Message-ID: <ZjPGCrqDQHW-n1Gi@nanopsycho.orion>
References: <20240502164043.2130184-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502164043.2130184-1-kuba@kernel.org>

Thu, May 02, 2024 at 06:40:43PM CEST, kuba@kernel.org wrote:
>I often forget the exact naming of ops and have to look at
>the spec to find it. Add support for listing the operations:
>
>  $ ./cli.py --spec .../netdev.yaml --list-ops
>  dev-get  [ do, dump ]
>  page-pool-get  [ do, dump ]
>  page-pool-stats-get  [ do, dump ]
>  queue-get  [ do, dump ]
>  napi-get  [ do, dump ]
>  qstats-get  [ dump ]
>
>For completeness also support listing all ops (including
>notifications:
>
>  # ./cli.py --spec .../netdev.yaml --list-msgs
>  dev-get  [ dump, do ]
>  dev-add-ntf  [ notify ]
>  dev-del-ntf  [ notify ]
>  dev-change-ntf  [ notify ]
>  page-pool-get  [ dump, do ]
>  page-pool-add-ntf  [ notify ]
>  page-pool-del-ntf  [ notify ]
>  page-pool-change-ntf  [ notify ]
>  page-pool-stats-get  [ dump, do ]
>  queue-get  [ dump, do ]
>  napi-get  [ dump, do ]
>  qstats-get  [ dump ]
>
>Use double space after the name for slightly easier to read
>output.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Had that on my todo list :) Thanks!

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

