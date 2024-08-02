Return-Path: <netdev+bounces-115319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DF4945D39
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C8D1C20C88
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66461E2118;
	Fri,  2 Aug 2024 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="O/pGx1kP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501C1E2105
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597828; cv=none; b=fNYnqpMtM5Pe0Ichf/u8l1SWOaXNsUj9KbkOYFnCk0bISflr6zNZQS7IC+zASxFAeCb0mPRuNuNu6nitaG2+TvHH9ikHW0zKkY8jJ+HUIDFp4y1wfHUU38KC/g7WBKQ+OVT63nEEwzNV4PIcMneNriT1xrYehKXmZzKQjDtAqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597828; c=relaxed/simple;
	bh=Uk5QlZ/o+Y1LgMCy1yQr9gNrxEU9ASYAUhhbHpBCN60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0YE/idxBuFt26UHPMs/AEk7e4OxLVvWIhWlBQvhpDB/9jalkofJNT4hzPFfbF1s9/QWwtSqI+eP5fddF17Ec632GXGOzw9/IQtE9bzkAWHFPeDPVqQzRcXeZBfgs4LIM2u2CsumPVLDH9F4W54LmTDmzhNtR1L+7PwEd5cSjOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=O/pGx1kP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso58623165e9.3
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722597825; x=1723202625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOdNo47Fhx4KRjytkczL/7XqSaQmLUQjrAhWJDoAzcs=;
        b=O/pGx1kPizaLipDXZ8JMk/MkRAasmTQ8VJBHUoxY9I9sSmNHMdO2BQrAV42xV7DDb9
         QO4oVaaG9NzyWWjp021pAhPPH23wWvWU7wBxu1iCIAd6v8IVFUORPm1VoYdiremfIKYV
         7BKVc0ccDZE4TvrMb+hns1fYmAwRLbY+CRj8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722597825; x=1723202625;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOdNo47Fhx4KRjytkczL/7XqSaQmLUQjrAhWJDoAzcs=;
        b=bKv6YfW1fl0bSg1VPR+WQyhIY0XOhI0rfxLxaz6Fw4V8ZyBpzEc9D6AG9rPj9ZCRAX
         ZlBzzqh4X5fVPYAOVAzyBPMqrTJbDxNAEMMJZkU7trQW8O5Iuug5gIdG0XcKme8s6RKm
         x/Ud5aHdIPq4bkQoNphtYJWddRi1rpNMcqIJV9b4sQaXKKI5G3uhOABiO+xM8Lk3t26d
         6kmbyKNxfY3KsInXUSvpvl2EmFBkJFLKunALIHErQeLa3YBmKO+QZMpaezAset7tZT7I
         o2KRumXPtfZxH/IUEUdjM+rRzXeKfgHRMLrAExq78p9GGAQ7ee1NIbsJTbLiBz2Nzw6M
         83/A==
X-Forwarded-Encrypted: i=1; AJvYcCUD9S6kVMM2tacWBB/OXnlIaw0+/cHCof9GM/5Anhh0KuE396U+NNk/BmThAqzHX8aT6ZabFZaRJJqEr1E/piqqqBejWTJT
X-Gm-Message-State: AOJu0YzC8jUwN+eKvPg0lcDsPd7uzNfOKFc7CdnRJyaeGn3ocB28sHc0
	z6uT2Kw1DBtzXsou5gMbCSo+5bmUnyrHS5kh0y47D4qyM1o8g96Ns8O/9H4t1dw=
X-Google-Smtp-Source: AGHT+IEIKL9J9Rlk0ZXwhk+Crvyi5orv00/0yWHgsd0s5nSQA6xxO90I+TOR4qGrOGwtS+FmnE9e2w==
X-Received: by 2002:a05:600c:46d5:b0:428:e820:37b6 with SMTP id 5b1f17b1804b1-428e8203ceamr18747765e9.31.1722597824965;
        Fri, 02 Aug 2024 04:23:44 -0700 (PDT)
Received: from LQ3V64L9R2 ([62.30.8.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8adc7dsm90595485e9.14.2024.08.02.04.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:23:44 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:23:41 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
	gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 01/12] selftests: drv-net: rss_ctx: add
 identifier to traffic comments
Message-ID: <ZqzBvTmsmhPoLb_f@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
References: <20240802001801.565176-1-kuba@kernel.org>
 <20240802001801.565176-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802001801.565176-2-kuba@kernel.org>

On Thu, Aug 01, 2024 at 05:17:50PM -0700, Jakub Kicinski wrote:
> Include the "name" of the context in the comment for traffic
> checks. Makes it easier to reason about which context failed
> when we loop over 32 contexts (it may matter if we failed in
> first vs last, for example).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/rss_ctx.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> index 011508ca604b..1da6b214f4fe 100755
> --- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> +++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> @@ -90,10 +90,10 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
>      ksft_ge(directed, 20000, f"traffic on {name}: " + str(cnts))
>      if params.get('noise'):
>          ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
> -                "traffic on other queues:" + str(cnts))
> +                f"traffic on other queues ({name})':" + str(cnts))
>      if params.get('empty'):
>          ksft_eq(sum(cnts[i] for i in params['empty']), 0,
> -                "traffic on inactive queues: " + str(cnts))
> +                f"traffic on inactive queues ({name}): " + str(cnts))
>  
>  
>  def test_rss_key_indir(cfg):

Reviewed-by: Joe Damato <jdamato@fastly.com>

