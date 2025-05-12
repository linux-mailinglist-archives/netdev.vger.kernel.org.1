Return-Path: <netdev+bounces-189735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676ACAB366C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215A53A6A75
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8208293756;
	Mon, 12 May 2025 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlJWR5nY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EDA293729
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050929; cv=none; b=V5qfv/YbiMJ6i3cfkVYXXgOuFTQjojg3TT/3Qm3GsVMOQphHsdjIMtWL8ypkNSs456ajdJDix92D8HSVutVa+nWiCMxaBCdyJBH7deOdo+CMYuhAp5iKoQhXQeTZGK14zUV6sD6W7eiFnYJvcxTbez+kGAqhJPvajUiJXtoJUvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050929; c=relaxed/simple;
	bh=fpKuJ2+4jefwS/IKbyRXQB4RvXukKzGtBFAU7YzBq0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkhKW5clHvJZi3dEnobtkcoPXit1ljRAhnY8Riu6pjLF2XspuFLO9tEjVtOPA5aV4n+nz6xp3nBjmIKbz3GW1gPbOAv6U4T2Wnj0h7nPm+pS9MB0heKx82RvQUfZxzf0vUyKZgDGYIs2Kig/USGLZDraWlbnK7kdGQCjxWqwD3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlJWR5nY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747050926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3w6DrVzh6eoUVhtoXnjZ8ZVgMOpqb53FdE8SSrAvQ0=;
	b=GlJWR5nYUJGl1ZCtBqTfT2q6k0Wa+QCwXaHF9N6XSf6bJuElqTVDoc1PxncGAD+H/rtFfn
	oFNFo7G3igQS41tbIueNhnFVWotrWJ1O8n7Us6ucFQ2TeqqGtfk8YFVSHWXOmR0sSWDivh
	x37MM9nMwLy5oFI3g80bk5lZxq8U7Kg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-Qddqo7gNMl6Iadh20AKurg-1; Mon,
 12 May 2025 07:55:21 -0400
X-MC-Unique: Qddqo7gNMl6Iadh20AKurg-1
X-Mimecast-MFC-AGG-ID: Qddqo7gNMl6Iadh20AKurg_1747050919
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEBFA1956077;
	Mon, 12 May 2025 11:55:18 +0000 (UTC)
Received: from [10.44.34.215] (unknown [10.44.34.215])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D89DA19560A3;
	Mon, 12 May 2025 11:55:12 +0000 (UTC)
Message-ID: <b095ffb9-c274-4520-a45e-96861268500b@redhat.com>
Date: Mon, 12 May 2025 13:55:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
To: Lee Jones <lee@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250507124358.48776-1-ivecera@redhat.com>
 <20250507124358.48776-9-ivecera@redhat.com>
 <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
 <2e3eb9e3-151d-42ef-9043-998e762d3ba6@redhat.com>
 <aBt1N6TcSckYj23A@smile.fi.intel.com> <20250507152609.GK3865826@google.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250507152609.GK3865826@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 07. 05. 25 5:26 odp., Lee Jones wrote:
> On Wed, 07 May 2025, Andy Shevchenko wrote:
> 
>> On Wed, May 07, 2025 at 03:56:37PM +0200, Ivan Vecera wrote:
>>> On 07. 05. 25 3:41 odp., Andy Shevchenko wrote:
>>>> On Wed, May 7, 2025 at 3:45 PM Ivan Vecera <ivecera@redhat.com> wrote:
>>
>> ...
>>
>>>>> +static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
>>>>> +       { .channel = 0, },
>>>>> +       { .channel = 1, },
>>>>> +       { .channel = 2, },
>>>>> +       { .channel = 3, },
>>>>> +       { .channel = 4, },
>>>>> +};
>>>>
>>>>> +static const struct mfd_cell zl3073x_devs[] = {
>>>>> +       ZL3073X_CELL("zl3073x-dpll", 0),
>>>>> +       ZL3073X_CELL("zl3073x-dpll", 1),
>>>>> +       ZL3073X_CELL("zl3073x-dpll", 2),
>>>>> +       ZL3073X_CELL("zl3073x-dpll", 3),
>>>>> +       ZL3073X_CELL("zl3073x-dpll", 4),
>>>>> +};
>>>>
>>>>> +#define ZL3073X_MAX_CHANNELS   5
>>>>
>>>> Btw, wouldn't be better to keep the above lists synchronised like
>>>>
>>>> 1. Make ZL3073X_CELL() to use indexed variant
>>>>
>>>> [idx] = ...
>>>>
>>>> 2. Define the channel numbers
>>>>
>>>> and use them in both data structures.
>>>>
>>>> ...
>>>
>>> WDYM?
>>>
>>>> OTOH, I'm not sure why we even need this. If this is going to be
>>>> sequential, can't we make a core to decide which cell will be given
>>>> which id?
>>>
>>> Just a note that after introduction of PHC sub-driver the array will look
>>> like:
>>> static const struct mfd_cell zl3073x_devs[] = {
>>>         ZL3073X_CELL("zl3073x-dpll", 0),  // DPLL sub-dev for chan 0
>>>         ZL3073X_CELL("zl3073x-phc", 0),   // PHC sub-dev for chan 0
>>>         ZL3073X_CELL("zl3073x-dpll", 1),  // ...
>>>         ZL3073X_CELL("zl3073x-phc", 1),
>>>         ZL3073X_CELL("zl3073x-dpll", 2),
>>>         ZL3073X_CELL("zl3073x-phc", 2),
>>>         ZL3073X_CELL("zl3073x-dpll", 3),
>>>         ZL3073X_CELL("zl3073x-phc", 3),
>>>         ZL3073X_CELL("zl3073x-dpll", 4),
>>>         ZL3073X_CELL("zl3073x-phc", 4),   // PHC sub-dev for chan 4
>>> };
>>
>> Ah, this is very important piece. Then I mean only this kind of change
>>
>> enum {
>> 	// this or whatever meaningful names
>> 	..._CH_0	0
>> 	..._CH_1	1
>> 	...
>> };
>>
>> static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
>>         { .channel = ..._CH_0, },
>>         ...
>> };
>>
>> static const struct mfd_cell zl3073x_devs[] = {
>>         ZL3073X_CELL("zl3073x-dpll", ..._CH_0),
>>         ZL3073X_CELL("zl3073x-phc", ..._CH_0),
>>         ...
>> };
> 
> This is getting hectic.  All for a sequential enumeration.  Seeing as
> there are no other differentiations, why not use IDA in the child
> instead?

For that, there have to be two IDAs, one for DPLLs and one for PHCs...
The approach in my second reply in this thread is simpler and taken
in v8.

<cite>
+#define ZL3073X_PDATA(_channel)			\
+	(&(const struct zl3073x_pdata) {	\
+		.channel = _channel,		\
+	})
+
+#define ZL3073X_CELL(_name, _channel)				\
+	MFD_CELL_BASIC(_name, NULL, ZL3073X_PDATA(_channel),	\
+		       sizeof(struct zl3073x_pdata), 0)
+
+static const struct mfd_cell zl3073x_devs[] = {
+	ZL3073X_CELL("zl3073x-dpll", 0),
+	ZL3073X_CELL("zl3073x-dpll", 1),
+	ZL3073X_CELL("zl3073x-dpll", 2),
+	ZL3073X_CELL("zl3073x-dpll", 3),
+	ZL3073X_CELL("zl3073x-dpll", 4),
+};
</cite>

Lee, WDYT?

Thanks,
Ivan


