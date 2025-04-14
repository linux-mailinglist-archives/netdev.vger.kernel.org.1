Return-Path: <netdev+bounces-182394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AFBA88A32
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6F817711F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DF628BA85;
	Mon, 14 Apr 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD82OC3x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D52749F9
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652573; cv=none; b=WDqO9gKu+s9MfIx8IXo0H0WZ6OXcpjAOdMxB+SuJ5l+m0YQ/s0+Lg2zl3VJFn8+9DeuBjvfPBLCWJzsjUzlZIqcRtQBfdnylXcuRebNDm+tb9+QubcSThxkev2yiQACVSkm3M0DkRt1Tbp15epnOrFBWNif161+38SjeT1Ww7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652573; c=relaxed/simple;
	bh=4kjXEbdhBm9JRfgtbuzoUGIO3kfVoOMeYuD+D2ETRJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDoHxtyu8PP4CHKn23GyQIIRku8V0LmhNY/goHM2/cp2Av2yeiOzfPlF5F38w5H5LYkoaktVukwT48tFsNDsB2KdX1c8r7CmJWdR9S1/2wTPMoUV9Q5uUcvBCawyIjx2Z/BtG5QktEugPvWkIZwG4EI83mkXgMCWsDM6v71dJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PD82OC3x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744652570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSpTUwU+7FESIVM4O59Wy17WDk2ETrjJCbiiZOcWCEc=;
	b=PD82OC3xDAE55GNKqEIHhjxA85IV0Ene6/YSAwTobJoR36J6B3RTiIQhSADD6OIHIwfkg1
	EbvKagut5IGc+ErkREtUmHrm+4fV22oMWZKpEID69fBRtE3NFVZOdJC4MZxwRB1Nc7FdFd
	m74nIwqLBSYPsc3bxhikfFlvLqg6As8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-cj31dKMROfSDFEgPx825Kg-1; Mon,
 14 Apr 2025 13:42:46 -0400
X-MC-Unique: cj31dKMROfSDFEgPx825Kg-1
X-Mimecast-MFC-AGG-ID: cj31dKMROfSDFEgPx825Kg_1744652564
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3DAD180AF6A;
	Mon, 14 Apr 2025 17:42:43 +0000 (UTC)
Received: from [10.44.32.81] (unknown [10.44.32.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DF9619560AD;
	Mon, 14 Apr 2025 17:42:38 +0000 (UTC)
Message-ID: <00cf9bc9-073c-4a6b-8024-2103942fe5b1@redhat.com>
Date: Mon, 14 Apr 2025 19:42:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/28] mfd: Add Microchip ZL3073x support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, netdev@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-2-ivecera@redhat.com>
 <Z_QTzwXvxcSh53Cq@smile.fi.intel.com>
 <eeddcda2-efe4-4563-bb2c-70009b374486@redhat.com>
 <Z_ys4Lo46KusTBIj@smile.fi.intel.com>
 <f3fc9556-60ba-48c0-95f2-4c030e5c309e@redhat.com>
 <79b9ee2f-091d-4e0f-bbe3-c56cf02c3532@redhat.com>
 <b54e4da8-20a5-4464-a4b7-f4d8f70af989@redhat.com>
 <CAHp75Ve2KwOEdd=6stm0VXPmuMG-ZRzp8o5PT_db_LYxStqEzg@mail.gmail.com>
 <CAHp75Vc0p-dehdjyt9cDm6m72kGq5v5xW8=YRk27KNs5g-qgTw@mail.gmail.com>
 <CAHp75Vej0MCAV7v7Zom8CXqh3F6f3QXevW93pOkXSLEZn7Yxfg@mail.gmail.com>
 <ad5ada81-d611-41bb-8358-3675f90767f1@redhat.com>
 <CAHp75VdkLnm42DS2+kebYUWyXAhyNgswwDNynNJ-weo3DZ=G+Q@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CAHp75VdkLnm42DS2+kebYUWyXAhyNgswwDNynNJ-weo3DZ=G+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 14. 04. 25 7:09 odp., Andy Shevchenko wrote:
>> Now, get it...
>>
>> I was a little bit confused by code of _regmap_select_page() that takes
>> care of selector_reg.
>>
>> Btw, why is this needed? why they cannot overlap?
>>
>> Let's say I have virtual range <0, 0xfff>, window <0, 0xff> and window
>> selector 0xff>.
>> 1. I'm calling regmap_read(regmap, 0x8f, ...)
>> 2. The regmap looks for the range and it finds it (0..0xfff)
>> 3. Then it calls _regmap_select_page() that computes:
>>      window_offset = (0x8f - 0x000) % 0x100 = 0x8f
>>      window_page = (0x8f - 0x000) / 0x100 = 0
>> 4. _regmap_select_page() set window selector to 0 and reg is updated to
>>      reg = window_start + window_offset = 0x8f
>>
>> And for window_selector value: regmap_read(regmap, 0xff, ...) is the
>> same except _regmap_select_page() checks that the given address is
>> selector_reg and won't perform page switching.
>>
>> When I think about it, in my case there is no normal page, there is only
>> volatile register window <0x00-0x7e> and only single direct register
>> that is page selector at 0x7f.
> Because you are effectively messing up with cache. Also it's not
> recommended in general to do such due to some registers that might
> need to be accessed directly. And also note, that each time you access
> this you will call a selector write_each_ time you want to write the
> register in the map (if there is no cache, or if cache is messed up).

Get it fully now...

Thank you, Andy, for the explanation and for the patience.

Will send v3 soon.

Ivan


