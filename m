Return-Path: <netdev+bounces-225613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819D1B96138
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D9F4A0035
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2043218AD4;
	Tue, 23 Sep 2025 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw1LFIKK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0626F1FBC8E
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635297; cv=none; b=nRzjnmMT85xYoFD1xH8QJ7PMdJuXKIahd3Rci1UXmfTd5yyCjL5qV0mDm3r/2CzIAPmWxRJdTcibooztOb+06IX+bPWHnGRJieVbzhel3VAHC9ssgwJEmXnOot82QoXgkjywAMbDbN1bWjktUa/DuaRk7xZWwZdtXyXUOYN418o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635297; c=relaxed/simple;
	bh=h7/FR/wOqwI447R5Z7nk3yAoxG5YTpFjgQ3Fw4jNfO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MA44P8du5SACk1UBp4fsoTAykMPDc7NHMTT98PLbT+Ryyby+Mx2lsAymFE15+TlUuiWKjlyXlFg6F6fI96aFOq9g5jeOM28niPurFFNcPWrjlbbJapRrzT6eT+hfPpgYlKiyz9vG8GVKjOFHZOidtnePhQbeMW/1+s19oULphP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dw1LFIKK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e2562e8cbso1900885e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635294; x=1759240094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hdt4dy22dCRolZPOpFu2PTUaS5plAPUzmADLxiXfYvs=;
        b=dw1LFIKKk+dR/vgi8fACgMtAlm+2QWdU0No63mQZddnV1Zyjjw9n55ONwjiNiP48Aj
         kyCrbM2wEX5lNuTLj/ARtNu+bGSbc6ckrSWMgfnemsoro/FghWcvt0V5RBSYjMuOO4L4
         4pNOsyV+4rPDVk/bpbPiL57vjm6Pd3aUb8NUJsO+K2ZhgSUuVAQqMrmBSUzc8XSxFg04
         lNFgi2dq/sYCnrGLS0UaoPvE2J5g9+otOyA/oaxkwWKaT8+ahJcPQ+Zo9S+h6kIO8xPz
         gJsLZLKxr3OA1yVJny89ZYYKo2fd+9ggO6kRrUCi9JlAly37si4qg4hXsLzRCWbHxu4u
         Y2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635294; x=1759240094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hdt4dy22dCRolZPOpFu2PTUaS5plAPUzmADLxiXfYvs=;
        b=i452xAwva92uw+BHwB4SNCngmfWAb8zbUMiCDahbTTepB3nD5QuYeCDxM/idGFELBf
         qPVnH4MRKHNgaLDccUvKVSROqvSsbCt+dVaIcfSoLSnINUnIzfoh5kZ6rOrMoAG5i3hR
         3E8QOe3jJWjmwNSndUvcbaA6cUnjtYOc6pZF+TqIDRn+chJ+SmySqJ5zklEjrKiHdeon
         ffq+Z2UMeSJIdsbUeAh9bI6pQPkAv+ysoEOE3t/Oa5eebDEWiTzoP5ArmgBpJFodXkaS
         HkBg7bAAe/4jJkbYCvuIzlkxi8Wy0XdglR4jQABdQb+dSsUKZmBBbz16LtkKL7yUblwZ
         f76Q==
X-Gm-Message-State: AOJu0Yx2hvzDYehAQMQl6rPkxv1aE2licgHMSPyTnreZQLMPYV2fed4e
	FSs9VCF/ZVUjNbpicMquWrSrWzFHisqwxaCLllcUNoAq3BOanCYes5dg
X-Gm-Gg: ASbGncsCzAO4K9L4yrW0J/5Sme1YS0XTburPogfWw7SnyUsWSPCskCTH3v+dsQ6Mywl
	RhzH9TF7EixAqZcBCY2ser9sVzNSU8zxKpec3VkLkGvVC1ks0flfR7rgXY+bJoDnxJk2FdhI+Cz
	W1WiI7//QE7o7hMOvZB+yg+2Q9fdY5kXwk0aUEZMinsYFkAztMffhSsGNJ4/bnLa8nIZGVaUlcC
	EtMQR/mlsz6XbCsBaf9eM30E7Uv/iOr/xnQF3EH4sQOPLq2QyKRlPAEsxgd3P7sZG8LteAaZI9T
	kQFT1D8ohkvO8IlyR3jbsp0P/ZBlZ07tK1YzlHzD40/6gQgeXv+nwMwipipG3F8MWgNwf0VZFs9
	gBrn4FZmnYRObWdZl3rCYDcIVb3IBX/fKEqhTFbyPNrWU7vHo+vsJ2XAYv1Q=
X-Google-Smtp-Source: AGHT+IFwa1ryJ2S3yVoLuC4iFgoPiS+QFdmQnrEc1muZempGFN0iBblIq5qFIY4tPg/kgRLzmGj2dw==
X-Received: by 2002:a05:600c:46c5:b0:46c:d6ed:2311 with SMTP id 5b1f17b1804b1-46e1daaefa7mr22421005e9.19.1758635294094;
        Tue, 23 Sep 2025 06:48:14 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fc00a92sm24239728f8f.63.2025.09.23.06.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:48:13 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 10/17] net: mana: Remove jumbo_remove step from TX path
Date: Tue, 23 Sep 2025 16:47:35 +0300
Message-ID: <20250923134742.1399800-11-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

From: Maxim Mikityanskiy <maxim@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the mana TX path, that used to check and remove
HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 0142fd98392c..5a4eb2bfedff 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -281,9 +281,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (skb_cow_head(skb, MANA_HEADROOM))
 		goto tx_drop_count;
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto tx_drop_count;
-
 	txq = &apc->tx_qp[txq_idx].txq;
 	gdma_sq = txq->gdma_sq;
 	cq = &apc->tx_qp[txq_idx].tx_cq;
-- 
2.50.1


