Return-Path: <netdev+bounces-249014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ED4D12B0D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B888A3000DFE
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8E3587D7;
	Mon, 12 Jan 2026 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHlRpbfa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE73587AA
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223421; cv=none; b=aMoV2vrVsqFDgry73KsRXyYWGkcB1Z6jKAtn6AHwx6C2+yCzz88eeHKo0nRv4D2TGUzBCZZ++RDoPLRM1gxQL+SSZBvSN3Ar57/pWAmP3TTpjjZJW7BdiqDAJ/au9cG0nHcdi9872In5kjsShSQb/CM2lB86vk2roplDcJmCQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223421; c=relaxed/simple;
	bh=KLb7rrix/hx2YIVl8QWBGWMLT0jC1Fm7N/5kv+rcUdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb2t/Fouv/cxmFFRlNDXpDk4/RruVSFXolPOduViYbjMYtz+Y0T5cTTLvAZuFFtTRD94P3IAy05nBEyj9HfrSNbIn5z9Gw9piL9Se3Xw/ts4WoWN4nG8MXy9V/zI2i2STkD6UmS6t13n3S198Yp47skTL9VbY/204YTmuKE2P54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHlRpbfa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768223419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCxte+sASljka+rQHwJ/rlUEewr2IBIVlYyDsrOe3CA=;
	b=SHlRpbfaNwW67YDVnjkEUE537JG135KZnz7uzj1ekMqdo319+XK0tQ322Vm52Okw0ZQQCf
	ZBpCuXxIBrIyxt5Uupq4YpVU8ByW2UOHDWf2DbGngN4an4kc21APzEmaUyGPlLLbQcG7ps
	i8JrzJ5UV1bvFnGCVus3KahOIcqx/eo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-S8ApqOwZNA6v_BM_gFkFSQ-1; Mon,
 12 Jan 2026 08:10:15 -0500
X-MC-Unique: S8ApqOwZNA6v_BM_gFkFSQ-1
X-Mimecast-MFC-AGG-ID: S8ApqOwZNA6v_BM_gFkFSQ_1768223413
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A98B180045C;
	Mon, 12 Jan 2026 13:10:13 +0000 (UTC)
Received: from [10.44.34.128] (unknown [10.44.34.128])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3FFCF30001A2;
	Mon, 12 Jan 2026 13:10:08 +0000 (UTC)
Message-ID: <e676a8f1-0b82-4053-86d6-a8c492cf7238@redhat.com>
Date: Mon, 12 Jan 2026 14:10:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] dpll: add dpll_device op to set working mode
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>
References: <20260112101409.804206-1-ivecera@redhat.com>
 <20260112101409.804206-3-ivecera@redhat.com>
 <0179717b-9567-4f3d-a521-6988c2d21ba6@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <0179717b-9567-4f3d-a521-6988c2d21ba6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 1/12/26 12:35 PM, Vadim Fedorenko wrote:
>> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/ 
>> netlink/specs/dpll.yaml
>> index 78d0724d7e12c..b55afa77eac4b 100644
>> --- a/Documentation/netlink/specs/dpll.yaml
>> +++ b/Documentation/netlink/specs/dpll.yaml
>> @@ -550,6 +550,7 @@ operations:
>>           request:
>>             attributes:
>>               - id
>> +            - mode
>>               - phase-offset-monitor
>>               - phase-offset-avg-factor
>>       -
>> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>> index d6a0e272d7038..37ca90ab841bd 100644
>> --- a/drivers/dpll/dpll_netlink.c
>> +++ b/drivers/dpll/dpll_netlink.c
>> @@ -853,6 +853,45 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
>>   }
>>   EXPORT_SYMBOL_GPL(dpll_pin_change_ntf);
>> +static int
>> +dpll_mode_set(struct dpll_device *dpll, struct nlattr *a,
>> +          struct netlink_ext_ack *extack)
>> +{
>> +    const struct dpll_device_ops *ops = dpll_device_ops(dpll);
>> +    enum dpll_mode mode = nla_get_u32(a), old_mode;
>> +    DECLARE_BITMAP(modes, DPLL_MODE_MAX) = { 0 };
> 
> I believe the size of bitmap should be DPLL_MODE_MAX + 1 or
> __DPLL_MODE_MAX?

Yes, you are right... will fix.

Thanks,
Ivan


