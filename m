Return-Path: <netdev+bounces-293127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LmPO4uXGWrVxggAu9opvQ
	(envelope-from <netdev+bounces-293127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:41:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A7B602FC3
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE11230C011B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB86A33B6C9;
	Fri, 29 May 2026 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+o5Ic8w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D1330B09
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061866; cv=none; b=iMfNEo4yJZg3Ebj8aIDuI/cZre7iidnX2wuhX08NjheF5legH4My0dWKRgI9S+U3JPDzKCEgSE4a7cGAUsT2Y+RrpjLWRhFds1LIEnNS7xhj6CvSFwe3sFbSVYvs5OoyMQpbDGOiWfEylnBTjagywbnBdyPR2QlyKcubcUXuxyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061866; c=relaxed/simple;
	bh=HBwzeHsQGXLIwUmMdkg94+SWWaGkRZMu5f0/X3LWr0M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XY5hJ+nAxRurFz07ne3fnHYWdoMhAz10hseVqvBT9LLKgzsam2dJxqiRYVUUbSZmeCdKrKidmMrPTtjjXUuHTTqupVqYTlL/d3xlq4Rh2Z5am0B8CRXck0vkfwQILr2Z2Yy8zImyVeQFrpZNyEMEkSgIh4NwxYyITSTpuPJxeSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+o5Ic8w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780061864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smhejs6fWqL6ERRhW1Bqm9utgrRekBtYZKQntnJMRVE=;
	b=R+o5Ic8wSAAXGh25hnf4kxkhQZ4ESVGPleN1+2xNykYSMjQDIIqZt2/UsTT8mmIL4lgL5W
	MDnDIfksX2y7GRpviCKqNQdMCxqZvBsl3EK1MRMD+rXzWfVWygnAN3V6yC7NetROOaaVgv
	/8ODJoMId1v67bLTFgefAOnnv5DiR5A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-UBwEWF4gPY-X-swh9CUnQQ-1; Fri,
 29 May 2026 09:37:41 -0400
X-MC-Unique: UBwEWF4gPY-X-swh9CUnQQ-1
X-Mimecast-MFC-AGG-ID: UBwEWF4gPY-X-swh9CUnQQ_1780061859
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB6CB180061F;
	Fri, 29 May 2026 13:37:38 +0000 (UTC)
Received: from [10.44.32.215] (unknown [10.44.32.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5D88180075C;
	Fri, 29 May 2026 13:37:33 +0000 (UTC)
Message-ID: <ba2db5bb-9016-406a-afb5-ce8abdc02d36@redhat.com>
Date: Fri, 29 May 2026 15:37:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/4] dpll: add NCO pin type and zl3073x
 support
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260527161241.86655-1-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260527161241.86655-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293127-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 71A7B602FC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 6:12 PM, Ivan Vecera wrote:
> Add a new DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
> the NCO mode of a DPLL and implement support for it in the zl3073x driver.
> 
> Patch 1 adds the new pin type to the DPLL netlink spec and UAPI header.
> 
> Patch 2 replaces the single 2s poll timeout with per-operation timeouts
> based on Microchip proprietary source code and own measurement.
> 
> Patch 3 adds a per-DPLL serialization mutex taken by all DPLL callbacks
> and the periodic worker, establishing a single lock that protects all
> per-channel state. The chan_state_update() call is moved under this lock.
> 
> Patch 4 adds a virtual NCO input pin to the zl3073x driver that allows
> userspace to switch a DPLL channel into NCO mode. The pin reports
> connected/active state when the channel is in NCO mode and handles
> the hardware-specific details of mode transitions including automatic
> df_offset capture and 1PPS phase preservation.
> 
> Changes:
> v4:
>    - New patch 2: per-operation poll timeouts
>    - New patch 3: per-DPLL serialization lock
>    - See individual patches for detailed changelogs.
> v3:
>    - fixed SoB position
> v2:
>    - See individual patches for detailed changelogs.
> 
> Ivan Vecera (4):
>    dpll: add DPLL_PIN_TYPE_INT_NCO pin type
>    dpll: zl3073x: use per-operation poll timeouts
>    dpll: zl3073x: add per-DPLL serialization lock
>    dpll: zl3073x: add NCO virtual input pin
> 
>   Documentation/netlink/specs/dpll.yaml |  13 +
>   drivers/dpll/dpll_nl.c                |   2 +-
>   drivers/dpll/zl3073x/chan.c           | 102 +++++-
>   drivers/dpll/zl3073x/chan.h           |  48 +++
>   drivers/dpll/zl3073x/core.c           |  47 ++-
>   drivers/dpll/zl3073x/core.h           |  10 +-
>   drivers/dpll/zl3073x/dpll.c           | 495 ++++++++++++++++++++++----
>   drivers/dpll/zl3073x/dpll.h           |   4 +
>   drivers/dpll/zl3073x/regs.h           |   9 +
>   include/uapi/linux/dpll.h             |   4 +
>   10 files changed, 628 insertions(+), 106 deletions(-)
> 
> 
> base-commit: aa064a614efcfa4c300609d1f01134e99a12ad10

After merge of "[PATCH net 0/3] dpll: zl3073x: various fixes", this
series is not applicable anymore.

Will send v5 after adjustment.

Ivan


