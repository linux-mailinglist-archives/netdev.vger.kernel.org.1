Return-Path: <netdev+bounces-273904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PXzDVK4zGnMVwYAu9opvQ
	(envelope-from <netdev+bounces-273904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:16:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB34F3751B3
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28BF83037781
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 06:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE23732C923;
	Wed,  1 Apr 2026 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLDkjwlP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478928CF4A
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024206; cv=none; b=NOqf3F5GXN0JW7W1dhVe7Lv1M1bA30DpgsxieDAGOpLdWkiAtCxDfm/vtMz7nPjcVzRXIJgWnHZG+iX+taSpz8Wcd0JaDfUoCiHVDH9dmJrxfmkPkYJ7fE9f2tHVGtzvLTEvvoRjDq5sGcQ2XD3jZ7bwFqVfWtHL/AHETL+b+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024206; c=relaxed/simple;
	bh=+IO+GWB3m7JSfYZ1W6+fElUGIem2tndtrO+W2FP60gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biURi2LMXt1ChaYNehps7zoo3+6ANeYx6CsH5aLQx8I4SdrRpoJnugtLK3/K3t3f764Xkk4Fq8bd3nMz7nSkhWMcfCB8l/nPGwJ2pQhcDSfNATNsQTyFfVqnaD1l1BKx1FhRj92/F7Ln3KafFa9BDp10uP5ppyRGFBI4WXirQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLDkjwlP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775024203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EMxhr6NKZiRLAY+R8lkBaVG5o0DsE+kCNZTpv9LkBE=;
	b=JLDkjwlPiBIXzyFmSh16YcaYyi1XWHvvmULuNSz9IkzwmHjGzsu2v9d4n9ca/IAYjHKriC
	/17/sFMPxspdAdu6sSsUqnEGro6S89CWXhFwpUIlOqzEYOBQlnjsOzo42NPm1FjPAYPHSV
	yHDJcgJnMElrZJnR9GJQjipSrNPLJLk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-MlBoq-UrPAyPQMwezfJu4g-1; Wed,
 01 Apr 2026 02:16:37 -0400
X-MC-Unique: MlBoq-UrPAyPQMwezfJu4g-1
X-Mimecast-MFC-AGG-ID: MlBoq-UrPAyPQMwezfJu4g_1775024196
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43F5018005B8;
	Wed,  1 Apr 2026 06:16:35 +0000 (UTC)
Received: from [10.44.32.46] (unknown [10.44.32.46])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81B8D19560AB;
	Wed,  1 Apr 2026 06:16:30 +0000 (UTC)
Message-ID: <3ee5bbc9-fd0f-4abc-9b56-f53efc800221@redhat.com>
Date: Wed, 1 Apr 2026 08:16:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] dpll: add frequency monitoring to netlink
 spec
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260330105505.715099-1-ivecera@redhat.com>
 <20260330105505.715099-2-ivecera@redhat.com>
 <20260331200535.6a73e940@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260331200535.6a73e940@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273904-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,intel.com,resnulli.us,lwn.net,linuxfoundation.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,microchip.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB34F3751B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuba,

On 4/1/26 5:05 AM, Jakub Kicinski wrote:
> On Mon, 30 Mar 2026 12:55:03 +0200 Ivan Vecera wrote:
>> Add DPLL_A_FREQUENCY_MONITOR device attribute to allow control over
>> the frequency monitor feature. The attribute uses the existing
>> dpll_feature_state enum (enable/disable) and is present in both
>> device-get reply and device-set request.
>>
>> Add DPLL_A_PIN_MEASURED_FREQUENCY pin attribute to expose the measured
>> input frequency in Hz. The attribute is present in the pin-get reply.
> 
> 
>> +      -
>> +        name: frequency-monitor
>> +        type: u32
>> +        enum: feature-state
>> +        doc: Receive or request state of frequency monitor feature.
> 
> reads a bit clunkily - how about:
> 
> 	Current or desired state of the frequency monitor feature.
> 
> ?

Agreed, will update.

> 
>> +          If enabled, dpll device shall measure all currently available
>> +          inputs for their actual input frequency.
>>     -
>>       name: pin
>>       enum-name: dpll_a_pin
>> @@ -456,6 +463,13 @@ attribute-sets:
>>             Value is in PPT (parts per trillion, 10^-12).
>>             Note: This attribute provides higher resolution than the standard
>>             fractional-frequency-offset (which is in PPM).
>> +      -
>> +        name: measured-frequency
>> +        type: u64
>> +        doc: |
>> +          The measured frequency of the input pin in Hz.
>> +          This is the actual frequency being received on the pin,
>> +          as measured by the dpll device hardware.
> 
> If we make this a u64 should it be fixed point? Seems dubious that we'd
> ever be able to measure >4Ghz frequencies, much more likely that we'd
> want sub-1 precision ? So let's say this is fixed point 34.30 ?
> 
Good point. I'm going with a decimal divider (1000) instead of 34.30, 
following the same approach as DPLL_PHASE_OFFSET_DIVIDER. The value
is now in millihertz (mHz) with a DPLL_PIN_MEASURED_FREQUENCY_DIVIDER
constant for userspace to extract integer and fractional parts.

Thanks,
Ivan


