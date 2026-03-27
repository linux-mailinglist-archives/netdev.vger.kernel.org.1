Return-Path: <netdev+bounces-272299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAHOOU3VxWnQCAUAu9opvQ
	(envelope-from <netdev+bounces-272299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:54:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF50E33DA30
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F154C301CEC2
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48962874ED;
	Fri, 27 Mar 2026 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryVKUbuS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D41D5160;
	Fri, 27 Mar 2026 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774572872; cv=none; b=EiDpOEIGr3vG9YUQTyADiJHzwWsHosOESB4Vz2/lKIRVt1oGGxXwByQVfwVhZlCm+QzzAZbRUOhR0CMcEMH+Gz0xBVGSyWhpxtNH4SnGIvVgzzz6/NN2/dRQRLLawZQdPGXa/B144/REK6WFuOhNYlCX/vdeZlxOEQ7eyYWGTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774572872; c=relaxed/simple;
	bh=+FvjcGCklqo4FF90eAX6+EdtMH3jFAmS5fh8CidR4XE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFVv0tYuDHXuXEJ4RS5occQOfJomSdR2qEdjnlCidseQHWOgGjPzV3G1Ug6Q56tiXAaLd21MbI50LAo8Ff4/BgJF2I0oLwv1v4Brhyqlk0mqCBr3+lMsfLbPuGgtBT8pXIA06pubCQIcKfvRSEn1AwZ8oM6PIfhng7m245d1N/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryVKUbuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E157EC116C6;
	Fri, 27 Mar 2026 00:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774572872;
	bh=+FvjcGCklqo4FF90eAX6+EdtMH3jFAmS5fh8CidR4XE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ryVKUbuSZSdi4NnWR2sV+J8fVQtSCXdsX7N54JSdmtvdND/5Eoqf/sEVK4IziYhxZ
	 CWDCrd3sTGUoBG8zPWmzjPzsOIKFfv6YiG+mEG9Ce5ddIhZ9n8Q074i38ZItvgpBS/
	 IUicsm1KJx17eD32BauQLXhvX8VV7h/66SwnRJvTDOQSLHElVND92P7RNyVylvX14q
	 upxoeqqaRuBJd1fjDHxz/jI4zmCZ+YC0pZitFSTsXNHbrjsJXljndf4Inf6OvNFIZ5
	 QUxpwSSkZivXJH9Nll1CZOksOJwGKTjhi5waH+IR72PEBb6e5WBEeMc2HGnJf4OyKL
	 5pAHel6iCFHMg==
Date: Thu, 26 Mar 2026 17:54:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v6 0/6] TLS read_sock performance scalability
Message-ID: <20260326175430.7ceff326@kernel.org>
In-Reply-To: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
References: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-272299-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EF50E33DA30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 09:50:45 -0400 Chuck Lever wrote:
> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
> this to Hannes, he reported a number of nagging performance
> scalability issues with read_sock. This series is an attempt to
> run these issues down and get them fixed before we convert the
> above sock_recvmsg consumers over to read_sock.
> 
> Batch async decryption and its submit/deliver scaffolding were
> dropped from this series because async_capable is always false
> for TLS 1.3, which NFS and NVMe/TCP both require. Async crypto
> support for TLS 1.3 is a prerequisite for revisiting that work.

Please repost the remaining 5 patches

