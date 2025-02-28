Return-Path: <netdev+bounces-170702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F02A499FD
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769BD166B06
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91B26B966;
	Fri, 28 Feb 2025 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aowUiikj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342826BD92
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747118; cv=none; b=iT9RVn6iwU3Pm9YGuoUCebiNAG64JzmZAiUVr91KbyQCzG3eRlBXIAVerzULByTUDh6ljtqpi02gPkdwx9yanvAN9ONaTCvX5sXkge+14lkoQko1wGtxDSjVKjMIMksAegUy1S6fgjpGzp2ECA02ofEMXeaXwBN7jodQa53DQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747118; c=relaxed/simple;
	bh=gXgJrT/MKS2vYXGjt/QlluYz1GHJ7nB5TVW6gPh49Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kxe80C0CSD90MP0huRL0r6yT6zos6r4nf05WwMkLfLIG4/Kn+2n3v18BOnr5t1E9ZnYxdyZyqJmIfbK28o6XwYuJfYjTUQJjZfO5PactfOS4GbJ2sB2TWz40XR9b6ZXBFg2DdnG37v6hmIqCguZwB+IVQtFtly0lz5DlUFKCfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aowUiikj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf06950db5so314784766b.1
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740747114; x=1741351914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXgJrT/MKS2vYXGjt/QlluYz1GHJ7nB5TVW6gPh49Mg=;
        b=aowUiikjYdBxhkP0Oa7v3AcQufF0O4EQeNVCNdJuOTdbCqf82ctEZ7qrYccKITIrWr
         KORymmtBQ1PV3eSFFyn9W2XFRU/JT/D3numXmLyp1JTtuIrMK0pi1eDWD/gPZtkgtV4K
         wL/7/H1pNPtU3D/wOS68PdLuAALKSPZz46L+E9cD1FbknHWwFul53Bl6GDf30HpW5z9+
         JHJvtTqs0JKkQ6FD0GW/hE+auQjMgHgZrHDOvrI4U12aZ1rrN0LmouXQHPMjCLewI9TE
         cbhfG3LcQIJ58t0L3ZWE6irRDI7rP8WLIHjvOj+s2HMgwGvXTNvcWxION9/vnnTPtmSH
         momQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747114; x=1741351914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXgJrT/MKS2vYXGjt/QlluYz1GHJ7nB5TVW6gPh49Mg=;
        b=ouP5nxWlV05wH8OohqCwYVZp3wkLmM9FdSyfMWBOrx0WteA+SDDTWyb/fekW9M7SvA
         SURQwXMdemsHEQ1doXfxuiGSb6KsG+1YtRSr/zjuFO+Qo5MKGXf0rlTJyEuC1QCnqv36
         tGRMnbuc+LNjAbW2Co5RBP73/2WSe8fH11LGWwslkV2gFc5PbcKaWf8YjG0f6NvMdaJu
         jQCVV3UlOG8NugQPQcjdb6vyy8ro0ISYwGVbVFj1NaGAmYQ9LC8gDJv/fAO8q2wrhNx4
         fRUTgHj2dVBPF0XhhAeQkPpKeFQQuZgn79ngmpx/44IN0X4S6r886sOHyMLPhEAuoBXz
         /PWA==
X-Forwarded-Encrypted: i=1; AJvYcCUZEUwtHAdbWfIGjT9SZuAyWu9E9DawyIaxiiVc5H3xp/gSKZhlDlq2hedIenH0p5yOgyfTauc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt7RPvRTFEFZj/i2gi6FjCywIJDYXMlo4quzHMHDZ8vq+Mj/H7
	tPPo2qJ7/qEp5nU+PXM0UDUYbAiBM4dj3L2AjKzXfAT5qxrvY0sP1VgF0+Uvv4A=
X-Gm-Gg: ASbGncvNec2z8D9wvWJR/IyY+m6MjqCFBtVWUnCIoOEfT/3W8B5eyrvKQMgB3ozolCj
	mx8YuUGBWLY5VxX/NRdo9lHvY3SxEIzbmbQtcliADnVNG7GAGkXSB5+v52yDlZ/M/GWGA7Tx8eU
	ijjVM3VAWCJKrJUcDSmRKr9r0aDg+NY0Fl4FMFfK3lbNTZqI9tqceemIsrUxnUzV3vmxgfwjTF5
	ysMdCAKgmegPep8LdWPev07Z0v2ofmBTYi463wq9xABhmYxanZ8bbmA8hkXmAjva5bA0rntkkmX
	cPorkwHU3ticlZhr9pXxBIoyLYtvdGFJupg6qV+gMjJTaE+waZPi0A==
X-Google-Smtp-Source: AGHT+IFYmYU1R7ifbjSZrpbkuYFlGGasWOV7+e8OvcoA9fQEvaqNkU37Uytka0OLE/mx3KbPoust7w==
X-Received: by 2002:a17:907:9446:b0:abe:dc71:883 with SMTP id a640c23a62f3a-abf25fcebe4mr284416966b.19.1740747113645;
        Fri, 28 Feb 2025 04:51:53 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b99a6sm290835766b.13.2025.02.28.04.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:51:53 -0800 (PST)
Date: Fri, 28 Feb 2025 13:51:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 11/14] net/mlx5: Implement devlink keep_link_up
 port parameter
Message-ID: <gbm5hz3x73n4peyho3v57xk244dsdixshxldhlo57gnyfsyeow@6ttickkw34gx>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-12-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228021227.871993-12-saeed@kernel.org>

Fri, Feb 28, 2025 at 03:12:24AM +0100, saeed@kernel.org wrote:
>From: Saeed Mahameed <saeedm@nvidia.com>
>
>When set, the NIC keeps the link up as long as the host is not in standby
>mode, even when the driver is not loaded.
>
>When enabled, netdev carrier state won't affect the physical port link state.
>
>This is useful for when the link is needed to access onboard management
>such as BMC, even if the host driver isn't loaded.
>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

