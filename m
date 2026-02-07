Return-Path: <netdev+bounces-257707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vjrRFBCrhmlUPwQAu9opvQ
	(envelope-from <netdev+bounces-257707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 04:01:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA6C104BB2
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 04:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01FA83015737
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 03:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5472FFF8F;
	Sat,  7 Feb 2026 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fle9I33Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5531DF273;
	Sat,  7 Feb 2026 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770433291; cv=none; b=gIAtzQeUx6JEA461PeVW1cW4uDDM9MV0BcUCUZ6lMbNhAp458cCs64JKU4janFHG0OyIVQlNHg9hBg3cTuibBNx+T024njQC+FdmRA2e4q7r4GcAalN77xwzH3PZpPFW1vQvmfYuYj1sh9DJQMZyuLogNqbsFgcqq/kLoeqPfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770433291; c=relaxed/simple;
	bh=gG61rk2O0dRYFDUOE2SQNbQ8F0SYd+0v0B67KEqFrL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTltjEUDeOjeGFuEWp7tTUNjbFxjMDbB4gnbppBTnzKUaFw+zlAimd2xoOLOuiw3YfIf08yAsW3e0Yn2GYB40n2den7HTjPa7jIzNrc1PQOZkVlECIavAaNgtXOLFSrFRA4eLfr8+hDI4M7Br6NPeDehEySMcLiyv4pU/7yiyJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fle9I33Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82555C116C6;
	Sat,  7 Feb 2026 03:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770433291;
	bh=gG61rk2O0dRYFDUOE2SQNbQ8F0SYd+0v0B67KEqFrL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fle9I33Q3PwKzZRZ9RJueZu6sYRgp7841WaK/FsCN/nSG1CmmpwhEg7VMf9tSisWi
	 HYAyqris5zvmZvIXgDkwgUEfAIX1m32Mxn0AxHXV7L77YT11IYfWVZMtNgCL3QPPfV
	 0hvhxb2DDsRPv3jFws/tKvfUGCzf+07kK0SbnAt2TeOE52FXmxv8xNOshlUvJy3tTL
	 oUzjNSULridPpLnejkN4U4ogU88m+if4gWKAUc9RZqbP9tQ1ImqPaShV1kwmSKXnCo
	 bpIgnt1JTKTaFini4H0BeCfcThYRWAOw0TIdSXEqTe1hLyVifjUhIMu+/v1cu3nL5X
	 vvj5mqG5KdDcg==
Date: Fri, 6 Feb 2026 19:01:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: jacob.e.keller@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Stanislav
 Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] iavf: fix deadlock in reset handling
Message-ID: <20260206190129.062cd792@kernel.org>
In-Reply-To: <20260206100426.106082-1-poros@redhat.com>
References: <d60cc9fd-70af-40ea-9023-78bbbf91766f@intel.com>
	<20260206100426.106082-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257707-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BAA6C104BB2
X-Rspamd-Action: no action

On Fri,  6 Feb 2026 11:04:26 +0100 Petr Oros wrote:
> Fixes: 120f28a6f314 ("iavf: get rid of the crit lock")

This is so much better =F0=9F=91=8D=EF=B8=8F

