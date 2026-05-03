Return-Path: <netdev+bounces-283508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHpdO/Si9mnuXAIAu9opvQ
	(envelope-from <netdev+bounces-283508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 03:20:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719AA4B3FB8
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 03:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE36B3007F7F
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 01:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860741BBBE5;
	Sun,  3 May 2026 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCjLdl5z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD340DFD0;
	Sun,  3 May 2026 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777771250; cv=none; b=CkdG1Py8LZPsAdCpN6eb3TdqwXPEhdUxcwMhXouR9SlKTrxaFf/nnra+ytdTxCh7nO0gsnt2cEoOCWkCeku1sPNB5tpJl8YufQwotHwDfHPUKRnZ2Kq1KaU9QWBeZ1yEKCy0e++aCVvY/n5a+INthKhJOBHtlKcaNY7tFB6f1A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777771250; c=relaxed/simple;
	bh=ln2M09XWydlYtx6k7ddVyvgKTW/RvzXpdo9wALFL0Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6KHHQEcYBZdMEyWQtTzLgilYQ80AZJQMDR/HhUlXNlpybJyl6abtFXn39eWDUN35PgzBWN8kaCEVwAK45pDhc0YBwYN1sLV66CcNZdXCpAUGyTb+kuWeEoh+83otpAQAr6I5BBLTR5kbXHs9kuj1arsk1nai2ptBnKHpILPV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCjLdl5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9108BC19425;
	Sun,  3 May 2026 01:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777771250;
	bh=ln2M09XWydlYtx6k7ddVyvgKTW/RvzXpdo9wALFL0Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OCjLdl5zXKff/kB+78LtQ6sf8bP55M3eUQtaOiHtVx5nlAK5gMjd+ZilsV1T7Pmt9
	 kNOIvbJgIzV3YUc+szaTTp9foWeK/5sjlm6rJ1XAWbx2KMGz4a2HI+Ux5BO3OYqv6L
	 nhBKouod9kipoUiGvmw5YXTxIUBlaM9U5AuUB+gbhkOGgbCi8LyZclV751dtt4Q7yH
	 Z5iBn8GpnBXaJlnYn0ukeBw4bev3+X4xh2mTvGmianXSjIHx4raWPTCXzT9BMrmjZp
	 +i9Fk0FnAKtbzEnHLRf9yDqB37F3wMsj9hmuTZInnuQrsWW/RSGLiLSxZY2c5W16+j
	 U7JLC1B/pDkSA==
Date: Sat, 2 May 2026 18:20:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, Chuck Lever
 <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH net-next v9 1/5] tls: Abort the connection on decrypt
 failure
Message-ID: <20260502182048.2c4d8314@kernel.org>
In-Reply-To: <20260429-tls-read-sock-v9-1-39e71aa7810f@oracle.com>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
	<20260429-tls-read-sock-v9-1-39e71aa7810f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 719AA4B3FB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-283508-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Wed, 29 Apr 2026 17:48:08 -0400 Chuck Lever wrote:
> Subject: [PATCH net-next v9 1/5] tls: Abort the connection on decrypt failure

I was gonna apply this one but the subject gives me pause.
It really oversells what this trivial refactor does..

