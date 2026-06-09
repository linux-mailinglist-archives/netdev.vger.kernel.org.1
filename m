Return-Path: <netdev+bounces-297099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cKGhHbovKGob/wIAu9opvQ
	(envelope-from <netdev+bounces-297099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:22:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05878661AEA
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:22:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=JxLBbwhH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297099-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297099-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12D873293FF9
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D7B34D3B0;
	Tue,  9 Jun 2026 15:09:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135E35E1D7
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:09:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017763; cv=none; b=eEAmiS2Um9XaIdv2sxORilzxTyrcW58w6DtMfqT+naa5vln98AeKWmuY9TPfSKMRMQDzFBrVlGGlwDYdtzP8yx3UNRyz+XlYN6ddQDzvqLa3me8iSydEgYEC+Wjf19kl1yTIPDB2W5LlHa9kFFlAtiN0RRcgfq2mqDPTELDLPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017763; c=relaxed/simple;
	bh=IMVCwKUih2Uqw58wkHLuxSJ2gYUl2swmL+hraZIoj6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4IoNh6UVwPEjYsU8a14IJgtDMI3h0NaE1nb01DE/GJMxPvhzGGhuXHJJ0OfE869nbjO+rGVlaAu216DM3m0nZNtMv0DE75x3aJLAbVV/7lhPrT9b/nUmgaV41w4eyIRV+eYnF80MZR63lmIE0D1bPT1kPjZpeXFGTlO76OcpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxLBbwhH; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781017761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7fPu4IonwtQPpiECu+HiO3W2XcnZJwWMr5HGoOfkZs=;
	b=JxLBbwhHKT/y2bphIdpuJIIW2GRxoNIlGGq70Eh+VEtzZRWDLSafeRpD5pwX3fedNQhwXH
	PkR0jeJ0GrVdzqZMxHhpcuPwyZN+n2QqhUQWfdRKFEFQsa/4twbp8+PV6w5a99fXD+VYFO
	QN4DHVjVaTVcfVdkG9YIeZu3vmyCBoU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-q3YY3ZGyNOOBIH5Ue4XL-Q-1; Tue,
 09 Jun 2026 11:09:18 -0400
X-MC-Unique: q3YY3ZGyNOOBIH5Ue4XL-Q-1
X-Mimecast-MFC-AGG-ID: q3YY3ZGyNOOBIH5Ue4XL-Q_1781017756
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90BAB184EB4C;
	Tue,  9 Jun 2026 15:09:15 +0000 (UTC)
Received: from [10.44.34.233] (unknown [10.44.34.233])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E3151954B00;
	Tue,  9 Jun 2026 15:09:11 +0000 (UTC)
Message-ID: <0011d6be-2ffb-4584-9ad7-86b3da447412@redhat.com>
Date: Tue, 9 Jun 2026 17:09:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Grzegorz Nitka <grzegorz.nitka@intel.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <20260603185037.05f8c6a0@kernel.org>
 <be19bd30-0bb0-4a22-8932-e62f7678ccc5@redhat.com>
 <20260604081649.1ae5302d@kernel.org>
 <3c5e01f5-8563-41a3-964f-13fcb80383b7@redhat.com>
 <d6b69d21-4542-498d-8253-7009a56634cc@linux.dev>
 <9b493ce2-6213-4a29-aeee-b473b6b16fa1@redhat.com>
 <b8e9aaed-3256-4501-a164-19a00f03d296@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <b8e9aaed-3256-4501-a164-19a00f03d296@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297099-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:kuba@kernel.org,m:arkadiusz.kubalewski@intel.com,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:grzegorz.nitka@intel.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,resnulli.us,redhat.com,microchip.com,kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05878661AEA

On 6/9/26 12:24 PM, Vadim Fedorenko wrote:
> On 08/06/2026 16:30, Ivan Vecera wrote:
>> On 6/8/26 1:33 PM, Vadim Fedorenko wrote:
>>> On 04/06/2026 17:42, Ivan Vecera wrote:
>>>> On 6/4/26 5:16 PM, Jakub Kicinski wrote:
>>>>> On Thu, 4 Jun 2026 17:01:36 +0200 Ivan Vecera wrote:
>>>>>>> Purely going on intuition here but feels like NCO should be a mode
>>>>>>> (enum dpll_mode) rather than one of the input pins?
>>>>>>>
>>>>>>> More acks here would be great, Vadim, Arkadiusz, Grzegorz... ?
>>>>>>
>>>>>> I had a long discussion with Jiri about this and we agreed finally
>>>>>> that dpll_mode represents a reference (input pin) selection strategy
>>>>>> mode and not a DPLL device running mode.
>>>>>
>>>>> Long discussion? I see 2 emails ;) Let's hear from others.
>>>>> (thanks for the link BTW, _if_ there's a v6 please put it in the cover
>>>>> letter)
>>>>
>>>> I called him... he explained me 'why?' in detail.
>>>> I also appreciate others' opinion.
>>>
>>> Well, NCO mode means manual operation of frequency tuning. Does it mean
>>> that different tunings may be applied to different out pins of DPLL
>>> device? My assumption that it's not possible, and in this case NCO is
>>> property/mode of DPLL device rather than single pin.
>>
>> The NCO pin is only one per device... When it is connected, then the
>> device the pin is connected to is switched to NCO mode. In this mode
>> the device is not locked to any input reference and the driver allows
>> tuning of the DPLL frequency manually via PTP interface.
>>
>> Such tuning is applied only to output pins associated with this device
>> but not on others.
>>
>> Examples:
>> DPLL0 is driving output 0-3 and DPLL1 is driving output 4-7.
>> Then if you switch the DPLL0 to NCO mode (makes NCO pin connected to it)
>> then frequency tuning (via PTP) has only influence on output 0-3 (the
>> same tuning is applied). Outputs 4-7 are not touched as they are driven
>> by DPLL1 (that can be locked to some input reference).
>>
>> If you switch both DPLLs to NCO, then frequency tuning for DPLL0 affects
>> output 0-3 and tuning for DPLL1 output 4-7.
> 
> Technically speaking you have described per-device behavior. And NCO pin
> can technically be virtual, just a configuration option via normal
> device communication channel. Doesn't feel like pin's attribute. Back in
> a days of DPLL RFC patches we have discussed the option with Arkadiusz,
> AFAIR we were leaning towards per-DPLL state for this case.

Frequency fine tuning is not the subject of this patchset. It is
currently part of the PTP API via the .adjfine() callback. I have not
added this feature yet, because it would be a duplication of part of the
PTP API, but if there is a consensus, we can add it as a per-device
attribute.

Something like dpll device attributes:
* fractional-frequency-adjust
   - corresponds to .adjfine()
   - tunes dpll device frequency (usable mostly in NCO mode because when
     the device is locked to physical reference then its frequency is
     driven by this ref)
* phase-adjust
   - corresponds to .adjphase()
   - adjusts phase of all outputs driven by this dpll device performed
     at once

Thanks,
Ivan


