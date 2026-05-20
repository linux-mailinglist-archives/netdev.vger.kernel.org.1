Return-Path: <netdev+bounces-290144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBBREJVNDmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:11:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C48B959D31C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF4FF30342A2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A681373C12;
	Wed, 20 May 2026 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obytBnlW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6484633D6F9;
	Wed, 20 May 2026 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321469; cv=none; b=n78lkFCG2U5oFtEdB3p+G0osToRA5V0DHJMsuY62MSXl99jxQYf9Bh7L74zgU92BX9yANU4Ow2XdOEI665JE2juL+LmjxTOBB9uGd8aS4coc87A6u4MmnyIThNgcVwIIlTtwR3PdLpFeXUQrQ4mQ6ub+pe0T6gCTIxiIs2CnQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321469; c=relaxed/simple;
	bh=WtG8EcmArf4Z8gLZlLF6rKwPdtxzneEuWsXigFBwDAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjuhkF9YcEUv6eK9zocVhQeRjW1qFvVcZuIpYCBGgvv8mI5WNA9jw2MGwY3FMJgzhU4WHnolTePq1SGqaVjLpp16J85EkDFm8c+gTfOXLHMVYaqE2sHI0XyWwoFnrfsHComenCpEB07WYHKgu13iToEK1az5+1/Tzes4pssqDGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obytBnlW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391BE1F000E9;
	Wed, 20 May 2026 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321467;
	bh=X6DI7mmqfvXQdfna5t6z3c+phyO48RHga9a4FKW2Iyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=obytBnlWNgsZNdo2sqNmjUBgAKaVk2zKmsmXf/v38/izx3LAqiK+wrSXbbfzw2JPr
	 8nlQNOBRsV0RNxu5IzcMr+btHRta9VIM+x/As9ZpMVth6XXLO5wPcUSVVRvctovCmq
	 KgkH7/z/mqEHiLyNwxBpAeXaKs+gGVlTyppSvUGFTgPHnmzhrcwA+ZpmVd7Yfa2YQ8
	 yFi+hyec+6ZhZSgTV7566ve+EbcM357QM6PLMmUFQbn4b0WtyTOuth1xKd9YUsK+Ya
	 x4tqQ2TRpRWlCCj5k6SG9pyzMrYQ9XcekzLn55ijpN98zKffmj/lPNb0vq9QhIvY4F
	 mdQ/opjZ9JPvA==
Date: Wed, 20 May 2026 16:57:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linuxppc-dev@lists.ozlabs.org (open
 list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack
 handoff
Message-ID: <20260520165746.7ed10c7b@kernel.org>
In-Reply-To: <20260517192856.3925-1-rosenp@gmail.com>
References: <20260517192856.3925-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C48B959D31C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> Collect received skbs on a local list during RX polling and pass the
> completed batch to netif_receive_skb_list(). This lets the networking
> stack process packets from a poll cycle in bulk instead of handing each
> skb up individually.

GRO should be even better.

> Speedup tested with bidirectional iperf3.

Please mention the platform / board as well.
-- 
pw-bot: cr

