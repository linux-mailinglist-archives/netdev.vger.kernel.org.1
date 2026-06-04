Return-Path: <netdev+bounces-295299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tp/kNr6YIWp4JgEAu9opvQ
	(envelope-from <netdev+bounces-295299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:24:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5881D641651
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:24:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=RAeuNdTi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295299-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295299-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CB453140381
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3033033C1B4;
	Thu,  4 Jun 2026 15:12:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF92B33B97D
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 15:12:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585978; cv=none; b=XcPmFerJL4uLYm0pAgikmbrrq8zmbGlGqarlfrgg3qLD41qLLQQtWeQvIPFmzQjBuIUG+8aDbO2EJaFZZAf6Ra8JAV6+/p0c51bSYAcigSNFrVIjkcZEd7zZLkxjO22QzWjlyeHlUsjYScr/DL61GlgqQO49Gxj5Pdwq1bJ3bZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585978; c=relaxed/simple;
	bh=L6b6QajUPBTYjNP8ITCBbJcFVFy4bWuhr7sa4wHr+5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtD32dGdK45PqrneZ6S0s2HhpmxAy3KFOsJ13pqeSUmcytaKjmDdTfVdiuw+HYIbmlEY77LxQlqyh7sKuqSHb5YGLFwQiBYR4+5grkOnOJckuxPmOqdzvZeRJeNPpiAXtfqNl1naW4GFzz8sTgZVhZy1sbF6ZSMJ6tb8psQK5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RAeuNdTi; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780585975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTfub8dwzVRomy/N4xiD9EU4gR/kBb4bnDPkTmil8OY=;
	b=RAeuNdTiuvd0fAkV0C2ecM6gvw8v8RYThM+hEz+UyJshbRnnXOVKyTWA/MOFzP0XSXMc0W
	Iiv2HsjlM2XquIdtixvfUWOok8Yjtmrx5q9vwKzhvLebFcPT9Fdmvtg/B0x2JdSxwW1FIc
	IrfnjIn1JO52/TQcGApn70FzgX7gPMU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-gbueSX3kOLae2JWmyFBemw-1; Thu,
 04 Jun 2026 11:12:52 -0400
X-MC-Unique: gbueSX3kOLae2JWmyFBemw-1
X-Mimecast-MFC-AGG-ID: gbueSX3kOLae2JWmyFBemw_1780585970
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79585195608C;
	Thu,  4 Jun 2026 15:12:50 +0000 (UTC)
Received: from [10.44.49.177] (unknown [10.44.49.177])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 643AD1955BC1;
	Thu,  4 Jun 2026 15:12:46 +0000 (UTC)
Message-ID: <b216ba07-6274-402b-84bc-a10b3fb6d317@redhat.com>
Date: Thu, 4 Jun 2026 17:12:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/4] dpll: zl3073x: add per-DPLL serialization
 lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, poros@redhat.com, arkadiusz.kubalewski@intel.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 jiri@resnulli.us, mschmidt@redhat.com, pabeni@redhat.com,
 pvaanane@redhat.com, Prathosh.Satish@microchip.com, horms@kernel.org,
 vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org
References: <20260531194423.383366-4-ivecera@redhat.com>
 <20260604015127.2872457-1-kuba@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260604015127.2872457-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295299-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:poros@redhat.com,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,intel.com,davemloft.net,gmail.com,google.com,resnulli.us,microchip.com,kernel.org,linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5881D641651

Hi Kuba,

