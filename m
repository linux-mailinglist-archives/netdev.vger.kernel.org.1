Return-Path: <netdev+bounces-249022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8721BD12CF6
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AABB301411A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FD53590AB;
	Mon, 12 Jan 2026 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvCiulux"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D433590A2
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224479; cv=none; b=Ee3YoLdiqNJYvcixi35Kw4IFj8D6Rxbfmf4Lq2PX2SGOezhh1MtyKBsmh5c2Nxyej6ehuvOHJ+IPGWbKT8b3AgNjeoK61a6LWtOTZ7axpf6Ynij+CrM7V1NN3fm5yspMkbekCA/KXqeUXjTzkWtHSr9UTqBeGX3nvZNR+Xs7EnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224479; c=relaxed/simple;
	bh=CIhkC+k7RaKiD70PG/AdFgLlkRDsiqkg0RzEEeTbOZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFzLS/Ql01j/BBQNqAI+jup2z2tWtDHHdVXFh6VbLqc7rOfyeTM4Ga9zXPZokOE1nPizBAJo5OgmEG5GpMBpQOJlVgWK1+aACt0vRMCdFxdX83EYjyPqvocAN1HcPZZlT2GoK/NyismQV8RsAjMjcmtjoE2gzmm30/OVn/Waq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvCiulux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768224477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7Y1CBgqCuAZZw2iqOqkkUlt8FG7Uwmv1KGkQFu9xgo=;
	b=LvCiuluxbdiiGZ8bZLUc0ZJitBZSSyUr5GLFQWSRTXn1FWncvX2sTHw0qH5+4sRFngJne+
	eL8ME6qkh2ywndTzEKbaEnYXqvWy2AJDM9nZOOqst8npuz3aQUyl35imfyzhRmhn3k4b2d
	L3wj1xaClJ4KoxpZtxFtJu0IJJQudY8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-9O5P0g2IPuy8XnmoDvzUqw-1; Mon,
 12 Jan 2026 08:27:53 -0500
X-MC-Unique: 9O5P0g2IPuy8XnmoDvzUqw-1
X-Mimecast-MFC-AGG-ID: 9O5P0g2IPuy8XnmoDvzUqw_1768224472
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EE6F1800610;
	Mon, 12 Jan 2026 13:27:51 +0000 (UTC)
Received: from [10.44.34.128] (unknown [10.44.34.128])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B337018004D8;
	Mon, 12 Jan 2026 13:27:47 +0000 (UTC)
Message-ID: <0db2bd26-07c4-4181-8f83-95d7d2cbd629@redhat.com>
Date: Mon, 12 Jan 2026 14:27:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] dpll: zl3073x: Implement device mode setting
 support
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
References: <20260112101409.804206-1-ivecera@redhat.com>
 <20260112101409.804206-4-ivecera@redhat.com>
 <825dbb02-5e76-45d1-acf6-78bcc2e999c8@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <825dbb02-5e76-45d1-acf6-78bcc2e999c8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 1/12/26 12:37 PM, Vadim Fedorenko wrote:
>> +    if (mode == DPLL_MODE_MANUAL) {
>> +        /* We are switching from automatic to manual mode:
>> +         * - if we have a valid reference selected during auto mode then
>> +         *   we will switch to forced reference lock mode and use this
>> +         *   reference for selection
>> +         * - if NO valid reference is selected, we will switch to forced
>> +         *   holdover mode or freerun mode, depending on the current
>> +         *   lock status
>> +         */
>> +        if (ZL3073X_DPLL_REF_IS_VALID(ref))
>> +            hw_mode = ZL_DPLL_MODE_REFSEL_MODE_REFLOCK;
>> +        else if (zldpll->lock_status == DPLL_LOCK_STATUS_UNLOCKED)
>> +            hw_mode = ZL_DPLL_MODE_REFSEL_MODE_FREERUN;
>> +        else
>> +            hw_mode = ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER;
>> +    } else {
>> +        /* We are switching from manual to automatic mode:
>> +         * - if there is a valid reference selected then ensure that
>> +         *   it is selectable after switch to automatic mode
>> +         * - switch to automatic mode
>> +         */
>> +        struct zl3073x_dpll_pin *pin;
>> +
>> +        pin = zl3073x_dpll_pin_get_by_ref(zldpll, ref);
>> +        if (pin && !pin->selectable) {
>> +            /* Restore pin priority in HW */
>> +            rc = zl3073x_dpll_ref_prio_set(pin, pin->prio);
>> +            if (rc)
>> +                return rc;
> 
> I think it's better to fill-up extack here to give at least some info of
> what's happened?

Will add, thanks for pointing this out.

Ivan


