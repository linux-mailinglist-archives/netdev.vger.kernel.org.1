Return-Path: <netdev+bounces-241290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243BFC825EE
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9D03AB9F0
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5E932D7DB;
	Mon, 24 Nov 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQYaFkgi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586F326955
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014722; cv=none; b=Gj9CNoMwmtYmcQpueudGK+oc/PwfoDAKi7O1QNOQMxa8mPGuiZ9WANmQRiGOAllnP+fo/ifGKhurPiNnI62jH1nWyBIPP1CI032sSbSnBNsRq1mOXPf1Q0vNDAlI+tup/8JqphbiFNTov+ak/iM7cZV2LXfz6UTf59mDWD1NqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014722; c=relaxed/simple;
	bh=J3hF68jzqgmjNyD1IxNwaOXxmmqKlmL8s6hdxxRtl+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MoQZqFSmPiq/5IoOpzJI/rp50O5rI83mD8nkesyYKhGrVQG3YxitRo7PZeu1ER7Inwvwh2j3G1TYm1omklSMvDiGnb+ZlD3ffqiC6CFHNxAofPlD8kNdJv21YG8/S3Zc3+XkPJaCQd7TlZMaKROrJZWdqRLU3SCQSt6LshB5+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQYaFkgi; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-450063be247so1604717b6e.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764014720; x=1764619520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AM2fqWLctcRWkTsD3htge6kdfIUCnI4hrH3kfYs1LtQ=;
        b=QQYaFkgiMCUsyv71HrwrfsoBM/YTweYP3aQz2oS+ccclZch1t2FIA1/iZZ8mV3QtnN
         MIzgHu5Ekn4eiIQmzziznaeNHyiNrswQFZylXLmq/LCCqm2NjqRvy6muI3wk5Bq9jLbR
         RhNWN958NRLuqtDBL4W8uLPs3k/tkQKDUl6/NxZvNxFhPmaxDo58NSc0FJU1Qir3ytKJ
         KWKEhgFe9vVmuLqFrMstYUmG3Cu8QJRK6l3cd+EZpgYShTTS8jMlTeq04+FRjnpaU2Xt
         76N3BKMlLGYNetf+rcrsEtBjv0wfOi7mOAhROcgkiumsEHvGpNl5hYio/vbKkHE04T74
         2DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764014720; x=1764619520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM2fqWLctcRWkTsD3htge6kdfIUCnI4hrH3kfYs1LtQ=;
        b=qSGykwAon36iGVff7WXOr5djV4BYDFb1tnyBSnKLu9gygt844Hpkm4Qnj5rV88ZCUB
         N2SasdVsilzhBg4p7CvnpUs6WHkrEFt/bNrSVAjDvqrO/3AM3AGN5AfGqz2ZCuMa/Mx0
         GhWrYBBJN+D1zH1KF+5Ys8Rw6xvouuS1hbO1MplJmdn14XtBSipYHzwkB6H+b0a62ok/
         bU6qywvOHg0RyYRQ4EoGb2bcLzalt2Ir6/8ZIb8ESsWs4NoXnYvx1mZvI1RvLmhJ3c9J
         P4dhJrBB08rdoeZD+cSGeYvc2fIQ6Kv38j9ksBYAQejHSuxArcnrHPHWuJf/XtWuh1HJ
         k8Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUKi2zBr80m3Eg4VOHCQoj0H/6seFYdTuheuM+tlSc5fAB2tEFrfgkg3fZqcPkNPaU8G/O4Psc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhbBiKr1iwxSQXnf4We4HIgxo2OXD0G+4/OGp9dXB3iEFBTwQh
	aE1kS/U4zLsLpbByOipsTe7WAWxu2EjgTwX9FG7zMDKu8Pos1RMHCE6M
X-Gm-Gg: ASbGncu+t+z7Zbuf4/QWuYSSN06RmcT5nG86x8n5vl9LLy0u2wGyyzzYu918sKpgZy0
	GFu2XUbSaiKQY46rds5mVPLLKI36zQJ3SAF18ulrIsWQCot6G38AaO9gQj1BH6tP0zD5hCxTgOJ
	Qy/XQRR2Vuap++y+cHeRckpjvhQKaMU1fmRjBCIvBgUqK8Eif0ORxTMHYV5vpbSVLgpaW0XFeuI
	qHkID2h+Q2Kkx2+4iGqs1go7emHdT6sY2GNoFBXvghgyrClIpGCUuFIVwqXKvrucbwBVWAFluzL
	zINktG631zM0FmC45Oj5sq+w6hKQcA+AxNOxMJWysyGhkYSyTUofGu/y51bF4hVTX6PjC2KRqET
	p3fTvCfXT0D6ywXEo1bdMfRPvQ77upALVq9nzFdeKJpyMlOXqpWHNQsSId3u7mBhZgK8HZKAznG
	55F+B/dhNrhdeV07WQdwP6PFs8qm8b
X-Google-Smtp-Source: AGHT+IGtB3gcCrG6+svWZQGIfagCxavLXWyHfNOdc+JDYMftYZ+uay25azU0d0DsBqgGkDHiPFMGUQ==
X-Received: by 2002:a05:6808:2e4c:b0:450:1eaf:ee2a with SMTP id 5614622812f47-4514e7fdb0amr190890b6e.54.1764014720021;
        Mon, 24 Nov 2025 12:05:20 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:6::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9dc8ab10sm6626759fac.16.2025.11.24.12.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 12:05:18 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] drivers: net: fbnic: Return the true error in fbnic_alloc_napi_vectors.
Date: Mon, 24 Nov 2025 12:05:18 -0800
Message-ID: <20251124200518.1848029-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error case in fbnic_alloc_napi_vectors defaulted to returning
ENOMEM. This can mask the true error case, causing confusion.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 56744e3a14ec..13d508ce637f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1808,7 +1808,7 @@ int fbnic_alloc_napi_vectors(struct fbnic_net *fbn)
 free_vectors:
 	fbnic_free_napi_vectors(fbn);
 
-	return -ENOMEM;
+	return err;
 }
 
 static void fbnic_free_ring_resources(struct device *dev,
-- 
2.47.3


