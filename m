Return-Path: <netdev+bounces-165270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C281A31584
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1FC168A68
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495E26E639;
	Tue, 11 Feb 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ngab9+Zo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAE26E621
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302873; cv=none; b=tBhYp5lifWJQluMxRc1ihtfq1+EqOo5xDUdEU4GtdGC+38Aq4nUJjHwUaYUsis2enCzqmwCnCGTAKvcB8rNwl8OUOXJMw6VpPOmLsXzzaap1u9rKSjPrWvfN1C/UPH9j0rbTlQwts3n1nKjKm7uTitmDlRE25Vs5qxanYbFjxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302873; c=relaxed/simple;
	bh=cqr1ywEI+LQUNTyKV+zhPdanLQ0rxsFzyPp65NvI0lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjqKg5xvQ53MUSwdYAEJcerDSFHes4aLHuRm9/9rRwys8NGaeNja9vYGbOVQOmFPy0qT+jKvuJSGS2VZMlIXxzrOWXb9mPhpZbg/hS6ArU55LczXlNf54URmXth/zH+zvUr4oYKsJqjjHJVjBmZE9z5nIZJ8jHl2gj1Wkb0bviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ngab9+Zo; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa0c039d47so8803302a91.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739302871; x=1739907671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHud0oEgDVUS7GYr4QZ8+LWOjY15+xjgAPUOA37axLo=;
        b=ngab9+ZoVZW7l6HCydN8/TBf641EZA3bmYfRK1/cWHIRAh493Lz0yrG+jC2z1PuJra
         kbWhJPQPeBRLMrODRhuYSXuewOegX6BwThG0oGlnlYTNz20JvwumEBfeK7gGabuI2P7c
         me7hy/IVgiFlQdgY1OGh0SHQmTHAFnaSd2278=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302871; x=1739907671;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHud0oEgDVUS7GYr4QZ8+LWOjY15+xjgAPUOA37axLo=;
        b=F4M2FYYgDMpF7trXdMtpKv4eO21BHvAvQIbLB0cyinGOhhqJLG7CMNy+oy5LjoDvaP
         m4EiAetQCe3uAzAV6HYvsL5zSYDR67zMhF846PjPgSpjSJGM6xgCfH1x0bryXE/cWwPN
         BfsPj46XhSIcVr92L91ow2AeIFEZ+bajF75nVu8lBgVxg0Eh+mr9Ei+4YKrIaGWIKPKy
         GbjF10pdk671NUpfM0hmLt3xHnEATSs8pHIBLhRhX/cvgre+Sc9/bsrBqTNEHKr6WeUr
         w7DKCnFai+rMWVWvldiwBhIFBGjCyVr+1rb1hijgv2CehEv52PqgJS7tOfO+jgROVX6x
         +Z2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMA+DpLMuKCHENnJGdpXTLSwXrpd+5Ybr8nJRPVnPgfK3rq/WWB397MZjYfVu+D2v4zbi23PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSGbmnvtfRcPipB4uc/rLjUDbkk9D7v6nDbCJL3Fec+L5acQh
	Ckjbk17q80DjW9mwnWdL3cWU4OWhwywq9vGhU8/V/hH6Z1c6JlBBW4mVdzyoyzRezzvu9uFFqkW
	D
X-Gm-Gg: ASbGnctX8821JZCAb1qTcBgleWxsmJxYzn8jbIN44iag0Is0JdI5GXtAf71hx5q07UK
	Z+uo6XTmfx6Q4IlE3pZxeTAhjeQoMI0Yyo1b6+lVolbNIH5uWUrAkcxCUbgtyN3c5hbcR+0kqk4
	zGrtozt8ZAzfkCWkPedDyvhgjtuBeqOhNEX3M/6wxIPlmTCkuYnScpBXizMvzKtjyKagG1LeU1S
	G0n5Q/S/oAKvcpnFUp0EUQALavIzhVxjFl/muLNtqX9iPPscCDrzvjvfgFdbihNi+uLiCdpWS2U
	e47l27Ny+ckErul26Foyn950UzMn4D/u/uRwsOlAP6oniaW+1u1hSzT/xA==
X-Google-Smtp-Source: AGHT+IH1aI6InFFtV2fuC9FXYDsP3M1qnA+5RhqNDLqMZHazgxer6yIJ+k9LimHbHu5so6wNtQNGKA==
X-Received: by 2002:a17:90b:2dc8:b0:2ee:964e:67ce with SMTP id 98e67ed59e1d1-2fbf5bb9167mr465333a91.3.1739302871242;
        Tue, 11 Feb 2025 11:41:11 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa099f5c06sm10621047a91.2.2025.02.11.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:41:10 -0800 (PST)
Date: Tue, 11 Feb 2025 11:41:08 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, alexanderduyck@fb.com, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org
Subject: Re: [PATCH net-next 2/5] eth: fbnic: wrap tx queue stats in a struct
Message-ID: <Z6un1GD15zX5-104@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	alexanderduyck@fb.com, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
References: <20250211181356.580800-1-kuba@kernel.org>
 <20250211181356.580800-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211181356.580800-3-kuba@kernel.org>

On Tue, Feb 11, 2025 at 10:13:53AM -0800, Jakub Kicinski wrote:
> The queue stats struct is used for Rx and Tx queues. Wrap
> the Tx stats in a struct and a union, so that we can reuse
> the same space for Rx stats on Rx queues.
> 
> This also makes it easy to add an assert to the stat handling
> code to catch new stats not being aggregated on shutdown.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h    |  8 ++++++--
>  drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c |  8 ++++----
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c    | 10 ++++++----
>  3 files changed, 16 insertions(+), 10 deletions(-)

Read through the driver and changes look good to me. Since I don't
have an fbnic or a lot of familiarity with the driver, I'll provide
a more modest:

Acked-by: Joe Damato <jdamato@fastly.com>

