Return-Path: <netdev+bounces-296650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0SZ/EojoJmqgmwIAu9opvQ
	(envelope-from <netdev+bounces-296650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:06:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCA26587E5
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:06:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Kfzda56T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296650-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296650-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45337312A194
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD2E26ED3C;
	Mon,  8 Jun 2026 15:48:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E52AE8D
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:48:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933701; cv=none; b=uJtMw5UtdwQvFrYvulFhVYjQRiSy7YzaNrAi7J/7lIZw83J8CPvfSUh0OhUxULvtTZqTAWtj25+KOSwrbpbCqvpLKwm3k83EnTSxNXhFSmvILf1RLjdwjOaSvG5byVzip+n04WpF/Phn/mJ0tOCNWsyEF1MpGb2G84/3DrEUKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933701; c=relaxed/simple;
	bh=gXWiAR3eG1hw3O6lLoirp5wSX06NvOORpD7MunpI880=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uz7GuSEa5OPbu5fj2KFf5mf+A7c82YSJNWMPUKFqL9KuHaQpJIPCe7yKdLHuBegXHCDvwFBTxN8+4xrFSTb8sgv5ZZJn2PIFoDupQVdZOkGlSoTwuAGOX9J/DLPh1634lzmQRR2Zg+cEF1Ve9Aga2GolQAKSnHidgm4TJ/XTQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kfzda56T; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780933699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQZZjnNUgN0/UHamiYqEX7QtlS2rp32rDzK8Diz0cFA=;
	b=Kfzda56Tw2UZJZoeFHRo8cjg+PblLXkWAvqFawo3Mvc4uRJ3ZidWofUhxVHMyOxFUVJnGj
	kB9eYu0AtyitThiuUfvaPh8jensN+9GZyrnRiMaTQ5bdG2G7qM/RDF/5shqzbLOj5WjqyT
	smUHJXFfZ9lVYHZ802UNor9Lxvrruhk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-lxBG658nMNS8ALq4SlugEQ-1; Mon,
 08 Jun 2026 11:48:14 -0400
X-MC-Unique: lxBG658nMNS8ALq4SlugEQ-1
X-Mimecast-MFC-AGG-ID: lxBG658nMNS8ALq4SlugEQ_1780933693
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FCC1180075E;
	Mon,  8 Jun 2026 15:48:12 +0000 (UTC)
Received: from [10.44.32.246] (unknown [10.44.32.246])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60DF31800370;
	Mon,  8 Jun 2026 15:48:08 +0000 (UTC)
Message-ID: <b5853501-969a-4ac3-8aff-83c9da9c9834@redhat.com>
Date: Mon, 8 Jun 2026 17:48:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Jiri Pirko <jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 "Schmidt, Michal" <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 "Vaananen, Pasi" <pvaanane@redhat.com>, "Oros, Petr" <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <CH0PR11MB5394BA7DB19301ECD5F9B0139B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CH0PR11MB5394BA7DB19301ECD5F9B0139B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296650-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:arkadiusz.kubalewski@intel.com,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDCA26587E5

On 6/8/26 4:43 PM, Kubalewski, Arkadiusz wrote:
>> From: Ivan Vecera <ivecera@redhat.com>
>> Sent: Sunday, May 31, 2026 9:44 PM
>> ...
>>        -
>>          name: gnss
>>          doc: GNSS recovered clock
>> +      -
>> +        name: int-nco
>> +        doc: |
>> +          Device internal numerically controlled oscillator.
>> +          When connected as a DPLL input, the DPLL enters NCO mode
>> +          where the output frequency is adjusted by the host via
>> +          the PTP clock interface.
> 
> Hi Ivan!
> 
> How would you control this in case of automatic mode dpll?
> Automatic mode DPLL shall be controlled on HW level, such pin brakes
> that rule and requires some driver magic to show it is higher
> priority then the rest of the pins?

The NCO pin can be connected only in manual mode. In other words a DPLL
in automatic mode cannot select NCO pin (switch to NCO mode) by its own.

If the DPLL device is in automatic mode then a user has to switch the
device to manual mode and then manually set the NCO pin as connected.

> Such NCO mode/pin is designed only for this single specific use case
> where a timecard contains a DPLL and PHC?

This is designed for a HW where DPLL channels (devices) support ToD
counters (can act as PHC besides DPLL functionality) and support the
mode where DPLL is not locked to any physical input and allows tuning
of its frequency.

> Any diagram?
> 
> Is there any other use case for such pin? (NCO is rather a general
> DPLL control mechanism?) Shouldn't it be called explicitly like
> ptp-nco?
I discussed this with Jiri and result was:
- DPLL_MODE is input selection strategy
- NCO is a case of manual selection strategy

And *_INT_PTP_NCO or *_PTP_NCO?

Yes, this could be reasonable... I can't think of anything else to use
other than PTP... for now (can be changed in future).

Thanks,
Ivan


