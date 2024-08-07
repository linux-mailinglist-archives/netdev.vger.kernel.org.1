Return-Path: <netdev+bounces-116541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF5194AD32
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 17:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6328A1F2225B
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E812FF72;
	Wed,  7 Aug 2024 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="a6buATYC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764E12C7F9
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045512; cv=none; b=GrsdNzBzvmgQSULw6S/A4gLPzTDOz0zLsXyTKlLzvcl+nY1rUiwRuFOuR9q/lKcVv/1DIMMBPnDKxkV3ebdIazOU+6meBIWeKqQ5e0Bcmx7Awt8RxYihdjSFIRdCdBYASTjf8RVGYCLs8vDA1vaVnbDnpDijEzEc/lDpyv88uaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045512; c=relaxed/simple;
	bh=dBF+VwRJeJbGw+Z31gRyUegx5r3j6mz41U8Rx095KUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFNxy6WeB4oJpq9sS2fxySDzzF8QGQjnPuil4JJ7Wl7ymdbEi3ByijRgxK2J4DjjFDNzzJ85698eQfAlMTJtuEnFOMtFi2zr8sntJu/9iyTrHnPPNW+MYqkmOSuCBeNEU/j+4IPALizCdRPB2KIgeiwroSiRW0tpNkhgHgwss8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=a6buATYC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3687ea0521cso1455121f8f.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723045509; x=1723650309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfurLXG54B+3Q8FofDa2qkh8I4FmdVlmU+KadVi/xO8=;
        b=a6buATYCooaG81jFhFsj02InouAhZVd/jvjypXFO00yYTufx1c4ic6+TNfBFQt0HiC
         BxE3rc8ZyG0jqcLVkkBlDAhIYQhaYx4s7m/L//AHXzLhzzCe1yG4EMnQVE1EbHuORBxb
         OZ8ZPWKMSsZM/6FOfnUBdSdNk25KDKojqKXG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045509; x=1723650309;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfurLXG54B+3Q8FofDa2qkh8I4FmdVlmU+KadVi/xO8=;
        b=TFavSkEjDHpz4LKWZuwLyI2sKAWiO7SL7H6DmbCUUhbqHHKvUoEnRhhITjqGaS53Da
         LIlDqEeQj5a4fj6eqooTvzKCRH+lCYxk1x1B496T4xeW9JMeqwKvaJFcAzJWD+fNz1Le
         02eUjChsI0SZMA+PN6jDZPHbJYmhZzV3aa/16VpXQk4sMcCtrmffkLwWx7pfJBpShKQ3
         7Qhu3ZXD5w14toiLWHR0ErCV8kA48pFPqj9HmFUsdX0q3rdfNo7vrWcAqxRhW1L53J5D
         v/J38+h8xKPjkGaa0ZuikmUsVoVb0hkFmnCAUyOeASo50yjeIjTeKxnmyPZaFWKKoZyS
         SXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHfJhfDMUGXTLO0LWDy07W8f3JDVTC/QVF+jC0icQ4BhnVYJlgYXpoc5lhLULLufCP5r7LwBh0IrGMGKfRAkqtV+TdfWik
X-Gm-Message-State: AOJu0YwtoHiPSpH02ah/sN/tkI5yHDZvAkt+eQJ1CKddAe/7bOqkEcsJ
	Y+R2jnTF1d9ys+yZ66xiBWyZcMfx07J3rvR0Oa6eRexBo3HNS77ZvwJ1XqhuXas=
X-Google-Smtp-Source: AGHT+IHDVqd3u5SGHFUoop9l8CyLoovPdnN7dnDs+AxZkOYsFRisNxsjLuxNUV1sFq6ySPK2KTK26Q==
X-Received: by 2002:a05:6000:1003:b0:367:dc45:55ab with SMTP id ffacd0b85a97d-36bbc112fa9mr13808246f8f.25.1723045508616;
        Wed, 07 Aug 2024 08:45:08 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1dfc3sm16406147f8f.31.2024.08.07.08.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:45:08 -0700 (PDT)
Date: Wed, 7 Aug 2024 16:45:06 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, alexanderduyck@fb.com,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next 2/2] eth: fbnic: add support for basic qstats
Message-ID: <ZrOWgjPMeEGIjhuO@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	alexanderduyck@fb.com, Stanislav Fomichev <sdf@fomichev.me>
References: <20240807022631.1664327-1-kuba@kernel.org>
 <20240807022631.1664327-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807022631.1664327-3-kuba@kernel.org>

On Tue, Aug 06, 2024 at 07:26:31PM -0700, Jakub Kicinski wrote:
> From: Stanislav Fomichev <sdf@fomichev.me>
> 
> Implement netdev_stat_ops and export the basic per-queue stats.
> 
> This interface expect users to set the values that are used
> either to zero or to some other preserved value (they are 0xff by
> default). So here we export bytes/packets/drops from tx and rx_stats
> plus set some of the values that are exposed by queue stats
> to zero.
> 
>   $ cd tools/testing/selftests/drivers/net && ./stats.py
>   [...]
>   Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)

Reviewed-by: Joe Damato <jdamato@fastly.com>

