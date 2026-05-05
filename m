Return-Path: <netdev+bounces-284581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG3ONv1U+mlPMgMAu9opvQ
	(envelope-from <netdev+bounces-284581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 22:37:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC88E4D3B51
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 22:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C2773005172
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 20:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0DE3C2763;
	Tue,  5 May 2026 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTQdB4qa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A83431F5
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778013431; cv=none; b=CAP4wdgvVTzfw47k0IEkunHnzelCxerIAmS/Fn7n9XAbzI6TWj4FHG03wGDwPfpm5VN4FBezBnzD+vQZ2kDrcx8nE2t9SPb1tiV5EMS2pWKrbQD6xcWYCyzI1Geeq9/Ct1eSnx+MdIUGK2M61iWuRuoLvA+zlWEv5piAeVj7r5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778013431; c=relaxed/simple;
	bh=2VBD2StxeBSn2lkuUQodYzWgZT895GY9jOdPfGL6kQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ak90/bzw6E+RKOohurpsSUINrMTGvmb9vG5AteaRhZGMo0W7zSYR4YW0zI1N+Svt6lywQ/OL8qFDlin3Fd6/XQDJBL7+y8eCV7je9DXC53IrC+AZ2+eKvVbTvklWqMzYFpm4O8213o9wHcRsxIh1GKrCd8ZRlavOrTqlMz6eRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTQdB4qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953DEC2BCB4;
	Tue,  5 May 2026 20:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778013430;
	bh=2VBD2StxeBSn2lkuUQodYzWgZT895GY9jOdPfGL6kQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rTQdB4qaSPjDDEjCNrw+sCdq8d9dMeA6g9qCfnNarMPMSmGRLErrTSrYaZPo8JAuc
	 QEqSA0V+knU2vGPVNkzB12+otgP+cwZVhqibamc0kgLN5D3NVpcCEABf4ufhDlxQii
	 L8z/aS8VDirZfnFTaKqqwa0kGOD3fGivcupLhwlrMUssaqkT4hY7Dck1lpsCUG7+fO
	 Oz9coZqdxO2mI1VkB75ncPGjDt3mgsF8pqQP6Bv5SpKND2bJoJjTpYPycgLUkMfBTZ
	 U5Gwy79O1UUtrs+YTh1aYNhc6hKohUWER0TVrNDP5MULw2YvwsB5ZAA0WgKU+muX0h
	 dJ2YFS1V/ID2w==
Message-ID: <272d1f19-032b-48e3-8f94-38d9906609a0@kernel.org>
Date: Tue, 5 May 2026 14:37:09 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: fix potential UAF caused by
 ip6_forward_proxy_check()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Damiano Melotti <melotti@google.com>
References: <20260505130056.2927197-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260505130056.2927197-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DC88E4D3B51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-284581-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,10.30.226.201:server fail,104.64.211.4:server fail];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 5/5/26 7:00 AM, Eric Dumazet wrote:
> ip6_forward_proxy_check() calls pskb_may_pull() which might re-allocate
> skb->head.
> 
> Reload ipv6_hdr() after the pskb_may_pull() call to avoid using
> the freed memory.
> 
> Fixes: e21e0b5f19ac ("[IPV6] NDISC: Handle NDP messages to proxied addresses.")
> Reported-by: Damiano Melotti <melotti@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/ip6_output.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



