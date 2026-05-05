Return-Path: <netdev+bounces-284138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGrDIhVA+Wkr7QIAu9opvQ
	(envelope-from <netdev+bounces-284138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:55:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E214C594C
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B3DE300A309
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 00:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2062130B53A;
	Tue,  5 May 2026 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/P2jC3L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E93033FB
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 00:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942547; cv=none; b=h8m4ELrfPr7Y7UnfGDkSn0NRQYgnuO5FuVPgEkf0deQmfhRvw1RQmvVGvCbd0MKYAJ3MwB4KDdzCyrshOZlZPVdAoKfdonX09d6PbYLkPXhl7iD28v/1NpHFJ+Hky7gj4Y5b+4eR8Al1URr/pILoAuBq+3B1hFOVam+cDw07ExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942547; c=relaxed/simple;
	bh=7n8Dhc+W70n0ieiqmMjEa+CvoBFEhEcidJlMOfJYpNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IC2QIu676ifXEi30q9ABViFnYTgH8EsM5uLY7qb1N97tOuSxzBSLjGyRJSfxh147UE+nO/nyhBbfnz2IZIVStG03hgYk8fkolbdvHkmWVPxrXSDqmdoV0PCedhD1OxoBbAQSch0C3oJXIinxrr0HY5OH5ocwhSBF9tX1GU76z9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/P2jC3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B04C2BCB8;
	Tue,  5 May 2026 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777942546;
	bh=7n8Dhc+W70n0ieiqmMjEa+CvoBFEhEcidJlMOfJYpNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K/P2jC3LJoS4xXRgCuM215F64IirBTan8Mi+y4rSVEAsrwl9M/iz6w7oUYNCFUL2p
	 qjgS5/t1/gCymqSD3vbywzTKlfpMZ/O9G1ImAONC6+C6OqMjGWwStrCv7/6+2ne1lp
	 st4Dizm7zpgYoDfCRiEpXuvZKyRRDFz19ZFbEFxC5p8TyM6pjeN6/8p2C0VQirG/SW
	 1JHAWKcdX3hmm5SNVKTJrZQTagqXVRf/L2Ullw08cJUvV5+uIfVzxqneHJKmQPZGII
	 j83tJqlzoqs0DHIJRLUw1qvC81gI3sh+VICdyhIJXAMMgRn075OslCiNOp0yt2sHfl
	 LtS5tdfFqonZw==
Date: Mon, 4 May 2026 17:55:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
Subject: Re: [PATCH net-next 1/3] net: Do not unconditionally turn on
 carrier when clearing protodown
Message-ID: <20260504175545.4008c1c3@kernel.org>
In-Reply-To: <20260503180803.GA269092@shredder>
References: <20260429124624.835335-1-idosch@nvidia.com>
	<20260429124624.835335-2-idosch@nvidia.com>
	<20260501180843.069635aa@kernel.org>
	<20260503180803.GA269092@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 33E214C594C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284138-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Sun, 3 May 2026 21:08:03 +0300 Ido Schimmel wrote:
> There are drivers that only implement ndo_get_iflink(), but don't
> implement get_link_net(), so it's unclear in which netns we need to look
> up the device using the ifindex we got from ndo_get_iflink(). Netdevsim
> is one example. There are also some drivers that only implement
> get_link_net() such as vxlan.
> 
> The popular drivers such as vlan, macvlan and veth obviously implement
> both.

It's probably unintentional omission for the less popular devices.
Easy to forget to add an NDO (which is also the basis for my initial
comments).

> I added a helper [1] that resolves the linked device if these operations
> are present and otherwise returns the device itself. Similar to
> dev_get_iflink() which only gives us the ifindex.

The linked diff LGTM, thanks!

> Another option is to add a new NDO that gives us a pointer to the linked
> device.

