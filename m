Return-Path: <netdev+bounces-210164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C03B12373
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D9E5A6913
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAA724A06D;
	Fri, 25 Jul 2025 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwj0G464"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727082F002B
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466411; cv=none; b=KJpp1+KuqoXSeSTtgwfTB54vTWF6IOjGcEApOc42i4wKcl5XH+FqLiwmd5qDwt0An+lcXvYHC7rwsJ1DzGcv5LxPKHwjlPwyFXyH2bICWWT3Wp4rUdFKDyukse9JxsWa0h/ihfXf6mTdhFECvrDAZAMYuOwVmGLlokWrQtRtY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466411; c=relaxed/simple;
	bh=M9yg6khhfMMbBT3TVLLeYr6wDb98FZCRGTr4eLOoT6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uh73id2nRfV/GUzGtwzK8Tul5EZ87HFbFpGejFky1qjTCyJGX/JgLPL1tlU6dduMw5hq8M0+noFbJlKY1O3mtc3DHdZlnUOF2Rz5qJOTry4ZmuBrlxd6ND57iUUfpePIb2iCAQvQiW6nkCiy+XwFoalDQeOwnNdsn7PqdotH07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwj0G464; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753466408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNVjF7EPg2u1wPInC0eFaHyp0s+0n/5rTgNPncE3WGU=;
	b=iwj0G464jyfLqW/+wzjdhJ1p2dv9kjyaordLXS6qvy80cUvVBIbKb9doli9B+mXbUGpwyi
	C8o4kjjXbzXO5tC6QhApeWvA08/PWilbbvT0lqxst+7rrcGFhu4dK+K96/DH5n5fThGZoq
	5OMHQ6h8fN+2klVxSa9ryw0MOwUGIic=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-EnlVueOQOqqQjsp94pSHww-1; Fri,
 25 Jul 2025 14:00:06 -0400
X-MC-Unique: EnlVueOQOqqQjsp94pSHww-1
X-Mimecast-MFC-AGG-ID: EnlVueOQOqqQjsp94pSHww_1753466405
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B5751800366;
	Fri, 25 Jul 2025 18:00:04 +0000 (UTC)
Received: from [10.45.224.176] (unknown [10.45.224.176])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB6FF1800359;
	Fri, 25 Jul 2025 18:00:00 +0000 (UTC)
Message-ID: <19fb41dc-4e24-49dc-a095-9e330acc42de@redhat.com>
Date: Fri, 25 Jul 2025 19:59:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] dpll: zl3073x: Add support for devlink flash
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>
References: <20250725154136.1008132-1-ivecera@redhat.com>
 <ea9f9931-95d9-4f7d-abba-eb7fae408977@redhat.com>
 <20250725104231.0307b4d1@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250725104231.0307b4d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Kuba,

On 25. 07. 25 7:42 odp., Jakub Kicinski wrote:
> On Fri, 25 Jul 2025 19:18:55 +0200 Ivan Vecera wrote:
>> Self nacked, need to fix warnings found by clang (not identified by
>> gcc).
> 
> Thanks for the note, I suppose you updated the patchwork state
> yourself? Please prefer using pw-bot commands in networking and bpf.

Will do next time, thanks for the note.

> (BTW net-next is closed already)

Oops, I missed this... will send v2 once the net-next will be open.

Thanks,
Ivan

> Quoting documentation:
> 
>    Updating patch status
>    ~~~~~~~~~~~~~~~~~~~~~
>    
>    Contributors and reviewers do not have the permissions to update patch
>    state directly in patchwork. Patchwork doesn't expose much information
>    about the history of the state of patches, therefore having multiple
>    people update the state leads to confusion.
>    
>    Instead of delegating patchwork permissions netdev uses a simple mail
>    bot which looks for special commands/lines within the emails sent to
>    the mailing list. For example to mark a series as Changes Requested
>    one needs to send the following line anywhere in the email thread::
>    
>      pw-bot: changes-requested
>    
>    As a result the bot will set the entire series to Changes Requested.
>    This may be useful when author discovers a bug in their own series
>    and wants to prevent it from getting applied.
>    
>    The use of the bot is entirely optional, if in doubt ignore its existence
>    completely. Maintainers will classify and update the state of the patches
>    themselves. No email should ever be sent to the list with the main purpose
>    of communicating with the bot, the bot commands should be seen as metadata.
>    
>    The use of the bot is restricted to authors of the patches (the ``From:``
>    header on patch submission and command must match!), maintainers of
>    the modified code according to the MAINTAINERS file (again, ``From:``
>    must match the MAINTAINERS entry) and a handful of senior reviewers.
>    
>    Bot records its activity here:
>    
>      https://netdev.bots.linux.dev/pw-bot.html
>    
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#updating-patch-status
> 


