Return-Path: <netdev+bounces-265884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN57HKqMr2n4aQIAu9opvQ
	(envelope-from <netdev+bounces-265884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:14:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C879244AC3
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8BE8301F3BB
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18CB3B8932;
	Tue, 10 Mar 2026 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUTfncbQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA773B8920;
	Tue, 10 Mar 2026 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112488; cv=none; b=GSfdoUMpeOM25tGGneoLQymXVEDKzeu9jWPcKr4LeHtr6g4JC2QCOyJW6hYbeT1Idj9FFjj32eXugAew0TsRT+69VAga06RO8VOPsQnBCxMVDQcYSh3v72rDYdbEaPv1IU6AXZItkxE0VbIA/oZM/1utTQE01C6wo1XpkkIGP6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112488; c=relaxed/simple;
	bh=KWwgmJ31cx7H8q/1ETyeAo45S86SvVyT2Kvku18GGJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWzoupbQXm9if/mQLjLIUwJ+QgyQB43VMxdkhVJuJ9g1qU0V/gvmTiUBs/EG6BhPrbNLSdopXZ3uX5xA6K0bTf9iRFXjVz+F9+tXUrDiFwtp3TP161CUr6R574WV0gvnYMBxJIt6BqUl34ztMQSYhpESNvUc2cCmrMCdVL+rrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUTfncbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54BDC4CEF7;
	Tue, 10 Mar 2026 03:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773112488;
	bh=KWwgmJ31cx7H8q/1ETyeAo45S86SvVyT2Kvku18GGJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sUTfncbQjnzfZ28bFWiED/g0tOVc+3JVksJE7ArOTdbnI5nUjSf81ArkoiifxKsCa
	 RnVF4liyp2PG30aRPbRt+HAfqVPzLoUEdVszmEr+NWrv3zTCp9KlgPhgMSKij4j9AD
	 AGkcx7Y6JiYs1yW0cEjI5T032AXj9kVFGBYl6SF+5L1SRqFNVKl4MFRRs3CzN8hecB
	 MUQTR9Hv/JxaSSzFVaGSLMUyO6UEupJTuepjqV6mPRCWpAjShkaQ6g7OQrp7dLE7vV
	 LWg4PICDaOj+qiY07JeULl/URkDkQS3SBEzSV7ybgMTMhOtXHO/zkzGWJvhVOMLTp6
	 nZlzy00pcekhw==
Date: Mon, 9 Mar 2026 20:14:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, <netdev@vger.kernel.org>,
 <kernel-tls-handshake@lists.linux.dev>, Chuck Lever
 <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 0/6] TLS read_sock performance scalability
Message-ID: <20260309201447.56dbb14f@kernel.org>
In-Reply-To: <20260305211402.39408-1-cel@kernel.org>
References: <20260305211402.39408-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1C879244AC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265884-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,vger.kernel.org,lists.linux.dev,oracle.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu,  5 Mar 2026 16:13:56 -0500 Chuck Lever wrote:
> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
> this to Hannes, he reported a number of nagging performance
> scalability issues with read_sock. This series is an attempt to
> run these issues down and get them fixed before we convert the
> above sock_recvmsg consumers over to read_sock.

This series seems to be lacking polish:
 - every patch which complicates the codebase should come with clear
   characterization of the perf win
 - increasing duplication / copy paste between recv and read sock paths
 - wouldn't the data_ready suppression equally apply to the recvmsg
   path?

