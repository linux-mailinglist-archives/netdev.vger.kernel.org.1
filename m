Return-Path: <netdev+bounces-153703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10E19F9423
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A51887FA1
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E6C21519D;
	Fri, 20 Dec 2024 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4Mr8FbO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362D1C5488
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704458; cv=none; b=izO9Zs4rGYsh8m1D8/mt33fIsyAbHpMsodnXVYmTUibJgGzuni99sUmexyVNBnQM8jvu07ZbHRhokGR3vgXZYrV5gn7JfNojsdI8MbdNpR+PpCimbpxNW4grUIegSwwgq027q7l/hgE0y0CoCYUIGh6rV+heMn56CV+bb1aynsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704458; c=relaxed/simple;
	bh=EgnJ/Tkh1C1LQYcKEaughP+rbf5J1jqLZWDAyyDB7yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czyj6IsWBMElRpqhGCEbT4VkrY57duqEykfZnQ1l1gCq1ID2uXnY7kMzQlJ3eOLGXFxBDjBFeSSQ+r2xHJ5S2Awi1B8FHPF3gF/I217zfBYpTMLD6u/klmN55CbrpHJr/6rZlRZkD60XA5N+Zs6jiLXIMBrdGcH/Z2bscRSzw4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4Mr8FbO; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844e10ef3cfso148409339f.2
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734704456; x=1735309256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7mDKl6tzxVN4OlPSHKO5eWK8XZLJ0ANoR86UwcJiqUw=;
        b=g4Mr8FbOYYPGt3jg/8Y9Mh9T1a1Z9cO94kl/11Dmpmtckim1o88aFhJUqK9xR9zWsg
         jSTED1Txb2JQId1vS4qWhcDIDvhiU6eePNqZ1vBOSq8xnPquCh+lI0jBN3/AlEYznPq/
         7SXXUs4u3Wq9PHmZ0s5iIWEYE1mDFmiAVdUHYyDGlV3UJ4e6vz6MPy+9eDGLXyfMNttZ
         PcRgjmtbHdEn1EXyuRhh8fRLGYxV2yejHLi6ER+A/M347iizhcSKqCmy8EJntnCpyg6B
         Oz/QuH3jmLDd6GFOtrDNobzU6/twrNqyStiLcgQztGXN+JSKKB7VrQFsYI4KcsGmteyg
         wJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734704456; x=1735309256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mDKl6tzxVN4OlPSHKO5eWK8XZLJ0ANoR86UwcJiqUw=;
        b=M66ehTr8/4BHozr+4XTqEeVb/kF6qothI71EEGgb352X7SPB8kusUDyKbMmF1l7+2K
         uyVBieU7uqZJOXrkiH6jmIkJ49H6YtAMit/3esTFzQACD1sFz7X6g/ChHgYJ7GmiKysG
         LWDv7ZdZ91E+U0Sn2Bn9qI+usu5CpcjlBVdDxsq6yZEZ19izPYoLpbaDHQbmvkqL8KLr
         8/qFxbE7xcEKjTehcd5hvGTt6OfAJXPknnoec08YddHsh9HuISGd3oA9aBjNAJx6wkZ5
         2vMy/gyQLYlnwMM8Gh+abjcUEHm8woLPkgGgTXFwQD2rLDYDLcz8bvZiu8OhweF+IlPf
         gKwg==
X-Gm-Message-State: AOJu0YxLmF+lb0c0Q2fC+aQpTW7iSQ8G9RBBE0sC9TeHU46KuV6xQJ0z
	Wq5pd/cRjYZ14dkbxWffQEbxTFxLp9o2OSK1f7/WCpSv+nAluH1r4w9o5A==
X-Gm-Gg: ASbGncvIZhfLKFtAa/XNezZaCXwQ8w/meVs8J8me9JU3MyhXSy2H0rvDjzomIZMJ8WD
	jQAC2gk0jUqD0MvojYo9XzoruwjELWNahkMAO6U6HOzq+QCdJn+j9xER1BTxjGlAkqsqrthdFSV
	lBSnOW9e7AETnIE+UramQsPkP4LYFiXiKrz4GsiihTbtR1/jMr1Uyp1rk3Prl6h5wpYZVi9L530
	ZqaToPDtvprQ5+DU/m2AeBmDeDG6X33bKu3yivQoedFkmplZ03lbw4ozLq8LHr/gib+vWEJIgbJ
	5RbQRFOfDzbIb7M/bee9f10wCpV8nbvHR/Bjz4CG96SnsLyWE8eTww==
X-Google-Smtp-Source: AGHT+IH62ymBhxgPcNssf0jsIwFi1XwyBWK2oaxmsI0s0iywLKHXKjI4oZaDr61vqAGYpiVtnIfRxQ==
X-Received: by 2002:a05:6e02:3042:b0:3a7:e147:812f with SMTP id e9e14a558f8ab-3c2d2d50ab6mr33058555ab.12.1734704456005;
        Fri, 20 Dec 2024 06:20:56 -0800 (PST)
Received: from T490s.eknapm (bras-base-toroon0335w-grc-37-142-114-175-98.dsl.bell.ca. [142.114.175.98])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3c0e411e88esm8953065ab.49.2024.12.20.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:20:55 -0800 (PST)
From: Antonio Pastor <antonio.pastor@gmail.com>
To: netdev@vger.kernel.org
Cc: Antonio Pastor <antonio.pastor@gmail.com>
Subject: [PATCH] net: llc: explicitly set skb->transport_header
Date: Fri, 20 Dec 2024 09:20:08 -0500
Message-ID: <20241220142020.1131017-1-antonio.pastor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

802.2+LLC+SNAP frames received by napi_complete_done with GRO and DSA
have skb->transport_header set two bytes short, or pointing 2 bytes
before network_header & skb->data. As snap_rcv expects transport_header
to point to SNAP header (OID:PID) after LLC processing advances offset
over LLC header (llc_rcv & llc_fixup_skb), code doesn't find a match
and packet is dropped.

Between napi_complete_done and snap_rcv, transport_header is not used
until __netif_receive_skb_core, where originally it was being reset.
Commit fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
only does so if not set, on the assumption the value was set correctly
by GRO (and also on assumption that "network stacks usually reset the
transport header anyway"). Afterwards it is moved forward by
llc_fixup_skb.

Locally generated traffic shows up at __netif_receive_skb_core with no
transport_header set and is processed without issue. On a setup with
GRO but no DSA, transport_header and network_header are both set to
point to skb->data which is also correct.

As issue is LLC specific, to avoid impacting non-LLC traffic, and to
follow up on original assumption made on previous code change,
llc_fixup_skb to reset and advance the offset. llc_fixup_skb already
assumes the LLC header is at skb->data, and by definition SNAP header
immediately follows.

Fixes: fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
Signed-off-by: Antonio Pastor <antonio.pastor@gmail.com>
---
 net/llc/llc_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 51bccfb00a9c..6f33ae9095f8 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -124,7 +124,7 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 	if (unlikely(!pskb_may_pull(skb, llc_len)))
 		return 0;
 
-	skb->transport_header += llc_len;
+	skb_set_transport_header(skb, llc_len);
 	skb_pull(skb, llc_len);
 	if (skb->protocol == htons(ETH_P_802_2)) {
 		__be16 pdulen;
-- 
2.43.0


