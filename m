Return-Path: <netdev+bounces-275295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAf1BBBV0GkA6gYAu9opvQ
	(envelope-from <netdev+bounces-275295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:02:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2A53992A4
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA3B230209CB
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252241548C;
	Sat,  4 Apr 2026 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcB0yCwV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02134186A;
	Sat,  4 Apr 2026 00:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775260888; cv=none; b=opUE06OohSGzYrSf6jDPDeEUUK/K4Z4lt72DM0y9jsH6wH5XyBQ6A60yb022auvuFdQqqsh1QQsgBOPbAf14j8g/UGaGNu2VfoJvVC61se0ADmhZODQ47EfhblTMkaa4DCidVu1s9HlaTD0TS97WmL0Fqper5hS2TiNu6JwmPRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775260888; c=relaxed/simple;
	bh=bNNcDrtNN79duLiVkQQ6cLnqJmh2d0HGN04f1nN0EgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaCgdq3tjInLdMnHoMX8uN7O7LCtf/6+lC6Zuf3XqBI8jVyAjGCSTiA7xNRGbSmmV2jLNt9mEfWtFHaJiJxQFFjDZY1wMEmAUGcIJGCH9WO+ghNX9amN0a7Kshhm77XczKeJpQCK5bZ+xEH/ON7kMvKkUpJMHz5cUKBmzO9nEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcB0yCwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252CBC4CEF7;
	Sat,  4 Apr 2026 00:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775260887;
	bh=bNNcDrtNN79duLiVkQQ6cLnqJmh2d0HGN04f1nN0EgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CcB0yCwV1VFrHA31Qi3rnveP9qR7FZ3ayZA2lNBEVbbf06jhsXbMT499hYfrPs11L
	 DV3eDBk/n4B0jZWqtYlEINCoakh5VcXORl307cHAaCWwrLqAyF4lP9ijDhJ6opc/fU
	 /IaFy6ie/V5Xpi2Ef2+D7TQphbraRiOayvyu4emcLeJVm4z3xtg6S6y1vxv4xTf45U
	 tBYHlFDdctydJbL4BerwLekoU3O7gJ7YlTFlEsylh/uS9xXCoiqo2KmZxCRPllEizE
	 lQe4XTQXYiEDFZ03pgkwrxfzMZ0UEbnLBAM0Mo4BigmqXWfaE61AjxuwRanziM6Vs6
	 ZoTnt6Wfh+0Dg==
Date: Fri, 3 Apr 2026 17:01:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, bjorn@kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v6 net 1/8] xsk: tighten UMEM headroom validation to
 account for tailroom and min frame
Message-ID: <20260403170126.276f9623@kernel.org>
In-Reply-To: <20260402154958.562179-2-maciej.fijalkowski@intel.com>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
	<20260402154958.562179-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org,fomichev.me];
	TAGGED_FROM(0.00)[bounces-275295-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D2A53992A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  2 Apr 2026 17:49:51 +0200 Maciej Fijalkowski wrote:
> The current headroom validation in xdp_umem_reg() could leave us with
> insufficient space dedicated to even receive minimum-sized ethernet
> frame. Furthermore if multi-buffer would come to play then
> skb_shared_info stored at the end of XSK frame would be corrupted.
> 
> HW typically works with 128-aligned sizes so let us provide this value
> as bare minimum.
> 
> Multi-buffer setting is known later in the configuration process so
> besides accounting for 128 bytes, let us also take care of tailroom space
> upfront.

I guess it's a bit late to ask this, but am I the only one that has
weird feelings about shinfo living in user-mapped memory?

