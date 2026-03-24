Return-Path: <netdev+bounces-271062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJYOCWSMwmlvewQAu9opvQ
	(envelope-from <netdev+bounces-271062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:06:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D87308E73
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAA7330E56E8
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BF43DCD90;
	Tue, 24 Mar 2026 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKwwQhzS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505853F7AAD
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357173; cv=none; b=MV8oHyO5WlCea9uBpGZlvoMe0tVJaKbqquG5FRJEbVcv41X3sAD0BzXg09UI4Zgf3OOaZNbzOaN3Hi+qM0lYAXnKZEYPNvN2aW5brPbw+PJqGrOf0xVY9L4ot2guEFYRLnEwL4iPQv4rdrEYbcfKO4agz/CyeVbr/9vwaDiAJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357173; c=relaxed/simple;
	bh=A9WppwW+5nYf74kSqIWyRbdH9mgFqE48/dceyoU2WEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8H7h2/qO5sDEI3n1yg6E5WGMI1Ni0VW1DHbuqJRfGq9B4fJ8RW4W5xRZFn1Chm6hB1XfDm1VVNGIc+eu0u6hNQMY4QN3QMO3jEwO1hnlglEAVkN5o1H3pkrnGpFB7NM6OgggUglSSTGHwQbmE6i3iEq/YplSBk1BH0lP4wC6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKwwQhzS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774357171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66aXgAm8lrLIlJwDHDhuJeRhflv8crX+JxuXz8zsArI=;
	b=MKwwQhzSC+v5eIbsnGP/vx9th/GHhlV5uLcXy8hiTwXxqvgr+0z0Udu4wBxTNWR4pcg1aX
	9F35lrXd9cf2mzuiUGPp+FXaLzGvbKceE1jv6Fdgn/yCAwEeVM/HWoCtEQbcnqXfA6VeuM
	YTMsogiHj8KfWqECLYJinRjyxp5p18Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-qVQpQO9YOSi99nlh1Us6Fg-1; Tue,
 24 Mar 2026 08:59:25 -0400
X-MC-Unique: qVQpQO9YOSi99nlh1Us6Fg-1
X-Mimecast-MFC-AGG-ID: qVQpQO9YOSi99nlh1Us6Fg_1774357164
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAA6A1956096;
	Tue, 24 Mar 2026 12:59:23 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B9B419560AB;
	Tue, 24 Mar 2026 12:59:20 +0000 (UTC)
Message-ID: <8486ce6e-ad2a-493d-b734-b40e8db9213e@redhat.com>
Date: Tue, 24 Mar 2026 13:59:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] dpll: zl3073x: add hwmon support for input
 reference frequencies
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, Simon Horman <horms@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Jakub Kicinski <kuba@kernel.org>
References: <20260320105915.149068-1-ivecera@redhat.com>
 <20260320105915.149068-4-ivecera@redhat.com>
 <964752ec-8e6d-444a-aad0-80da3acb2dab@roeck-us.net>
 <7dbb5130-72cf-49d2-bfac-3439deb1b2e3@redhat.com>
 <20260323154825.1a2320c4@kernel.org>
 <50a1671c-9901-426a-97ed-bf36400fe9a7@roeck-us.net>
 <6f1e98b3-4b86-4b7f-8c91-d8d5721aeb25@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <6f1e98b3-4b86-4b7f-8c91-d8d5721aeb25@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-271062-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4D87308E73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo,

On 3/24/26 11:49 AM, Paolo Abeni wrote:
> On 3/24/26 6:16 AM, Guenter Roeck wrote:
>> On 3/23/26 15:48, Jakub Kicinski wrote:
>>> On Fri, 20 Mar 2026 14:48:01 +0100 Ivan Vecera wrote:
>>>> On 3/20/26 1:21 PM, Guenter Roeck wrote:
>>>>> On 3/20/26 03:59, Ivan Vecera wrote:
>>>>>> Expose measured input reference frequencies via the hwmon interface
>>>>>> using custom sysfs attributes (freqN_input and freqN_label) since
>>>>>> hwmon has no native frequency sensor type. The frequency values are
>>>>>> read from the cached measurements updated by the periodic work thread.
>>>>>>
>>>>>> Cache the device ready state in struct zl3073x_dev so that
>>>>>> freq_input_show() can return -ENODATA without an I2C access when
>>>>>> the device firmware is not configured.
>>>>>>
>>>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>>>
>>>>> "frequency" is not a hardware monitoring attribute. I understand that it is
>>>>> convenient to report it as one, and that other drivers implement it as
>>>>> well,
>>>>> but that doesn't change that.
>>>>>
>>>>> I understand that the code lives outside the hardware monitoring
>>>>> subsystem and is
>>>>> thus not in control of its maintainers, so you can essentially do
>>>>> whatever you want,
>>>>> even if it is wrong. That doesn't change the fact that it is wrong.
>>>>>
>>>>> However, do _not_ try to add it into the official list of hardware
>>>>> monitoring
>>>>> attributes. I would NACK that.
>>>>
>>>> Understood. I recognize that frequency falls outside the strict scope of
>>>> hardware monitoring and does not belong in the official hwmon ABI.
>>>>
>>>> I'm using it here as a convenient way to expose these specific driver
>>>> metrics, but I hear you loud and clear. I will absolutely not propose
>>>> adding frequency to the official list of hwmon attributes or
>>>> documentation.
>>>>
>>>> Thank you for your time and for reviewing the patch.
>>>
>>> Guenter, should this be a debugfs interface, then?
>>>
>>
>> There is nothing that prevents the actual (generated ?) frequency to
>> be reported as sysfs attribute attached to the chip (spi) driver, if
>> it is indeed of interest. If it is of interest for all dpll drivers,
>> it could be attached to the dpll device, the chip driver could make it
>> available via dpll_device_ops to the dpll subsystem, and the dpll
>> subsystem could provide a common API function (such as the existing
>> temp_get) and generate a common set of sysfs attributes for all dpll
>> devices.
>>
>>> Also an hwmon noob question - isn't it better for the monitoring
>>> interface to report frequency error / instability in this case
>>> instead of absolute value? Or do you not know the expected freq?
>>>
>> In the hardware monitoring world one would have min/max attributes and
>> one or more alarm attributes. I never heard about the idea of reporting
>> deviations, and for typical hardware monitoring attributes it does not
>> really make sense. What would be a "deviation" of a temperature/
>> voltage/current/power/humidity sensor ? Such attributes typically have
>> an operational range, and they are allowed and even expected to
>> fluctuate within that range.
> 
> Ivan, my take on all the above is that using the HWmon interface here is
> stretching it too much. I think it would be better to move debugfs
> and/or netlink events.

I'd rather avoid debugfs... My proposal is to expose absolute measured
frequency attribute of dpll-pin and follow phase-offset-monitor
functionality:

So:
* add real-frequency attribute to dpll pin
* add real-frequency-monitor attribute dpll device
* user will be able to enable/disable monitoring by enabling/disabling
   real-frequency-monitor feature (similarly to phase-offset-monitor)

Thoughts?

Thanks,
Ivan


