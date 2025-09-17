Return-Path: <netdev+bounces-223998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C71D3B7D501
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96CD620AEB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3231D3233EF;
	Wed, 17 Sep 2025 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+i9x2GY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF83233EC
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111512; cv=none; b=lkPx51dggxoCd5aoSpfitDeRod/9VZ/l1CljOdSkDhO+WwfEhzLON4Sn6r+Rrd+d0E0MMlBBc+dabCKSe/p1Ven/WB0QH/w039c914WURx5FhwfnjOLzb0cc6GN6O5MuE9Ns0rmRSgQB1OKLGCSeX5Z37n30XPYAXZ1U5gtmlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111512; c=relaxed/simple;
	bh=Fu6VJL0MenpK/PD9UnrT8AK9a4ClFtuRJz79IysQBbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFBgUUzOj3fikNTkLj37rYtFFeH85VXgYzza4F4U2pX02BwPav/KP/aJSkMbino1+aZlKpx4PGSxHAV0USJwimNspTB1HRlobZOezAOoNI39Nc00p+o5asa5WVQJYefqiHh1m0/IRRLSd3ZFIuo6dkWpFNYeLM5BCdk5D5KBSMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+i9x2GY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758111509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHUsCtApx+pxExGjQp0qwPu/9kvqAUJMxOY2ilcMotc=;
	b=b+i9x2GYwzymS9ayjtrD7VIfMnc3CF3rhMxaNmg5ZU3IK3JXk7GrGZsNU5eTHQWUEVLEbb
	FyXy4cS1NhGSqysXzyCgmezpj0p4rKGMvfylKK8Mm/5PPigtfr6lcYpt79ac8Rs3FbGZsg
	fsXCNfUWef1umRdtOMCHpqFzYbUNXlo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-hsrNCk_4Nw-FpNyMYA7TAw-1; Wed,
 17 Sep 2025 08:18:25 -0400
X-MC-Unique: hsrNCk_4Nw-FpNyMYA7TAw-1
X-Mimecast-MFC-AGG-ID: hsrNCk_4Nw-FpNyMYA7TAw_1758111503
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBB5C1800378;
	Wed, 17 Sep 2025 12:18:22 +0000 (UTC)
Received: from [10.45.225.133] (unknown [10.45.225.133])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A1B6195608E;
	Wed, 17 Sep 2025 12:18:17 +0000 (UTC)
Message-ID: <c60779d6-938d-4adc-a264-2d78fb3c5947@redhat.com>
Date: Wed, 17 Sep 2025 14:18:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] dpll: zl3073x: Allow to use custom phase
 measure averaging factor
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250911072302.527024-1-ivecera@redhat.com>
 <20250915164641.0131f7ed@kernel.org>
 <SA1PR11MB844643902755174B7D7E9B3F9B17A@SA1PR11MB8446.namprd11.prod.outlook.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <SA1PR11MB844643902755174B7D7E9B3F9B17A@SA1PR11MB8446.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 17. 09. 25 1:26 odp., Kubalewski, Arkadiusz wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>> Sent: Tuesday, September 16, 2025 1:47 AM
>>
>> cc: Arkadiusz
>>
>> On Thu, 11 Sep 2025 09:23:01 +0200 Ivan Vecera wrote:
>>> The DPLL phase measurement block uses an exponential moving average,
>>> calculated using the following equation:
>>>
>>>                         2^N - 1                1
>>> curr_avg = prev_avg * --------- + new_val * -----
>>>                           2^N                 2^N
>>>
>>> Where curr_avg is phase offset reported by the firmware to the driver,
>>> prev_avg is previous averaged value and new_val is currently measured
>>> value for particular reference.
>>>
>>> New measurements are taken approximately 40 Hz or at the frequency of
>>> the reference (whichever is lower).
>>>
>>> The driver currently uses the averaging factor N=2 which prioritizes
>>> a fast response time to track dynamic changes in the phase. But for
>>> applications requiring a very stable and precise reading of the average
>>> phase offset, and where rapid changes are not expected, a higher factor
>>> would be appropriate.
>>>
>>> Add devlink device parameter phase_offset_avg_factor to allow a user
>>> set tune the averaging factor via devlink interface.
>>
>> Is averaging phase offset normal for DPLL devices?
>> If it is we should probably add this to the official API.
>> If it isn't we should probably default to smallest possible history?
>>
> 
> AFAIK, our phase offset measurement uses similar mechanics, but the algorithm
> is embedded in the DPLL device FW and currently not user controlled.
> Although it might happen that one day we would also provide such knob,
> if useful for users, no plans for it now.
>  From this perspective I would rather see it in dpll api, especially
> this relates to the phase measurement which is already there, the value
> being shared by multiple dpll devices seems HW related, but also seem not a
> problem, as long as a change would notify each device it relates with.

What if the averaging is implemented in different HW differently? As I
mentioned the Microchip HW uses exponential moving average but
a different HW can do it differently.

> Does frequency offset measurement for EEC DPLL would also use the same value?

Nope, this only affects phase offset measurement. AFAIK there is no such
tuning knob for FFO or frequency measurement in general...
Is it correct Prathosh?

Thanks,
Ivan


