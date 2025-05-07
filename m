Return-Path: <netdev+bounces-188679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F24AAE2F3
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC2E1740ED
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43666288C11;
	Wed,  7 May 2025 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWlFWe9A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99791288CA9
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627586; cv=none; b=o8C+D/G4+IBOJ97kMSt/9lEvh0fF+wixhNsVJ2tjCk9AvBfhJfCesF8+/2HJdO+uQdqdpw6U/zTCI7Wq7PYOoj9UVrOp+DvHdmHQLG+ZVaG2E/ByuM4EQVVI2VicOfG0DP9o8Shwcf/Qoezb1TI3KMVnna2jbGlVUWbNyVLVNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627586; c=relaxed/simple;
	bh=+gSWaLrlSKvjhkkdwPTUbaGH52GIa8jFvFcv1TL+Qr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGrRHCrzA+4qU4P7e06yt6sZA2T2Mj7CtYZCxc9Pr8Vf/N9qQx7o5li3QqPM8W6d7PYyAdtZK/hNGgfvKX/4hOzFJeizUIDzlxH840/Fgj/5h8IUBmdT33ET665rJZU8lNXlc4qgFS76+RI7bi+CJ6TX/NwHWLHS2zVvtl6/FNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWlFWe9A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746627583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MweqEOF5l5jRk/Y5461YnFfXIpxXFbmEcdriDx9b/ng=;
	b=bWlFWe9AfGUUSCpkJnzozssJvwsej+RipLj2M8Jt0PyEj4pplUX6K4QaXd/U7wCubd9JOC
	QfWEZLespLJkLgpk7nY+Nj6XdIyH4xnHoySW9A/F67bdrdDfGmPlkXUd2WGISYjJ2/CiMO
	HLco24rpQaM7kVPjcG/ojBjRdqPFlPw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-MokWut8GP3WQFdyZTAATqA-1; Wed,
 07 May 2025 10:19:40 -0400
X-MC-Unique: MokWut8GP3WQFdyZTAATqA-1
X-Mimecast-MFC-AGG-ID: MokWut8GP3WQFdyZTAATqA_1746627577
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DEDA1956050;
	Wed,  7 May 2025 14:19:37 +0000 (UTC)
Received: from [10.44.33.91] (unknown [10.44.33.91])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5062D1800359;
	Wed,  7 May 2025 14:19:31 +0000 (UTC)
Message-ID: <7e7122b1-b5ff-4800-8e1d-b1532a7c1ecf@redhat.com>
Date: Wed, 7 May 2025 16:19:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250507124358.48776-1-ivecera@redhat.com>
 <20250507124358.48776-9-ivecera@redhat.com>
 <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 07. 05. 25 3:41 odp., Andy Shevchenko wrote:
> On Wed, May 7, 2025 at 3:45 PM Ivan Vecera <ivecera@redhat.com> wrote:
>>
>> Register DPLL sub-devices to expose the functionality provided
>> by ZL3073x chip family. Each sub-device represents one of
>> the available DPLL channels.
> 
> ...
> 
>> +static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
>> +       { .channel = 0, },
>> +       { .channel = 1, },
>> +       { .channel = 2, },
>> +       { .channel = 3, },
>> +       { .channel = 4, },
>> +};
> 
>> +static const struct mfd_cell zl3073x_devs[] = {
>> +       ZL3073X_CELL("zl3073x-dpll", 0),
>> +       ZL3073X_CELL("zl3073x-dpll", 1),
>> +       ZL3073X_CELL("zl3073x-dpll", 2),
>> +       ZL3073X_CELL("zl3073x-dpll", 3),
>> +       ZL3073X_CELL("zl3073x-dpll", 4),
>> +};
> 
>> +#define ZL3073X_MAX_CHANNELS   5
> 
> Btw, wouldn't be better to keep the above lists synchronised like
> 
> 1. Make ZL3073X_CELL() to use indexed variant
> 
> [idx] = ...
> 
> 2. Define the channel numbers
> 
> and use them in both data structures.
> 
It could be possible to drop zl3073x_pdata array and modify ZL3073X_CELL
this way:

#define ZL3073X_CHANNEL(_channel)                               \
         &(const struct zl3073x_pdata) { .channel = _channel }

#define ZL3073X_CELL(_name, _channel)                           \
         MFD_CELL_BASIC(_name, NULL, ZL3073X_CHANNEL(_channel),  \
                        sizeof(struct zl3073x_pdata), 0)

WDYT?

Ivan


