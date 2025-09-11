Return-Path: <netdev+bounces-221976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 478EAB52852
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 07:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01403567879
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 05:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D23224DD15;
	Thu, 11 Sep 2025 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UxwHY2t7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631A3214A6A;
	Thu, 11 Sep 2025 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757569990; cv=none; b=tIaviwZ/KRaRf5ruZiNGQbp9lnYhxVAc5LwpWEuQOnYGY8uPDCy+j2rnig92ffzqKndiIAozK9xIIwSpDvjn03znMlHLTAuSb1y04JgcJqP6wFONJhfeF1Ei1qoUas2lQ0Y07Cws1Qxc4TKjwgsXFxCHY8wRTc45XA+iMl3Ckec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757569990; c=relaxed/simple;
	bh=cSAiifVvxBoSpW9GjYX5RXnE1bXqyNM0WzHg8Ilov3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mawFZ2LySqRZdtwhmqpdPq9MzUGr+Cz1GDVOYQTrFvx1CUAf8kUx5VuHeckhkqWTrd//PZ6QnXvf2s0ZcWHMiy3FNS4PN5QuUKVBP9ryvoNFL2CD2tAaGLQkFnqoynnKEvyJzkZEJt6Rgz4lBdNBzq080Exos1xT9N91iMKvbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UxwHY2t7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E569C4CEF1;
	Thu, 11 Sep 2025 05:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757569989;
	bh=cSAiifVvxBoSpW9GjYX5RXnE1bXqyNM0WzHg8Ilov3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxwHY2t7Bfte9bZPXI8IXJ8682HLSFf9pay5bdwiNeSWi3gkHiKikIQPkk+RCK3Nx
	 E10Od8MECoX18XRm2WWEriX5h39ONcIqsYK8/6i4d1V/H28zWOlA+aj5B/UFFnm4xN
	 1MbknOqrqozYL9/lgRdYkpbVzTk4oY2V4K7+ex8s=
Date: Thu, 11 Sep 2025 07:53:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, kuba@kernel.org, vitaly.lifshits@intel.com,
	post@mikaelkw.online, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jonnyc@amazon.com
Subject: Re: [PATCH 5.10.y] e1000e: fix EEPROM length types for overflow
 checks
Message-ID: <2025091131-tractor-almost-6987@gregkh>
References: <20250910173138.8307-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910173138.8307-1-farbere@amazon.com>

On Wed, Sep 10, 2025 at 05:31:38PM +0000, Eliav Farber wrote:
> Fix a compilation failure when warnings are treated as errors:
> 
> drivers/net/ethernet/intel/e1000e/ethtool.c: In function ‘e1000_set_eeprom’:
> ./include/linux/overflow.h:71:15: error: comparison of distinct pointer types lacks a cast [-Werror]
>    71 |  (void) (&__a == __d);   \
>       |               ^~
> drivers/net/ethernet/intel/e1000e/ethtool.c:582:6: note: in expansion of macro ‘check_add_overflow’
>   582 |  if (check_add_overflow(eeprom->offset, eeprom->len, &total_len) ||
>       |      ^~~~~~~~~~~~~~~~~~
> 
> To fix this, change total_len and max_len from size_t to u32 in
> e1000_set_eeprom().
> The check_add_overflow() helper requires that the first two operands
> and the pointer to the result (third operand) all have the same type.
> On 64-bit builds, using size_t caused a mismatch with the u32 fields
> eeprom->offset and eeprom->len, leading to type check failures.
> 
> Fixes: ce8829d3d44b ("e1000e: fix heap overflow in e1000_set_eeprom")
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
> index 4aca854783e2..584378291f3f 100644
> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> @@ -559,7 +559,7 @@ static int e1000_set_eeprom(struct net_device *netdev,
>  {
>  	struct e1000_adapter *adapter = netdev_priv(netdev);
>  	struct e1000_hw *hw = &adapter->hw;
> -	size_t total_len, max_len;
> +	u32 total_len, max_len;
>  	u16 *eeprom_buff;
>  	int ret_val = 0;
>  	int first_word;
> -- 
> 2.47.3
> 

Why is this not needed in Linus's tree?

Also, why is it not cc: stable@vger.kernel.org?

thanks,

greg k-h

