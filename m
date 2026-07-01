Return-Path: <netdev+bounces-303822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wpnbCfB/RWrnBAsAu9opvQ
	(envelope-from <netdev+bounces-303822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:00:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7446F1B78
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:00:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=bP5Y1uth;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303822-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303822-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624BE314183F
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F8F27B35F;
	Wed,  1 Jul 2026 20:54:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129F3A7F6B;
	Wed,  1 Jul 2026 20:54:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939262; cv=none; b=T2SUpCW2CHPOeU0mDnB0u22qxuYga/vpPmFvrouUlBaMYTeOeZ6DKf9qWgRxL5NAbXOp4CVsIasOYv9UdXXCuE2eqcYjHdG2qaGGjUDhDoMzS7ckmesWik/R5i+4PgNHRoo/LoqiK+aFAvFD4r8XZRxuQvFfoCWXDYozChngBRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939262; c=relaxed/simple;
	bh=pflyARrIC1PkECp+vY/Xn1BVY0ujTQ/JDr52eHmBJF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgS0bahADaddHMUFsUq/HKV/sv6Kc7Y8mRvAvUibKVmm22/ehlAPLD37F6SnsYh9dlINnqhvkN56pU6zyKKc0aUJyjDmWu2YrMk3DqJ1E2oKAZhSqJzxVUFJcHSNgQFFAy0HQHQbYtm4+CKTaScHa0eTC2q4AC6jYdeQnjZEi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bP5Y1uth; arc=none smtp.client-ip=91.218.175.188
Message-ID: <75aafe76-fa22-4985-b277-fb51debf8852@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782939256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTSQsuTdzdnUYTD7BTPntQLkPU6l8HPheSNnHeBOHHQ=;
	b=bP5Y1uth5XwlVbKmRMA1yvUclZCCZcHoAQdvdFQRqGGeW3y0luZx3MAiC8IP9y14Z/U4gQ
	bpnlxzMOMOJjiyVRS/Tlp3I0aOLPSj8XDkLexvIfGXcrXvugY/SLz00wwQyddbRkT60fF7
	msh/WM6xC58NsXos//1rGdxe5gS/big=
Date: Wed, 1 Jul 2026 21:54:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/3] net: ipv4: report multicast group user count
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20260630110207.37841-1-sigefriedhyy@gmail.com>
 <20260630110207.37841-2-sigefriedhyy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260630110207.37841-2-sigefriedhyy@gmail.com>
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
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303822-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,gmail.com,google.com,nvidia.com,redhat.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C7446F1B78

On 30/06/2026 12:02, Yuyang Huang wrote:
> RTM_GETMULTICAST has been part of the rtnetlink ABI for a long time
> and already reports IPv4 multicast group membership through
> IFA_MULTICAST and IFA_CACHEINFO. It does not report how many consumers
> hold each membership, so userspace still has to parse /proc/net/igmp to
> get the Users column.
> 
> Add IFA_MC_USERS as a u32 attribute carrying ip_mc_list::users in
> RTM_GETMULTICAST replies and entry-lifecycle notifications.
> 
> This gives iproute2 enough information to migrate the IPv4 part of
> "ip maddr show" from procfs parsing to rtnetlink.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> ---
>   Documentation/netlink/specs/rt-addr.yaml | 4 ++++
>   include/uapi/linux/if_addr.h             | 1 +
>   net/ipv4/igmp.c                          | 2 ++
>   3 files changed, 7 insertions(+)
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

