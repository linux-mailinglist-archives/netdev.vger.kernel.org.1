Return-Path: <netdev+bounces-111445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C6893112D
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3923EB22368
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9301862BD;
	Mon, 15 Jul 2024 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWitRA/7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582C76AC0
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035706; cv=none; b=IHABiQZwVGMDkG3erdcWHTWnV1QyXvP31PnP7BEH3q02N23OH5WFosJh/eCBDuBaH/Mr/2GIr/0p3Yr8cycou785bC4LVboXJ1R49wkVRjD9YKKb9x/FKlNFb/KpQhZn009QpGo6PFdpYRpeDck9zmotXep+N+bL0vX8z/U5jQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035706; c=relaxed/simple;
	bh=brXKPzeKHaL5JOnRb/wvtuUnXrOYR8fE75F/JPW3LBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpkMEUjpMjnWbiynv2SYRDumAGEl95XJSjgFkN7A6tmI7r+9oiXXIBfNzlWsuuHwQCa+0hMfLgmHHb865ocQKiXWqtuMErZEiBOWv5aZ2MAz6bHFpYyMd2crB/bJk3/fyGKrbB4u1hsJ9THnRnfWJV909qcQwn+x+z0Q5JFh1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWitRA/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA18EC4AF0B;
	Mon, 15 Jul 2024 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721035705;
	bh=brXKPzeKHaL5JOnRb/wvtuUnXrOYR8fE75F/JPW3LBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWitRA/7fDf2Pm9sSg7HCABAJUhvN5cvSmhPyFFwJtxbDLAs0x2hiEMboYgvml3HG
	 mvhKkYZvjQeOUvElBL1p2XY3VYSWcvBsUKWGrZ6GqpvMUQaCeGBbk5YDqJ1cZpn4wj
	 p0SsfJvKiRUUHKGOle2LbF4DGG8lRuk7SsbmccixwoAoB731squ2s1FQe09JbPDUDS
	 Jqy5iGqeyhEepJtXrRPRIN2Q6BFzbvGVjWhf0JcvP+Ae8QF9IUrZ/37rftowTZCuIF
	 aWQ+DFXz8qW3up7QD3JQDybt/Q7f2w7rudO1MsJ0idZQ1RzkyuOOQndvbdNwGBWpwu
	 yliVG9Jni8JeQ==
Date: Mon, 15 Jul 2024 10:28:21 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next 1/9] bnxt_en: add support for storing crash dump
 into host memory
Message-ID: <20240715092821.GF8432@kernel.org>
References: <20240713234339.70293-1-michael.chan@broadcom.com>
 <20240713234339.70293-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-2-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:31PM -0700, Michael Chan wrote:
> From: Vikas Gupta <vikas.gupta@broadcom.com>
> 
> Newer firmware supports automatic DMA of crash dump to host memory
> when it crashes.  If the feature is supported, allocate the required
> memory using the existing context memory infrastructure.  Communicate
> the page table containing the DMA addresses to the firmware.
> 
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



