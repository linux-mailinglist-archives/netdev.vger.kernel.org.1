Return-Path: <netdev+bounces-282535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N6cIqiQ8mlAsgEAu9opvQ
	(envelope-from <netdev+bounces-282535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:13:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE7A49B40C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E523D301B15F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326A93115AF;
	Wed, 29 Apr 2026 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ4uBzl0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE81285CB3;
	Wed, 29 Apr 2026 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504420; cv=none; b=kmFn7gkNp/Zqfg4AcPymLENi29sAJ13EWgBKaTTvgi91KYSfK9CYCvsbyZzG3FWylRQdbCxp93VUMnVpo9rnpi949sk9cS04zkZpUKRFW2m0EXeWUn7YThNubyBdCyLp4lvOFsuYPFBjQRqIvrOXMp/2YAmtDOiTxnxoD2/dCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504420; c=relaxed/simple;
	bh=r4aaCFBW8CcUna0et0rF+jA1Bp0/Pd1s9hFrnRnuB6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhmMtGnrECNbum2MnwYKPhJQhAwNqASt37nSJncXlkJVcnrj36DgTvc1EwZN8nHq9se1a+hn3IZ7sIs+TazdGtjiFTkkFediLYPgV9QiRPUHoIJDGFbSl/YTjz0izTqMYuAwG6SX0eSrWKcuqB+rk1MK24A34CYXUWJPR7jzwnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ4uBzl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE5BC19425;
	Wed, 29 Apr 2026 23:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777504419;
	bh=r4aaCFBW8CcUna0et0rF+jA1Bp0/Pd1s9hFrnRnuB6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nQ4uBzl0Oj+OkgzUT/eS7cy3+JOq2OLci3pu5RHAHV5GjdXVZpGI+PjooyjQ34MhC
	 NRFM9XAVZjrs90G0q4neprR8gVnflsRhGiQCpvvSpC+Vc6EZz14Az5vjCCbmzKX8yp
	 GumfHpUIdw8LrgZLh6JZqWUnLrf7YnkgowVc83VstR/lckz73FwkZ5vB1rLz2ODueO
	 CSzD3TGLuhGR/1xMFuf2huLaowACSEt51Yog75hcXsQ20luwWqAmSru9F8gfywxB/z
	 asxuJUjg5EUPWhUitYtfql+Gcuamngj2XEvDACxzwfCN3owc5G74B+XyOm2LnDVLxO
	 cljKtiyfMoL+w==
Date: Wed, 29 Apr 2026 16:13:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, Chuck Lever
 <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v9 0/5] TLS read_sock performance scalability
Message-ID: <20260429161338.6da2b22d@kernel.org>
In-Reply-To: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EAE7A49B40C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	TAGGED_FROM(0.00)[bounces-282535-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 17:48:07 -0400 Chuck Lever wrote:
> Changes since v8:
> - Address review comments from sashiko
>   - Patch 2: Requeue partially consumed skb to prevent leak
>   - Patch 5: Re-check sk_err so RST during flush surfaces as
>     -ECONNRESET instead of EOF
> - Address review comments from gpt-5.5

Is someone running gpt-5.5 on the public submissions?

>   - Patch 4: Restore msg_ready early-return in tls_strp_check_rcv()
>     so the queued strp_work doesn't double-wake the consumer
>   - Patch 4: Add tls_strparser msg_announced bit so the recvmsg
>     exit-point handoff doesn't re-fire saved_data_ready() for a
>     record BH or the worker already announced (rx_list-only drain
>     path)

