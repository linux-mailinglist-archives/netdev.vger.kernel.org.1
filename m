Return-Path: <netdev+bounces-201122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66204AE827C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23125A1837
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C606825A320;
	Wed, 25 Jun 2025 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN8bGoMs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA3522ACEF;
	Wed, 25 Jun 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750853978; cv=none; b=F5y94eMIAma05nSdINRqk7CPrlgMhn+jDHtNAC/+8cAcNAS+RaYx3XKxL4ildLhlVl+bOhqOOhoq5QI6W10BT5KabQY9xZuxS4SSneSdhJE8t7YLqjVqfUCHorgAH8RxGpQa1lZoikMrpl4aoEsoWYeHfYNvTQwhmWTlr4E9/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750853978; c=relaxed/simple;
	bh=d3hbjcTYZBHF9JdqXaMJzsaAqNIFdJ1GVA4EtXfbBgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwI49KnBrNLYTpGX/52jpBHXH9VzMH0PhhWF5xfIInZCtX4cuLltme93m4esiJrV6JPMLfeMKRL0bES+X7JmUEOJWfFHhdoErzNKrMBRbzUx8qC+rvkHdtNvpqKIdGbz7h7pjQU/TJbuupi6VfoTWaa9XJe5WLGpddL70totJy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN8bGoMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC8DC4CEEA;
	Wed, 25 Jun 2025 12:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750853976;
	bh=d3hbjcTYZBHF9JdqXaMJzsaAqNIFdJ1GVA4EtXfbBgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HN8bGoMsKzd/xuQcs7r8vd48xPW98SCfE5ZrcTZ2rNmeQHATmVlLUMI6exKSbZ7sV
	 lQ6ls+h+LPIWl62qfsdXwl1dNkrgSPj8bHsxLzYam/42u1Up2DKqMjtSBy1TYtxKem
	 PdNJ6YekDw7uXoa04zqYIlDEeJHAhf+p5oYOEm5BsiVdtifv20cg5KSzy9BC9tJCDz
	 Y7Vnc0okIzpdxh/oNCgiyPmpqGfGuS6D5pLyauAkwMRPaKDiwDl4/FC1Qdq3IjL5gV
	 ruJwA6+lNKJcoUPoJRJvWmjuW5vEWEZNdUGsDhB5rswgk9UThn1+KqDjH8eoRRoVkU
	 qNGO0oc6VXZtQ==
Date: Wed, 25 Jun 2025 13:19:32 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] e1000: drop checksum constant cast to u16 in
 comparisons
Message-ID: <20250625121932.GC1562@horms.kernel.org>
References: <46b2b70d-bf53-4b0a-a9f3-dfd8493295b9@jacekk.info>
 <20250625121828.GB1562@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625121828.GB1562@horms.kernel.org>

On Wed, Jun 25, 2025 at 01:18:28PM +0100, Simon Horman wrote:
> On Tue, Jun 24, 2025 at 09:29:43PM +0200, Jacek Kowalski wrote:
> 
> Hi Jacek,
> 
> Thanks for the patchset.
> 
> Some feedback at a high level:
> 
> 1. It's normal for patch-sets, to have a cover letter.
>    That provides a handy place for high level comments,
>    perhaps ironically, such as this one.
> 
> 2. Please provide some text in the patch description.
>    I know these changes are trivial. But we'd like to have something there.
>    E.g.
> 
>    Remove unnecessary cast of constants to u16,
>    allowing the C type system to do it's thing.
> 
>    No behavioural change intended.
>    Compile tested only.
> 
> 3. This patchset should probably be targeted at iwl-next, like this:
> 
> 	Subject: [PATCH iwl-next] ...
> 
> 4. Please make sure the patchset applies cleanly to it's target tree.
>    It seems that in it's current form the patchset doesn't
>    apply to iwl-next or net-next.
> 
> 5. It's up to you. But in general there is no need
>    to CC linux-kernel@vger.kernel.org on Networking patches
> 
> > Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> > Suggested-by: Simon Horman <horms@kernel.org>
> 
> As for this patch itself, it looks good to me.
> But I think you missed two.
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> index b5a31e8d84f4..0e5de52b1067 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
> @@ -3997,7 +3997,7 @@ s32 e1000_update_eeprom_checksum(struct e1000_hw *hw)
>  		}
>  		checksum += eeprom_data;
>  	}
> -	checksum = (u16)EEPROM_SUM - checksum;
> +	checksum = EEPROM_SUM - checksum;
>  	if (e1000_write_eeprom(hw, EEPROM_CHECKSUM_REG, 1, &checksum) < 0) {
>  		e_dbg("EEPROM Write Error\n");
>  		return -E1000_ERR_EEPROM;
> diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
> index 1c9071396b3c..556dbefdcef9 100644
> --- a/drivers/net/ethernet/intel/e1000e/nvm.c
> +++ b/drivers/net/ethernet/intel/e1000e/nvm.c
> @@ -588,7 +588,7 @@ s32 e1000e_update_nvm_checksum_generic(struct e1000_hw *hw)
>  		}
>  		checksum += nvm_data;
>  	}
> -	checksum = (u16)NVM_SUM - checksum;
> +	checksum = NVM_SUM - checksum;
>  	ret_val = e1000_write_nvm(hw, NVM_CHECKSUM_REG, 1, &checksum);
>  	if (ret_val)
>  		e_dbg("NVM Write Error while updating checksum.\n");

Sorry, I now see that the 2nd of the two hunks above is for patch 2/4.

