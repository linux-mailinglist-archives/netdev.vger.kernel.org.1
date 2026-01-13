Return-Path: <netdev+bounces-249548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADC5D1ADDE
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 744133068DC6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28765343D78;
	Tue, 13 Jan 2026 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dz19fCc5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B606D34E776
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329540; cv=none; b=OgrR11jJD8zyUUIlNcVIsMFnA2tSTir6YbVU4c/y+rovfLk/04rJ4pgWVzkvd4ieUHs07s67z3p7OBTqTgPU0L747TQOMggxXPuiLrPNOXrmf+d10mZmV7EdhmtotgeZvtSMTWs3wyjUa0P/m0tPkE2D/1zuRR7JO42JV+Weq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329540; c=relaxed/simple;
	bh=T3XklyHmi0zL6Hq6XVLpoC/iYJ/hpCdZU4WmsKgj6ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAcFbaaX7/JxcyeekpyiKe0MKeLBKPrJn+BAWTq5blbJdb4HT4QaILFpC7/D/8JxSvfZvcNki/bzKDFSR/wi1nllTexX3aGSE43yoHgBh7H4aUyRNLLp84gMOP9KPapHtAY/oPv0HvsPT1z3cGhIVKrAnEwEGsWplukKlFATzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dz19fCc5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768329535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYLQ9pb7mDbdjvW5qFhZLjZCZDcUydviJ4/haXg7EfY=;
	b=dz19fCc5bQaVRpNgV8KYpNzTnaUJnSQnE8/DzWHs6AOsKyxS9ocy9g3ARZDVi6x8QkD8wF
	ls8wJIjF6Kuuy+Mg8EcC5i9HxvNS303WH2Q14Ih5ysLEPvIOt8yPLrQdSRUvd3yXKlkvxK
	uDr+AqhYsaZOzGIayWKNe3j6RuN7oDY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-M2IR8reHOdyts1QFqy7SpA-1; Tue,
 13 Jan 2026 13:38:50 -0500
X-MC-Unique: M2IR8reHOdyts1QFqy7SpA-1
X-Mimecast-MFC-AGG-ID: M2IR8reHOdyts1QFqy7SpA_1768329528
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 556541800610;
	Tue, 13 Jan 2026 18:38:48 +0000 (UTC)
Received: from [10.44.32.45] (unknown [10.44.32.45])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AEF1B30001A2;
	Tue, 13 Jan 2026 18:38:44 +0000 (UTC)
Message-ID: <cb8e4434-7a34-4580-a830-a9e79c049c94@redhat.com>
Date: Tue, 13 Jan 2026 19:38:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] dpll: add dpll_device op to set working
 mode
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>
References: <20260113121636.71565-1-ivecera@redhat.com>
 <20260113121636.71565-3-ivecera@redhat.com>
 <c5a1f45f-542e-4280-a601-ae96f2d1cac4@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <c5a1f45f-542e-4280-a601-ae96f2d1cac4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 1/13/26 6:47 PM, Vadim Fedorenko wrote:
> On 13/01/2026 12:16, Ivan Vecera wrote:
>> Currently, userspace can retrieve the DPLL working mode but cannot
>> configure it. This prevents changing the device operation, such as
>> switching from manual to automatic mode and vice versa.
>>
>> Add a new callback .mode_set() to struct dpll_device_ops. Extend
>> the netlink policy and device-set command handling to process
>> the DPLL_A_MODE attribute.  Update the netlink YAML specification
>> to include the mode attribute in the device-set operation.
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>> v2:
>> * fixed bitmap size in dpll_mode_set()
> 
> [...]
> 
>> +static int
>> +dpll_mode_set(struct dpll_device *dpll, struct nlattr *a,
>> +          struct netlink_ext_ack *extack)
>> +{
>> +    const struct dpll_device_ops *ops = dpll_device_ops(dpll);
>> +    enum dpll_mode mode = nla_get_u32(a), old_mode;
>> +    DECLARE_BITMAP(modes, DPLL_MODE_MAX + 1) = { 0 };
> 
> this one breaks reverse xmas tree order.

oops, my bad :-(

> with this fixed:
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

will fix... thanks for pointing this out.

Ivan


