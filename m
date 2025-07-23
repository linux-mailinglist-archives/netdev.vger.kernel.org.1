Return-Path: <netdev+bounces-209224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D78B0EBD1
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5B6188C44D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 07:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F9627281B;
	Wed, 23 Jul 2025 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zopgn9CP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6A26CE2B
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255407; cv=none; b=clQYOfEgV+21trfq5McKsWEEbF6S+hyD1+qI8mne8+nZsxbmvSOk1vABXKoa5onbBSARC19WE009fxLwxwJ11h8aWnw685nTS1PhJwouQLh0313yBJoH0YQ2k2MXrpABIvZZCNzCpi9G/p600u6wbwLQrb0zZVhlyagf3nYyCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255407; c=relaxed/simple;
	bh=Xn0EJQAyZjyg/Fu77DpWIs4Rt8b0AhawHCeV6mW4ueE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otej7BrfIns5iMR9CnyXZoNy0fN/Nz5dEIYHojm4FiGmBhqM+RwL6GnFj1TwxFDSYy+wfyCzeQFyBaJM7m5wNu6jAY7OonOaPIGX6b9E6U4HShaed/K0ZSDigWAUkElR8BKbr/tnnlRnqc5oFR2wqjW3wAc8pEKOemVqUp/ID8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zopgn9CP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753255404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwuDDZvpn5btO7c6PwfvFLxjjWRhR+iaw+Yy2+oI+rA=;
	b=Zopgn9CP0QAgDyruwCkmixfewheCHUFom6akK310z+sOEGwnpo2WeEIB7Ki8CAPiEqJdbz
	KDEZdc99Gc67noe3M87pe1YqQ7YYFSJDkRp1BnGLIKozmmUA4U641TC1NnYZf0DXzLc56R
	Cs9I01rKH+31Uc+bIyFHpbrdfVu2GX4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-4C7JxSxLN1WUyoGpdzreuA-1; Wed,
 23 Jul 2025 03:23:21 -0400
X-MC-Unique: 4C7JxSxLN1WUyoGpdzreuA-1
X-Mimecast-MFC-AGG-ID: 4C7JxSxLN1WUyoGpdzreuA_1753255399
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 579441800365;
	Wed, 23 Jul 2025 07:23:18 +0000 (UTC)
Received: from [10.44.32.30] (unknown [10.44.32.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAD6218004AD;
	Wed, 23 Jul 2025 07:23:14 +0000 (UTC)
Message-ID: <466e293c-122f-4e11-97d2-6f2611a5178e@redhat.com>
Date: Wed, 23 Jul 2025 09:23:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: dpll: Add clock ID property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250717171100.2245998-1-ivecera@redhat.com>
 <20250717171100.2245998-2-ivecera@redhat.com>
 <5ff2bb3e-789e-4543-a951-e7f2c0cde80d@kernel.org>
 <6937b833-4f3b-46cc-84a6-d259c5dc842a@redhat.com>
 <20250721-lean-strong-sponge-7ab0be@kuoka>
 <804b4a5f-06bc-4943-8801-2582463c28ef@redhat.com>
 <9220f776-8c82-474b-93fc-ad6b84faf5cc@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <9220f776-8c82-474b-93fc-ad6b84faf5cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 23. 07. 25 8:25 dop., Krzysztof Kozlowski wrote:
> On 21/07/2025 14:54, Ivan Vecera wrote:
>> On 21. 07. 25 11:23 dop., Krzysztof Kozlowski wrote:
>>> On Fri, Jul 18, 2025 at 02:16:41PM +0200, Ivan Vecera wrote:
>>>> Hi Krzysztof,
>>>>
>>>> ...
>>>>
>>>> The clock-id property name may have been poorly chosen. This ID is used by
>>>> the DPLL subsystem during the registration of a DPLL channel, along with its
>>>> channel ID. A driver that provides DPLL functionality can compute this
>>>> clock-id from any unique chip information, such as a serial number.
>>>>
>>>> Currently, other drivers that implement DPLL functionality are network
>>>> drivers, and they generate the clock-id from one of their MAC addresses by
>>>> extending it to an EUI-64.
>>>>
>>>> A standalone DPLL device, like the zl3073x, could use a unique property such
>>>> as its serial number, but the zl3073x does not have one. This patch-set is
>>>> motivated by the need to support such devices by allowing the DPLL device ID
>>>> to be passed via the Device Tree (DT), which is similar to how NICs without
>>>> an assigned MAC address are handled.
>>>
>>> You use words like "unique" and MAC, thus I fail to see how one fixed
>>> string for all boards matches this. MACs are unique. Property value set
>>> in DTS for all devices is not.
>>>> You also need to explain who assigns this value (MACs are assigned) or
>>> if no one, then why you cannot use random? I also do not see how this
>>> property solves this...  One person would set it to value "1", other to
>>> "2" but third decide to reuse "1"? How do you solve it for all projects
>>> in the upstream?
>>
>> Some background: Any DPLL driver has to use a unique number during the
>> DPLL device/channel registration. The number must be unique for the
>> device across a clock domain (e.g., a single PTP network).
>>
>> NIC drivers that expose DPLL functionality usually use their MAC address
>> to generate such a unique ID. A standalone DPLL driver does not have
>> this option, as there are no NIC ports and therefore no MAC addresses.
>> Such a driver can use any other source for the ID (e.g., the chip's
>> serial number). Unfortunately, this is not the case for zl3073x-based
>> hardware, as its current firmware revisions do not expose information
>> that could be used to generate the clock ID (this may change in the
>> future).
>>
>> There is no authority that assigns clock ID value ranges similarly to
>> MAC addresses (OUIs, etc.), but as mentioned above, uniqueness is
>> required across a single PTP network so duplicates outside this
>> single network are not a problem.
> 
> You did not address main concern. You will configure the same value for
> all boards, so how do you solve uniqueness within PTP network?

This value differs across boards, similar to the local-mac-address. The
device tree specifies the entry, and the bootloader or system firmware
(like U-Boot) provides the actual value.

>> A randomly generated clock ID works, but the problem is that the value
>> is different after each reboot. Yes, there is an option to override the
>> clock ID using the devlink interface, but this also has to be done after
>> every reboot or power-up.
>>
>>> All this must be clearly explained when you add new, generic property.
>>
>> Would it be acceptable to define a hardware-specific property, since
>> only this hardware has this particular problem (the absence of a chip
>> unique attribute)? I'm referring to a property like 'microchip,id' or
>> 'microchip,dpll-id' defined in microchip,zl30731.yaml.
> 
> It does not change anything, no problems solved.
> 
> 
> Best regards,
> Krzysztof
> 


