Return-Path: <netdev+bounces-180032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3734BA7F2BD
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AE1188BECB
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DE81CDA2D;
	Tue,  8 Apr 2025 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="S4KNaOWw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544C2AD00
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079834; cv=none; b=Bup55ojL3VIu41z7oxabqo+BnykEH7dk4AVSZJcvPF3mloMwgs1LUD4icII9MnsjN7sKdLkx09rpm2rMayodQzvZ6h9AcUvaatsfomsy50bee6nDfTEgD4AR6BIvI5ryEGj5tFmpmF2ER+WuOm62d2nyW4NzegQr0l8rMAjOxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079834; c=relaxed/simple;
	bh=YPeTz7pmVv/gwfUfssJuXrQjDveglwoDN0Z+wmp2+AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQIwcKvM/di57LRPkc7Kz7b+c9/eUQdXRd3GqXvJzk0HQo3RozRJjA5idlSZDlQEjFmh9tquvBgbqw/eNa9HX3tXdwqbbB78ZqRcGJ2u9OasKLbNbpOv2KqKO5HkGT3y6Nmj2fesodY+kxCH03u5PKyj9eqFfhsw6DbanwJ2Uz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=S4KNaOWw; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-aee79a0f192so3139635a12.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744079832; x=1744684632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfqbRMOTssC49PvQIYBCVP6KUYuWVnGgVa4pW/Iz09k=;
        b=S4KNaOWwrplisiGeWsHSDMrD173ZKk5HDsH4V/GlJqnjsSHEng2codF5sn277EZ1Rf
         ZEDrcDvP/BUG0SoctRpPT3FjuRHl4cp52ZyrweKKrHmmhH6/bFKzr5uBCJUlxm4QwTdL
         92kZQmHnKZb9rICoOf/FeeGxermCRGTmqv+Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744079832; x=1744684632;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfqbRMOTssC49PvQIYBCVP6KUYuWVnGgVa4pW/Iz09k=;
        b=gVZlVgxDZsH/sRjkXz6Q/JILzSdJazIRBR8rALfQwN2JkQFKPpDqOtojqDPaVPQXC8
         OjRtURbC/AeU2IB9P9a/LcYljfAviQdm5gH4fqd0RoPmr3cFeRodSCtLoXdMcQMiVEl9
         AnEe3xmznPuW0ye5Bjr2ytvGMgOZ2ai2dX4cCrr1TuJN2Pd0FmskIU8jXg82ZasDVuWS
         t/Wg3sIbN4BCh+5iGYYQUoO/k2ApSqO5JuI6OIKmKt2Sx98XuAPF5YJM5Y6OqEJOJLKc
         LLag0mMtBarHa6gRZ3vPXB66/cOG3OXNPxGf+z7qfWjFoNt292UnvWZ/Ipy2MCB515ds
         RbGw==
X-Forwarded-Encrypted: i=1; AJvYcCUng0qLlI7nG16c8ABQHFB3iTnYsONZixUrYCV/4MLZ3LDerN3OLDrYwdImXY/Z+Vs2s4Dx7NI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38K5JdUDI0xeq33YAWhBnxoArW8/B1aulqlshkq2DcKn8ZOSk
	YZzfGEkNV4r7x3aXV6OV1/0WAJyuRhFrY5B+zOD4UG1hTpFaZmA3ClX1bGoIwHE=
X-Gm-Gg: ASbGncuHAlUbonKTsBRbNRb76MOOQvapzv9A6cUzBRaEhgVR//1fO1gpLmiUzVRjA85
	OmT8+31FWZj9SY0IoblUv6ZxDMDChMStnFxLoJlOKu82Az8jOiR8sVUN60hF8FY8TXnQryMPhPa
	/8U7kpnrdUZ9sZ/+Mm+XETyQ86jCRN12Uk/SQnxUC3r2mHuh9YFz7SYTTZ1LZnjwvg9okV54Vzc
	IOIT/kXAqEb4l0bZDc1gArF1+DqM3qXRcaE9K8H+58D/yPHpLxGLM9eBzNVsiqbxR3Uki0KQ8vv
	EQDDT06ZmBfJqhEkChNXk+2MDa0JJ8Zbcuj4eQWUKx6WA0GvGIa04dsObnPzZCEa3F0s5K4wKBm
	WjSY8aHQOA6k=
X-Google-Smtp-Source: AGHT+IFTZEiZytmWK4g3VlluoR2LD+U+eHq1bVvnFpPU9sp6crcrCBwep75tT11WrsZEOGfF5kRdiQ==
X-Received: by 2002:a17:90b:1f91:b0:2fc:a3b7:108e with SMTP id 98e67ed59e1d1-306af6eaa64mr13141348a91.4.1744079832367;
        Mon, 07 Apr 2025 19:37:12 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca1f07fsm9881348a91.6.2025.04.07.19.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:37:11 -0700 (PDT)
Date: Mon, 7 Apr 2025 19:37:08 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me, hramamurthy@google.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next 8/8] netdev: depend on netdev->lock for qstats
 in ops locked drivers
Message-ID: <Z_SL1Dlsxi8t0w3W@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	hramamurthy@google.com, kuniyu@amazon.com
References: <20250407190117.16528-1-kuba@kernel.org>
 <20250407190117.16528-9-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407190117.16528-9-kuba@kernel.org>

On Mon, Apr 07, 2025 at 12:01:17PM -0700, Jakub Kicinski wrote:
> We mostly needed rtnl_lock in qstat to make sure the queue count
> is stable while we work. For "ops locked" drivers the instance
> lock protects the queue count, so we don't have to take rtnl_lock.
> 
> For currently ops-locked drivers: netdevsim and bnxt need
> the protection from netdev going down while we dump, which
> instance lock provides. gve doesn't care.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/networking/netdevices.rst |  6 +++++
>  include/net/netdev_queues.h             |  4 +++-
>  net/core/netdev-genl.c                  | 29 +++++++++++++++----------
>  3 files changed, 26 insertions(+), 13 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

