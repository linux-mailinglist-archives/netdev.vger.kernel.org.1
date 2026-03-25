Return-Path: <netdev+bounces-271637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KODJN2EMxGk+vgQAu9opvQ
	(envelope-from <netdev+bounces-271637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:25:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB22328F15
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14EF73015461
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903D3B6C0E;
	Wed, 25 Mar 2026 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P50ywjpS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7FA2874FA
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454668; cv=none; b=ZYHXH0wYLzpoSTa5mmPDMlLVtzvOk1NTu6iQxbPuHtPRaRbdaZKy/ZmMWusoxUMDBWPDjJTy40cBJ8eR20PxhJ2IP5+meJua0vcBvkoM66T0NU2EBlHTRGJkHLhYcQJeWLwN3JUDwc29C7wNKRPsYY5VA4rir0REU/f/QKMKtGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454668; c=relaxed/simple;
	bh=It2AI6F3YafYz9dpGZrSpJ6G8TBbDP8wXG7gFIH9xd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jodombtY6rAYd8Jtlsmv03wwOo1J59u+bLlA1PVW8B4FKO9tsOYBLE1c+GQmygz275rwRme5SfYUdFRCh7Ms0+oO5pr5OLZBuiQjPnxCkuPSI6JezqJrzbGhx1+sMof8MWBnCNt4grYtiFyZKXdU9bRjjKPBLueH62d7p6okcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P50ywjpS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774454666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hitlAwvXRhuCJkHzSod0gxliy1aWU9t/lo673gtXWhk=;
	b=P50ywjpScDJeE4SFwJubjxf/lGpTLhDUijPrLz5FSvlQkjcyncSvFKiKvQjjc32x316lJR
	/gT2GE4Xpj5FUGfY0lr5nWmdDHOvhZ2gWSkub/73zp169G3m9Fp0RM2gmC2BEfPDL3uYhh
	qxO1vJZVnx/MGlwfnqQKRv7/X4hZFvo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-oDyfpEOxONGv4oKfYgyt2Q-1; Wed,
 25 Mar 2026 12:04:24 -0400
X-MC-Unique: oDyfpEOxONGv4oKfYgyt2Q-1
X-Mimecast-MFC-AGG-ID: oDyfpEOxONGv4oKfYgyt2Q_1774454663
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26C4718002CF;
	Wed, 25 Mar 2026 16:04:22 +0000 (UTC)
Received: from [10.44.32.254] (unknown [10.44.32.254])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21E7B300019F;
	Wed, 25 Mar 2026 16:04:17 +0000 (UTC)
Message-ID: <66f8ab00-4058-489e-8a95-e6f8990f4732@redhat.com>
Date: Wed, 25 Mar 2026 17:04:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] dpll: zl3073x: add hwmon support for input
 reference frequencies
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
 Simon Horman <horms@kernel.org>, Guenter Roeck <linux@roeck-us.net>
References: <20260320105915.149068-1-ivecera@redhat.com>
 <20260320105915.149068-4-ivecera@redhat.com>
 <964752ec-8e6d-444a-aad0-80da3acb2dab@roeck-us.net>
 <7dbb5130-72cf-49d2-bfac-3439deb1b2e3@redhat.com>
 <20260323154825.1a2320c4@kernel.org>
 <50a1671c-9901-426a-97ed-bf36400fe9a7@roeck-us.net>
 <6f1e98b3-4b86-4b7f-8c91-d8d5721aeb25@redhat.com>
 <8486ce6e-ad2a-493d-b734-b40e8db9213e@redhat.com>
 <20260324143654.4dcec5a0@kernel.org>
 <9f169bf2-1d1f-4f7f-9f9f-0b90d06673e0@redhat.com>
 <2ea6547d-aa47-4333-b569-3a10a8fa9988@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <2ea6547d-aa47-4333-b569-3a10a8fa9988@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-271637-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BB22328F15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/25/26 4:56 PM, Vadim Fedorenko wrote:
> On 25/03/2026 11:19, Ivan Vecera wrote:
>>
>>
>> On 3/24/26 10:36 PM, Jakub Kicinski wrote:
>>> On Tue, 24 Mar 2026 13:59:19 +0100 Ivan Vecera wrote:
>>>>>> In the hardware monitoring world one would have min/max attributes 
>>>>>> and
>>>>>> one or more alarm attributes. I never heard about the idea of 
>>>>>> reporting
>>>>>> deviations, and for typical hardware monitoring attributes it does 
>>>>>> not
>>>>>> really make sense. What would be a "deviation" of a temperature/
>>>>>> voltage/current/power/humidity sensor ? Such attributes typically 
>>>>>> have
>>>>>> an operational range, and they are allowed and even expected to
>>>>>> fluctuate within that range.
>>>>>
>>>>> Ivan, my take on all the above is that using the HWmon interface 
>>>>> here is
>>>>> stretching it too much. I think it would be better to move debugfs
>>>>> and/or netlink events.
>>>>
>>>> I'd rather avoid debugfs... My proposal is to expose absolute measured
>>>> frequency attribute of dpll-pin and follow phase-offset-monitor
>>>> functionality:
>>>>
>>>> So:
>>>> * add real-frequency attribute to dpll pin
>>>> * add real-frequency-monitor attribute dpll device
>>>> * user will be able to enable/disable monitoring by enabling/disabling
>>>>     real-frequency-monitor feature (similarly to phase-offset-monitor)
>>>>
>>>> Thoughts?
>>>
>>> I don't have a strong opinion. IDK where to draw the line between DPLL
>>> and "random functionality some devices may have". We have 3 DPLL
>>> maintainers, let's see what their majority opinion is..
>>
>> I think that line has already been crossed by temperature reporting,
>> which has been there since the beginning. Actual frequency measurement
>> is, in my opinion, much closer to the DPLL world than temperature 
>> reporting. :-)
> 
> Frequency measurements are DPLL-world properties indeed. Temperature
> reporting was added as it has some influence on the stability of DPLL 
> devices as well as on any oscillators.
> 
>> Anyway, I have the relevant patch-set already prepared, so I can submit
>> it if you want to see it.
> Feel free to submit, I'll be happy to review it.
> 
Thanks, will do..

Ivan


