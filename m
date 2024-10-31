Return-Path: <netdev+bounces-140797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1C49B8164
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 18:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C583A282409
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5245A1BD515;
	Thu, 31 Oct 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXAk3HtF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0D13A868;
	Thu, 31 Oct 2024 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396393; cv=none; b=brxSJltsHwO5tgr4ciGKfNAVp/1Wu0DQml9xerrWdtA6sACWdc3F24YdB9uv/LyUF6mbzPZTRWg9E7O1bP9HJikuEGT49vlWH/xdj2x0QAh4ZmAFezRMHz4Hj03WjBr0AuTUeib3FWuzGLwPtjbkX1pxxNZ0B0nRMVqp5R4Gm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396393; c=relaxed/simple;
	bh=HywTTPvnc9qbb0wAHtNJ8ibarBWCj/vmqWwmSmJv+sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAHpa6q6BXf6AVld76565Wg2KwTERS7rTRbZliiDB0KxdNJz5HcP5bpO2NJEDgpwFK5Mv1d7+0RbtUxs86Qnc7BKTYf0ykhOPM+TX1LwIB8VHqqU9rjWnrpVd/DMqceQENHr6OiZvTCCIL2VPsWU0noExwuOYMfOpK5ZEIB1cAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXAk3HtF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d7351883aso80627f8f.0;
        Thu, 31 Oct 2024 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730396389; x=1731001189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqvY1FdkPNuOeLMP1wREhSeYVKoRbaudNYxdHd3X7Lw=;
        b=fXAk3HtFsOxXVktCy6CT7tR1pIvfXta55zh9eeWtoLYu8Zfxx4VPft6AcvkjniUYiJ
         mOHcUShvMVVzbEvCBBO4lln0qRUmW2H68OzT00sPIlqpPbeQXvtQqR8oGgeS4cyjw0tY
         71JV20nBrcR6wpRgoKoEHMZP27N3dPyY5fRJHGOuFSrjSKsK49OSAIH5GtEyAqc8kt31
         5xPU/pc9d+mcFsa5dCcveH9+8HkiADyP+GG5T1d9YGJ2NMqkKf6zhQmpvqx3O/HYZHSe
         cvAPhZgTjCKqVpjITkslqyPn47I6xS+9VZRpDLWGzthN0s/SYeIugEnNJZGvOPSTpBH8
         qtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396389; x=1731001189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqvY1FdkPNuOeLMP1wREhSeYVKoRbaudNYxdHd3X7Lw=;
        b=uUBMqrUR3AHhX4BdccG+pOKV0DG1JZFL78Xoq7yho9Q/RrSVYRHKKwLmwO8soVAR/Z
         bqw4qLNHM6NsyeNsNv+AqlIzMLHniCRyjosf0kJDJejD/ePGb7tbLGTew1DOBMtPm6m6
         Sp2BQPlnNb6SEAbeP1MMQ1poyRWmKTWV0N+nDA4cg2PFrPNdDaMYOTakzZe6AsVW/Q7A
         M36qfb0K8PWE1KOM0mZoMmogdY2HC7UUTvvHpkZsLqN3t564MexwcsLNIXv7yRqPPtDX
         nrOP+WAaaeDQZPqc1/Zl+6aMUaK8udbttIEBVv4kjgql21QvFx/5bX6GpUhwlTaSRgh1
         ry0w==
X-Forwarded-Encrypted: i=1; AJvYcCWdyoWYQ56TImzi+XVgrOyo9GjUePzmLSBgzvuuWzP9xE5kRze3EXxUpslwiRy7sqZrVH4d6w+uILLH+Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2A10+5mZzASPa+LZLLYDcSiE7cUIFtjcU4tMhFV6Vbh2UGbC
	k3NkjLF4q4bMLkOtxtfgS3FjU/2AZPmMWyeTwet2K6HXG1x5gfog
X-Google-Smtp-Source: AGHT+IHznYfg7XnUHFbFmXkwCN88TMBnRAuRY9xjBHvTnqdJucFrQwoWQFJgSXdcQGNoUalg4yBOhw==
X-Received: by 2002:a05:600c:1c29:b0:431:50b9:fa81 with SMTP id 5b1f17b1804b1-4319ad368f4mr76025085e9.7.1730396389495;
        Thu, 31 Oct 2024 10:39:49 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6983ddsm34746115e9.44.2024.10.31.10.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:39:48 -0700 (PDT)
Date: Thu, 31 Oct 2024 19:39:46 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v7 4/8] net: stmmac: Introduce
 stmmac_fpe_supported()
Message-ID: <20241031173946.53ydl7v7gihtdkx5@skbuf>
References: <cover.1730376866.git.0x1207@gmail.com>
 <917f3868cdaf8ce1d45239117c3ea1c8c45ba56c.1730376866.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <917f3868cdaf8ce1d45239117c3ea1c8c45ba56c.1730376866.git.0x1207@gmail.com>

On Thu, Oct 31, 2024 at 08:37:58PM +0800, Furong Xu wrote:
> Call stmmac_fpe_supported() to check both HW capability and
> driver capability to keep FPE as an optional implementation
> for current and new MAC cores.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---

Doesn't this commit actually fix a bug which patch 3/8 introduced?
If priv->fpe_cfg.reg is NULL, we will dereference that after just
patch 3/8 has been applied. During e.g. a git bisect landing in between,
that crash might be seen by users.

Thus, please reorder these 2 patches to prevent the bug from existing in
the first place, and say in the commit message that the reason for the
introduction of stmmac_fpe_supported() - initially simply implemented as
a single "priv->dma_cap.fpesel" check - is to prevent unexpected
behavior on unsupported FPE MACs during further refactoring.

Then, the patch "net: stmmac: Refactor FPE functions to generic version"
should be the one which also reimplements stmmac_fpe_supported() to
check for the presence of the newly added primitives.

