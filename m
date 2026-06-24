Return-Path: <netdev+bounces-301708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hQ60E/r+O2ruhwgAu9opvQ
	(envelope-from <netdev+bounces-301708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:59:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E27166BFDD4
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:59:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=O9bJU5eS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301708-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301708-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 275823025799
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E7D3DB313;
	Wed, 24 Jun 2026 15:58:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECED3DABE3
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:58:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316693; cv=none; b=MW8bjik65C1NsPPjn9+MRcyNmGhcwdfMT4kNPXEppliGH69yjuOt64r19rxZ5Easo8y0bqKYUfzTCBPq+M4OS4SociFtsudO79kQfmR2rJYQFyJZUjalnI/DDHlMiM7qzUGiW+DsExkegHSuIFQwBG8VI7VMtcOUumgN2l8yuY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316693; c=relaxed/simple;
	bh=qOCC82zbDgLAtAREZQopsMCl/TVgetNqjetFo74q+W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhcMeLl8D5wUF7QjYI6a8oCv5zhyUHU+4UBaSj112ALHJDhQx0WU3c017N4JHhazdjIVH0fbsZtejDh82kMcWwRPzWF11hmWdk0iRMCZvZ2lTyx8Ugn+YynmX14Xc7cGgEFeqONHqRLtJFyfXaxamgbb97Luhs5wKIQZfIDuSHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O9bJU5eS; arc=none smtp.client-ip=95.215.58.176
Message-ID: <0f8fe4e0-72d8-48a6-96ad-d1650919d2df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782316679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZv/MCvSCCb1CHN0i/0feUhcg9UEbyieYA6SUYVFUR0=;
	b=O9bJU5eSJXvqZVDxNGAu8hcXrrfgzVq+RF2g0JeZYwNjBWfYrnZopXDwIyPvfyh1wYxhjL
	Leu23AEMwkuBfGMsLc0Kkz1Bd2rjj3z46zoiPbJRvQgOlyHc68+sSLs3iutQWWsnM2pxbg
	sKtey5NrIbn8ZlU5slu11nCgWAHVGFU=
Date: Wed, 24 Jun 2026 16:57:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: Ivan Vecera <ivecera@redhat.com>,
 "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 "Schmidt, Michal" <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 "Vaananen, Pasi" <pvaanane@redhat.com>, "Oros, Petr" <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Simon Horman <horms@kernel.org>,
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
 <fcaa184b-f9e9-44c4-bae8-c4a9c6c41239@redhat.com>
 <aiqkZhNdt-WhglDg@FV6GYCPJ69>
 <ca33b9b8-aafa-40f0-9943-a6b6736af4e4@redhat.com>
 <CH3PR11MB8749910F17977B951A8B12CA9BE42@CH3PR11MB8749.namprd11.prod.outlook.com>
 <23e47140-f69f-451d-9154-29071130c11c@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <23e47140-f69f-451d-9154-29071130c11c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301708-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:arkadiusz.kubalewski@intel.com,m:jiri@resnulli.us,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,redhat.com,microchip.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,resnulli.us:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E27166BFDD4

On 19/06/2026 18:07, Ivan Vecera wrote:
> On 6/17/26 1:59 PM, Kubalewski, Arkadiusz wrote:
>>> From: Ivan Vecera <ivecera@redhat.com>
>>> Sent: Monday, June 15, 2026 2:00 PM
>>>
>>> On 6/11/26 2:09 PM, Jiri Pirko wrote:
>>>> Wed, Jun 10, 2026 at 05:45:46PM +0200, ivecera@redhat.com wrote:
>>>>> On 6/10/26 3:04 PM, Kubalewski, Arkadiusz wrote:
>>>>>>> From: Ivan Vecera <ivecera@redhat.com>
>>>>>>> Sent: Tuesday, June 9, 2026 4:59 PM
>>>>>>>
>>>>>>> On 6/9/26 4:00 PM, Kubalewski, Arkadiusz wrote:
>>>>>>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>> Sent: Tuesday, June 9, 2026 10:51 AM
>>>>>>>>>
>>>>>>>>> Mon, Jun 08, 2026 at 07:03:46PM +0200,
>>>>>>>>> arkadiusz.kubalewski@intel.com
>>>>>>>>> wrote:
>>>>>>>>>>> From: Ivan Vecera <ivecera@redhat.com>
>>>>>>>>>>> Sent: Monday, June 8, 2026 5:48 PM
>>>>>>>>>>>
>>>>>>>>>>> On 6/8/26 4:43 PM, Kubalewski, Arkadiusz wrote:
>>>>>>>>>>>>> From: Ivan Vecera <ivecera@redhat.com>
>>>>>>>>>>>>> Sent: Sunday, May 31, 2026 9:44 PM ...
>>>>>>>>>>>>>            -
>>>>>>>>>>>>>              name: gnss
>>>>>>>>>>>>>              doc: GNSS recovered clock
>>>>>>>>>>>>> +      -
>>>>>>>>>>>>> +        name: int-nco
>>>>>>>>>>>>> +        doc: |
>>>>>>>>>>>>> +          Device internal numerically controlled oscillator.
>>>>>>>>>>>>> +          When connected as a DPLL input, the DPLL enters NCO
>>>>>>>>>>>>> mode
>>>>>>>>>>>>> +          where the output frequency is adjusted by the host
>>>>>>>>>>>>> via
>>>>>>>>>>>>> +          the PTP clock interface.
>>>>>>>>>>>>
>>>>>>>>>>>> Hi Ivan!
>>>>>>>>>>>>
>>>>>>>>>>>> How would you control this in case of automatic mode dpll?
>>>>>>>>>>>> Automatic mode DPLL shall be controlled on HW level, such pin
>>>>>>>>>>>> brakes that rule and requires some driver magic to show it is
>>>>>>>>>>>> higher priority then the rest of the pins?
>>>>>>>>>>>
>>>>>>>>>>> The NCO pin can be connected only in manual mode. In other words
>>>>>>>>>>> a
>>>>>>>>>>> DPLL in automatic mode cannot select NCO pin (switch to NCO 
>>>>>>>>>>> mode)
>>>>>>>>>>> by
>>>>>>>>>>> its own.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Being picky on DPLL_MODE for enabling feature is not something we
>>>>>>>>>> can allow if it is not related to HW limitation, is it?
>>>>>>>>>> Could you please elaborate why it is not possible for AUTOMATIC
>>>>>>>>>> mode?
>>>>>>>>>
>>>>>>>>> In automatic mode, the pin selection logic is defined upon prio. I
>>>>>>>>> can imagine that if NCO pin has the highest prio of the available
>>>>>>>>> ones, it gets picked. I would be aligned 100% with automatic mode
>>>>>>>>> behaviour.
>>>>>>>>> Is there a real usecase for it?
>>>>>>>>>
>>>>>>>>> [..]
>>>>>>>>
>>>>>>>> This is not true. AUTOMATIC mode is HW solution, SW driver ONLY
>>>>>>>> configures priorities on the inputs, not manages the active inputs.
>>>>>>>> This brakes that behavior, the SW driver would have to manually
>>>>>>>> override the AUTMATIC mode to be fed from such NCO pin as it 
>>>>>>>> doesn't
>>>>>>>> exists on it's priority list, HW cannot pick or use it.
>>>>>>>
>>>>>>> Correct, AUTO mode is hardware feature and it should not be emulated
>>>>>>> by a
>>>>>>> driver. If the hardware does not support it then the switching
>>>>>>> between
>>>>>>> input references should be done by userspace (by monitoring ffo,
>>>>>>> phase_offset, operstate).
>>>>>>>
>>>>>>
>>>>>> Yes, exactly, so for AUTOMATIC mode HW it will not be possible to
>>>>>> create
>>>>>> such pin, which means that NCO pin would serve only a MANUAL mode
>>>>>> implementation.
>>>>>> Basically this is something we shall not allow to happen. DPLL API
>>>>>> should be designed to cover the case where AUTO mode is able to
>>>>>> implement
>>>>>> all features consistently.
>>>>>
>>>>> If you don't like the proposal from Jiri (NCO switch driven by NCO pin
>>>>> priority -> highest==enter_nco else leave_nco) then it could be
>>>>> possible
>>>>> to handle the switching by allowing the state 'connected' in AUTO mode
>>>>> for the NCO pin type. Then the implementation will be the same for 
>>>>> both
>>>>> selection modes.
>>>>>
>>>>> Only difference would be that a user does not need to switch the 
>>>>> device
>>>> >from the AUTO to MANUAL mode.
>>>>>
>>>>>>>> The real use case is that any DPLL can switch the mode to this one
>>>>>>>> instead of implementing MANUAL mode just to use the feature with a
>>>>>>>> 'virtual' pin.
>>>>>>>
>>>>>>> I don't expect this... but it is up to a driver. I don't plan such
>>>>>>> functionality in zl3073x as the NCO pin does not expose prio_get()
>>>>>>> and
>>>>>>> prio_set() callbacks - so it is clear that this pin cannot be 
>>>>>>> part of
>>>>>>> the
>>>>>>> automatic selection.
>>>>>>>
>>>>>>> Ivan
>>>>>>
>>>>>> There is a difference between particular HW and API capabilities, 
>>>>>> with
>>>>>> the
>>>>>> proposed API we would disallow the possibility of such implementation
>>>>>> for
>>>>>> existing HW variants.
>>>>>>
>>>>>> DPLL NCO MODE would allow that but as pointed here by Ivan and by 
>>>>>> Jiri
>>>>>> in
>>>>>> the other email it would also require the extra implementation for
>>>>>> some
>>>>>> configuration - device level phase/ffo handling.
>>>>>>
>>>>>> To summarize it all, I don't have such simple solution for it.
>>>>>>
>>>>>> First thing that comes to my mind is to combine both approaches.
>>>>>> Make it possible for AUTMATIC mode to also set "CONNECTED" state
>>>>>> on certain kind of "OVERRIDE" pins, where it could be determined by
>>>>>> the type of PIN and embed that logic into the DPLL subsystem.
>>>>>
>>>>> The possible states for particual pins are now handled at a driver
>>>>> level
>>>>> so the driver decides if the requested state is correct or not. So it
>>>>> could be easy to implement this.
>>>>>
>>>>> For auto mode allowed states:
>>>>> - input references: selectable / disconnected
>>>>> - nco pin: connected / disconnected
>>>>>
>>>>>> Basically, if driver registers such NCO pin it would be always
>>>>>> selected
>>>>>> manually, and in such case all the other pins are going to
>>>>>> disconnected
>>>>>> state while DPLL mode is also a "OVERRIDE" or something like it.
>>>>>
>>>>> I would leave this decision on the driver level... Imagine the
>>>>> potential
>>>>> HW that would allow to switch NCO mode if there is no valid input
>>>>> reference.
>>>>>
>>>>> Example:
>>>>>
>>>>> REF0 (prio 0) -> +------+ -> OUT0
>>>>> REF1 (prio 1) -> | DPLL | -> ...
>>>>> NCO  (prio 2) -> +------+ -> OUTn
>>>>>
>>>>> Such HW would prefer REF0 or REF1 and lock to one of them if they are
>>>>> qualified. But if they are NOT, then it switches to NCO mode.
>>
>> Now you said yourself "NCO mode" ... I agree that it would be a mode in
>> that case. Where instead of running on regular/built in XO dpll would run
>> on NCO and user could select it, and this would be addition to regular
>> behavior.
>>
>> I also agree that the pin approach might be better/easier to use, 
>> assuming
>> frequency offset for all the outputs given dpll drives, it makes more 
>> sense
>> to have it configurable on input side.
> 
> +1
> 
>>>>>
>>>>> In this situation the relevant driver would allow to configure 
>>>>> priority
>>>>> and state 'selectable' for this NCO pin.
>>>>>
>>>>>> Perhaps the pin type could include OVERRIDE in it's name to make it
>>>>>> less
>>>>>> confusing and needs some extra documentation.
>>>>>>
>>>>>> Thoughts?
>>>>> I think _INT_ is ok. In the case of TYPE_INT_OSCILLATOR it is also
>>>>> obvious that it is not a standard input reference.
>>>>>
>>>>> Jiri, Vadim, Arek, thoughts?
>>>>
>>>> I agree with you, the driver should have the flexibility to implement
>>>> this according to his/hw's needs/capabilities. If it implements prio
>>>> selection in AUTO mode, let it have it. If it implements manual NCO pin
>>>> selection in AUTO mode using connected/disconnected override, let it
>>>> have it.
>>
>> I don't know 'current' HW that is capable of using AUTO mode as a part of
>> HW-based priority source selection and use such NCO input..
>> But as already explained above, this is special mode of regular XO, which
>> allows DPLL's output frequency offset configuration.
> 
> Lets keep this available for potential future HW. I can imagine a
> situation where a user will prefer an automatic switch to NCO mode
> if there is no qualified input reference - automatic switch means
> that HW will support this (not emulated by the driver).
> 
>>>>
>>>> Moreover, I actually like the "override" capability for pins in AUTO
>>>> mode in general. It may be handy for other usecases as well.
>>>>
>>> Arek? Vadim?
>>>
>>> Thanks,
>>> Ivan
>>
>> Agree, 'override' capability of a pin would be the way to go for this and
>> other similar further cases.
>>
>> I believe a single approach on this would be best, I mean if AUTO mode
>> needs a capability, to switch from regular behavior to 'OVERRIDE', and
>> 'OVERRIDE' is only pin capability that allows such behavior for AUTO
>> mode, then similar approach should be used on MANUAL mode, to make
>> userspace know that such pin is always available to set "CONNECTED"
>> and make the userspace implementation consistent on enabling it no matter
>> if AUTO or MANUAL mode dpll.
> 
> Proposal:
> 1) new pin capability
>     - name: state-connected-override
>     - doc: pin state can be changed to connected in any DPLL mode
> 
> 2) new NCO pin type to switch the DPLL to NCO mode when connected
> 
> 3) automatic-only DPLL
>     - should expose NCO pin with state-connected-override capability
> 
> 4) manual-only DPLL
>    - does not need to expose NCO pin with state-connected-override cap
> 
> 5) dual-mode DPLL (supporting mode switching)
>    - if it exposes NCO pin with the override cap then it has to support
>      switching to NCO mode directly from AUTO mode
>    - if does not expose NCO pin with the override cap then a user MUST
>      switch the DPLL mode from AUTO to MANUAL to be able to make NCO
>      pin connected to the DPLL

I still don't see good reasoning for the pin. Even this sentence says
"DPLL mode" which keeps me thinking whether we have to move it to a
special DPLL mode. All these items look like overcomplication of a
simple function of the device itself. DPLL can be either in the closed
loop when one of the pins provides a signal to align to, or in the open
loop meaning that software can control adjustments to phase/frequency.
But it's definitely a property of the device, and it's not a pin in any
kind...

> 
> Vadim, Jiri, Arek - thoughts?
> 
> Thanks,
> Ivan
> 


