Return-Path: <netdev+bounces-272919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNGbNNQ4yWmKwAUAu9opvQ
	(envelope-from <netdev+bounces-272919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:36:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E46AE3526FC
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 484FD3009F3D
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D636E475;
	Sun, 29 Mar 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yRoSPapY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mApmdXbU"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9883793A4;
	Sun, 29 Mar 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774794907; cv=none; b=lHS+Tv9oJXxz05egL/wfmuV1sOpJ0/peIleOyzh0r3zcCOJ5PuojvALHrICM0X7sWBdDcXuZnGJJ5jrV9RbbbdwvTBqRUGvAYnTmSV5ajR7AEzAa4oJV2J5GbhoC6W1umQB5DwLoKPioqq8C5e/CtnvM1IY78hdYfIcFn3qkXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774794907; c=relaxed/simple;
	bh=HPSfrOSyflEDsPPutOyoR+lBR/dwTkjyv1EHtxr8G7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZWEhH0ehM9ZXQvXxg9IZ4+dCty5FjwZanPw8ZrKFQk4P2wfA8q2fi0xOtWxGmCUtHMVioXDSdw16FkDBXHRzpyeyDrklUP+ekpSspc+ncOMgwIi1XFbViccmegmQxB340wF7g4FDWSGDcpHCgQ/qagROaF9IGGujm8N+WMEgkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yRoSPapY; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mApmdXbU; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fkH3C4wQBzB12J;
	Sun, 29 Mar 2026 16:35:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774794903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjlUEvmvkigT1ah8ECWudjKocEQAAMyY51iehZYxEbE=;
	b=yRoSPapY7cE4gG/gFIIm9cCuyVrt1wZRDsaQtUuT7PunTNsbg9CmLYbag5k3iJJxOsVx3M
	A3Is7r8l8twGOXaM53YFn+/Rv/KA1rNMjtY4Q5/K9/KRzty3fV2Tj6K9G9dckMS0f5FZSH
	aIW6gMlmd+MMtq7/zCSD6k1QduGPKG3i2DLP/DOQeTaP3kben0P1YXSzGEZqYvHQsznvYh
	rlfEq07es75G6b/wz9RI1BdVQJMCh8ccZTYpU6mn6vKmmfb9ryAoWDjQ+bQcByYnWivqtl
	GncVuiuBdVF/k3tmLvNTep/nGT4wjeZbWefQ34dlJ7TDeH7SPM31qgnbw5nmOA==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774794901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjlUEvmvkigT1ah8ECWudjKocEQAAMyY51iehZYxEbE=;
	b=mApmdXbUH/Di4UcFU+/PZx6RYTTlDs2oIOTWmCb/o1g7gO0nDbMJXwkoIqAC7tz7rJGUwe
	Xwb3qaDYzhOIEg00SIGPQw9GZAhXDqqADpa6FLszO2+etuBVcu31y6Ufsb3XKUkbL2nCZi
	JmzZl6yvIGKedoKgK7YLJMyePOsMDu1f7Z62+trKuakfM9MI9nb7JexIx61JtjGZiSu2Sc
	95CgKHG0797MpH78tkcpDwFxTQcyBH1uZ8Hv2MCUe5yPHvsUDgTU/T6x/1OgpYAqvexRy7
	82bOblZWHUahUXwAgjjU2m46RNcJtxLOMMTdHGsKvRulZnAU9llhFuNZSle5cw==
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH 2/5] hamradio: mkiss: remove redundant static initialization to 0
Date: Sun, 29 Mar 2026 22:34:05 +0800
Message-ID: <20260329143408.747197-3-mashiro.chen@mailbox.org>
In-Reply-To: <20260329143408.747197-1-mashiro.chen@mailbox.org>
References: <20260329143408.747197-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f200503a6cd8f425546
X-MBO-RS-META: 7ieh53i41ut41w89trnt6trzo5djdcxb
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272919-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E46AE3526FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Static variables are automatically initialized to 0 by the
compiler.
Remove the explicit initialization to comply with the Linux
Kernel coding standards.

Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/mkiss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index eac45d936..3721572ce 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -686,7 +686,7 @@ static void mkiss_put(struct mkiss *ax)
 		complete(&ax->dead);
 }
 
-static int crc_force = 0;	/* Can be overridden with insmod */
+static int crc_force;	/* Can be overridden with insmod */
 
 static int mkiss_open(struct tty_struct *tty)
 {
-- 
2.53.0


