Return-Path: <netdev+bounces-291638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HUSCg1zFWpbVAcAu9opvQ
	(envelope-from <netdev+bounces-291638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:16:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE235D406C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38E9630055D7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72C3D891F;
	Tue, 26 May 2026 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b="MbufjXYK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD63D3016
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790598; cv=none; b=V53zcXM74qIyZ5FYrZ7BC2scaVt8CBF/xtucSBVhCPaPOsWcDRUXlKcwjkCv1viXfD/j2N0A7tJUSQDYI++yBxoug2yYRN8ce23GAVNj3HVixvuVE+jBOBUOpq2fBGCd/xh1k4YnoLEGUfyh4AT2EBts82/VBYD3g/WFgVDLwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790598; c=relaxed/simple;
	bh=Nh+C+Fy0FqiBHKrNXaY08YwYU34+UqfXLUWTYrNpkdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxSDhUq1mVjLqyQhB6UAllm5tgJaWOPtcuxQeTk0KYwO5gO2neUoyNEHPBQwrwNnUJRz8rhc7OEMDxiNgwLSX5e+hz0Zyii8fa/3bZQi4j9TI8WFRSm+ceJcTGRkUEx9Ztez4p2aquYEPjF2I21i3diLW8t0tI7AnudnekQi7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=MbufjXYK reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerlync.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-366330b6751so8163802a91.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1779790597; x=1780395397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrZ4NvK5jrlaPy7QvhC9XeQXCUzbUpfIVsVCaVJAXRU=;
        b=MbufjXYKrB08/BqOEE5RCssY4owMi0cOiWdNN7OjPdiTTaWqawCuC78DrHZOpQbikj
         wFIzwXjFi2YP3BNvJ957LkNZVZE/bdWVS6se2WyLE0y0xpcln7JSIn5uxi47/zpvKnoh
         Jtt7Ji8KmlqUMBlRzGCS6nEioaH9oa4021XxBU65NiHAoptHBTlT4ajFUm37DAUIfGrB
         n0xtQ23tFOCfrvBQDOQhPyRmP8TgNedusvs7qnzL2eUlWXvMQnHFfy79EEwOsLAtKftX
         pkL0/XxoOIbqxeDqtxgzE8fBtVPoSIVk77Dc8HlQ+ln1BsHGa008ftjBzo7FepyeYATn
         2aTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790597; x=1780395397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrZ4NvK5jrlaPy7QvhC9XeQXCUzbUpfIVsVCaVJAXRU=;
        b=hlfFH4BGPKFxVFlA4zRJyIF13dq6hMmIMXWP+dZtzyW6Pfyu5Td6viyhbCl6cyXADG
         19dpnHrLEU4zQMfz0fbPVONTnzMhgbSO0gz+6rEzz/nNqpd30LH87PPMx2/U0b4hT1ml
         t219uw/rK+w6yjg9pJVQe7yXsx9cVg1G+LoEzw8iY7OO9lQZMgWjw8WYDPEhrQ8Ab+m2
         bMhHPqB7fFuRcTcsi3vSVGBIG83oGbbFmkvbyi7f+OZfFiYBDYA7IFin26p0GSA+6VfK
         trF2CFJbETXI2i7obYfdzVphB0VUiOhrnC1e0mXkMpnyIwzcVI4Z57rlxAljowTAG/Uk
         RaqQ==
X-Gm-Message-State: AOJu0YysABzk5S1ZZG/suwmTcrvcFUSQy9ipeq/3mKUOk1TJcMbFDiXI
	pNCRHCTN6oFTSuU6OdgU/JZf8xtsBd4pyXl0c0f25MHMX1QgoTDIULUG9oP6zvUGcTm+ksmg6I6
	Y+sq6
X-Gm-Gg: Acq92OHmWZpDxYovTdOLpzSDt8q4bNvOVZ/FmOvIgndu3qrWlxdNU8fkublxNTYTC66
	u+rMfYjpt/1RmYS+ZfG6KxDTN8XzIZMsKXY7rrDcbzyHoPMUaTUrGj6wTKoe/4bNIj802EmBUNj
	4BqZbxVUEo1maLwcD7QWYzZC/LsoIwSRQIFeYwevA+9LJYqgxu+72kSJKfXpHXIdKdcoNw/PCZS
	cEVHj0+bue3qsnrsY+wh2V9klRTzOj6FYOVZFYHC75KmGUPb3jz4ag7Vn/tjYGA8lZFt93k1Ho6
	fB9+ZBBC/WOj4jbl3FkCmwjFWNshDMhFc9engUrMvdpBelTDUq15g6X07amHI9L7m0AaIG9/ETR
	wAj9Om6swDKtsBi3/5LPI0X6ohZ0pIMsybm2Vsh6jhfYLf8rsOPPcWdAzg7YQFEs68TmADXfIxV
	6DwN/en9oWhlBveA1GgWFr/vlBTzjZa+z8kXUGP4Kcrvp2nPE+Tl3Ztad50AcDATk1TEaKbw==
X-Received: by 2002:a17:903:3bcf:b0:2ba:df8c:11d3 with SMTP id d9443c01a7336-2beb06c0336mr204209215ad.32.1779790597039;
        Tue, 26 May 2026 03:16:37 -0700 (PDT)
Received: from manjaro ([103.186.230.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56bc46esm127812265ad.25.2026.05.26.03.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:16:36 -0700 (PDT)
From: Sayooj K Karun <sayooj@aerlync.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Sayooj K Karun <sayooj@aerlync.com>
Subject: [PATCH] net/ipv6: icmp: fix is_ineligible() to block errors for Redirect packets
Date: Tue, 26 May 2026 15:46:22 +0530
Message-ID: <20260526101622.38536-1-sayooj@aerlync.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[aerlync.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[aerlync.com:~];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291638-lists,netdev=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[aerlync.com:s=google];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sayooj@aerlync.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2BE235D406C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC 4443 section 2.4(e.2) mandates that an ICMPv6 error message MUST NOT
be originated in response to an ICMPv6 Redirect message (type 137).

Add check for NDISC_REDIRECT (137) so that redirect packets become
ineligible and error packets are not generated for Redirect messages.

Signed-off-by: Sayooj K Karun <sayooj@aerlync.com>
---
 net/ipv6/icmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index efb23807a026..3fdb3a97dd8e 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -157,7 +157,8 @@ static bool is_ineligible(const struct sk_buff *skb)
 		 */
 		if (!tp && frag_off != 0)
 			return false;
-		else if (!tp || !(*tp & ICMPV6_INFOMSG_MASK))
+		else if (!tp || !(*tp & ICMPV6_INFOMSG_MASK) ||
+			 *tp == NDISC_REDIRECT)
 			return true;
 	}
 	return false;
-- 
2.53.0


