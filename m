Return-Path: <netdev+bounces-190630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EBBAB7ECF
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23772167D53
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0D20298E;
	Thu, 15 May 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmoydwrd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387310FD;
	Thu, 15 May 2025 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294171; cv=none; b=Pkyd/MBg5JyBeqDrmVJot1bI3juIqlkzgOQAKXjKaZt5atau6+VoV6lN/qP66hWnz3UDtWb2BFdtSTiqjHaOUGoiDT3jao2o7sy9RD46QHkkYTd/vs45LGqW6kPeZFMsDvXqmaZPu9iINhIczNbgvj8pygBuLiE/Qk/1eFgYr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294171; c=relaxed/simple;
	bh=8S4//SS94aP1NtYNL6eqkDynPtiXbxJWNGCHYzi1LBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaUEZ8OpJ4bUC7Qmfx+PsndbgXJL8gAZGU2+ueSzQLWiSDNhUg0UP7tYmVT1UR5erajPVT2+bpB0P1FqZ+t+0KpZKaQ4W0b1LOOpaROVFuVvFLofNdPkgX7HONZaesWW2LhFgxjGe7TMU+HgzSIORKMPyeOCEZbQDNVjLOSEe24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmoydwrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B1DC4CEE7;
	Thu, 15 May 2025 07:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747294170;
	bh=8S4//SS94aP1NtYNL6eqkDynPtiXbxJWNGCHYzi1LBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mmoydwrdXlPv2WN5WdafzZHAk03wcsQ7VRjT2fZP89+E7N0XZQ1WYr8+nLGeOvsyW
	 SUIdLbAxZYTEK1wL7w/mI5kk+sMjBv8Sa7MnQUpsU+4sqVwM57Ym3w+OA8sqSGaIq2
	 v5GzO789n5ZgZ01BsiIWlXfisnTCycHR4gP9NTOxZDW/GVu5mE8cMGYK/BOzwxKs3e
	 KnzZ8Uosxkzw3UmRa0o/n7Zyi6ggCHZQDgjrwKSyxTkMvxRKQ6lPpnpo1vgxGZoFP0
	 /yx5c3ZxcNJzPyLaqTC/oW1VPWDCbTnc3eiSESxOhiHvlhQzyYlNF3dj6c6UF0NMg0
	 CAmL423Q79gzQ==
Date: Thu, 15 May 2025 08:29:26 +0100
From: Simon Horman <horms@kernel.org>
To: Zak Kemble <zakkemble@gmail.com>
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: bcmgenet: tidy up stats, expose more stats in
 ethtool
Message-ID: <20250515072926.GP3339421@horms.kernel.org>
References: <20250512101521.1350-1-zakkemble@gmail.com>
 <20250513094501.GX3339421@horms.kernel.org>
 <CAA+QEuT0tPd0Qxjy0LP2zXhRhAe_bRv5omFPaFdbHVzoBAO-Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+QEuT0tPd0Qxjy0LP2zXhRhAe_bRv5omFPaFdbHVzoBAO-Yw@mail.gmail.com>

On Tue, May 13, 2025 at 08:26:47PM +0100, Zak Kemble wrote:
> Hey Simon, sorry I'm still figuring out mailing lists lol. This v2 was
> submitted after the kernel test bot had replied about a warning, but
> before anyone else had a chance to reply. Latest version is here
> https://lore.kernel.org/all/20250513144107.1989-1-zakkemble@gmail.com/

Thanks, and apologies for not realising that before I wrote
my previous email.

