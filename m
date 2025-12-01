Return-Path: <netdev+bounces-243045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2BC98C94
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 19:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BDF84E1A6F
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391E523909C;
	Mon,  1 Dec 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="WkiHkVTL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A3D1C8FBA
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615577; cv=none; b=GXmhT55usYTwWejAQLcD9nYZnpj7WTvUeEcV8Pz0r3DYxvDV99BlKvp6y7jFIj8Ud1nAwLsVEMhZ8+jrmEnGnptzAJ40O8OleT9d6F89k1pcQdgRaj0pgu16SSSAzYWsY18NoqDlHk5q5LGKkBoXFQmNZagHhNcbn6SErE2EZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615577; c=relaxed/simple;
	bh=GBd7QwLVdYKTqN6eCByNv3dNdrNMkG/w6VO+LUxuH/w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Knx9NkkA1SaaYaPmT33/fh/SO6Q232+Z9pfWYrXnHgmZ58A+eP3ZuIcE15KNneduoE03drUJGjWPUTVywLNVG4D51Lma1saxT21+0n5GI5yidUonef3ezGP8uwI7C795h9iPpwNLHKLEMDpBo5G2dbZclpl6gBVAkFV5RkD5scY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=WkiHkVTL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7ade456b6abso3646404b3a.3
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1764615575; x=1765220375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rl6iwGSYT7lX+DDTi+0SS+e9A3AsFOQ14UkPaCvOIe8=;
        b=WkiHkVTLhUlx+2YySlcP44DI1CbUxsN/p2kkXsJ1CqhkMUb7xUYA80qKbGJNwYEymH
         xAVfZW6QS20KHs/up/xHSU262zHwDDrG+m+bg/yyB8WaiAjzcgePyer1CCqtPJU7HTEu
         juBCk5VQmiqrbxMvE1IZ9GMCSLVtkmBwbdf0ZYRfoOYqUeen46wrNRMbJZ+PXGUbt4PO
         hIvBPxl+DRHHMWwQfE2Ou24Jw1skLhCRMziqht7XnCdHM8RWW/ybxZEv/0rSB1GpQWDd
         mkTV3g4ShPL/gEd+LIEHvnE8oogcyafcYE0qkFZaCZWSfaVNzCSlUOO8xNf1ZN0NYURu
         ElOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764615575; x=1765220375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rl6iwGSYT7lX+DDTi+0SS+e9A3AsFOQ14UkPaCvOIe8=;
        b=Ztv88Awff0g+YB3F7lMS55xSZ3iMF/ikR8fu3AE2S1mae8arM0ya7uFemgxrSacnPm
         UtESxrCeERsJOAz9fIcP5jRzpVt4ui0TYQk4a16oMor9G8MvzAgRgAJJSwXXQolxfJ3o
         NEqssTuxTFqUNNk97Dy22+vr52X7Iea6spdVkqZLLXvgH5tu5xiOdXp7cBkRGsmobju6
         IYoL6HB5WNI+izvLuz6MOjC7FtYovUUZHNvZTEPDv0V+g79ro9fVaNkRb7C1pKqQY6oe
         5ie+ozxlCN0u7fAvTkUDM9bvUopwepxdNjMOALYAJfRJlzHmvMkxDtzz6h2sqe9KRykN
         fN3g==
X-Forwarded-Encrypted: i=1; AJvYcCVmDE75Ht7A3tHPbgbzcYjgEqCDrHOsG569rlk72UC0a8Y4JiBC7SOfCbbp5AMy5SGcVNEGFd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3Zrc22rbCh91oMZZm6r3ny/XgjIhCqn99rBp/UEtJhVZZtQQ
	DHG1h9xkoaHb9mKYOVXeqqNVHjl4InCjyO7MokYhtZNc/h7i8lRwV4NRvf9WKMXFQA==
X-Gm-Gg: ASbGncuFGE0g2VxDqpOl5KReBjdbWYJbb96AnZClHT2+ONJ847hjKZLXYYnYliWspcC
	NBKDf8H8/P+YUhZnbgakL0QwP5hsv44qc+IbbByxHDtrFE3jwnfafK3jqynM51VEVGssGvQOOeh
	z5Ijwl1ZagK/3aH7xRRcLBhAeSkM/FSzZi0d0bF1ilEBn+1tx6aw0Ek2YSt3KH9U8JSos9QwILQ
	64WZFZHDEI9jlngc9px647JsFgpt73YogCKjX5d9uQoioAeY727fsQTvv4Y9hVneBUBdHHJDU1W
	/wGHBTt3ilTQqpdqvSEdAZoYU8X9OGgGFh4+X3/vCBGSQ1PvgmoS0e4pJnl2mcFKG6CHXxG/pSX
	HoAQ6ib5tJS0SqakKgK8pLoRpoH2gS2fT3h2TjnyX0LH2BABwQ5AiJ7aEyJnseRUEbanRUqt52S
	malwcB5KdB27/SeSo5EjiBwcer5zJWUjgbDYFuER54p+Vvewp8H2G29kot
X-Google-Smtp-Source: AGHT+IH9a30ecDCWvD/iCYMRoGCJknwa621ZwfWdqbxltKucCNde3QpapknEETRLSW25O6PM1NDUhA==
X-Received: by 2002:a05:6a00:2d88:b0:7b9:d2ad:bebf with SMTP id d2e1a72fcca58-7c58e50cda1mr39887649b3a.22.1764615574951;
        Mon, 01 Dec 2025 10:59:34 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:14e3:ac6f:380c:fcf3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1520a03a3sm14522852b3a.29.2025.12.01.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 10:59:34 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: tom@herbertland.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/5] ipv6: Set Hop-by-Hop options limit to 1
Date: Mon,  1 Dec 2025 10:55:32 -0800
Message-ID: <20251201185817.1003392-4-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201185817.1003392-1-tom@herbertland.com>
References: <20251201185817.1003392-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Hop-by-Hop options limit was a default of 8 meaning that up to
eight Hop-by-Hop options would be received in packet before the limit
is exceeded and the packet is dropped. This limit is to high and
makes the node susceptible to DoS attack. Note it's not just the
options themselves, but a lot of padding can be used between options
(.e.g. up to seven PAD1 options). It's pretty easy for an attacker to
fabricate a packet with nothing but eight unknown option types and
padding between the options to force over a hundred conditionals to
be evaluated and at least eight cache misses per packet resulting
in no productive work being done.

The new limit is one. This is based on the fact that there are some
hop-by-hop option in deployment like router aletrt option, however they
tend to be singleton options and it's unlikely there is significant use
of more than one option in a packet. From a protocol perspective,
RFC9673 states:

"A Source MAY, based on local configuration, allow only one Hop-by-Hop
option to be included in a packet"

We can infer that implies that at most one Hop-by-Hop option is
sufficient.

It should be noted that Hop-by-Hops are unusable in the general
Internet hand packets with Hop-by-Hop Options are commonly dropped
by routers. The only realistic use case for Hop-by-Hop options is
limited dominas, and if a limited domain needs more than one HBH option
in a packet it's easy enough to configure the sysctl to whatever limit
they want.
---
 include/net/ipv6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 723a254c0b90..62ed44894e96 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -91,7 +91,7 @@ struct ip_tunnel_info;
  * Denial of Service attacks (see sysctl documention)
  */
 #define IP6_DEFAULT_MAX_DST_OPTS_CNT	 0
-#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
+#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 1
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
 
-- 
2.43.0


