Return-Path: <netdev+bounces-252143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FLwIVyKcWkLJAAAu9opvQ
	(envelope-from <netdev+bounces-252143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:24:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3269D60DD6
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA2033C2064
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304313382FB;
	Thu, 22 Jan 2026 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9yTSh/L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B822154B
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048448; cv=none; b=eVFuix03Y2fMJMjaqCAJe9N2Slr8C1dYrTwD12rexpq5GfBnOXHGr6CW6sU2/SmA4VvC9ekshR+EZ4X+hJUWHUn80iZk8XnK7iLm/F4ENUjVIFmXhneYPH0vTZPfyoRgAeWhBZpF1GZrHhYX7Gjyw7aX5kePeCEIL4TQzZ8KfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048448; c=relaxed/simple;
	bh=882eBcpumymMA74V642NIs9iDyToQadz59pXly7+ufs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0JPjPZ+DecfrC3RUioWDxdLIdqyB5KpS0mv2oJVOBXag6FIG3rxUaDr7Rl0ncSrdgHVI7zKgcaRafY0P2AgkX0/upt/wRby2Y5Si+lX92Y1UDYX8/CuYPuPlvr5BcTZcuYBHvv1GaeK3L67O8qUZgKLZ/ZKODn8iHuXJvCgvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9yTSh/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54373C4CEF1;
	Thu, 22 Jan 2026 02:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769048447;
	bh=882eBcpumymMA74V642NIs9iDyToQadz59pXly7+ufs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u9yTSh/Lxkutf7+pEV1+Wlf23rqCjLbHV+1s4q3aFO3BX1BNi36V4nz98AGWy+72w
	 /tVur+QObAPHfYbiDUA/CINf27ipH4caPy1X1f+CGgCnJZdtiW6DVAf8smr2UVL55l
	 JOHmhFMVhVKbEplb1TPhPqGv7fUHX77mUTpBy/YAOkM2DlWulXfROelsM9XzzOs7UC
	 84YfwnM8pQHpJCNEtkN4/3a7xI3bx0mDmczhACW3k5Caa6PPIF9K+7uyyFQX6o2TRp
	 3Et02MwAzdT5XzyhkjXrEPoE3wcgdw9OsibSoACu5Q16AS4s4TYrQiimunY03X3Zoj
	 v7kiW/m7YbgTw==
Date: Wed, 21 Jan 2026 18:20:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Mietus <mmietus97@yahoo.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, Jason@zx2c4.com
Subject: Re: [PATCH net-next v6 09/11] net: sctp: convert sctp_v{4,6}_xmit
 to use a noref dst when possible
Message-ID: <20260121182046.6371cc66@kernel.org>
In-Reply-To: <20260120162451.23512-10-mmietus97@yahoo.com>
References: <20260120162451.23512-1-mmietus97@yahoo.com>
	<20260120162451.23512-10-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252143-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[yahoo.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 3269D60DD6
X-Rspamd-Action: no action

On Tue, 20 Jan 2026 17:24:49 +0100 Marek Mietus wrote:
> +	rcu_read_lock();
>  	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
>  			     tclass, ip6_dst_hoplimit(dst), label,
>  			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
> -	dst_release(dst);
> +	rcu_read_unlock();

These sctp RCU changes need to be earlier in the series, otherwise
patch 3 transiently introduces a bug.

