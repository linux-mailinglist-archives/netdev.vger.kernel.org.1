Return-Path: <netdev+bounces-238104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3522BC54219
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 917D3349AB9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0C634F461;
	Wed, 12 Nov 2025 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ak/O6kmU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6334D913
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975466; cv=none; b=ZUw39wBvhsmc4V0XnQkVljdTpRkic7N3hE5qQ3WaE92iWU7ntRg59UHCHS7bcErKWZm0QWJw2fdBLyvt6NKIM8W65EcWsl/fRKiN5jxY3TQbjgtF0uVd+30cVZNhKJ2TiRyQ3U6Uejr61Atp+GpwgEGHrZ7Fumj6SimRPPEwq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975466; c=relaxed/simple;
	bh=VWlJVlua6iS1JCewUB1BVWxoLPN5wEEPRegrFQ2V3zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JG5GD+mQO8EJcClHPO2izP5HyeZlW1RU36mjsrVclrshgm4RpRsKN2B4bvUWg+idina316XoAxYNJQDmI8rmeVTaViwPWnt1r6I+pfi0ZW8OyQ5iCNK8idJGiRKBIa9vOSpbeDpndX+L45z3aMInqv0E3ceR1PX7CrGI/rHk7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ak/O6kmU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762975463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2VxMPfPM1mRBBE94HE3R7FECDA19LXKHeo3VGwgz2c=;
	b=ak/O6kmUl0ORtzaw+OCSGKfcPAT6gJ6NE52W4r0RWzDaAnraIHcAD2TZXE4+8Hoa3PMZKk
	olkOh3IIveUabEWXQWCBjBA3kDEbUqGriKI4/PJWRJtL1EeDpWNcr89G3IaOYA3g/tfdcd
	rBgxEG0FU9ttdZCAsJR/sGVRzqpJASk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-1KmoTz2oORq_7iFYQiQcbA-1; Wed,
 12 Nov 2025 14:24:19 -0500
X-MC-Unique: 1KmoTz2oORq_7iFYQiQcbA-1
X-Mimecast-MFC-AGG-ID: 1KmoTz2oORq_7iFYQiQcbA_1762975458
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9BA718001D1;
	Wed, 12 Nov 2025 19:24:17 +0000 (UTC)
Received: from [10.44.32.66] (unknown [10.44.32.66])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65F1030044E9;
	Wed, 12 Nov 2025 19:24:15 +0000 (UTC)
Message-ID: <45a93065-eaaa-4b18-90e0-e1d9cceb91b4@redhat.com>
Date: Wed, 12 Nov 2025 20:24:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/6] dpll: zl3073x: Store raw register values
 instead of parsed state
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20251111181243.4570-1-ivecera@redhat.com>
 <20251111181243.4570-2-ivecera@redhat.com>
 <886723c3-ff9e-43cf-a1da-021f1ff088ab@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <886723c3-ff9e-43cf-a1da-021f1ff088ab@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/12/25 3:12 PM, Vadim Fedorenko wrote:
> On 11/11/2025 18:12, Ivan Vecera wrote:
>> The zl3073x_ref, zl3073x_out and zl3073x_synth structures
>> previously stored state that was parsed from register reads. This
>> included values like boolean 'enabled' flags, synthesizer selections,
>> and pre-calculated frequencies.
>>
>> This commit refactors the state management to store the raw register
>> values directly in these structures. The various inline helper functions
>> are updated to parse these raw values on-demand using FIELD_GET.
>>
>> Reviewed-by: Petr Oros <poros@redhat.com>
>> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   drivers/dpll/zl3073x/core.c | 81 ++++++++++++-------------------------
>>   drivers/dpll/zl3073x/core.h | 61 ++++++++++++++++------------
>>   2 files changed, 60 insertions(+), 82 deletions(-)
>>
>> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
>> index e42e527813cf8..50c1fe59bc7f0 100644
>> --- a/drivers/dpll/zl3073x/core.c
>> +++ b/drivers/dpll/zl3073x/core.c
>> @@ -598,25 +598,22 @@ int zl3073x_write_hwreg_seq(struct zl3073x_dev 
>> *zldev,
>>    * @zldev: pointer to zl3073x_dev structure
>>    * @index: input reference index to fetch state for
>>    *
>> - * Function fetches information for the given input reference that are
>> - * invariant and stores them for later use.
>> + * Function fetches state for the given input reference and stores it 
>> for
>> + * later user.
>>    *
>>    * Return: 0 on success, <0 on error
>>    */
>>   static int
>>   zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
>>   {
>> -    struct zl3073x_ref *input = &zldev->ref[index];
>> -    u8 ref_config;
>> +    struct zl3073x_ref *ref = &zldev->ref[index];
>>       int rc;
>>       /* If the input is differential then the configuration for N-pin
>>        * reference is ignored and P-pin config is used for both.
>>        */
>> -    if (zl3073x_is_n_pin(index) &&
>> -        zl3073x_ref_is_diff(zldev, index - 1)) {
>> -        input->enabled = zl3073x_ref_is_enabled(zldev, index - 1);
>> -        input->diff = true;
>> +    if (zl3073x_is_n_pin(index) && zl3073x_ref_is_diff(zldev, index - 
>> 1)) {
>> +        memcpy(ref, &zldev->ref[index - 1], sizeof(*ref));
> 
> Oh, it's not obvious from the code that it's actually safe, unless
> reviewer remembers that N-pins have only even indexes.

Would it be helpful to add here the comment describing that is safe and
why?

> Have you thought of adding an abstraction for differential pair pins?

No, zl3073x_ref represents mailbox for HW reference... Here, I’m just
following the datasheet, which states: "If the P-pin is marked as
differential then some content of the mailbox for N-pin is ignored and
is inherited from the P-pin".
For now, the content of zl3073x_ref is the inherited one, but this may
change in the future.

The abstraction for differential pin pairs is actually handled in
dpll.c, where only a single dpll_pin is registered for each such pair.

Ivan


