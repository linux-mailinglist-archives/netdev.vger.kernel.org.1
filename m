Return-Path: <netdev+bounces-173588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EBEA59AEF
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED29A3A89F9
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE0222FE03;
	Mon, 10 Mar 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkBokQ9O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C8B22FDFB;
	Mon, 10 Mar 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623949; cv=none; b=KtilW27lv/GRIIPKiNWUa4cqOxABAZcFgVoBtSlf8Il2dOI70P8tXjDivQk2f2r59xO0a2s+Cn2pFaqd+3a/oVIK6eVhm997CNk32ccjyhSf/kao3uAqAm1f5de8ajIom+xoH+73PI1j+mAbyH/hDOYML3YtfntZTcYM4/RZXVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623949; c=relaxed/simple;
	bh=wvmdDKCoDaEru8Dl5f0QNShdKE18WMOAWrVkw03H/mM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPVkIe4i+XQtESnMEMdK9t4Qdote2Vi/STD0REDD8zyw67lEi3clsBD0VeRz16MdLcOh95u7d2T8OUcYSA+sya6yyq+FufsEq2RyRdxoqUNgVZbLMWGuhiuryNJeN7FRq0kwMQJgTXT7kQ2wq2pty3NMAWzZNZNiWXJWGIM/yro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkBokQ9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B96DC4CEE5;
	Mon, 10 Mar 2025 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741623949;
	bh=wvmdDKCoDaEru8Dl5f0QNShdKE18WMOAWrVkw03H/mM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XkBokQ9OhC2gPVk+5VQsLxbrKnkd6hnpAJBzbrTPjTKHo9Qkv2ZlOFtBRfkWIJh79
	 439Uil74VB7VwaVNalpI156hOq2CTmlpl+36UHbs5vFrDtjRBTDQpCP/Vqc2/GOr3y
	 Vpsf7rP2BKWXM/TOEUa8lf+Pv6Q9wgECGM+SgN4bSUnQeSLHKyWYuAMFUclWD5pm+X
	 ixex9jj4Y7uLs6j7qVbMirhNG7kI0TL1i/LiNagCm7FBjMjGTlpiT3tGvboUZEyVgF
	 UaG1SY2hr7GsEdN50+QPg+BEWQD0IP8dobwL6av9eClZS+UhXHhvD3YCgjNsZ1XY9o
	 9nJh5lfAezF0w==
Date: Mon, 10 Mar 2025 17:25:41 +0100
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Meghana Malladi <m-malladi@ti.com>, Richard Cochran
 <richardcochran@gmail.com>, <lokeshvutla@ti.com>, <vigneshr@ti.com>,
 <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
 <horms@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Roger Quadros
 <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: Plan to validate supported flags in PTP core (Was: Re: [PATCH
 net v2 0/2] Fixes for perout configuration in IEP driver)
Message-ID: <20250310172541.30896e20@kernel.org>
In-Reply-To: <f7072ca6-47a7-4278-be5d-7cbd240fcd35@intel.com>
References: <20250219062701.995955-1-m-malladi@ti.com>
	<415f755d-18a6-4c81-a1a7-b75d54a5886a@intel.com>
	<20250220172410.025b96d6@kernel.org>
	<a7e434a5-b5f6-4736-98e4-e671f88d1873@intel.com>
	<f7072ca6-47a7-4278-be5d-7cbd240fcd35@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 15:48:27 -0800 Jacob Keller wrote:
> Would a series with individual patches for the 3 special cases + one
> patch to handle all the drivers that have no explicit flag check be
> acceptable? Or should I do individual patches for each driver and just
> break the series up? Or are we ok with just fixing this in next with the
> .supported_extts_flags change?

A mass rejection of unsupported settings feels like a net-next material
in general. Handling the more complex cases individually and the rest in
a big patch makes sense.

