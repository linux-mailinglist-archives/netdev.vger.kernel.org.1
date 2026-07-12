Return-Path: <netdev+bounces-306942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TaztFtKFU2pSbgMAu9opvQ
	(envelope-from <netdev+bounces-306942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 14:17:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E40927449AB
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 14:17:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=pnU3NpW0;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306942-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306942-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 635143003D39
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657453A4F32;
	Sun, 12 Jul 2026 12:17:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC930EF80
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 12:17:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783858640; cv=none; b=MWDOLMRvlIjw6jhKUMoMSvnoLAsIkwhvID1mxrnEFU8qcymDIone67G8CuYwscySdsAyxpRpxV+SQ339UliAP8WR1y2giWW/ZEQ6HyhEZZMlpC91sht8rwKwkhZxEs/MfVsfhZ0USAa9boovOWKYBe5KvM7lePBDEPWHz8gn06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783858640; c=relaxed/simple;
	bh=GhZd/XfEUa+JlDioXYReZpiTb+QqWsKH4GGipILVAGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CA9RlRHI8hJ/yz6k2SKIntQhDKCCk7tISj2WbZu7M2cLJrq8A7tg74inzL3TEJn8eUnp72oqcJfaW38aKqpzNVp5HBnw7mMzvSPyfjBDmPYCTstjCN2rQBeJpRcSsgdIpzFQIEnHLWIaUWybwWJu6Iy1kgX9mi1Onb4waX3yGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pnU3NpW0; arc=none smtp.client-ip=95.215.58.174
Message-ID: <904e6cbe-8774-42e6-8930-c4fc43cdbaec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783858626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOGsiwkurcz5QWt2OlGzDxgCUFJG3Ey9sVuWGXtSkU8=;
	b=pnU3NpW0AFK47qVGH7i+8a90by6FnkzINb5PnoAG8/qzUNJ0xC5AjRhXkzDt6kAD07Dlv4
	NI1yVPRdlSn+09FpfvAyfeLyNuZVmFlO2my8yC4iOMGTCRGhQtXQUtL/Z35QUHGNWo+poQ
	LhYCKEoXhOfMKolyWJtwFUC9LPvU7Ks=
Date: Sun, 12 Jul 2026 13:16:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 0/2] ptp: fix scaled_ppm_to_ppb() overflow bypassing
 the max_adj check
To: Deep Shah <deepshah146@gmail.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20260712040922.6403-1-deepshah146@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260712040922.6403-1-deepshah146@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306942-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,lunn.ch];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:deepshah146@gmail.com,m:netdev@vger.kernel.org,m:richardcochran@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E40927449AB

On 12/07/2026 05:09, Deep Shah wrote:
> ptp_clock_adjtime() validates an ADJ_FREQUENCY request by converting
> tx->freq to ppb and comparing it against ops->max_adj. On 64-bit systems
> that conversion can overflow s64 and wrap the result back into range, so
> a crafted tx->freq bypasses the check and reaches ->adjfine() unclamped.
> 
> Patch 1 rejects the overflow in ptp_clock_adjtime().
> Patch 2 adds a regression test that crafts struct timex.freq directly
> (testptp's int-ppb path cannot express the value) and confirms it is
> rejected with -ERANGE.
> 
> Deep Shah (2):
>    ptp: reject frequency adjustments that overflow scaled_ppm_to_ppb()
>    selftests: ptp: add a regression test for the frequency adjustment
>      overflow
> 
>   drivers/ptp/ptp_clock.c                       | 14 +++-
>   tools/testing/selftests/ptp/Makefile          |  2 +-
>   .../testing/selftests/ptp/ptp_freq_overflow.c | 74 +++++++++++++++++++
>   3 files changed, 88 insertions(+), 2 deletions(-)
>   create mode 100644 tools/testing/selftests/ptp/ptp_freq_overflow.c
> 
> 
> base-commit: 3f1f755366687d051174739fb99f7d560202f60b

For the series:
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

