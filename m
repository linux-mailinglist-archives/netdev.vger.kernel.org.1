Return-Path: <netdev+bounces-232382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAECC05047
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 10:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556B81896A3F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F2E3016FD;
	Fri, 24 Oct 2025 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="V9KvNY0k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51E52FF168
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293803; cv=none; b=mnVV2FpCxzzYBrQMS+0c0lUC3Ib1kFreIr8vqZQrwEkvBw7G6/2m1VrMIJ2Eq1q1bHlt4oM64IwrkLiVY04rf8zQPAYVJ4T+Bp6dbFJr4Z5zsNJtCx+hkzNInm0k2jBElCtvrYxnZP3RM47QlUNxvbNj/CfnmytNnmqG75ieolI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293803; c=relaxed/simple;
	bh=RWdGPNS1iDQpL3AYAMrng6/fsuBkytsPx/WEa5J21x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXKX7WdnFBVbYXs8rrV+0tRqxby+6Hx2DbEOwIHXk0fdAK2GrcRKiHO0UzopKqmQwyOdl3A4NCdh3DQHnoqvgb8/5THfUwK6T62lVXlqujnjWi7zwett+uD2p6DDkHDYoHQWefR8ZcTVzCvOr5zvmwUpSk31hhVz81FwUQHw70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=V9KvNY0k; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4270a3464caso770421f8f.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1761293800; x=1761898600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5cjUqGbM0RrW05do79zm+nugfOI5OuKl18rgtRfqvY=;
        b=V9KvNY0kI67U/PdaJYXieop8BZiy4MZiedSzwXjemnFqsCbENvl/lA7gCz6OcHQIzL
         eiJWHzZxk7urBdwxlCv2X5tYbJD7YsYQ5zYjkdYOEmi6YSf+hQWxb/rcX2AwZb3LpzR1
         nkQmvDmsq0WaQZ7Ffc1NFdMOQwNW19vXZXIh5yNE1CxGKjBgy3rhCCbKLpfwTvDW4xDO
         6N0M2i/BaAT8lGP58ZNoDGGIinx6LvhTr1kaOKWif3GriTPFo99fcKHMmRJ0pQwsStc6
         cJRUvn3fOj2g+6FujJ6mOHKhfWTmLnTdJ86cisoxKz2rpTdtjHhqQFBvtbRLSiM0+FXr
         kXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293800; x=1761898600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5cjUqGbM0RrW05do79zm+nugfOI5OuKl18rgtRfqvY=;
        b=L9ld3IDlYtyj0hMVJdh5OiBT3OOyfcRV1Bd/3dyvjttfRVqOvOGrhW3fQx5LgqtB50
         4cSbssvo2VsP97FBS3qK69ufc+2znQJ0xKjMBKJGfdDAUGpGl0Lx5KkzIYU3YQ9OQMgO
         DDCrpGiIz1lpkLkAnRDJ1melePoR4GueN9YJVySrmzi2MjMhr3G8YCBcSTiS86yNv9CX
         B41A2iZvzzA+vwnLwUq2E7zFYkysBWDHsAfl7GCfTb1kMVGBPV0lr0IsCD7r0/uEZ/vv
         h0L2dnpManeAXuGWeHC2qmrWKjWi7JKCH9TIvSkX/6AoMm81cxBiyPBbem34S5RiKfs5
         YmTg==
X-Forwarded-Encrypted: i=1; AJvYcCVI4vK5PIITVHD7vpwMIE6hCrinKTRP+9W4DyjAB18g8RdRlvuo8mqHs+vCefxMYXTA22KxKB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylH096r0Ne2YqLNjVGuEn0ScyJOheTs4W25RIBFcen0nAyBhdU
	vdgvdV3nc9PsxNu5LIUeDl86RISshMWwnuwP1cB1FM8iFRsaWHSlzpmgQH7wPZm9Qkc=
X-Gm-Gg: ASbGncuUr3yI+TiUOEKQRLMIb4KePQHuD2qdDyX1k9EZ/M0V3vMkl2Nv7pnxZ8t4CVb
	4Ni42jnRqY1M/Kl4XVvHTfWC53abUhjkvHpJI5R6jQg7uv2IX6A9FZhFlinN7aeT3PggwQKgtTq
	U698r/1b6zaafeVL5YlXhYZzSY7c3Eof19Q+d2XGgNYv6TCiVzmb7S93zeENLOFb6yKqrvLneV7
	MwrajeeBIk3RDbsPaQAJsq47Ong5f3H3AapPNjsjRzrC8qJbg2rLAbpOAA0YWV/QnKi1m+5aqA0
	SDTTQSSBDLuEGprHoOofurTKiUT+tZEd88gXXvLjG1iRL/p4yroy2yunvGMAujO3z8GemGLa/QH
	dRUehvIBeBKDNlZWmheyuTU9ieoDM/mh2BeYZThq8ryn36FU9XBDrjuQwLz1EOvo3Et1QXSXQ1r
	yfB23GlG4Eu/kXIkMzTwvSy2XeHaxS2tQinpnypQ==
X-Google-Smtp-Source: AGHT+IEjgDbqn3z5tjHECw3913ThgDrQE5n6C5KutSqEORLETt+ny0gQGMO4mUMda0NT2ai8gi8/9Q==
X-Received: by 2002:a05:6000:2203:b0:428:5659:81d6 with SMTP id ffacd0b85a97d-4298a0a9200mr3119153f8f.37.1761293799579;
        Fri, 24 Oct 2025 01:16:39 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4298d4a49ffsm4043496f8f.13.2025.10.24.01.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:16:39 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:16:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Vlad Dumitrescu <vdumitrescu@nvidia.com>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: Implement swp_l4_csum_mode via
 devlink params
Message-ID: <uez74rl75ner76kl3i5ps4huyxmzerrhananjw4vyo74tvev64@nk2lwjivr6ho>
References: <20251022190932.1073898-1-daniel.zahka@gmail.com>
 <uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
 <20251023063805.5635e50e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023063805.5635e50e@kernel.org>

Thu, Oct 23, 2025 at 03:38:05PM +0200, kuba@kernel.org wrote:
>On Thu, 23 Oct 2025 14:18:20 +0200 Jiri Pirko wrote:
>> >+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_SWP_L4_CSUM_MODE,  
>> 
>> Why this is driver specific? Isn't this something other drivers might
>> eventually implement as well?
>
>Seems highly unlikely, TBH.

Well even unlikely, looks like a generic param, not something
driver-specific. That is my point.

