Return-Path: <netdev+bounces-288452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CI1A6mIB2ol7gIAu9opvQ
	(envelope-from <netdev+bounces-288452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:57:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F46155794A
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DA7D300DDD6
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E2E3EB7E4;
	Fri, 15 May 2026 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+TxcGY6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78023AA1A1
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878590; cv=none; b=BfWbwtgzxKGeKoDdXFZLqDigYbxJVDqqB29//d8QtGPzMFe+48uUkGM5Ayww5A0fmYi6pIPfyiFZvuFCfGWBU/x9hbA0564SvGb79HEvjUUDTB7hvvMk2oaY3ZKWfD8sQN6mzcFVvtX3K+NK4/e8paIxbBWuZJNBg0Mp+XANW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878590; c=relaxed/simple;
	bh=eaaDSseYiP18mck6eeTj+fa5MVa694wwwXP4WP9PGIc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A5qeLZYZeR3telxFrkwoa3xgj99ft21C9bgOaP+axtydOfXkEP/5vSQ4C8mzbXkseJa0Jvfx7DSYduErBAHN1uHQUsPmkc1drLxt7B8+dnXC2/Of69mZPaApTQO4nf+griyu0JUF7iWP2xrYW10DLiRbabCJXMacZoRyKolhSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+TxcGY6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778878587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3Ul3o0lwxWdnZL3SNibJBB119qwNzk1hUHM/1632qo=;
	b=Y+TxcGY6yCPA3b32Q+Yd4q9wMzRtjzkEm6unXmwUxkDv72yqNLMfHR11hkLF0dzSRSafVH
	WkN5HixndSXp98O1WV02nyZ5jvZ4RnHUdBhYtLxCb5aUU87jVXXvQcsN8FzWVVS9VB5+1o
	4SkyZwMe0EpsyRVU2zx7o2hXmdaoSMg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-sN3Ob0v7M8i2r5M9p_6ESw-1; Fri,
 15 May 2026 16:56:24 -0400
X-MC-Unique: sN3Ob0v7M8i2r5M9p_6ESw-1
X-Mimecast-MFC-AGG-ID: sN3Ob0v7M8i2r5M9p_6ESw_1778878582
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 071D9195607A;
	Fri, 15 May 2026 20:56:22 +0000 (UTC)
Received: from [10.44.48.187] (unknown [10.44.48.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D0DF30002DC;
	Fri, 15 May 2026 20:56:17 +0000 (UTC)
Message-ID: <2fb498cc-4d91-4e2e-bb3c-e62155fc6aeb@redhat.com>
Date: Fri, 15 May 2026 22:56:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] dpll: add NCO pin type and zl3073x support
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
References: <20260513145645.175451-1-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260513145645.175451-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 5F46155794A
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-288452-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/13/26 4:56 PM, Ivan Vecera wrote:
> Add a new DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
> the NCO mode of a DPLL and implement support for it in the zl3073x driver.
> 
> Patch 1 adds the new pin type to the DPLL netlink spec and UAPI header.
> 
> Patch 2 adds a virtual NCO input pin to the zl3073x driver that allows
> userspace to switch a DPLL channel into NCO mode. The pin reports
> connected/active state when the channel is in NCO mode and handles
> the hardware-specific details of mode transitions including automatic
> df_offset capture and 1PPS phase preservation.
> 
> Ivan Vecera (2):
>    dpll: add DPLL_PIN_TYPE_INT_NCO pin type
>    dpll: zl3073x: add NCO virtual input pin
> 
>   Documentation/netlink/specs/dpll.yaml |  12 ++
>   drivers/dpll/dpll_nl.c                |   2 +-
>   drivers/dpll/zl3073x/chan.c           |  14 +-
>   drivers/dpll/zl3073x/chan.h           |  24 +++
>   drivers/dpll/zl3073x/core.c           |   7 +
>   drivers/dpll/zl3073x/dpll.c           | 259 ++++++++++++++++++++++----
>   drivers/dpll/zl3073x/dpll.h           |   2 +
>   drivers/dpll/zl3073x/regs.h           |   7 +
>   include/uapi/linux/dpll.h             |   4 +
>   9 files changed, 291 insertions(+), 40 deletions(-)
> 
Sashiko found some issues... will address them in v2.

Ivan


