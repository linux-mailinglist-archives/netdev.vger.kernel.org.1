Return-Path: <netdev+bounces-224528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA72B85E88
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8DE188A8E1
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914C0315D47;
	Thu, 18 Sep 2025 16:05:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D0315D42;
	Thu, 18 Sep 2025 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211512; cv=none; b=bola+sh/JjUeEKfSQB/+ZUt3CQ/BRYaOAhVyDQ+yuInzzd8Wrt9OP+6WJA7VviwsqinRwOv2r8w4C3ml/s99S9MlNDZoPU8yFFiM+aZxGktjJAeZzAnpoSyKnbsp3BxCHQbbU6/aTDStWAwea6a40zUaqDe6jRbL6CPZllXmNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211512; c=relaxed/simple;
	bh=iY4LeQULomcpam8kh1OA82zPLoZNxtvKGtjBX/0HVnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+Y/SmWDWhRfIjAor8+hbIzV5YBS/J0y2sgTh0vDu3HLjUGyIqNlVz0scQCqrhvcXP1GpyYRW2p0p2VVAnhXSctMriAinui9svWIl9ATvO/Fjrqvtyzxoq6jeju4vEucvqpWSENbFZIuvZ6d4iWCr6LJ6R+PshpSMXNWtb1gzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0478060213C91;
	Thu, 18 Sep 2025 18:03:28 +0200 (CEST)
Message-ID: <11e02598-3fc8-4350-91b7-5fc587a8cf6b@molgen.mpg.de>
Date: Thu, 18 Sep 2025 18:03:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] igc: fix race condition in
 TX timestamp read for register 0
To: Chwee-Lin Choong <chwee.lin.choong@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Avi Shalev <avi.shalev@intel.com>,
 Song Yoong Siang <yoong.siang.song@intel.com>
References: <20250918183811.31270-1-chwee.lin.choong@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250918183811.31270-1-chwee.lin.choong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chwee-Lin,


Thank you for your patch.

Am 18.09.25 um 20:38 schrieb Chwee-Lin Choong:
> The current HW bug workaround checks the TXTT_0 ready bit first,
> then reads LOW -> HIGH -> LOW from register 0 to detect if a
> timestamp was captured.
> 
> This sequence has a race: if a new timestamp is latched after
> reading the TXTT mask but before the first LOW read, both old
> and new timestamp match, causing the driver to drop a valid
> timestamp.

Reading the TXTT mask is `rd32(IGC_TSYNCTXCTL)`, correct?

> Fix by reading the LOW register first, then the TXTT mask,
> so a newly latched timestamp will always be detected.
> 
> This fix also prevents TX unit hangs observed under heavy
> timestamping load.

The unit shouldn’t hang, even if valid timestamps are dropped?

Do you have a reproducer?

> Fixes: c789ad7cbebc ("igc: Work around HW bug causing missing timestamps")
> Suggested-by: Avi Shalev <avi.shalev@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ptp.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index b7b46d863bee..930486b02fc1 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -774,10 +774,17 @@ static void igc_ptp_tx_reg_to_stamp(struct igc_adapter *adapter,
>   static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
>   {
>   	struct igc_hw *hw = &adapter->hw;
> +	u32 txstmpl_old;
>   	u64 regval;
>   	u32 mask;
>   	int i;
>   
> +	/* Read the "low" register 0 first to establish a baseline value.
> +	 * This avoids a race where a new timestamp could be latched
> +	 * after checking the TXTT mask.
> +	 */
> +	txstmpl_old = rd32(IGC_TXSTMPL);
> +
>   	mask = rd32(IGC_TSYNCTXCTL) & IGC_TSYNCTXCTL_TXTT_ANY;
>   	if (mask & IGC_TSYNCTXCTL_TXTT_0) {
>   		regval = rd32(IGC_TXSTMPL);
> @@ -801,9 +808,8 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
>   		 * timestamp was captured, we can read the "high"
>   		 * register again.
>   		 */
> -		u32 txstmpl_old, txstmpl_new;
> +		u32 txstmpl_new;
>   
> -		txstmpl_old = rd32(IGC_TXSTMPL);
>   		rd32(IGC_TXSTMPH);
>   		txstmpl_new = rd32(IGC_TXSTMPL);
>   

Kind regards,

Paul

