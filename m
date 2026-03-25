Return-Path: <netdev+bounces-271498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJpjFDXIw2lKuAQAu9opvQ
	(envelope-from <netdev+bounces-271498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:34:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7220F323F78
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9914C30046B1
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67D63AB276;
	Wed, 25 Mar 2026 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOA4NVAc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452793043BE
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437583; cv=none; b=YyA58E+lt1ZML6aa8FflGc4DDr0AE5x+/OFFk3kLOMSKG+79ZXBWrlkz/sfoNyT5y+tS5iYvI4+4m5El+L0Vh/YJCQTVNf822NRo40UZjM3K6Hmp/ORa64pgidduGtIjiPY5ZrrAo0OAvH9tqEbnNvLIZun3T6etsXS6pN+fUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437583; c=relaxed/simple;
	bh=XW77TBg68HqucZSDZgf/eZQGswv9nbbrvZ+7GUTE8jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kurzY5yVar10td6MviM1Cn468ZdnIu1ILGJw3yH1vNb+gdGLD6ESesLVuVxR88ZCqSdAGZvGGv7ieUeBn0O8sW3wJ2JZO3EawyGS/pBaZPe43poDOWYbgkHpI+OA5YqxbL/qrKc8vbRCp5kLhpBpbMjrbkSvRK6SYAJF1DeCeMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOA4NVAc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774437581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcu7X20LtGJI1sr0/TMhyNj2XP5fyXzzK13F8Ax+u9g=;
	b=WOA4NVAcOd3QgbrBbuMaKdcm5vl4L38BqgwCsNN89kZzZbtEsu2bTtzwmQCv7x0+2DAfnO
	q0DyYvavVLYsk66kRWDBYV8pMmZsRNvvS+Y8XUrQSX1lHvjAMYN3wWxCCbe1oyWen4/kPE
	IWAmTZRIAzbRYBE+5qG0OKXgvYx536U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-IoCr3ecSPNSQlazJgLUWwg-1; Wed,
 25 Mar 2026 07:19:38 -0400
X-MC-Unique: IoCr3ecSPNSQlazJgLUWwg-1
X-Mimecast-MFC-AGG-ID: IoCr3ecSPNSQlazJgLUWwg_1774437576
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A028418002C9;
	Wed, 25 Mar 2026 11:19:35 +0000 (UTC)
Received: from [10.44.32.254] (unknown [10.44.32.254])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FAA31955D71;
	Wed, 25 Mar 2026 11:19:30 +0000 (UTC)
Message-ID: <9f169bf2-1d1f-4f7f-9f9f-0b90d06673e0@redhat.com>
Date: Wed, 25 Mar 2026 12:19:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] dpll: zl3073x: add hwmon support for input
 reference frequencies
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, Simon Horman <horms@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>
References: <20260320105915.149068-1-ivecera@redhat.com>
 <20260320105915.149068-4-ivecera@redhat.com>
 <964752ec-8e6d-444a-aad0-80da3acb2dab@roeck-us.net>
 <7dbb5130-72cf-49d2-bfac-3439deb1b2e3@redhat.com>
 <20260323154825.1a2320c4@kernel.org>
 <50a1671c-9901-426a-97ed-bf36400fe9a7@roeck-us.net>
 <6f1e98b3-4b86-4b7f-8c91-d8d5721aeb25@redhat.com>
 <8486ce6e-ad2a-493d-b734-b40e8db9213e@redhat.com>
 <20260324143654.4dcec5a0@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260324143654.4dcec5a0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-271498-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7220F323F78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/24/26 10:36 PM, Jakub Kicinski wrote:
> On Tue, 24 Mar 2026 13:59:19 +0100 Ivan Vecera wrote:
>>>> In the hardware monitoring world one would have min/max attributes and
>>>> one or more alarm attributes. I never heard about the idea of reporting
>>>> deviations, and for typical hardware monitoring attributes it does not
>>>> really make sense. What would be a "deviation" of a temperature/
>>>> voltage/current/power/humidity sensor ? Such attributes typically have
>>>> an operational range, and they are allowed and even expected to
>>>> fluctuate within that range.
>>>
>>> Ivan, my take on all the above is that using the HWmon interface here is
>>> stretching it too much. I think it would be better to move debugfs
>>> and/or netlink events.
>>
>> I'd rather avoid debugfs... My proposal is to expose absolute measured
>> frequency attribute of dpll-pin and follow phase-offset-monitor
>> functionality:
>>
>> So:
>> * add real-frequency attribute to dpll pin
>> * add real-frequency-monitor attribute dpll device
>> * user will be able to enable/disable monitoring by enabling/disabling
>>     real-frequency-monitor feature (similarly to phase-offset-monitor)
>>
>> Thoughts?
> 
> I don't have a strong opinion. IDK where to draw the line between DPLL
> and "random functionality some devices may have". We have 3 DPLL
> maintainers, let's see what their majority opinion is..

I think that line has already been crossed by temperature reporting,
which has been there since the beginning. Actual frequency measurement
is, in my opinion, much closer to the DPLL world than temperature 
reporting. :-)

Anyway, I have the relevant patch-set already prepared, so I can submit
it if you want to see it.

Thanks,
Ivan


