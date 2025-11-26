Return-Path: <netdev+bounces-242088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD4C8C230
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A03384E2472
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80A33F8CF;
	Wed, 26 Nov 2025 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cve.cx header.i=cve@cve.cx header.b="fEJioz/V"
X-Original-To: netdev@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1C2FBDFF;
	Wed, 26 Nov 2025 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194416; cv=none; b=XVBvimLPY8II2KTGwlX631AN0HwfqJjyp04wJwdc4o4Okug/Nvxpaa/0tsI3uAGcyY8WpiFWEdCGsdLka/HN4y5Xv4+XMoS0fM3+O6o9ODEUf5iFm7m/axx3bRoU9A8hfe7k9L58zFWSaehJ2RudL2Lff0FX44gVM/zm2asfpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194416; c=relaxed/simple;
	bh=/OsfkbL5EUBGoslWMuby5bc4sHG15XcsL0UjQ9p99JE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EZimbHzubeKyH4EfCeqRVKYWPD3v4qcq4Bm4qQRrLkCT1NtkmRLwDc4eLQF7meXUnexK531Mzjr1Q0Qb0+VH3W0tsoXRvJIR62y9VTWDQsCLfPwMXO4qDLsuSD8vBLAVGfmi5jzPQEUhEBpZzXyj/BIq4cDUs+G6rlqZx1dbmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cve.cx; spf=pass smtp.mailfrom=cve.cx; dkim=pass (1024-bit key) header.d=cve.cx header.i=cve@cve.cx header.b=fEJioz/V; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cve.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cve.cx
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 6F112C93;
	Wed, 26 Nov 2025 23:00:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764194402;
	s=20250923-2z95; d=cve.cx; i=cve@cve.cx;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
	bh=zSvDGyPOuLyTt4cC8pBORbua+O2bUVJoJBW2Y1J6P3o=;
	b=fEJioz/VqPQ0whXuPL5FuaBY0hvS5eoQ7jmvYCIRZS0juaaB7JDu3zRfLetu2iL3
	6GxjiH/29cC1LnS+Eo9imFgDn+geHpsVBSiaUOjUvSEKhG4z8Hp/98nnuexGKUtna4e
	nC0HdieQ5i1CwoMQ4tHOi9QSqHHusQdEj21P+v+c=
Received: by smtp.mailfence.com with ESMTPSA ; Wed, 26 Nov 2025 23:00:00 +0100 (CET)
Date: Wed, 26 Nov 2025 22:59:58 +0100
From: Clara Engler <cve@cve.cx>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, cve@cve.cx
Subject: [PATCH] ipv4: Fix log message for martian source
Message-ID: <aSd4Xj8rHrh-krjy@4944566b5c925f79>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ContactOffice-Account: com:620022785

From: Clara Engler <cve@cve.cx>

At the current moment, the log message for packets with a martian source
IP address is wrong.  In fact, the current syntax looks as follows:

```
martian source <DESTINATION> from <SOURCE>, on dev <DEV>
```

This is wrong because `<SOURCE>` and `<DESTINATION>` need to be swapped.

Another verification for this claim can be seen when looking at the
(correct) implementation for logging packets with a martian destination
IP address, which happens to be identical, as it can be seen in line
2477 on the same file.

Signed-off-by: Clara Engler <cve@cve.cx>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b549d6a57307..913de56d2c2d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1796,7 +1796,7 @@ static void ip_handle_martian_source(struct net_device *dev,
 		 *	the only hint is MAC header.
 		 */
 		pr_warn("martian source %pI4 from %pI4, on dev %s\n",
-			&daddr, &saddr, dev->name);
+			&saddr, &daddr, dev->name);
 		if (dev->hard_header_len && skb_mac_header_was_set(skb)) {
 			print_hex_dump(KERN_WARNING, "ll header: ",
 				       DUMP_PREFIX_OFFSET, 16, 1,
-- 
2.50.1 (Apple Git-155)


