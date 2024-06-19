Return-Path: <netdev+bounces-104903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D99890F14D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531471C24565
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCE81EB5B;
	Wed, 19 Jun 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt4glaN7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E8B1CF9B
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808645; cv=none; b=D9FqGlSFBK8VBTLCZsZ/EvexACCg82qLZbXIXJWJW7+WWoeA6f19qDDNDgt3w9RK+oI920GdA3AFEKU/P7V4agTnU6qAlm1ZJy9Z0m/VsalhyNJtaF2NBVqHWXZHVUnr6aBdSxNUkbcQ5+sSFOgsEnf7x3KRf2YbqYu406JynIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808645; c=relaxed/simple;
	bh=PUg7u/58aUVTQu7aZ+isi2XPmvodA5MdjIyVBgBFKOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjPRcQlEyTLyRJWDWeiY/JYwYLNyQh3OSPceIs5KpLDLdQiWrM+7qT67lKibTxsvW5RjcyThrS1gIqaq8DR0ny787eSn1g2Ypto4i9+yjujKi6O0OSRtvcC7yblN2K1CrUhlMRqziL1F3wYbLbDKVHzXwhLtXwekHGyoGlpUPVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt4glaN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AACCC2BBFC;
	Wed, 19 Jun 2024 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718808645;
	bh=PUg7u/58aUVTQu7aZ+isi2XPmvodA5MdjIyVBgBFKOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qt4glaN7SRBm/7srVjptXrvVJGDEYBc0inde6n24LWzH4KHOuRBGCIxB7xbVKrshr
	 421wv1XoryYnkq3hhFJ/6UNN5XuyVTWklQ4yDBPAjB3oSTEWULAohSrMeHDB1Sa/wG
	 QRSt4aGN7TDTe6LYNNy/mu/zut5ybTtwIF9Jow+gQvh+wRfOCPH2SO24oY2/+fPAd2
	 6/QUU4/kQwr+TqkhwiGX0kTueQV4MIvYNCvrcCAs8p5oMom1vTqGG9HSgZ5U532Rf5
	 3kkcbhqFgIRNjVYvJPb9kPBxam/DKVB6icL1v+udB7Xr7/XEJz1F+Pm6NWJpQPeStp
	 fp8TCmcC+LTlQ==
Date: Wed, 19 Jun 2024 15:50:40 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	mlxsw@nvidia.com, Maksym Yaremchuk <maksymy@nvidia.com>
Subject: Re: [PATCH net 1/3] mlxsw: pci: Fix driver initialization with
 Spectrum-4
Message-ID: <20240619145040.GH690967@kernel.org>
References: <cover.1718641468.git.petrm@nvidia.com>
 <782b8dfa5a4b6adb0ef9b56303037fb0cda19226.1718641468.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <782b8dfa5a4b6adb0ef9b56303037fb0cda19226.1718641468.git.petrm@nvidia.com>

On Mon, Jun 17, 2024 at 06:56:00PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Cited commit added support for a new reset flow ("all reset") which is
> deeper than the existing reset flow ("software reset") and allows the
> device's PCI firmware to be upgraded.
> 
> In the new flow the driver first tells the firmware that "all reset" is
> required by issuing a new reset command (i.e., MRSR.command=6) and then
> triggers the reset by having the PCI core issue a secondary bus reset
> (SBR).
> 
> However, due to a race condition in the device's firmware the device is
> not always able to recover from this reset, resulting in initialization
> failures [1].
> 
> New firmware versions include a fix for the bug and advertise it using a
> new capability bit in the Management Capabilities Mask (MCAM) register.
> 
> Avoid initialization failures by reading the new capability bit and
> triggering the new reset flow only if the bit is set. If the bit is not
> set, trigger a normal PCI hot reset by skipping the call to the
> Management Reset and Shutdown Register (MRSR).
> 
> Normal PCI hot reset is weaker than "all reset", but it results in a
> fully operational driver and allows users to flash a new firmware, if
> they want to.
> 
> [1]
> mlxsw_spectrum4 0000:01:00.0: not ready 1023ms after bus reset; waiting
> mlxsw_spectrum4 0000:01:00.0: not ready 2047ms after bus reset; waiting
> mlxsw_spectrum4 0000:01:00.0: not ready 4095ms after bus reset; waiting
> mlxsw_spectrum4 0000:01:00.0: not ready 8191ms after bus reset; waiting
> mlxsw_spectrum4 0000:01:00.0: not ready 16383ms after bus reset; waiting
> mlxsw_spectrum4 0000:01:00.0: not ready 32767ms after bus reset; waiting
> mlxsw_spectrum4 0000:01:00.0: not ready 65535ms after bus reset; giving up
> mlxsw_spectrum4 0000:01:00.0: PCI function reset failed with -25
> mlxsw_spectrum4 0000:01:00.0: cannot register bus device
> mlxsw_spectrum4: probe of 0000:01:00.0 failed with error -25
> 
> Fixes: f257c73e5356 ("mlxsw: pci: Add support for new reset flow")
> Cc: Simon Horman <horms@kernel.org>
> Reported-by: Maksym Yaremchuk <maksymy@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Maksym Yaremchuk <maksymy@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


