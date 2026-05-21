Return-Path: <netdev+bounces-290177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KSlMCxXDmoZ+AUAu9opvQ
	(envelope-from <netdev+bounces-290177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:51:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B8F59D6A1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4EC33018773
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6144B274B2A;
	Thu, 21 May 2026 00:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLpc4G+R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F0257459;
	Thu, 21 May 2026 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324351; cv=none; b=BA+P8IAThWyA0kgPoG58RyZ+dTCxdTIhDkLj51GneC5CLheXtw7zv7IYOgOJfH/KfObCh/HGtHJQQOffRj4HGeD+Ay7BEW6lWdUXsAQJB7VEPNj+AxQsHJToZvOCL9RDc+BxC9GY0XNBKjqGJ6MIKP3hTSd26C7wTCA/FJPMCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324351; c=relaxed/simple;
	bh=B/ZeesevxXHRQd2uEWIIOWvHeWpFAm1kO/+BiHAqmnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/Uy+Z4N5JdIrCHNU9eP+dHYW3cKvQhbyxrqNRd+Yn8VwNM7yQiDwYUT+o9qJHmgYbBfIU1lyZJBB1rL/hMtHr/j5YlGP64QB/uwy+nCgcwDNkwBpIReGh00SQ2YADfz95rd+X88HupSrZz0CT984KFk/Iclr3lz1oqoY8jvdd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLpc4G+R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBA51F000E9;
	Thu, 21 May 2026 00:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779324346;
	bh=d/GjZWbX9fuiG28r9u5wb4+qykcdkLHar6zri5fQxHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RLpc4G+RqTO3RNeHjmqFeFE4bAmLfOaNRO/Qau/Y9ZFbMqKQVkXVg5k4L1YGNHqwB
	 qmcqUl/cjm5QcA8RUa92cKkvZfTLk9XY0wrblhcjKyi1BbKfCfuqhSb42WbOyUuJcO
	 oWL3h2EHZTvHSqOMjXlRWjkXM/rwk6abKxcpabpD+YBuw78dDnxFW2zcHAZO+FDiNr
	 aecYjPKIgXSfa6gOkcGEJBDvISX2M05D+1IJKJRDJZzuq5izRhRLHaTHOt3Aot+CMZ
	 9hQbKWO14EqyrG7CnBuKvVFbdLkorew+LxX/4vsQfdWh5kn9L5QXCpxXHMoTCXBL9v
	 x2LyOwzxnQ8CQ==
Date: Wed, 20 May 2026 17:45:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "open list:FREESCALE QUICC ENGINE UCC ETHERNET
 DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack
 handoff
Message-ID: <20260520174545.69766438@kernel.org>
In-Reply-To: <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
References: <20260517192856.3925-1-rosenp@gmail.com>
	<20260520165746.7ed10c7b@kernel.org>
	<CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290177-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 17B8F59D6A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 17:39:41 -0700 Rosen Penev wrote:
> > On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:  
> > > Collect received skbs on a local list during RX polling and pass the
> > > completed batch to netif_receive_skb_list(). This lets the networking
> > > stack process packets from a poll cycle in bulk instead of handing each
> > > skb up individually.  
> >
> > GRO should be even better.  
> GRO will result in slower routing performance because there is no
> hardware checksum.

Mention this in the commit message too.
Network adapters without checksum offload are pretty rare these days.
Speaking of being old, do you know if this driver is used in practice?
Maybe we can delete it.

