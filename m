Return-Path: <netdev+bounces-133255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0C099565D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04CF1C25417
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3020B212D0F;
	Tue,  8 Oct 2024 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ao4PoGI9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3AE20ADE2
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411772; cv=none; b=ttm+bVM6qhzC+D/riyZwKFFUbAV9rACTSnD1intNffRz4ScARggRCQj02tWiMyPdm+jbr+Aq5n6L5e2b3kdH93vctoy+QoPDvTkkGiv8FJcjNevoRWCRp/p2zWdOmUAbvp6ildppB52cCYZYMaG5I/Z7t+Zdaw96vuKGJB1ainQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411772; c=relaxed/simple;
	bh=Soj8mFaLd1Cyy0ejjBioY9cxLP9QIIW58JDFeiu2ts0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6PJq3Ln67A39SVetKd9ClzsySxS0cY8nAec1wZ5EVqyThTLI4+PUu22Bac2KBouoQm1dGdCfDw/3SbI35PZRUtWNx+HD+i5tqeE8qYQPsja8WuYRzhrpoKwpcgvzZOi1/FTh52C/ucKF4dg0GYA2JC1rhnmMKvg7Cqrhh3anfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ao4PoGI9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b9b35c7c3so62564995ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728411770; x=1729016570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfgCpS5PaaDvZjkTJaE/xBzcbJqmdBm8+yyCnyw3De8=;
        b=Ao4PoGI9vwBp2XBS9TbUrC82t+VibfUVIqpnOWesXqezv0Br5BL3Ty6wA+tIYl1bwg
         Gl3KwX7OxATwATQ4aFYcSBL764vZgdr5lfvNManB36kYOHUNNMjmJjglTqDhY7hkgNAh
         S6g4uoFnk9dwmJfotqQFxrZf4dItl8v4X5YDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411770; x=1729016570;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfgCpS5PaaDvZjkTJaE/xBzcbJqmdBm8+yyCnyw3De8=;
        b=MW1EfhYJc2LrCcMc4Gs+LKML84MEHawlxRwcPWBJ/X/q71yn8GWJNUlpB+YTg/MbOB
         aH2/kva1tNleHVgg9tPz8KgFJ3/q18k2pssku0Gcl/5/vQEz5MNSceIzySRS2mrOOx4W
         HPzpt8Z7R9VVAH2jBGBJlsxA6oQ2+KFZfE5xqH1aIe64bAoIc8ans1A3rOUHNDLMvpPS
         NuO86NRj0WBzgj1zd4Ht/gc8es+rtWgRyW0XhyNCENGxg1CtuvFey4wQpSNrB75JitWT
         cz0vKBqWpKTH1T4vPbWrEsuoPqm4+i/Jm7ACB7DqXqM+zTzHLpK1H+2X+SzdpCbMNl/K
         D5UQ==
X-Gm-Message-State: AOJu0YyKbTH6ojIc0V0WaSM8dVydezfxuCWN27ckX50kCwV4xzjj4+mt
	T5UJY+R11BTqMNWd2PGM/PVvvU2eiYj+prLS8c7BzEwef3cxqdHnNtR5mpftc9IALzlPZgQfDBU
	ap3KGpH0rMwYHYDeRvqjfctrTdQjWfVaHfypGp5YRoYbcnDmdFL80KesOoIRY8Lj7qbYquhkyqM
	rKJsALyolpO223HuUDCmtixMSf7EB/H9l89Wc=
X-Google-Smtp-Source: AGHT+IGLwKH5D8GmqT91lF+IEqFV1bkPlXaOCwMdX6WQyBYQ2vbuWPbJ2h7utnI4zy5Lzw/E/iDnDg==
X-Received: by 2002:a17:902:ea0f:b0:20b:a431:8f17 with SMTP id d9443c01a7336-20bff1c4055mr294243605ad.58.1728411769685;
        Tue, 08 Oct 2024 11:22:49 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1395a408sm58422345ad.193.2024.10.08.11.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:22:49 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:22:45 -0700
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [RFC net-next v4 3/9] net: napi: Make gro_flush_timeout per-NAPI
Message-ID: <ZwV4dUxPZIVG366J@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
References: <20241001235302.57609-1-jdamato@fastly.com>
 <20241001235302.57609-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001235302.57609-4-jdamato@fastly.com>

On Tue, Oct 01, 2024 at 11:52:34PM +0000, Joe Damato wrote:

[...]

> Note that idpf has embedded napi_struct in its internals and has
> established some series of asserts that involve the size of napi
> structure. Since this change increases the napi_struct size from 400 to
> 416 (according to pahole on my system), I've increased the assertion in
> idpf by 16 bytes. No attention whatsoever was paid to the cacheline
> placement of idpf internals as a result of this change.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  .../networking/net_cachelines/net_device.rst  |  2 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
>  include/linux/netdevice.h                     |  3 +-
>  net/core/dev.c                                | 12 +++---
>  net/core/dev.h                                | 40 +++++++++++++++++++
>  net/core/net-sysfs.c                          |  2 +-
>  6 files changed, 51 insertions(+), 10 deletions(-)

[...]

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> index f0537826f840..fcdf73486d46 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> @@ -438,7 +438,7 @@ struct idpf_q_vector {
>  	__cacheline_group_end_aligned(cold);
>  };
>  libeth_cacheline_set_assert(struct idpf_q_vector, 112,
> -			    424 + 2 * sizeof(struct dim),
> +			    440 + 2 * sizeof(struct dim),
>  			    8 + sizeof(cpumask_var_t));
>  
>  struct idpf_rx_queue_stats {

Now that idpf was fixed separately [1], this will be removed in the
v5.

[1]: https://lore.kernel.org/netdev/20241004105407.73585-1-jdamato@fastly.com/

