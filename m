Return-Path: <netdev+bounces-229711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7665BE03CC
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BC148784E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EAF26F2BF;
	Wed, 15 Oct 2025 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxSNe3T7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5F19E81F
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553963; cv=none; b=Yt35ZuaSvM0R2upOx+lcXluqA3kMLpxU6Yvp/hdZzcfmrTnljb4ia9MCJ6BTvZhg7dQwmHVvGvUJ8Jkt1Br6TL/6nue9oLOslJwrd5HTRVaksLrCNDwQIDucxxEZYjNChaxZ9OrUknerboIf0WTx1s4rOAuOTEqEvN3afv+dRlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553963; c=relaxed/simple;
	bh=j0dB+z1QJhokdFNrZJ4E2TDUIMNX6UmtknIL+sRxQg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KJKOorXwbiMNkatyT/iYcXdMCCcSxas2LUHpqxP8J9H0yGRoEXeoXIPs9ncEMazFM97In9cQta0Gm0HQklbpuQgltEjEju6S3x0pHHFFhcHY98NiMpCDXgA1wMt68ce4q6bSuWmIwhZXFAsNDhxt4SHz5IBPHTgdUgOV9bLaXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxSNe3T7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-367444a3e2aso71273231fa.2
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760553959; x=1761158759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4/Q7+5bvyc+y+xZiQH200o3xNZSiEQX4GGlTPGcAOz4=;
        b=TxSNe3T7NP1QCopkMkf9WLGdc8jdENZmQtC5TpmmE1uY2ZC05kCXet1N18RNHFthPI
         bRP4p+IJsmWGtsgfC9ar7HTXRvk+EnJLiyqCHY0qDNo9hoZDVPL6hl0xXRBvS4F6XABK
         jAExM8nGify0l+2sikJavOlRSI+rV5HIWa5sndZUyHI4GeZSzzO2kry0QAkHgnqnlYu0
         SUXPhjn5sTCx7BAy57qyZ/DvMRHUICFBB2H/JE6duqGhM/dSuLQQZ0J5JGPS3EGm2eM8
         cI4flGJXt2uQNyT4SfW9ugRvXmza9GSmXN6ZYeQFJuwk8n+6/GYD5cAGdg0q1bktPmvo
         oWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553959; x=1761158759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/Q7+5bvyc+y+xZiQH200o3xNZSiEQX4GGlTPGcAOz4=;
        b=IxbcneFxWE+n5kQsdUUZHbd91J4C3xe8HoQwM2DhjZ+QETjzIH9AmVGDWzD1O2kz9w
         9i2CmmxG4RVxBeQ2f+oB10U3a2m9ABiIVIyLsRuD4BwVwXKd9op3tD/9LX5Op1smEuBU
         Nzd4dVCPFmSdY7PNBjwv0FPPyW/n1EkIHicC4SgSDjMlw0pWdm5Zm6mPS+IwO6gehq6b
         ZRQCiJiPlEEqLtGxAQoW6O8ymsy5H7so9R1qCh60p2uuhFQEGJi/FXOsKvR+ksaEdM1O
         bMKUYJbAyQPGwt9/Tm5jt1PUbhg6mjRED/E4ti2eSMUOyE+e8x6H5N5tniggQmAiAPpb
         +ElA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8FmF2TDV0bnN+KaHtMHh0CMIC7gwGHoZetuM+7DsgbD+zfLAiIGEYiI5cTN/NgeP0QFII6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPMpPju8RYwII//tr7MatSaS6DNxTcZGiLJI+9lIsbTQCA4T+f
	W0R99X7oRyYjWUyBms2Z/JjZCuQnOk5y/v3F09ebIzf15az5skc7Hf2X
X-Gm-Gg: ASbGncuK8miZkKOlQ8QF/DSfhJISXu4Z8VIwpKXD+ISb/nJdNZdHDBF5GuzuuAFrfGz
	+yKr/EGb5Wnn8P8Paq8u0QY5MyBWtJ2ZA3KlIHix0FKmqA3/dvpYGsv8dU54cfNdskjzvWy1ubY
	avRRN3Hr6EltwSVag64N06RfX+yUki3d8SZoIAkGZqkMHzxAQoLV2I/Cq+Y8Zb8u5xWK0VaueCo
	QGwXf5ajsbdecLH/7PN7xwnUv2OeULd1FRXlXl130JaJQvTUmtJ7/MxsbIMmMq1ThkvsPwWkEdz
	E89quwuIRw83LeYqNx/yS2exKpvNEqtmSFa76CeNFicqmT9iR4jFtQSUIBhhWvLornvbDCDHrNk
	AtjgkGXS3yzQjOyRRWRX5WZMIWClrK+TqN+9fKOmpCT+UV8jCoBKGY/fEsg==
X-Google-Smtp-Source: AGHT+IEQ8J7mN7zmFb/mTib/dJL7UdCidB0M0c96bKSMNuCRBOVnxZ/30d1D7ryje52tDGkLhm1OBA==
X-Received: by 2002:a05:651c:990:b0:371:fb14:39bb with SMTP id 38308e7fff4ca-37609d72cc1mr85265531fa.16.1760553959064;
        Wed, 15 Oct 2025 11:45:59 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762e7b6cf1sm50005891fa.24.2025.10.15.11.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:45:58 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net] sctp: avoid NULL dereference when chunk data buffer is missing
Date: Wed, 15 Oct 2025 21:45:10 +0300
Message-Id: <20251015184510.6547-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

chunk->skb pointer is dereferenced in the if-block where it's supposed
to be NULL only.

Use the chunk header instead, which should be available at this point
in execution.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 90017accff61 ("sctp: Add GSO support")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 net/sctp/inqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 5c1652181805..f1830c21953f 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -173,7 +173,8 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
 
 			if (WARN_ON(!chunk->skb)) {
-				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
+				__SCTP_INC_STATS(dev_net(chunk->head_skb->dev),
+						 SCTP_MIB_IN_PKT_DISCARDS);
 				sctp_chunk_free(chunk);
 				goto next_chunk;
 			}
-- 
2.34.1


