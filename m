Return-Path: <netdev+bounces-74706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE45A8624FF
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 13:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BA31F222BB
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861213EA86;
	Sat, 24 Feb 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qu8jJCux"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047523CE
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708778632; cv=none; b=eEj3FWsjsHAYBSqmUpVMiiQH9pLhEB887ktGTwQ7oHDBpHabqfIM13ZHZ0juEOLRUqM1NGyktmoQIursGu7YRjWOAIbSyd4cNJuAM2rI7sAUBUPlX25OszI7LuiYEICMbFQ8pLe4epYx4mzWqrIm29m9+3Hv/20hXfNhgAlhlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708778632; c=relaxed/simple;
	bh=8uoHp4cPtslag23AL7LccV7ZPuOol9x3dXQ2dAd6Gzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqcFbzhADaJfFIgrYW+g4iVR9lFhdCVgm2t7rAAFoST6xcMMqUxAgthhCXAmInkVgztWFDlDRuBRgwpqH/V+KwO3kOTFUS1xEmUDMK/nuLTnGuoUB7CLA7XBonZKPNIsH1bZAIKwJqVcpeWO3eW8XX84qwy/2sDJPhxFIcit4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qu8jJCux; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4129e842463so1543945e9.3
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 04:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708778628; x=1709383428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8uoHp4cPtslag23AL7LccV7ZPuOol9x3dXQ2dAd6Gzc=;
        b=qu8jJCuxD5q1IH/aqBRHKWL3ki8TK8KhO8HjNlURs4ITnOEgPrJqV8CW3UGmc55hDf
         STURzWQE30qiEnVC0VUJ33IqEHN436bIuCjkKKtZD1QApnz7pzglL+f726Qn6h0fKKHA
         FKvTt6xWQotN6/g8w7WVr+bezkb8XvJU4A2Jlk9O3s8YyRLrFDm0rKe1Ig9AiZyfgno+
         A1EHf4ShSG/0q16BM9jRB75uTMpvTS9aPfZFgPr+ujas0qnxYVDeTtjKAHb0L3DbkUZ4
         f3Bu0DHRxn8Vz9Z7ZVYymmpMEBVNbxTa2JXW9RhjAtEKkA2FdUrhz4i5I4WFjt/4TV1W
         TrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708778628; x=1709383428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uoHp4cPtslag23AL7LccV7ZPuOol9x3dXQ2dAd6Gzc=;
        b=iVsZx08ysrJOi97MM6J644jgnHl2bX0dHWPJbv0LMHSb+L2fAk3NjW+iBGbavt3NHF
         GD0wxgsVssY6PaUwDfdc/8mOArGgYuJUjClZp01g4d2jHpJuyASha0oI0EIQ1jtRRbDC
         8ZyZfJWcR1T59IR9cu5HPXznN5P3P/O3dCOWrfS9ECyF3GdL+cH8ZTekKUu4V1YG0BVo
         cfVVzQrJYOvApl3S9FmVGCm2jBT5YcPAz4IT/ZpOZ4B9tRV1isSX/2BuzT06eqwp8W8A
         WpJsqGBebIdAkE2Ukl36ZbZQEtCyuUprHcXdC4YtMUdoCgDxeN5D/to1GjwuuJ2M+1Pj
         toMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjr0JUrdJXPkh12JO1NlE48QoSI4EcAvYVtS/wtw6/nsFjU+ZGSyg+HymauJ/8yaEHcOU2y4ji9U9UIYUdCCdp+SCTCwmV
X-Gm-Message-State: AOJu0YxwT3vQyN4szBQiUJAKt5FVmFtafISb3dyJP4MhGr5YduWVWbi+
	MK7lRFm6b+W/jw1ShQ2o2W6/OzutkdRswUxZ0LZbSP6dyepPkT2D/Dv3L1VV1HM=
X-Google-Smtp-Source: AGHT+IEAKHGJBJDYRuQmsLurrYTpKTVew5RLnBTrf3wkeDw5Wd5w82xiFj4z3U+zUGAEBJa6+8VqsA==
X-Received: by 2002:a05:600c:1c26:b0:412:9008:b252 with SMTP id j38-20020a05600c1c2600b004129008b252mr1506272wms.40.1708778627764;
        Sat, 24 Feb 2024 04:43:47 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id bv15-20020a0560001f0f00b0033d47c6073esm2053757wrb.12.2024.02.24.04.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 04:43:46 -0800 (PST)
Date: Sat, 24 Feb 2024 13:43:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v2 net] dpll: rely on rcu for netdev_dpll_pin()
Message-ID: <ZdnkgctN0wQrQCLR@nanopsycho>
References: <20240223123208.3543319-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223123208.3543319-1-edumazet@google.com>

Fri, Feb 23, 2024 at 01:32:08PM CET, edumazet@google.com wrote:
>This fixes a possible UAF in if_nlmsg_size(),
>which can run without RTNL.
>
>Add rcu protection to "struct dpll_pin"
>
>Move netdev_dpll_pin() from netdevice.h to dpll.h to
>decrease name pollution.
>
>Note: This looks possible to no longer acquire RTNL in
>netdev_dpll_pin_assign() later in net-next.
>
>v2: do not force rcu_read_lock() in rtnl_dpll_pin_size() (Jiri Pirko)
>
>Fixes: 5f1842692880 ("netdev: expose DPLL pin handle for netdevice")
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

