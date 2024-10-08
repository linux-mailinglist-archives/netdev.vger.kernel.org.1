Return-Path: <netdev+bounces-133252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BB6995651
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4805C282B69
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52305212D19;
	Tue,  8 Oct 2024 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bJLMB0pa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF0212D09
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411571; cv=none; b=fOgYSu6sG5U7MNzWVhdYqtaI1sOgA0FGoxlwBnUEI0xF7isqEr4O7JsrOPYFyJiw55b5cm267D7M7qAMdmfp8GHAPyQHiSgRUDEVmX8CegS9ipQ9hhr2ynfxh7BPCLDYqAcFtztNGN9Le5Q0xv8Nuu4GDs07WRWU20Vqlo1/fiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411571; c=relaxed/simple;
	bh=9eYP7A5/N0DO/nX/nAr52PXSj6ehjX4WQjbyfcs0Zi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boLk4n/LBZK+hqEwbUnlJo3L+5ibxuq6+EaDw/btP5VECJtAy+khImoOoYVe6lCnhfJTro11NuxpjvGoFOtKzHbgN5FUg4PAcqy6eRD9JtPCKBzVrWR42hJjJTsUVAkhiSSz7E07/4VRgteEZq90UgE6lfVCN1WRfq2mPw4s39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bJLMB0pa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b49ee353cso55694455ad.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 11:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728411569; x=1729016369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCz1Qc+MHmm+VZJW/bV/ivnW5CrYlGd/Q98fG900he0=;
        b=bJLMB0pa6fZy7wBekCNcYqi2bAN/Zsju+2YaBP7I+/bXEdlB4qG6UGQkev9CAuzVQS
         HfjaoD5I4xs3bge/+CuSALFLrJf+BgSYdC3dh7qlQwKeViXTKrDxigODZVb4wVQvg3L2
         RL/9PBROmLUIKcA8Q3c8hJhvcAenc4/1RHyM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411569; x=1729016369;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCz1Qc+MHmm+VZJW/bV/ivnW5CrYlGd/Q98fG900he0=;
        b=iRJwHxLIY76JMF7GLAvy7j2o4eZ1hKjbgcQUGGDhIKD990+addtkdz9jDEAMuhy2k0
         9L7japknMzYyNiTo4gRoHdEW2PC8jWulMBHnP7chKvElTVSNApcBbTM203Ieb8hER3aH
         5S51LOuo4yeYDiqy0GubTp9RAG4IIO3Bm9WJvHj2HCR4gjaVUjuxzlXNbDDWsLOsVfcN
         avdaCzn0ldA64fMKzTD5dmfdOu422SFy5BBoO1D5ESllSfnGPaFYDuZNCiOnRy9Syhjk
         OKCMvwhLc8LvDhOg7pTTma/7kOVQE/T+6qaNWETw+Qg3l3HBEsNQ9CGdGyEpRQTCxcyx
         KH6g==
X-Gm-Message-State: AOJu0YwbU8znlfgsFtbaNq8r+ITYL2leVOGYGK8b8c0V/UF3VbQi/SMJ
	5eSWgAQnVSkO9oRjZudlddX4DkyPgvneMEPbxqeYMMbzwerLW1JI3R6ZnAFao7W9v1WLX1yjSOi
	QbZDpO0DI8wgpdnwH882rILe07PpSeIzLzgalHGpGuNyikPZuO4POLXJCPDdQWhx8E0TLvje7cY
	vfXq7ArhhVkSFgZDSHBBdAYs63dmyJ+HwQZtM=
X-Google-Smtp-Source: AGHT+IG3n+8BjvNyfdOQ41CtWB50a+df5hMGC6hZK0ik2wYeBjEF5HII03Wx0Fx78I6sx8mNTwMEPw==
X-Received: by 2002:a17:902:db02:b0:20b:ba72:37c with SMTP id d9443c01a7336-20bfea542c6mr268194995ad.48.1728411568581;
        Tue, 08 Oct 2024 11:19:28 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393997fsm58485815ad.179.2024.10.08.11.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:19:27 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:19:24 -0700
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v4 5/9] net: napi: Add napi_config
Message-ID: <ZwV3rOFhsEyVoNtR@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241001235302.57609-1-jdamato@fastly.com>
 <20241001235302.57609-6-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001235302.57609-6-jdamato@fastly.com>

On Tue, Oct 01, 2024 at 11:52:36PM +0000, Joe Damato wrote:
> Add a persistent NAPI config area for NAPI configuration to the core.
> Drivers opt-in to setting the persistent config for a NAPI by passing an
> index when calling netif_napi_add_config.
> 
> napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
> (after the NAPIs are deleted).
> 
> Drivers which call netif_napi_add_config will have persistent per-NAPI
> settings: NAPI IDs, gro_flush_timeout, and defer_hard_irq settings.
> 
> Per-NAPI settings are saved in napi_disable and restored in napi_enable.
> 
> Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  .../networking/net_cachelines/net_device.rst  |  1 +
>  include/linux/netdevice.h                     | 32 ++++++++
>  net/core/dev.c                                | 79 +++++++++++++++++--
>  net/core/dev.h                                | 14 ++++
>  4 files changed, 119 insertions(+), 7 deletions(-)

[...]
  
> +/**
> + * netif_napi_add_config - initialize a NAPI context with persistent config
> + * @dev: network device
> + * @napi: NAPI context
> + * @poll: polling function
> + * @weight: the poll weight of this NAPI

For anyone following along, I noticed this unnecessary bit of kdoc
left in from a previous revision and will remove it when submitting
v5.

