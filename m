Return-Path: <netdev+bounces-295008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NxDwGfbYIGrK8QAAu9opvQ
	(envelope-from <netdev+bounces-295008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:46:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC79F63C42C
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:46:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=EjF7yMxM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295008-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295008-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA956300AC3C
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 01:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B07E13B5B3;
	Thu,  4 Jun 2026 01:45:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6A2199D8
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 01:45:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537544; cv=none; b=RYitmdYYAkeEK/lyX4uuFgK3ekFJHuA+k+ETvkiFlyYRWrjQink4ladtQCJjEi+CHYWQlpfaaSdh5PIwLFzyqXXjsPDjz1kQFZe+no2vXJWPltgKh/QXoUjAVk8YSft3uD3zq6JRMt7ehQHXRx/6peKMFQRlESHJA4krfO9EDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537544; c=relaxed/simple;
	bh=l4ZF8/PZdrr9oJ9Z3PmYG1C/xSWrKhDGca+y0i0kYTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8m+cfxcDP8toY/OysWOOfdqnwFjrE8i3jTCCsUl63iZTU3ABONFQiG1wB24ywwzYQkG4eb+tqUxjLhgezachAgH5M+KEB0kK8NEZnlTaOlt6AyC7hvc6Y05+TBXtDopUikWlRKlYRnh2pwcyqj47yCWG9lbqD0VqVy7yhBEIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EjF7yMxM; arc=none smtp.client-ip=91.218.175.181
Message-ID: <dce55902-02ab-4e5a-ac8d-6173064bb35b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780537540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4ZF8/PZdrr9oJ9Z3PmYG1C/xSWrKhDGca+y0i0kYTY=;
	b=EjF7yMxMhYMnENFkoE8MMHzLnlnPcItcIWat4TPdPQ7FW/5m8X55awsl2uYvq1mgm9tm0a
	M4Yx4lIvVMZxAj2xsf/EZb4LN/8GHTAMDMtQO4EbWOj5qOlpPh776n38oJ3W+AHu0lb0Tz
	SpAGTwEDiMCrFAJEG8HhBOokDoY+uck=
Date: Thu, 4 Jun 2026 09:45:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net-next] rtnetlink: use dev_isalive() in
 rtnl_getlink()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260603180831.1024716-1-edumazet@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260603180831.1024716-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295008-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC79F63C42C


On 6/4/26 2:08 AM, Eric Dumazet wrote:
> rtnl_getlink() uses an RCU lookup to get the netdevice pointer.
>
> When/If rtnl_lock() is used, we should check if the netdevice is not
> being dismantled before potentially perform illegal actions.
>
> Move dev_isalive() out of net/core/net-sysfs.c and make it available
> in net/core/dev.h.
>
> Return -ENODEV if rtnl_getlink() finds a device which is currently
> being dismantled and RTNL is requested.
>
> Fixes: e896e5c0734b ("rtnetlink: do not acquire RTNL in rtnl_getlink() with RTEXT_FILTER_NAME_ONLY")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


