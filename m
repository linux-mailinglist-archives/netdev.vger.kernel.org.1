Return-Path: <netdev+bounces-273116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBWsIkFRymmb7QUAu9opvQ
	(envelope-from <netdev+bounces-273116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:32:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2842359591
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48AAB3043FBA
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E44E3BADB5;
	Mon, 30 Mar 2026 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SzMLjlBB"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D002E3BADBC
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866468; cv=none; b=lb/YTPIoHQIpHY+uo+o4avtEXtfc5naSZyoWssyVD3v38nrBmSIJhu5BFuKKPi1KxUdVn0rtcpAYx2ukP9JWmqylCfvkhbvJCP57rLVdK3D7alqsGxCX8+897RqVsYF6pUQyxTxBowRU79TatN+KOMTKfh8643t3KC3k91+nPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866468; c=relaxed/simple;
	bh=+Qteq5dPyhbY15tJRt3TuJmErEIzgLhr1XV4UIcwuoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ON6IueV7rAbGxZJVmmpd/H3AVkw7bbI4PY0SjXkh4I+4eW3F0pAQgzDVj1YG0RTFArfEzY3sWvTg910h04hs3omGYthV6Do4blGhsvZxE9xYnth5mWoIOvdusUVKyKdY79sC1Dnx0ITo7tGDDY09O4E44lku9fallrR072qzI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SzMLjlBB; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <447c9ec1-2f3e-4da6-bcd0-febce271ae6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774866454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUQgRzqepPeMNaAgLk7AwaLDULRzH/pnHtqpTNEISBs=;
	b=SzMLjlBB+PjsuuLHyVZ/zuy1uGb/2ASld9OBG6zvgqhznPEtkHaByJk3pawZdIk3/Ej/Ip
	C1dHEx9DpU/ABODUw2aCem3p9GWv7TcdMAqMQdV61HGo+twJ+n7/tAMLGRcox+RHE/XC/w
	lffWMqSFZ/6zwYfFh7J7DLYaoRBeaDI=
Date: Mon, 30 Mar 2026 11:27:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] dpll: add actual frequency monitoring
 callback ops
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260325193914.124898-1-ivecera@redhat.com>
 <20260325193914.124898-3-ivecera@redhat.com>
 <d0a6d302-c5af-4ad1-87e2-fa017bdd96a8@linux.dev>
 <e4372a58-13ba-4581-af4e-28d0c880c7bc@redhat.com>
 <a341fd52-3682-473f-8116-a8323bf846ee@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <a341fd52-3682-473f-8116-a8323bf846ee@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273116-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,resnulli.us,lwn.net,linuxfoundation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,microchip.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2842359591
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 30/03/2026 09:52, Ivan Vecera wrote:
> On 3/26/26 6:48 PM, Ivan Vecera wrote:
>> On 3/26/26 12:21 PM, Vadim Fedorenko wrote:
>>> On 25/03/2026 19:39, Ivan Vecera wrote:
>>>
>>>> +static int dpll_msg_add_actual_freq(struct sk_buff *msg, struct 
>>>> dpll_pin *pin,
>>>> +                    struct dpll_pin_ref *ref,
>>>> +                    struct netlink_ext_ack *extack)
>>>> +{
>>>> +    const struct dpll_device_ops *dev_ops = dpll_device_ops(ref- 
>>>> >dpll);
>>>> +    const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>>>> +    struct dpll_device *dpll = ref->dpll;
>>>> +    enum dpll_feature_state state;
>>>> +    u64 actual_freq;
>>>> +    int ret;
>>>> +
>>>> +    if (!ops->actual_freq_get)
>>>> +        return 0;
>>>> +    if (dev_ops->freq_monitor_get) {
>>>> +        ret = dev_ops->freq_monitor_get(dpll, dpll_priv(dpll),
>>>> +                        &state, extack);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +        if (state == DPLL_FEATURE_STATE_DISABLE)
>>>> +            return 0;
>>>
>>> I think we have to signal back to user that frequency monitoring is
>>> disabled via extack.
>>
>> Hi Vadim,
>>
>> This would break pin-get operation... Do or dump pin-get operation would
>> fail with this extack message.
>>
>> Here we can check if the freq-monitoring is enabled and conditionally
>> call actual_freq_get() or measured_freq_get()

Let's make it this way, we don't want to waste even small amount of
resources for useless call.

>>
>> -or-
>>
>> Call this callback unconditionally and check for return code and if a
>> driver returns e.g. -ENODATA then skip nla_put_64bit() but return
>> success.
>>
>> WDYT?
> 
> Vadim?

Sorry, was AFK this Friday/weekend



