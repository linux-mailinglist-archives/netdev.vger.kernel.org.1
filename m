Return-Path: <netdev+bounces-181153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DF9A83E75
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95AF17EBA9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A421CC63;
	Thu, 10 Apr 2025 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCcDHHFd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B1021B9DA
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276719; cv=none; b=M9qySCePxXgUKRzyMRUmHVajLva4LPx6tl/Z2ZSNyYeDazystUGnXt6l1X96yihlwD4G1BoOA4fCUXfX5VXlZJl8XsLULyHkV+goAl9QG7JCGPXxG37WJkwbbwv3whchXiNMfL65Je/sU2C5sVVm4ylc+thyj1xBXdD72FlkVYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276719; c=relaxed/simple;
	bh=TPqJ1k8AAIrPY7q3JCPcpdlJDfzdRL5HJ7DL+ztbSTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfZ7mdbsSj0bX80JRzZzBQJJ6bKlKpumSWvI60pAObrbI+kv4k1OB/0ZJnu7wF+WdV6d9e7Or8kQ4u/CAH/qJnW0dzSRahEEK0XwTF8C/im5350RGNK3g+dat+2+KR8d+ch6Lj7PgoMmmyjKtjOguDRXfLJ9uIVeC3ku0tq1Akc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCcDHHFd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744276716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UaBBYYn9+Ny+SB7cdMeOGamaaptDicYH91ubkreRXjE=;
	b=SCcDHHFdp1OyPL9EPvqfKlViAutSAqR+3r4RFlGbQKP8XiZEouFplo0Wyk3Mzo7tRvfQZM
	+s97y86H8eIsfo1Y8yqYUC9N+tjMjzIjQLzjmVARjoGdXC470IwxQTYrof0s3o9t/an1n7
	v4CafGUAwdY/ksgQ2uGWU/u3ZLqwzNE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-0xZnWK54OPGpkNHlMA1m1g-1; Thu,
 10 Apr 2025 05:18:32 -0400
X-MC-Unique: 0xZnWK54OPGpkNHlMA1m1g-1
X-Mimecast-MFC-AGG-ID: 0xZnWK54OPGpkNHlMA1m1g_1744276710
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA6DB180025E;
	Thu, 10 Apr 2025 09:18:29 +0000 (UTC)
Received: from [10.44.33.222] (unknown [10.44.33.222])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3ABE119560AD;
	Thu, 10 Apr 2025 09:18:24 +0000 (UTC)
Message-ID: <889e68eb-d5b5-41ae-876d-9efc45416db6@redhat.com>
Date: Thu, 10 Apr 2025 11:18:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Add Microchip ZL3073x support (part 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409171713.6e9fb666@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250409171713.6e9fb666@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On 10. 04. 25 2:17 dop., Jakub Kicinski wrote:
> On Wed,  9 Apr 2025 16:42:36 +0200 Ivan Vecera wrote:
>> Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
>> provides DPLL and PTP functionality. This series bring first part
>> that adds the common MFD driver that provides an access to the bus
>> that can be either I2C or SPI.
>>
>> The next series will bring the DPLL driver that will covers DPLL
>> functionality. And another ones will bring PTP driver and flashing
>> capability via devlink.
>>
>> Testing was done by myself and by Prathosh Satish on Microchip EDS2
>> development board with ZL30732 DPLL chip connected over I2C bus.
> 
> The DPLL here is for timing, right? Not digital logic?
> After a brief glance I'm wondering why mfd, PHC + DPLL
> is a pretty common combo. Am I missing something?

Well, you are right, this is not pretty common combo right now. But how 
many DPLL implementations we have now in kernel?

There are 3 mlx5, ice and ptp_ocp. The first two are ethernet NIC 
drivers that re-expose (translate) DPLL API provided by their firmwares 
and the 3rd timecard that acts primarily as PTP clock.

Azurite is primarly the DPLL chip with multiple DPLL channels and one of 
its use-case is time synchronization or signal synchronization. Other 
one can be PTP clock and even GPIO controller where some of input or 
output pins can be configured not to receive or send periodic signal but 
can act is GPIO inputs or outputs (depends on wiring and usage).

So I have taken an approach to have common MFD driver that provides a 
synchronized access to device registers and to have another drivers for 
particular functionality in well bounded manner (DPLL sub-device (MFD 
cell) for each DPLL channel, PTP cell for channel that is configured to 
provide PTP clock and potentially GPIO controller cell but this is 
out-of-scope now).

Btw. I would be interesting to see a NIC that just exposes an access to 
I2C bus (implements I2C read/write by NIC firmware) instead of exposing 
complete DPLL API from the firmware. Just an idea.

Thanks,
Ivan


