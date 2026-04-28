Return-Path: <netdev+bounces-281950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBcgCbjR8GmRZAEAu9opvQ
	(envelope-from <netdev+bounces-281950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:26:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F112487CD1
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21928306CB36
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD7D3AEF20;
	Tue, 28 Apr 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+plPVOQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4B37DE89;
	Tue, 28 Apr 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389897; cv=none; b=h0ykDoJyz1ak88cZ9qDQd9nfHWTaLrzRJxfcAaQevKzr2TEePtbLpKgm7h8jgNp8SDItZbIuKEPLsXnUkLNeNuG9670IkGiQsryp/VenriBN72xqi1YKKwuwMUoeT3Rx+021H+XshC/qcQkUqGJQPmYFam4R2ge8TP5W1Z8HbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389897; c=relaxed/simple;
	bh=56Fp1yQPL8pbpZYpADUm+ua5tJZNW5aTo917mksvWMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sngTua2n8slYsIff4KTDMcF5tC0bw4NyVINle8q5QMdz8wOXHOoo4IkzTkEfxafVD53MwSW1KrcB0gZmu8Oo2Kg8D8zJMWAt6Z5zUfSbkXuweiqlzmSXEod5+PLKhAKFWI+CIskExEqoT2MgQt+0/3OBc1M+EPCP9CjJBDeH3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+plPVOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9653C2BCAF;
	Tue, 28 Apr 2026 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777389897;
	bh=56Fp1yQPL8pbpZYpADUm+ua5tJZNW5aTo917mksvWMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+plPVOQv500ll+e4hjLw6NUVnL9xzT873IIUwha2+BAHSaqkAgIvfFaL2ll11pIM
	 iOJkOicx+nzEBTKpOJlRACscAYrUl1RXmQilovG07BQmWRWm5j3DCFiTs9dopoUwxW
	 w7nHJZ35Qx0KGzTjLIvC+fELAKpnagWeCMg2hi+3wMZBLo9FzZfkWdnulcYsMY5XMT
	 vvC8lpiQ6o5gi3Cq8cDoyDfBLQz7aH4JI3fCwYOX9sHaErHBJTJG/l65H0FM8mbm1X
	 yYm7upRRzmrzCdszMwondkUVONGtqbL72uo23OHSpJaaxaZv3hpNJahKKiKFxAS2Z7
	 ot7V1Z5PTQhhw==
From: Thierry Reding <thierry.reding@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: (subset) [PATCH V4 0/3] net: stmmac: Fix Tegra234 MGBE clock
Date: Tue, 28 Apr 2026 17:24:49 +0200
Message-ID: <177738985822.3914480.11384945974455400904.b4-ty@b4>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401102941.17466-1-jonathanh@nvidia.com>
References: <20260401102941.17466-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F112487CD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-281950-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Thierry Reding <treding@nvidia.com>


On Wed, 01 Apr 2026 11:29:38 +0100, Jon Hunter wrote:
> The name of the PTP ref clock for the Tegra234 MGBE ethernet controller
> does not match the generic name in the stmmac platform driver. Despite
> this basic ethernet is functional on the Tegra234 platforms that use
> this driver and as far as I know, we have not tested PTP support with
> this driver. Hence, the risk of breaking any functionality is low.
> 
> The previous attempt to fix this in the stmmac platform driver, by
> supporting the Tegra234 PTP clock name, was rejected [0]. The preference
> from the netdev maintainers is to fix this in the DT binding for
> Tegra234.
> 
> [...]

Applied, thanks!

[3/3] arm64: tegra: Fix Tegra234 MGBE PTP clock
      commit: 8f0cc929a4bad534c5a860a53d88912cf16d9c9c

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

