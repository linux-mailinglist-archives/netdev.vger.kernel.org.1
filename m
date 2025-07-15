Return-Path: <netdev+bounces-207160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840F6B060FD
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6743F50361E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFEE299AA1;
	Tue, 15 Jul 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiblNp5H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5E299A80
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588628; cv=none; b=cpTDhUabZh0LTTipYOH6bhrYa1Ua5iijQljqKSzdusJRdbDtUiy8QBgKHviCJTYERdQRcfqd89CzOz8yVObaZa5UnanA/vGIwK6QTxc4dY0pYvfpjlovg1Qe0dKzN8QePwoijuSaWBXNNRG2oPpV41SlDFoTlqzjPqzA4GK8MDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588628; c=relaxed/simple;
	bh=nM3sBbEd/MC4IBp/ZTDuhZ4F/OA3tDt2R5MAzuttJPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQ+vP/Qx61jsqRUKC3l680mL5O2C8hUjWIxpGMm1M4W46/hwM70ktQt5T2oVd5/LS1TGa9Pf+KZ31OidxG4AdDsG/zxRAO7v4GPdeFEmFp4ZniXSMldPG0zSxSIjFKY5Aenmjd7N7x20725H8Mio8gaZtydqhALpJYJXk6SDy/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiblNp5H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752588626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nn0ifr0DWEppbJzKrvZ/M9f086j3MUbtfEOSL9jAtjU=;
	b=eiblNp5HFaXUO8IqjxcnaflNZxbbu6XFq34VlWY1Xypp14nyxR94nrfDl3h3KGdL4AbQnX
	hbU4N0PPuRsajdHQev73XeM1JnIJ9ANxPU8e7vrIdfwWyItC487174jb63wDViZFBQz560
	eNxsXDtRW6moynOIM+0d/ud/GGbhEac=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-uILN_OEUNHuxmQjQX_-f2Q-1; Tue,
 15 Jul 2025 10:10:20 -0400
X-MC-Unique: uILN_OEUNHuxmQjQX_-f2Q-1
X-Mimecast-MFC-AGG-ID: uILN_OEUNHuxmQjQX_-f2Q_1752588618
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 045B81800253;
	Tue, 15 Jul 2025 14:10:18 +0000 (UTC)
Received: from [10.45.225.30] (unknown [10.45.225.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC3EC195609D;
	Tue, 15 Jul 2025 14:10:14 +0000 (UTC)
Message-ID: <c2a337b9-8036-49cb-a9ff-9471bcd66c6f@redhat.com>
Date: Tue, 15 Jul 2025 16:10:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] dpll: zl3073x: Add support to get/set esync
 on pins
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250710153848.928531-1-ivecera@redhat.com>
 <20250710153848.928531-2-ivecera@redhat.com>
 <c954b60d-130e-4acb-9390-3e632803413d@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <c954b60d-130e-4acb-9390-3e632803413d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On 15. 07. 25 2:52 odp., Paolo Abeni wrote:
> On 7/10/25 5:38 PM, Ivan Vecera wrote:
>> +static int
>> +zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
>> +				  void *pin_priv,
>> +				  const struct dpll_device *dpll,
>> +				  void *dpll_priv, u64 freq,
>> +				  struct netlink_ext_ack *extack)
>> +{
>> +	struct zl3073x_dpll *zldpll = dpll_priv;
>> +	struct zl3073x_dev *zldev = zldpll->dev;
>> +	struct zl3073x_dpll_pin *pin = pin_priv;
>> +	u32 esync_period, esync_width, output_div;
>> +	u8 clock_type, out, output_mode, synth;
>> +	u32 synth_freq;
>> +	int rc;
> 
> Minor nit: please respect the reverse christmas tree order above.
> 

Will fix

>> +
>> +	out = zl3073x_output_pin_out_get(pin->id);
>> +
>> +	/* If N-division is enabled, esync is not supported. The register used
>> +	 * for N-division is also used for the esync divider so both cannot
>> +	 * be used.
>> +	 */
>> +	switch (zl3073x_out_signal_format_get(zldev, out)) {
>> +	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
>> +	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
>> +		return -EOPNOTSUPP;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	guard(mutex)(&zldev->multiop_lock);
>> +
>> +	/* Read output configuration into mailbox */
>> +	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
>> +			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Read output mode */
>> +	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_MODE, &output_mode);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Select clock type */
>> +	if (freq)
>> +		clock_type = ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC;
>> +	else
>> +		clock_type = ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL;
>> +
>> +	/* Update clock type in output mode */
>> +	output_mode &= ~ZL_OUTPUT_MODE_CLOCK_TYPE;
>> +	output_mode |= FIELD_PREP(ZL_OUTPUT_MODE_CLOCK_TYPE, clock_type);
>> +	rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_MODE, output_mode);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* If esync is being disabled just write mailbox and finish */
>> +	if (!freq)
>> +		goto write_mailbox;
>> +
>> +	/* Get synth attached to output pin */
>> +	synth = zl3073x_out_synth_get(zldev, out);
>> +
>> +	/* Get synth frequency */
>> +	synth_freq = zl3073x_synth_freq_get(zldev, synth);
>> +
>> +	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_DIV, &output_div);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Compute and update esync period */
>> +	esync_period = synth_freq / (u32)freq / output_div;
> 
> Here there is no check for output_div != 0, while such check is present
> into zl3073x_dpll_output_pin_esync_get(). Either is needed here, too, or
> should be dropped from the 'getter'.

Will add it here...

Thanks Paolo...

I.


