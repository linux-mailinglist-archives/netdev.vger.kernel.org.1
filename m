Return-Path: <netdev+bounces-216747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF15B35076
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAF53BE1AB
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B055D8F0;
	Tue, 26 Aug 2025 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeFWRknx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768671FC8;
	Tue, 26 Aug 2025 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756169143; cv=none; b=iJx6RDUKMjOHzsGRWX4ZgOjYQaAO5RUELa6MWyDkbM22E1mpB7QU+FsNoWcNHwAuXnR4LDLOF/xMlXb4iADXTxlf1sO0FuighQ0b4uTlIcrkJoT5xw2mH1kvJ85pkz/nkOJK1qNWaNR8UW0aXEx1dxkchm503+uubGp/9Dcake4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756169143; c=relaxed/simple;
	bh=q/ApEimL52B+G+oVZ7OXV1FFoAOegw1ViaoJS/+MNwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e80Xi0O5DV/08O2MmtZvtvJzzxFI1Ty5FUvIQj7gsw5PJJrcfWif4dQZcNrc76BbZtwhH9yfQujXx2aAh0SXiGNAfrEHIr7EVowZZQnfTwTZDkHjUW/G32tPFpVcJ1PFpp0OGnqBvEyuw4ziANsjvKOmoaN9FsCgMBw05lJiYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeFWRknx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D56C4CEED;
	Tue, 26 Aug 2025 00:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756169143;
	bh=q/ApEimL52B+G+oVZ7OXV1FFoAOegw1ViaoJS/+MNwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XeFWRknx/CgQmmppS1Rtba/7nc3xKgrrDbrqRIsjNm76sSC5ssitJPyJA+9jdmqYT
	 /y1w3s2Z3+CLijpYNUBejPdahHObW9KZESVOZvcq5d2aRf6gcgb5zBTKVfMZR92ry1
	 H0WIe/NbPWHWfJi0QHSpe/XsBF3zd9izXQH+u1FdWAUbo99DtmuZWCYEs+bvf/qEY9
	 7D4WCLPHNNEiqWCo5hXYP/lTYvVqh8YJmdK5DLwkja546HjMjaqDrm1GhxXKVtzvig
	 NLNc2GQJ9kN0vxrJFwDQtbpWlhIIz25ZDiozANlylK5Easv94FoPCvUzZQmh+KB63U
	 gZFiv5l6M3o1Q==
Date: Mon, 25 Aug 2025 17:45:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Harini Katakam <harini.katakam@xilinx.com>, Neil Mandir
 <neil.mandir@seco.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>
Subject: Re: [PATCH net] net: macb: Disable clocks once
Message-ID: <20250825174542.2ece797c@kernel.org>
In-Reply-To: <20250825165925.679275-1-sean.anderson@linux.dev>
References: <20250825165925.679275-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 12:59:25 -0400 Sean Anderson wrote:
> From: Neil Mandir <neil.mandir@seco.com>
> 
> When the driver is removed the clocks are twice: once by the driver and a
> second time by runtime pm. Remove the redundant clock disabling. Disable
> wakeup so all the clocks are disabled. Always suspend the device as we
> always set it active in probe.

needs a rebase:

$ git pw series apply 995325
Failed to apply patch:
Applying: net: macb: Disable clocks once
Using index info to reconstruct a base tree...
M	drivers/net/ethernet/cadence/macb_main.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/ethernet/cadence/macb_main.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/cadence/macb_main.c
Recorded preimage for 'drivers/net/ethernet/cadence/macb_main.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0001 net: macb: Disable clocks once
-- 
pw-bot: cr

