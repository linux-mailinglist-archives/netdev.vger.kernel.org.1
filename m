Return-Path: <netdev+bounces-208147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A25C2B0A3F5
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 14:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BC817475D
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F366C2D9794;
	Fri, 18 Jul 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGkyPTmp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C202010EE
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841017; cv=none; b=Wb75nojfa0RJ8ad3wgNKLFqzB33fPZVQad+cH/UDoQSM2sTBCToabcrooczVIQF65wRZofJ7o+uesFCB8z1/T27/wxKyQimJvltYyrptGKrXCMxHvmMhEQOla4giSeiWOByJCRkevpQJiDx0J8Af2D4YFCZRJXw3pLI98k3IJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841017; c=relaxed/simple;
	bh=ssCJnZiVU0NS5C2CWr681wCS6S2+9KNs1VykMx9TTKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F353ZBkOUcadstq0KC2jKxqs9WwfzXHXgqzDaJQvgQGdgs9HaVvtwGftTf+WuPSR3sKBENpaiFc33dxT/X8BJSzJl90txUnCY8BWd9293ZdP4dAR220/DVUpTyRoHSUyKDTWqAn/xC1fmdNhtBPcVJx0UQe8Ke/QV0shpFI+OIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGkyPTmp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752841015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StQAxm1RKG6Tk+bIyXR+UyKD+w6FfQFmbkQV3JFNsg4=;
	b=WGkyPTmpzMWMbvAnya99dmR4m14Y4rV7+4ZwpuweQIvM47Y+S2cUE2cz0ipw00EO+Ef+YV
	8xf95nleSdHaUbv0bktDTevt1N/n/MpvADSYqF7oNBdTfZvhA23P+ihiytdThMRdCaVDhg
	GWADNR1TF0fxl74yS/SxbeNCbyyNIPM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-mWhcBiItOvupwHuYwYGOrg-1; Fri,
 18 Jul 2025 08:16:49 -0400
X-MC-Unique: mWhcBiItOvupwHuYwYGOrg-1
X-Mimecast-MFC-AGG-ID: mWhcBiItOvupwHuYwYGOrg_1752841007
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F08CB19560A2;
	Fri, 18 Jul 2025 12:16:46 +0000 (UTC)
Received: from [10.44.33.77] (unknown [10.44.33.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFE33196664F;
	Fri, 18 Jul 2025 12:16:42 +0000 (UTC)
Message-ID: <6937b833-4f3b-46cc-84a6-d259c5dc842a@redhat.com>
Date: Fri, 18 Jul 2025 14:16:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: dpll: Add clock ID property
To: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250717171100.2245998-1-ivecera@redhat.com>
 <20250717171100.2245998-2-ivecera@redhat.com>
 <5ff2bb3e-789e-4543-a951-e7f2c0cde80d@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <5ff2bb3e-789e-4543-a951-e7f2c0cde80d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Krzysztof,

On 18. 07. 25 8:55 dop., Krzysztof Kozlowski wrote:
> On 17/07/2025 19:10, Ivan Vecera wrote:
>> Add property to specify the ID of the clock that the DPLL device
>> drives. The ID value represents Unique Clock Identified (EUI-64)
>> defined by IEEE 1588 standard.
> 
> With the exception of clock-output-names and gpio-hogs, we do not define
> how the output looks like in the provider bindings.
> 
> I also don't understand how this maps to channels and what "device
> drives a clock" means. Plus how this is not deducible from the compatible...

The clock-id property name may have been poorly chosen. This ID is used 
by the DPLL subsystem during the registration of a DPLL channel, along 
with its channel ID. A driver that provides DPLL functionality can 
compute this clock-id from any unique chip information, such as a serial 
number.

Currently, other drivers that implement DPLL functionality are network 
drivers, and they generate the clock-id from one of their MAC addresses 
by extending it to an EUI-64.

A standalone DPLL device, like the zl3073x, could use a unique property 
such as its serial number, but the zl3073x does not have one. This 
patch-set is motivated by the need to support such devices by allowing 
the DPLL device ID to be passed via the Device Tree (DT), which is 
similar to how NICs without an assigned MAC address are handled.

Suggestions:
1. Use the dpll-id property in dpll-device with the description:
    "Specifies the unique ID of the DPLL device if it is not retrievable
     from the hardware."
-or-
2. Use microchip,id or microchip,dpll-id with a similar description, as
    this issue is specific to this hardware, which does not provide such
    information.

Thanks for the advice.

Ivan


