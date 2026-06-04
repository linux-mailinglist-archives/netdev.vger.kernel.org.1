Return-Path: <netdev+bounces-295294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7M1BDtKUIWozJQEAu9opvQ
	(envelope-from <netdev+bounces-295294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:08:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2FD641394
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:08:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=S0wXq46T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295294-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295294-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45F2A30E0E1B
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E48305671;
	Thu,  4 Jun 2026 14:57:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218783033DE
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:57:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585074; cv=none; b=Vhl+/OTxA7utYw+0mpSZqJcJMeDujsoVIwZ8dXa/cgn8CZtWU86qbqVjNJtH1ahAzvaVbAPzKSLAfrB7V3CVGhApLLFF09TPfFqcWvKTIjrgNr0aKVxtlW68zdxPyWu59pv+nakOzSOqiHkoM5OJO50CC2h9FqkodV8dYOBGnvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585074; c=relaxed/simple;
	bh=o9UXxMYdY0WvCiPyBbAMkXmO2+fN1JZrlFMmoUWsUhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZlR3xyem767Labuicn53qdI7/XgTX3QhBjz4SwphJ/+C6vCsAGBif8NlqFYxm/1yoyG/Z14Os0fSOp23RfLNv+Z+hEQsESIVTB62FRxvVT2/ZHvuaLNY2NJUqr9OfFUbJw2mvA/HHolHzSP/sAtvwZecrRBnQlGY05Mu/PiY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0wXq46T; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780585072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3g3EIKMkRGmHVm4qeCIejvJKEgg0irayPWEuc7aC1Ag=;
	b=S0wXq46TYTAmHHKAghmtJmoOh/EVD0g54D43lRKS46o3HkNry78Xex+KS6MI7DJ8zPllC7
	sRLoA3qLdxQTt0XCUGceBShcbuBV/xT7qsXZ13VvT9zIJGmDj3bVdIegU/A7vhueAbXsN9
	wiTADyEEkf6Tp08zivyETEl87WYJH8U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-9WKG0g7PNzSot_sOaysypw-1; Thu,
 04 Jun 2026 10:57:47 -0400
X-MC-Unique: 9WKG0g7PNzSot_sOaysypw-1
X-Mimecast-MFC-AGG-ID: 9WKG0g7PNzSot_sOaysypw_1780585066
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95F89180059F;
	Thu,  4 Jun 2026 14:57:45 +0000 (UTC)
Received: from [10.44.49.177] (unknown [10.44.49.177])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F97B1766;
	Thu,  4 Jun 2026 14:57:41 +0000 (UTC)
Message-ID: <2960f14c-df57-4cb8-a7e5-4b715e475b13@redhat.com>
Date: Thu, 4 Jun 2026 16:57:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/4] dpll: zl3073x: add per-DPLL serialization
 lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-4-ivecera@redhat.com>
 <20260603184046.4c834317@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260603184046.4c834317@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295294-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,davemloft.net,gmail.com,google.com,resnulli.us,redhat.com,microchip.com,kernel.org,linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB2FD641394

On 6/4/26 3:40 AM, Jakub Kicinski wrote:
> On Sun, 31 May 2026 21:44:22 +0200 Ivan Vecera wrote:
>> Add a per-DPLL mutex that serializes all operations on a given DPLL
>> channel across DPLL netlink callbacks, the periodic kthread worker,
> 
> Sounds like there are already two entities accessing the state?
> If so why is this not a fix?

Yes, but prior NCO pin implementation (patch 4) this was not a problem.

1. All DPLL callbacks are serialized by the DPLL subsys mutex and they
- read status and measurements from cache (ref, chan, out and synth)
- writes config into HW and cache

2. Periodic function
- reads config from cache (...)
- reads status and measurements from HW and writes to cache (...)
- emits notifications when something was changed

All accesses to cache objects' fields are atomic.

With patch 4 there is a change because at least df_offset can be written
by both (DPLL callback during switching or periodic function during
measurement). At this point it is reasonable and safe to do explicit
locking on DPLL level.

And the next series I have in my queue (that depends on this series)
introduces the PHC support into zl3073x and there will be a need to
serialize DPLL and PTP callbacks.

Thanks,
Ivan


