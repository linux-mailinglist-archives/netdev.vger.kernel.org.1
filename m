Return-Path: <netdev+bounces-164777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78833A2F08D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED091889DDC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F114239072;
	Mon, 10 Feb 2025 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pev92nib"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D41237717;
	Mon, 10 Feb 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199508; cv=none; b=S+Jj3V+h0G/4A26TNRkWBg0pMwjQyD12fEBYMr8VojGo9qtH9CvKmcrL1GikOYSoejS9RaCqiCw+nhXhHbLZcIr8VyGiNiaTMezTCNBxwAnoO+ZZwOnR6YVxrm6MMcMp4BfLrKsrhNc1TlwD/3ASlKS2sV7Mr5Kx7uFZyWvR17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199508; c=relaxed/simple;
	bh=lNe0mZFoZDbbCnGKAeb7nhDZMeQMOeBsOMs6KbIvGMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tP6dD1bgyNPrcSZaqUYz5d1zglx0qUkZGD9UckWcfhtCTTR+waovDAwcb4uPxDfQYC11At9mwLU1apyC8UcRqyqpQJreGQZRQi0hsy68C/H19EDfnk/SoiWozuJTjTtnjjS/Qbw+IMCDBC/czKWHjoraxXysPhXqKIt/LvpFSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pev92nib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284A7C4CED1;
	Mon, 10 Feb 2025 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739199507;
	bh=lNe0mZFoZDbbCnGKAeb7nhDZMeQMOeBsOMs6KbIvGMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pev92nibWQAIsa+j//NG3oi60URV8IstozxTcs9QE4oxHRTtEvFUiW0NJ8BYziZcO
	 MRWyoBzpFe/1g9MuRVxlByBkXW5GzzvPkkS1LwFRcDqz6U5hRX4cQXQqi8CADuWgtm
	 Uj7uIVnJ/b571wAy6F3nxPPolUNrsosgXvH+MvJPPLgxp16ygUwNWOdf964ZzTv8vP
	 x51WXs3cVKQdODZamGOyaVVFqvVaANVJ7CCZEAg+JZAfqRO3r1WeGsrtZD3Rqitm+v
	 3H5QbJ/Q3FdQy1Mctmg02ijs5DUoEgjc+IrekhIVjGMmNv8EZu1EIGNF711NkIWtYf
	 CngAr2r6LyYow==
Date: Mon, 10 Feb 2025 06:58:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Piotr Wejman <wejmanpm@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: e1000e: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250210065826.63a8822d@kernel.org>
In-Reply-To: <20250208154350.75316-1-wejmanpm@gmail.com>
References: <20250208154350.75316-1-wejmanpm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Feb 2025 16:43:49 +0100 Piotr Wejman wrote:
> -	if (!(adapter->flags & FLAG_HAS_HW_TIMESTAMP))
> +	if (!(adapter->flags & FLAG_HAS_HW_TIMESTAMP)) {
> +		NL_SET_ERR_MSG(extack, "No HW timestamp support\n");

No new lines at the end of extack messages, please.
User space adds its own line breaks.
-- 
pw-bot: cr

