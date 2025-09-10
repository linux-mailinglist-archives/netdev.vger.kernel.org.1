Return-Path: <netdev+bounces-221800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67704B51E48
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039A4445939
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2D727602F;
	Wed, 10 Sep 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6Juxuny"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61475272814
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523069; cv=none; b=CpFR8WlajTwxTshqJ86b9cgQV1kY99tNevFaOckRAtm+u7BZk3AMd22oIu2JWiSHYbkH3Ug57DKNmDP6PBBIOLxLAq3QXXJQubN2NR3U4iCqIxQ42vNTNLs6AXoPB2JroZLvXpYTBKQuEjUuWx5Gu6sTkKOtnP5V7r804Qm+Gxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523069; c=relaxed/simple;
	bh=h3/FAOSRRVmznFBcQ4npGgTTtGHAFrZyox46Q/dAY2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KN5kLpbiLKtRmB++4/RMFGLhTiZXDEbixE8M4+Q2NO4p3jDXzuLpknS6ooaZG9bYFzbvR5URHD1fDQQV7Lcqk7jqhu37kv6NY48mEEiamEWi1NY9VuE9rKzQ0bjTsxCKFKUpTEU4EltKW+zIIwOSabqHCI9ByGQl1tDhTH924Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6Juxuny; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757523066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQKT4ZzpNa/yKWGTVArTDPi3S7egIlUSjK6QBqA8Noc=;
	b=M6JuxunyGwdfJNF/E2dHAQo7KsF6Fya4DP5Te/ktFYWOx9yqc+3tgOv5yq5zrP9Qo/q6jm
	xRphB8sDo/yWcP+xzf10WsRLTqazyBr3LSt789wH5cfO4JEWocr8IvcJeZuD0adDMA2Cou
	tRJQacTLJVUhVblVn8mUC+zD34RpbzM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-tD-GeKuiO0mEr3n384YwTQ-1; Wed,
 10 Sep 2025 12:51:02 -0400
X-MC-Unique: tD-GeKuiO0mEr3n384YwTQ-1
X-Mimecast-MFC-AGG-ID: tD-GeKuiO0mEr3n384YwTQ_1757523059
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F5C5180048E;
	Wed, 10 Sep 2025 16:50:59 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4DC7B180035E;
	Wed, 10 Sep 2025 16:50:53 +0000 (UTC)
Message-ID: <0817610a-e3dd-427e-b0ad-c2d503bb8a4f@redhat.com>
Date: Wed, 10 Sep 2025 18:50:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dpll: zl3073x: Allow to use custom phase measure
 averaging factor
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250910103221.347108-1-ivecera@redhat.com>
 <acfc8c63-4434-4738-84a9-00360e70c773@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <acfc8c63-4434-4738-84a9-00360e70c773@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10. 09. 25 6:13 odp., Andrew Lunn wrote:
> On Wed, Sep 10, 2025 at 12:32:21PM +0200, Ivan Vecera wrote:
>> The DPLL phase measurement block uses an exponential moving average,
>> calculated using the following equation:
>>
>>                         2^N - 1                1
>> curr_avg = prev_avg * --------- + new_val * -----
>>                           2^N                 2^N
>>
>> Where curr_avg is phase offset reported by the firmware to the driver,
>> prev_avg is previous averaged value and new_val is currently measured
>> value for particular reference.
>>
>> New measurements are taken approximately 40 Hz or at the frequency of
>> the reference (whichever is lower).
>>
>> The driver currently uses the averaging factor N=2 which prioritizes
>> a fast response time to track dynamic changes in the phase. But for
>> applications requiring a very stable and precise reading of the average
>> phase offset, and where rapid changes are not expected, a higher factor
>> would be appropriate.
>>
>> Add devlink device parameter phase_offset_avg_factor to allow a user
>> set tune the averaging factor via devlink interface.
>>
>> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>   Documentation/networking/devlink/zl3073x.rst |  4 ++
>>   drivers/dpll/zl3073x/core.c                  |  6 +-
>>   drivers/dpll/zl3073x/core.h                  |  8 ++-
>>   drivers/dpll/zl3073x/devlink.c               | 67 ++++++++++++++++++++
>>   4 files changed, 82 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/networking/devlink/zl3073x.rst b/Documentation/networking/devlink/zl3073x.rst
>> index 4b6cfaf386433..ddd159e39e616 100644
>> --- a/Documentation/networking/devlink/zl3073x.rst
>> +++ b/Documentation/networking/devlink/zl3073x.rst
>> @@ -20,6 +20,10 @@ Parameters
>>        - driverinit
>>        - Set the clock ID that is used by the driver for registering DPLL devices
>>          and pins.
>> +   * - ``phase_offset_avg_factor``
>> +     - runtime
>> +     - Set the factor for the exponential moving average used by DPLL phase
>> +       measurement block. The value has to be in range <0, 15>.
> 
> Maybe put the text in the commit message here as well?

Do you mean to put the equation and details from commit message here?
This is pretty long.

Ivan


