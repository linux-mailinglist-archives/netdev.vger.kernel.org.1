Return-Path: <netdev+bounces-295296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BWx6AFyYIWpcJgEAu9opvQ
	(envelope-from <netdev+bounces-295296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:23:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE36641620
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:23:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=EL4UDjR8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295296-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295296-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A575C3145341
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC07430E83F;
	Thu,  4 Jun 2026 15:01:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A72BE03C
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 15:01:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585312; cv=none; b=jsouW8xHKoQLUwg7ClxlZn7pk4Qp+L3epyHKx6p2PQykZocmtXetaha42/be0lZrThDYPWK4rJiteMiTgcePUwrYiw73VuZkN7dUxNS5TnFOePNAcnuf65mtZ09en5Euhx/7Atn+amuvTPLJve6TCHSP/yIwsB0V+39tHW8LvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585312; c=relaxed/simple;
	bh=ehEbUvR+UJcR6XatWDW/QJT0VJqLOE4hFSwcuqVvCvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWt3EPi2LdcnR0YftAyUimFoYUMosBnX4bjsOxq4YVkskwPZdD4qv0djgDmbykje+a8GrX2UP7RWaoMCMDiamSN3iL9DEidqyf0ANBvKXafmq/l6qrEFL/LHDMjQie3lPJ/rNSci7OFUbIF0USdPaJ905k05Iv5N9XpiATgSBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EL4UDjR8; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780585309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTDaHYcq+0MiAYLTq0XBseB27+UMmCkCWmlwInNcDcA=;
	b=EL4UDjR8EWEe3BCrQ5pjb0bZh4vLD29rOv9qWdntanZzsKJt5CwK1XNHqBRdYwlhrsjgws
	DIrsVRLKJJy6YbVplpUTUOklMiCUqWUUI588tGBCH9sRbeg6r7sBGRhS5R42FlMDIq5Bp2
	pBoNTqtvTnkEF/xXC6HVr7Lnfw4uoJk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-yLd7EHM9N9-vCl9Me2iPiA-1; Thu,
 04 Jun 2026 11:01:46 -0400
X-MC-Unique: yLd7EHM9N9-vCl9Me2iPiA-1
X-Mimecast-MFC-AGG-ID: yLd7EHM9N9-vCl9Me2iPiA_1780585303
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD5091800586;
	Thu,  4 Jun 2026 15:01:42 +0000 (UTC)
Received: from [10.44.49.177] (unknown [10.44.49.177])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9719D180049F;
	Thu,  4 Jun 2026 15:01:38 +0000 (UTC)
Message-ID: <be19bd30-0bb0-4a22-8932-e62f7678ccc5@redhat.com>
Date: Thu, 4 Jun 2026 17:01:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: Jakub Kicinski <kuba@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Grzegorz Nitka <grzegorz.nitka@intel.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <20260603185037.05f8c6a0@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260603185037.05f8c6a0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295296-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:grzegorz.nitka@intel.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,davemloft.net,gmail.com,google.com,resnulli.us,redhat.com,microchip.com,kernel.org,intel.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AE36641620

On 6/4/26 3:50 AM, Jakub Kicinski wrote:
> On Sun, 31 May 2026 21:44:20 +0200 Ivan Vecera wrote:
>> Add DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
>> the NCO mode of a DPLL. When connected as a DPLL input, the DPLL
>> enters NCO mode where the output frequency is adjusted by the host
>> via the PTP clock interface.
>>
>> Update the fractional-frequency-offset and fractional-frequency-
>> offset-ppt attribute documentation to note that for INT_NCO pins
>> these attributes represent the DPLL's current output frequency
>> offset from its nominal frequency.
>>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> Purely going on intuition here but feels like NCO should be a mode
> (enum dpll_mode) rather than one of the input pins?
> 
> More acks here would be great, Vadim, Arkadiusz, Grzegorz... ?

I had a long discussion with Jiri about this and we agreed finally
that dpll_mode represents a reference (input pin) selection strategy
mode and not a DPLL device running mode.

See [1]

Thanks,
Ivan

[1] 
https://lore.kernel.org/netdev/fda7883e-b502-44dc-97b3-af658a035d0b@redhat.com/


