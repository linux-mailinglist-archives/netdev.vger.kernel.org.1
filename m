Return-Path: <netdev+bounces-139344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44E9B18FA
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 17:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9B21F221C2
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1101DFF8;
	Sat, 26 Oct 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhtdUj5w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9FE42AAD;
	Sat, 26 Oct 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729955571; cv=none; b=KQhWTtJd2FxNOYSWskj99z1+DecAxjjER7NokYsWNhcOEtZLfID6EOwiEIGwGnSBPweYqd90CAClGlPxRN3UEF3FDmi8oxnBg4M7ApEhVSVSRdI5oe8tNtboUP91mVfczu83uuU9TzfOFBMDF5mNnP6PcBIlDTYL6Jdd0r6HhgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729955571; c=relaxed/simple;
	bh=o/tai8lTXpGy8rXeA1w1NQN7NzD/+6wcZlVFRd/HqZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r026KSNOvFO8h9dBBRW1HYBaNazCIoco0kM4zZCE0dbDqI9fKk+p+yrSxNgPuCRTObg5KOdHLhbBdMoqu0+vR/WbJoOw+ilNgolJd/4XYtaOHpTVvXfytme7ZIo7Xws8Az8KznSL2HCh05emypRzY74OpPjeIbW8SlknVLzqkHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhtdUj5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF0CC4CEC6;
	Sat, 26 Oct 2024 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729955570;
	bh=o/tai8lTXpGy8rXeA1w1NQN7NzD/+6wcZlVFRd/HqZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhtdUj5wqpY4ZVVctf4BYOBA/JClQkc6Wt7NAqBo0Q7lnF2Ef+b8ZRmiRm0ok8sXV
	 bFI0QAHBnwXvUuATUF0HumLA/9+jyqGjZQywH28RbXxma9uMQKCK7g4qyg7RFb94qU
	 5YMPD1CiXVaM+It0Pprr+cBwgaFsJ9NqcTml2Z28A573ckSYret/2UY8HssPZbqNBO
	 SyA5kE5L8YuO/NTi1ST7Ia8T/7nFx1lAmDXjeXONzVonrg+SvN7XXnpHNggMsIKeRQ
	 Dl8p0nPOnKw3fXadevvquatGZr4qNFGqbe4T4s4bQUIOX/GNNTTOcU/RU4o47mlBTd
	 8frpJ+pYFKtzw==
Date: Sat, 26 Oct 2024 16:12:45 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Sanman Pradhan <sanmanpradhan@meta.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] eth: fbnic: Add mailbox support for PLDM
 updates
Message-ID: <20241026151245.GH1507976@kernel.org>
References: <20241012023646.3124717-1-lee@trager.us>
 <20241022013941.3764567-2-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022013941.3764567-2-lee@trager.us>

On Mon, Oct 21, 2024 at 06:37:46PM -0700, Lee Trager wrote:
> This adds driver support to utilize the kernel completion API. This allows
> the driver to block on a response from firmware. Initially
> fbnic_fw_completion only has support for updates, future patches will add
> additional features.
> 
> Signed-off-by: Lee Trager <lee@trager.us>

Reviewed-by: Simon Horman <horms@kernel.org>


