Return-Path: <netdev+bounces-266817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNNYAyoPsmkNIQAAu9opvQ
	(envelope-from <netdev+bounces-266817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:56:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C5B26BCBE
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A14D4301DEF2
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39CC337BA3;
	Thu, 12 Mar 2026 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deBANyDf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06DF2DF68;
	Thu, 12 Mar 2026 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773276965; cv=none; b=LMqGkscOWvjlt5UKuOvDhY9Xv0TnTZAJUTy+dmOkk8pwb5o8+BVQnB+S7Vd1U9wLxR91kjImOV8bzfU/1iB9hDS1LIWGl4gqb5SSWtp0Ri4RXxH85ztjs6peXGqdbmTjqEXF3Qxj2mW6+1j8rB4Qcby309eV7W+kdj5VKdqFnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773276965; c=relaxed/simple;
	bh=dPjYe2JMfStgHEB0UVgva8X2gHI9DeelJ+D/y9pRC9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UF7a8a8DH+ckpe+bzgKXScXB5el/xxiVZd2/UIjsb8k06cZsGFIfsZUi6w9l1yPj1Zmfd3GM7fLDaGVoicSwgVn97zFM5bEXLiJ+fgh9t/Wd5A/+kvJQccFQSUX+P1eAoVus3YhAh5TcQUYMr/vCmOiwg/jBPEvbdvR+oCR7Brs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deBANyDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97F8C4CEF7;
	Thu, 12 Mar 2026 00:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773276965;
	bh=dPjYe2JMfStgHEB0UVgva8X2gHI9DeelJ+D/y9pRC9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=deBANyDfqI0BN3u/S0MoLjpYeFOqbRRV1R8hINtx9pZkuj0WENHG3STveojBAJtBN
	 zkAZC4OZ8InVcYbgOgnkHrnWt9lK0nGB9wPfe/b1pzVqac/59wwiaz67wRdJR/Qchv
	 Zqg2H0862l1gAFWWY52k/N0b6gIFI9fRbVn5KPX+SYUPbeRFrOjFtn6VCV26zQL/JS
	 /k1p9Uvn2Z0cLZau3f8KwdrSql9ERRicQ0Bsk/cXNbLA8iPEfZOP8gdANYN4POmb+8
	 qAnDoOv6omJV6/Ml15unFubXpSlSStH8MVChvDgqmZDdsjBvXPwX6u6fJKvOx++0vq
	 ofg7uOngXd8DQ==
Date: Wed, 11 Mar 2026 17:56:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Nimrod Oren <noren@nvidia.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] net: page_pool: scale alloc cache with
 PAGE_SIZE
Message-ID: <20260311175602.62629255@kernel.org>
In-Reply-To: <20260309081301.103152-1-noren@nvidia.com>
References: <20260309081301.103152-1-noren@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266817-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6C5B26BCBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 9 Mar 2026 10:13:01 +0200 Nimrod Oren wrote:
> The current page_pool alloc-cache size and refill values were chosen to
> match the NAPI budget and to leave headroom for XDP_DROP recycling.
> These fixed values do not scale well with large pages,
> as they significantly increase a given page_pool's memory footprint.
> 
> Scale these values to better balance memory footprint across page sizes,
> while keeping behavior on 4KB-page systems unchanged.

Jesper WDYT? I'm of course happy with this simple approach.
https://lore.kernel.org/all/20260309081301.103152-1-noren@nvidia.com/

