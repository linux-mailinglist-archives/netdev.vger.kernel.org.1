Return-Path: <netdev+bounces-306618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fpmkDU8PUWpL+wIAu9opvQ
	(envelope-from <netdev+bounces-306618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:27:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7874573C398
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:27:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=G9yCNmRl;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306618-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306618-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9068F303A8D8
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A443644A3;
	Fri, 10 Jul 2026 15:22:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A0257824
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 15:22:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696925; cv=none; b=GPwHRNvdDY1g9r/yBRtUUDxs9XIPUX2/S0r48RlM7brmH+o9ntIJtlffY/xYDc6Ywdce4umYALzaCFTX+Oa3Pigcqfzn96d+MwehVksCBGW0s+/A3ebpG/suPEhsAcxM55gd17IniUgUDMSjiPWVs+Crkd8J5EmCp2YRFy/KOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696925; c=relaxed/simple;
	bh=E02UlOJjRKHWirUaHnm/fAY0sE822rfZSlCOYRt5zZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnFgwVkGEgbQAXFtFiQW4vUrcSEgdZuGRikLWrCElP3MilQ0sxiMGWFxsHDXxQI/Ug6FO14SPiHNCenhfrHa3KW9bKzrX5jy+kaEDg3+EPv3413VAaDFZYNOvGtywRDMdPCbs1zY6We/RPXa1XVk09Wpr7QqZ+eIE4urBIQh1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9yCNmRl; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783696923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YH0OsQ7SG+0r7mMcuKkzz2GVNVtc6VjMrxG1+l0hoI=;
	b=G9yCNmRlQzHzHPW/8FYqW8jke3YbX4wC4Ln728mtpB8ezuobGUPd/aCGN3YU71dp6ShGef
	GofdwNNVyRF/e5jiucWL+7qJN9wTnTs6cQ0O14/L924F4V3F2Qv5ldKkMLIc1etigLVrhD
	r6Oi0N1mVoPRQlANWXa9Q+IzDwLp4t8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-lDIVrXVSMiqxm_mva8bwuQ-1; Fri,
 10 Jul 2026 11:20:05 -0400
X-MC-Unique: lDIVrXVSMiqxm_mva8bwuQ-1
X-Mimecast-MFC-AGG-ID: lDIVrXVSMiqxm_mva8bwuQ_1783696804
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A58521955EBC;
	Fri, 10 Jul 2026 15:20:03 +0000 (UTC)
Received: from [10.44.48.68] (unknown [10.44.48.68])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8509B18005B8;
	Fri, 10 Jul 2026 15:19:59 +0000 (UTC)
Message-ID: <5c633517-048b-4174-bfc2-77eb36868635@redhat.com>
Date: Fri, 10 Jul 2026 17:19:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] dpll: zl3073x: add PTP clock support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260708170527.916035-1-ivecera@redhat.com>
 <20260708170527.916035-3-ivecera@redhat.com>
 <8de7e108-3616-4e02-a7be-243e4cb8563c@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <8de7e108-3616-4e02-a7be-243e4cb8563c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-306618-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:netdev@vger.kernel.org,m:Chris.duQuesnay@microchip.com,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:richardcochran@gmail.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,intel.com,davemloft.net,kernel.org,resnulli.us,redhat.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7874573C398

On 7/10/26 3:08 PM, Vadim Fedorenko wrote:
> On 08/07/2026 18:05, Ivan Vecera wrote:
>> Add PTP clock support for the ZL3073x DPLL driver. A PTP clock device
>> is registered for each DPLL channel that is in NCO mode, providing
>> gettimex64, settime64, adjtime, adjfine and perout callbacks.
> 
> Here we come back to the discussion of NCO mode. Is DPLL channel
> actually a pin (virtual or physical)? If it's not, then it means that
> channel is exposed as independent DPLL device, that shouldn't affect
> other devices, but AFAIU, it can in the current implementation. If it is
> a pin, why do you check device's mode rather then pins?
> 
> And another question - what happens when channel changes its mode to
> non-NCO? Do we have ptp device disappearing from the system?

Hi Vadim,

I understand your point. The PTP code was originally developed before
the NCO pin switching was implemented, when it made sense to split PTP
support into two patches - basic PTP for NCO-only channels (patch 2) and
then extending it to all modes via TIE write (patch 4).

Now that NCO mode can be entered and left dynamically via the NCO pin,
this split no longer makes sense. Having patch 2 register PTP only for
NCO-mode channels creates an awkward intermediate state where a dynamic
NCO switch would require dynamic PTP clock registration/unregistration.

I'll squash patches 1&3 and 2&4 in v2, so the PTP clock is always
registered regardless of the initial channel mode, with per-callback
mode checks.

Thanks,
Ivan


