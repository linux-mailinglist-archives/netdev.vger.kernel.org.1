Return-Path: <netdev+bounces-230375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA26BE74C3
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB9FF564146
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D4B2C1590;
	Fri, 17 Oct 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="etBAo3YP"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7EA2C325D
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691074; cv=none; b=WEC/S5IQIWTGRZLTfj1IDqMiF/hup2gRO6yR8UCZG2vt96J0gdxArrtXJKFSKH5CRsWofdh1SQMQ0K+exlaBHKX0JNWMe0u8KNWO8N+ZyQnhXa5PmUx7rwszKvt5XyV6VUE++yBfe+FLVqv3eyAKalFoKU0weGmcPt20559AXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691074; c=relaxed/simple;
	bh=0FSVyIOmVSyhOnsafvX99K9WTYmDJGEhvSKwy5yqciQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxQFIz/FElxHJFFNtBQEr+SgTsXNL+ukmj1Tn/SjPxYlqJJRsKESxuoW1xFDoBpRDMGwZd3oJDxMVUWLaac3H1o8m6arWzGPj2dJmvIhH0awoaq06ghb0bmj8OI+HUvl3ZHUskFX7RN4EsK3hNhzT87gh1L7Y61ThSxOaY7znTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=etBAo3YP; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <20f633b9-8a49-4240-8cb8-00309081ab73@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760691070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3t5o1al0iIuvLxUpjx3C+BDSiQtTH4sdzJib2uIrsXw=;
	b=etBAo3YPqGdjvZK5+Zqk4VqNW7eV9C6W/YHsDmlqhZ04WacQAykztjtrYXAaQjn+nxC1gW
	l0sPjCPCkMzyjC/g7qZMWqk1nRiFvvYS9NjwfwF/fTY1w88qoXt7DfF9Wq52L6DZU+Wzzu
	8bwxWUjTba+G3en+77ZxBzgQV1Xcvbw=
Date: Fri, 17 Oct 2025 09:51:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] bnxt_en: support PPS in/out on all pins
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski
 <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
References: <20251016222317.3512207-1-vadim.fedorenko@linux.dev>
 <CALs4sv2gcHTpGRhZOPQqd+JrNnL05xLFYWB3uaznNbcGt=x03A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CALs4sv2gcHTpGRhZOPQqd+JrNnL05xLFYWB3uaznNbcGt=x03A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 17.10.2025 04:45, Pavan Chebbi wrote:
> On Fri, Oct 17, 2025 at 3:54 AM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> n_ext_ts and n_per_out from ptp_clock_caps are checked as a max number
>> of pins rather than max number of active pins.
> 
> I am not 100pc sure. How is n_pins going to be different then?
> https://elixir.bootlin.com/linux/v6.17/source/include/linux/ptp_clock_kernel.h#L69

So in general it's more for the case where HW has pins connected through mux to
the DPLL channels. According to the bnxt_ptp_cfg_pin() bnxt HW has pins
hardwired to channels and NVM has pre-defined configuration of pins' functions.

[host ~]# ./testptp -d /dev/ptp2 -l
name bnxt_pps0 index 0 func 0 chan 0
name bnxt_pps1 index 1 func 0 chan 1
name bnxt_pps2 index 2 func 0 chan 2
name bnxt_pps3 index 3 func 0 chan 3

without the change user cannot configure EXTTS or PEROUT function on pins
1-3 preserving channels 1-3 on them.

The user can actually use channel 0 on every pin because bnxt driver doesn't
care about channels at all, but it's a bit confusing that it sets up different
channels during init phase.

>>
>> supported_extts_flags and supported_perout_flags have to be added as
>> well to make the driver complaint with the latest API.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> index db81cf6d5289..c9b7df669415 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> @@ -965,10 +965,12 @@ static int bnxt_ptp_pps_init(struct bnxt *bp)
>>          hwrm_req_drop(bp, req);
>>
>>          /* Only 1 each of ext_ts and per_out pins is available in HW */
>> -       ptp_info->n_ext_ts = 1;
>> -       ptp_info->n_per_out = 1;
>> +       ptp_info->n_ext_ts = pps_info->num_pins;
>> +       ptp_info->n_per_out = pps_info->num_pins;
>>          ptp_info->pps = 1;
>>          ptp_info->verify = bnxt_ptp_verify;
>> +       ptp_info->supported_extts_flags = PTP_RISING_EDGE | PTP_STRICT_FLAGS;
>> +       ptp_info->supported_perout_flags = PTP_PEROUT_DUTY_CYCLE;
>>
>>          return 0;
>>   }
>> --
>> 2.47.3
>>


