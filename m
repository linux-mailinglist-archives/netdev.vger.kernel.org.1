Return-Path: <netdev+bounces-99487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA678D509D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E921F21DD5
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B94436A;
	Thu, 30 May 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMV1UhCL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE94653C;
	Thu, 30 May 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089076; cv=none; b=bR+Zr0e7Zo8gRtq3bkkqWgY19QBbt8eENnOYZIDkqVy75pZCyaeIKz0IkHBqoR+qslLXjTEaCuAGQrAGHTH2Zg+otC0JyGFNIUvjcT4DaHA8V9SaSNK1BQg8+7X72431Q6x2xW3rsfHCPGE5O/sIaQ+GiCuvfpRZhb9O8ghJ/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089076; c=relaxed/simple;
	bh=w1P9GtWTZiHFljha6+hHxilF9/Ml0j8wVOwBBGlUVKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNu+bgo4MCselEaJDzQO4m8v62Yr2W/5wPMFQDMxqa1GqjFDxw4HS1DpDtoC3O8E/Wx3XXTNDWKgMvhATvP9Ocah6EvfoveH9B/3Xw/7j0dk8uNwiQTQhJff6VH8Z61TwF6GSpQd98p8jneQJF2VCzDC947KGWDmhURmYKkTC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMV1UhCL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f61f775738so6362865ad.2;
        Thu, 30 May 2024 10:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717089074; x=1717693874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b5dMIK+YmRjKcd+w3hKSLG4KLhKC/IhFM8M8zHEuCAE=;
        b=hMV1UhCLwlKxQjhs6r8tmhQMgu61oo8J5jwJFpDBAlq3ec9zZsrynG+aYyHTEQZbXn
         KIG42d8cQLeBKwqPBK5pTiCMegaiysg5zgiVC3IW7cqQR8Hc2yLDgCgPzJ9pWlq0eEri
         jxGS42BTCR3unVO5qyime7FKXurFSTUM6RQtb3KuSCQZN8lf+3sNN4zGxKoqK3KiCnjq
         u4nfj0K4xpbtBlLG6NLpT/k/VZ1ZAVeJx5VqVRBK/wdQ+YoOllW085K3QQq6BRu8oyT5
         f37NnnHNAzFDD+71I49hkzMcVP1TrhR0cSbo0A32OEyaX9Avwp0j9SX4mOWZG0k7zk8P
         MlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717089074; x=1717693874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5dMIK+YmRjKcd+w3hKSLG4KLhKC/IhFM8M8zHEuCAE=;
        b=AVhcHGnaDEu05WxJHV6xTh2FFTljODLqOaYhFn5zQtFqeD722JXF4zZkkgF01xDpGC
         XEldUxksEaFSlyRHN4Hij+1NRVlLDyuXAHwLMHomD5TboI7ypUPyrp1bErZwQjyw8YA6
         6lu0S9sRw8tXo4lAGcGuKnX9kCgDHKuOlWSq2PkI5DrGcQHX+nWpf6VuKDueAJUvZACC
         zUUEFIxONrfxt48Aq+aBKZrmcGmKPBVA0G7yfLLPLaMh69/VL8jf4+CHfsZFPkwEeO0R
         WiKnoD4ji0dt/LOy+NckHoE89m515q0L80Hw85V8hdzr729CbGGL/k3JXnky7lVmGx84
         3gtw==
X-Forwarded-Encrypted: i=1; AJvYcCXgoYfDCGX7YthnArIzmCDwcPDl2MGVok6fM30fxa7co+GXFEzxvbueWtqFxBBWAW8x56498JAqCCjJ9SZ8KhvjsriMuL06Pd6HCENyUOg6bKF63aG9EtSazG5FdBC9o5MHmvno
X-Gm-Message-State: AOJu0YzIuv536NXXANqPIHFQo1sR8wRa27TRdlzFk4oyjhFn+w21IGR5
	dBhGSwdBoIhGfNIa4eEjubiOr07IWE5HGl7wKy/xr/6uc+BTed3a
