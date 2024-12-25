Return-Path: <netdev+bounces-154226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972EB9FC319
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 02:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAEF160C20
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 01:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A61CA81;
	Wed, 25 Dec 2024 01:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVP8NXnA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980518638;
	Wed, 25 Dec 2024 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735088917; cv=none; b=fA8dBKXu9qmoL8NcNlSg89xlLVnHMKRdCd7h8SvQHzI7zG1eprFUljyHCDJn5l3zW/XHYm++eoFgW6StCfwEmtjbmxVnZQqQBdHvOOoXqkwA4qIkcvOBFGcX8dr3prhE/h05prdifKG40ZO9/D+l+/oDVPtme8Y8wLNCNZ8pAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735088917; c=relaxed/simple;
	bh=dcy4e6tJ3ahRYJzGZMlhKHogTTIyQ3WV8w9PclR9/fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaQXUHWBsZkAOSiHlV5jNe+3lPoODRzsCSQIBsDyEanQWBfuRG68UbEbJd3w056FG6Ry1EzPyKEfNjf742v/264C0l2hv7ZqLC266VbmMZ7YYQ0H80e+SA1h36XJQSydOh64ApdVi9ErqgTVPnkySSzozT6bDuootfGBmd1Jd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVP8NXnA; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844ee166150so202186539f.2;
        Tue, 24 Dec 2024 17:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735088915; x=1735693715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXvF63+wXVZmZ2tEzo/T2HLHzV82DaeWxnPIIlXclaM=;
        b=lVP8NXnA7t6dxSVDZdehy9GAbArf5AcYosg+ItrPZCIW0na34wvuoR+WGddZ2fETEb
         5Iw5PDbyOP4gAk813e9ffXLMcj0L19EubaGKWhrELcJ8VB9LeP/47pAWr46zBdHOhC02
         2+RPGYrBNbv6LeJGzFfrbF+5aHozO8dGarLDjoJ2h1uCI3EW0JiNLnUuOK0rpLvOrOxC
         sTHSIL8SUV305Wi8W6Nl0o07jGOmA3UrXUVongG2g5CKKMcYQN9VVsjTrqlpGiysmiYe
         6LYFewUJwRe0b5IMGF26p4DQOihVmc4a//En9Iqz3QA0ABocNZmjoSeB5XnC9hI8KzZH
         Y62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735088915; x=1735693715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXvF63+wXVZmZ2tEzo/T2HLHzV82DaeWxnPIIlXclaM=;
        b=d9vAfgWA7aZvFop5Szw5EvOlL7rkmaPBdUIURUOZ62gnMLfPCLiOor/hD0BQSp4NxS
         Q9tZDWHYx8sjRw0te6kUC0COh5UzaUrDU2zmu44XfpfIYkg6j5rEiy/r3dUjY6oOgjFj
         d2ciMsl7LJ6+3y0qtvtWsPTkWyUFI15r3p5HozJ4gb8EY37j6GdFqyd/zxdkR3iDrjtX
         RzjviTeuXdfZMCrWwbVhL367hNdf5MaGnsRLhb0F65epyyX1sev8LMTOPYjYqVb2Gsi4
         l97TSkcDJ18DBL9UYtd/uaVJwR9iVEbhDdw2meY+jRujCBHVyh/C7FHxZU14In0CwTsY
         gF5w==
X-Forwarded-Encrypted: i=1; AJvYcCUPatg/VvR3HFmHx81OhdJb9HbYuPhXDoHMebLqKjGjoWCFR5Hz4+ZsHFKxorXfjqCWmsnLwYVFt80Zg98=@vger.kernel.org, AJvYcCV06u0YGJvzr8XdmnqTAlUOUfcHDfBdb9nDDzQEx3zPN48Yw7T766JHxQ9BR3y9lcnAcoM0cmF2@vger.kernel.org
X-Gm-Message-State: AOJu0YyVG2VVrsku2X28SzfE+9KDf9vMCLcm5mGh27v2oGjF0MkQ6LUK
	mW5TcMfg1Zk1HDcXTll1dr3ihpTHCKoeqe139w+fJxjmNnu0kmBA
X-Gm-Gg: ASbGncuLso195usw+BxsYlOf89Z7upMNd1NhQQ4zQgBKdt2zIKiLj+lhhKtfEZoZuWI
	ngJVPAp+BB1AcCocXRy45B+g9FWBLxDrzpdpd7J0LfcYxnSJ+7rLT3M1526sFTv1KVqmMyZVtsr
	dI+F/oOkH0ttDOis3UM+/8mS+TZPduCO5UQvjsjF8gRJhc90KPlZymuOV3EIyJbDVff4kwquTjN
	Xk+IWGcXHAGOS7Gz5kR6yXuvsJ/LJZBxEKtOGqpEPaQGR78hvYnzL2Rp/YBpbWPVRR+nS2ZF2o0
	Of4UiLaDSJB0iRE0N3CaT4TD+9HAdXcdN2v2XQHwVVLOuJTySKQ=
X-Google-Smtp-Source: AGHT+IFB3y5H+9iEKBuoTSTNik6wOcuXJdPjK0EhbSoIlpCRHH2IgqZxfHIlDmJywGZDWSvjvE+LSw==
X-Received: by 2002:a05:6602:6c13:b0:847:4fc0:c6c3 with SMTP id ca18e2360f4ac-8499e6277c7mr1887475439f.7.1735088914689;
        Tue, 24 Dec 2024 17:08:34 -0800 (PST)
Received: from T490s.eknapm (bras-base-toroon0335w-grc-31-174-93-21-120.dsl.bell.ca. [174.93.21.120])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-8498d8aaecbsm291178739f.39.2024.12.24.17.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 17:08:33 -0800 (PST)
From: Antonio Pastor <antonio.pastor@gmail.com>
To: edumazet@google.com,
	netdev@vger.kernel.org
Cc: antonio.pastor@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: llc: reset skb->transport_header
Date: Tue, 24 Dec 2024 20:07:20 -0500
Message-ID: <20241225010723.2830290-1-antonio.pastor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89i+9Lt78ErDdbgVuOgvSy=UBz2Vhnp=cJYGvwuuQLp6qjg@mail.gmail.com>
References: <CANn89i+9Lt78ErDdbgVuOgvSy=UBz2Vhnp=cJYGvwuuQLp6qjg@mail.gmail.com>
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
llc_fixup_skb to reset the offset after skb pull. llc_fixup_skb
assumes the LLC header is at skb->data, and by definition SNAP header
immediately follows.

Fixes: fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
Signed-off-by: Antonio Pastor <antonio.pastor@gmail.com>
---
 net/llc/llc_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 51bccfb00a9c..61b0159b2fbe 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -124,8 +124,8 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 	if (unlikely(!pskb_may_pull(skb, llc_len)))
 		return 0;
 
-	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
+	skb_reset_transport_header(skb);
 	if (skb->protocol == htons(ETH_P_802_2)) {
 		__be16 pdulen;
 		s32 data_size;
-- 
2.43.0


