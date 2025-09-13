Return-Path: <netdev+bounces-222786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A189FB56074
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 13:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525F61644FF
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AF72E8E0B;
	Sat, 13 Sep 2025 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXDPMtQE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19E1A0B15
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757761755; cv=none; b=fHZyaPotSytQqKiLw2NwUJ/3ew2zrnYaoXRihdLi2SI1q4HzvmvRn5ypVI+M8u1dDwS8DXavkBbt/8WZjoOG22nmwGBgo9QSLECAbhb028axnezKnJoSK7ZvRq94GKyEQmBYRo2aITsSAPTAwZoY6pRk25jPnVRWOw1tZpa62BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757761755; c=relaxed/simple;
	bh=X6lcWc9KVe36VtfHjKKWspbtw+Y7hlSjY7dQKGLg9A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qudXvcgiI/t3OvYd+vd5FChNg432YBvLjzI0UEViPfESSVF5E8jQ5E/vs2Mca8wnItx0YrigyUFP55rso7gznFBlQynEbfuiGoVZ0AHHAYdXo/cHH1EU3oXKbBjOHUXT1Xu4LNHLWE5jQAu0kVA3DDsdkHzlOoSkj8SjJ3FwEk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXDPMtQE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757761752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1kOs3Erdb9qfAALh69kcRAjtEQS3yPD4o2lsunznKM=;
	b=ZXDPMtQEABg+5NbwJt3t4114LxRIk/RWrC0Q+CgMIGdU3KPoXF2UAeavN5gbhqEBlYe3Mn
	9bhYbxlIr/WuKO5+QQu/PxCcdALYZzodU7co0NLMZlVhtxni4XvepVyLKPCqkTqLttAfFI
	Sb7UcwoNW4geNbIDWUwq82xaOUj8t0c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-k9aBWwj9OQ-tQDv0N_Ax-Q-1; Sat,
 13 Sep 2025 07:09:08 -0400
X-MC-Unique: k9aBWwj9OQ-tQDv0N_Ax-Q-1
X-Mimecast-MFC-AGG-ID: k9aBWwj9OQ-tQDv0N_Ax-Q_1757761747
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59252180045C;
	Sat, 13 Sep 2025 11:09:07 +0000 (UTC)
Received: from [10.45.224.175] (unknown [10.45.224.175])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 264F7300021A;
	Sat, 13 Sep 2025 11:09:04 +0000 (UTC)
Message-ID: <11fbd6f4-0cab-48cb-83e8-f62adc0ed493@redhat.com>
Date: Sat, 13 Sep 2025 13:09:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dpll: fix clock quality level reporting
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250912093331.862333-1-ivecera@redhat.com>
 <6c98a19e-473a-4935-a3aa-51c53618b2a9@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <6c98a19e-473a-4935-a3aa-51c53618b2a9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 12. 09. 25 9:37 odp., Vadim Fedorenko wrote:
> On 12.09.2025 10:33, Ivan Vecera wrote:
>> The DPLL_CLOCK_QUALITY_LEVEL_ITU_OPT1_EPRC is not reported via netlink
>> due to bug in dpll_msg_add_clock_quality_level(). The usage of
>> DPLL_CLOCK_QUALITY_LEVEL_MAX for both DECLARE_BITMAP() and
>> for_each_set_bit() is not correct because these macros requires bitmap
>> size and not the highest valid bit in the bitmap.
>>
>> Use correct bitmap size to fix this issue.
>>
>> Fixes: a1afb959add1 ("dpll: add clock quality level attribute and op")
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   drivers/dpll/dpll_netlink.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>> index 036f21cac0a9..0a852011653c 100644
>> --- a/drivers/dpll/dpll_netlink.c
>> +++ b/drivers/dpll/dpll_netlink.c
>> @@ -211,8 +211,8 @@ static int
>>   dpll_msg_add_clock_quality_level(struct sk_buff *msg, struct 
>> dpll_device *dpll,
>>                    struct netlink_ext_ack *extack)
>>   {
>> +    DECLARE_BITMAP(qls, DPLL_CLOCK_QUALITY_LEVEL_MAX + 1) = { 0 };
>>       const struct dpll_device_ops *ops = dpll_device_ops(dpll);
>> -    DECLARE_BITMAP(qls, DPLL_CLOCK_QUALITY_LEVEL_MAX) = { 0 };
> 
> I believe __DPLL_CLOCK_QUALITY_LEVEL_MAX should be used in both places

I don't think so. I consider __DPLL_CLOCK_QUALITY_LEVEL_MAX to be an
auxiliary value that should not be used directly.

But it would be possible to rename it to DPLL_CLOCK_QUALITY_LEVEL_COUNT
and use this.

Thoughts?

Ivan


