Return-Path: <netdev+bounces-182274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8D7A8868D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76701901483
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A1C19539F;
	Mon, 14 Apr 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nxp0lmUV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D582472BB
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642435; cv=none; b=TiPkXKXvzhe9JBHLmfC7vNqYRm/fgB/SG/+Q2zPIl5DDyP/KCF1pV0Ha/GZl/yBQAybTVSW9TmI3yf4KyLcdFJzx6kPhoYjvSWiWYnTWgeZff8BqpthkEHAkCI3GXF8EO75Rovw5pSEYGoYQ4+0VpYM4F881Yia5ldTQNy1xtaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642435; c=relaxed/simple;
	bh=CPWUMoO/hJ8wp8Jksk3JD28gquTg6bVUwkKbgmJ0LpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dp6+mdwwk2DX3pcNhL0/fTwtBv8WewTYnim7bw6m6HWpvce3shEtKeHkXk+y+GWyy42MdUkRYQ0fXhPm8qufYnVavgw3aAvUH03/rpYiYhTTARhPtjfmTY5ZrkCWKigrEyycIx+euanb4EiP4EeQb9OLNuw197b3Mm13loGw3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nxp0lmUV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744642432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cd0S4b4Qg1iHX5AktXHWyQVLtGhRM54Nv+RIauLgOUs=;
	b=Nxp0lmUVXQxXS/KKPyJ6tGmxV0BkQytnH+enQK9/a6b9ktuU0cHdRxct4mG80Q4QpXMexz
	lT5t+x6WQ5oo641/C7Jdk+IuTOAIp96NSrM++kSPZ2o+UzgsVsq3avpZn8usxouziD1lQY
	v0cl9O4+0+eyW4PAgsqGFTjOwlQ/AIs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-CCIMtZdNPDyXOgxqVeNC8Q-1; Mon,
 14 Apr 2025 10:53:48 -0400
X-MC-Unique: CCIMtZdNPDyXOgxqVeNC8Q-1
X-Mimecast-MFC-AGG-ID: CCIMtZdNPDyXOgxqVeNC8Q_1744642422
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1D1F1828A89;
	Mon, 14 Apr 2025 14:53:40 +0000 (UTC)
Received: from [10.44.32.81] (unknown [10.44.32.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57F333001D0F;
	Mon, 14 Apr 2025 14:53:35 +0000 (UTC)
Message-ID: <ad5ada81-d611-41bb-8358-3675f90767f1@redhat.com>
Date: Mon, 14 Apr 2025 16:53:33 +0200
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
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CAHp75Vej0MCAV7v7Zom8CXqh3F6f3QXevW93pOkXSLEZn7Yxfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 14. 04. 25 4:16 odp., Andy Shevchenko wrote:
> On Mon, Apr 14, 2025 at 5:13 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Mon, Apr 14, 2025 at 5:10 PM Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Mon, Apr 14, 2025 at 5:07 PM Ivan Vecera <ivecera@redhat.com> wrote:
>>>> On 14. 04. 25 1:52 odp., Ivan Vecera wrote:
> 
> ...
> 
>>>> Long story short, I have to move virtual range outside real address
>>>> range and apply this offset in the driver code.
>>>>
>>>> Is this correct?
>>>
>>> Bingo!
>>>
>>> And for the offsets, you form them as "page number * page offset +
>>> offset inside the page".
>>
>> Note, for easier reference you may still map page 0 to the virtual
>> space, but make sure that page 0 (or main page) is available outside
>> of the ranges, or i.o.w. ranges do not overlap the main page, even if
>> they include page 0.
> 
> So, you will have the following layout
> 
> 0x00 - 0xnn - real registers of page 0.
> 
> 0x100 - 0xppp -- pages 0 ... N
> 
> Register access either direct for when direct is required, or as
> 0x100 + PageSize * Index + RegOffset

Now, get it...

I was a little bit confused by code of _regmap_select_page() that takes 
care of selector_reg.

Btw, why is this needed? why they cannot overlap?

Let's say I have virtual range <0, 0xfff>, window <0, 0xff> and window 
selector 0xff>.
1. I'm calling regmap_read(regmap, 0x8f, ...)
2. The regmap looks for the range and it finds it (0..0xfff)
3. Then it calls _regmap_select_page() that computes:
    window_offset = (0x8f - 0x000) % 0x100 = 0x8f
    window_page = (0x8f - 0x000) / 0x100 = 0
4. _regmap_select_page() set window selector to 0 and reg is updated to
    reg = window_start + window_offset = 0x8f

And for window_selector value: regmap_read(regmap, 0xff, ...) is the 
same except _regmap_select_page() checks that the given address is 
selector_reg and won't perform page switching.

When I think about it, in my case there is no normal page, there is only 
volatile register window <0x00-0x7e> and only single direct register 
that is page selector at 0x7f.

Thanks,
Ivan


