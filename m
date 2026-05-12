Return-Path: <netdev+bounces-287004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Mc+GmTlAmpEyQEAu9opvQ
	(envelope-from <netdev+bounces-287004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:31:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E9C51CBEA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63F1C301A2C8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F5495520;
	Tue, 12 May 2026 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sewt19bA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77A4963A2
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574645; cv=none; b=EJp/LlFJ4iRYPKuAlnxc1oRtCEkys9LGMjI9k9fyX7OppbKQEDF/uiWpKidJO3ljat1u+HrZSu5VslJaJqmFuZkcfZ8qYG77H3fvJTcwyT8LTMA2EY022KTT1uZJqVPOhvXE78KhtZjCCfTK2DgQmoveCz/sv9EKERHZTfeC9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574645; c=relaxed/simple;
	bh=19uuXv4pdoyTiWt0tFxHqabbMaASusFxj4gnMjn9RGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ1pmY95qPCq0ipdGtz/aVcDPlqt0+kX+ok1Ji0FJ5Ad4/6dB5TWbK2Lx/nCity9ieotKv4dyKstt3A/abD5ZoMV9h5eTDRZyTeJ0wkw7t5GiA5uj2ymvmipgo8cQiBPmfXJNLlSI0At4W5Sl29UvnSnSDdCQsEAXCDcEUW+bUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sewt19bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C511C2BCB0;
	Tue, 12 May 2026 08:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778574644;
	bh=19uuXv4pdoyTiWt0tFxHqabbMaASusFxj4gnMjn9RGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sewt19bAtR5FgkB5KExPONXLTnGPJQ26nHWeKtWYMGN6hEnRlg38ay+pvSmtFjI1R
	 W4xkIc56LPaQ2JfgbnBDz07XDYwoBbLAkcQbGAFzxc2J373ICJetHzd9wV2wYKp8Sh
	 S1fVTgYfhsMOW9q3MgrGutGb9sBZaIDjApHLL/1E0v81rKDyRuztq5z7zCbm0nF5aG
	 wcbKBj4kkT33rlKTybLVgzV8ZO0Rsw9vXFHCdGa9pbwZg4lPtfHIV1ag/hYNDKd87i
	 FrX7+YmZfk+De57ZQ6NKWN+SX8vi1lawS/TiBkxp2EGThosWNkg+c5lAStwIzhw3ET
	 IHVPtF1QFxixw==
Date: Tue, 12 May 2026 09:30:39 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Wei Wang <weibunny@fb.com>
Subject: Re: [PATCH v14 net-next 0/5] psp: Add support for dev-assoc/disassoc
Message-ID: <20260512083039.GG27589@horms.kernel.org>
References: <20260508042611.130945-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508042611.130945-1-weibunny.kernel@gmail.com>
X-Rspamd-Queue-Id: 64E9C51CBEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com,fb.com];
	TAGGED_FROM(0.00)[bounces-287004-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid,fb.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 09:26:05PM -0700, Wei Wang wrote:
> From: Wei Wang <weibunny@fb.com>
> 
> The main purpose of this feature is to associate virtual devices like
> veth or netkit with a real PSP device, so we could provide PSP
> functionality to the application running with virtual devices.

Hi,

There are AI-generated reviews of this patchset available on
https://netdev-ai.bots.linux.dev and https://sashiko.dev
with some overlap between them. I would appreciate it if
you could look over these and address issues that are
either introduced by or effect the functionality of this patch-set.
I suggest leaving other pre-existing issues as follow-up
so as not to expand the scope of this patch-set.

