Return-Path: <netdev+bounces-278749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO2hEoRy32mFTAAAu9opvQ
	(envelope-from <netdev+bounces-278749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:12:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D674039C9
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08FEE303DD31
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637993659FD;
	Wed, 15 Apr 2026 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tIHAIhY/"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC72E0938
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251521; cv=none; b=kwbiV3cgCQCfAxzznR8aHCTZTfd6J3YSG+gcuIZVrOG7e0jWYUBlOHY/eoSUEbZ3BTsLSKFmBYrEOD8MFADqU/clKhyFO1GPn6kM6zZtwunQD6hMaXtc1dZywItXlPFPEH/au2hF8itlYxYGJOA6gO/JrFNj3pMB2TqCc6NnnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251521; c=relaxed/simple;
	bh=JlHW5XCkGqA8aRiZPhKPWm4/lumwoeft20DD0fldfWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzzV+5qGNka0JPdaeQrrs9ZOeABop0ajsa6EmPSGKhn1VvFhICRMIyeOytmOrzzygWgLkegqkvBTQAqMAxgbSuUPNPNrxAF8oBhCoEWFOWdBFMjUygSB96+dDMs4+rTzz3RXE7gggM+Z/PhwPyblb0Tohvtay+e1MFJPLgxaGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tIHAIhY/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cdeb4c42-5856-48a7-bdb1-e61376654f36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776251518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7U9lqmUN9Z1+5IRdyqrC9d6oLUbBlcezaZ6gpo+G8zI=;
	b=tIHAIhY/Tvffm+I/ikftxa/yK73/f0IG6ifLKkQlxut4EnKXOjz5uJ3cq0IrEqglxj2OyW
	35T374PWn9qtNzPmtg3MCGoA/jZuVzjQIOgy1Pyi+uJcY+ADfebnp0Y9ra33JGOhjAzsDx
	qk/WsC9WObuzVWi9pGLiZ78n1ylykvs=
Date: Wed, 15 Apr 2026 12:11:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] macvlan: fix macvlan_get_size() not reserving space for
 IFLA_MACVLAN_BC_CUTOFF
To: Dudu Lu <phx0fer@gmail.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <20260413085349.73977-1-phx0fer@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260413085349.73977-1-phx0fer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278749-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95D674039C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13/04/2026 09:53, Dudu Lu wrote:
> macvlan_get_size() does not account for IFLA_MACVLAN_BC_CUTOFF, but
> macvlan_fill_info() conditionally includes it when port->bc_cutoff != 1.
> This causes nla_put_s32() to fail with -EMSGSIZE when the netlink skb
> runs out of space, triggering a WARN_ON in rtnetlink and preventing the
> interface from being dumped.
> 
> The bug can be reproduced with:
> 
>    ip link add macvlan0 link eth0 type macvlan mode bridge
>    ip link set macvlan0 type macvlan bc_cutoff 0
>    ip -d link show macvlan0   # fails with -EMSGSIZE
> 
> The bc_cutoff feature was added in commit 954d1fa1ac93 ("macvlan: Add
> netlink attribute for broadcast cutoff"), which added the nla_put_s32()
> call in macvlan_fill_info() but missed adding the corresponding
> nla_total_size(4) in macvlan_get_size(). A follow-up commit
> 55cef78c244d ("macvlan: add forgotten nla_policy for
> IFLA_MACVLAN_BC_CUTOFF") fixed the missing nla_policy entry but still
> did not fix the size calculation.
> 
> Fixes: 954d1fa1ac93 ("macvlan: Add netlink attribute for broadcast cutoff")
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
>   drivers/net/macvlan.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index a71f058eceef..80f87599a503 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -1681,6 +1681,7 @@ static size_t macvlan_get_size(const struct net_device *dev)
>   		+ macvlan_get_size_mac(vlan) /* IFLA_MACVLAN_MACADDR */
>   		+ nla_total_size(4) /* IFLA_MACVLAN_BC_QUEUE_LEN */
>   		+ nla_total_size(4) /* IFLA_MACVLAN_BC_QUEUE_LEN_USED */
> +		+ nla_total_size(4) /* IFLA_MACVLAN_BC_CUTOFF */
>   		);
>   }

Please, use tree indication for the next submissions. As this patch
fixes the issue, it will go to net tree.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

