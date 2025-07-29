Return-Path: <netdev+bounces-210827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B97B15017
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375E13A3AF3
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208C292B38;
	Tue, 29 Jul 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmlKKCVs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC923292B2E
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802424; cv=none; b=GwGNhuZ+YuoCmFC+bdOL0AL5bSJn5ujj+2dAWEg3mxgCZMunOiJEmi+stuYu8xlqp9uGjRd3QGFCdjNHYVZ7qFvQ5eYKFaX2dacOW1Sa6qw5qAeVprBQSHr6RyWDaqamz8BZ2NKMgAhsfyvYJigr86Ccf7AL7wDZxYLjDtma3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802424; c=relaxed/simple;
	bh=WvGZqKnX9XxPdLw/AbNtfIFikRg12kKOYJZxboaUNJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ewu6x+DU1J2ghMDMV7N/kk9gSVaRN2T9ljCG0BgJvYXS+qanQ9aoib6w0d1bRLiWOverEFcIcsnzuDVHHhB6+nefDRvNmQWWfm8qhJ7imCOqo6xLZuBUhHuwMmpn1zY6eFRW5m2Wk3s+8mS2NgYCsRoRqh2yDiTfmHbHgRHbOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmlKKCVs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753802421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FO/1vKVqO9RBP4Rk0YFJ1qonOTPK/AJG6R01vpmqPYY=;
	b=XmlKKCVsX2UUz7B6QcP732TX+Ikcoh7yNU9lj1t8xLyGgH9lE3rRhUbddUgnZBBJ5HMvlw
	oEE9q7fLyYGsMkU2j9U23HOWygNEjd0KGWPzF4lZWF/2jZwndOwKQP0si2UoxhObzL63GS
	gPUfpq33NQwPW2SMzDLp5z8awmnVSuI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-4uMyyuLxOOqg1ELrBMf1Hw-1; Tue,
 29 Jul 2025 11:20:18 -0400
X-MC-Unique: 4uMyyuLxOOqg1ELrBMf1Hw-1
X-Mimecast-MFC-AGG-ID: 4uMyyuLxOOqg1ELrBMf1Hw_1753802416
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 996D21956094;
	Tue, 29 Jul 2025 15:20:15 +0000 (UTC)
Received: from [10.45.225.137] (unknown [10.45.225.137])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46A6C18003FC;
	Tue, 29 Jul 2025 15:20:11 +0000 (UTC)
Message-ID: <5f2aaa88-d3fb-46ae-b325-603fda5e8851@redhat.com>
Date: Tue, 29 Jul 2025 17:20:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] dpll: zl3073x: Add firmware loading
 functionality
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>
References: <20250725154136.1008132-1-ivecera@redhat.com>
 <20250725154136.1008132-4-ivecera@redhat.com>
 <20250726203351.GP1367887@horms.kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250726203351.GP1367887@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 26. 07. 25 10:33 odp., Simon Horman wrote:
> On Fri, Jul 25, 2025 at 05:41:34PM +0200, Ivan Vecera wrote:
>> Add functionality for loading firmware files provided by the vendor
>> to be flashed into the device's internal flash memory. The firmware
>> consists of several components, such as the firmware executable itself,
>> chip-specific customizations, and configuration files.
>>
>> The firmware file contains at least a flash utility, which is executed
>> on the device side, and one or more flashable components. Each component
>> has its own specific properties, such as the address where it should be
>> loaded during flashing, one or more destination flash pages, and
>> the flashing method that should be used.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> Hi Ivan,
> 
> Some minor feedback from my side.
> 
> ...
> 
>> diff --git a/drivers/dpll/zl3073x/fw.c b/drivers/dpll/zl3073x/fw.c
> 
> ...

Hi Simon,

> 
>> +/* Santity check */
> 
> Sanity

Will fix in v2.

>> +static_assert(ARRAY_SIZE(component_info) == ZL_FW_NUM_COMPONENTS);
> 
> ...
> 
>> +int zl3073x_fw_flash(struct zl3073x_dev *zldev, struct zl3073x_fw *zlfw,
>> +		     struct netlink_ext_ack *extack)
>> +{
>> +	int i, rc;
>> +
>> +	for (i = 0; i < ZL_FW_NUM_COMPONENTS; i++) {
>> +		if (!zlfw->component[i])
>> +			continue; /* Component is not present */
>> +
>> +		rc = zl3073x_fw_component_flash(zldev, zlfw->component[i],
>> +						extack);
>> +		if (rc)
>> +			break;
>> +	}
> 
> Perhaps it cannot happen in practice.
> But Smatch warns that rc may be used uninitialised below.
> And that does seem theoretically possible if all
> iterations of the loop above hit the "continue" path.

Yes, it should not happen as at least one component has to be present
but for sure I will init rc in the next iteration.

Thanks for review,
Ivan

> 
>> +
>> +	return rc;
>> +}
> 
> ...
> 


