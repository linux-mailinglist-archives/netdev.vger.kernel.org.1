Return-Path: <netdev+bounces-257557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC8IKPP0hWnHIgQAu9opvQ
	(envelope-from <netdev+bounces-257557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:04:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B89C7FE976
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBC4F3001598
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6783D9034;
	Fri,  6 Feb 2026 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fWPksgV5"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE33B8BB2
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770386670; cv=none; b=Nzd0nzJfQH+yuDvjnyq0n2RqIAy/K+uxiCi4YPBbyRpiACS4/EoZueu1aNA1oBGaepTahJa6tXQbfmcfHbTCwxwJz7ltJSPX94TSFQ3rvjgy0QkLiwIYqrRc0pwAuy3nZYSfiMKhIYj6RwhDSRUoEK/vgl+Mlig38YhNJZR37r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770386670; c=relaxed/simple;
	bh=z4GNuMRZct0KcMBQZOFElH6rK3k1LgWIOdpyLUXQ8Zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APu+3u4fgGSbMWs4gGGgyCvpnI+7g624qcUzDvBFJJTqRmUxADshy/mBaKz52u9tkMUjLW8Mz6qnq/30RzNNs85D7DLjrcCCqyqNd9FXdrE/9TXETjkdEhW6SVTywHvvF/ijNkklVh3vHnHi62Rq+KgmyzlldBVGdO0htB9/dSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fWPksgV5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d3f6c71c-133d-443a-adee-3430936ff8c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770386668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TR+sNHwRto6X97gwyNZ0eglR840iij69ujYUHSFBO8s=;
	b=fWPksgV5qmy0XKWUaSpnfstNbJxpx4If3eBbfXsWnD2dzDwIehAVQtOz4BSiGSAx6ZCyrr
	jSPxq7GfX/w6Iwq1f4Ozq2Tc4bH4DIadz3vKSQA74+cQtc9yCuIGtPT6ayVZwN4h8r2ZCd
	LXqXhU5HbWWJYnwsUYqsQE9kjR8cmPg=
Date: Fri, 6 Feb 2026 14:04:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] dpll: zl3073x: Fix output pin phase adjustment sign
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
References: <20260205181055.129768-1-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260205181055.129768-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257557-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: B89C7FE976
X-Rspamd-Action: no action

On 05/02/2026 18:10, Ivan Vecera wrote:
> The output pin phase adjustment functions incorrectly negate the phase
> compensation value.
> 
> Per the ZL3073x datasheet, the output phase compensation register is
> simply a signed two's complement integer where:
>   - Positive values move the phase later in time
>   - Negative values move the phase earlier in time
> 
> No negation is required. The erroneous negation caused phase adjustments
> to be applied in the wrong direction.
> 
> Note that input pin phase adjustment correctly uses negation because the
> hardware has an inverted convention for input references (positive moves
> phase earlier, negative moves phase later).

Is it common for DPLLs to act this way?

> 
> Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Anyways, with datasheet info being correctly read, the change LGTM
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

