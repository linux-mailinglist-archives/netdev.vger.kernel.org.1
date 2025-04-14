Return-Path: <netdev+bounces-182247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91080A88553
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1E8189FFF2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574142C0303;
	Mon, 14 Apr 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWZ5aCZA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF83433CB
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639713; cv=none; b=YHZ77hXh3IFk4jkFLatWpPlwrsv80kEhX0NIL5lwiuEAg1tmHa9+acBGG71lwM7DOugaBXUOa/i0F6gGi2HcDjXf4T96VKO7jND+jppS3++NH33ruweVUwDzNxRQwhBDv50TNPlqjCodDtVie3iAElW4VefAlazP/fZrKf9ymeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639713; c=relaxed/simple;
	bh=WqGTqa2wWw2oXDWJ5sPQzdsrwsWJMRcIj1r1cQCHE4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqUUY2wY7C5kk/K1mO2/ujsIQIEOnhVJ9IBpLm5+aY+sCe+ddqjNimjAMuuhe+owi/kO4m6+miUFvo81K9zuPnEMxzDt8TeGy+2gnA1LB4tsoRxoyvt0P9mqE7+zwYnCkAYfutiH7e7rhIZdmaOQCNrD47afzDa784bMPfhBIoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWZ5aCZA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744639710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVLsjYDvYBHlqk+yeP8jOnkwTdAVrBmSgCOK1FGYOz0=;
	b=BWZ5aCZAaOdJgWoncMD3jUTKs1HYGndURY7/+WvTsbFi9e/76Xu+2pgmctrCSBUXLrgtBN
	MnZub9yVUM7qDk0+aPrVOpN/0IUPtJ/LPxFPi7EilrDpd6ZYhhJ9eFQo5WLPmiu8eKNIBj
	ggO88lnEavCBp+nt77qEwScg9P9P5RI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-H_swq0IhO42Cqi9zOHrAjw-1; Mon,
 14 Apr 2025 10:08:25 -0400
X-MC-Unique: H_swq0IhO42Cqi9zOHrAjw-1
X-Mimecast-MFC-AGG-ID: H_swq0IhO42Cqi9zOHrAjw_1744639701
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E63281955DCF;
	Mon, 14 Apr 2025 14:08:20 +0000 (UTC)
Received: from [10.44.32.81] (unknown [10.44.32.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DEBA180AF7C;
	Mon, 14 Apr 2025 14:08:16 +0000 (UTC)
Message-ID: <79617a32-ddc3-42c4-bdb5-c21bf985c92c@redhat.com>
Date: Mon, 14 Apr 2025 16:08:15 +0200
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
 <CAHp75VcumcH_9-2P2iayGWwD3Y87A7CZyO9vxqvbaUptS1FeQw@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CAHp75VcumcH_9-2P2iayGWwD3Y87A7CZyO9vxqvbaUptS1FeQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 14. 04. 25 3:55 odp., Andy Shevchenko wrote:
> On Mon, Apr 14, 2025 at 2:52 PM Ivan Vecera <ivecera@redhat.com> wrote:
>> On 14. 04. 25 1:39 odp., Ivan Vecera wrote:
>>> On 14. 04. 25 8:36 dop., Andy Shevchenko wrote:
>>>>> What is wrong here?
>>>>>
>>>>> I have a device that uses 7-bit addresses and have 16 register pages.
>>>>> Each pages is from 0x00-0x7f and register 0x7f is used as page selector
>>>>> where bits 0-3 select the page.
>>>> The problem is that you overlap virtual page over the real one (the
>>>> main one).
>>>>
>>>> The drivers you mentioned in v2 discussions most likely are also buggy.
>>>> As I implied in the above question the developers hardly get the
>>>> regmap ranges
>>>> right. It took me quite a while to see the issue, so it's not
>>>> particularly your
>>>> fault.
>>> Hi Andy,
>>>
>>> thank you I see the point.
>>>
>>> Do you mean that the selector register should not be part of the range?
>>>
>>> If so, does it mean that I have to specify a range for each page? Like
>>> this:
>>>
>>>       {
>>>           /* Page 0 */
>>>           .range_min    = 0x000,
>>>           .range_max    = 0x07e,
>>>           .selector_reg    = ZL3073x_PAGE_SEL,
>>>           .selector_mask    = GENMASK(3, 0),
>>>           .selector_shift    = 0,
>>>           .window_start    = 0,
>>>           .window_len    = 0x7e,
>>>       },
>>>       {
>>>           /* Page 1 */
>>>           .range_min    = 0x080,
>>>           .range_max    = 0x0fe,
>>>           .selector_reg    = ZL3073x_PAGE_SEL,
>>>           .selector_mask    = GENMASK(3, 0),
>>>           .selector_shift    = 0,
>>>           .window_start    = 0,
>>>           .window_len    = 0x7e,
>>>       },
> 
> ...
> 
>> Sorry,
>> .window_len = 0x7f /* Exclude selector reg */
> 
> It actually will make things worse. If selector register is accessible
> to all of the pages, it's better to include it in all pages.

Yes :-) I know this is non-sense.
See my recent reply.

Thanks,
Ivan


