Return-Path: <netdev+bounces-198781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED17BADDC6C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB847A4DAE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C2A25D906;
	Tue, 17 Jun 2025 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="savLHHtk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEADA243946
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188836; cv=none; b=QaHRbgFFhwUv02tiSccGbYtg0DKSBU34HyFm/UnnT6eMbA7UNgEifsJkB9cmawmPBVs+lWDwgdToLQE0rqf83g4ZoJf9pKuWKK8emI2/Aqc/YnA9w0SBh/L9oGjEMKc3eFjM7lHeF6b9SntflkkweCqSBm3oKkHBnR0ZKNsONrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188836; c=relaxed/simple;
	bh=k/TpLa/PtWMfFkZ4PpMbzwrabb0DP58l+kNvcugkCXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJF9TNzxk7VC7GuCPO4GoE34zX7t+Cp8KkJaQ4f3EW6dNCxSM5KLDvsmdvFFKRvDvnTWJxiKnGWeCIn2w7Eqgkt7Jmju7hF/BfXPH40jtEYZ71S1pEDhj/tDgZrVBErFLH5MwSz+s+o2rtRKwKuHNDvf/jvrHsizDe2OGcqaXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=savLHHtk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a54700a463so4933f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750188833; x=1750793633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9AFIG2TIq+3H8Om9x4puK4H6GBxJfrgH+yDtc9rGns=;
        b=savLHHtkigRbwEN8fhi74siBsUCc+NdjO2fW09sXrReDg/AVqKUvVC/SOJeM2QCqjj
         HEiK8N8OVoaPKnYMb6tiz37a0lmQBfVgXBSTLFhqI1WKko/32WNYGy9Iom0lTSIWKaa8
         YwZq3WDXWIbmnrHfQEijcdZ1pailuJNzHv3upGZ0yD/Giuo/OennSjsTBGz3ALZWt/sp
         DmuclvbbpFJ46Lb+QzJW22013+rxP/sPT8NFEuino0+VP4KswBTO8lQznQZc1j+BK91Y
         FkQi0DNAz43EnDBBe1Rf0zF9a9c8wGlio9SChnfutmruV0UPwbX3f9eY00/qUcYwgF+3
         zkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188833; x=1750793633;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9AFIG2TIq+3H8Om9x4puK4H6GBxJfrgH+yDtc9rGns=;
        b=PouoQfR9H8vGNbc7L6Sy1t01fco8iPK0ER10aNn705qDllTzgHJ+7/RSPCBk6M8ggz
         xDJju260i/SucQg8n5iQOep6NuHQMX+/aik6AwoPV6ClpaaAa4NwE8YU5tXLNj5m8EoE
         x/+b8YswVpcVl6+JSSSwoSd/wyXKzjvU/KOAw9TvinmIRkO6CIJR78t147tLoVC7T7H7
         j/Gk/xplLqnhyN48exAyrGuoqYOyS8D4f2uCCaYqv9EdfUWFJWaiVcfY79MtROUr/peg
         qg3RbpwR53QoGpgE8Fu36483OdoyeSp5sSGE1z44F6Kb5gGzVzTv15nFYCUHUrmu9Mkx
         D3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXFEUdcd9Ik/vSfJo3pSKRHff82PXizZmtzFDxF8+J08dYLVsRcFtJvKsH5j4ri/G+FXbn3MUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KPdPbQda2HLW0PI4icqyl5XYAliDH/4CDsLTQSAmBjKaGQrD
	gAlJIBCyhQ3tF08V6xfCHSwN21KCtl20Rwam1c6BK3GgNWpXY8qn2x7y3G9UB2EBAQA=
X-Gm-Gg: ASbGnctEEhzuCPYunD3/Rl/SJV2gk+IShCetDHNs/DDGyrOVrY87b42f572ZracA/mS
	aFoG1mJzWWhmOotMVDsC1tamYP5daC9G4hZdhqAAiJEDlH5GZWtAYlbn7DzrIx3DJGEN2pAgmJK
	yZyvSFpwq+KfPwUSthKQ1BT9YCNvxiKcyV2HJGO2O9gPSOGM8jkiGdeP2Q9nRhJxz8yA17pRCa9
	EvSBNZNggt99/712aEEVzoU9C5rwz9qCU2L0OOa7UGEPY4MzlFdX2Gp/hT+eNXw1ty7z658l5sk
	ocu8JbTlTxBmLpGV53umBJDYDpqWdWkcDCGlWxadwlICaYlLMHM1H3wbejIc5rzRkssUmUKV+u5
	zmQ==
X-Google-Smtp-Source: AGHT+IFdeD1FalHjh/M0Id4CVVT8Uo1X9UM+/h0kDU2haqdwcsz+E9jE8GI2CMfLB+2+NJ4yrS8evQ==
X-Received: by 2002:a05:6000:2f86:b0:3a3:7117:1bba with SMTP id ffacd0b85a97d-3a572e85245mr12261631f8f.24.1750188832660;
        Tue, 17 Jun 2025 12:33:52 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b089b5sm14613782f8f.48.2025.06.17.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:33:52 -0700 (PDT)
Date: Tue, 17 Jun 2025 22:33:48 +0300
From: Joe Damato <joe@dama.to>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	gustavold@gmail.com
Subject: Re: [PATCH net-next v3 3/4] net: add dev_dstats_rx_dropped_add()
 helper
Message-ID: <aFHDHOAAqym2DKIq@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	gustavold@gmail.com
References: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
 <20250617-netdevsim_stat-v3-3-afe4bdcbf237@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-netdevsim_stat-v3-3-afe4bdcbf237@debian.org>

On Tue, Jun 17, 2025 at 01:18:59AM -0700, Breno Leitao wrote:
> Introduce the dev_dstats_rx_dropped_add() helper to allow incrementing
> the rx_drops per-CPU statistic by an arbitrary value, rather than just
> one. This is useful for drivers or code paths that need to account for
> multiple dropped packets at once, such as when dropping entire queues.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/netdevice.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>

Reviewed-by: Joe Damato <joe@dama.to>