X-Google-Smtp-Source: AGHT+IEBj73siAJfZoLiX9gqpPn+nv1DxMqUBBrc8uKp//jC475DsqApjM9Y16BLcPTu9eoocFrNUA==
X-Received: by 2002:a17:902:c7d2:b0:1f3:a14:5203 with SMTP id d9443c01a7336-1f61962bd45mr20087525ad.38.1717089074324;
        Thu, 30 May 2024 10:11:14 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd824sm203895ad.128.2024.05.30.10.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 10:11:13 -0700 (PDT)
Date: Thu, 30 May 2024 10:11:11 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 13/21] bitmap: make bitmap_{get,set}_value8()
 use bitmap_{read,write}()
Message-ID: <ZlizL6d1_ePq-eKs@yury-ThinkPad>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <20240327152358.2368467-14-aleksander.lobakin@intel.com>
 <5a18f5ac-4e9a-4baf-b720-98eac7b6792f@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a18f5ac-4e9a-4baf-b720-98eac7b6792f@arm.com>

On Wed, May 29, 2024 at 04:12:25PM +0100, Robin Murphy wrote:
> Hi Alexander,
> 
> On 27/03/2024 3:23 pm, Alexander Lobakin wrote:
> > Now that we have generic bitmap_read() and bitmap_write(), which are
> > inline and try to take care of non-bound-crossing and aligned cases
> > to keep them optimized, collapse bitmap_{get,set}_value8() into
> > simple wrappers around the former ones.
> > bloat-o-meter shows no difference in vmlinux and -2 bytes for
> > gpio-pca953x.ko, which says the optimization didn't suffer due to
> > that change. The converted helpers have the value width embedded
> > and always compile-time constant and that helps a lot.
> 
> This change appears to have introduced a build failure for me on arm64
> (with GCC 9.4.0 from Ubuntu 20.04.02) - reverting b44759705f7d makes
> these errors go away again:
> 
> In file included from drivers/gpio/gpio-pca953x.c:12:
> drivers/gpio/gpio-pca953x.c: In function ‘pca953x_probe’:
> ./include/linux/bitmap.h:799:17: error: array subscript [1, 1024] is outside array bounds of ‘long unsigned int[1]’ [-Werror=array-bounds]
>   799 |  map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
>       |                 ^~
> In file included from ./include/linux/atomic.h:5,
>                  from drivers/gpio/gpio-pca953x.c:11:
> drivers/gpio/gpio-pca953x.c:1015:17: note: while referencing ‘val’
>  1015 |  DECLARE_BITMAP(val, MAX_LINE);
>       |                 ^~~
> ./include/linux/types.h:11:16: note: in definition of macro ‘DECLARE_BITMAP’
>    11 |  unsigned long name[BITS_TO_LONGS(bits)]
>       |                ^~~~
> In file included from drivers/gpio/gpio-pca953x.c:12:
> ./include/linux/bitmap.h:800:17: error: array subscript [1, 1024] is outside array bounds of ‘long unsigned int[1]’ [-Werror=array-bounds]
>   800 |  map[index + 1] |= (value >> space);
>       |  ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/atomic.h:5,
>                  from drivers/gpio/gpio-pca953x.c:11:
> drivers/gpio/gpio-pca953x.c:1015:17: note: while referencing ‘val’
>  1015 |  DECLARE_BITMAP(val, MAX_LINE);
>       |                 ^~~
> ./include/linux/types.h:11:16: note: in definition of macro ‘DECLARE_BITMAP’
>    11 |  unsigned long name[BITS_TO_LONGS(bits)]
>       |                ^~~~
> 
> I've not dug further since I don't have any interest in the pca953x
> driver - it just happened to be enabled in my config, so for now I've
> turned it off. However I couldn't obviously see any other reports of
> this, so here it is.

It's a compiler false-positive. The straightforward fix is to disable the warning
For gcc9+, and it's in Andrew Morton's tree alrady. but there's some discussion 
ongoing on how it should be mitigated properlu:

https://lore.kernel.org/all/0ab2702f-8245-4f02-beb7-dcc7d79d5416@app.fastmail.com/T/

Thanks,
YUry

