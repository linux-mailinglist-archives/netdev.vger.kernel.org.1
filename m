Return-Path: <netdev+bounces-263779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB3UEuIbqGmYoAAAu9opvQ
	(envelope-from <netdev+bounces-263779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:47:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ED41FF40A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F130F30DC5E2
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD33A872B;
	Wed,  4 Mar 2026 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXOmIPJb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADCF38757C;
	Wed,  4 Mar 2026 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624607; cv=none; b=i9wk+cAfW5lrMht0YgbYrxWjNnt1Fb6UwMPaKItmh+rNLhf0XcQUtG81C10JAhB2DGhzYDRuMw85lNtR/YbAj9eSIZohvbtU2EuLOpm0E6VUeeZdzteL99JGK/jYuGyDTjjN3ESkUS6OOemRST38wWcm66k1WQ5QsUDrSwpphQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624607; c=relaxed/simple;
	bh=RdeQxpM446a30snr6DksUquAKJ3HbafVGgNp+XRn85U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMfUuYt7f1xlabzE8w1MN7HDuX0Cv4kXJ3MmgwEFPj5QciUdVnCuoWbGMk7/4lPb37ACg7A+e6wSQdal/kvcC30TmrUAvrAxlUERKqKQf2H6pUik++YErj3gOCdt0a5nve+oK19Qfjhalcm65/IQL+UjqLwxgTPfZ13brv/Z6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXOmIPJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC93C19423;
	Wed,  4 Mar 2026 11:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772624606;
	bh=RdeQxpM446a30snr6DksUquAKJ3HbafVGgNp+XRn85U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SXOmIPJbVZrOiDQdxxHApj/MW4tElG/4y1VDKOns6EUYefWrdr3Nr/hORg0FG/nKl
	 sf1jwiYbcTZbeo7mP4eRySpZJ31b4r6vFlDZoXwGsaYxUbLpzcmLCpyPBnaQMF2w6D
	 zSU46tKdc/tDIq/9Axq5QIFsmPRUOfKWlu4Ek0SCjV2XwQQi5WJbOW0k2GOs11f74U
	 HNyTzaWEX5p6CpRYLaPACt5i/fuBO1I2z9ZS7nlX24pj9dCw8AZa5ERaK5bSsLmVrP
	 zWxfSaQ2ripq1cTH+j0Ox0ed/JrZaAKczpFk/forHoP1khftNCM5CvekS5OYqimc8h
	 OnrLrF99lt4nw==
Date: Wed, 4 Mar 2026 11:43:19 +0000
From: Simon Horman <horms@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Airlie <airlied@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v2 4/4] drm/xe: switch xe_pagefault_queue_init() to using
 bitmap_weighted_or()
Message-ID: <20260304114319.GI71509@kernel.org>
References: <20260302011159.61778-1-ynorov@nvidia.com>
 <20260302011159.61778-5-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302011159.61778-5-ynorov@nvidia.com>
X-Rspamd-Queue-Id: D7ED41FF40A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,linux.intel.com,lunn.ch,linux-foundation.org,gmail.com,google.com,kernel.org,redhat.com,ffwll.ch,rasmusvillemoes.dk,lists.freedesktop.org,vger.kernel.org,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 08:11:58PM -0500, Yury Norov wrote:
> The function calls bitmap_or() immediately followed by bitmap_weight().
> Switch to using the dedicated bitmap_weighted_or() and save one bitmap
> traverse.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

It's not entirely clear to me why this patch is included in a patchset
for the ice driver.

And it's also not clear to me why, but allmodconfigs - fo4 at least x86_32
and x86_64 - fail with this patch applied to net-next [1].

ERROR: modpost: "__bitmap_weighted_or" [drivers/gpu/drm/xe/xe.ko] undefined!

[1] 2b12ffb66955 ("net: mana: Trigger VF reset/recovery on health check failure due to HWC timeout")

