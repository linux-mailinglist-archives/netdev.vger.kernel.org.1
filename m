Return-Path: <netdev+bounces-207164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE9FB0619D
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C833F5A652A
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2EC74BE1;
	Tue, 15 Jul 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfJfEJG/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E961E832A
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589486; cv=none; b=NwiAxp+nPZ4cjjqXqWR5Y41udRLPAerlByPCXPJIewQif1ATs0V8kyK4GizZ1zsjJAHe7gTJ8ARB+pgvIozKVlpAK8GGO0H2zv7/5UNYs/VCwaJ0uErCoN/1oxz0lWFZNEFBf0h6HXUK+uQ72yF5XS7UHM17vR2r/q7qt/ED+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589486; c=relaxed/simple;
	bh=Qw/PROQAq5BP6Jn0m4gJ/7ZqmkUwpZ5VeYsRhv5TxKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6ZQ5OzZhNPAWoAArKXtYH3GZPmeK/Y/wUdnjQmNBFTqyXBPFEI53BZuZLbvhgosfdgR90t8mHWFKdBj/zsuBAHtol3grJ5ut3SdWK3kwz4FEmV7q8sFrohzdlPvPAXExhVtqX7+bNI5D3GSYL8lFXwWdq0YI/sSCyDPmB6Rxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TfJfEJG/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752589483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFnv2wbLhigICtNklHhDLySykgY9KegI6p2UWJYgeVo=;
	b=TfJfEJG/wNGk1vMR1HjPDCNXpg8xFvloMDCv/esdcYS2YuEU+eqxQ8112xDbEONSI3v9lK
	99M/7zwURkjqRdvsDdaKHVSycy1P622wdcM9rM2o3rkk7URAvXsTVoh/6yRDbeRAYNkY/i
	jc3zcuMnhzB0EdDX6HOHtSUML24f/F4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-WdaDn4OoPbel_sZOkYEcIg-1; Tue,
 15 Jul 2025 10:24:42 -0400
X-MC-Unique: WdaDn4OoPbel_sZOkYEcIg-1
X-Mimecast-MFC-AGG-ID: WdaDn4OoPbel_sZOkYEcIg_1752589480
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4FC2180028C;
	Tue, 15 Jul 2025 14:24:40 +0000 (UTC)
Received: from [10.45.225.30] (unknown [10.45.225.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6170180045B;
	Tue, 15 Jul 2025 14:24:37 +0000 (UTC)
Message-ID: <e1078cc6-f22e-441a-86f5-8c4c6e239f02@redhat.com>
Date: Tue, 15 Jul 2025 16:24:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] dpll: zl3073x: Add support to adjust phase
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250710153848.928531-1-ivecera@redhat.com>
 <20250710153848.928531-5-ivecera@redhat.com>
 <495a37e7-e31d-4671-a4d9-7e653ad80b60@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <495a37e7-e31d-4671-a4d9-7e653ad80b60@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 15. 07. 25 3:12 odp., Paolo Abeni wrote:
> On 7/10/25 5:38 PM, Ivan Vecera wrote:
>> +static int
>> +zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
>> +					 void *pin_priv,
>> +					 const struct dpll_device *dpll,
>> +					 void *dpll_priv,
>> +					 s32 *phase_adjust,
>> +					 struct netlink_ext_ack *extack)
>> +{
>> +	struct zl3073x_dpll *zldpll = dpll_priv;
>> +	struct zl3073x_dev *zldev = zldpll->dev;
>> +	struct zl3073x_dpll_pin *pin = pin_priv;
>> +	u32 synth_freq;
>> +	s32 phase_comp;
>> +	u8 out, synth;
>> +	int rc;
>> +
>> +	out = zl3073x_output_pin_out_get(pin->id);
>> +	synth = zl3073x_out_synth_get(zldev, out);
>> +	synth_freq = zl3073x_synth_freq_get(zldev, synth);
>> +
>> +	guard(mutex)(&zldev->multiop_lock);
>> +
>> +	/* Read output configuration */
>> +	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
>> +			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Read current output phase compensation */
>> +	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP, &phase_comp);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Value in register is expressed in half synth clock cycles */
>> +	phase_comp *= (int)div_u64(PSEC_PER_SEC, 2 * synth_freq);
> 
> Is 'synth_freq' guaranteed to be != 0 even on extreme conditions?
> Possibly a comment or an explicit check could help.

Under normal conditions (device is working and synth is enabled) this
should not happen but additional check here is reasonable to catch
unusual conditions to avoid division by zero.

Will add it.

Thanks,
Ivan


