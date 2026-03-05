Return-Path: <netdev+bounces-264101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCoNOFLSqGmlxgAAu9opvQ
	(envelope-from <netdev+bounces-264101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 01:46:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA532098F2
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 01:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B34A304A5B1
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 00:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769731632C8;
	Thu,  5 Mar 2026 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLDy2DaY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2C33985;
	Thu,  5 Mar 2026 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671557; cv=none; b=KuKkKbHGhzCJUMX0gGYNUv22LO2BLe/XM7TxmPQQixNZ9u5ByUHIpQ6vltq9i3v3+reyIJ6CC4ZTR1hISlyuE9MdDNp9sg9Yqo3SeeF76H7PbzDrPRZ3RrZ6Y8qnUtYAUl5Zc9cd2cyJOSdZJSVBUxtD3aTvKzCJT9DGa4SUXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671557; c=relaxed/simple;
	bh=Vs4wXaEJ5isRbpaM5gDufAuQu/lZt97ZRSo2jtArV1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIIYiktBCp5ObE8rDqyuL3MMO5M3KE8ROcb6lIxIyRQjvZGGzcuDik8+btf0DnZ5rlWKT7d2N2LWOl7dQDGexdtvJtEzSvfuqvRP7mDO8NGRrobZVyn5Lz25Y5/eXEqzGoxP1g9KaeZnHYOUyEf7er78/58cVG/Q0lHVmaAUaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLDy2DaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7853DC4CEF7;
	Thu,  5 Mar 2026 00:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772671557;
	bh=Vs4wXaEJ5isRbpaM5gDufAuQu/lZt97ZRSo2jtArV1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bLDy2DaYJwZwbTmr2Sp/4KaHhVREX2EgSi6WF3hGOSC0sdySKkSV129oxRWv7uV7a
	 bSxL0uxcwNGi0qHOqQttNVsYWEgC4flNGhQjEHEmVYLUgl9Zz6zKra3Jl1r/v3qmyO
	 KlZyItHf0ekiZEcpzvgbUwA0DndrwnEb+mT/3XLqtic8eun03uIXfKnBPwBEc9KA3e
	 6Rl+TQ+fJh4E7RyqGxJDxpXCGlA3VRXBLgQWVi0XYdVDfYvvzrRBA+bxyNOtgYtpz2
	 7zaTNySO4o7ltE9HPqocHO0dhJW88zuwPedAiUh2CIIuvuToSEqcXMH94s3H4OipIS
	 LXruFzJN9Sptg==
Date: Wed, 4 Mar 2026 16:45:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jian Zhang" <zhangjian.3032@bytedance.com>
Cc: "Samuel Mendoza-Jonas" <sam@mendozajonas.com>, "Paul Fertser"
 <fercerpav@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ncsi: fix skb leak in error paths
Message-ID: <20260304164555.6253faf3@kernel.org>
In-Reply-To: <20260302054629.1347119-1-zhangjian.3032@bytedance.com>
References: <20260302054629.1347119-1-zhangjian.3032@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6DA532098F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mendozajonas.com,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264101-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon,  2 Mar 2026 13:46:29 +0800 Jian Zhang wrote:
> +bail:

please give meaningful names to the labels, eg:

err_free_skb:

> +	consume_skb(skb);

since this is a drop condition kfree_skb() seems more appropriate.

> +	return ret;
-- 
pw-bot: cr