On 6/4/26 3:51 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "While we wait for more acks - claude says.."
> ---
> dpll: zl3073x: add per-DPLL serialization lock
> 
> This patch adds a per-DPLL mutex serializing netlink callbacks and the
> periodic worker, moves zl3073x_chan_state_update() under the new lock,
> defers change notifications outside the lock to avoid ABBA with
> dpll_lock, and converts pin->freq_offset from atomic64_t to plain s64.
> 
>> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
>> index 0b2050aa2ed9..27c71807e4ef 100644
>> --- a/drivers/dpll/zl3073x/core.c
>> +++ b/drivers/dpll/zl3073x/core.c
>> @@ -567,19 +567,7 @@ zl3073x_dev_ref_states_update(struct zl3073x_dev *zldev)
>>   	}
>>   }
>>   
>> -static void
>> -zl3073x_dev_chan_states_update(struct zl3073x_dev *zldev)
>> -{
>> -	int i, rc;
>>   
>> -	for (i = 0; i < zldev->info->num_channels; i++) {
>> -		rc = zl3073x_chan_state_update(zldev, i);
>> -		if (rc)
>> -			dev_warn(zldev->dev,
>> -				 "Failed to get DPLL%u state: %pe\n", i,
>> -				 ERR_PTR(rc));
>> -	}
>> -}
> 
> [ ... ]
> 
>> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>> index 5e58ded5734d..4bee3d0c4659 100644
>> --- a/drivers/dpll/zl3073x/dpll.c
>> +++ b/drivers/dpll/zl3073x/dpll.c
> 
> [ ... ]
> 
>> @@ -1817,27 +1906,37 @@ zl3073x_dpll_pin_measured_freq_check(struct zl3073x_dpll_pin *pin)
>>   void
>>   zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
>>   {
>> +	DECLARE_BITMAP(changed_pins, ZL3073X_NUM_INPUT_PINS);
>>   	struct zl3073x_dev *zldev = zldpll->dev;
>>   	enum dpll_lock_status lock_status;
>>   	struct device *dev = zldev->dev;
>>   	struct zl3073x_dpll_pin *pin;
>> +	bool dev_changed = false;
>>   	int rc;
>>   
>> +	bitmap_zero(changed_pins, ZL3073X_NUM_INPUT_PINS);
>> +
>> +	mutex_lock(&zldpll->lock);
>> +
>>   	zldpll->check_count++;
>>   
>> -	/* Get current lock status for the DPLL */
>> -	rc = zl3073x_dpll_lock_status_get(zldpll->dpll_dev, zldpll,
>> -					  &lock_status, NULL, NULL);
>> +	rc = zl3073x_chan_state_update(zldev, zldpll->id);
>> +	if (rc) {
>> +		dev_err(dev, "Failed to get DPLL%u state: %pe\n",
>> +			zldpll->id, ERR_PTR(rc));
>> +		goto unlock;
>> +	}
> 
> [Low]
> The previous code path, zl3073x_dev_chan_states_update() in core.c, used
> dev_warn() and continued the periodic update for the device, allowing the
> subsequent lock-status, phase-offset and per-pin checks to run for every
> DPLL even when an individual chan_state_update() failed.

Well, any error zl3073x_chan_state_update() are very very unusual and
if they happen (communication error, timeout) then it means that
the device hangs or there is an bus (I2C controller) error.

> After this change, a single failure of zl3073x_chan_state_update() inside
> zl3073x_dpll_changes_check() is logged at dev_err and triggers
> goto unlock, skipping all remaining work for that DPLL in that cycle:
> 
> 	rc = zl3073x_chan_state_update(zldev, zldpll->id);
> 	if (rc) {
> 		dev_err(dev, "Failed to get DPLL%u state: %pe\n",
> 			zldpll->id, ERR_PTR(rc));
> 		goto unlock;
> 	}
> 
> The commit message describes the move only as a serialization change so
> that it "runs under zldpll->lock". Should the log-level promotion from warn
> to err and the new short-circuit of the rest of the cycle on transient
> register-read failures be mentioned in the commit message, or alternatively
> preserved as warn-and-continue?

I think the error is more appropriate in this case.

>> +
>> +	rc = __zl3073x_dpll_lock_status_get(zldpll, &lock_status);
>>   	if (rc) {
>>   		dev_err(dev, "Failed to get DPLL%u lock status: %pe\n",
>>   			zldpll->id, ERR_PTR(rc));
>> -		return;
>> +		goto unlock;
>>   	}
> 
> [ ... ]
> 
>>   }
> 
> The commit message states:
> 
>      All DPLL pin and device callbacks that access mutable state take the
>      lock as the first operation.
> 
> [Low]
> Does this hold for zl3073x_dpll_freq_monitor_get() and
> zl3073x_dpll_freq_monitor_set()? Both are device callbacks that read or
> write zldpll->dev->freq_monitor, but neither takes zldpll->lock:
> 
> 	static int
> 	zl3073x_dpll_freq_monitor_get(const struct dpll_device *dpll, ...)
> 	{
> 		struct zl3073x_dpll *zldpll = dpll_priv;
> 
> 		if (zldpll->dev->freq_monitor)
> 			*state = DPLL_FEATURE_STATE_ENABLE;
> 		else
> 			*state = DPLL_FEATURE_STATE_DISABLE;
> 
> 		return 0;
> 	}
> 
> 	static int
> 	zl3073x_dpll_freq_monitor_set(const struct dpll_device *dpll, ...)
> 	{
> 		struct zl3073x_dpll *item, *zldpll = dpll_priv;
> 
> 		zldpll->dev->freq_monitor = (state == DPLL_FEATURE_STATE_ENABLE);
> 		...
> 	}
> 
> The same field is read in zl3073x_dpll_pin_measured_freq_check() under
> lockdep_assert_held(&zldpll->lock):
> 
> 	static bool
> 	zl3073x_dpll_pin_measured_freq_check(struct zl3073x_dpll_pin *pin)
> 	{
> 		...
> 		lockdep_assert_held(&zldpll->lock);
> 
> 		if (!zldpll->dev->freq_monitor)
> 			return false;
> 		...
> 	}
> 
> freq_monitor is a per-device bool shared by all channels, so the per-DPLL
> lock would not provide cross-DPLL serialization for it anyway. Should the
> commit message carve out an exception for this per-device field, or should
> some appropriate lock be taken in the freq_monitor get/set callbacks to
> match the stated invariant?

The assert is not for serializing accesses to zldpll->dev->*_monitor and
could be moved below this 'if'... Do you want to move it?

Regarding cross-DPLL serialization, IMHO this is an overkill just for
toggles like zldpll->dev->freq_monitor.

Thoughts?

Thanks,
Ivan


