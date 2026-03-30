Return-Path: <netdev+bounces-273102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLESKaI7ymnD6gUAu9opvQ
	(envelope-from <netdev+bounces-273102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:00:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F06A6357A4E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CBDC304002B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52E3ACA6B;
	Mon, 30 Mar 2026 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mt5BNCFx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE9382383
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860769; cv=none; b=Rr/aAVjnj84cvvmUAH8teEsuIe4qLNW4LHkjUZrIEkblzuhSPrPlPwrukXX/ONusUzGiLPsKR96iEqM1a9MdkI4a6loR6GKvCkhPnzMmsV2E9iOtUMTU/QnWX8uZ+wc5KpqDBCGu95FRDqGqZ1OQdFLQxIbz1mcuV7fj796MBls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860769; c=relaxed/simple;
	bh=AA2BdMUW7VfEiqAUAzVMsm0H/MPU3SGAH/WOlBUEhSw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DmZ7i5o3/Sd9tsC1gWLF5Yu+EfpcRM0rsiMMAifjiCCC0nOwslejKOAFElT2S9JJyahe3MUfXhS4ibiJi/5iU/9d8ftTTZbIKj3m/zEBpOFULOcSSGs+/miYIADn5EyQ3ZPpXJX9FOdOQ5HvE9WYnowmF4rpNEMnBz+9nLbWwPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mt5BNCFx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774860766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=or/KOdTHYhj19Ns3SWZkcQKqCJUJy40IjMw5ydB3GXk=;
	b=Mt5BNCFxGFvA5kjrq1dKKJwqb3zGhCYyxcQBd+bJMnC2BSYZERCjbWZZyE68mhT5NPwpjl
	ME/Z/ozkidtgZPau5Ow4FPLPld0T33r7C23LdDVdKUlrbwHiwR05nAg1KP67DTyuSjAwJ7
	qX/YyvuY32+KonwkKEA+6oR4VA1AlQk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-PbSe9W_gOB-x8qrN-X81PA-1; Mon,
 30 Mar 2026 04:52:45 -0400
X-MC-Unique: PbSe9W_gOB-x8qrN-X81PA-1
X-Mimecast-MFC-AGG-ID: PbSe9W_gOB-x8qrN-X81PA_1774860763
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 873F51800610;
	Mon, 30 Mar 2026 08:52:42 +0000 (UTC)
Received: from [10.44.33.70] (unknown [10.44.33.70])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E5FC1800107;
	Mon, 30 Mar 2026 08:52:37 +0000 (UTC)
Message-ID: <a341fd52-3682-473f-8116-a8323bf846ee@redhat.com>
Date: Mon, 30 Mar 2026 10:52:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] dpll: add actual frequency monitoring
 callback ops
From: Ivan Vecera <ivecera@redhat.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
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
Content-Language: en-US
In-Reply-To: <e4372a58-13ba-4581-af4e-28d0c880c7bc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273102-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,resnulli.us,lwn.net,linuxfoundation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,microchip.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F06A6357A4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 6:48 PM, Ivan Vecera wrote:
> On 3/26/26 12:21 PM, Vadim Fedorenko wrote:
>> On 25/03/2026 19:39, Ivan Vecera wrote:
>>
>>> +static int dpll_msg_add_actual_freq(struct sk_buff *msg, struct 
>>> dpll_pin *pin,
>>> +                    struct dpll_pin_ref *ref,
>>> +                    struct netlink_ext_ack *extack)
>>> +{
>>> +    const struct dpll_device_ops *dev_ops = dpll_device_ops(ref->dpll);
>>> +    const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>>> +    struct dpll_device *dpll = ref->dpll;
>>> +    enum dpll_feature_state state;
>>> +    u64 actual_freq;
>>> +    int ret;
>>> +
>>> +    if (!ops->actual_freq_get)
>>> +        return 0;
>>> +    if (dev_ops->freq_monitor_get) {
>>> +        ret = dev_ops->freq_monitor_get(dpll, dpll_priv(dpll),
>>> +                        &state, extack);
>>> +        if (ret)
>>> +            return ret;
>>> +        if (state == DPLL_FEATURE_STATE_DISABLE)
>>> +            return 0;
>>
>> I think we have to signal back to user that frequency monitoring is
>> disabled via extack.
> 
> Hi Vadim,
> 
> This would break pin-get operation... Do or dump pin-get operation would
> fail with this extack message.
> 
> Here we can check if the freq-monitoring is enabled and conditionally
> call actual_freq_get() or measured_freq_get()
> 
> -or-
> 
> Call this callback unconditionally and check for return code and if a
> driver returns e.g. -ENODATA then skip nla_put_64bit() but return
> success.
> 
> WDYT?

Vadim?


