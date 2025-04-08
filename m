Return-Path: <netdev+bounces-180036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6681CA7F2C9
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C624816735A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0EF22A80C;
	Tue,  8 Apr 2025 02:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="J0Y8qw5p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53852AE6C
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744080297; cv=none; b=ZZFttLSdc1+SjbQ5MADGI8NQUJRc9Td3dsKNx4Kmswxn16ZZEU/DfN1VdAptm/tJfUAjFHyGZ6B5753UBDxxdi9IW7Rd3YnTe3USFDPTtcCiVupX0dQk/3gLy0xNhMp72lNw5EUDUCucBURiKrcCi/V3WcxfoYnYbyo1qjzIdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744080297; c=relaxed/simple;
	bh=iWxvemNBYjvEqfzf1xQ8uYXWUJ1YhCHZoVYw97TFXvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsOPFIJf/xtmvKCwskXP0Aa7MgurqB6o7x8uHMHrIrNlQi/wihx84NjkgFuZhDBK2Zt6pLLVJJytk5uEzp199e2j+bF8DDcXIIxzDg2rq2NVaR8W2bqiHBT+gyFpIiFa1dL8wwjiaeqpLdqw8S8mxHGb/7vzxuSOvyp+1e5kp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=J0Y8qw5p; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736b0c68092so4018908b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744080295; x=1744685095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHYsYt6MomkIl7F9y0PfeyDugJcu7HVSAIBbjfocuDM=;
        b=J0Y8qw5pQUHpqCHdVNJZ+hmwWThpiwUI7KJBfq7ZVm5uUiDLiAZOTrL2y5WQ4C+Aah
         jFUC03UWmkmvsgePyahZzZwr6RRmGH3RHEeNWrtC+SWT0IFH0zseNzNXulpOQ5KO4n9B
         aUetEwx0kkwhepFAVY7Gb1/3XytAWmt4fELKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744080295; x=1744685095;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHYsYt6MomkIl7F9y0PfeyDugJcu7HVSAIBbjfocuDM=;
        b=hGLLbafSt/PsmxAW4B3PWGkiexuiCm9ol3qefSSDOtAQAtjp19quPpGb2mnsd8WMsZ
         71hciCZuDuAQcY+ct+TEnthzpTlQ9WgGLA6HGDrjwUtmU426AYQdlCaVos2t6OoJKSsK
         rYL0zoVUPUqiF8K5HDyS0Idl6+YUeMLfvRnxZJOba6n5RCCVqa3HcbDccV7y7ydfMePp
         GyltMqHQCXdBAGZ6vpxXk+EssNyPPcCgS0Z5d1D9cgblcflejkS4vkeppUKGNYRdbuX+
         cDlloJAydvrCaO4KsO27dB2NZXPtb+bLzqsgXnSX/14+VhlDsmtIln7njSmK1Y1ZvSn+
         oFaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUK36MayK8j2thN/5h/gay+xW85ez2qVbLqu12Wk6UpIqzAtAOBluGQf+rNXa+o3JyAqAYfkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNV0S1RRFcV2bzHprI9T+5dX9zOzn8RCqs9Nsxz8Y3ycBnJWhN
	eph6+ikT1P20wIzbXX2IrDwwKzqTewcRhVbqlnZ1MyoWub4gdyVLh9e5USprgls=
X-Gm-Gg: ASbGnctCaPooFeSau8e5SZbRo5byDvdSm5WQ6b+F6vsW9vivYsqLvQpIf0CpyudtpWg
	iZjWEx3tL+bypkWdCn9lRh9ELD27QG9Dt87mTw+jbM21D9dvosg4WFkjob1opMiqC4TqQzGHvKY
	NxQC8Oxax5QTtYLq1ZeKHL+mkeOeOEXHUnu50WrdiY0SEABx6tPXMcXUClmsLkyxgXbaN8E3I7Z
	+uYeamEyLqeB4CWq5VzkWTU9tsgu8VFkfq34rYt1jnpaR3UUABPgOAWxgjNPFxHlGKpd4KQx8kX
	cGam2WgeGjgQ4JUknMTV8ft3HqVxdEkycF6YdWPHbX3O4KEQPPakOzQrFn5f86nTd+17yRn7UED
	GDWNQeBcuLsQ=
X-Google-Smtp-Source: AGHT+IF8c8tbfJL7Tc+eVNs822MO2Rrs+FLwJdu7yuVU6P6f4x0rmn31/NkizNyw4Y9jdApe51pJGw==
X-Received: by 2002:a05:6a21:6d91:b0:1f8:e0f5:846d with SMTP id adf61e73a8af0-2010472df12mr25513369637.34.1744080295388;
        Mon, 07 Apr 2025 19:44:55 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc31d4d1sm8075554a12.21.2025.04.07.19.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:44:54 -0700 (PDT)
Date: Mon, 7 Apr 2025 19:44:52 -0700
From: Joe Damato <jdamato@fastly.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	duanqiangwen@net-swift.com, dlemoal@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: libwx: handle page_pool_dev_alloc_pages error
Message-ID: <Z_SNpFmFXJwjWATx@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, duanqiangwen@net-swift.com,
	dlemoal@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250407184952.2111299-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407184952.2111299-1-chenyuan0y@gmail.com>

On Mon, Apr 07, 2025 at 01:49:52PM -0500, Chenyuan Yang wrote:
> page_pool_dev_alloc_pages could return NULL. There was a WARN_ON(!page)
> but it would still proceed to use the NULL pointer and then crash.
> 
> This is similar to commit 001ba0902046
> ("net: fec: handle page_pool_dev_alloc_pages error").
> 
> This is found by our static analysis tool KNighter.
> 
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

