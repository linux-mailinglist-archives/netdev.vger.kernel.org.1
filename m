Return-Path: <netdev+bounces-273805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIrgFUlwzGnJSwYAu9opvQ
	(envelope-from <netdev+bounces-273805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:09:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC255373600
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18BF13023502
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FD527816C;
	Wed,  1 Apr 2026 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVMkG/sT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52883175A79;
	Wed,  1 Apr 2026 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775005646; cv=none; b=fsePP6wDDwAEQf+bGhxb5bPjfSJmZeV7iyEHQJqxEz5wdyvLaePU6bQzSNKDNGSnjPP13Trje9xC0Bte1+aQY2OMpmuo5BBAfNN7VuPv4UJE1tAluC8NYKl8WmHagFr81k2uvx8wBnolaxiHKCo3SxlEVH/lihKGnWl809tTIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775005646; c=relaxed/simple;
	bh=k8IeX6WyY0PVZ54Mm0EBbtzQpHlrBrAlvtbUybofxqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3m2Vvfg4+U5o1uk+Oap3GDUa7gO4xPyN0vLrcF/1oqTcJvFtycIUCQU/ReloOsn/uToTLko+PSm14ZwpMAtBtR83gzzIFwFYJddIWuhPsxOUIZCyJ/R41lOheQyfMN/0hhZGMO12LoDfEaKdTLWGOXYD1OBoaKydNY7/pmJsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVMkG/sT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D50C2BCB3;
	Wed,  1 Apr 2026 01:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775005646;
	bh=k8IeX6WyY0PVZ54Mm0EBbtzQpHlrBrAlvtbUybofxqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FVMkG/sTrSB5ejGqfRbgMO8zH7ZNCZ/W1Eo7XSN2ALVhvNyEXRexA+yqam3JvSfMQ
	 I4mzFe+YT1xzmxIpMwClUqFtHlYKiaTu/IZppBS3R3mBTakuNof3UWY3gnWT0jb8C/
	 5OFVkKUgY0NReJuHazdyfWYQHo+9rQLuF93MVYPTw8AY/K+UvhsE/64MsIkVE8vipW
	 ik0ackX16GxJHfOeVXmOq0AKs+6I/katlmY7a9hAoM/imVvuFDo5XGGxBL12M76Jhm
	 eg57ZGHt1yrvmi431BFhBz24WtZ48npqn39o5D6MkK9QnmRdOmA2gosNXHlRBIJ8pp
	 4XKYbAIvQYoEA==
Date: Tue, 31 Mar 2026 18:07:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wang Jun <1742789905@qq.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn,
 23120469@bjtu.edu.cn
Subject: Re: [PATCH v2] net: ns83820: fix DMA mapping error handling in
 hard_start_xmit
Message-ID: <20260331180724.78f76e00@kernel.org>
In-Reply-To: <tencent_EB7280CE1394ABF5035CDA078FC60A481906@qq.com>
References: <51dfd8ae-dc4e-4837-9b00-c596c457117e@redhat.com>
	<tencent_EB7280CE1394ABF5035CDA078FC60A481906@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273805-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[qq.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC255373600
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 20:21:41 +0800 Wang Jun wrote:
> This is v2 of the DMA mapping error handling fix for ns83820. Changes since v1:
> 
> - Added queue restart check in error path to avoid potential TX queue stall
>   (as pointed out by the AI review)
> - Adjusted variable declarations to follow reverse christmas tree order
> - Switched from dma_unmap_single to dma_unmap_page for fragments
> 
> Thanks to reviewers for the feedback.

Please do not post new patches in reply to old ones.
Please do not post new patches within 24h of previous posting.

And ask yourself if you trying and failing to post patches for this
ancient driver is a good use of maintainer's time.

