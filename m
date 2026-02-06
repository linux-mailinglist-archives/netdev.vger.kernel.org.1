Return-Path: <netdev+bounces-257573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOM3KxcDhmmyJAQAu9opvQ
	(envelope-from <netdev+bounces-257573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:04:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2373CFF6D1
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3F99304D253
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4127815D;
	Fri,  6 Feb 2026 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8dUYBBO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4122777EA
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390188; cv=none; b=SQ35v6m0b6/v6PvLLeGAlhG4ZBowYhCkGNINUsDPXwrMsah2OpFwf1x66drpp+9afnasGInmva8/rR6W/jROxL4Vy3mO8uFrhZ9Sm31jUO3NMsoNYjZG0QuejzigMtqEx14A0kfxiSeog9K7uyFS74Wo3rPjnBu/dYUaA5cw+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390188; c=relaxed/simple;
	bh=LB7QDEsMXgPCxCjTIXwHVncfd/5iivLKZH1PdJOqVjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb91B17SJKcf0D1bgJtwDr05psdZLtBAUzbUW7Qpx8gnrKbUKqwP6hvyfiHkKu3aYA3Z8kPPMB3vDh4HMGDfNrQx/uoKCsDioEr3pRIshpT8J5hBza33I9oxwlHvAlks6E4ExY5384Ki1Yw5g5UNXRh+tR9nj9UGl5av02U1pEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8dUYBBO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770390187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1i6cAHTv7DBd9mv/VZP++loTThVeud67POkhWzDkRRM=;
	b=R8dUYBBOZ5jGrkDYXYIgScKy1bf7IRGRg/lMz5hGwmNoX1NTLoLNd6JTUKT1qzKHgEnun+
	DgKn5yEYjXBh+kdFHTZZlMpA2tWDhzpX5oQ27VVbL65u7bgG4Pn0WKfzD/qUfKTZX5S72o
	b6UYPctH7eCjSDGo5xLjYonxDAf8K9M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-jXqXJ1jDNOCmbzcpKl7krA-1; Fri,
 06 Feb 2026 10:03:02 -0500
X-MC-Unique: jXqXJ1jDNOCmbzcpKl7krA-1
X-Mimecast-MFC-AGG-ID: jXqXJ1jDNOCmbzcpKl7krA_1770390181
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EB581955F21;
	Fri,  6 Feb 2026 15:03:01 +0000 (UTC)
Received: from [10.44.34.88] (unknown [10.44.34.88])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B12A1800465;
	Fri,  6 Feb 2026 15:02:59 +0000 (UTC)
Message-ID: <ae73b2e5-f008-48c9-a960-c147590b6ac4@redhat.com>
Date: Fri, 6 Feb 2026 16:02:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dpll: zl3073x: Fix output pin phase adjustment sign
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
References: <20260205181055.129768-1-ivecera@redhat.com>
 <d3f6c71c-133d-443a-adee-3430936ff8c5@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <d3f6c71c-133d-443a-adee-3430936ff8c5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-257573-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 2373CFF6D1
X-Rspamd-Action: no action

On 2/6/26 3:04 PM, Vadim Fedorenko wrote:
> On 05/02/2026 18:10, Ivan Vecera wrote:
>> The output pin phase adjustment functions incorrectly negate the phase
>> compensation value.
>>
>> Per the ZL3073x datasheet, the output phase compensation register is
>> simply a signed two's complement integer where:
>>   - Positive values move the phase later in time
>>   - Negative values move the phase earlier in time
>>
>> No negation is required. The erroneous negation caused phase adjustments
>> to be applied in the wrong direction.
>>
>> Note that input pin phase adjustment correctly uses negation because the
>> hardware has an inverted convention for input references (positive moves
>> phase earlier, negative moves phase later).
> 
> Is it common for DPLLs to act this way?

I don't now if this is common for DPLLs but for ZL3073x family chips the
datasheet says:

<cite>
ref_phase_offset_compensation:
==============================
Phase offset compensation for references. The value is specified as a
signed two's complement, in units of ps. A positive value moves the
phase of any DPLL that locks to this reference earlier in time (more to
the left on a scope). A negative value moves the phase of any DPLL that
locks to this reference later in time (more to the right on a scope).

output_phase_compensation:
==========================
Output phase shift, expressed in 1/2 synth clock cycles. Two-complement
signed integer.
A positive value moves the phase of the output later in time (more to
the right on a scope). A negative value moves the phase earlier in time
(more to the left on a scope).
</cite>

So for input pins the value must be negated, while for output pins it
is not.
>>
>> Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> Anyways, with datasheet info being correctly read, the change LGTM
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
Thanks,
Ivan


