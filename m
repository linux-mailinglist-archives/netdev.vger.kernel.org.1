Return-Path: <netdev+bounces-259063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBKXAhuClGniFAIAu9opvQ
	(envelope-from <netdev+bounces-259063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:58:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7162714D58B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EA6B3017265
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1C1336EF8;
	Tue, 17 Feb 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1s22E53"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F33242BC
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340312; cv=none; b=RlMhepMg8l6pDQKCTFbn/piHBcBrY5hIU8IAVX1DvbsovVk52nQOyKaIKT9dcXFYNHwGEQ98DMjIQQtd/gH4oZIJzExT5JdnealGzhnH8AnA+jQKtAlPLRhH/DPZ4Fj1yTDu0T/QiG9QOvt4XbVV26zbNCamN74oM2kjhnyhZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340312; c=relaxed/simple;
	bh=6jI5NjPkqq5P37tgUsRhyQbzJNVtBhMzr4smvOEVHCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xphhnu4KkGE9O/3784ogdfsa8Y+sVq6AzTVqlLWOIqtjmzugXWtpjotzdYB5ZEXqkJhsBCcIbkb3KN2OkIWdyr9QRG0RExS00/2WdDWIU09X9xWO6cNR8NRz5uUSBmQWqMbefwnBdKvdR4Ma0zLx5H+apuwFLAHi/diOoeQcZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1s22E53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3DBC4CEF7;
	Tue, 17 Feb 2026 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771340311;
	bh=6jI5NjPkqq5P37tgUsRhyQbzJNVtBhMzr4smvOEVHCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1s22E53KR9kQKVFK/QE4HxeDWxJwaZQI0tj/n+o+f4m2HkZimXCHpzEfTAEwZ1er
	 lV6U1vJ0G96us12n7/8b8cN9Tw1EFrHkPLn7Uiq0a42hH6zJW+TtJTqNjMw7cv8nQn
	 Ew2NEDGHfMrp8poKwNTv21lRoAQ1SblhuIQ0I2/b6K+zRDVqDetxoNc6wZg+xp4+Bq
	 76xf6pbjwbOzbLAWx98HWGalI9MCS8nEYh6NfqhgLPyoBx/sCfDxAp067O9a9yhzgd
	 iQPLYvue4IvZSpsLxjyu9Z026ksneOTTpnu8rwHYpyYwbqSmxI/XxuSa7Lnf/ag1cR
	 MbS7OJ0A0AONg==
Date: Tue, 17 Feb 2026 14:58:27 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net] ipv6: fix a race in ip6_sock_set_v6only()
Message-ID: <aZSCE92NwIOQo43R@horms.kernel.org>
References: <20260216102202.3343588-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216102202.3343588-1-edumazet@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259063-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7162714D58B
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 10:22:02AM +0000, Eric Dumazet wrote:
> It is unlikely that this function will be ever called
> with isk->inet_num being not zero.
> 
> Perform the check on isk->inet_num inside the locked section
> for complete safety.
> 
> Fixes: 9b115749acb24 ("ipv6: add ip6_sock_set_v6only")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


