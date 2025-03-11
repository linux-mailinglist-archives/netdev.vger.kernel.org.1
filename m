Return-Path: <netdev+bounces-173829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6401A5BE71
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847621897800
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B32512E3;
	Tue, 11 Mar 2025 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmB6XRbU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ABB24169D
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691063; cv=none; b=BDKyDofxXHuaa/6iGykO2v8xuWzBiP6UQIobWlNoFF4D3SKxTKVLKyb2uxDKvZTY4r0KcXunyYivHcFZKe4QDZxfWgQdSGgmDK8qBas08jBNFCou9b/fRfcUlFDeLIM7BbvE86Oh2fbKjI31C6H8o5l9xZBkbIXT/Pq9A0DdIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691063; c=relaxed/simple;
	bh=/JETuvOyKN6qqzVHVb4ofsOnUtJA9YuFu/oCz0Cz7N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXkhHn6wzKshKf0GzE17kS+WVAzVxqLSXd0xhYJVGl46AbtW9hRtAv+ANqhp/bteCCWm72sD2V+14jV5AEG3Jthr1d13Uq4+a/Q5g6dspKLnk41wvaYo/BkS4Je4/GB4R84yAE/58DexAkmOFaqVZppGX7jwD/dTHsT7l0J+cak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmB6XRbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9378BC4CEE9;
	Tue, 11 Mar 2025 11:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741691063;
	bh=/JETuvOyKN6qqzVHVb4ofsOnUtJA9YuFu/oCz0Cz7N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmB6XRbU6pqC0YE+WAG8iDLMfJybbgWwoAV+5nDxZR4lLa42bDrLF0j8TQfeto/1t
	 csjVFPcHzc5cEeOoGhgqYycQwzCvbFxmwYB/dmWiWxLKH1yI7c7YWG+cW5azDCwWvA
	 4p5UzoMr9sJnVfEFvLfk5pUidqzchXZWz1DsmeW5LQGnhifQsURQX7FVO7BPY/0oCL
	 sMVVAORXKJrxFpA9iSYgby18xiPTasBFjvGCx6IR5OUc395ds+WOHmej9TqHJDpQIL
	 Qc/onh1Phys5JPbtS1lUApmoCjRIsqpqvEXxyWI/B5GuQZyReweGsEP5VYo4deSZ09
	 4QhrjmJnNg/fg==
Date: Tue, 11 Mar 2025 12:04:18 +0100
From: Simon Horman <horms@kernel.org>
To: Kyungwook Boo <bookyungwook@gmail.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] i40e: fix MMIO write access to an invalid
 page in i40e_clear_hw
Message-ID: <20250311110418.GK4159220@kernel.org>
References: <e7e4e5d5-931d-4506-9d75-b87783011379@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e4e5d5-931d-4506-9d75-b87783011379@gmail.com>

On Tue, Mar 11, 2025 at 02:16:02PM +0900, Kyungwook Boo wrote:
> When the device sends a specific input, an integer underflow can occur, leading
> to MMIO write access to an invalid page.
> 
> Prevent the integer underflow by changing the type of related variables.
> 
> Signed-off-by: Kyungwook Boo <bookyungwook@gmail.com>
> Link: https://lore.kernel.org/lkml/ffc91764-1142-4ba2-91b6-8c773f6f7095@gmail.com/T/
> ---
> Changes in v2:
> - Formatting properly
> - Fix variable shadowing
> - Link to v1: https://lore.kernel.org/netdev/55acc5dc-8d5a-45bc-a59c-9304071e4579@gmail.com/
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 370b4bddee44..b11c35e307ca 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -817,10 +817,11 @@ int i40e_pf_reset(struct i40e_hw *hw)
>  void i40e_clear_hw(struct i40e_hw *hw)
>  {
>  	u32 num_queues, base_queue;
> -	u32 num_pf_int;
> -	u32 num_vf_int;
> +	s32 num_pf_int;
> +	s32 num_vf_int;
>  	u32 num_vfs;
> -	u32 i, j;
> +	s32 i;
> +	u32 j;
>  	u32 val;
>  	u32 eol = 0x7ff;
>  
> ---
> base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627

I see that this addresses the problem at the first link above.
And I'd happy to see it accepted as-is.

Reviewed-by: Simon Horman <horms@kernel.org>

But, as an aside, wouldn't it be more appropriate to use generic
types like int and unsigned int for most of the above variables?
Perhaps this could be addressed by a follow-up. Or perhaps that
would just be churn, IDK.

