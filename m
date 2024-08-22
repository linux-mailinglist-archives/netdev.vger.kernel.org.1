Return-Path: <netdev+bounces-120836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B4695AFA8
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B483B1F226D6
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4880A157A6B;
	Thu, 22 Aug 2024 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcZ+z7Af"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B613A139D1A
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313213; cv=none; b=CzeVrGNzNzE/qbW5X5NGUAan6M0Y5yUyBj2stUD1uGz1dMZxHTy6T86qkMvIgM2m4lHoTWsGf8IEJQ5KffWzBTUkEK3zGHInMbkRrYyuu62zPLC66WsbtWwW0/Xd5ZOF8CWN7NqGXdSPoPbfoVnsg0tbNypNlBRRnIV32jboPyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313213; c=relaxed/simple;
	bh=RaIhx5O9tmpQeHwum71OiEOeHZKulJB0JQw36n+bhk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swG3FJReTg/tk229OIsiY/QUvNTSIfTLiPyz7BLy5Xdx8/atrOwBVETWOQDxa6p8ag7X3hk/MKYOiEpzzSv4NnMRWyA6YkVeqsBAlAWdlYrDjQNF92K3Fi7ZwNkf0aWA5xIfuUk1zQ1Xy5cym7xUEmmGxB11gwHfndzLiScg8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcZ+z7Af; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724313210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qz/tdls6cnOOu3JOwA/hHCLBawPXMSyqfmoIOx3PN+I=;
	b=UcZ+z7AfFIgxoi6a4GhitWDZGd1b7eCdJseyf5VdKrhYtgsZsOxw0pHVqnjwYm86RDdXnh
	vv5SHGzwyz/RO9b8UO6v26hDPoKOHWnXdDhvYBIeLvdx7ANJiR1Qahen/pqA3G60qm/dp9
	w8b7aqOUJdll9NcwcQLMxZGgYB39fJI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-l_n4hpTFN3CfpAqm9b129g-1; Thu, 22 Aug 2024 03:53:26 -0400
X-MC-Unique: l_n4hpTFN3CfpAqm9b129g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42817980766so3693235e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 00:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724313205; x=1724918005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qz/tdls6cnOOu3JOwA/hHCLBawPXMSyqfmoIOx3PN+I=;
        b=qtfb5h/5NtlSppJcxrRuHTuy7EKJbAvHtG65vVyD2Un4wVC8mS5jRM1sU+bzn8aF5K
         Nnjq0YCqeuVX5uJRM0kxaOUz29n3El85zxmuZqbjzrrWDy+rAlfqmb4uneCHnrN+sI/g
         WATDALjXPAi7wp+OH0F9RdOerdIXUgM49bqIId0JPbNMKQDbXqGlxMDPXKbc3VRduL+9
         Yx1eMnghW1bbVH/a+j4Q8cifUtOah5n6K9jKkc+9QXWNWw9KvL7FQhvXifbEQ4QoGl1q
         nE8fatyQbyH/gYEAfW9Yt70MkPM37XF2zulNuJLxUd4XV3QXR0Zi56G8RTh4ArBBu36K
         6EXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKc/OHgYdIayEIr06ZJy6/uGKKCNhdioMbBWzSx+kmSBQx7DCoWAPxdQ3dAJiiNewzYOdnWwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQf/yNJp6Ap82j+AHpJgzi0Ykqoe8kdNmT2A4sMWgJylpTChM
	ULuM5UlevOPwDPO39N6rjAKvxqV6iEwaQKTLY1AMjJSW/zjdxR0n/Unn+1idUTRFGlEWlD+fLBg
	3lyFCZR/OFH8AQyZCERGEXUymxRG3xjVzciMaIxBfHtsAJiTkZR4cCg==
X-Received: by 2002:a05:600c:5844:b0:426:67f0:b4fa with SMTP id 5b1f17b1804b1-42ac8805ff1mr607155e9.1.1724313205253;
        Thu, 22 Aug 2024 00:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9hrOYs2q4f+fjvNcWUy1j3HYdgAupUMULtmjUPxzO2bk4MeOzgLCUihit5Wg+JUg3IrLESg==
X-Received: by 2002:a05:600c:5844:b0:426:67f0:b4fa with SMTP id 5b1f17b1804b1-42ac8805ff1mr606945e9.1.1724313204747;
        Thu, 22 Aug 2024 00:53:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5? ([2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86e9fsm52044295e9.13.2024.08.22.00.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 00:53:24 -0700 (PDT)
Message-ID: <3b1ca110-d1e7-47c5-af31-360a233cb4aa@redhat.com>
Date: Thu, 22 Aug 2024 09:53:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 09/12] testing: net-drv: add basic shaper test
To: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
References: <4cf74f285fa5f07be546cb83ef96775f86aa0dbf.1724165948.git.pabeni@redhat.com>
 <202408220027.kA3pRF6J-lkp@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <202408220027.kA3pRF6J-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/24 18:52, kernel test robot wrote:
> Hi Paolo,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/tools-ynl-lift-an-assumption-about-spec-file-name/20240820-231626
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/4cf74f285fa5f07be546cb83ef96775f86aa0dbf.1724165948.git.pabeni%40redhat.com
> patch subject: [PATCH v4 net-next 09/12] testing: net-drv: add basic shaper test
> config: hexagon-randconfig-r112-20240821 (https://download.01.org/0day-ci/archive/20240822/202408220027.kA3pRF6J-lkp@intel.com/config)
> compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
> reproduce: (https://download.01.org/0day-ci/archive/20240822/202408220027.kA3pRF6J-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408220027.kA3pRF6J-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>>> net/shaper/shaper.c:227:24: sparse: sparse: Using plain integer as NULL pointer

AFAICS this warning comes directly from/is due to the hexgon cmpxchg 
implementation:

#define arch_cmpxchg(ptr, old, new)                             \
({                                                              \
         __typeof__(ptr) __ptr = (ptr);                          \
         __typeof__(*(ptr)) __old = (old);                       \
         __typeof__(*(ptr)) __new = (new);                       \
         __typeof__(*(ptr)) __oldval = 0;                        \
				^^^^^^^ here.

Cheers,

Paolo


