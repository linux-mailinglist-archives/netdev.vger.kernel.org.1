Return-Path: <netdev+bounces-196961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D08CAD7219
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD0817EE71
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6892253932;
	Thu, 12 Jun 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="hPO6p1Jn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384A244696
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735083; cv=none; b=MJZr9eIRUWvyLFN6bZtIwUc2rm1qUrWhi6EvD/bV2EhJU4fkIE8s54V791tmhLG7V8IdmiJeMO+1732IhF9tTr62eyDho3ICa6BWpBZFj1B1ufb00SljY1dMv1L2Cs3IHkf8joDvycQI+5ZVllrVFlyv9UIM7Vjzj2FwAfV9x+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735083; c=relaxed/simple;
	bh=Sa3FfmyKDCefdw/wrrcSViRREiOcyF/hD2ktzHVhuic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsLAtd4CLlGUmUf/p2c+XYLlFXGRt7UvxVlmcNwVx2eEMXv/hsC1TEgCaWk8FdsBctvSBp5qK0MGJp7xGSJhS3bAqMUHLD/dgUxFiTzRaslcVZ8V3hwylB7jsRyBUWwuIaHqTd4U/KeEm6c0e4mpAeNkKDba4WtIC2V6R0hxKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=hPO6p1Jn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so6183295e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749735080; x=1750339880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/lv9BUbkH3J6UtkmDC2NeXR0wU5Tdpo+Wob7H38rwk=;
        b=hPO6p1JnECrOxly87eBXL0t2vTXaZ/Gw4Qac89lQ8FVIZUxA59rDWxlgPxlXTnbTlh
         p5jwxay2cYBVLYvO7MQlygaUWJB8weKFHwazZej2RTPQ4yYNhrdGRc7LJse2YOQCdpNL
         RkNW0goS780V+MUZInqiR8fZt61KvMS/ivdhIYR4o7jP0Ybfa20hDq5t6m7A+rp6ev8i
         p1fUomoBEX/nsd67g+Z0BxPPrF5lFCFtqCFu/U8psSFYbD3aFW8Fyrq0yLKxb4SvU/Bt
         M4va1h2JAjWx8q6jVgBCew+dbYVK0hx9ZZWlk4cDl8U2Y/DaOqrXIta4uurKjKGqThGa
         tAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749735080; x=1750339880;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/lv9BUbkH3J6UtkmDC2NeXR0wU5Tdpo+Wob7H38rwk=;
        b=qRVSqILJ7nY+xaahGCAe9vXxWogotlBV1OeBIiKoNPL0U1NT5uHjERYLLwCJ9y4siC
         sew9rXHSEZLLl3nWgJRYScTt1yNb99WuJ3zc5L3Mw7PN6fdHuJcfTuABtW0VFhRchZsv
         7vJeJNg2T/yR3jEQMv3WtImh10VbyUwb70u8yny4MSbj8qbo83AKpBRhCwyWqhfuA7z6
         VEMIU3W0yisy+FlT7L3sNBbBQv9zxOu3PlQEXXNdFMWssLjxx4gmqpIJPcjlz3u2WtEq
         1CgpJMknTVvFld/nDI1aKzpW6KFaO4r6xZ9xj2+ncYQLdzzVCZGdLVD1ecYWHqHhdqlG
         0JKA==
X-Forwarded-Encrypted: i=1; AJvYcCWiDGCsE8nqy7Fd5AGx2kcYHOFhfkD8dtVVqZFR5OY/CoYJ8LKT4FGdyRKd4ImEc3DFv+EOw1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaO0CltOX3hryaiSpQQZKLYC94EZILlaGq9F6p/UhQlo27hn6R
	wyh/NElDUAs0JNeo4g8A/YHIMjIdzrcEsQVBziaTU4PLILxn8yvNgg3R0mzz33UPgHY=
X-Gm-Gg: ASbGnctKpfbaut4D7xn16r+aWyBxfx4qIxdBPCNEyuW9ReesvclMXHiytflf/vhC/+T
	OlXkAsUlyGlp3VGv6UrNsrhZrzLz4CifWgLmZYuPWkH9zkRtSQsLBwM+DeD7U9B1WXJjmkWL6cB
	Ow17HvQgivfx++7noaf37cVRhv65wacYyt3QUUakRAwi2WWlMJeITATbgUYeCXW8UprooazekJY
	fABt1r2TySX6HJVOjCPsP++rqyFqwCoMSlso24kes0mlwahw51s7yH7gReUd12cjJH75hYEhVEj
	1RgzaoE4bemKWqlWYs+LvoVkjElAsWoGs24j3qNaoqgybt9PkBWp67LeV1NwUUdfSoo=
X-Google-Smtp-Source: AGHT+IGLPYGJwuDsstUQ/cRzlY6KTrrss8ksjQeA6mAs9fAoclJ4T88v0q/9WTTlQxerw8xkgkktyA==
X-Received: by 2002:a05:600c:6297:b0:452:fdfa:3b3b with SMTP id 5b1f17b1804b1-4532d292ec9mr32104055e9.5.1749735080089;
        Thu, 12 Jun 2025 06:31:20 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e268de2sm20954975e9.40.2025.06.12.06.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 06:31:19 -0700 (PDT)
Date: Thu, 12 Jun 2025 16:31:12 +0300
From: Joe Damato <joe@dama.to>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH net-next 1/3] ionic: print firmware heartbeat as unsigned
Message-ID: <aErWoFty-VDoZ97B@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Shannon Nelson <shannon.nelson@amd.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
References: <20250609214644.64851-1-shannon.nelson@amd.com>
 <20250609214644.64851-2-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609214644.64851-2-shannon.nelson@amd.com>

On Mon, Jun 09, 2025 at 02:46:42PM -0700, Shannon Nelson wrote:
> The firmware heartbeat value is an unsigned number, and seeing
> a negative number when it gets big is a little disconcerting.
> Example:
>     ionic 0000:24:00.0: FW heartbeat stalled at -1342169688
> 
> Print using the unsigned flag.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

