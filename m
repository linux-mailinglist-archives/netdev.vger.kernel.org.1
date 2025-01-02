Return-Path: <netdev+bounces-154833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E9B9FFF47
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 20:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0253A36E1
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF3E1B4230;
	Thu,  2 Jan 2025 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="waNSsQ6v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1D1B3944
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735845153; cv=none; b=UiKJ2WlAnQvGDwFp4xHONPKezpa9PjIa05us01PYblebWP/BFoOoRBe3ZRcC3XXQEGjnDHGIjVng9Q5p9lTVCxvdbcjR9ohbRDpaxhmrPUN2DbZP4/JLCi5zgNC2F/7kHl0oVqVnpKTkz62QNnQ7Z26dScmn2py/SzqLat/mRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735845153; c=relaxed/simple;
	bh=wSBhS+IuGPcIZlqRmv6UNiYB7pmIrosa8C99ItnNum0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uQubNit54fDtoecwY8fr1vQJG6YaBOblRetH4JmQrThT4X0pLRl33Czi213cPOfKKcqTJYI8w2BBPRg/iKhvl0Skp6pQmIjrQTOyCw+PX27ZoKzanFOxv+nZjDeMlGisC7sUfkzjRlIbRcB5zuAXjKM65+UuVYypxJiFg0g3aSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=waNSsQ6v; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee6dccd3c9so15709169a91.3
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 11:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735845151; x=1736449951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VbTMlPgITTF8zvKL2cw9nlTdPwqwwqp+bMy8kAMrA20=;
        b=waNSsQ6v42mfCoXvT2zL7YnfGEjxJ9bgATJJ2VGQdjD9nTzrTJmy7/TbPs5R1rB5qR
         8WQmHyaWcb4+ktGJpAIUya5CXtOqqZWs9BZ38wkBF26IkLANhATg9pF91bXpmKYQNmJP
         cIatc0/CVpJU8v2DW501uuyQhaovcpdW6M7wmsDf2OMFWEt9zVuEFI/BzX3PxnAECx4z
         Iiowq1VTDM0j1+gSWi4+NCD79uzQvze3z2GoCKyxLxvZ3GpAF8iXRbVTAUY5KZpcgk6n
         k/HnTvvfiDH8q2ersuphQ+fCYiWjAzamj+Yj0olJXM/47p5GsMf+GhJieE40xM6T8/w8
         UVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735845151; x=1736449951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbTMlPgITTF8zvKL2cw9nlTdPwqwwqp+bMy8kAMrA20=;
        b=aeoPf8i73YgCCvrdW7eO2VH7lXbrBSJJBvg0KlFEsuW4M3FRXH6F4MdHkvRNKp/UfR
         XsfS7ib0ehjC2oQ/9D1Ue8/sDD9x6ZI0CJslGP54u9sNcszpkf+zsYCui6KY1KVoFL1C
         q3Q4pNEl8cWo1INyRqwnuaZ76ToPd8sHaJ0FXedWybG8RTcc3Cd1G8nOdHUVIt2PDDCM
         5Iy4k+SlW9saqbIG/ueQNFBam7JRB9hrFdHhggVDNpmbcc2/r1MjfYYMlg4G1uP2gzGB
         HzIC6lqjnh+w16l17nR2BIzpzWQeN1x3Xz+yx66KFAjB2LBRNiOk087QBfE954lRHBqY
         vBVQ==
X-Gm-Message-State: AOJu0Yy8P9xqHTSerRfvSReG/qxHxn5CSQMZfCSCLMEW3LIhGPkqgKCb
	lpC2aISLeOhKvFm5CjyYJOmpfE90JIGgePAhQOIuJ+glbteE5KV9O2hEsr4guuQefIONS1IgZfc
	2UMHD8+GwBQ==
X-Google-Smtp-Source: AGHT+IFnkgjHPP894grqasbdVPIqtI5Im6T2WMIjDJi3ZHbHk1hxJ3Erydw9LtAshOdIRMtx8xaDODCtpsz08Q==
X-Received: from pjtu8.prod.google.com ([2002:a17:90a:c888:b0:2e0:9fee:4b86])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2547:b0:2ee:c6c8:d89f with SMTP id 98e67ed59e1d1-2f452e20d8fmr66453545a91.14.1735845151403;
 Thu, 02 Jan 2025 11:12:31 -0800 (PST)
Date: Thu,  2 Jan 2025 19:12:26 +0000
In-Reply-To: <20250102191227.2084046-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250102191227.2084046-1-skhawaja@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250102191227.2084046-3-skhawaja@google.com>
Subject: [PATCH net-next 2/3] net: Create separate gro_flush helper function
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Move multiple copies of same code snippet doing `gro_flush` and
`gro_normal_list` into a separate helper function.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/core/dev.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3c95994323ea..762977a62da2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6325,6 +6325,17 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 	}
 }
 
+static void __napi_gro_flush_helper(struct napi_struct *napi)
+{
+	if (napi->gro_bitmask) {
+		/* flush too old packets
+		 * If HZ < 1000, flush all packets.
+		 */
+		napi_gro_flush(napi, HZ >= 1000);
+	}
+	gro_normal_list(napi);
+}
+
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
 static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
@@ -6335,14 +6346,8 @@ static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 		return;
 	}
 
-	if (napi->gro_bitmask) {
-		/* flush too old packets
-		 * If HZ < 1000, flush all packets.
-		 */
-		napi_gro_flush(napi, HZ >= 1000);
-	}
+	__napi_gro_flush_helper(napi);
 
-	gro_normal_list(napi);
 	clear_bit(NAPI_STATE_SCHED, &napi->state);
 }
 
@@ -6942,14 +6947,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 		return work;
 	}
 
-	if (n->gro_bitmask) {
-		/* flush too old packets
-		 * If HZ < 1000, flush all packets.
-		 */
-		napi_gro_flush(n, HZ >= 1000);
-	}
-
-	gro_normal_list(n);
+	__napi_gro_flush_helper(n);
 
 	/* Some drivers may have called napi_schedule
 	 * prior to exhausting their budget.
-- 
2.47.1.613.gc27f4b7a9f-goog


