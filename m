Return-Path: <netdev+bounces-291355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENtBBWVrFGoTNQcAu9opvQ
	(envelope-from <netdev+bounces-291355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:31:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D40C5CC4DF
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E1923006B24
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCF82F7EEC;
	Mon, 25 May 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROkfkZv5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA6277C81;
	Mon, 25 May 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723103; cv=none; b=hHvIMcsXPkM7gfQG6Ya5KQ563z0IKvtRNKf2T7LplZ4NIQ717zVW9hxNXcRGVnf5hgSkgB3zmCSBjOGIr9tWufzSf7F8LZqw1UkIisKyhLb4uXyP2g2f9hY7L6oRT5C0zB9A561zdZdVer1/Ul/+vQ514JVnk+kRrhdYmNTa4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723103; c=relaxed/simple;
	bh=ORGjYHl/HM7l84LJtx5PLD5qwCR4MVymJb5I4nlfswQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMD4sXmouO6zir0EFx7zsSXhjBkVwQFvwVWKnL5ugmw5JWWZZ/0JDZpw3nN1slHtBEj8RWuLEkze+cKNnVFWiD5aGQkmukqUm0OMe2TwkIKwpfLet1uv8PXL5gTKE+PJXZpiY+VXWDfyciH3oVoWU8iQxsgRkL40mc8W7+tA1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROkfkZv5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A1A1F000E9;
	Mon, 25 May 2026 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723099;
	bh=GGLO+57HKF/dJaE+tp9cJyavkQ/nGo6YVkQXb8u09vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ROkfkZv5FMuBWEzwxwp9oE/7oknG58Uo0IbOe+vEAcwNATR1q9uTXS9BDEsKtnQKJ
	 1QrKUEbJppA+r1Lz4zF5TNte0Gpu5BkDhVxqKGKuunIdmb0te/LnuW5LVXHbhR3ENn
	 w57fXSfW+kshDFkX1asKjQGqivxOMi3aHQNIg6/k3xshPtDmONyG3d7S2M2ckYeTm6
	 4PWDfcOqMrETWECexamE1lorm9LAxcYxs630WpBTZjW9vqFL3HPZC3IN2AxOawTu7V
	 OMzvSCqsal/1SkKYDDWhC3VYBVP8B6tl7RRmbYE9wP5Vj/QS8V6VSlJO2ZeB8hemSr
	 7A5vysZ1LLsBA==
Date: Mon, 25 May 2026 08:31:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul <rc@rexion.ai>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Alexander Aring <alex.aring@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: rpl: fix hdrlen overflow in
 ipv6_rpl_srh_decompress()
Message-ID: <20260525083138.124503ac@kernel.org>
In-Reply-To: <20260524115301.905478-1-rc@rexion.ai>
References: <20260501164242.419cc17e@kernel.org>
	<20260524115301.905478-1-rc@rexion.ai>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291355-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8D40C5CC4DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 24 May 2026 17:23:01 +0530 Rahul wrote:
> Signed-off-by: Rahul <rc@rexion.ai>

Real name is for example what appears on your passport.
Or the name the community knows you buy.
I'd venture a guess that nobody among the maintainers ever met you
in person so the "passport name" option is the only choice for you.

Also - please do not post new versions of the patches in reply to the
old one.
-- 
pw-bot: cr

