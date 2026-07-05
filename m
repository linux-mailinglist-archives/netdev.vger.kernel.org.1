Return-Path: <netdev+bounces-304748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WCC+KEDISWr96wAAu9opvQ
	(envelope-from <netdev+bounces-304748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 04:58:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA23708D39
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 04:58:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=IPDE47EK;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304748-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304748-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13ECF30103A9
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 02:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7178C1E633C;
	Sun,  5 Jul 2026 02:58:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861301A316E
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 02:58:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783220285; cv=none; b=Dzo+98ZkiiTjMMKzSiisox8tmOjjj34v1jjCMyziXJmuAabSYLvHTvkSbhmMkzeLtVOAuzLc3XIzXCFfUpdjVrPqEbLM6hvtuNGWaKFEbjYUv/R4KwYKahknS5pCe4wjdZnMjbmExPiSbeNPbl3Cg/Rp5dlM92O3oTnDfjjqzNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783220285; c=relaxed/simple;
	bh=bMbaDl5MhEmbOcJtxvdENGZ6fVJB3hJnkuNHcCFTXts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTVYPrJWbOriZjXW9h+Zp7PYf8RYoAD2anB4nkSZ1Yr774+7kEIaf0NhBSZ2002To6bEQIGeR1w6KgI9t+scQAgLndk+vRjwdSzzxZjXRXOM4zLpdRI6duDfEVU40cJSn0/41IJIsgNwsxzavGMv1HgGK+9uLxCgNgSyY2xomQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IPDE47EK; arc=none smtp.client-ip=95.215.58.172
Message-ID: <87111f02-5b7a-4185-8364-2faba650578b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783220280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w57z/uu0fzBBMUOs8WK2tGZ+yvPyqJzpYHF98GM3FAM=;
	b=IPDE47EKxlvC8tiyTXUs4mrgufGfq2/VjqG9Dix65qbxcCHonC5tIwPQDJYMFRWHT2ftLU
	w82DXz9rRQDKHC6cRk+DWzFjtq41V1aYUhxg4bduoVXFPSluq0n5Etrp9qFfbmUSF0XLwt
	2EQZgINYHiGBCdv5Pmj+yvdSYQiFgOQ=
Date: Sun, 5 Jul 2026 10:57:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
To: Breno Leitao <leitao@debian.org>
Cc: Norbert Szetei <norbert@doyensec.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Taegu Ha <hataegu0826@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
 <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev> <akfjpBVML_1RFF91@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <akfjpBVML_1RFF91@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304748-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:norbert@doyensec.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bigeasy@linutronix.de,m:hataegu0826@gmail.com,m:kees@kernel.org,m:linux-ppp@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gnault@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[doyensec.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FA23708D39

On 7/4/2026 at 12:32 AM, Breno Leitao wrote:
> On Fri, Jul 03, 2026 at 03:27:00PM +0800, Qingfang Deng wrote:
>> AI-review found an issue: https://sashiko.dev/#/patchset/D9C0245B-608B-4884-8A09-F55BA4A9F948%40doyensec.com
>>
>> An rcu_barrier() call is needed at the end of ppp_cleanup().
> 
> I was initially unclear why rcu_barrier() would be necessary on a kfree path,
> but it appears to be required during module unload to ensure that
> ppp_release_channel_free() completes before the module's struct rcu_head is
> destroyed. Is that the correct understanding?

It's required to ensure that all ppp_release_channel_free() callback 
complete before the text segment of the module is unloaded.

