Return-Path: <netdev+bounces-301848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 95gfA76WPGqcpggAu9opvQ
	(envelope-from <netdev+bounces-301848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:47:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 639816C273C
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:47:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=d2+qyivy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301848-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301848-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 658253008536
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACED27FB2A;
	Thu, 25 Jun 2026 02:47:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C8283FE6
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 02:47:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355642; cv=none; b=Cr9zE7ArCYVJy0p5tTfjxMyApU3NNyibuHZ9cDtSCrF28wTFS1Ui4iE2smTI5aXv+SPImNjnWRYgU+GK7LRJddvq+pwSm7wScximb/71gOL00G3ZQ0MxtPCMgCAgRQ1MKa6EZ9u7XljVF0UsgpBWuaSwWx/SsZUkoUc+ELAtmOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355642; c=relaxed/simple;
	bh=3fQFCQJHcQJJW9TgvHwJeaOTpLuz7ky/H4yqJfAn+xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGYeO7N+Bobeg+AKoFEBlQNr8TAtSh15MUPjCOsruWgE2R5pJPiE2FoNh6BfVtnzyLyP7cZmNgFnCRqeUz0H1YBkRgQYgHTQPdo13ZCNc3QbibgmPgwLm1POQ/SAPHXmYEp6RqZBln1noP01aWfabtMnykK+RskUi9sSijvUF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d2+qyivy; arc=none smtp.client-ip=91.218.175.182
Message-ID: <04d09dea-baa2-4c43-ada1-cd71579aad53@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782355638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eTGMM8kti/dniSQqR68ud+T031fNCB0pmtx3QWvpFms=;
	b=d2+qyivy5J4b37rFabyUW2yc1k3kly6VeEL3jHwjzzn/A6oLxydCSd8TAGTCdZutyaCZUc
	DU8RXvYjdadsPy5zpWyRzgOunltCGB+oXWzSooIsJi7LR1vH9dhqxvE0BvgCZ+D0GmfeKi
	Tfp0cWSh5iaOjiVVPqakRxO/0Dw40Iw=
Date: Thu, 25 Jun 2026 10:47:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: udp_tunnel: fix use-after-free by refcounting
 udp_tunnel_nic
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Yue Sun <samsun1006219@gmail.com>
References: <20260624171034.4117423-1-edumazet@google.com>
 <20260624145722.083632b6@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260624145722.083632b6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301848-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:samsun1006219@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 639816C273C


On 6/25/26 5:57 AM, Jakub Kicinski wrote:
> On Wed, 24 Jun 2026 17:10:34 +0000 Eric Dumazet wrote:
>> Yue Sun reported a use-after-free and debugobjects warning in
>> udp_tunnel_nic_device_sync_work() during concurrent device operations.
>>
>> The state flags of struct udp_tunnel_nic were originally bitfields
>> sharing a byte, modified concurrently without locking (RCU vs worker).
> Can you clarify the path where the bits are modified without locks??
> My mental model is that this is basically all under rtnl_lock, and
> Stan added _another_ lock so that drivers can call "sync" / reply
> without needing rtnl lock, but any changes are still under rtnl_lock.
>
> The gap seems to be that we don't check pending under Stan's new lock,
> since commit 1ead7501094c6 ("udp_tunnel: remove rtnl_lock dependency")
> did:


I think the real problem is that a single work_pending flag can't track 
the work being queued twice:

1. Thread A calls queue_work() -> work_pending = 1.
2. The worker gets picked up; workqueue clears the PENDING(internal work 
queue flag) bit before running the work function.
    The worker then blocks on rtnl/utn->lock.
3. Thread B calls queue_work() again. Since PENDING was already cleared, 
it enqueues a second
    instance and sets work_pending = 1.
4. A's worker finally gets the lock and does work_pending = 0, runs, 
returns.
5. Now work_pending == 0 but B's instance is still queued. unregister 
sees 0, frees utn.



