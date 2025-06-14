Return-Path: <netdev+bounces-197756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0224AD9C46
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 12:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DA0189B1F0
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B8B24BD03;
	Sat, 14 Jun 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsSREzGo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA21247DF9
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749898564; cv=none; b=KFs67YGdzpFx0+nMBcdjZibsEOaH23OOw9F/zV4iVng9l7AqzC921SZ7SxRujCfZpYI6PziI55+9Wtwv8PDIWjJdr64b+UOn92TsvuSgoEt/jRFlU9AVWovbgocv9OoaiYP18fwu5TOBcS54lkw13djCv5Mr5XfHmdFBz0U+Raw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749898564; c=relaxed/simple;
	bh=v9JAZMbAlGj+PI2KBTAH+4c6GQ22Vu0QZw0EvB4pGcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqdofU6YJCoohE26BnFPs0bZo0TLzg74sPcPWcZEyYF7CSA9SNzv0+B7evrMJA+RynwjNCA1kFKqk/kvJhsz0IB7ihttMhsI5cZ6TNwC41XwJztPq1pkhQBdUCWt7dUgG3K9kXtO0ul6RlQNCoSQjCdRcYrwNOWa8kJKEbmQxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsSREzGo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749898561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3cUmQ0MyZkdcrlxR7yc+f3znrveTY8lEdfw/tNRmdE=;
	b=fsSREzGoYyCdfS9Rb/nHczoBb/GxJCE7TWPKxoqXc13uLdiLtcaKiuEW2qU9yfZAeLd/6U
	Uba6GbFwB/qmT+rNS9lcnqbPCGH83v6JuV2Aqhy1Y1VdOP8IhfLCRB1QiaoQeTtsAmSsQG
	+rXB4SOeDLfBz02Wt2H7v/OTI1549v8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-ypRNLI9eP0mJlHcLtYRiCA-1; Sat,
 14 Jun 2025 06:55:57 -0400
X-MC-Unique: ypRNLI9eP0mJlHcLtYRiCA-1
X-Mimecast-MFC-AGG-ID: ypRNLI9eP0mJlHcLtYRiCA_1749898555
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21A86195608B;
	Sat, 14 Jun 2025 10:55:54 +0000 (UTC)
Received: from [10.45.224.53] (unknown [10.45.224.53])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 247F81956094;
	Sat, 14 Jun 2025 10:55:45 +0000 (UTC)
Message-ID: <a129e92b-6f01-4345-979f-e57e1829e506@redhat.com>
Date: Sat, 14 Jun 2025 12:55:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 06/14] dpll: zl3073x: Fetch invariants during
 probe
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson <shannon.nelson@amd.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250612200145.774195-1-ivecera@redhat.com>
 <20250612200145.774195-7-ivecera@redhat.com>
 <c3400787-7279-4a50-a61a-92a100b3b4b9@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <c3400787-7279-4a50-a61a-92a100b3b4b9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On 13. 06. 25 9:13 odp., Vadim Fedorenko wrote:
>> +    synth->enabled = FIELD_GET(ZL_SYNTH_CTRL_EN, synth_ctrl);
>> +    synth->dpll = FIELD_GET(ZL_SYNTH_CTRL_DPLL_SEL, synth_ctrl);
>> +
>> +    dev_dbg(zldev->dev, "SYNTH%u is %s and driven by DPLL%u\n", index,
>> +        synth->enabled ? "enabled" : "disabled", synth->dpll);
>> +
>> +    guard(mutex)(&zldev->multiop_lock);
> 
> Not a strong suggestion, but it would be good to follow netdev style
> (same for some previous functions):

Hi Vadim,

I'm using guard() on places (functions) where it is necessary to hold
the lock from that place to the end of the function. Due to this
scoped_guard() does not give any advantage. Using classic mutex_lock()
and mutex_unlock() would only increases the risks of locking-related
bugs. Also manual locking enforces to use mutex_unlock() or goto in
all error paths after taking lock.

> https://docs.kernel.org/process/maintainer-netdev.html#using-device- 
> managed-and-cleanup-h-constructs
> 
> "Use of guard() is discouraged within any function longer than 20 lines,
> scoped_guard() is considered more readable. Using normal lock/unlock is 
> still (weakly) preferred."
> 
>> +
>> +    /* Read synth configuration */
>> +    rc = zl3073x_mb_op(zldev, ZL_REG_SYNTH_MB_SEM, ZL_SYNTH_MB_SEM_RD,
>> +               ZL_REG_SYNTH_MB_MASK, BIT(index));
>> +    if (rc)
>> +        return rc;
>> +
>> +    /* The output frequency is determined by the following formula:
>> +     * base * multiplier * numerator / denominator
>> +     *
>> +     * Read registers with these values
>> +     */
>> +    rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_BASE, &base);
>> +    if (rc)
>> +        return rc;
>> +
>> +    rc = zl3073x_read_u32(zldev, ZL_REG_SYNTH_FREQ_MULT, &mult);
>> +    if (rc)
>> +        return rc;
>> +
>> +    rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_M, &m);
>> +    if (rc)
>> +        return rc;
>> +
>> +    rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_N, &n);
>> +    if (rc)
>> +        return rc;
>> +

---> You have to keep the lock to here.

>> +    /* Check denominator for zero to avoid div by 0 */
>> +    if (!n) {
>> +        dev_err(zldev->dev,
>> +            "Zero divisor for SYNTH%u retrieved from device\n",
>> +            index);
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Compute and store synth frequency */
>> +    zldev->synth[index].freq = div_u64(mul_u32_u32(base * m, mult), n);
>> +
>> +    dev_dbg(zldev->dev, "SYNTH%u frequency: %u Hz\n", index,
>> +        zldev->synth[index].freq);
>> +
>> +    return rc;
>> +} 

This kind of function (above) is mailbox-read:
1. Take lock
2. Ask firmware to fill mailbox latch registers
3. Read latch1
4. ...
5. Unlock

But in later commits there are mailbox-write functions that:
1. Take lock
2. Ask firmware to fill mailbox latch registers
3. Write or read-update-write latch registers
4. ...
5. Ask firmware to update HW from the latch registers (commit)
6. Unlock

Step 5 here is usually represented by:

return zl3073x_mb_op(zldev, ZL_REG_*_MB_SEM, ZL_*_MB_SEM_RD,
                      ZL_REG_*_MB_MASK, BIT(index));

and here is an advantage of guard() that unlocks the mutex automatically
after zl3073x_mb_op() and prior returning its return value.

Thanks,
Ivan


