Return-Path: <netdev+bounces-251310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3678ED3B923
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0C0C300923D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8A32F7ADE;
	Mon, 19 Jan 2026 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="XWzetaF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2892EA47C
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857170; cv=none; b=JFC7ZbsMpB/naRZaXyarhl/OihZ2+xU9bla2fpz09jba3vVt/ZL7lWbYuDqX8fp6/DxRcwRkBKDctgWdcXrgNgfEptq0TN5LaYONBxxX4bOOI0jgDn1Yj6+cA6Cy8Caco1Hurttz7w7I6IpqXQGZRCyyiTpRhNCr7jy4XXJ7BDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857170; c=relaxed/simple;
	bh=PmV5YAPEpQOqqVDfWDBRqjD2thilw2MpMdy0q5knJbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmElIiK9dgmqz8B0AAba7hCsuu8G0qAKmSzXM20cuG/BOfjhftT1/Gwuo+UdQNMgM1ElCO6bVMxVt4TnbUGPSMrwLX06c14dXuLogQRUQ16evhHgLag0H4+vOtsAPxNytB4W8oQvBCDDeq8DuLd4CY31JBxKRuoAdg8cg2fX2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=XWzetaF+; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so8326256eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1768857168; x=1769461968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMyq9AmwzRJXnI07jLCpkE9ql0RrgO+3qgk2M4bUPqY=;
        b=XWzetaF+viKcFFGixh9YnQOKh+tV1evntsCSwv86xFqYpqmVwM13+l2ctZ9DdpkeEG
         oL9qxhGfXzTRusHCRD+Mi8BWIRiZhTdOLqE3CePVKvZsZHpJqJxUWfVrWcViexVt2oCE
         coVHOEK+Hp8D5gcgJBq3e8MucowlGhwfRko3v9HxB7IAiix/hMzO5Ug8iIXfKvgUcFt8
         keBlM69WUh9CQx7fbZnR8by4GXB2WYsn9tl1Gr2nH2uOO3tS4QVHY1VtbNVYeptXTg1L
         EIwKB/khulOfPiWMPL8ZGXYT/rOGg03yn/zRB7BeWPJMRf9EqRwJeQ7ePiyLAwsimR6Z
         ZYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768857168; x=1769461968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMyq9AmwzRJXnI07jLCpkE9ql0RrgO+3qgk2M4bUPqY=;
        b=mOmBEMjY31AS/XwYLrREQaNecMtJx5Dl3+2P4Tl0zbN43CkiXx4mt4Lo+cqY/kdZVo
         MXUXjtL/AYXxk2N66qrcud9iGqnHxElnf0udO6VAapJilOKfuFIaJmFvAsd35nhsJ1mP
         U/u5tAezL+umV3xRIDz7tO1/I+8QpbLU2b2MuRH9P1sFfrB7iiAREwQm3WTeODM3VctV
         OYq/YLycSgbUg+gFVVUDOTuvnH/mO/Z9n/5o2NBE9ukGBzEdLXh2zF0njxQcUwoOE9yG
         /8K2j+cjL8Dfr69lGzjiKlwrhH/Ld+FUMg5bpJx1aEbybixC0bRVk6CNF2fH3pEK8IyW
         cDIA==
X-Forwarded-Encrypted: i=1; AJvYcCVY3GPidLPYcYVQ8R/LmTkl7FbdA5kBWXOw3GPViGIS7HYl0/I4+6DlUeo9e3UQVQVMLGDbnHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUD230opsAUUlEyqpZq/8yqmyG5uVBL1S7CHfWhBjOS/tj8yk
	nTqUI6nT2euK9387C36zSDIwbSGvS+2IiTPrzDSFcDep5AriA4i+DrGdZJveugRQLQ==
X-Gm-Gg: AZuq6aIx9gu05pbXBkoE9hQQkij9kjW9u4QXANJq7bzPpoW/cZhqnhyc0IyFXzixlHG
	pPXm9d/W3XnQGq5HiYjHGShK/IbdgUEu8wqkzVeM+hWv7Su8cHXa+eKWO2qjys0UsX+l/MWgezO
	lgI2gRxgmkDr98rXKkbKMnV8dUbH8ZUlr5WmNe9ZLcMwUSUXVFYlAZAhe0KwgQo/qDjGlEh27PQ
	R5DdaqnMU2qoYRcGhaXxSEfP9/1rZCJ0VBwHoxseyoC+fbgug1y6KRHb/Jx7v1CTcpis6bEDDCj
	x4+ZWwP8+bBkyzwWWXREV5NLaj8q/LITnTyptcLZr/6wdnCKIx5qA20unUKmz6KNL9KCXTiXBq7
	YGh6YmQb76C5Ij85iQ56qhhLv5vDGCPsb/cNsj18/fqmfv3D79zvjoGucdzgLvdYUjdsnar8deX
	46t6VtaP/EhbVTpafS4rXVUN+tNDBvpavCmpKsiT5FqIBcwRo/a+Gu/KjoOv0BcFbcu9k=
X-Received: by 2002:a05:7300:bc8a:b0:2b6:a580:c37e with SMTP id 5a478bee46e88-2b6b50025f5mr12074043eec.25.1768857168306;
        Mon, 19 Jan 2026 13:12:48 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:850a:22d6:79cd:2abe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm14348137eec.14.2026.01.19.13.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 13:12:47 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 2/7] ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
Date: Mon, 19 Jan 2026 13:12:07 -0800
Message-ID: <20260119211212.55026-3-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119211212.55026-1-tom@herbertland.com>
References: <20260119211212.55026-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPV6_TLV_TNL_ENCAP_LIMIT is a recognized Destination option that is
processed in ip_tunnel.c. Add a case for it in the switch in
ip6_parse_tlv so that it is recognized as a known option.

Also remove the unlikely around the check for max_count < 0 since the
default limits for HBH and Destination options can be less than zero.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/ipv6/exthdrs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 45bbad76f5de..394e3397e4d4 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -122,7 +122,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
 	int tlv_count = 0;
 	int padlen = 0;
 
-	if (unlikely(max_count < 0)) {
+	if (max_count < 0) {
 		disallow_unknowns = true;
 		max_count = -max_count;
 	}
@@ -202,6 +202,16 @@ static bool ip6_parse_tlv(bool hopbyhop,
 					if (!ipv6_dest_hao(skb, off))
 						return false;
 					break;
+#endif
+#if IS_ENABLED(CONFIG_IPV6_TUNNEL)
+				case IPV6_TLV_TNL_ENCAP_LIMIT:
+					/* The tunnel encapsulation option.
+					 * This is handled in ip6_tunnel.c so
+					 * we don't need to do anything here
+					 * except to accept it as a recognized
+					 * option
+					 */
+					break;
 #endif
 				default:
 					if (!ip6_tlvopt_unknown(skb, off,
-- 
2.43.0


