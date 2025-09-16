Return-Path: <netdev+bounces-223661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F7BB59D5E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0659C188ACB3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A282F6579;
	Tue, 16 Sep 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="puqqU5o2"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515228488D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039629; cv=none; b=vDpueGlqKONr/llCMJdcVrIDpFE4XsHHeSTStnPRr3c4wwc/et3mrnBCSa5f3rZ1hCxrT76Fr/KiT9fwj6P0XyskkYfzDlk7lwE51Ska6T2t0O/bFsD8F6LQ44+25Cd9G+cNXBoO6f4ijjjjDEPgFb5NJpEWwU+getBzO7njdW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039629; c=relaxed/simple;
	bh=+FFvRqfTMNtjcJ1Bge4aDv1coqZlJWD3ttRj9H9DYRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLVd4oIoriKpqoMUoxuzwG2DD3fz/0y2gUrUSbHh7p57g2ZE2uAg/xcIq71qr2DAXf3UMyaMJ1+YA67WRznWQemmIbVuOMpxSm/Go9T4CoG6gmVN4rf8MULteGl5Wck+NNIZPfCcXnA9+InVm6fszYYrb6F/fv+iELA3myM1xbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=puqqU5o2; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b6e0d1e5-bd50-464a-9eae-05ecd11de4ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758039623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQC89dD1c3jT6JY0wqpeRVJR3Kc57Rt3TOanUiinKWA=;
	b=puqqU5o2fTXlNQUA2Y7bIK0rOQ/5P9qd6u8lCM1nsldMsoqZRyqPb0HxaIPspMfut/taCx
	T6fyvRk2UL1RZVmzyeuB1woRMtRtlToUMp4fm5i+iOWV7uD5b08wiLaAbvK0NvbvX9q7PA
	5zmk28y+HHiZSwhcrfL0PrhFO/mtTOA=
Date: Tue, 16 Sep 2025 17:20:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] ptp: rework ptp_clock_unregister() to
 disable events
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>, Eric Dumazet <edumazet@google.com>,
 imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
 Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Yangbo Lu <yangbo.lu@nxp.com>
References: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
 <E1uyAP7-00000005lGq-3FqI@rmk-PC.armlinux.org.uk>
 <9d197d92-3990-4e48-aa35-87a51eccb87a@linux.dev>
 <aMmGFQx5lWdXQq_j@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aMmGFQx5lWdXQq_j@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/09/2025 16:45, Russell King (Oracle) wrote:
> On Tue, Sep 16, 2025 at 02:02:56PM +0100, Vadim Fedorenko wrote:
>> On 15/09/2025 15:42, Russell King (Oracle) wrote:
>>> the ordering of ptp_clock_unregister() is not ideal, as the chardev
>>> remains published while state is being torn down. There is also no
>>> cleanup of enabled pin settings, which means enabled events can
>>> still forward into the core.
>>>
>>> Rework the ordering of cleanup in ptp_clock_unregister() so that we
>>> unpublish the posix clock (and user chardev), disable any pins that
>>> have events enabled, and then clean up the aux work and PPS source.
>>>
>>> This avoids potential use-after-free and races in PTP clock driver
>>> teardown.
>>>
>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>> ---
>>>    drivers/ptp/ptp_chardev.c | 13 +++++++++++++
>>>    drivers/ptp/ptp_clock.c   | 17 ++++++++++++++++-
>>>    drivers/ptp/ptp_private.h |  2 ++
>>>    3 files changed, 31 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
>>> index eb4f6d1b1460..640a98f17739 100644
>>> --- a/drivers/ptp/ptp_chardev.c
>>> +++ b/drivers/ptp/ptp_chardev.c
>>> @@ -47,6 +47,19 @@ static int ptp_disable_pinfunc(struct ptp_clock_info *ops,
>>>    	return err;
>>>    }
>>> +void ptp_disable_all_pins(struct ptp_clock *ptp)
>>> +{
>>> +	struct ptp_clock_info *info = ptp->info;
>>> +	unsigned int i;
>>> +
>>> +	mutex_lock(&ptp->pincfg_mux);
>>> +	for (i = 0; i < info->n_pins; i++)
>>> +		if (info->pin_config[i].func != PTP_PF_NONE)
>>> +			ptp_disable_pinfunc(info, info->pin_config[i].func,
>>> +					    info->pin_config[i].chan);
>>> +	mutex_unlock(&ptp->pincfg_mux);
>>> +}
>>> +
>>
>> This part is questionable. We do have devices which have PPS out enabled
>> by default. The driver reads pins configuration from the HW during PTP
>> init phase and sets up proper function for pin in ptp_info::pin_config.
>>
>> With this patch applied these pins have PEROUT function disabled on
>> shutdown and in case of kexec'ing into a new kernel the PPS out feature
>> needs to be manually enabled, and it breaks expected behavior.
> 
> Does kexec go to the trouble of unregistering PTP clocks? I don't see
> any driver in drivers/ptp/ that has the .shutdown method populated.
> 
> That doesn't mean there aren't - it isn't obvious where they are or
> if it does happen.

That's part of mlx5 and at least Intel's igc and igb drivers.

> The question about whether one wants to leave the other features in
> place when the driver is removed is questionable - without the driver
> (or indeed without something discplining the clock) it's going to
> drift, so the accuracy of e.g. the PPS signal is going to be as good
> as the clock source clocking the TAI.

In our use-case we use PPS out as an input to the external monitoring
and we would like to see the PPS signal to drift in case of any errors.

> Having used NTP with a PPS sourced from a GPS, I'd personally want
> the PPS to stop if the GPS is no longer synchronised, so NTP knows
> that a fault has occurred, rather than PPS continuing but being
> undiscplined and thus of unknown accuracy.
> 
> I'd suggest that whether PPS continues to be generated should be a
> matter of user policy. I would suggest that policy should include
> whether or not userspace is discplining the clock - in other words,
> whether the /dev/ptp* device is open or not.

The deduction based on the amount of references to ptp device is not
quite correct. Another option is to introduce another flag and use it
as a signal to remove the function in case of error/shutdown/etc.
> Consider the case where the userspace daemons get OOM-killed and
> that isn't realised. The PPS signal continues to be generated but
> is now unsynchronised and drifts. Yet PPS users continue to
> believe it's accurate.

And again, there is another use-case which actually needs 
thisunsynchronised signal


