Return-Path: <netdev+bounces-283523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHrdBsev9mlyXgIAu9opvQ
	(envelope-from <netdev+bounces-283523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:15:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD04B41DC
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8FBF3003EE8
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 02:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F0535E549;
	Sun,  3 May 2026 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2mrZlwa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ABA326927
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777774532; cv=none; b=JmuxKYsE2AOzuEMbTiDl2zZhbNaLdTtov1TC3rO5KGSoDF60EUKT5CcjTXhkxHTHxvgyv5H/rUDht/Aq10E0HyKN9S2Z8KO3HxNicgTX4tqDRqUpU+cga/7cRniSkB1Zf7TZMLXfPYmBzRmsIe780dMxcDiWxf3ZedufmL/rUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777774532; c=relaxed/simple;
	bh=a5ENMxKuzSP3TLpaDvHCJ5GphbUDZ3AbNSl4cKJ3Xl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1sPp7zrMqxrfOyIn1gA1iKTtMzaep9Tx4RuYL6IW4SFDyqpOpenJebWNAH7u+eUZM2yuNYJLh7D4wI3ffT9L7P55XRJjyVs55a9PMdS/uTghvvQoojJ2Ms0CCPV8Jd2nxzTH6y7cOkRgOY1cUGso5b9+uQEzvGj8j41xZdxWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2mrZlwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341B9C19425;
	Sun,  3 May 2026 02:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777774532;
	bh=a5ENMxKuzSP3TLpaDvHCJ5GphbUDZ3AbNSl4cKJ3Xl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2mrZlwaOeeV9ZRD6LJAUxy4VNo5iUn8apEZG2Q9LXQ4S3wuq7pEz9yoNDiWH3a62
	 OhW1IfJ5KAbJ9164SzypuuLtgAyL2culsm9cxGOweu42IfpD5gEKTErMbpoDwWwQrS
	 kMYLu0Rm7A+3wyp4FpGo/1+5xb8stl2leC6Oaa3EByG1RDzghAr5FVAe+xYffVXFLc
	 p15jTrWzt70oo9F1X6o4b+o5iXHRui5rmIN0YiHim6dv0sTo8bvYhGwxc9DrxHweu4
	 AhsJUA9esPBka83X8O8OAT+aRGuswip+12GkJGIt5G5MvKrKKUrRPAZH6x02PqE3sd
	 SiPgRU6PhkQXA==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	kees@kernel.org,
	larysa.zaremba@intel.com,
	leitao@debian.org,
	joe@dama.to,
	jacob.e.keller@intel.com,
	fabio.baltieri@gmail.com
Subject: Re: [PATCH net-next v2 1/6] net: ngbe: implement libwx reset ops
Date: Sat,  2 May 2026 19:15:29 -0700
Message-ID: <20260503021529.4127250-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430082517.19612-2-jiawenwu@trustnetic.com>
References: <20260430082517.19612-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6DBD04B41DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-283523-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ngbe: implement libwx reset ops

This commit implements the wx->do_reset() operation for the ngbe driver,
allowing the library module to trigger a reset by bringing the interface
down and back up.

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index d8e3827a8b1f2..bd905e2675758 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c

[ ... ]

> +static void ngbe_reinit_locked(struct wx *wx)
> +{
> +	netif_trans_update(wx->netdev);
> +
> +	mutex_lock(&wx->reset_lock);
> +	set_bit(WX_STATE_RESETTING, wx->state);
> +
> +	ngbe_down(wx);
> +	ngbe_up(wx);
> +
> +	clear_bit(WX_STATE_RESETTING, wx->state);

Does this introduce a regression by using WX_STATE_RESETTING as an ad-hoc
lock here?

While this pattern appears to exist elsewhere in the driver, adding it
to ngbe_reinit_locked() relies on a design where background readers might
check test_bit(WX_STATE_RESETTING, wx->state) without holding reset_lock.

Since the flag check and subsequent accesses are not atomic, a reader could
test the flag just before it is set and then proceed to access shared state
concurrently with the ngbe_down() and ngbe_up() teardown path.

Could this result in torn or corrupted reads, and would it be safer to use a
proper synchronization mechanism like RCU or a shared lock for readers?

> +	mutex_unlock(&wx->reset_lock);
> +}
> +
> +void ngbe_do_reset(struct net_device *netdev)

[ ... ]

