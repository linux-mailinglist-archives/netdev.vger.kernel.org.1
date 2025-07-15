Return-Path: <netdev+bounces-207162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F66B0614A
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25ABC585E1C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AF72517AA;
	Tue, 15 Jul 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heYyLxG1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1324DCE3
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589148; cv=none; b=Ypw3KnK1gFZ6wzWAkBP6/dJJqzdUs9a9fxzQp3zQwhjWPmFcy23p4p4aT19inyRcobDHbldBi4GukB9P4kcq24SGosmP9ezqgsycBIhacedScNbdB2zS4SewoTXdbBL/WG9XPlaFVuvNJKSMS30kzeaS8cir5tc+yjBOabnN/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589148; c=relaxed/simple;
	bh=m2p5MpSBXPyRVU5LktqZkzEk73hU5qjWjmUZo4QJ9S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhgTD81JYq17RjxCayuIJ37ixPC2F52w4sYpXnmJYXKN+86tkc260ZeS0ezS+bDUtzV8hUgvCJr0i8k69iPi3kT8tzsVxgpoQLmqkTA4rxMeY5mT/u+RNJQipMnbp0VUa91F5tvn5Hg6X42Rby1dRigmU1e84tDHOEFgRHnt8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heYyLxG1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752589146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fM1ATrFTUMHItot+j19m0V6zj980p2XBZrzeRcBmDGs=;
	b=heYyLxG1qH0Mx1g2vRxqyIv9re1efmGZwQS/ssBQipPDfUHK6jMuDDLm1GPOB1gyQEF/uz
	M4ZBZMfn/h0v+qL6rhXFPJGw8VK1JBoqULMFuMm1eT+9TArayk4cRaYZTGJf5vXZJ52ne5
	4c0WMg3PAvi34YqYLoWbBTENX75oSaY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-QUcjVcW5MZqW9gx0MtIRDw-1; Tue,
 15 Jul 2025 10:19:02 -0400
X-MC-Unique: QUcjVcW5MZqW9gx0MtIRDw-1
X-Mimecast-MFC-AGG-ID: QUcjVcW5MZqW9gx0MtIRDw_1752589140
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D1EC1800372;
	Tue, 15 Jul 2025 14:19:00 +0000 (UTC)
Received: from [10.45.225.30] (unknown [10.45.225.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E92EC1977029;
	Tue, 15 Jul 2025 14:18:56 +0000 (UTC)
Message-ID: <dba89108-0302-4773-af40-8026a5c12f5b@redhat.com>
Date: Tue, 15 Jul 2025 16:18:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] dpll: zl3073x: Implement phase offset
 monitor feature
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250710153848.928531-1-ivecera@redhat.com>
 <20250710153848.928531-4-ivecera@redhat.com>
 <e6801550-fb58-4a94-9405-b14e13c0e936@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <e6801550-fb58-4a94-9405-b14e13c0e936@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 15. 07. 25 3:02 odp., Paolo Abeni wrote:
> On 7/10/25 5:38 PM, Ivan Vecera wrote:
>> @@ -536,8 +539,38 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
>>   		return 0;
>>   	}
>>   
>> -	/* Report the latest measured phase offset for the connected ref */
>> -	*phase_offset = pin->phase_offset * DPLL_PHASE_OFFSET_DIVIDER;
>> +	ref_phase = pin->phase_offset;
>> +
>> +	/* The DPLL being locked to a higher freq than the current ref
>> +	 * the phase offset is modded to the period of the signal
>> +	 * the dpll is locked to.
>> +	 */
>> +	if (ZL3073X_DPLL_REF_IS_VALID(conn_ref) && conn_ref != ref) {
>> +		u32 conn_freq, ref_freq;
>> +
>> +		/* Get frequency of connected ref */
>> +		rc = zl3073x_dpll_input_ref_frequency_get(zldpll, conn_ref,
>> +							  &conn_freq);
>> +		if (rc)
>> +			return rc;
>> +
>> +		/* Get frequency of given ref */
>> +		rc = zl3073x_dpll_input_ref_frequency_get(zldpll, ref,
>> +							  &ref_freq);
>> +		if (rc)
>> +			return rc;
>> +
>> +		if (conn_freq > ref_freq) {
>> +			s64 conn_period;
>> +			int div_factor;
>> +
>> +			conn_period = div_s64(PSEC_PER_SEC, conn_freq);
>> +			div_factor = div64_s64(ref_phase, conn_period);
>> +			ref_phase -= conn_period * div_factor;
> 
> It's not obvious to me that the above div64_s64() will yield a 32b value
> for every possible arguments/configuration. Possibly a comment would
> help (or just use s64 for div_factor).

Practically it should not happen due to maximal reference frequency but
it will be safer use s64 here also for div_factor..

Will fix in v2.

Thanks,
Ivan


