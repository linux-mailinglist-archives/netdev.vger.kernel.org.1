Return-Path: <netdev+bounces-267945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPebNqbutmnnKgEAu9opvQ
	(envelope-from <netdev+bounces-267945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:38:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52239291CCC
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C2E5300F79A
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F818379EEA;
	Sun, 15 Mar 2026 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VazmMTF7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B24377EA1
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773596319; cv=none; b=jDB50viI0GRtii4fgylKXCFFrKyT+b1N6kyx7AMAlX69Itj8g90cbf1mmnQB3tCl4xcUKNvrIT/Kl4MKwmxBUHYWeCDqGLQSsGacafOJpjpH/HVWDdDxq6B42n+eKC6jeJPhQ70h1+wNpojJ8VTygSOoOstQcMJlhRgdlEYQBK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773596319; c=relaxed/simple;
	bh=iBQ/RmIBuOV6VSBa1klkJGFdJiH8oQd7jZJru+/UZoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryP2hzFRgJKUnCem4VVmiLZRD4SHCU8gl8MRlEl63ouyr53kMNT0gVvCadX/nPocjo6a6Nv1F+KBgNBTSrdmm35N6oLMU+h8reWWFkTEp0Qft5NdF2KplKUkCzPKHgm2qh0nJU8nbKyWiaV9G9cppkisPEdL3qIgZCwCoqCH1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VazmMTF7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773596316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92yQn7f64JNa760O3HTBqIWvm6sE3vRlAjefmSPO4yE=;
	b=VazmMTF7FqoTAVaOIiYQwF/kQLqVDeADzydsTmoRrI5NsjMk02qkE2aIITQGB0qfFXZ1Ff
	sqXq7xkkCGChta52BQZdKYsvqmir39A5kAMl51griHEoHeSeBAVEb2ZxfqBUW+baZPuDNQ
	bO/EPaITo+eSeeLmlwR1PlM3BDZgykc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-Ms3qZChxNCGcElSYuDM2PQ-1; Sun,
 15 Mar 2026 13:38:33 -0400
X-MC-Unique: Ms3qZChxNCGcElSYuDM2PQ-1
X-Mimecast-MFC-AGG-ID: Ms3qZChxNCGcElSYuDM2PQ_1773596312
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E9961956088;
	Sun, 15 Mar 2026 17:38:32 +0000 (UTC)
Received: from [10.45.224.46] (unknown [10.45.224.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52917300019F;
	Sun, 15 Mar 2026 17:38:28 +0000 (UTC)
Message-ID: <a4ffd3b0-e5a0-4c2c-9f2a-117034a0e4b7@redhat.com>
Date: Sun, 15 Mar 2026 18:38:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,5/6] dpll: zl3073x: add reference priority to
 zl3073x_chan
To: Jakub Kicinski <kuba@kernel.org>
Cc: mschmidt@redhat.com, linux-kernel@vger.kernel.org,
 Prathosh.Satish@microchip.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, poros@redhat.com,
 netdev@vger.kernel.org
References: <20260311190055.139006-6-ivecera@redhat.com>
 <20260314195358.2710968-2-kuba@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260314195358.2710968-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267945-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 52239291CCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/14/26 8:53 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "Is this legit? Quite hard to follow the logic of this change :/"
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> dpll: zl3073x: add reference priority to zl3073x_chan
> 
> This commit caches the ZL_REG_DPLL_REF_PRIO registers in the zl3073x_chan
> cfg group, adding a ref_prio[] array and inline helpers for accessing
> priority values. It extends state_fetch and state_set with DPLL mailbox
> operations to read and write these priority registers.
> 
>> diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
>> index 10189c8a5ded..74d00cee624e 100644
>> --- a/drivers/dpll/zl3073x/chan.c
>> +++ b/drivers/dpll/zl3073x/chan.c
> 
> [ ... ]
> 
>> @@ -85,7 +102,9 @@ const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
>>    * @chan: desired channel state
>>    *
>>    * Skips the HW write if the configuration is unchanged, and otherwise
>> - * writes the mode_refsel register to hardware.
>> + * writes only the changed registers to hardware. The mode_refsel register
>> + * is written directly, while the reference priority registers are written
>> + * via the DPLL mailbox interface.
>>    *
>>    * Return: 0 on success, <0 on HW error
>>    */
>> @@ -93,14 +112,48 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
>>   			   const struct zl3073x_chan *chan)
>>   {
>>   	struct zl3073x_chan *dchan = &zldev->chan[index];
>> -	int rc;
>> +	int rc, i;
>>
>>   	/* Skip HW write if configuration hasn't changed */
>>   	if (!memcmp(&dchan->cfg, &chan->cfg, sizeof(chan->cfg)))
>>   		return 0;
>>
>> -	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
>> -			      chan->mode_refsel);
>> +	/* Direct register write for mode_refsel */
>> +	if (dchan->mode_refsel != chan->mode_refsel) {
>> +		rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
>> +				      chan->mode_refsel);
>> +		if (rc)
>> +			return rc;
>> +	}
>> +
>> +	/* Mailbox write for ref_prio if changed */
>> +	if (!memcmp(dchan->ref_prio, chan->ref_prio, sizeof(chan->ref_prio))) {
>> +		dchan->cfg = chan->cfg;
>> +		return 0;
>> +	}
>> +
>> +	guard(mutex)(&zldev->multiop_lock);
>> +
>> +	/* Read DPLL configuration into mailbox */
>> +	rc = zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_RD,
>> +			   ZL_REG_DPLL_MB_MASK, BIT(index));
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Update changed ref_prio registers */
>> +	for (i = 0; i < ARRAY_SIZE(chan->ref_prio); i++) {
>> +		if (dchan->ref_prio[i] != chan->ref_prio[i]) {
>> +			rc = zl3073x_write_u8(zldev,
>> +					      ZL_REG_DPLL_REF_PRIO(i),
>> +					      chan->ref_prio[i]);
>> +			if (rc)
>> +				return rc;
>> +		}
>> +	}
>> +
>> +	/* Commit DPLL configuration */
>> +	rc = zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_WR,
>> +			   ZL_REG_DPLL_MB_MASK, BIT(index));
>>   	if (rc)
>>   		return rc;
>>
> 
> Could this function leave the cache and hardware out of sync?
> 
> When both mode_refsel and ref_prio have changed, the function writes
> mode_refsel to hardware first. If the subsequent mailbox operation fails
> (during the mailbox read, a ref_prio write, or the mailbox commit), the
> function returns an error without executing 'dchan->cfg = chan->cfg'.

This potential situation is very unusual (mode_refsel updated and
mailbox access erroneous) but yes, after successful write of mode_refsel
dchan->mon_refsel should be updated to avoid this issue.

Will fix in v2.

Ivan


