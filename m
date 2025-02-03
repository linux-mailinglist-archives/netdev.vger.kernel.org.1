Return-Path: <netdev+bounces-162250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373CFA2657D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF263A3AE2
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02EA1D5166;
	Mon,  3 Feb 2025 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lqoRhd/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4270A1D5159
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738617684; cv=none; b=NJ1yxm4xHe0y/5jn2tLtrDkU3+Hx7Kr3yCGlEnf4b/N2+5YDRWr6JY7Owq0NhiYYsP6VxVEZFunPVzi7TWJFXIxkcnQqB3nYof9XiO1G9AYur/U0O5r6vC2QpV2mVKzFD1lASw4gW4IblDweRSymmxLj5HWoYMQpss0CIyIyCtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738617684; c=relaxed/simple;
	bh=+lP/lpqbGvtiGqMOhOdvClKYUtQGSI59Y5h0MYOVwY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXwvbjb6zqJx6y7RPlxxjZr+LTPinB2xUMIElq+6R5h1E2PoXvv8yGNBBd+fg9XVMYcNTSfe5kAYCI2WlWEgVd58e6fVqRmw2DeYXT0veoIyLa/T2mp1xQ7fFhNomH1hp6ebATBPxlC5qRXP0YSua9WDGt2qcYIiYZaYzbjDifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lqoRhd/u; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso7251414a91.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 13:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738617682; x=1739222482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmaOHg22k3cgwen26ICHbwo9WQDpDVpXJa7Vj1RfP48=;
        b=lqoRhd/uyFOWKC94JP3O1IkCxYNpLJT1NbchDZn+K2n9eG++odNh5y8CRxYFZ3S4xy
         FfNaFwwL9q2+4Pzzj1xSmbk38oczPfnfXnOgBgn9lQrjmvB67vrK3ODEMrepPhLEg40V
         u2lR6SS16R87WiZC3E0UnGayf53ALC5JQtGZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738617682; x=1739222482;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmaOHg22k3cgwen26ICHbwo9WQDpDVpXJa7Vj1RfP48=;
        b=NsIrjEMwRzWic8rwcaDI3JqjeUXHs7GDD76WlLtrvIAPq/yE6CZmjat01fzF9AS3Qk
         dPLOlqwE73LI6rKZEN4/G9kYj/wiqKLEqIfTguOBjJcTO+hxP5z7dAwrJZpOEZH+isr3
         Z9/e04sQNwkaKZLvfbST3204prd2MJTWvvdm9LRDdeCzYujCftyUAZ6yabSPhhjpsc1d
         n+H2M1NU/jV6BpzyB5T5Ufk/OeCe+wdUlHgLcfmUh+U8o+BtD3KxBo85+1SNyDFTWv/D
         b4RlxLEUjBpRHoIalULuhRDnHi3tAOtc7cNX+C/VN/ERY95oMCILprAUgivyELkS5BbV
         K94w==
X-Forwarded-Encrypted: i=1; AJvYcCULQge/Vk+rAb2l2seYllo4HM69c5WxaoygSMtLIKUrN0Aha/WLwhHg4Etcznv0aUoMEN9DXYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vtsHcjdNOwsw/Cu5umGW2PU47A82NLdzbg3ECPYrswg8NCVK
	pQy/KHxW7nX0xqU1/UDWWV8vKcVylSwyQNd3G1lShSTx7jLJmv2L5AFZu7vO9aw=
X-Gm-Gg: ASbGncvyx4WLJnjCtPVMvqwhz8Fzz0bk6+dfp/b8B7NC2aV0G/HGa4X4FqYBiWOnjbB
	8fZOu3VY3QMoUEhmGpGcp22lCvvPUKvYNyEv7xbiVvdlLQ7UkuOKdTzfaWqFOd96XmPoG3WCOO9
	n8OU0MdHCMOPU496nS6OxNW3qosrEH8uttHKJG/GoQG+wRI3XjUvkKKkGkgqMa+refIp9JgRxMH
	wmALJPCra+SFVAmGxS6NqqNVk8i6w5z+NZynOyDiptWAERjWaoWoZKq0M9g8qkooILqPzXyg+sx
	l0swb82ebKwsCnhnihOHovJNhI+rxRbpo8l07rfBZuKTWKI8BPglayz8Jg==
X-Google-Smtp-Source: AGHT+IGgCQ2ffhL+LPk8WmDRrATjGez6ZybOSoH0u5klkaLeGr52/mU62vTqj8z5h0u/A8e9z51PdA==
X-Received: by 2002:a17:90b:264e:b0:2ef:2980:4411 with SMTP id 98e67ed59e1d1-2f9ba26b850mr1211230a91.9.1738617682394;
        Mon, 03 Feb 2025 13:21:22 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848976d1fsm10562546a91.3.2025.02.03.13.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 13:21:21 -0800 (PST)
Date: Mon, 3 Feb 2025 13:21:19 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, ecree.xilinx@gmail.com, gal@nvidia.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net 3/4] selftests: drv-net: rss_ctx: add missing cleanup
 in queue reconfigure
Message-ID: <Z6EzT7R9cqicxfNB@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	ecree.xilinx@gmail.com, gal@nvidia.com,
	przemyslaw.kitszel@intel.com
References: <20250201013040.725123-1-kuba@kernel.org>
 <20250201013040.725123-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201013040.725123-4-kuba@kernel.org>

On Fri, Jan 31, 2025 at 05:30:39PM -0800, Jakub Kicinski wrote:
> Commit under Fixes adds ntuple rules but never deletes them.
> 
> Fixes: 29a4bc1fe961 ("selftest: extend test_rss_context_queue_reconfigure for action addition")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/rss_ctx.py | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Joe Damato <jdamato@fastly.com>

