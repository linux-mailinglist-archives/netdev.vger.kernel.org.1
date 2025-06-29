Return-Path: <netdev+bounces-202264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D1FAECFD0
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC2D18963B6
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B785123A9AE;
	Sun, 29 Jun 2025 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNQsGW0N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8DBE4A
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751223873; cv=none; b=uRiRGL3ld4A7a1yqu3wqrgxzJzlL3zjfdFy1mW5+rA+RzDrfCtqpls6DHHkaYzoUm0aeYiYY8Q2pJyyO/xp1b6Ge3ZWm/8RVoqc2Ry2cNvHP81FlJnJwTAIt/vjYJqCJT4Q3eWkQkMA7wZlsgEeG+C/hdnaYV/r5EmcMTnKq/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751223873; c=relaxed/simple;
	bh=M10Ctqs7hcuFcS2TexQxfgsXUncjchaWsO0PwT9D8GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nw1UcTNs2X0FaIICjKfV1jlj4VTZgGlFkWHmKnh92SCLO+Q4u1NbE+KQcxhSFsZWirFqOQg1Lc4MgPhISv0ecHihsuC4CNVJai37XuhsbAeX5EKJjpHeKs9vm3ZAoABoeFIozKbvQW9W6RjNAqGg64XXhVaP2DHTlFXqYt54Hs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNQsGW0N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751223871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s49YQGftGKpHPbBrk+2AAdXS1ZVznQ5MfA7qQvDwtec=;
	b=iNQsGW0NNi+poaksWoF5gtsOtZ/UZ0nWdUQnrCdxpcg3Ok9QG2LEm+wr7XT73kEFKqldJc
	ZdW7DnOTbHXNTe/OW0L49nz+nxZIJBVOK0wggZpLOH4bt+ET5dw56SXG2lRgiEyOnH0KdR
	KqQ3FmDgoZIzjstM+H/+UPp24L9CYIA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-hLuN9LUrNUaJhEg8GSdwOQ-1; Sun,
 29 Jun 2025 15:04:25 -0400
X-MC-Unique: hLuN9LUrNUaJhEg8GSdwOQ-1
X-Mimecast-MFC-AGG-ID: hLuN9LUrNUaJhEg8GSdwOQ_1751223863
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC31118001D1;
	Sun, 29 Jun 2025 19:04:22 +0000 (UTC)
Received: from [10.45.224.33] (unknown [10.45.224.33])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53DC618003FC;
	Sun, 29 Jun 2025 19:04:16 +0000 (UTC)
Message-ID: <1e2997cd-6932-46bd-8d5b-35a98b52abae@redhat.com>
Date: Sun, 29 Jun 2025 21:04:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 14/14] dpll: zl3073x: Add support to get/set
 frequency on output pins
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson <shannon.nelson@amd.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250616201404.1412341-1-ivecera@redhat.com>
 <20250616201404.1412341-15-ivecera@redhat.com>
 <7fce273d-06f4-498c-a36a-d6828b4d4f30@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <7fce273d-06f4-498c-a36a-d6828b4d4f30@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On 19. 06. 25 1:40 odp., Paolo Abeni wrote:
> On 6/16/25 10:14 PM, Ivan Vecera wrote:
>> +static int
>> +zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>> +				      void *pin_priv,
>> +				      const struct dpll_device *dpll,
>> +				      void *dpll_priv, u64 frequency,
>> +				      struct netlink_ext_ack *extack)
>> +{
>> +	struct zl3073x_dpll *zldpll = dpll_priv;
>> +	struct zl3073x_dev *zldev = zldpll->dev;
>> +	struct zl3073x_dpll_pin *pin = pin_priv;
>> +	struct device *dev = zldev->dev;
>> +	u32 output_n_freq, output_p_freq;
>> +	u8 out, signal_format, synth;
>> +	u32 cur_div, new_div, ndiv;
>> +	u32 synth_freq;
>> +	int rc;
>> +
>> +	out = zl3073x_output_pin_out_get(pin->id);
>> +	synth = zl3073x_out_synth_get(zldev, out);
>> +	synth_freq = zl3073x_synth_freq_get(zldev, synth);
>> +
>> +	/* Check the requested frequency divides synth frequency without
>> +	 * remainder.
>> +	 */
>> +	if (synth_freq % (u32)frequency) {
> 
> As the frequency comes from user-space and is validated only the DT
> info, which in turn is AFAICS imported verbatim into the kernel, I
> *think* it would be safer to check for 0 here or at DT info load time.

This check is superfluous, the frequency from user-space is validated
in DPLL core against frequency list provided for particular pin by the
driver. And frequencies from DT are filtered/checked during load.
So no check is needed here.

Will fix.

Ivan


