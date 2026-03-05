Return-Path: <netdev+bounces-264502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNBpJ3bAqWnNDQEAu9opvQ
	(envelope-from <netdev+bounces-264502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:42:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB8D21663B
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4CF6300E245
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740DF39FCB7;
	Thu,  5 Mar 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxOg7gUF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049301F936
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732530; cv=none; b=VXpdTkw57CzoOVYJCv6bR+mHyWd4xt5P494vUaeGxfkWhmkgjJxwZlyKVGOwWdDcysju6/CoFH4+jo6sG97Wd2dCX0FBjWjjxxRE/SkyiT8L7as6xyUdz7bHqqDwDMTQsbXMEjiKiDdlKUQxgXvpInjaG56dl1ZzB9t2f2MLhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732530; c=relaxed/simple;
	bh=dtZLE0bn9qUI5TUP5ZZdojWWOM+DtKAJcCJVNGVx2Tw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SPH6sScsTTrOg860QPAbJGSK/d36+GnVSQUEXIYKXHY8/3X74QMkjs5WKQ3gUAayz4FQAkRrKVQB7Mhq61hBHGO8Bv57O/zXbaBGkatTM2Q8AUr+8MApjWX0XWwR365OO4OXW5dz7Ny0QETnkm2J+okdhtmJZ53yX+Wloj6p67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxOg7gUF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65faaa8b807so5934833a12.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 09:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772732527; x=1773337327; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPfBnnEowmmRR3udw8BkgO3fgqzXW8yak5Wue4LR45Q=;
        b=TxOg7gUFuH65KvENUpi5JtEtCjsBZav6ulA88SMwNiu6tOPNcbHcJ71gxavjQYYGFI
         dh02mL4l1emmDRKM3Ea7kWPADRolomk/sppSK+YnFTuJ9ZGv1TUmLiEif+sDu3fsRHyw
         +jqF8M9n4y9EpoXZAk1bGbFYcgDupCbDLMIoXWvsYdy74jq1MtC6xq/+Yge2gTnmS5p4
         w6shvCHuKCOPy5Y6xwmJ+764UBkNtdAxd8nE7t651axP25hnT3aXZ9m3nRxB2b6y8LxA
         aFXsonQyl6EGj3iAIgKphFZcvZFtKn4VfualhGkDKf3zuWg0591pen4W9Ac+iBz2RSD7
         g6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772732527; x=1773337327;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPfBnnEowmmRR3udw8BkgO3fgqzXW8yak5Wue4LR45Q=;
        b=cX9p1zeaBhJM9d4Q1/5ADPrhH38ZI8c/v49eTVqKY0n06LYv1/Ior3muYpOz+HyCs1
         j/Z4W3tbQDBsuGp149Hy4j/N9LIP4B//C0xnOxYuS9sZdiVSZLPeRwmxg6TUFkzQOFMW
         l8cx3HG3HQ/pcIljnTm3+PY9Lfy8aoJjJzJwjmGgZFDceqxrT2UUzX1rXdRyNxVQX8Wy
         hDeZ+pSWRX2oLKzGN2I2TsH9XPf4NpFzVv6GCuh1j+RI9UgxbxndZGhsLhD+wWaM7tVM
         7a7ogD31PvsRtrJk321sd47YUrRTns6IeDp2cnLuo3qQtSKLPhPOBEFxGqXHPwc6KmDE
         cjLw==
X-Forwarded-Encrypted: i=1; AJvYcCXjN4JHVVzB8ZVNn9/goCnueoxuwPVW5tygMUUX2LBJ0QsOawx2CJ9tPNlrjtc5cuH89Yv+EDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynIJsNKwgl0XVdcc3X1WLUZjrzDH2IUBcTrLmdsRC4wvmcdEv5
	fhfKvQ9ppDaw1Y39pZNQ3a6bSddfWguV4ug88AsmDfcQOEinwsrPcZCn
X-Gm-Gg: ATEYQzz8mjx36Avsvwk56iCGYHZ3rfLVHkf76XMcYhofGH/HHlI6HKC2ZNXKPgvrfMH
	ky8sgEAN/C7NCunoThNFNTvGusW5aEpa6P4oxswDsBZZOoJ6WPFoMq3I7SC9oY5swWRG0Z9EC/B
	YgYWpy/pxzixpZ9NrLBM3LoOV0KcdcM8/Dq1xVf/TgklMxiCkOc9PnN0DsZWCkS6AbFqnuiB3an
	5m2idXokMq7//74ypNUCE8V4iKtmX92incXFF5z2+JiDU0VEeGjlJNGBaEl7kRudEBT7+4qH3oL
	a4QSH+4S4aHWIsfdgMkL7mj2zox4kVgW7rtBWRKauYTBTPRRo1tBmeeLogaRwHnuiGsZ8nJBzTG
	c7CRXtdAiB1PhuS3Ml0mTkgtpjKPwU8f/OjV2iGAMxbLRXWMrIgOJKupW+G8FVaQ8uRdS+liH/g
	o7WzzPMjbHb4VpJpjFS72v/sb0qO30m8PFUWmMvSmo1uTYtCjyCzN7R5vVCVB7frrSLq+6mNT2L
	mgoHZiHwbaQ/CQafTjimJxcq2FJtfpRru/m/mnQs7NieXwgCIdBOBR/wUF+y1GMcnUQ+HVIovQ3
X-Received: by 2002:a05:6402:27cd:b0:650:883a:8896 with SMTP id 4fb4d7f45d1cf-660effd0f72mr4184655a12.29.1772732527035;
        Thu, 05 Mar 2026 09:42:07 -0800 (PST)
Received: from ?IPV6:2003:ea:8f26:e300:f4ea:baa8:3194:fe01? (p200300ea8f26e300f4eabaa83194fe01.dip0.t-ipconnect.de. [2003:ea:8f26:e300:f4ea:baa8:3194:fe01])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabd46753sm7118720a12.8.2026.03.05.09.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 09:42:05 -0800 (PST)
Message-ID: <c3a1aba9-3fae-4c4b-bcb1-fb620fb7a309@gmail.com>
Date: Thu, 5 Mar 2026 18:42:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] Revert "net: phy: improve mdiobus_stats_acct"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CAB8D21663B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264502-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This reverts commit 1afccc5a201ec7c9023370958bae1312369b64da.

As reported by Marek the change causes a warning on non-PREEMPT_RT
32 bit systems.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- add missing SoB
---
 drivers/net/phy/mdio_bus.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index cf5ce1ed48c..00d0e4159e9 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -60,17 +60,22 @@ EXPORT_SYMBOL(mdiobus_is_registered_device);
 
 static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
 {
+	preempt_disable();
 	u64_stats_update_begin(&stats->syncp);
 
 	u64_stats_inc(&stats->transfers);
-	if (ret < 0)
+	if (ret < 0) {
 		u64_stats_inc(&stats->errors);
-	else if (op)
+		goto out;
+	}
+
+	if (op)
 		u64_stats_inc(&stats->reads);
 	else
 		u64_stats_inc(&stats->writes);
-
+out:
 	u64_stats_update_end(&stats->syncp);
+	preempt_enable();
 }
 
 /**
-- 
2.53.0


