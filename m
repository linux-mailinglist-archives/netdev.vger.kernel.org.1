Return-Path: <netdev+bounces-297020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mPSyHs31J2py6QIAu9opvQ
	(envelope-from <netdev+bounces-297020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:15:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D1765F649
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:15:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ncykL8Qy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297020-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297020-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8101A3058056
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBF839B4A5;
	Tue,  9 Jun 2026 11:06:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2053F9F32
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 11:06:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003203; cv=none; b=DqzJdm1wPrHbiJa5O8WSxfzOLZkw1j76uqi/FcpjN+bX8VhOPJvBZBLMRLX6dkfof7q1cfQMEzSZkmrcQ+8sBRKPPfeMX2OKxsG31aUCak6TsMcAyZF8Q2w82lE8ex2+0Qewi+W83T3v2qquz61pLWrHz2aqCfOO71d4BhEjGm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003203; c=relaxed/simple;
	bh=eT/9Sn/sYsrL31GQDuHiuEQUw+7Tb4fr2oU7PuE0GnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNqPoeJXY/DAbTzdPFVZBIlryygLMhVrkuuuBLz4udElfKx9RMcPWON4VeFJXD1k06Dz6vJnI1Zq5FyjmMDJ3NwY8cR/uWhziJaqJkgxCNBdlD5SBUN5JyESxsSrertaXSgDddAN/P0e/ASrqx3UzjiXX6pi0KH6CJoP5/gcvlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ncykL8Qy; arc=none smtp.client-ip=95.215.58.180
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781003200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOFwe83SM6QIMCLbxJXV0qmGwf1qp7uMCkco1AkMiLA=;
	b=ncykL8QyKMmCpqapX6jRGNRoeYwfXLUa94vpzhXvxJdYLfWIGkVevVUp8Nx8omyNSYfTKh
	DQy8f756Oy0E+iFy92HQtvQMHypZTxhyYbXOr57ZjtD/yyA0WV9iUYro39sFHPOOjo932n
	DvhCSH3dUl1qH2nFsHE0skIi2xVsU2k=
From: Menglong Dong <menglong.dong@linux.dev>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 shuah@kernel.org, liuhangbin@gmail.com, Sun Jian <sun.jian.kdev@gmail.com>
Subject: Re: [PATCH] bpf: Unshare cloned skb before devmap egress XDP program
Date: Tue, 09 Jun 2026 19:06:20 +0800
Message-ID: <L0cwr1-KRSKR7-dJdjDmJA@linux.dev>
In-Reply-To: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
References: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297020-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:liuhangbin@gmail.com,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02D1765F649

On 2026/6/9 18:02 Sun Jian <sun.jian.kdev@gmail.com> write:
> dev_map_redirect_clone() uses skb_clone() when redirecting a generic XDP
> skb to multiple devmap destinations. The cloned skb can share packet data
> with other clones.
> 
> If the destination devmap entry has an egress XDP program, that program
> can modify packet data. Such modifications can then be observed by other
> clones sharing the same packet data.
> 
> This can be reproduced by strengthening xdp_veth_egress to configure a
> different source MAC for each egress device and checking that store_mac_1/2
> observe the MAC configured for their own egress devices. Without the fix,
> the SKB_MODE subtest observes store_mac_1 receiving the MAC configured for
> the next egress device.
> 
> Fix this by unsharing the cloned skb before running the devmap egress XDP
> program. Limit the extra copy to destinations with an attached egress
> program.

Hi, Jian.

This sounds like a good idea in this case. When I have a look at bpf_clone_redirect(),
I found that it use skb_clone() too, which means it has the same problem. The
data can be modified by other xdp prog in the destination NIC if we use
bpf_clone_redirect().

So maybe this is the default logic, and I'm not sure if this patch can break the
existing users :/

Thanks!
Menglong Dong

> 
> Tested with:
>   ./test_progs -t xdp_veth_egress
>   ./test_progs -t xdp_veth
>   ./test_progs -t xdp
[...]
>  
>  destroy_xdp_redirect_map:
> -- 
> 2.43.0
> 
> 
> 





