Return-Path: <netdev+bounces-286285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJIQM596AGqbJQEAu9opvQ
	(envelope-from <netdev+bounces-286285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 14:31:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67536503E6C
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 14:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC8C23002886
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BCE3815EA;
	Sun, 10 May 2026 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnZsboA0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB9DDCD;
	Sun, 10 May 2026 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416283; cv=none; b=UfLzCqjLLwfHXsciP0yTGxpniurOkyoK/UZ2Gf+vyhCd0YeLtm+4tR1+rv1Yh1f3QrDk8wqzDu4kul+SnBJ1aZ0jijYW/kEbX2AtrVsvrV2fOQ0hJAr8/qye13DZu6NPTSbczwOcaspBXKMRiDY3aYcv2LZxgx7V548DpEFZlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416283; c=relaxed/simple;
	bh=3JqIN/a5xnDrsf7uQ/t04AQRZOGabyoAFAk9x9agD58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TEfAsLuJcETScE+cHsE2ROt0F42hXh506YYz6fhCvJLid56l9ysyF3Mnew1x8wwCMzJ5VFpOnBuOqBFBhxuufDUD/VVNDDdVhLUDG7fZLYSKtwaR8m+GuyjHr3sXkxIz9LJPq/sCMxZ8lfGCsuNtXuYHCu4Lc3vHJM3RBkZC16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnZsboA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51955C2BCB8;
	Sun, 10 May 2026 12:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778416282;
	bh=3JqIN/a5xnDrsf7uQ/t04AQRZOGabyoAFAk9x9agD58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MnZsboA0jQmaijqnX2BD+hvMlrJcDvxnQQDS/r9gbtq9L0V6otNe32bZ6WXiAjBl3
	 aKhZSAZglSQAFSPZRmNTI/7CsKpNa/vW0GUwQZSSxgX5zNqKwthOcghfNnZGDyvFfs
	 pcqtjUOYAD3a3JBSRBc0WzaejDDpIBU2DgafD/VPQsPUgKnuaFhpyjnSV88PTNZVy1
	 BqVaYN47khWtmCpyaH43ZRIK/rfWHRQCScbn0wHvzO4YXLpYwz5mjuenpxA7ukRS/I
	 aRTznzwF4TgpHbyDD/T4T9c/LeNSzAQGWUJDOgbfOJFRwbfcVRV097cqwM05W0vHAr
	 R7W6HiWOe6XCw==
From: Vinod Koul <vkoul@kernel.org>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux@ew.tq-group.com
In-Reply-To: <cover.1775559102.git.nora.schiffer@ew.tq-group.com>
References: <cover.1775559102.git.nora.schiffer@ew.tq-group.com>
Subject: Re: (subset) [PATCH v4 0/5] J722S SGMII support
Message-Id: <177841627590.434434.3111204439748668574.b4-ty@kernel.org>
Date: Sun, 10 May 2026 18:01:15 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 67536503E6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286285-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Tue, 07 Apr 2026 13:42:32 +0200, Nora Schiffer wrote:
> The J722S CPSW and SERDES are very similar to the variants found on the
> AM64, but they additionally support SGMII. Introduce new compatible
> strings for the J722S to add this support to the drivers.
> 
> This is a prerequisite for the Single-Pair Ethernet interface of the
> TQ-Systems MBa67xx baseboard for the TQMa67xx SoM, which will be
> submitted separately.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: phy: ti: phy-j721e-wiz: Add ti,j722s-wiz-10g compatible
      commit: 059f1a4c9e3aa44d888c0e7cf4559403eece0438
[2/5] dt-bindings: phy: ti: phy-gmii-sel: Add ti,j722s-phy-gmii-sel compatible
      commit: 567b3c62a7eb51db4cb562b416ec220132d524c9
[3/5] phy: ti: phy-j721e-wiz: add support for J722S SoC family
      commit: 61849b7afb579630fc45dbeaf5449b42b33cc70e
[4/5] phy: ti: gmii-sel: add support for J722S SoC family
      commit: d39cf00e7daea64889dda9abb0b7e6da04a69d04

Best regards,
-- 
~Vinod



