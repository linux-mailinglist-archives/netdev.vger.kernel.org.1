Return-Path: <netdev+bounces-198160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC755ADB735
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D8A16A993
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AAE2877E4;
	Mon, 16 Jun 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiDccW4t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD2420FAA4
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092064; cv=none; b=NNt4OdRPt+llH2htsrsld7dXycPbrLB2eYJXxDtkPK1n5ECSVYVPIXPf4Q/7Utg60MLbNCRSmtegd51m8LVf0QqDAhF//JEmrHaeV7yuDE3LgPM4Tc1p/Fxe81HEA4aNAXqSYhp71FiVgACuK70+c/CQGd3KRNTcpFSpf+UwUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092064; c=relaxed/simple;
	bh=LwE/WuesUXIxV0abPIcpPADTky2PxZjAG+IcG/6YKSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g81FupDej4mdct284re7qcyvlcW6BYwK+tuXet6WSeKn27ZlJFAM3cDJg570hTemEF7rvCNfglSOhPLwg0ypumkkXDD4R5z4LYVx2DRCmpiGty+rn2t1XXxNyPmVRJv9O8jMfXJu414n/Sy78VklU+9WfpE3OfTYhuu5KonFURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IiDccW4t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750092062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8lQD9OdGrrnpQH1qsSN5fp1bQN4PsZfD/B5xZ27lys=;
	b=IiDccW4tOh4m6wAs6LL3boZwDkpsbcKOj3pG6kShnrtzl3lE5tHgVLBgS5UVA1s2Ww79w8
	kD7vW//z07RIrGdrRU8u07gMwqAwrCGwLWOVSsmR7p5Q8EQN/BQVGCpU4Lb+C4TFDja4dn
	U9Oul3E0NPhsF52lC1ewsN2jHZXg7ms=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-d1Zho7N8MJij7u1dH3uWBg-1; Mon,
 16 Jun 2025 12:40:56 -0400
X-MC-Unique: d1Zho7N8MJij7u1dH3uWBg-1
X-Mimecast-MFC-AGG-ID: d1Zho7N8MJij7u1dH3uWBg_1750092054
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F160719560B0;
	Mon, 16 Jun 2025 16:40:52 +0000 (UTC)
Received: from [10.45.224.53] (unknown [10.45.224.53])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE7F8195608F;
	Mon, 16 Jun 2025 16:40:45 +0000 (UTC)
Message-ID: <9a0443f1-e3c0-443d-9120-636be25e6794@redhat.com>
Date: Mon, 16 Jun 2025 18:40:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 09/14] dpll: zl3073x: Register DPLL devices
 and pins
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson <shannon.nelson@amd.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250615201223.1209235-1-ivecera@redhat.com>
 <20250615201223.1209235-10-ivecera@redhat.com>
 <20250616160047.GG6918@horms.kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250616160047.GG6918@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 16. 06. 25 6:00 odp., Simon Horman wrote:
> On Sun, Jun 15, 2025 at 10:12:18PM +0200, Ivan Vecera wrote:
>> Enumerate all available DPLL channels and registers a DPLL device for
>> each of them. Check all input references and outputs and register
>> DPLL pins for them.
>>
>> Number of registered DPLL pins depends on configuration of references
>> and outputs. If the reference or output is configured as differential
>> one then only one DPLL pin is registered. Both references and outputs
>> can be also disabled from firmware configuration and in this case
>> no DPLL pins are registered.
>>
>> All registrable references are registered to all available DPLL devices
>> with exception of DPLLs that are configured in NCO (numerically
>> controlled oscillator) mode. In this mode DPLL channel acts as PHC and
>> cannot be locked to any reference.
>>
>> Device outputs are connected to one of synthesizers and each synthesizer
>> is driven by some DPLL channel. So output pins belonging to given output
>> are registered to DPLL device that drives associated synthesizer.
>>
>> Finally add kworker task to monitor async changes on all DPLL channels
>> and input pins and to notify about them DPLL core. Output pins are not
>> monitored as their parameters are not changed asynchronously by the
>> device.
>>
>> Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>> Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> ...
> 
>> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> 
> ...
> 
>> +static int
>> +zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
>> +{
>> +	struct kthread_worker *kworker;
>> +	struct zl3073x_dpll *zldpll;
>> +	unsigned int i;
>> +	int rc;
>> +
>> +	INIT_LIST_HEAD(&zldev->dplls);
>> +
>> +	/* Initialize all DPLLs */
>> +	for (i = 0; i < num_dplls; i++) {
>> +		zldpll = zl3073x_dpll_alloc(zldev, i);
>> +		if (IS_ERR(zldpll)) {
>> +			dev_err_probe(zldev->dev, PTR_ERR(zldpll),
>> +				      "Failed to alloc DPLL%u\n", i);
> 
> Hi Ivan,
> 
> Jumping to the error label will return rc.
> But rc may not be initialised here.
> 
> Flagged by Smatch.

Hi Simon,
good catch... thanks.
Will fix this in v11 later today (after 24h).

Ivan

> 
>> +			goto error;
>> +		}
>> +
>> +		rc = zl3073x_dpll_register(zldpll);
>> +		if (rc) {
>> +			dev_err_probe(zldev->dev, rc,
>> +				      "Failed to register DPLL%u\n", i);
>> +			zl3073x_dpll_free(zldpll);
>> +			goto error;
>> +		}
>> +
>> +		list_add(&zldpll->list, &zldev->dplls);
>> +	}
>> +
>> +	/* Perform initial firmware fine phase correction */
>> +	rc = zl3073x_dpll_init_fine_phase_adjust(zldev);
>> +	if (rc) {
>> +		dev_err_probe(zldev->dev, rc,
>> +			      "Failed to init fine phase correction\n");
>> +		goto error;
>> +	}
>> +
>> +	/* Initialize monitoring thread */
>> +	kthread_init_delayed_work(&zldev->work, zl3073x_dev_periodic_work);
>> +	kworker = kthread_run_worker(0, "zl3073x-%s", dev_name(zldev->dev));
>> +	if (IS_ERR(kworker)) {
>> +		rc = PTR_ERR(kworker);
>> +		goto error;
>> +	}
>> +
>> +	zldev->kworker = kworker;
>> +	kthread_queue_delayed_work(zldev->kworker, &zldev->work, 0);
>> +
>> +	/* Add devres action to release DPLL related resources */
>> +	rc = devm_add_action_or_reset(zldev->dev, zl3073x_dev_dpll_fini, zldev);
>> +	if (rc)
>> +		goto error;
>> +
>> +	return 0;
>> +
>> +error:
>> +	zl3073x_dev_dpll_fini(zldev);
>> +
>> +	return rc;
>> +}
>> +
> 
> ...
> 


