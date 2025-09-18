Return-Path: <netdev+bounces-224615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095EBB86F30
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88633B97F6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29862D594D;
	Thu, 18 Sep 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ilw4l79L"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08FD528
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228471; cv=none; b=txqLUuYlsA1qCrjc8tTJaXRIYDWnlH05gNrgc3d0HofCeq5XhILLzCI9AjMRXw+OlPFHrxgAvzd40wPz+kbuJr8hFpK02GfyYyW4o1//EkPCSKIYWiPi+VsXZtmMLtdlVzUqClGFprVpYrMBdDcBSILoUbE/po3uDTeLtjdNIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228471; c=relaxed/simple;
	bh=01aM7kTxYYuOTd2hpW+rvtHoGJAQTBNFNZJgBDduAuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxevyMpReNmLRKglS3hEAdu1i2Tff1VAfU5nIaJvoarW3zG3IqDlxMeDuwXiMOK/hzBwQj5pNwyxv+FEnn8R5BdkOvgfIV76ZEmQ4X39DC/Bgnr/+9RnAwJC280fr/jHcp5iiaVOeocvI6SesvgMSimrM/hDlpFSsWJubrM0rtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ilw4l79L; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0fc877a5-4b35-4802-9cda-e4eca561c5d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758228456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9lnNfEkDvcZjokYLgamdA2J6AkuI6fP9ftEP6VOZ2o=;
	b=ilw4l79LwaGDHO4b9169Vw87H546/3nWal6LdOQ8mATmyMUyUMxhoqT7phwb0dOBMu95Et
	FjKejSwvLCW3oK+4IDMvQTyfGYTL7ZiPym7sbZQmNLDCDQ7Qkn2HnDi4ekYFAfRlieixWd
	HwKrCQOxIaJVZddIs+JEjEa1VirXFPI=
Date: Thu, 18 Sep 2025 21:47:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-net v1] igc: fix race condition in TX timestamp read
 for register 0
To: Chwee-Lin Choong <chwee.lin.choong@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Avi Shalev <avi.shalev@intel.com>,
 Song Yoong Siang <yoong.siang.song@intel.com>
References: <20250918183811.31270-1-chwee.lin.choong@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250918183811.31270-1-chwee.lin.choong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/09/2025 19:38, Chwee-Lin Choong wrote:
> The current HW bug workaround checks the TXTT_0 ready bit first,
> then reads LOW -> HIGH -> LOW from register 0 to detect if a
> timestamp was captured.
> 
> This sequence has a race: if a new timestamp is latched after
> reading the TXTT mask but before the first LOW read, both old
> and new timestamp match, causing the driver to drop a valid
> timestamp.
> 
> Fix by reading the LOW register first, then the TXTT mask,
> so a newly latched timestamp will always be detected.
> 
> This fix also prevents TX unit hangs observed under heavy
> timestamping load.
> 
> Fixes: c789ad7cbebc ("igc: Work around HW bug causing missing timestamps")
> Suggested-by: Avi Shalev <avi.shalev@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ptp.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 

[...]

>   		 * timestamp was captured, we can read the "high"
>   		 * register again.
>   		 */

This comment begins with 'read the "high" register (to latch a new 
timestamp)' ...

> -		u32 txstmpl_old, txstmpl_new;
> +		u32 txstmpl_new;
>   
> -		txstmpl_old = rd32(IGC_TXSTMPL);
>   		rd32(IGC_TXSTMPH);
>   		txstmpl_new = rd32(IGC_TXSTMPL);

and a couple of lines later in this function you have

		regval = txstmpl_new;
		regval |= (u64)rd32(IGC_TXSTMPH) << 32;

According to the comment above, the value in the register will be
latched after reading IGC_TXSTMPH. As there will be no read of "low"
part of the register, it will stay latched with old value until the
next call to the same function. Could it be the reason of unit hangs?

It looks like the value of previous read of IGC_TXSTMPH should be stored
and used to construct new timestamp, right?


