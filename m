Return-Path: <netdev+bounces-218839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D900FB3EC3E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9493D444EBB
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7DD2EC080;
	Mon,  1 Sep 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhIzjYA3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896851E2853
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744471; cv=none; b=byPzYI3/iATCpnhMfirNqx9ABNXdAY6/bcZUS/9ud6vxVoh1FpV9fHijg53+b6NoIWtc6cf1gv2g++SrZXRaaoAsPsVLHKch6EFsFGGWBSnzgOqKbffNCpzGoxUWhnZk+4Er2dyGpsRINR9CsW8tueIkfIPUREse3sqxGMlqyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744471; c=relaxed/simple;
	bh=aWny5m6Wqz1CRg5geT1nOdfOifoEJVrWBp+q4CMHEPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgRJBCn1+J83ykCFlHVzTg0g5qq32/PUUDe1JvC0HwJvC1iW6/BXwXlHmFZv9lzBTae6IsgVYXI4mhbqevom+D/Y64rcokKDFfx/T/BBhALnDaa/QPVgf7KajedZACt/6s80ORn31qmPHGLpBno/oJA4eZSotNmh8Fdtysvnw3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HhIzjYA3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756744466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oU/qMtZcyC8i4LZR6Q/18FupAVEqnteAX6wqUkmR8s4=;
	b=HhIzjYA3/TklirdbLRRp/tRzn9J0EG7H24WnlYxbak1yE6cUT+vhULbVRq8F/DDrlgBz3x
	ChvOYaDKAb3hJYG1RwemCnRqGhShP1/Fv1h8GhpsGGrSSLkD4ZuDC1mi080iFglKjopR68
	x65kOoU2M49v/4QW2VF6HNQ6PqdwY40=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-qWNZv9x-PcakHwb8E4-A1A-1; Mon,
 01 Sep 2025 12:34:23 -0400
X-MC-Unique: qWNZv9x-PcakHwb8E4-A1A-1
X-Mimecast-MFC-AGG-ID: qWNZv9x-PcakHwb8E4-A1A_1756744461
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F220619560B0;
	Mon,  1 Sep 2025 16:34:20 +0000 (UTC)
Received: from [10.44.32.239] (unknown [10.44.32.239])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 416BF19560AB;
	Mon,  1 Sep 2025 16:34:16 +0000 (UTC)
Message-ID: <e6cd77a7-bc18-4e0c-9536-5fb107ec4db4@redhat.com>
Date: Mon, 1 Sep 2025 18:34:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] dpll: zl3073x: Implement devlink flash
 callback
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20250813174408.1146717-1-ivecera@redhat.com>
 <20250813174408.1146717-6-ivecera@redhat.com>
 <20250818192943.342ad511@kernel.org>
 <e7a5ee37-993a-4bba-b69e-6c8a7c942af8@redhat.com>
 <20250829165638.3b50ea2a@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250829165638.3b50ea2a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Kuba and Jiri,

On 30. 08. 25 1:56 dop., Jakub Kicinski wrote:
> On Fri, 29 Aug 2025 16:49:22 +0200 Ivan Vecera wrote:
>>>> +		/* Leave flashing mode */
>>>> +		zl3073x_flash_mode_leave(zldev, extack);
>>>> +	}
>>>> +
>>>> +	/* Restart normal operation */
>>>> +	rc = zl3073x_dev_start(zldev, true);
>>>> +	if (rc)
>>>> +		dev_warn(zldev->dev, "Failed to re-start normal operation\n");
>>>
>>> And also we can't really cleanly handle the failure case.
>>>
>>> This is why I was speculating about implementing the down/up portion
>>> in the devlink core. Add a flag that the driver requires reload_down
>>> to be called before the flashing operation, and reload_up after.
>>> This way not only core handles some of the error handling, but also
>>> it can mark the device as reload_failed if things go sideways, which
>>> is a nicer way to surface this sort of permanent error state.
>>
>> This makes sense... The question is if this should reuse existing
>> .reload_down and .reload_up callbacks let's say with new devlink action
>> DEVLINK_RELOAD_ACTION_FW_UPDATE or rather introduce new callbacks
>> .flash_update_down/_up() to avoid confusions.
> 
> Whatever makes sense for your driver, for now. I'm assuming both ops
> are the same, otherwise you wouldn't be asking? It should be trivial
> for someone add the extra ops later, and just hook them both up to the
> same functions in existing drivers.

Things are a little bit complicated after further investigation...

Some internal flashing backround first:
The zl3073x HW needs an external program called "flash utility"
to access an internal flash inside the chip. This utility provides
flash API over I2C/SPI bus that is different from the FW API provided
by the normal firmware. So to access the flash memory the driver has
to stop the device's CPU, to load the utility into chip RAM and resume
the CPU to execute the utility. At this point normal FW API is not
accessible so the driver has to stop the normal operation (unregister
DPLL devices, pins etc.). Then it updates flash using flash API and
after flash operations it has to reset device's CPU to restart newly
flashed firmware. Finally when normal FW is available it resumes
the normal operation (re-register DPLL devices etc.).

Current steps in this patch:
1. Load given FW file and verify that utility is present
2. Stop normal operations
3. Stop CPU, download utility to device, resume CPU
4. Flash components from the FW file
5. Unconditionally reset device's CPU to load normal FW
6. Resume normal operations

I found 4 possible options how to handle:

1. Introduce DEVLINK_RELOAD_ACTION_FW_UPDATE devlink action and reuse
    .reload_down/up() callbacks and call them prior and after
    .flash_update callback.

At first glance, it looks the most elegant... The zl3073x driver stops
during .reload_down() normal operation, then in .flash_update will
switch the device to flash mode, performs flash update and finally
during .reload_up() will resume normal operation.

Issues:
- a problematic case, when the given firmware file does not contain
   utility... During .reload_down() this cannot be checked as the
   firmware is not available during .reload_down() callback.
- DEVLINK_RELOAD_ACTION_FW_UPDATE has to be placed in devlink UAPI
   and but this reload action should be handled as internal one as
   there should not be possible to initiate it from the userspace

   e.g. devlink dev reload DEV action fw_update

2. Add new .flash_down/up() or .flash_prepare/done() optional callbacks
    that are called prior and after .flash_update if they are provided by
    a driver.

This looks also good and very similar to previous option. Could resolve
the 1st issue as we can pass 'devlink_flash_update_params' to both
new callbacks, so the driver can parse firmware file during
.flash_down and check for utility presence.

Issues:
- the firmware has to be parsed twice - during .flash_down() and
   .flash_update()
   This could be resolved by extending devlink_flash_update_params
   structure by 'void *priv' field that could be used by a driver
   during flash operation.
   It could be also useful to add flash_failed flag similar to
   reload_failed that would record a status reported by .flash_up()
   callback.

3. Keep my original approach but without restarting normal operation
    (re-register DPLL devices and pins). User has to use explicitly
    devlink reload fw_activate to restart normal operation.

This could be reasonable but introduces some kind of asymmetry because
the driver stops normal operation during .flash_update() and left
the device in intermediate state (devlink interface is working but
DPLL devices and pins are not registered). Only upon explicit user
request (fw_activate) would it restore normal mode (re-registration).

4. Keep my original approach, fix the ignored error code reported by
    Jakub and pass "re-start normal operation failure" via devlink
    notification.

 From my POV better than previous one as the driver will do its best to
resume device state prior the flashing. Only corner case where the
firmware is unresponsive after reset will cause that normal operation
won't be resumed -> could be handled by health reporting?

Thanks for opinions and advises.

Ivan


