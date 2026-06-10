Return-Path: <netdev+bounces-297748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r779BaCLKWqRZAMAu9opvQ
	(envelope-from <netdev+bounces-297748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:06:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6144866B2B1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:06:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=EyG9GLAF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297748-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297748-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDC6F302E78C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6B34C9554;
	Wed, 10 Jun 2026 15:46:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7050A4C954D
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:45:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106363; cv=none; b=UaFQjduItb5zk+Yfd2FPxEee3luE0CqjM1nLAwmpJBvdANFR9UttKX0K4i7coA8lUISgiWrR2dnvnTFUwsvC/zRpCVwqO2dHni3TuMfUhaDQDU00ReHOQEOPwecDBiVs+JchW0LbsqKwtbnWMAcHZSMV8BBXDDW2U1ldyKi0BcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106363; c=relaxed/simple;
	bh=8zXg3+fyE6EnwY2HwLAjCOq0zy/aBP0iU+dkKE03NbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4x2aQLJoTQL/mKSdbc5FwudIJNiGiwl4H8bv23miORdPfDSWXoVUfxqYJalMrLqbfY39AOG6HNVoeJd0TBCMkZZUbNDPD+NMRGHnO6OHgOP+fqSuYNPSxi9bBtbK+XbiLt0MWmJ6Sh02xT2u9VL6XfbQTWcfRENz7zsPyXmtrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyG9GLAF; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781106358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pg/eH6eAgTrBl8GUt4o9Qkj3EqMNeSXuv8C5por2LI=;
	b=EyG9GLAFkP6aReqeQS8Ti+vpaazMQXA5O7E3ZRLgoW6oYoEXIay0gtn/GM0WfikS4da93O
	oAwTdK1wKYsjEmRkgj64DEkkPU7SJsRIIkxZB6FOgtU5b8knQck91xoHCngGzhBFFoaaQD
	8F5sBOnfJflwaJfyVKLhaPPRKOeUZAk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-Bwr_QS2dO4OEoyAJ9ezYsQ-1; Wed,
 10 Jun 2026 11:45:55 -0400
X-MC-Unique: Bwr_QS2dO4OEoyAJ9ezYsQ-1
X-Mimecast-MFC-AGG-ID: Bwr_QS2dO4OEoyAJ9ezYsQ_1781106353
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB3341944F2E;
	Wed, 10 Jun 2026 15:45:51 +0000 (UTC)
Received: from [10.44.32.96] (unknown [10.44.32.96])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F94327A;
	Wed, 10 Jun 2026 15:45:47 +0000 (UTC)
Message-ID: <fcaa184b-f9e9-44c4-bae8-c4a9c6c41239@redhat.com>
Date: Wed, 10 Jun 2026 17:45:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Schmidt, Michal" <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, "Vaananen, Pasi" <pvaanane@redhat.com>,
 "Oros, Petr" <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <CH0PR11MB5394BA7DB19301ECD5F9B0139B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <b5853501-969a-4ac3-8aff-83c9da9c9834@redhat.com>
 <CH0PR11MB53941698BDF5C3B8298CC0679B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <aifTFMZtWBgLzhCS@FV6GYCPJ69>
 <CH0PR11MB5394DA86D0D2CA45FD3DBEA79B1D2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <99cebea4-156a-4379-922e-07c50f766fbe@redhat.com>
 <BN9PR11MB5401F6BA29CBA6F0C78FDB119B1A2@BN9PR11MB5401.namprd11.prod.outlook.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <BN9PR11MB5401F6BA29CBA6F0C78FDB119B1A2@BN9PR11MB5401.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297748-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:arkadiusz.kubalewski@intel.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,kernel.org,redhat.com,microchip.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp,resnulli.us:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6144866B2B1

On 6/10/26 3:04 PM, Kubalewski, Arkadiusz wrote:
>> From: Ivan Vecera <ivecera@redhat.com>
>> Sent: Tuesday, June 9, 2026 4:59 PM
>>
>> On 6/9/26 4:00 PM, Kubalewski, Arkadiusz wrote:
>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>> Sent: Tuesday, June 9, 2026 10:51 AM
>>>>
>>>> Mon, Jun 08, 2026 at 07:03:46PM +0200, arkadiusz.kubalewski@intel.com
>>>> wrote:
>>>>>> From: Ivan Vecera <ivecera@redhat.com>
>>>>>> Sent: Monday, June 8, 2026 5:48 PM
>>>>>>
>>>>>> On 6/8/26 4:43 PM, Kubalewski, Arkadiusz wrote:
>>>>>>>> From: Ivan Vecera <ivecera@redhat.com>
>>>>>>>> Sent: Sunday, May 31, 2026 9:44 PM ...
>>>>>>>>          -
>>>>>>>>            name: gnss
>>>>>>>>            doc: GNSS recovered clock
>>>>>>>> +      -
>>>>>>>> +        name: int-nco
>>>>>>>> +        doc: |
>>>>>>>> +          Device internal numerically controlled oscillator.
>>>>>>>> +          When connected as a DPLL input, the DPLL enters NCO mode
>>>>>>>> +          where the output frequency is adjusted by the host via
>>>>>>>> +          the PTP clock interface.
>>>>>>>
>>>>>>> Hi Ivan!
>>>>>>>
>>>>>>> How would you control this in case of automatic mode dpll?
>>>>>>> Automatic mode DPLL shall be controlled on HW level, such pin
>>>>>>> brakes that rule and requires some driver magic to show it is
>>>>>>> higher priority then the rest of the pins?
>>>>>>
>>>>>> The NCO pin can be connected only in manual mode. In other words a
>>>>>> DPLL in automatic mode cannot select NCO pin (switch to NCO mode) by
>>>>>> its own.
>>>>>>
>>>>>
>>>>> Being picky on DPLL_MODE for enabling feature is not something we
>>>>> can allow if it is not related to HW limitation, is it?
>>>>> Could you please elaborate why it is not possible for AUTOMATIC mode?
>>>>
>>>> In automatic mode, the pin selection logic is defined upon prio. I
>>>> can imagine that if NCO pin has the highest prio of the available
>>>> ones, it gets picked. I would be aligned 100% with automatic mode
>>>> behaviour.
>>>> Is there a real usecase for it?
>>>>
>>>> [..]
>>>
>>> This is not true. AUTOMATIC mode is HW solution, SW driver ONLY
>>> configures priorities on the inputs, not manages the active inputs.
>>> This brakes that behavior, the SW driver would have to manually
>>> override the AUTMATIC mode to be fed from such NCO pin as it doesn't
>>> exists on it's priority list, HW cannot pick or use it.
>>
>> Correct, AUTO mode is hardware feature and it should not be emulated by a
>> driver. If the hardware does not support it then the switching between
>> input references should be done by userspace (by monitoring ffo,
>> phase_offset, operstate).
>>
> 
> Yes, exactly, so for AUTOMATIC mode HW it will not be possible to create
> such pin, which means that NCO pin would serve only a MANUAL mode
> implementation.
> Basically this is something we shall not allow to happen. DPLL API
> should be designed to cover the case where AUTO mode is able to implement
> all features consistently.

If you don't like the proposal from Jiri (NCO switch driven by NCO pin
priority -> highest==enter_nco else leave_nco) then it could be possible
to handle the switching by allowing the state 'connected' in AUTO mode
for the NCO pin type. Then the implementation will be the same for both
selection modes.

