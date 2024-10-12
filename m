Return-Path: <netdev+bounces-134868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC97399B69D
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 20:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95C11C20DB4
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 18:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6B83CDB;
	Sat, 12 Oct 2024 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HfAJmhSL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9B768FD
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728758568; cv=none; b=h8LQKRTd1LPRtMe9oQTHbXavw5n+ly/gihDJ17aRWTkaRl6gHKBGE9/ba9CFbQ0sbCSl0Xw5+v/7RB8h7WPuQ70Ntzs7KuUNG7BfUXxQGoYRBJSYK7pQ2PB5VNKNwTxjVmM3u0Dkg0RGNzyb3S8iRtS0XUOcxE5vMSP78CaMPw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728758568; c=relaxed/simple;
	bh=aD9769Ai33ANRRwRfBKAvc06HGoBZ3EEiEmQXAolgZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cbkh98uy57sHPK/GvREz8UNHowYWlwdhraRRkDdRnPs86/FgPJmZE5bQpeVVTgcd+8PyggihghO4GieZHfU1ve0v7ZKfZ/ukn4HOvfxMF5Cp9x5Qp/bd6Be6UPFu5aaY0+yddVmbWLZ2cBiQ9cy09Jdwx5ouNipLJvUcrnIClxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HfAJmhSL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z9Vw9tqTsh2NIgXn2Uom2hDgSwNfIr0HX3ljk/NnuIg=; b=HfAJmhSL4g3kOsUQKML81Gg3vK
	sClunIM9MCqsdL+9gFNEypLQ8lYWeBayvoeKYpt/HMWgZvZH7EtYtKvtyX7HtgWPJcDMIZ8Jsgpwy
	2e5CO39h4Uaa+TI9PRz6T8dh3IHqbasKUqaO98Wf/gLUgAVCkMlN/L5QrcA6kb0OrEtw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1szh4R-009oTJ-PA; Sat, 12 Oct 2024 20:42:31 +0200
Date: Sat, 12 Oct 2024 20:42:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, Gerhard Engleder <eg@keba.com>
Subject: Re: [PATCH RFC net-next] e1000e: Fix real-time violations on link up
Message-ID: <f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch>
References: <20241011195412.51804-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011195412.51804-1-gerhard@engleder-embedded.com>

On Fri, Oct 11, 2024 at 09:54:12PM +0200, Gerhard Engleder wrote:
> From: Gerhard Engleder <eg@keba.com>
> 
> Link down and up triggers update of MTA table. This update executes many
> PCIe writes and a final flush. Thus, PCIe will be blocked until all writes
> are flushed. As a result, DMA transfers of other targets suffer from delay
> in the range of 50us. The result are timing violations on real-time
> systems during link down and up of e1000e.
> 
> Execute a flush after every single write. This prevents overloading the
> interconnect with posted writes. As this also increases the time spent for
> MTA table update considerable this change is limited to PREEMPT_RT.
> 
> Signed-off-by: Gerhard Engleder <eg@keba.com>
> ---
>  drivers/net/ethernet/intel/e1000e/mac.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index d7df2a0ed629..f4693d355886 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -331,9 +331,15 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
>  	}
>  
>  	/* replace the entire MTA table */
> -	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
> +	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
>  		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
> +#ifdef CONFIG_PREEMPT_RT
> +		e1e_flush();
> +#endif
> +	}
> +#ifndef CONFIG_PREEMPT_RT
>  	e1e_flush();
> +#endif

#ifdef FOO is generally not liked because it reduces the effectiveness
of build testing.

Two suggestions:

	if (IS_ENABLED(CONFIG_PREEMPT_RT))
		e1e_flush();

This will then end up as and if (0) or if (1), with the statement
following it always being compiled, and then optimised out if not
needed.

Alternatively, consider something like:

	if (i % 8)
		e1e_flush()

if there is a reasonable compromise between RT and none RT
performance. Given that RT is now fully merged, we might see some
distros enable it, so a compromise would probably be better.

	Andrew

