Return-Path: <netdev+bounces-247725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14589CFDD14
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98D34300C0C3
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8A3090C5;
	Wed,  7 Jan 2026 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnBA9dsl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD81199931
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790641; cv=none; b=qWPdzTZ6NhmIyCb8bPlK2qZpL2YFSCvE9mUXtZNtobIcZrV0IA9QhBc3rBwhYuYGH+Tc+nYnEbezGK+ymLq767fHuQ5f8YEga9GPtl1Eg3IFs0zMeRUtir5MuOYSWZeNImxZENsG4zedh7taxshXdE6prZbvXixFLfDdfhaAuPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790641; c=relaxed/simple;
	bh=LDR6zZNxvNAe79YVdbYC3IMGbZJyR6nFG1w7NflTFVs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uJK8TWmi0jQkmvDZY+Tm0aEnqhaXfn3rVTgHL3z5E78iC/Xl2q6OF2mDZe+cjt3+EnCcXfBM7HqVf2C13PWqDUqnye4nhg3Uk6pTRvRMriWzYka9M1hkuhQn/rfzfGoxRLw8kMGrQ6O4y6cQq7xYbMq+njuO5VS8DbTQjp01LbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnBA9dsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C1BC4CEF7;
	Wed,  7 Jan 2026 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767790641;
	bh=LDR6zZNxvNAe79YVdbYC3IMGbZJyR6nFG1w7NflTFVs=;
	h=From:Subject:Date:To:Cc:From;
	b=TnBA9dslET6W8sUuliD2ggdJCxhcKKRxsonN5VpLjKZJRUzphKzC1dsq5cJa9CvvW
	 XguTRSt5Eg3aOifdSfPG4S5PTAjV/CvGSiPio4QVHT9YkfAgkcNtYOUZ+RKbyAJfGH
	 n4xWod38e8z+uXEdrwgCbEQ4HvRwcp+P+KndYPFZFZDFsIT3J6nO624y35o6qzuVKq
	 ssKzbw/cSLK84v0cgbEMDjlRTme83NKs4UinPg/Nl7pWBn9sx0CDAev/Tc6rttK216
	 M5jEjQ9S7lhxAaVTRNEQXwRIvtuhBbJmJZsgTySHtMlPm8EB5eYpv6HqAUUKbgfz08
	 QZ/VBSmWb3FrA==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next 0/2] Add DSA tag handling for KS8995
Date: Wed, 07 Jan 2026 13:57:13 +0100
Message-Id: <20260107-ks8995-dsa-tagging-v1-0-1a92832c1540@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQrDIBBA0auEWXegmgraq4QuxIx2CEyKIyEgu
 Xuky7f4v4NSZVJ4Tx0qHay8y4B5TJC+UQohr8Ngn9YZaxxu6kNwuGrEFkthKUjGB5/mlF45wwh
 /lTKf/+kCQg2Fzgaf67oB5e1ZAG4AAAA=
X-Change-ID: 20251215-ks8995-dsa-tagging-e1898c3cc4ff
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

The KS8995 switch supports DSA tagging.

The sibling devices KSZ8864 and KSZ8795 does not support
special DSA tags, so the patch series makes sure we only
enable these tags specifically on the KS8995.

Tested on the Actiontec MI424WR rev D router.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (2):
      net: dsa: tag_ks8995: Add the KS8995 tag handling
      net: dsa: ks8995: Add DSA tagging to KS8995

 MAINTAINERS              |   8 ++++
 drivers/net/dsa/Kconfig  |   1 +
 drivers/net/dsa/ks8995.c |  87 +++++++++++++++++++++++++++++++++++-
 include/net/dsa.h        |   2 +
 net/dsa/Kconfig          |   6 +++
 net/dsa/Makefile         |   1 +
 net/dsa/tag_ks8995.c     | 114 +++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 217 insertions(+), 2 deletions(-)
---
base-commit: d48eae8baa8db1cff42c69aaedd87af43f4ca36b
change-id: 20251215-ks8995-dsa-tagging-e1898c3cc4ff

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


