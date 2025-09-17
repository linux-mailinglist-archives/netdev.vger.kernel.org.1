Return-Path: <netdev+bounces-224059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B64B8053E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC6C3A5D63
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4A332A2F;
	Wed, 17 Sep 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRR22urM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919D32E724
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120963; cv=none; b=tKm3wJMNoqUFcwtZokKhRKdCIAOGbFfW6iZu4TTMBnisGWRlsPwF97ZeIpNlhkTiZoLvtKKNPoSt5AyCMqKP3rsWHPIWTHL/miN09gXFHI2McUWm9jpX+x6NcHTPv2t1ktrSp+QAhx84LVTFh+TMYKI4q6lXUyrFvZ3msnkbelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120963; c=relaxed/simple;
	bh=UP76scATbO9HP2meL4acIXvgkNwIkTFTRgcCRmL7uC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSPDl5XQLylVxqVR1BvIOeQX/W7iOCPU9fe4jQKNi+BsZpybrdNh1Ng7BjdES3198njDYcvWNfNPJZAXk4f7tfWhoWFUB+Hom8MW3TXG9WfOpeR/OAf8NDPHikCtryXyFKxE8Kw+d1a2wjAbr/u5tR/7tm78vtYDLJDspGRR9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRR22urM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758120960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzA0JqEbh6Ep4K/N7TZ19/EGTrYogIbnJlv3097QrVg=;
	b=DRR22urMhqKiB9x/zKMxi4ZMDGCUrjej7rlgOSN/Eca9eNFSReJHqtbYyLW05+xvsYkLBY
	MRu8Uw8B4G4iBph7fXrgiH4yVAhzt/x/F0G0dvTAAtB9ad+zp0aMLL/+/wyMRGzgq6Vugx
	nu9prEtLC8z9s6ZVuZF+qb7pEgO9e4c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-rPE8zZhBOa6amsebACejWw-1; Wed,
 17 Sep 2025 10:55:55 -0400
X-MC-Unique: rPE8zZhBOa6amsebACejWw-1
X-Mimecast-MFC-AGG-ID: rPE8zZhBOa6amsebACejWw_1758120952
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFAD11956048;
	Wed, 17 Sep 2025 14:55:51 +0000 (UTC)
Received: from [10.45.225.133] (unknown [10.45.225.133])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A26D8300018D;
	Wed, 17 Sep 2025 14:55:47 +0000 (UTC)
Message-ID: <2ee83405-fd42-4a70-8a5f-f6f34b0b8731@redhat.com>
Date: Wed, 17 Sep 2025 16:55:46 +0200
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
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
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
 <c60779d6-938d-4adc-a264-2d78fb3c5947@redhat.com>
 <SJ2PR11MB845273963D6C04DCDB222FF19B17A@SJ2PR11MB8452.namprd11.prod.outlook.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <SJ2PR11MB845273963D6C04DCDB222FF19B17A@SJ2PR11MB8452.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 17. 09. 25 3:10 odp., Kubalewski, Arkadiusz wrote:
>> From: Ivan Vecera <ivecera@redhat.com>
>> Sent: Wednesday, September 17, 2025 2:18 PM
>>
>> On 17. 09. 25 1:26 odp., Kubalewski, Arkadiusz wrote:
>>>> From: Jakub Kicinski <kuba@kernel.org>
>>>> Sent: Tuesday, September 16, 2025 1:47 AM
>>>>
>>>> cc: Arkadiusz
>>>>
>>>> On Thu, 11 Sep 2025 09:23:01 +0200 Ivan Vecera wrote:
>>>>> The DPLL phase measurement block uses an exponential moving average,
>>>>> calculated using the following equation:
>>>>>
>>>>>                          2^N - 1                1
>>>>> curr_avg = prev_avg * --------- + new_val * -----
>>>>>                            2^N                 2^N
>>>>>
>>>>> Where curr_avg is phase offset reported by the firmware to the driver,
>>>>> prev_avg is previous averaged value and new_val is currently measured
>>>>> value for particular reference.
>>>>>
>>>>> New measurements are taken approximately 40 Hz or at the frequency of
>>>>> the reference (whichever is lower).
>>>>>
>>>>> The driver currently uses the averaging factor N=2 which prioritizes
>>>>> a fast response time to track dynamic changes in the phase. But for
>>>>> applications requiring a very stable and precise reading of the average
>>>>> phase offset, and where rapid changes are not expected, a higher factor
>>>>> would be appropriate.
>>>>>
>>>>> Add devlink device parameter phase_offset_avg_factor to allow a user
>>>>> set tune the averaging factor via devlink interface.
>>>>
>>>> Is averaging phase offset normal for DPLL devices?
>>>> If it is we should probably add this to the official API.
>>>> If it isn't we should probably default to smallest possible history?
>>>>
>>>
>>> AFAIK, our phase offset measurement uses similar mechanics, but the
>>> algorithm
>>> is embedded in the DPLL device FW and currently not user controlled.
>>> Although it might happen that one day we would also provide such knob,
>>> if useful for users, no plans for it now.
>>>   From this perspective I would rather see it in dpll api, especially
>>> this relates to the phase measurement which is already there, the value
>>> being shared by multiple dpll devices seems HW related, but also seem not
>>> a
>>> problem, as long as a change would notify each device it relates with.
>>
>> What if the averaging is implemented in different HW differently? As I
>> mentioned the Microchip HW uses exponential moving average but
>> a different HW can do it differently.
>>
> 
> Yeah good point, in that case we would also need enumerate those, and the new
> HW would have to extend the uAPI to let the user know which method is used?
> Different methods could require different parameters?
> But for your current case only one attribute would be enough?
> Or maybe better to provide those together like:
> DPLL_A_PHASE_MEASUREMENT_EMA_N
> Then different method would have own attributes/params?
> 
> Next question if a HW could have multiple of those methods available and
> controlled, in which case we shall also have in mind a plan for a
> "turned-off" value for further extensions?
> 
> Thank you!
> Arkadiusz

Jiri, Vadim,
any comments / opinions?

Thanks,
Ivan


