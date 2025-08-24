Return-Path: <netdev+bounces-216324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE41B331B2
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 20:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FF9200E8A
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5470E1946DF;
	Sun, 24 Aug 2025 18:01:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810A21348
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756058497; cv=none; b=ITlewprSaso/e5oCqIADYww4NEgBCeH+AFfpUdbXoHL3Bq91fqglxUfqUBGKYXd1/kb+nD4trJ/QO1ZIovY4jI9jvaPifQpfN521LlJ2+9XRn5lWSx2mcl05KQG7X+48U4pMIDmUPsP3DYMdH2QHHFkwPNV01dLcmxqXNxeGN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756058497; c=relaxed/simple;
	bh=cWV4zt5KTuLzegEW8JAuaOetvvjZxW+pVkC6CUCKFVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1IjRyNPVXqv95QE+PLftLyjAZI61Pe5clK6iyhTQ9MPBsR6R8xrbN37Ect+EL0nJL97nJylyITLQIBqKlNfnXspbKd3i4hqZMfFOF9nNoUTDAz0R7UcMDCa8Z0Vi4970KFt/RwmE9WPS7pGyDtawFgOLtAKeTPHI/L1zRf9VBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.49.230] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2E2C161E6484C;
	Sun, 24 Aug 2025 20:00:36 +0200 (CEST)
Message-ID: <b83c21c4-f379-47ff-9dd2-9d2fc0779d8f@molgen.mpg.de>
Date: Sun, 24 Aug 2025 20:00:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: preserve RSS
 indirection table across admin down/up
To: Kohei Enju <enjuk@amazon.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kohei.enju@gmail.com
References: <20250824112037.32692-1-enjuk@amazon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250824112037.32692-1-enjuk@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kohei,


Thank you for your patch.

Am 24.08.25 um 13:20 schrieb Kohei Enju:
> Currently, the RSS indirection table configured by user via ethtool is
> reinitialized to default values during interface resets (e.g., admin
> down/up, MTU change). As for RSS hash key, commit 3dfbfc7ebb95 ("ixgbe:
> Check for RSS key before setting value") made it persistent across
> interface resets.
> 
> By adopting the same approach used in igc and igb drivers which
> reinitializes the RSS indirection table only when the queue count
> changes, let's make user configuration persistent as long as queue count
> remains unchanged.
> 
> Tested on Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network
> Connection.
> 
> Test:
> Set custom indirection table and check the value after interface down/up
> 
>    # ethtool --set-rxfh-indir ens5 equal 2
>    # ethtool --show-rxfh-indir ens5 | head -5
> 
>    RX flow hash indirection table for ens5 with 12 RX ring(s):
>        0:      0     1     0     1     0     1     0     1
>        8:      0     1     0     1     0     1     0     1
>       16:      0     1     0     1     0     1     0     1
>    # ip link set dev ens5 down && ip link set dev ens5 up
> 
> Without patch:
>    # ethtool --show-rxfh-indir ens5 | head -5
> 
>    RX flow hash indirection table for ens5 with 12 RX ring(s):
>        0:      0     1     2     3     4     5     6     7
>        8:      8     9    10    11     0     1     2     3
>       16:      4     5     6     7     8     9    10    11
> 
> With patch:
>    # ethtool --show-rxfh-indir ens5 | head -5
> 
>    RX flow hash indirection table for ens5 with 12 RX ring(s):
>        0:      0     1     0     1     0     1     0     1
>        8:      0     1     0     1     0     1     0     1
>       16:      0     1     0     1     0     1     0     1
> 
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 37 +++++++++++++------
>   2 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 14d275270123..d8b088c90b05 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -838,6 +838,7 @@ struct ixgbe_adapter {
>    */
>   #define IXGBE_MAX_RETA_ENTRIES 512
>   	u8 rss_indir_tbl[IXGBE_MAX_RETA_ENTRIES];
> +	u16 last_rss_i;
>   
>   #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
>   	u32 *rss_key;
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 80e6a2ef1350..dc5a8373b0c3 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -4318,14 +4318,22 @@ static void ixgbe_setup_reta(struct ixgbe_adapter *adapter)
>   	/* Fill out hash function seeds */
>   	ixgbe_store_key(adapter);
>   
> -	/* Fill out redirection table */
> -	memset(adapter->rss_indir_tbl, 0, sizeof(adapter->rss_indir_tbl));
> +	/* Update redirection table in memory on first init or queue count
> +	 * change, otherwise preserve user configurations. Then always
> +	 * write to hardware.
> +	 */
> +	if (adapter->last_rss_i != rss_i) {
> +		memset(adapter->rss_indir_tbl, 0,
> +		       sizeof(adapter->rss_indir_tbl));
> +
> +		for (i = 0, j = 0; i < reta_entries; i++, j++) {
> +			if (j == rss_i)
> +				j = 0;
>   
> -	for (i = 0, j = 0; i < reta_entries; i++, j++) {
> -		if (j == rss_i)
> -			j = 0;
> +			adapter->rss_indir_tbl[i] = j;
> +		}
>   
> -		adapter->rss_indir_tbl[i] = j;
> +		adapter->last_rss_i = rss_i;
>   	}
>   
>   	ixgbe_store_reta(adapter);
> @@ -4347,12 +4355,19 @@ static void ixgbe_setup_vfreta(struct ixgbe_adapter *adapter)
>   					*(adapter->rss_key + i));
>   	}
>   
> -	/* Fill out the redirection table */
> -	for (i = 0, j = 0; i < 64; i++, j++) {
> -		if (j == rss_i)
> -			j = 0;
> +	/* Update redirection table in memory on first init or queue count
> +	 * change, otherwise preserve user configurations. Then always
> +	 * write to hardware.
> +	 */
> +	if (adapter->last_rss_i != rss_i) {
> +		for (i = 0, j = 0; i < 64; i++, j++) {
> +			if (j == rss_i)
> +				j = 0;
> +
> +			adapter->rss_indir_tbl[i] = j;
> +		}
>   
> -		adapter->rss_indir_tbl[i] = j;
> +		adapter->last_rss_i = rss_i;
>   	}
>   
>   	ixgbe_store_vfreta(adapter);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

