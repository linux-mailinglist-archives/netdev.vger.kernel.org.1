Return-Path: <netdev+bounces-267814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJlYGr2htWk02wAAu9opvQ
	(envelope-from <netdev+bounces-267814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:58:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B48AD28E52F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74D53301FA7E
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192EC3264E0;
	Sat, 14 Mar 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFMMC4Op"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB53043DE
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773511099; cv=none; b=roS88OMJ9GNVsRWBN6DMATh/KhEQSTtIq93DKbUGV6UsHHyTRJ0SScH6jP9WH0KJ2AHCJrLd9ARzMZ4g34RSs919iwpJ1sZPKD8WoGriYLejP2L5vvSdSjLgIz5B939KjHhpHDZs3bGP6nUXiO4S3pxVfy8Zi4VDb721hVRnzmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773511099; c=relaxed/simple;
	bh=1HcUNQlO2NbCXrEDrW/HqrpMWDWXPBU+lOJZJkkXI40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJKO3/HBoJOaFnaTqrT6lS3baJdQ3UuPpOh1Po15xBgmKwBtJxSQ1NAyNkJ6TMU922EXvOVKVv1JXmEzXkS0mM5BBSDp/hKL+Jfsfe9GXD89zAiix32dG9uqRVubjBFJ7LDydcEGWnEXGFD7vXo/fyYvzoKX8Vb4i6k9dWCk0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFMMC4Op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B24C116C6;
	Sat, 14 Mar 2026 17:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773511098;
	bh=1HcUNQlO2NbCXrEDrW/HqrpMWDWXPBU+lOJZJkkXI40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SFMMC4Opk8pK5/5WKyMx8Ry0cY1ElhyTtaMwlpiH1dxyu+r6ykJYUJwIbxGyFRPUS
	 j5rVqFbZhc/ifwAzPw1efKvdkBt2Zz+oEa3NhQL2jraqY51zA/2f5e9TgoWYlgBazP
	 7tEvkeKhpcyHSzemk8TlZ03sqH+67MNNrxslWgpzWq4qL0FHztfbsIwsJFk3fRR6co
	 g6VIiUT6IcwwPOWLxNTr0YWGYKza37qzGc/PexNUAmkfeYQo+bXOxo0cXHrKt2z8Tw
	 7RQhgMggcCgpdqOHELxlz1psBbWSKHK1PkUMIJ3jIaLCY09vAs6pKl+Rcc8eSEc8rw
	 CMlmgJoXU14Yg==
Date: Sat, 14 Mar 2026 10:58:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, justin.iurman@uliege.be,
 willemdebruijn.kernel@gmail.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v9 00/10] ipv6: Address ext hdr DoS
 vulnerabilities
Message-ID: <20260314105817.6243c3cf@kernel.org>
In-Reply-To: <20260314175124.47010-1-tom@herbertland.com>
References: <20260314175124.47010-1-tom@herbertland.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267814-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B48AD28E52F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 10:51:14 -0700 Tom Herbert wrote:
> Subject: [PATCH net-next v9 00/10] ipv6: Address ext hdr DoS vulnerabilities

Sir, 24h between reposts, please. I could have told you that net-next
is our default tree, anyway. So you're just spamming the list and the
CI for no good reason.

Quoting documentation:

  tl;dr
  -----
  
   - designate your patch to a tree - ``[PATCH net]`` or ``[PATCH net-next]``
   - for fixes the ``Fixes:`` tag is required, regardless of the tree
   - don't post large series (> 15 patches), break them up
   - don't repost your patches within one 24h period
   - reverse xmas tree
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

