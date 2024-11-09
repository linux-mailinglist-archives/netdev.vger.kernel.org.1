Return-Path: <netdev+bounces-143539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E149C2EBA
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717E0B215DD
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 17:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACD719D8B4;
	Sat,  9 Nov 2024 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSmwu6GJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49109154445;
	Sat,  9 Nov 2024 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731173161; cv=none; b=oglrj0Y8joAT3T90w9x5HkL1xeIXx+CR61HP6JIMo9G957u7OIGBqFlA1CwO10eaeL4VG2ih/OdRNtq+xMTjEblBY6YRvX8JBjgswYHIM3vq/0Noh1h1SAh5Mk1yUsYSeCMIsEZ2rxw7cEphHaRLyYwy+C7w02EO8o2LmqASYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731173161; c=relaxed/simple;
	bh=rcO9lETf5/Rs/eltH9MWb45jkbf6qDnS12leP9TXLNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlGTbggwxG5a/LFNx0j82qALtKmbjGlE4M8fA1/fldd9yDBPXVPERDyN3jg/YQXvkd5ttek3HNQ8xGfOstZBM/4UCg56ZmxGm4N6BGfXGCEmjgUqezh/lhIW9P4FfrbcROYwtXdwjFjQ5cTMyzs7Gsd4LNOpd/hPS5e86kfCg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSmwu6GJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05576C4CECE;
	Sat,  9 Nov 2024 17:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731173158;
	bh=rcO9lETf5/Rs/eltH9MWb45jkbf6qDnS12leP9TXLNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aSmwu6GJfaKu6wiV/j6acgoQdPtnNiHlBm8sle99pnv+6dgHFZoXNUQ79eVl9V5n4
	 fAV0CPn/vDuXWH3HJqEfPg7lleXRKN/IKBsRRljo+xfZZscW69LCuh08fRb7RiFVZM
	 XxmzKeg3jc51p5L+d3wvbkNTWKFywq2Dn0brpETCGSU6S+Q3UPfkDfQFIQGcRFyJVw
	 euDPGzDVc0u3D0Rz0UlSRqzDoWgyLBRH8kAEqJ6g/Mrjmv3jpe3f79yOw9idxBcr2M
	 LVKH4/3PdYkytWScG7eeM1zdYHNF7aO9WTUbXOSrO3E8pEjrEnTv72x/C7BGfMY5cn
	 56F4xPzTIJHuQ==
Date: Sat, 9 Nov 2024 09:25:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: michael.chan@broadcom.com, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, pabeni@redhat.com, martin.lau@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] bnxt_en: ethtool: Supply ntuple rss context
 action
Message-ID: <20241109092552.3295381d@kernel.org>
In-Reply-To: <384c034c23d63dec14e0cc333b8b0b2a778edcf1.1731092818.git.dxu@dxuuu.xyz>
References: <384c034c23d63dec14e0cc333b8b0b2a778edcf1.1731092818.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 12:07:29 -0700 Daniel Xu wrote:
> Commit 2f4f9fe5bf5f ("bnxt_en: Support adding ntuple rules on RSS
> contexts") added support for redirecting to an RSS context as an ntuple
> rule action. However, it forgot to update the ETHTOOL_GRXCLSRULE
> codepath. This caused `ethtool -n` to always report the action as
> "Action: Direct to queue 0" which is wrong.
> 
> Fix by teaching bnxt driver to report the RSS context when applicable.

Ah, so it was a driver bug after all.

Please add a fixes tag here, add a test case for this in
tools/testing/selftests/drivers/net/hw/rss_ctx.py
as a second patch of the series.
-- 
pw-bot: cr

