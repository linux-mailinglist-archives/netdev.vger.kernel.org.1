Return-Path: <netdev+bounces-136181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8551A9A0D11
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6ED11C2417D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F5520C017;
	Wed, 16 Oct 2024 14:43:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D26D208D63;
	Wed, 16 Oct 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089837; cv=none; b=JsPigZoGeVRHO0t9gXkGIBtASJ7eYVxlAdc7KyDbbyf2njnSjNqKj2iZ2shppJgkUbpCBt2Ew6H1nXX3jeNI1G7FZkO2+Ck3W53y7T0jF+SziSMRgDMOrBbKjBOEffTc5lasOZJ597T9qezCyhXE9BTNOnxqaDhTBOOpCtHFx9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089837; c=relaxed/simple;
	bh=JiVa5/90/cZvb2+61ERpg3MxggQZczhhtMnM0mhJmMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTi/PW1VzuGjkipxF/Jo5uGVhh+qSoHAqa3XwQ3H3Ghx8CNhU/1/UP9a3h4XycmCTRVhL3JmtJp24E0hvH0zve1pxEx0Ty491lRRgAoqst9NI2/pS90IWRdLj1T9NoHqICrMEm03t4pwJPL+nGPz0ssY3FTpwJSoBusXQhIXJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FD381007;
	Wed, 16 Oct 2024 07:44:25 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5FBD3F71E;
	Wed, 16 Oct 2024 07:43:51 -0700 (PDT)
Message-ID: <456ea437-fe6c-474f-bd9f-583c6fce9151@arm.com>
Date: Wed, 16 Oct 2024 15:43:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 27/57] net: e1000: Remove PAGE_SIZE compile-time
 constant assumption
Content-Language: en-GB
To: "David S. Miller" <davem@davemloft.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalesh Singh <kaleshsingh@google.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>,
 Paolo Abeni <pabeni@redhat.com>, Will Deacon <will@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-27-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-27-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Przemek Kitszel, Tony Nguyen

This was a rather tricky series to get the recipients correct for and my script
did not realize that "supporter" was a pseudonym for "maintainer" so you were
missed off the original post. Appologies!

More context in cover letter:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/


On 14/10/2024 11:58, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> Convert CPP conditionals to C conditionals. The compiler will dead code
> strip when doing a compile-time page size build, for the same end
> effect. But this will also work with boot-time page size builds.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index ab7ae418d2948..cc14788f5bb04 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -3553,12 +3553,10 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
>  
>  	if (max_frame <= E1000_RXBUFFER_2048)
>  		adapter->rx_buffer_len = E1000_RXBUFFER_2048;
> -	else
> -#if (PAGE_SIZE >= E1000_RXBUFFER_16384)
> +	else if (PAGE_SIZE >= E1000_RXBUFFER_16384)
>  		adapter->rx_buffer_len = E1000_RXBUFFER_16384;
> -#elif (PAGE_SIZE >= E1000_RXBUFFER_4096)
> +	else if (PAGE_SIZE >= E1000_RXBUFFER_4096)
>  		adapter->rx_buffer_len = PAGE_SIZE;
> -#endif
>  
>  	/* adjust allocation if LPE protects us, and we aren't using SBP */
>  	if (!hw->tbi_compatibility_on &&


