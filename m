Return-Path: <netdev+bounces-197520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C7EAD9011
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B461E05B4
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451871ADFFB;
	Fri, 13 Jun 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rerx9dZ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE09444;
	Fri, 13 Jun 2025 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826212; cv=none; b=M1rkVhLzLCEUx7fiiC7+lqNGWfDcHfeQcuDuW2ocksqHlaGXB8fnsawQNSbd4YKimfT6o8RP8ycyaiPn7W7Nhf6cFbzNHgT2l7p13/xWmeAUL9ctkc2JsMbcjj5X1NKx41fXbDrdPifIb5nR2nEEZHoPNCE4m/8hVjdBsHTEgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826212; c=relaxed/simple;
	bh=lCf7T5fc00BdCEMSSuurkjGn0xJbs/OQqTwhsezYUAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEwVqYiE+uNgWGcdTYB+0MIGyiZKUCw8A7ewT8Y5VYtxxHPpYnOwXkp5xMQ8H65CnUHSyHWgkh93h7M/C7HwDT9yTuJFXvktXVbAEOIJp37LK2XxymdSzX52nsnXCF00K6AOA0s+jK/tZKo9Nc0T9CuzE8KeAux8zhtRkaiQ/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rerx9dZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2355FC4CEE3;
	Fri, 13 Jun 2025 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749826211;
	bh=lCf7T5fc00BdCEMSSuurkjGn0xJbs/OQqTwhsezYUAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rerx9dZ6F6Q7AJIzyxLPvkCT/hH7sy3NXCQGnvi07t0HPaxFM4OsA2xir/Uk1itmM
	 UG8EV7f7v+8AWNUDJVC3hppJaVtgiAq/m9KzxsMPIopBMN8LvTERIoRQXy717GLa6/
	 SF20shSUYHyzDXhykAk5HpkP0NlfFa/i68L4HIB+Rhts0xT+fIQcc8NbAWX4Ub8tNA
	 iMVtd+o8lhQEW+ppDbWkXtAENt5m/8TosizRs+IlJttd8so/4p0FzU2C/cleP60IXz
	 uUvUReu6TFvpQPxMH51hIjtTdTXgzsmz4J9iS/FYzC6cYczlQrGM7KE9HJwIBKe7rp
	 X+fK6bXNRcnxA==
Date: Fri, 13 Jun 2025 07:50:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bharat@chelsio.com, benve@cisco.com, satishkh@cisco.com,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, bryan.whitehead@microchip.com,
 rosenp@gmail.com, imx@lists.linux.dev
Subject: Re: [PATCH net-next 6/6] eth: sfc: falcon: migrate to new RXFH
 callbacks
Message-ID: <20250613075010.0b59564d@kernel.org>
In-Reply-To: <6425933b-3b17-4509-86be-be4a75f12e17@gmail.com>
References: <20250613005409.3544529-1-kuba@kernel.org>
	<20250613005409.3544529-7-kuba@kernel.org>
	<6425933b-3b17-4509-86be-be4a75f12e17@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 14:44:40 +0100 Edward Cree wrote:
> So granted that you're only moving code, but looking at this it doesn't
>  actually make sense, since every path that sets info->data to nonzero
>  also sets min_revision, so why not just do the ef4_nic_rev() check at
>  the start?  Answer, from git log spelunking, is that when this code was
>  shared with Siena, EFX_REV_SIENA_A0 supported IPv6 here.

Ack, I was tempted to clean this up, but it felt slightly outside of 
the objective. Looks like I need to respin for enetc - I can change 
it in v2 if you'd like?

> Have a
> Reviewed-By: Edward Cree <ecree.xilinx@gmail.com>
> ... but this patch could be followed-up with a simplification to put
> 	if (ef4_nic_rev(efx) < EF4_REV_FALCON_B0)
> 		return 0;
>  before the switch and get rid of min_revision.
> Falcon is long since end-of-life, so I don't have any NICs and can't run
>  any tests, which maybe means the smart thing to do is just to leave well
>  alone and not touch this code beyond your factoring.
> 
> *twitches with barely-suppressed urge to fix it anyway*
> -ed
> 
> PS: I spent about two hours reading device documentation from 2008
>  because I thought it said Falcon did 4-tuple hashing on UDP too.  For
>  the record: the 'Falcon hash' was broken (in some unspecified way), so
>  falcon_init_rx_cfg() selects the Toeplitz hash which does indeed only
>  consume port numbers on these devices if protocol is TCP.  And I will
>  never get that time back :/

:D

