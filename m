Return-Path: <netdev+bounces-183787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F0FA91F43
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A120119E6F2B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958E525179E;
	Thu, 17 Apr 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzmUb0Df"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D125178E
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899358; cv=none; b=FOtUJJsp2HMGImAlLUk/HWUYSFCD5P7khYLiksSUhUiQmU7azEM+9AWCWawZvrXjTKZxt4n1fHLb/+00C4AXlqCcOLCxYJUFkqrfQElaZDz5dPGyjfdBf7LyYQ1Hq/tEis2Ip2D+Owe3R4vfEIbXPru4jTETqfIzNf+NoGLvz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899358; c=relaxed/simple;
	bh=P9h4O8gdB+tlOXx6aUyTO8Xc61OwjUm9m2At/cnifiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9xHZyGQoE2yl5X+nb9GF5W4u5IEyLEW9DCNMnp+YjRxDUI1GXYKlpGcvuXyOaVHRhD8wrw8nIWw9iKSTmuBAmwSYtTS2PL+lNa+UOsRNbRV0Wuv969RLV0J1J55OHzFsXfcFyMZizt2Mzy/SVF7baKB56Rc/KklNY8GmwGgB4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WzmUb0Df; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744899354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhAPzg/hAd+522tJiICzEiLKQ/EOBtk9V+Wlmbrgn3Y=;
	b=WzmUb0DfEhgjb3/lx0mIs7YlJurTq9abMMGaVF4zJO7siVRMFfhqwyzEcF3PCYZUY9oYE9
	dCEeZyQADv+bB62g+wm1noHFLINALmBn87WALdhys4mXfNhQc8p7D2cS306p59hVw2/dNy
	3pLuufp2IteSwfhxv7cRUZN4TqHgo6Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-tn0r6BnUMEanhjbv4LTkHQ-1; Thu,
 17 Apr 2025 10:15:48 -0400
X-MC-Unique: tn0r6BnUMEanhjbv4LTkHQ-1
X-Mimecast-MFC-AGG-ID: tn0r6BnUMEanhjbv4LTkHQ_1744899344
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2B501955DDE;
	Thu, 17 Apr 2025 14:15:43 +0000 (UTC)
Received: from [10.44.33.28] (unknown [10.44.33.28])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B33C61956095;
	Thu, 17 Apr 2025 14:15:38 +0000 (UTC)
Message-ID: <f9149df7-262e-4420-87b4-79c8a176c203@redhat.com>
Date: Thu, 17 Apr 2025 16:15:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-6-ivecera@redhat.com>
 <d286dec9-a544-409d-bf62-d2b84ef6ecd4@lunn.ch>
 <CAAVpwAvVO7RGLGMXCBxCD35kKCLmZEkeXuERG0C2GHP54kCGJw@mail.gmail.com>
 <e22193d6-8d00-4dbc-99be-55a9d6429730@redhat.com>
 <09c3730a-f6f1-4226-ae29-fe02b1663fe7@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <09c3730a-f6f1-4226-ae29-fe02b1663fe7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On 17. 04. 25 3:27 odp., Andrew Lunn wrote:
>> Anyway, I have a different idea... completely abstract mailboxes from the
>> caller. The mailbox content can be large and the caller is barely interested
>> in all registers from the mailbox but this could be resolved this way:
>>
>> The proposed API e.g for Ref mailbox:
>>
>> int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index,
>>                          struct zl3073x_mb_ref *mb);
>> int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index,
>>                           struct zl3073x_mb_ref *mb);
>>
>> struct zl3073x_mb_ref {
>> 	u32	flags;
>> 	u16	freq_base;
>> 	u16	freq_mult;
>> 	u16	ratio_m;
>> 	u16	ratio_n;
>> 	u8	config;
>> 	u64	phase_offset_compensation;
>> 	u8	sync_ctrl;
>> 	u32	esync_div;
>> }
>>
>> #define ZL3073X_MB_REF_FREQ_BASE			BIT(0)
>> #define ZL3073X_MB_REF_FREQ_MULT			BIT(1)
>> #define ZL3073X_MB_REF_RATIO_M				BIT(2)
>> #define ZL3073X_MB_REF_RATIO_N			 	BIT(3)
>> #define ZL3073X_MB_REF_CONFIG			 	BIT(4)
>> #define ZL3073X_MB_REF_PHASE_OFFSET_COMPENSATION 	BIT(5)
>> #define ZL3073X_MB_REF_SYNC_CTRL			BIT(6)
>> #define ZL3073X_MB_REF_ESYNC_DIV			BIT(7)
>>
>> Then a reader can read this way (read freq and ratio of 3rd ref):
>> {
>> 	struct zl3073x_mb_ref mb;
>> 	...
>> 	mb.flags = ZL3073X_MB_REF_FREQ_BASE |
>> 		   ZL3073X_MB_REF_FREQ_MULT |
>> 		   ZL3073X_MB_REF_RATIO_M |
>> 		   ZL3073X_MB_REF_RATIO_N;
>> 	rc = zl3073x_mb_ref_read(zldev, 3, &mb);
>> 	if (rc)
>> 		return rc;
>> 	/* at this point mb fields requested via flags are filled */
>> }
>> A writer similarly (write config of 5th ref):
>> {
>> 	struct zl3073x_mb_ref mb;
>> 	...
>> 	mb.flags = ZL3073X_MB_REF_CONFIG;
>> 	mb.config = FIELD_PREP(SOME_MASK, SOME_VALUE);
>> 	rc = zl3073x_mb_ref_write(zldev, 5, &mb);
>> 	...
>> 	/* config of 5th ref was commited */
>> }
>>
>> The advantages:
>> * no explicit locking required from the callers
>> * locking is done inside mailbox API
>> * each mailbox type can have different mutex so multiple calls for
>>    different mailbox types (e.g ref & output) can be done in parallel
>>
>> WDYT about this approach?
> 
> I would say this is actually your next layer on top of the basic
> mailbox API. This makes it more friendly to your sub driver and puts
> all the locking in one place where it can easily be reviewed.
> 
> One question would be, where does this code belong. Is it in the MFD,
> or in the subdrivers? I guess it is in the subdrivers.

No, it should be part of MFD because it does not make sense to implement 
API above in each sub-driver separately.

Sub-driver would use this MB ABI for MB access and
zl3073x_{read,write}_u{8,16,32,48} for non-MB registers.

Ivan


