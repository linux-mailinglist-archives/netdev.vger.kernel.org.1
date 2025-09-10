Return-Path: <netdev+bounces-221669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBAAB517F0
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 727637BA380
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57364306B33;
	Wed, 10 Sep 2025 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzPp3qhs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E415315765
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511022; cv=none; b=Ns8vueyYqO5SB2tSzHiTURziLPX+GHxOF1jih5bEfeLLtPuyr933z3r2RJfUD0P2FtZXytC3g1qDArKpkUOuVrszq5C2e9sUd3WZaNP+UUTo71VjqSG6s0NefUDQUQ2qNXTlceuhs1sWKE0R9zYWAYDJKMIkAVbHFPbbJjPJduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511022; c=relaxed/simple;
	bh=6x+Vpsnc+xkOPq71Wuxf8fF0DuLDPVUnbFe36/ataco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbNghCuTN/V0E4JH8te3HXFdbWKVP2K5/q0QE1nS/UaTsk7LnbMHr1JWKW9OJi9NBszUUMVlQfKq4Rz5N+FKZVKspwmMLEmvnxvpWz68NyOyZqYWhIx5Im1lsWWdFARFmta0ZU4tf6IO/3p9clCKmq9YLSfZoB8dJPINw8rjYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzPp3qhs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757511019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcLbP4DZN3vOin6ohkFEHicNsZylVtQfBbadWvWw0qU=;
	b=FzPp3qhsrMwDJeaHkRM4+DQ6mWx8SXJse2KS7Ip5qt5RF1sSpxsp9ptDfRKeaJPye89Yel
	QXZOcf1In4WtUmaDztp+XrovZYES/c5FHF5m84cbLEKmIAfV9sVtPLQC2uqyFjyWBMmRZN
	EzXOHpTxmLkPkJa4M0yP/yDewIPnqP0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-Qco1AUOeNTKTj_Gg18lhGQ-1; Wed,
 10 Sep 2025 09:30:16 -0400
X-MC-Unique: Qco1AUOeNTKTj_Gg18lhGQ-1
X-Mimecast-MFC-AGG-ID: Qco1AUOeNTKTj_Gg18lhGQ_1757511013
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE6E01800590;
	Wed, 10 Sep 2025 13:30:11 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EC3D1800579;
	Wed, 10 Sep 2025 13:30:07 +0000 (UTC)
Message-ID: <b9be10d5-16de-4ad5-80eb-df28c5b5ae29@redhat.com>
Date: Wed, 10 Sep 2025 15:30:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dpll: zl3073x: Allow to use custom phase measure
 averaging factor
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250910103221.347108-1-ivecera@redhat.com>
 <5ca46c45-96c3-4ad8-b00a-2494ae12d88b@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <5ca46c45-96c3-4ad8-b00a-2494ae12d88b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On 10. 09. 25 2:34 odp., Vadim Fedorenko wrote:
> On 10.09.2025 11:32, Ivan Vecera wrote:
>> The DPLL phase measurement block uses an exponential moving average,
>> calculated using the following equation:
>>
>>                         2^N - 1                1
>> curr_avg = prev_avg * --------- + new_val * -----
>>                           2^N                 2^N
>>
>> Where curr_avg is phase offset reported by the firmware to the driver,
>> prev_avg is previous averaged value and new_val is currently measured
>> value for particular reference.
>>
>> New measurements are taken approximately 40 Hz or at the frequency of
>> the reference (whichever is lower).
>>
>> The driver currently uses the averaging factor N=2 which prioritizes
>> a fast response time to track dynamic changes in the phase. But for
>> applications requiring a very stable and precise reading of the average
>> phase offset, and where rapid changes are not expected, a higher factor
>> would be appropriate.
>>
>> Add devlink device parameter phase_offset_avg_factor to allow a user
>> set tune the averaging factor via devlink interface.
>>
>> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> [...]
> 
>> +static int
>> +zl3073x_devlink_param_phase_avg_factor_set(struct devlink *devlink, 
>> u32 id,
>> +                       struct devlink_param_gset_ctx *ctx,
>> +                       struct netlink_ext_ack *extack)
>> +{
>> +    struct zl3073x_dev *zldev = devlink_priv(devlink);
>> +    u8 avg_factor, dpll_meas_ctrl;
>> +    int rc;
>> +
>> +    /* Read DPLL phase measurement control register */
>> +    rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, &dpll_meas_ctrl);
>> +    if (rc)
>> +        return rc;
>> +
>> +    /* Convert requested factor to register value */
>> +    if (ctx->val.vu8 < 15)
>> +        avg_factor = ctx->val.vu8 + 1;
>> +    else
>> +        avg_factor = 0;
>> +
> 
> This looks like avg_factor = (ctx->val.vu8 + 1) & 0x0f;
> The same logic can be applied for get() function assuming we are aware of
> unsigned roll-over...

Yes, I know about this trick but I wanted to use more readable code and
leave potential optimization to the compiler.

Ivan


