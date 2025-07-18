Return-Path: <netdev+bounces-208186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A220B0A662
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB67E3B2804
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD3A86352;
	Fri, 18 Jul 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYGK+fuy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C252F50;
	Fri, 18 Jul 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849151; cv=none; b=E1cCPeRcRyBAi3ArLGVyZiXUuM0gS00wZziMJFhKGZazaNnicZ0JoBvY6apeIwsAWAPUElMQ/YhTc4s2SD6KD4gsRQzXRM2nYp8VbQjyY5BLM7qxXVVDoW7K5flNF8krz6put/j09UKLu9QMlggalv4BAPv7W9PfXiJMprVs/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849151; c=relaxed/simple;
	bh=f+6hv450kX1gmPLqzkXJtJ1MTj1vRlxtu4IdFzoYfxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orxHhJUycvKsBA7V8Uy9t8mYE/hWAywxR/6yJa4xot16cUG51aF8GiqYZbH6Tv3sVxtZK8ldt7LPkXHUV+ln+HlZ+XuBQilHD/0NRTXKRyNwhqJCFYW15m/45zSikMe4GIGG955Mjt6gLWuVmS0ThKQxzPPucJ+iYwGl602/sAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYGK+fuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD6AC4CEEB;
	Fri, 18 Jul 2025 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752849150;
	bh=f+6hv450kX1gmPLqzkXJtJ1MTj1vRlxtu4IdFzoYfxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYGK+fuyhTPtFRjfbj5ql1987bq9LEM3SyDZQXgzbffZJ7+FdZeqST20ZIwTzHRF4
	 /arw/zy1oJjP0y08SPSD6/M7P8OCBSpt2Vn0b9EyX4pTCu/tPqdT4iaUkUz/Ctwgnp
	 s6zk/LP7+InrrMYBT2ZXffoG0OWqAcnWDCFueexQk2RjW1H1Z3Lw3f3uIhAuFe+Jxd
	 bnl21QVUf9WrwUVGDWoQkXBivQPmTSXWM1MTaY0dHlwpxJXLMyB15tzLw1cn7zua2l
	 HFy/VHaQePf00V70eQvQsBODkfVw7htMTHsZ0H8mQdJgjinyk/52Fh2QWDMCLuJszY
	 isczmDj5LqSYA==
Date: Fri, 18 Jul 2025 15:32:25 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Himanshu Mittal <h-mittal1@ti.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>,
	prajith@ti.com, Pratheesh Gangadhar <pratheesh@ti.com>,
	Sriramakrishnan <srk@ti.com>, Roger Quadros <rogerq@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix buffer allocation for
 ICSSG
Message-ID: <20250718143225.GE2459@horms.kernel.org>
References: <20250717094220.546388-1-h-mittal1@ti.com>
 <4c677fdb-e6d6-4961-b911-78aaa28130e6@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c677fdb-e6d6-4961-b911-78aaa28130e6@web.de>

On Thu, Jul 17, 2025 at 02:56:15PM +0200, Markus Elfring wrote:
> …
> > +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> > @@ -288,8 +288,12 @@ static int prueth_fw_offload_buffer_setup(struct prueth_emac *emac)
> >  	int i;
> >  
> >  	addr = lower_32_bits(prueth->msmcram.pa);
> > -	if (slice)
> > -		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
> > +	if (slice) {
> > +		if (prueth->pdata.banked_ms_ram)
> > +			addr += MSMC_RAM_BANK_SIZE;
> > +		else
> > +			addr += PRUETH_SW_TOTAL_BUF_SIZE_PER_SLICE;
> > +	}
> …
> 
> Would you like to use the following code variant?
> 
> 	if (slice)
> 		addr += ( prueth->pdata.banked_ms_ram
> 			? MSMC_RAM_BANK_SIZE
> 			: PRUETH_SW_TOTAL_BUF_SIZE_PER_SLICE);
> 
> 
> Can the usage of the conditional operator be extended another bit
> (also for the function “prueth_emac_buffer_setup” for example)?

1. (Subjective) The current code seems fine to me
2. (Objective) Your suggestion features unnecessary parentheses, and
   incorrect indentation and whitespace

