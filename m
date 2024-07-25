Return-Path: <netdev+bounces-112887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E693B9C7
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 02:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20C31F23DF5
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 00:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B681E;
	Thu, 25 Jul 2024 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fgtu0ktE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E0437B
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 00:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721867137; cv=none; b=oAc0R5dBeo91fboFOF0QJTlL9d4ZGzcsw7rYrJ0PVscYdYl6KnXdQDlC1DQsv+rk8o7QF1/rM7glx/GKq5nRSYCm/o8Wu/NG87tTi/mlZKiagZ01PhaHHYRDvQ2b5rWbCR9qnZml1f9e7puKtgT0jzR1XpwHI2+f5G6LL3xq2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721867137; c=relaxed/simple;
	bh=RqIl+pnrtL+oOFDpxShlqJqZcIaTlxfkW81hjhTSh48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOuMyBjqrMY/z5YXKkK7nKGLlIyVKySabv8HXQ05l/Rl2LeBhqYf2CcboPP0/lP6ntNXfpg1QY/GTtfDGy3YDbEhuZFu8psRTyaI+hkDSZkW1VjjMddq3oabORvyfQ7pkB/LGlZ+OTYF3tHmCxW6veXa7LQiIRp2cDCiGqapPxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fgtu0ktE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CFEC32781;
	Thu, 25 Jul 2024 00:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721867137;
	bh=RqIl+pnrtL+oOFDpxShlqJqZcIaTlxfkW81hjhTSh48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fgtu0ktEUE0NSEqqGHjd5MPRti2Y0SAHUGlFSxmookO+3HG5bPle2cS96T7viOl8I
	 cTR6tzGwAPbO/ecN4ba1Ts9484sg1a9TPY++N5g9wwxVrcMjz2sBKDGz3Jc/7wtiBD
	 +zDqaui64UauNc7cvUh62vUvg8bxnjt4Yzfpcs3Wvm5W6bVsYdu1J5qYtMntIWZqnN
	 hnc9i25UN1hNwQ9ff1A1mRIrtRRGp/26nNCjrMW33FND582BbpcxgTpZ6qkBIkU50g
	 dMokFC/KnFssHYkEGet09pv8DKZkqlaw1uNZh9dGcSBGT/RrU3fZFIdTdiYY/Da6dv
	 Qt+6guWmb+DeA==
Date: Wed, 24 Jul 2024 17:25:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH] bnxt_en: Fix RSS logic in __bnxt_reserve_rings()
Message-ID: <20240724172536.318fb6f8@kernel.org>
In-Reply-To: <20240724222106.147744-1-michael.chan@broadcom.com>
References: <20240724222106.147744-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 15:21:06 -0700 Michael Chan wrote:
> Now, with RSS contexts support, if the user has added or deleted RSS
> contexts, we may now enter this path to reserve the new number of VNICs.
> However, netif_is_rxfh_configured() will not return the correct state if
> we are still in the middle of set_rxfh().  So the existing code may
> set the indirection table of the default RSS context to default by
> mistake.

I feel like my explanation was more clear :S

The key point is that ethtool::set_rxfh() calls the "reload" functions
and expects the scope of the "reload" to be quite narrow, because only
the RSS table has changed. Unfortunately the add / delete of additional
contexts de-sync the resource counts, so ethtool::set_rxfh() now ends
up "reloading" more than it intended. The "more than intended" includes
going down the RSS indir reset path, which calls netif_is_rxfh_configured().
Return value from netif_is_rxfh_configured() during ethtool::set_rxfh()
is undefined.

Reported tag would have been nice too..

