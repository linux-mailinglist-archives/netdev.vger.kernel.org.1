Return-Path: <netdev+bounces-188702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1468AAE48A
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FB71C21B8C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AFD28A72F;
	Wed,  7 May 2025 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSjUC3Nc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033A28A419
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631421; cv=none; b=ufFnKyRrStiBWKYmDZ1mUsikXJfQQtFAtDI12k8IT0eMgaFGn5bjGtPKSXJDvvK+UAgcSLm6dyPcaQtbd1a4+0MJtqJVpvHzTdig1BApwecwMpKiVxlWCh62Anpg8JI8itYUpdRUEEAPbOeXwzc9wXXpLYvfdvYh9YyXiKhjjYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631421; c=relaxed/simple;
	bh=OEYJla6yHOI5aq7uzE4QyMPKy37/w0aCSCvZZmQryAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdmgMUu/jMVyScFO4g5S04u2cVq2ZCnTersmV+crpyW9nbOlKbZb6fwGHWNQj3gUKDOHziRvcp6bb8mvwhqWFxYbNnUWoajXn4q4t2WsF3UfQJo2drB5F45/hiDY/sIZyhhsiE2vWME6JHhzChki9U610fCGslpVvGLwoCGtAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSjUC3Nc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746631418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Udw3u5odw3nfkdx4NGPiBiHcQObVWVbppj9xzXvG9I=;
	b=DSjUC3Nc+EWyOlrpB+I88FO/BlNLM5k2d4xIXa2wMDY/gkmjosEN4Uv4enGN/wmB95bv4W
	3C+VNLWG/LlkcYGw3m6SDrYI/9hzZtqlN+rc/EvIxKSXk8msojWe1KjGP5q1fmIn7RHQVg
	KjHVOukmoeMck33RFig0Umc/bQl6nlI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-U2ae1rr7N7-WB7Gx_usSuA-1; Wed,
 07 May 2025 11:23:33 -0400
X-MC-Unique: U2ae1rr7N7-WB7Gx_usSuA-1
X-Mimecast-MFC-AGG-ID: U2ae1rr7N7-WB7Gx_usSuA_1746631411
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BECAA18001E0;
	Wed,  7 May 2025 15:23:30 +0000 (UTC)
Received: from [10.44.33.91] (unknown [10.44.33.91])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A488B1956058;
	Wed,  7 May 2025 15:23:25 +0000 (UTC)
Message-ID: <54232b53-343f-456c-9c62-bd4958e2962a@redhat.com>
Date: Wed, 7 May 2025 17:23:24 +0200
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
 Lee Jones <lee@kernel.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250507124358.48776-1-ivecera@redhat.com>
 <20250507124358.48776-9-ivecera@redhat.com>
 <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
 <7e7122b1-b5ff-4800-8e1d-b1532a7c1ecf@redhat.com>
 <aBt1jXNRgtNVDcWC@smile.fi.intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <aBt1jXNRgtNVDcWC@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07. 05. 25 5:00 odp., Andy Shevchenko wrote:
> On Wed, May 07, 2025 at 04:19:29PM +0200, Ivan Vecera wrote:
>> On 07. 05. 25 3:41 odp., Andy Shevchenko wrote:
>>> On Wed, May 7, 2025 at 3:45 PM Ivan Vecera <ivecera@redhat.com> wrote:
> 
> ...
> 
>>>> +static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
>>>> +       { .channel = 0, },
>>>> +       { .channel = 1, },
>>>> +       { .channel = 2, },
>>>> +       { .channel = 3, },
>>>> +       { .channel = 4, },
>>>> +};
>>>
>>>> +static const struct mfd_cell zl3073x_devs[] = {
>>>> +       ZL3073X_CELL("zl3073x-dpll", 0),
>>>> +       ZL3073X_CELL("zl3073x-dpll", 1),
>>>> +       ZL3073X_CELL("zl3073x-dpll", 2),
>>>> +       ZL3073X_CELL("zl3073x-dpll", 3),
>>>> +       ZL3073X_CELL("zl3073x-dpll", 4),
>>>> +};
>>>
>>>> +#define ZL3073X_MAX_CHANNELS   5
>>>
>>> Btw, wouldn't be better to keep the above lists synchronised like
>>>
>>> 1. Make ZL3073X_CELL() to use indexed variant
>>>
>>> [idx] = ...
>>>
>>> 2. Define the channel numbers
>>>
>>> and use them in both data structures.
>>>
>> It could be possible to drop zl3073x_pdata array and modify ZL3073X_CELL
>> this way:
>>
>> #define ZL3073X_CHANNEL(_channel)                               \
>>          &(const struct zl3073x_pdata) { .channel = _channel }
>>
>> #define ZL3073X_CELL(_name, _channel)                           \
>>          MFD_CELL_BASIC(_name, NULL, ZL3073X_CHANNEL(_channel),  \
>>                         sizeof(struct zl3073x_pdata), 0)
>>
>> WDYT?
> 
> Fine with me as it looks not ugly and addresses my point.
> 
Will submit v8 shortly..

Thanks for review and advice.

Ivan


