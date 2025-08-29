Return-Path: <netdev+bounces-218313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDA9B3BE8B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963FD16743D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3872C2E7F08;
	Fri, 29 Aug 2025 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bx08KVrj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3921C84DE
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479067; cv=none; b=BHbh+kZ5X9bG3nPlSMeGHUmbPaheOoxsCEicRLuP/4tHZwAVVZZJh9+/Kgb5Ji5EC6hEY/A617ACmfhM846qHU/nqM/DXWQ7ZlNfodUgEdxxAIkoFQmbKmgbbbH1shVygxqf9kB0nKJu+79qxWle9+fDC70LZVdfO5rdLv3u+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479067; c=relaxed/simple;
	bh=WL89je6DiiHJ8zm1KAPw9gHwmNQbwHiX8qux5ytnaN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgJDKr4+OViqz5mxh9vUJNU7zLyBHk77Opb4jw6Vh2zlIijKupQUlEKVaLnXqZqZvwNhyo9ZOMWQ+J3JzsCGFZV17qHFwDVSVyYNEZ971ToWvwdUUsdnSQDuVOAASEHkRgo9bG5MCm4z7RwKiy0eV1c+bljfGPUdWIpdnzQXYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bx08KVrj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756479061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/Pipyb1To1Nv+/AeyJWgr3lnBnGQR9EAX0GXEeG6L4=;
	b=Bx08KVrjU0+TNL8lMxJly/gJVrXAhucHQhtjvDNEQ817AuERRFlJD85ofEIY03rYxyQXRS
	nLO7QKUACatx6KXrjFs1kfwNuS8yeLykvGFGK6PKb5+3gcfMmVYMsZ4RrDEOl5KruSx2D1
	0hsTy7AwMlTwWTVY0QfLP4TZNh4ICtI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-auVmEHmVPW2ZCpfzvdh58g-1; Fri,
 29 Aug 2025 10:49:30 -0400
X-MC-Unique: auVmEHmVPW2ZCpfzvdh58g-1
X-Mimecast-MFC-AGG-ID: auVmEHmVPW2ZCpfzvdh58g_1756478968
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 435261800446;
	Fri, 29 Aug 2025 14:49:28 +0000 (UTC)
Received: from [10.45.224.190] (unknown [10.45.224.190])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A06830001B5;
	Fri, 29 Aug 2025 14:49:23 +0000 (UTC)
Message-ID: <e7a5ee37-993a-4bba-b69e-6c8a7c942af8@redhat.com>
Date: Fri, 29 Aug 2025 16:49:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] dpll: zl3073x: Implement devlink flash
 callback
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20250813174408.1146717-1-ivecera@redhat.com>
 <20250813174408.1146717-6-ivecera@redhat.com>
 <20250818192943.342ad511@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250818192943.342ad511@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Jakub,

On 19. 08. 25 4:29 dop., Jakub Kicinski wrote:
> On Wed, 13 Aug 2025 19:44:08 +0200 Ivan Vecera wrote:
>> +	struct zl3073x_dev *zldev = devlink_priv(devlink);
>> +	struct zl3073x_fw_component *util;
>> +	struct zl3073x_fw *zlfw;
>> +	int rc = 0;
>> +
>> +	/* Load firmware */
> 
> Please drop the comments which more or less repeat the name
> of the function called.

Will do.

>> +	zlfw = zl3073x_fw_load(zldev, params->fw->data, params->fw->size,
>> +			       extack);
>> +	if (IS_ERR(zlfw))
>> +		return PTR_ERR(zlfw);
>> +
>> +	util = zlfw->component[ZL_FW_COMPONENT_UTIL];
>> +	if (!util) {
>> +		zl3073x_devlink_flash_notify(zldev,
>> +					     "Utility is missing in firmware",
>> +					     NULL, 0, 0);
>> +		rc = -EOPNOTSUPP;
> 
> I'd think -EINVAL would be more appropriate.
> If you want to be fancy maybe ENOEXEC ?

OK, will use -ENOEXEC.

>> +		goto error;
>> +	}
>> +
>> +	/* Stop normal operation during flash */
>> +	zl3073x_dev_stop(zldev);
>> +
>> +	/* Enter flashing mode */
>> +	rc = zl3073x_flash_mode_enter(zldev, util->data, util->size, extack);
>> +	if (!rc) {
>> +		/* Flash the firmware */
>> +		rc = zl3073x_fw_flash(zldev, zlfw, extack);
> 
> this error code seems to be completely ignored, no?

Yep, you are right, this should be propagated to the caller.

>> +		/* Leave flashing mode */
>> +		zl3073x_flash_mode_leave(zldev, extack);
>> +	}
>> +
>> +	/* Restart normal operation */
>> +	rc = zl3073x_dev_start(zldev, true);
>> +	if (rc)
>> +		dev_warn(zldev->dev, "Failed to re-start normal operation\n");
> 
> And also we can't really cleanly handle the failure case.
> 
> This is why I was speculating about implementing the down/up portion
> in the devlink core. Add a flag that the driver requires reload_down
> to be called before the flashing operation, and reload_up after.
> This way not only core handles some of the error handling, but also
> it can mark the device as reload_failed if things go sideways, which
> is a nicer way to surface this sort of permanent error state.

This makes sense... The question is if this should reuse existing
.reload_down and .reload_up callbacks let's say with new devlink action
DEVLINK_RELOAD_ACTION_FW_UPDATE or rather introduce new callbacks
.flash_update_down/_up() to avoid confusions.

Thanks,
Ivan


