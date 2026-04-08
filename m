Return-Path: <netdev+bounces-276312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD6wKGL/1Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:10:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A6F3B7EF9
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF658302AE31
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6853237266A;
	Wed,  8 Apr 2026 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k41L79SI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AC52367D9;
	Wed,  8 Apr 2026 07:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632005; cv=none; b=h5Ci29PGynzSHXUECetluZmUlC/EehdjyjnTaRDvAudP8p6q0yIz/LJAauB2OPB7pJ57cQEkUolN8bo6Od4Kp0qqvmMGiyVEwryk4HkECymUCC4VR4qHZwj+EVNdsiGIaW/8wk+g6P/KJaJOG4u/p0+8h09EIAVo6lze0cNZjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632005; c=relaxed/simple;
	bh=5RpO5nqi0Qqh1hOnIYFFnZ/QZ0Tn4Y20lPuI71HCfzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jkvfl+6k2x8ZtYzq56qgZVz9vIwufD1Z6V0RPL+iR7dOBN1q/UhYDMT5J+Ss/uPat3BTVhkbiR48muKOwMt2SCTyWj10932OzIf4jhtp+0ayp35uCA/Nfc6JMkDCjcPyXiQpotvCO6tZeig/Keu9bY8M/xUYOuqaKgTLZuybC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k41L79SI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FFBC19424;
	Wed,  8 Apr 2026 07:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775632005;
	bh=5RpO5nqi0Qqh1hOnIYFFnZ/QZ0Tn4Y20lPuI71HCfzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k41L79SIJiM5WqyLTBoBGW7r2qPtkFVHzibbF6pSMUoAydWX01XuSbGfTN3AGRqzv
	 SKUhoJUVgEP9wpEHNVJdnMsyj66IOwpRsjgR0nrN/wGogpvPbcioCLzGY68aRi51/9
	 7BlOw+JTDn6aXB2/vbJCiNGByB3zVs2MLdxJ4lEitvV6Pyd/ltfE4Inyraclc3/cKM
	 YLmI6bASiucXjIzFyQ+LtHYTg754fyuNi8dl11DoekwavyAUTKvtyw4TauJDUrG3p6
	 SmfN9Jzf/Cgg0ZIqGo8cTxbgY3eCAUB/Zrl/K/SM869TGIFxEHS2jKi5BU8eATE/Ot
	 //A/SUgs/RU0w==
Date: Wed, 8 Apr 2026 09:06:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: ti:
 k3-am654-cpsw-nuss: Add ti,j722s-cpsw-nuss compatible
Message-ID: <20260408-lavender-wildebeest-of-freedom-ebf1fe@quoll>
References: <191e9f7e3a6c14eabe891a98c5fb646766479c0a.1775558273.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <191e9f7e3a6c14eabe891a98c5fb646766479c0a.1775558273.git.nora.schiffer@ew.tq-group.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276312-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,tq-group.com:email]
X-Rspamd-Queue-Id: F2A6F3B7EF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 12:48:01PM +0200, Nora Schiffer wrote:
> The J722S CPSW3G is mostly identical to the AM64's, but additionally
> supports SGMII. The AM64 compatible ti,am642-cpsw-nuss is used as a
> fallback.
> 
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> ---
> 
> v2: keep ti,am642-cpsw-nuss as a fallback
> v3: resubmission for net-next, no changes
> v4: remove redundant items: level

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


