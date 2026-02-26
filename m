Return-Path: <netdev+bounces-261476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FVrAwWKoGlvkgQAu9opvQ
	(envelope-from <netdev+bounces-261476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:59:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE251AD272
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8618E3441E85
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6C439000;
	Thu, 26 Feb 2026 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfrIh+Gz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4173B5303;
	Thu, 26 Feb 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122729; cv=none; b=E/n7YWMBS50Vxh91+uNt2xaYrPoCoF7Sc3nBrgx+lUp67Spb5Mp49N5eL3X02nws3V5mihasl6focDPeNj9BONH2Vbp9o/oybrKiNo+oXdsWJ9Hp+0nQfkdVB76BWhq1XoGQOEC/c6PX57HAPN4rd/0FK8ujzI12prLIcWWq1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122729; c=relaxed/simple;
	bh=kxUP9RO43PuNS5icnrQd14OoirwDeG69E+sv7gAMhJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwj7Ee6Yfg/x9B7H96KURSVb6vCaDLGD4/S/BBcOR44VKo+8A86PmybZDnE0QozEhNCjmGe9W5fkIglgQy6WeBfJ9X0F5/BWhCdgBRJO/FQNhJJRcFsPG6Nk+VDWAtob/e/B4MtQyk31nKZ9KJsM/L554qQ7qpRyK+nwTv9wPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfrIh+Gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39242C116C6;
	Thu, 26 Feb 2026 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772122728;
	bh=kxUP9RO43PuNS5icnrQd14OoirwDeG69E+sv7gAMhJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TfrIh+GzhsVBuYvEDEtaeeQAYDMqnD3jNuyXS35/GwVy5XJ5a3V5Km1OA+i/1ETCf
	 HO0VqwDS9sjnTf95VavzzBKR+9otFWpQhMCknaADzW0vY6djJlaVhpG8/Rsib9KdGA
	 FJmGSV9zTzeWam2TZbJ6PWlYCXLr7JDj61IQKs4Pd7oHSScAnpVKp1Ut3mbCQdhmVT
	 boYz/aTEAW3HNeF2p7+/F1WvonyiPYAxnkcwNd6KcHBRDbxiFF5I6CqtAZ2qMDBZhO
	 7bCZ8PpSkZx2g0/dKvD558iLlZiElKz1LuxHCjBXKU+cHEjt9St9AnZ6mekmzj4vXL
	 MahvMUEOVv4PQ==
Message-ID: <78b7e776-5e1e-4cbf-96ed-ece9549e5caa@kernel.org>
Date: Thu, 26 Feb 2026 09:18:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] icmp: fix ICMP error source address when
 xfrm policy matches
Content-Language: en-US
To: Antony Antony <antony.antony@secunet.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan <shuah@kernel.org>,
 devel@linux-ipsec.org, Tobias Brunner <tobias@strongswan.org>,
 Simon Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 stable+noautosel@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1772101380.git.antony.antony@secunet.com>
 <19a0156ff6e76baa323a81d710510d399a6ff63a.1772101380.git.antony.antony@secunet.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <19a0156ff6e76baa323a81d710510d399a6ff63a.1772101380.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261476-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,noautosel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strongswan.org:email]
X-Rspamd-Queue-Id: 7AE251AD272
X-Rspamd-Action: no action

On 2/26/26 3:27 AM, Antony Antony wrote:
> When an IPsec gateway generates an ICMP error (e.g., Destination Host
> Unreachable), the source address incorrectly shows the unreachable
> destination instead of the gateway's address. IPv6 behaves correctly.
> 
> Before fix:
>   ping 10.1.6.3
>   From 10.1.6.3 icmp_seq=1 Destination Host Unreachable
>   (wrong - 10.1.6.3 is the unreachable host)
> 
> After fix:
>   ping 10.1.6.3
>   From 10.1.5.2 icmp_seq=1 Destination Host Unreachable
>   (correct - 10.1.5.2 is the gateway)
> 
> The fix removes the memcpy that overwrote fl4 with fl4_dec after
> xfrm_lookup(). A follow-up commit adds a selftest.
> 
> Fixes: 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
> Cc: stable+noautosel@kernel.org # Avoid false positives in tests
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Acked-by: Tobias Brunner <tobias@strongswan.org>
> ---
>  net/ipv4/icmp.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


