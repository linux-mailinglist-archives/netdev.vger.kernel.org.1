Return-Path: <netdev+bounces-299629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M9BlObRzMGq9TAUAu9opvQ
	(envelope-from <netdev+bounces-299629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:50:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E615368A39A
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:50:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=maSZAd5I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299629-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299629-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A3813008092
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58F63168EB;
	Mon, 15 Jun 2026 21:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E312E7631;
	Mon, 15 Jun 2026 21:50:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560239; cv=none; b=Uq1EXbHDjeCvLlZ2XAmL462KWqZ135RPH4PwGCRDZ/VWnU21qLYL8QR0t6S/NBkzOqyFWDR4KTsHt70DiAkoIK0OZgLdS9m88zb6NiyW/Y2G4CuzsPfsgxtn8/AnABje+7ig1yGGTCGLIAsULxhGCadldS3S/hSA/9/wZbnl0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560239; c=relaxed/simple;
	bh=2DMamNs0h4ZXC5SkjSLbLQslhWpf5W1TUFb9UnPucbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2eHzZIz4bGt7rRtW/lC3zlq/X40k7cXH+wcjnIr2w1DS43Bpho/1ITb+rWrEO8uS+GuW108JMeJlpuLnRneCtJNJr9JW8Csg/d96PGJOsN9f+sip7ChMah2+OAbJc1VtRQU6wgp2n06h+AlLj1NhWBa4yiAbL3BR6YL5L7r4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maSZAd5I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDC11F000E9;
	Mon, 15 Jun 2026 21:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781560238;
	bh=rUmDL9/uSXnWdNDTm7S51nG4txVC/VP/YIY87isaxgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=maSZAd5Ix4BpMiX30F0b5Q3d+lU10nzTyZIx27FJJfd029aHr4x2f1z8yKBCMv8lp
	 /z4jOQ8IHcXUabZfJMDx3vUQcxHoso7jPyikcYYtAWXBC8PYetMMnCkWv3hzgiYQ3D
	 6tagLpYrjRDakp7dgixQkRaeF02O6F6kxjyjoWGGM2u2PFfuARXdj2OA/EKOW3tVKm
	 6n9D+PP/IN5vadP0crSxIKrWi9030iUreQQHWuRyAYyB1mdk/x9V2LbPOu9k3+lh+v
	 o5+sIXwV9e+nX3HBJFrnxrKD0YghMrIxysEWtztgWSeEB4P9nRvbvj1j/E0AFlLxFg
	 cx93xgQr5A+Sw==
Date: Mon, 15 Jun 2026 14:50:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH net-next] octeontx2-pf: add page pool ethtool statistics
Message-ID: <20260615145037.0970f6f0@kernel.org>
In-Reply-To: <20260615032141.521667-1-rkannoth@marvell.com>
References: <20260615032141.521667-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299629-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E615368A39A

On Mon, 15 Jun 2026 08:51:41 +0530 Ratheesh Kannoth wrote:
> Expose page pool allocator statistics through ethtool.
> When the interface is up, aggregate stats from each
> receive queue page pool and append the common page_pool ethtool stat
> block to the driver's private statistics set.

include/net/page_pool/helpers.h :

/* Deprecated driver-facing API, use netlink instead */
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
int page_pool_ethtool_stats_get_count(void);
u8 *page_pool_ethtool_stats_get_strings(u8 *data);
u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats);

Is the page pool in your driver shared by multiple netdevs?

If not just set netdev in page_pool_params
If yes then you need to explain it in the commit msg

Please note that net-next is closed for the next 2 weeks
-- 
pw-bot: cr

