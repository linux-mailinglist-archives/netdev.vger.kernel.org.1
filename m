Return-Path: <netdev+bounces-281742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M8dNKl98GlSUAEAu9opvQ
	(envelope-from <netdev+bounces-281742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:28:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2C48165B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70C0C3079723
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06C02EF653;
	Tue, 28 Apr 2026 09:18:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D92E2852;
	Tue, 28 Apr 2026 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367937; cv=none; b=TdyZhTCAraYjxAOu8GFgZn8Fg9RlWoEhBF2x3I5Dv45n6n81x6jPpwM4ScAzKYAb2pCiDtdnzyKI+MZmrAv5xckm3CvAnOtuPFlY/46HLiF3sfsQ2A4zVaM/AAd9stlgKrfBS8Jn/t3O6jHpBBB92A+tgriPpBVUsOOGb2VYNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367937; c=relaxed/simple;
	bh=hWEKb+8Ve/B5+/4K9nf7ZmA6HaAUHpWBy4yoT5wrjPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uq6m84mnIfIdo2WhkfuHkmQBvtNvnBfQP1wFuxY2OsXQjfI39rDrWY4zXBX6ULZoioFr4g1s0Q3E65FAqz3QKVhgV8d5SxsR6Adl95lC5XXNM8srUqu3XyLkujpK6gQ3K9zn7XwlCd1onRD+WxDYsFmZW4Dg2LrlYH994GAw/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 899634C4431022;
	Tue, 28 Apr 2026 11:18:00 +0200 (CEST)
Message-ID: <091fa6fa-0f1d-40b3-9c32-8401306f0e66@molgen.mpg.de>
Date: Tue, 28 Apr 2026 11:17:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2] ice: wait for reset completion in
 ice_resume()
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org, Kohei Enju <kohei@enjuk.jp>
References: <20260424030345.1140665-1-aaron.ma@canonical.com>
 <0d1ef57c-7ab6-4ed1-bc11-323aeeb12eac@molgen.mpg.de>
 <CAJ6xRxUEcbadApMg0i7ngcqYMUacrGNvCrUZ96sqkW22TsC7iA@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAJ6xRxUEcbadApMg0i7ngcqYMUacrGNvCrUZ96sqkW22TsC7iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53A2C48165B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281742-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:email]

Dear Aaron,


Thank you for your reply.

Am 28.04.26 um 09:53 schrieb Aaron Ma:
> On Mon, Apr 27, 2026 at 6:13 PM Paul Menzel wrote:

>> Am 24.04.26 um 05:03 schrieb Aaron Ma via Intel-wired-lan:
>>> ice_resume() schedules an asynchronous PF reset and returns
>>> immediately. The reset runs later in ice_service_task(). If
>>> userspace tries to bring up the net device before the reset
>>> finishes, ice_open() fails with -EBUSY:
>>>
>>>     ice_resume()
>>>       ice_schedule_reset()          # sets ICE_PFR_REQ, returns
>>>     ...
>>>     ice_open()
>>>       ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
>>>     ...
>>>     ice_service_task()
>>>       ice_do_reset()
>>>         ice_rebuild()               # clears ICE_PFR_REQ, too late
>>>
>>> Reproduced on E800 series NICs during suspend/resume with irdma
>>> enabled, where the aux device probe widens the race window.
>>
>> Please document, how you reproduced it, and also paste possible messages
>> by Linux or NetworkManager, so that people can easily search for the commit.
> 
> The error message is "can't open net device while reset is in progress"
> I can add it in v3 if you like.

Yes, that’d be great.

>   > > Wait for the reset to complete before returning from ice_resume().
>>
>> Please mention the delay length in the commit message.
> 
> The timeout is 10 * HZ (10 seconds), matching the existing usage in
> ice_devlink_info_get() for the same ice_wait_for_reset() call. In
> practice the wait completes in ~300ms.

I often wonder, where the delay values come from. Maybe mention, that 
you copied it.

>>> Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>>> ---
>>> v2: reword comment to clarify best-effort semantics (Kohei Enju)
>>>
>>>    drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>>> index 5f92377d4dfc2..a81eb21ea87c1 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>>> @@ -5635,6 +5635,15 @@ static int ice_resume(struct device *dev)
>>>        /* Restart the service task */
>>>        mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
>>>
>>> +     /* Best-effort wait for the scheduled reset to finish so that the
>>> +      * device is operational before returning. Without this, userspace
>>> +      * (e.g. NetworkManager) may try to open the net device while the
>>> +      * asynchronous reset is still in progress, hitting -EBUSY.
>>> +      */
>>> +     ret = ice_wait_for_reset(pf, 10 * HZ);
>>
>> Why not pass a delay in micro/milliseconds?
> 
> ice_wait_for_reset() takes jiffies — that's the existing API.

It’s recommended to use `msecs_to_jiffies()` to make it HZ invariant.

>>> +     if (ret)
>>> +             dev_err(dev, "Wait for reset failed during resume: %d\n", ret);
>>
>> Mention the delay?
> 
> Good point. I'll include the timeout in the error message in v3.

Awesome.

[…]


Thanks,

Paul

