Return-Path: <netdev+bounces-137224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0526D9A4F87
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 17:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A771F22C9A
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF11D18BB8E;
	Sat, 19 Oct 2024 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="fdMgiiHG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D05189B94
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729352889; cv=none; b=PoALfz8SewL/3UGaDCbPKBCsxxUFjfBxmIslw/TYPg67Sv0ZZdCcV/U78N9pAKjPy3GlCIDVzN85Q+RBo6n2Suc0kU+IWA9XvYlKOKaMgh1lkixVzwFaU4oXYByXtyGRx1nxn9JwD4op5uB+jdxT9iH3NkkcW9DVmRxRJZJp+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729352889; c=relaxed/simple;
	bh=wnztqBF8IwTX8D1FyQPLrXscInObLTsIMZ8fQVXs16Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPCF1CZDPvAJaxdI1NMa90pojEy7zGMCu+52noobZOaDBLAn1d0zoV3OAWa5FXh9snFirwdbN0ahvmDj0E/oYAMuJZA5nhl8kThmN5gInAawcdEGrazV8mo3XtLDEEr07bauHaAZOUuFlIJq2oJU6KicYGhHgOi2GFCKgtIEYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=fdMgiiHG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ce5e3b116so25696405ad.1
        for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1729352887; x=1729957687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAj4UFyqvzplAfdoGHeEajZtYN5YSutin6EbOqec624=;
        b=fdMgiiHGjdIcTbPX8a0rv9M2xH3NDtNHjZakzaPl8AnDeyu0zQAdLgeoTKotlBxG55
         8x4MjfJbVOsZ/GxWsO9D7VbILAIRW7Axtmixhr2xnGn4prFgkKtJGsWZF1jT8iljmIli
         juHzGiEa+TvVqpvA/NOp37+HqfKiA1ZzP4EMgfVFc5xx9oIvpBsO7+qWcJQ2MSmtcqaj
         GYVMMCrZ7WQRi18iTrXKPsEFLLKw3QiLCM+Rje0UCFCx7G+mXCMhlIgevxInxOAnFkFj
         IZykK7knikOJfrZ7kyT1hQmGJa9fAi/i6A4MR8/s/uTRWrp6ys/o/89vOVPFsUppPw0p
         pxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729352887; x=1729957687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAj4UFyqvzplAfdoGHeEajZtYN5YSutin6EbOqec624=;
        b=ZqIBsXJ2iAeHY7x0po0mG92Eyx4f6pjDcLcowSrQ6h4wDy0i/F96cnOE544wFObmsQ
         y1M+G8kEE4FZHsJX2IlOIRTVzPDFLefCTsLRUaIqrbSnWWFSwOWK+5VbRM7weQ7F0PiZ
         oqRErd2UKeo18j9K3UVyVxbIOJQOoA65295pIYzYxRh7hHkh/0Bw4d6qrM8A1fcZjDdV
         I/oYaIFSsfMKj3eeuA8s6ny+DXzGLAiNf3K6amVDZrCmk+3AGm5zMIOg18MFT1xtn6So
         5VKmSPflKodxDqizAP7+wGXQ/0f+a6/wACu30P17q1QqN+TX9PnGmCixi/OAmbH4lwCi
         ujEQ==
X-Gm-Message-State: AOJu0YyFvEn9N0uxZJ44pVw9lcNAs5GWlCfXGQ3RrdVNRvDd6JNNheLV
	H8BbD7m7YMu/6o4eqWjeRbPnVA5OwDTkklZmwA0SeaQujksYUEYBbeM2ulEPI3c=
X-Google-Smtp-Source: AGHT+IGTKB51TZaSqJNPBcMFrl2V6WL7ZERnpXb/DIDAURp8PSrF768GTi2KRyrpE5N5LznX1HCZqQ==
X-Received: by 2002:a17:902:e741:b0:20c:ac9a:d751 with SMTP id d9443c01a7336-20e5a8f99e8mr89116935ad.32.1729352886748;
        Sat, 19 Oct 2024 08:48:06 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a9255a2sm29172735ad.297.2024.10.19.08.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 08:48:06 -0700 (PDT)
Date: Sat, 19 Oct 2024 08:48:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com, Olga Albisser
 <olga@albisser.org>, Olivier Tilmans <olivier.tilmans@nokia.com>, Henrik
 Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>
Subject: Re: [PATCH v3 net-next 1/1] sched: Add dualpi2 qdisc
Message-ID: <20241019084804.59309c7a@hermes.local>
In-Reply-To: <20241018231419.46523-2-chia-yu.chang@nokia-bell-labs.com>
References: <20241018231419.46523-1-chia-yu.chang@nokia-bell-labs.com>
	<20241018231419.46523-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Oct 2024 01:14:19 +0200
chia-yu.chang@nokia-bell-labs.com wrote:

> +config NET_SCH_DUALPI2
> +	tristate "Dual Queue Proportional Integral Controller Improved with a Square (DUALPI2) scheduler"
> +	help
> +	  Say Y here if you want to use the DualPI2 AQM.
> +	  This is a combination of the DUALQ Coupled-AQM with a PI2 base-AQM.
> +	  The PI2 AQM is in turn both an extension and a simplification of the
> +	  PIE AQM. PI2 makes quite some PIE heuristics unnecessary, while being
> +	  able to control scalable congestion controls like DCTCP and
> +	  TCP-Prague. With PI2, both Reno/Cubic can be used in parallel with
> +	  DCTCP, maintaining window fairness. DUALQ provides latency separation
> +	  between low latency DCTCP flows and Reno/Cubic flows that need a
> +	  bigger queue.
> +	  For more information, please see
> +	  https://datatracker.ietf.org/doc/html/rfc9332

The wording here is awkward and reads a little like a marketing statement.
Please keep it succinct.

> +
> +	  To compile this code as a module, choose M here: the module
> +	  will be called sch_dualpi2.
> +
> +	  If unsure, say N.
> +

> +/* 32b enable to support flows with windows up to ~8.6 * 1e9 packets
> + * i.e., twice the maximal snd_cwnd.
> + * MAX_PROB must be consistent with the RNG in dualpi2_roll().
> + */
> +#define MAX_PROB U32_MAX
> +/* alpha/beta values exchanged over netlink are in units of 256ns */
> +#define ALPHA_BETA_SHIFT 8
> +/* Scaled values of alpha/beta must fit in 32b to avoid overflow in later
> + * computations. Consequently (see and dualpi2_scale_alpha_beta()), their
> + * netlink-provided values can use at most 31b, i.e. be at most (2^23)-1
> + * (~4MHz) as those are given in 1/256th. This enable to tune alpha/beta to
> + * control flows whose maximal RTTs can be in usec up to few secs.
> + */
> +#define ALPHA_BETA_MAX ((1U << 31) - 1)
> +/* Internal alpha/beta are in units of 64ns.
> + * This enables to use all alpha/beta values in the allowed range without loss
> + * of precision due to rounding when scaling them internally, e.g.,
> + * scale_alpha_beta(1) will not round down to 0.
> + */
> +#define ALPHA_BETA_GRANULARITY 6
> +#define ALPHA_BETA_SCALING (ALPHA_BETA_SHIFT - ALPHA_BETA_GRANULARITY)
> +/* We express the weights (wc, wl) in %, i.e., wc + wl = 100 */
> +#define MAX_WC 100

For readability put a blank line after each #define please.

There are lots of parameters in this qdisc, and it would be good
to have some advice on best settings. Like RED the problem is that it is too
easy to get it wrong.

Also, need a patch to iproute-next to support this qdisc.

