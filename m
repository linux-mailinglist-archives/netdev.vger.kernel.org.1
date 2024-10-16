Return-Path: <netdev+bounces-136182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3665D9A0D15
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682E41C241DA
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51220C02B;
	Wed, 16 Oct 2024 14:44:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EEC20C012;
	Wed, 16 Oct 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089868; cv=none; b=ssK/YvQy/3ui4iHSFmkKa68H09N8N95tpvxvhFBC2Oo0CRC83GC/Oy58FbOUQpfI6CtKATXnI5Ub4ZSY1uuznIdUEEW2IQff46cCk3RZDHhBTT7xGIYtTUjRYoefCWABQvibf2KZfJ5h1lnCYhOxDuJE0G7yC7M6PhnAHLnRHlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089868; c=relaxed/simple;
	bh=GD9ZIVfEWNFVbxGWqL+Z2BFFxwhZ+TB8F6JoPexbAJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmZRucbR00a9kSW//QOQcTBLk4SEGdr+0WTwybk59yhX+NSUWErxzKGESa3WckRihyXwImvq9P3YjNEXSCpbV693vktDl9kJUbthieWKX+VE0tQCVIsE1c07AlaWe5PJe1e2+nt4VIPDXTCBctvJGfC62yjWKspfL1yG2FBb2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E13BF1007;
	Wed, 16 Oct 2024 07:44:55 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84AB63F71E;
	Wed, 16 Oct 2024 07:44:22 -0700 (PDT)
Message-ID: <6463a9f9-76ee-48bc-9173-75b220fcb3ac@arm.com>
Date: Wed, 16 Oct 2024 15:44:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 28/57] net: igbvf: Remove PAGE_SIZE compile-time
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
 <20241014105912.3207374-28-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-28-ryan.roberts@arm.com>
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
>  drivers/net/ethernet/intel/igbvf/netdev.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
> index 925d7286a8ee4..2e11d999168de 100644
> --- a/drivers/net/ethernet/intel/igbvf/netdev.c
> +++ b/drivers/net/ethernet/intel/igbvf/netdev.c
> @@ -2419,12 +2419,10 @@ static int igbvf_change_mtu(struct net_device *netdev, int new_mtu)
>  		adapter->rx_buffer_len = 1024;
>  	else if (max_frame <= 2048)
>  		adapter->rx_buffer_len = 2048;
> -	else
> -#if (PAGE_SIZE / 2) > 16384
> +	else if ((PAGE_SIZE / 2) > 16384)
>  		adapter->rx_buffer_len = 16384;
> -#else
> +	else
>  		adapter->rx_buffer_len = PAGE_SIZE / 2;
> -#endif
>  
>  	/* adjust allocation if LPE protects us, and we aren't using SBP */
>  	if ((max_frame == ETH_FRAME_LEN + ETH_FCS_LEN) ||


