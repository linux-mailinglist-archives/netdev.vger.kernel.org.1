Return-Path: <netdev+bounces-261163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCIpNLW8n2ktdgQAu9opvQ
	(envelope-from <netdev+bounces-261163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:23:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 447191A07CE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98107301E220
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076A433C53F;
	Thu, 26 Feb 2026 03:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpnQDj4b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F92727E0;
	Thu, 26 Feb 2026 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076132; cv=none; b=kFbIzy/wfUK++44RYerLGJFU6lUgOFEQ5PHE4vf6mGW7eq8oL87OV7dO8pzQkxnDv7oTthtOuI4FF+bXpDUTC+gnE9Z8DFA8BYdAZ7TgTSyu4+Oe6BdtUYlgValuljhaBfNGX6BoTaoEqrt+/1MQtz9E6dP1yEIW5OhK8TdlLuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076132; c=relaxed/simple;
	bh=2QlABgjkYgzDNl/L4s/2jLxI9ybi1SP5/Y0C3gyCMtY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3630ekyuuDOWTeuKf5NdNK6Ybpu4xuf7k5wO78803PoEqpSc7D3GxKUq+RGLcU3FlJAygZQ5Qba7uGOiuhe8yKMDddTnRcpMdn79O16JuixRdCBvBGkVbpNgRuik5Z/4mJHdZvf6FvIeU3DVZu0bikMlPpo1waEIbxsgFbWXsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpnQDj4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E593C116D0;
	Thu, 26 Feb 2026 03:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772076132;
	bh=2QlABgjkYgzDNl/L4s/2jLxI9ybi1SP5/Y0C3gyCMtY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JpnQDj4bBYUCkUnn5wfIVMULSTRQjuMv7Zu7fDYQZ7tlY6Q7TSeYArrCsNx0NOeBN
	 9hxGgQdojv5s1TdXou/NTllfJM2Dep9WAQ4velv1KM3x1yXBKP3O6+HzGCR8P9sMcs
	 ZeEgK6cwd0xJKl6cbPcAhXJS82IP+O4PxOzBcefhVGW2DOi1dnMmKVQcsSSbXaie1O
	 1bl/ErJsVgiY6mUGeCsIgG1x4ZAHKOfqs82eKyjZROCU0F9d512DIzzns93RBxVlXT
	 wC5bArQW2gOZcr72dntukJtqwi5cX3U4W4GnmaVhFKG/PCPA0wqCW/KPRPSAfREQor
	 b5K0E4qlSyqsA==
Date: Wed, 25 Feb 2026 19:22:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, jdmason@kudzu.us, dave.jiang@intel.com,
 allenbh@gmail.com, ntb@lists.linux.dev, netdev@vger.kernel.org,
 alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] net: ntb_netdev: Fix NULL check ordering in TX
 handler
Message-ID: <20260225192211.7a8e1be8@kernel.org>
In-Reply-To: <20260224130458.1355686-1-alok.a.tiwari@oracle.com>
References: <20260224130458.1355686-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	FREEMAIL_CC(0.00)[redhat.com,google.com,davemloft.net,lunn.ch,kudzu.us,intel.com,gmail.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-261163-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 447191A07CE
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 05:04:47 -0800 Alok Tiwari wrote:
> ntb_netdev_tx_handler() calls netdev_priv(ndev) before checking
> whether ndev is NULL. Although qp_data is expected to always be
> valid in normal operation,

Right. Can we delete the seemingly pointless null check instead?
Defensive programming is discouraged in the kernel..

> dereferencing the pointer before the
> NULL check is logically incorrect.

If you strongly prefer to keep the patch as is maybe say "valid 
but surprising" rather than "logically incorrect"

> Move netdev_priv() after validating ndev.
> 
> No functional change intended.
-- 
pw-bot: cr