Only difference would be that a user does not need to switch the device
from the AUTO to MANUAL mode.

>>> The real use case is that any DPLL can switch the mode to this one
>>> instead of implementing MANUAL mode just to use the feature with a
>>> 'virtual' pin.
>>
>> I don't expect this... but it is up to a driver. I don't plan such
>> functionality in zl3073x as the NCO pin does not expose prio_get() and
>> prio_set() callbacks - so it is clear that this pin cannot be part of the
>> automatic selection.
>>
>> Ivan
> 
> There is a difference between particular HW and API capabilities, with the
> proposed API we would disallow the possibility of such implementation for
> existing HW variants.
> 
> DPLL NCO MODE would allow that but as pointed here by Ivan and by Jiri in
> the other email it would also require the extra implementation for some
> configuration - device level phase/ffo handling.
> 
> To summarize it all, I don't have such simple solution for it.
> 
> First thing that comes to my mind is to combine both approaches.
> Make it possible for AUTMATIC mode to also set "CONNECTED" state
> on certain kind of "OVERRIDE" pins, where it could be determined by
> the type of PIN and embed that logic into the DPLL subsystem.

The possible states for particual pins are now handled at a driver level
so the driver decides if the requested state is correct or not. So it
could be easy to implement this.

For auto mode allowed states:
- input references: selectable / disconnected
- nco pin: connected / disconnected

> Basically, if driver registers such NCO pin it would be always selected
> manually, and in such case all the other pins are going to disconnected
> state while DPLL mode is also a "OVERRIDE" or something like it.

I would leave this decision on the driver level... Imagine the potential
HW that would allow to switch NCO mode if there is no valid input
reference.

Example:

REF0 (prio 0) -> +------+ -> OUT0
REF1 (prio 1) -> | DPLL | -> ...
NCO  (prio 2) -> +------+ -> OUTn

Such HW would prefer REF0 or REF1 and lock to one of them if they are
qualified. But if they are NOT, then it switches to NCO mode.

In this situation the relevant driver would allow to configure priority
and state 'selectable' for this NCO pin.

> Perhaps the pin type could include OVERRIDE in it's name to make it less
> confusing and needs some extra documentation.
> 
> Thoughts?
I think _INT_ is ok. In the case of TYPE_INT_OSCILLATOR it is also
obvious that it is not a standard input reference.

Jiri, Vadim, Arek, thoughts?

Thanks,
Ivan


