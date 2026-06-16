Return-Path: <netdev+bounces-299711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9DLXCHivMGrtWAUAu9opvQ
	(envelope-from <netdev+bounces-299711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:05:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1060968B647
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:05:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CoC7TDNK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299711-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299711-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10BB83005174
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871803A7F66;
	Tue, 16 Jun 2026 02:05:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA393A5430;
	Tue, 16 Jun 2026 02:05:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575537; cv=none; b=gfQbT4tZLGV3zthuqlwqMpxJLSWrkxEdzLnZYfpPhjnMAhpkUDtokepoFXjLtDN8XnEJ+IY9uIsuOSDxPwIczV6l31o8ssEGji3GSk7zh5Z3muD+pQCFl/beqMEk69jsfnHH65A8wTEVL0tFn4PK/NnudBUa5fvlIpWl6Kx4lQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575537; c=relaxed/simple;
	bh=rf6rx+7putc32z8jq3hR64Sy6AxhVLIpxTD6RKximwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2Mkv8FwaXywwNhVLL0gh/MoQxgKtsLy2DrBB1b9S29jNciFQMO7rpuUiOgs0XQ8rlaiPTD4/8qf3RXvLro/xHO4jYkya7tQcK5APEv4YxqSfF2nFt1ZGleUIBhbW7bQpm28lO2wQsXzrLA027x8/T1Wig8dRu47tExkXhQpefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoC7TDNK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F271F000E9;
	Tue, 16 Jun 2026 02:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575536;
	bh=8znM3pJUPt6x9IlJTjtM1p/Ei0zOzcfw/VnYhIPhrJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CoC7TDNK4mOO79MYOuNdq19Zyxwg3Yd4chCewlKOmha5lkihtl0IiR1jFNv5lrIFC
	 lkFL1/Mt2yH9JB6d+cw++FwlKKOfm9ZoCL8Oz9btZW6wvU9WR6RGLnLkd8Plobyh+V
	 FqoAUyxbmQGpxRifUrdnhbudh89a9/24FOjp1WXvnWRDpVq9auZEbxQAPRHvDzbv4+
	 A+aYQPFy6ROfXoUQjdy2zz51SAvAafg0RgQ2xnhNXQAAkL2xIIuiCIofrZRiPJ5Fmr
	 RfZeBVWMAazjIA32mCy65kPFz94vKC469iZECqJCen0BjxPTLIBVFa7HVPJeL7fOqZ
	 BX+A5hMkQ0/mA==
Date: Mon, 15 Jun 2026 19:05:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: hns3: add support to query/set TX
 pfc_prevention_tout for ethtool with RX prevention disabled
Message-ID: <20260615190534.77a1b679@kernel.org>
In-Reply-To: <20260615063427.430456-1-shaojijie@huawei.com>
References: <20260615063427.430456-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299711-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:shaojijie@huawei.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1060968B647

On Mon, 15 Jun 2026 14:34:27 +0800 Jijie Shao wrote:
> Add ethtool support to query and configure the PFC (Priority Flow Control)
> storm prevention timeout. When TX continuously sends PFC frames, the peer
> end is suppressed from sending packets. If this persists, a PFC frame storm
> may occur.
> 
> This feature allows configuring a timeout to prevent such storms.

net-next is closed for the duration of the merge window.
It basically closes the moment Linus tags final.

Please see: https://netdev.bots.linux.dev/net-next.html
And of course:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

