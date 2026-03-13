Return-Path: <netdev+bounces-267498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBP0L4cptGkQiQAAu9opvQ
	(envelope-from <netdev+bounces-267498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:13:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA9E285B1A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C15F130AD647
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276323A75AF;
	Fri, 13 Mar 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwNG1XIw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4232C937
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414193; cv=none; b=ZmAMwUY1KRJ7tdctaRzyEHHw907Md0JnZzuf4NyREDxCfMw2y28ypuzNM4cLglwg5OlV1dcxRnIaHVND9wHtwXTJTs1vpCNu0SXcz+0Ss4CdPlm1MhsN5YK7WlHolXGYmtsL3pBlGKdggpHV85pOdDHk6IzKUUjiuJcrMd2kCvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414193; c=relaxed/simple;
	bh=tRAeGE3gCsn6bmyyitbqFGSUPCagRgExw61eugFG9+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkGKyAAS7h+GzOP5xjJ6bTBW5TQyg/rsCFgGCxnh4w6j4I7LEwF3AB7iVVOq5zTBWjDcdUHnPrVqYLdvpqPao8yDFe+hC9E/9UAQh86SAKMd+49qG1larnDxi3Pq/NJqTZ7+Mowp3j8NjTGH6BFg362wLCDJOsgtYh/1tJpNSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwNG1XIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB5EC19421;
	Fri, 13 Mar 2026 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773414192;
	bh=tRAeGE3gCsn6bmyyitbqFGSUPCagRgExw61eugFG9+Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GwNG1XIw2jQFHZA1gtmaVwVAfRh1gE/APlmUhYsXq0hF0B2Ck0l/f46Y68F3hiDCu
	 34IDjaIQOP0nZMVau1WCcI5LtO5yXuQjt+Gfqd+avIcSJKnGosC9kyNh/h2kEnZQ1S
	 xYEgfz72vhxiz5IvVQQfRUvlgBg9ohPuiVzDJP8PZpPL6l1ZXwgnfLb0ok0HgKfjV6
	 9rK/tGoQaYTdPePPRCXPdhQWh1I5avW1nEQ1+uGlu7mXBiML2KnHssnKazKxw9Toef
	 SJ0GpMb9+Uvjsjcfb7ihQbSupcjezhukiVKkwkLn12D1HGfEwOeQIBWzd4pkQG8URq
	 dL9TH2sxzPuzw==
Message-ID: <20f079ac-3046-4b12-a9c4-381a077cf36a@kernel.org>
Date: Fri, 13 Mar 2026 09:03:11 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net 0/2] ipv6: Fix two GC issues with permanent routes.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260311052954.1224278-1-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260311052954.1224278-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267498-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DA9E285B1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 11:29 PM, Kuniyuki Iwashima wrote:
> Patch 1 fixes the unbounded growth of tb6_gc_hlist due to
> permanent routes whose exception routes have all expired.
> 
> Patch 2 fixes an issue where exception routes tied to
> permanent routes are not properly aged.
> 
> 

There are several tests covering gc and changing routes from permanent
to temp and back. Can you expand those tests to cover this problem?

