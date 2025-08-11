Return-Path: <netdev+bounces-212665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A57B21993
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809F31902DAB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43DE287244;
	Mon, 11 Aug 2025 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="usiUfNJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053D286D44
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956368; cv=none; b=mhsDGKHltdVFbdp3bx01HXEm6Ftw+RBZZXLW6MY3w/pSF71P3Nd4g/xt4Q/lchYvG07qWhczvbDXWSPTUbO7rPU8xa3ulo1MeH/IO3+6M8ruE0cwVA7CkG42464AKx/BVo7q/AadSHw6vMSXt4l5qFd4IOQwbKTF3opatO4OfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956368; c=relaxed/simple;
	bh=LuLa11RQ9Ak3pIPyVTsNhZVG22TpH49u5jkTJNk34+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpiva457oQWLmNei+5rGKXKdZ8kYoH74yYWA+vSnudfSuoOBFZw6hrYH+7G8+pGjk0ZRRW6aWxi3+uZyM24rFUjCs02/ylnQfQQMKiXyhjuueWoUlgIRciwvJlAzSYQIvtllRpTmq1vV5onZThUxR5ebzIgu8yRRwnsWY62sL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=usiUfNJ3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b422863dda0so3417477a12.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754956366; x=1755561166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLq6I+LvQ/j3G+FK4La2KdnSRJKMLfe2wH5rVFD3G/g=;
        b=usiUfNJ3p0z8hwXvb7aD0ShZEf3T5/U5ygofNM3DpvX5aJ59tvL4m5JBZsDEJuRPmq
         S9uJP7tKrs+Rdba9T0QsJSLJ453RXP5l+2PakoSIEciKxKoer7qE25mDQo7DGUhoVrXh
         IXiYgLskZHsHfSBMIlc57XeJRPb9b8BqBQ08tv9o6nUeX3aIZil99PxLYgxk/PnzdKuU
         GoGhI4LCZa4cZ5GGz5nQoeHnQyTRE0a3wgRTPp80DopiuFHuGcE3abrRk/mUoohdYZh3
         d4U+iBT1urR7N/XYk+pfJb5TFw7rHG2Ya8Evsjn2hQjsbJJ957zaLfaY29MLOa+bOR+x
         MFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754956366; x=1755561166;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLq6I+LvQ/j3G+FK4La2KdnSRJKMLfe2wH5rVFD3G/g=;
        b=fdtqtxG/vB207FTu/7HONonV/kx+dSqjAfTIoV0BCDp56npd3M2RezAjaIB86H5jTy
         i1JipQN6rkXrB1+WDIe2TA9swJkR9gcxPjCTx4TUqwJjNiNH5aLqGbp1XCbfSPLTAJ/e
         +UpJZXoTK8yP0SSXZRpZyqotdKPqJGzGfUHTNBVMB91+k8I4D4BKNoylJib/HtM2up5V
         xBbqxQ2d2biByKK/9W5n1xYS+YrVC+LgEhAGS7VTYtsRjEwsdPx8TV5P9FDpVs9Z4XYR
         m383qDo7IiH1YGQRLzXfaNkneuAEv4ExdQ9FaB9QTWyKZDU1fwhwXH0ukdVIGd3WU5bx
         ccBw==
X-Forwarded-Encrypted: i=1; AJvYcCWR1CdwZMbzwkFUCDNVYgQSGMzibIOQdLaNiYmgOg+tpGxvsH87rBImV8lE0ci3Lr8kq2GPGeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVDEntg4sk2CJYLo51stbkBb/8jZx0g+OapIPEPxgTW6wuD25s
	LezooMnOOKMTtbuVzDgLZyZq2Bjq4SyotDwRvBNkhYtmxLPqmplfixlEj5pDnOLGzoY=
X-Gm-Gg: ASbGncsje4tRFSZAbvBkssQ2e5EqviUh3jdvRizY/0WfRsymI6SaI22txaJBH5gzuWk
	Dtp+Ro/s7GrcQxZCqhTDqsYbxOSOYe2xPPUys2mtXoUPLFr0TcAVZow90QEPdgAPIB++S4eUoY3
	LV9Ne3GqqBgVcTpx1Xni2lczwAIXie9niqrMeyu5IjwupFHk7de7AaT6u0Yhw3d63ucillRgX4I
	482H5Ui4egRPZuNeYFQYTbhzcmyjqYSyRfXn4X/I66Aitk/DOKnJa9ts76MB2n/vMt0iPo2+aKc
	/vUdCBd06Nj6eUdhJwUcRNCyOu5BPHUI+ePT4eQHXNKvqSiWzLLLg/CRnjaawhhP/N98GWmTgoP
	WGx3Aunr0NNWUqBpwTDJqZg/PrpqzYriWLHSj6ZJYwAdW49z6ldcVn0KA74K96fw3UsY=
X-Google-Smtp-Source: AGHT+IGgSzJ8+46VNOZXexlqYViBQQ0yPEQdQYjheVTYFx2jan9h9qwT1GQqTaqshNqjHKDQFZMH9g==
X-Received: by 2002:a17:903:2984:b0:234:ef42:5d65 with SMTP id d9443c01a7336-242c2257710mr232368915ad.52.1754956366570;
        Mon, 11 Aug 2025 16:52:46 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242fe07f5c0sm3552955ad.97.2025.08.11.16.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:52:46 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:52:43 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, almasrymina@google.com,
	noren@nvidia.com, linux-kselftest@vger.kernel.org,
	ap420073@gmail.com
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: add configs for
 zerocopy Rx
Message-ID: <aJqCS3xqi6UXwsP6@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	sdf@fomichev.me, almasrymina@google.com, noren@nvidia.com,
	linux-kselftest@vger.kernel.org, ap420073@gmail.com
References: <20250811231334.561137-1-kuba@kernel.org>
 <20250811231334.561137-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811231334.561137-2-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:13:30PM -0700, Jakub Kicinski wrote:
> Looks like neither IO_URING nor UDMABUF are enabled even tho
> iou-zcrx.py and devmem.py (respectively) need those.
> IO_URING gets enabled by default but UDMABUF is missing.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/config | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
> index 88ae719e6f8f..e8a06aa1471c 100644
> --- a/tools/testing/selftests/drivers/net/hw/config
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -1,5 +1,7 @@
> +CONFIG_IO_URING=y
>  CONFIG_IPV6=y
>  CONFIG_IPV6_GRE=y
>  CONFIG_NET_IPGRE=y
>  CONFIG_NET_IPGRE_DEMUX=y
> +CONFIG_UDMABUF=y
>  CONFIG_VXLAN=y

Reviewed-by: Joe Damato <joe@dama.to>

