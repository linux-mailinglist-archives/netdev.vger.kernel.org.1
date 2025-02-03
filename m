Return-Path: <netdev+bounces-162248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7CFA26565
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12513A030F
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C006920F094;
	Mon,  3 Feb 2025 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="cPAP32Ff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC0520E71F
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738617123; cv=none; b=L9ew7QMlbz/Ui1L97F3TP5KMq0A3U4ABaGXXAlXMEKRun/srUzlJUZ/CkMTb3h2ZAE3G3BNc+Zu02AYhPn635uB2G0JXj/SOPHDC1rI13hZietKAPAfHGn5b5Dl1cRcDxwDjp2wOJWCcx56P4ntBorSJMVZDLIYqGpHMUL1ksUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738617123; c=relaxed/simple;
	bh=11Nvk3hzjdb/w1e/puQKMDia0KfRczpUGK8DoIy2fhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0CRR2ypXlb2b0YxmK8H2bhuIyd69fuQIhA+6AFj2kG8ZcT1mxrCZMcIpnu2RrnELNylcKDbnhk5yg/50K82eDAQiOeXFrCyZd77oINmCZUBQ/LJt6M8z4sciXhfzd7QQTpnl2fbHVg+njIEocVmc3hyKsCdyXM5h8F0c/CKFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=cPAP32Ff; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21654fdd5daso84369125ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 13:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738617121; x=1739221921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igz1MzdVVMR+l9aG8qa3bIUBvAjHant1VpILPp28EC0=;
        b=cPAP32Fff3/TtP2lqffQbywX9cZmtesJEZmAlV/ooPYYsP/AiNe14fcf+B1djq5fzE
         PSrIbBbqIl2hFqeuXvwoSzK6+H65GRX8oxInD5F7sLflDajWtd5IxVFpLDmwkQbp+9OJ
         xyuMtexPS7A+RdAoBqEuNWleyU438v7bDsw14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738617121; x=1739221921;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igz1MzdVVMR+l9aG8qa3bIUBvAjHant1VpILPp28EC0=;
        b=urgNVw2YHvWI+xC9Fala+DcaPSXgGIPjDo8vvETRG+AvmYqxp5QEdDsOac046kEnmL
         hM4+s6yTGW04U/II80NCSVpTaSNpda4OjVKhnzr8lw3we1G3ixnhPQzJVt2cg5patiyQ
         cdntu5+3/w9VlxGrEmBgOsCSFMoLQbb3RtfHyVTX2RjZpmESK91Ej4ZwMCVnRYVtttep
         fj31ZAdEJN5pGLxtEDh5n69b4ZNToce3XOSvNWPrWtcTGvB81oVBZRqh+yPamSjLEt7q
         919bAk40F60P4kI7lkWdzYv6thUfSBMxZFjR9zCmVbNnnj+RJBgtMKHMFEvudusx7K/7
         QkiA==
X-Forwarded-Encrypted: i=1; AJvYcCW39tGezHOFxB8sSXX6Z6h0KfrdxxUuHxHyZlmGG/wC5p4J8TR10NBsNBjubK9UhxWSANQ4lN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNB3rxN1KtWJxHHbmXOzwoDXLzIPLXlCliJbmQzGun0zoqOOos
	j81udzroU6WjPS/Ktqic0fVpDbsCo5jb+CvM8ePBMLcpdHdNbgZ5isRXR9kbf3s=
X-Gm-Gg: ASbGnctyEP+NMx6C1htpWFvfOtjG5Py7RXd7gAnCjv25LZEdZ70YTR7fbot0WDlnHoq
	aPS2p1qD+MargVxb9cPhW0zYcaH9TIBjYU4n6WK9vO/NRtX1cPxbryynI81iYHQd2YYHQNiH/KH
	mzt5vyofp+jPN74/006lk0sUw0uuqtXsd+9mchYOLfnG11nLAMMqYZgU6oG7TRsOkzsm2j0Jd+X
	EZ21VRxyG0kbb3Aj26ulaHgHMGLqWXXdtZvWIuxexklhuJQw4pYBr1k6RhJBcY0arFq+as1P+KR
	BTpzLh3P3N6KGX+5qSFbO7rZF7CRKBd/fsvbGzoje3ItN6u5Dd8eQGGFsQ==
X-Google-Smtp-Source: AGHT+IHTUIocV6m3/NShsiLwSktbHiacpGHhtqsjuScTZ6E7PZnEMmn5ToFCIXiNMog1aAjyYCC4uw==
X-Received: by 2002:a05:6a21:516:b0:1e1:9f57:eab4 with SMTP id adf61e73a8af0-1ed7a5f9036mr37881795637.16.1738617121136;
        Mon, 03 Feb 2025 13:12:01 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ceb1csm8771404b3a.151.2025.02.03.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 13:12:00 -0800 (PST)
Date: Mon, 3 Feb 2025 13:11:58 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, ecree.xilinx@gmail.com, gal@nvidia.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net 1/4] ethtool: rss: fix hiding unsupported fields in
 dumps
Message-ID: <Z6ExHoXv2dR_Cu0a@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	ecree.xilinx@gmail.com, gal@nvidia.com,
	przemyslaw.kitszel@intel.com
References: <20250201013040.725123-1-kuba@kernel.org>
 <20250201013040.725123-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201013040.725123-2-kuba@kernel.org>

On Fri, Jan 31, 2025 at 05:30:37PM -0800, Jakub Kicinski wrote:
> Commit ec6e57beaf8b ("ethtool: rss: don't report key if device
> doesn't support it") intended to stop reporting key fields for
> additional rss contexts if device has a global hashing key.
> 
> Later we added dump support and the filtering wasn't properly
> added there. So we end up reporting the key fields in dumps
> but not in dos:
> 
>   # ./pyynl/cli.py --spec netlink/specs/ethtool.yaml --do rss-get \
> 		--json '{"header": {"dev-index":2}, "context": 1 }'
>   {
>      "header": { ... },
>      "context": 1,
>      "indir": [0, 1, 2, 3, ...]]
>   }
> 
>   # ./pyynl/cli.py --spec netlink/specs/ethtool.yaml --dump rss-get
>   [
>      ... snip context 0 ...
>      { "header": { ... },
>        "context": 1,
>        "indir": [0, 1, 2, 3, ...],
>  ->    "input_xfrm": 255,
>  ->    "hfunc": 1,
>  ->    "hkey": "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
>      }
>   ]
> 
> Hide these fields correctly.
> 
> The drivers/net/hw/rss_ctx.py selftest catches this when run on
> a device with single key, already:
> 
>   # Check| At /root/./ksft-net-drv/drivers/net/hw/rss_ctx.py, line 381, in test_rss_context_dump:
>   # Check|     ksft_ne(set(data.get('hkey', [1])), {0}, "key is all zero")
>   # Check failed {0} == {0} key is all zero
>   not ok 8 rss_ctx.test_rss_context_dump
> 
> Fixes: f6122900f4e2 ("ethtool: rss: support dumping RSS contexts")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/ethtool/rss.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

