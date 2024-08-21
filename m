Return-Path: <netdev+bounces-120734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC42995A681
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B3C1C224F7
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA99B17BB04;
	Wed, 21 Aug 2024 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="cE72wCy4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BEB17B50A
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275376; cv=none; b=gmNM+g+hQlQHH2NQdUiPDmrGJkGHgmaM6X8x3wOYu/qbAf4Cp+mIGKLaPj0bWtKX3twTTL4otaFpbhYci+m+cB+u+P0EX+/04ZI7Dpx/Vgmpqh82adRC8sSSqj1xQPik2c4ewKdegKHdPXTMuViOFNs4w8O9xnnlBAU6lM47NuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275376; c=relaxed/simple;
	bh=J4jhXfuZXVsA1fnIFK2aBdNRhCqvs1bcYCs4askDyfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2HJSfxTGwnQdM4eSxF3rv2a5yynAEtITbmiJH5E6bs0YEcspKhzSaES4EE6aX0SxCO4EJBMm/o+JUPcqLEtOV4XqnFb0u/MoC9CBjst0Sd57q+1tPYtKIdlxFStTBzjDhDV3ezZ4SB+qlsST64G1rqLbAec0HqdYfTZ3yDWSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=cE72wCy4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20219a0fe4dso1322285ad.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275375; x=1724880175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWlusxC/4B0Tt61cIudea7r7QbRBK/lDmlXELXrJz3M=;
        b=cE72wCy4ZBc0/+0WNT87HK3J9cAklPodIGlL5+BOF9+3G7b+gj/e+3BO1rGU0L2VFw
         5LwejM+SovcjvFSdgXUcJ68wA7oUt0gSgRHATlO2+vX8B84HtxcnN8PORm9LjS8wMRhr
         VELXamehS74j48oKC0AfqdXSExR9hXXMyRBATlAWSjkZK1ffbisYV89JYfSGtIAOX50u
         NU/zP0NC+bHgNyGsq76WE+4UpzLd6wnDCP46+aGMnLM0abtvAS5eD5h8sUS1HfkKdENO
         iWsf3c9O+GX/V5+xRr6rv2IcDwUNwGWbBvrLZkUoW0vi2s2gLGabwEt3iprFR1mbVKUZ
         Qb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275375; x=1724880175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWlusxC/4B0Tt61cIudea7r7QbRBK/lDmlXELXrJz3M=;
        b=MmYL0iMKuGi8iKbW0YqC1FGarbooCqUtEyGiwXg6b909WoFspbR9qFwXPgA5TD7lrc
         GSJq5cOYSYXdfFJZAweCBQoVqpoGUtQXfZ12dc0bQYarFBMYvtxzzAhj41SWxTmMJdIe
         JOb9rfV5m11gyUoInNmz/NeXAZZhk3DKwA0vuOOq68YwP0tNb7bm6o2TheeLUS16cJx4
         roWS43u5hgRGqeqwQnaDjIqFOTvPik2ceHYDl7Ag2Cvq++arGuUTRmD3mJPo8JLYgcJH
         v6NPQxyLLQLxVTL+knrqzE+x0eTRvoq8c1Yt/5GJIPaoJu5I4CAK2cTWoIno4JtCRAx4
         FtKg==
X-Forwarded-Encrypted: i=1; AJvYcCV/KbjJfCCSqzFZkLUvqpiWFQBKyC9ld9qN0FRvqWPvT6KckwjiBKHGyBPPgqQO1MVRRYMm6qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjb+wKjPSHC/uh8PoNSRjuTH04le8ySlKoOfy+8AhdOzGK3gd
	xr2ORkpdfJSTbrBXukqfEQeUWxl6FviW5EozmUbr76Xsk8wnBWEL4XMtRcO40g==
X-Google-Smtp-Source: AGHT+IESiY6uqwnmtMIbInVxU4n1CDlMMGRMdJ7VdPyUHrT0bhOlkUfkdS5w3apy4szvXnLNBbf02A==
X-Received: by 2002:a17:902:e546:b0:1fb:8245:fdeb with SMTP id d9443c01a7336-203681c3183mr39163705ad.64.1724275374698;
        Wed, 21 Aug 2024 14:22:54 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:54 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 13/13] flow_dissector: Add case in ipproto switch for NEXTHDR_NONE
Date: Wed, 21 Aug 2024 14:22:12 -0700
Message-Id: <20240821212212.1795357-14-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821212212.1795357-1-tom@herbertland.com>
References: <20240821212212.1795357-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protocol number 59 (no-next-header) means nothing follows the
IP header, break out of the flow dissector loop on
FLOW_DISSECT_RET_OUT_GOOD when encountered in a packet

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index ee80c2d2531c..e34c1b6c36e3 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1991,6 +1991,9 @@ bool __skb_flow_dissect(const struct net *net,
 		fdret = FLOW_DISSECT_RET_OUT_GOOD;
 		break;
 	}
+	case NEXTHDR_NONE:
+		fdret = FLOW_DISSECT_RET_OUT_GOOD;
+		break;
 	case IPPROTO_IPIP:
 		if (flags & FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP) {
 			fdret = FLOW_DISSECT_RET_OUT_GOOD;
-- 
2.34.1


