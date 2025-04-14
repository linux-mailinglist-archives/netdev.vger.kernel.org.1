Return-Path: <netdev+bounces-182434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC5BA88BA4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350CB3B5662
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D328BAAC;
	Mon, 14 Apr 2025 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E12PzeVZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77E26E16B
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656271; cv=none; b=cOKsdWj1tMdavHGVN0OZxxcHJQDJWqWn+0JhqeXlRPn5ozIIBKvLKSoMbMYDKJOQXuU1PLfEThwemBt46vY2GBZYIMHYya6KsCXPpzg3vjzFCOIcy/qJit3WuRVP26JFlojfg4sLxCMHG6E2W1OCq/4Y02ZmS79goT/6jkuWs7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656271; c=relaxed/simple;
	bh=YpSfHpLk4g82/Efaxxr4vcOeA7lwSVP0ZoulsVdeGLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Raed8jaeW6dLObWDGGQEuhWq8AGRTa/fJuFlSToScBnNW7V67HnjrEg0ahvlG+zE9ClXHPlRHGSqr8EjLJNSAhY9Wa4sAnwuvLiO78IHtGuXUcPwOz5Hpe9AGbrf+YQNjs/4iT9DgRLh35KKGpSInkWFEOBrTvvH/qaRnbszwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E12PzeVZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so4048832a12.3
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744656269; x=1745261069; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YpSfHpLk4g82/Efaxxr4vcOeA7lwSVP0ZoulsVdeGLY=;
        b=E12PzeVZu5Exwy8LyxFk9HWgo0LQ+XxMijoqt+C1B+Mp3AYP3HgimWmrf9iOztUsrf
         4UHJRw1rgGT5K2jugGhaZYNqMS6qBc4LSCCwbOjuZ1TPhvHD/SZzcqq2/oTv/wxv6qsY
         hKoy7XFhw7AZeIAB4v0NuPvLvGIFSngF5FTv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656269; x=1745261069;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpSfHpLk4g82/Efaxxr4vcOeA7lwSVP0ZoulsVdeGLY=;
        b=dzHYLNXKI0qL3KfZdf+1bOFrXnaLg3/zRnVf/EXYrEdL/og/ZM26uJSQaqetIFITmj
         AzUKMfL+92b4i13nUkCyE3TbE0z1tpnO9XdF612jyqgd27iDD/HGEmXVTDxMJY1A1P16
         9ajUR5J4wpKw0I9mi07aYOIriLbu4KB34dgq/jZMPp6urv5aISKOYLTe0LF9GMkSKA+j
         T7r8N4gWsSiiGVjYZLuSWVm1JE/LsMmobE3Bh5kZtGhDwwQ2RMe3hUF48pev6ZXmxSKN
         D3VR6e6kFxAgM9yGcw7+bWrldJ5VmTQw9kPluxtijxs2U1yuWuwydl9ce9Kso45vF5sP
         zH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMqWd1VxXIEWozVnrtU2yGfUu0f6vrzSAxAV38IBbZOvWU95Vws4iEKvDjSsstGPtdSIJXFZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsb0aS4BzBZrZdh/Ngb1BKM+yEFL1X7lLq6LgRqHCnhiCqfwCz
	7wiGmJx1R8nSUHzFL0H13rtzAtaVP6a49kfHlcEF9rsmbIPs0b8/S/8GAKRebw==
X-Gm-Gg: ASbGncuVO/t7JiTb1Pj3AwvTXSe2xXaru2Oy2Op1RiHzSZ7aY2AQMAhXpCHSNiOvq9A
	YJ2tBj3B28DdeLq7M4gUYepUr1SqvaA8JRs+OxwvZirVkqYlpCcsX9TGZJML+oW74r2hdmNA+d2
	/JJriXVGV6FjaJGXCTqYu13lwcmFEstRllSbMeOaQR6E1R0ttomjQGxQed8TYzJkrMqv7tsZS4D
	OEVhgztxNNE4EjLk1npO6lnJ55P1O0N38aBJ9ppIWLfX5dijuD/lFnkAwEjFuD/+cXWBULG0ka0
	1cOccbXlsdXhYFeHUy0PG6qxbDKDThjtKEoP5urWavtyyk8snLKPxI/KPPPFcetd6sgSo+MKGT6
	Mzw==
X-Google-Smtp-Source: AGHT+IHRnGevNVFCEzzLtuARDY+GV3b1ySMboNdXjtt9nCxP859MMeYdEqvd7RpkkuyGR22MEOT6ZQ==
X-Received: by 2002:a17:90b:2752:b0:301:1bce:c255 with SMTP id 98e67ed59e1d1-308237ba788mr18304386a91.27.1744656268888;
        Mon, 14 Apr 2025 11:44:28 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:cfd0:cb73:1c0:728a])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-306df082327sm11386410a91.15.2025.04.14.11.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 11:44:27 -0700 (PDT)
Date: Mon, 14 Apr 2025 11:44:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
	ath11k@lists.infradead.org, ath12k@lists.infradead.org,
	wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: Don't use %pK through printk
Message-ID: <Z_1XiNY2ujreEo69@google.com>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>

On Mon, Apr 14, 2025 at 10:26:01AM +0200, Thomas Weißschuh wrote:
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk().

Is this really true? Documentation/admin-guide/sysctl/kernel.rst still
has a section on kptr_restrict which talks about dmesg, CAP_SYSLOG, and
%pK, which sounds like it's intended. But I'm not highly familiar with
this space, so maybe I'm misreading something.

(I do see that commit a48849e2358e ("printk: clarify the documentation
for plain pointer printing") updated
Documentation/core-api/printk-formats.rst.)

In any case, even if the advice has changed, it seems (again, to an
outsider) a bit much to say it was "never" meant to be used through
printk().

Brian

