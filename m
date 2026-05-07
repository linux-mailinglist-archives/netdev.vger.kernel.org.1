Return-Path: <netdev+bounces-285368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MuIEkao/Gn5SQAAu9opvQ
	(envelope-from <netdev+bounces-285368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:57:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5CD4EAAB7
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB21B3003624
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0491335BBB;
	Thu,  7 May 2026 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDs9EUZ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBB3306B37
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165827; cv=none; b=JhAHyB/ANmbm0cO5EX8x1Mb3pwBJyJbQMDLG3rOpOG8lKD+V0YA74kIzQPsnPzpJl/XK9TITHI054wzdXl5iWWGARji98Z4+WdCpTsJMKIOkduK0Wh/Kql6DzPc6fMQmGyahGKF/bmE+3qIiXnd3zvU/IWxF+tqmR/jva6kYXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165827; c=relaxed/simple;
	bh=PvLSEysbifg565g3DA6jS+loymliEvUT/DPan/JtIj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxWgVq+VGV+bc/J1j8YcSLt2N7syBBaFIP/37y21zFx6I88lwjO8gO0CGlKC07hodoAHradFyJtHrLc07q5zjSqKe+5hTX+yac/DuNWphGIeXU0smlsb12p2ifedZ5aGZb4EDpKrPjMhBJiRYNNmfZ6XhyxE9ZwzXcu0YRkzBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDs9EUZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36CEC2BCB2;
	Thu,  7 May 2026 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778165827;
	bh=PvLSEysbifg565g3DA6jS+loymliEvUT/DPan/JtIj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eDs9EUZ8Bz5yN1EJbllC0ymG+SIounyLI9S/E36E1dOqlrM0/AwtfhYrbVrnK6ipt
	 AJMYDS9kkYC7YKl2V8qdS3U8E1uhQgZ2ct+wGA+MjeVVH8HglufD9xsowrUyRNN/FX
	 pJPXrr5gqFqYDyccCOp9ZGMhOEMDtO4KLYPhvOpVurKyduhJfCMGdtQsuue0Y36S5K
	 lLDtJ4kCRyVKiVSB0N9H4mx1asfASuX7woi1Td0GA/3iKC73ydLJeWLrrJQr+6mbID
	 qrtsRE/bbjhem2h7KMJ6+ObLWDIfM/CP5vOcqsdLrPXinPUd58PSuJ9o0p0gRdF9LC
	 Iko+KIE65J3rg==
Message-ID: <749c97fa-9836-47af-a7ee-76b15bf54e21@kernel.org>
Date: Thu, 7 May 2026 08:57:06 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] ipv4: Flush the FIB once on multiple
 nexthop removal
Content-Language: en-US
To: Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260507075606.322405-1-cratiu@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260507075606.322405-1-cratiu@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DA5CD4EAAB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285368-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 1:56 AM, Cosmin Ratiu wrote:
> This series optimizes multiple nexthop removal performance from having
> to do a FIB flush for each nexthop being removed to only doing a single
> FIB flush after all nexthops are removed.
> 
> This dramatically improves performance in scenarios where there are
> many nexthops and many ipv4 routes. Please see individual patches for
> more details and for a test scenario.
> 
> V2 -> V3: https://lore.kernel.org/netdev/8fea4084-c9ec-472a-b8ab-ecc87e537216@kernel.org/T/#t
> - Split the patch into 3 (Ido Schimmel, David Ahern)
> - Used WARN_ON_ONCE instead of WARN_ON (Ido Schimmel)
> 
> V1 -> V2:
> - Fixes xmas tree in a couple places (Kuniyuki Iwashima)
> - Added __must_check to remove_nexthop_from_groups() (Kuniyuki Iwashima)
> 
> Cosmin Ratiu (3):
>   ipv4: Provide a FIB flushing signal from nexthop removal functions
>   ipv4: Flush the FIB once on multiple nexthop removal
>   ipv4: Add __must_check to nexthop removal functions
> 
>  net/ipv4/nexthop.c | 88 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 56 insertions(+), 32 deletions(-)
> 

Much easier to follow. Thank you.

For the set:
Reviewed-by: David Ahern <dsahern@kernel.org>


