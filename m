Return-Path: <netdev+bounces-271984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC2VGu4UxWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-271984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:13:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E3833431B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E44E8304C49C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550D13890ED;
	Thu, 26 Mar 2026 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GKzQ9M9A"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F38382F39
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523210; cv=none; b=KvZf7XtQmsrftYJsHzN3xlWNAefkBdCzo6raWA4W31GsVcPg1UBRajsG1GD78sljcrZtAnQvjRgR3O+JezmIaInNGkLGp6xovTDA+E0yhPMKENEQ7pOBhEJWXU8pXkF7xcnzG+aeakdCWV8OXre6e0uKEUQAKU1wids6lZ5rLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523210; c=relaxed/simple;
	bh=k+wu+2cuNPZeET/Emq8oKs+zlyzXvPmaUY8+O6El8n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grt/cTqzwDV1qM5Hj0zemHUeIp2H7qan8I2nkWVCBEsu6pl4nTanJnwok5isOPeH9HJLrt6EeZad8mDn1+m8rsm2aIWCpN6tP7558OaUU8WkwORSK2Ln3FQLpWjZVQKSZtuwJMNjzmIfU/VAif4Xc2VEFyvvAOJP24C/k4xu4SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GKzQ9M9A; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c3a01e7b-0b3a-4a0e-86cb-f9fe79a90a62@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774523196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t82upu+JkYBPixAK81aWkOm93P++6ewa96nPfYVRcls=;
	b=GKzQ9M9AR79IL1NcYc6CwQLAjkXvhfgt1JwV5btp0LSD3R71Ah86kpegNAN0AUojCgUmpO
	ZJCdK2e88XeZ1taR4aVB2ZZgLejnMmchCWNyBG0rn7o7k4EJVAKjVueU/qqrSuMQI+S85K
	XSGhNNCimStJRgXLVo9pHfTIhZVlyBI=
Date: Thu, 26 Mar 2026 11:06:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/3] dpll: add actual frequency monitoring to
 netlink spec
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260325193914.124898-1-ivecera@redhat.com>
 <20260325193914.124898-2-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260325193914.124898-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271984-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,resnulli.us,lwn.net,linuxfoundation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,microchip.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: B7E3833431B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25/03/2026 19:39, Ivan Vecera wrote:
> Add DPLL_A_FREQUENCY_MONITOR device attribute to allow control over
> the frequency monitor feature. The attribute uses the existing
> dpll_feature_state enum (enable/disable) and is present in both
> device-get reply and device-set request.
> 
> Add DPLL_A_PIN_ACTUAL_FREQUENCY pin attribute to expose the measured
> input frequency in Hz. The attribute is present in the pin-get reply.

Overall looks ok, but the wording can be improved, I think. What about
using "MEASURED" or "READ" instead of "ACTUAL"? The spec file has this
note already, looks like there were some concerns already?

