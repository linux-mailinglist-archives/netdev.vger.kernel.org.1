Return-Path: <netdev+bounces-275633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE/YF/TS02nGmgcAu9opvQ
	(envelope-from <netdev+bounces-275633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:36:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F4D3A4CE3
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73C8D300FC4F
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66CD2BE03C;
	Mon,  6 Apr 2026 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2Hb1eBa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82787239E9B;
	Mon,  6 Apr 2026 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489777; cv=none; b=urN7rXtavu+5dXMtNMJ1Ph9oUM4aP+kNLFW8dOtlAmrxoPYiWtQSscm6adS8LXFPBmuZMhH1MIESCpoFbhFxnZWTehyjj45KWdayhtOfn450v22/jo5H8UA2jIxLvjE9/pjDzCx3q77NoPelhdhxpRNq816Q1w3FMVmHeOgfuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489777; c=relaxed/simple;
	bh=MYWbB6ymMvRbnKt9cVcsyl0G3Tc+tvo1l3wlz0ADtaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ceb3WBgkvRGX1KDfP9wI1ywyIfijvJzd86p4kd97ZRnyV69eRybVqgv2YcCkH5Kqs1ciRj676l8tpS1fheuy8smj5oSzTx3PYHeV/dE6lNJOpcKrzJQVeMRjwJYR+T0ef7oUNHfljjOkwJ5W2U9SR2OMG3wyJJE4GJzEhCIyqzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2Hb1eBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD062C4CEF7;
	Mon,  6 Apr 2026 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775489777;
	bh=MYWbB6ymMvRbnKt9cVcsyl0G3Tc+tvo1l3wlz0ADtaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O2Hb1eBaLtGFJ84/SyNKGJZQS+eGdGzT3pc4X6tkyj5DJfUYRxdzJCCvPhPFUqtld
	 URgAXVgq3PdB8ICXDBfv0RmN4xYk9uO2COgPfmoZkjPMbGwpxY7G1UtWv7gJ3OXMLq
	 SJYwZ79Vy/pZI3ALfl/ffxH29iTUudzc6rH05+1a9Pe/RUp53aoOwypFSMSwPsIB89
	 2CZsK7ujce4jPJUJeat7Ank9YfEPA9UZFir/cGSP8h7prlekDfTyhTL0VoXLWt6NoN
	 +P7TYVKDi6IAc6n0+/577ESDpSROZb593ON8y9C0a6X3EfUjnUc33z7FdEDVhZmQLQ
	 XW8AxD5gRELNA==
Date: Mon, 6 Apr 2026 08:36:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Yiqi Sun <sunyiqixm@gmail.com>, horms@kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, Mark Brown <broonie@kernel.org>,
 linux-next@vger.kernel.org
Subject: Re: [PATCH net] ipv4: icmp: fix null-ptr-deref in
 icmp_build_probe(): manual merge
Message-ID: <20260406083615.32f44e4f@kernel.org>
In-Reply-To: <c7df7e27-992e-4973-b6fb-63cdb7b40158@kernel.org>
References: <20260402070419.2291578-1-sunyiqixm@gmail.com>
	<c7df7e27-992e-4973-b6fb-63cdb7b40158@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-275633-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9F4D3A4CE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 12:48:28 +0200 Matthieu Baerts wrote:
>  -			dev = ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
>  +			dev = ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
> + 			/*
> + 			 * If IPv6 identifier lookup is unavailable, silently
> + 			 * discard the request instead of misreporting NO_IF.
> + 			 */
> + 			if (IS_ERR(dev))
> + 				return false;
> + 
>   			dev_hold(dev);
>   			break;

See my reply, AFAIU we can just delete this new check in net-next.

