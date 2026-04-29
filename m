Return-Path: <netdev+bounces-282165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGpOIPFa8Wn/gAEAu9opvQ
	(envelope-from <netdev+bounces-282165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:12:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4FC48DE46
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2C623007377
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE67218592;
	Wed, 29 Apr 2026 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBdtUJ6j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3B81CEAC2
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777425131; cv=none; b=CPiZFmhkUFRNC/CbgYJEGgUlnwTUYLODHIVIySGPZACgC5FrtgwV6W/9WhGu5OGaYjhQzWzaWITgpSKhVYXKDYXK+h8gX/uouv3o+mYa7joEiItgjMSx+dKHRJ4cRCI+oya9T5HMgJevIfRljgIl+xs+Tmyefir7ZI8ixCFs8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777425131; c=relaxed/simple;
	bh=iAspeg2HEHyp9VsWHEYlVw3gB9JMUmPZ2mxq92JM/E0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y693uo0+Q3fhjidVuvLmzRYANwtSvV0p3ZPQAfhv0mJm2dxI1+qK3pt5g+YtDR2MPcNLqmRA8U890ETIPr9cJZhRrR0bDSGQBmExsGJjSsTsgXQt5gh1XBGCXt7sA8cudaLFSq7qdC6yKT4LPNEpYLKhaczNF9gZF3xRONtggik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBdtUJ6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66561C2BCB7;
	Wed, 29 Apr 2026 01:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777425130;
	bh=iAspeg2HEHyp9VsWHEYlVw3gB9JMUmPZ2mxq92JM/E0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YBdtUJ6joIAT/5SRxp2C52jTJ2KGjmBlmfjhqZLkkmIIAJs9nahWYm5xr+jYFo9H7
	 Y8XvJkZtlKth+N/0MsNWuTdm5xtAIIuOcIZsyvVe34dYsOXZf1HI6Dwbhld6RWA3nu
	 dNMQl7JmG7jeScoYfVYNcp7ZnE3NL2hDfCFKtb7jyaGqIymWE7Uftom3m/68PVHbDG
	 SGwedaEef6bgG4tZ719goeBc74O8lY8NwYGl8gJo3Q0otuk6047UmmX5wCDzYvW/fv
	 H5dbNAicTdDLWLTIfCQk+S5hTWiCOwuT1ak+gMleiDQ1OQMe9mqfW6Cd/5a6tBM29I
	 Kg7UhsOMgnfIg==
Date: Tue, 28 Apr 2026 18:12:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: netdev@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 2/2] net: thunderbolt: Fix lockdep issue during tunnel
 tear down
Message-ID: <20260428181209.1cca85ff@kernel.org>
In-Reply-To: <20260427081623.2338179-2-mika.westerberg@linux.intel.com>
References: <20260427081623.2338179-1-mika.westerberg@linux.intel.com>
	<20260427081623.2338179-2-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3A4FC48DE46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-282165-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 10:16:23 +0200 Mika Westerberg wrote:
> When unplugging cable with lockdep enabled it triggers following:

Sounds like a fix, should it have a Fixes tag?

I'll also send out the AI review but on a quick look not sure if any 
of it is worth addressing.

