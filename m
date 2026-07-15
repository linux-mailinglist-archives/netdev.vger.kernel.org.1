Return-Path: <netdev+bounces-307662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HdtYNywbV2raFQEAu9opvQ
	(envelope-from <netdev+bounces-307662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:31:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7B175AAFC
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:31:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=SEVXk03s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307662-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307662-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8D50303C01B
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 05:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBAF280018;
	Wed, 15 Jul 2026 05:31:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B61A8F7B
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 05:31:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784093482; cv=none; b=NUTwyCHLhcPreET8bU59qJoWRy3KGlb2EuQQiwdE/UK4kdyj1B/Bw46xvVJgvc0Zds1WvXtUrh9NdIpOemMj7bviGpRcblTZrlSEd6KaWgSkTVW1oJ29BtcCw2dhw3wJqvpaZo8/YPijB5++EHknp5SZxtf/AGAU+7l0fsYlwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784093482; c=relaxed/simple;
	bh=ugJnAwMrZudP5W6/NCbvXshsTfn6ZgiR1yUWNFxBKDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRQJIvxrPWSZtwCfaRwn+mMnyCk1RvTt2fVqdUjFmpqOg2NrxxX9AIiRMLIKkmRTmSIGZzEGBJ8VIoLja8p3Omyc633ngnjUqr76Ovlw0WqyN7qgJ0Tq45iLHhet0JFbT0Nbqn6Zmu9Vuc3VExB+1ovWDE9LFxRTo+hSGYYyC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SEVXk03s; arc=none smtp.client-ip=91.218.175.177
Message-ID: <e07c280b-d3a8-442d-bf19-f00d544ab26c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784093468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnBUbq3k1b9tRTWvCLJ4zc2zppxBtgM0T1Bl95+DRd0=;
	b=SEVXk03sXpdnZ9KQ8ppgRaStRmjskPj2AxKXL6+3L/TrMPZAuiB86HoGkcllnBSMlqhnKC
	zecO0CGARsqgWXgVV4BhyACqxg71cJLpBC62wFIcSzsJMElWDIX7Cf7tmr5l+g2nuQaFjq
	CV1XjC+xxQlU45r3XuOvSUosyXjyklk=
Date: Wed, 15 Jul 2026 13:30:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] ppp: reuse ppp_get_stats64() for ioctl stats
To: Zhixing Chen <running910@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-ppp@vger.kernel.org, netdev@vger.kernel.org
References: <20260714091941.33783-1-running910@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260714091941.33783-1-running910@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-307662-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:running910@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-ppp@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E7B175AAFC

Hi,

On 2026/7/14 17:19, Zhixing Chen wrote:
> ppp_get_stats() open-codes the per-cpu tstats aggregation even though
> ppp_get_stats64() already collects the packet, byte and error counters
> needed by the legacy SIOCGPPPSTATS ioctl path.
>
> Reuse ppp_get_stats64() when filling struct ppp_stats. This keeps the
> ioctl stats path consistent with the netdev stats64 path and removes the
> open-coded per-cpu stats aggregation from the ioctl path.
>
> Signed-off-by: Zhixing Chen <running910@gmail.com>
> ---
>
> This is meant as a small cleanup. The ioctl path and the netdev stats64
> path already use the same underlying counters, so this just makes the
> ioctl path reuse ppp_get_stats64() instead of open-coding the per-cpu
> aggregation locally.

On a 32-bit architecture, this will introduce unnecessary seqlock 
overhead to get the upper 32-bit of a counter, which would then be 
immediately discarded.

Regards,

Qingfang


