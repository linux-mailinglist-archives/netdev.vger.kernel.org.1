Return-Path: <netdev+bounces-120793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D21595ABED
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 05:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282A0284002
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 03:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0521F947;
	Thu, 22 Aug 2024 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw7E9hcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58041CAB9;
	Thu, 22 Aug 2024 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297575; cv=none; b=L8I1mR8tSSYopmvz2VYwynb6YJ3Ya9EtArgWfLR/9R+DIeEPdn8ZHv5xkzacA3N1CqNEWKkdz9FvZzyq8wnv+cd0Yi+16G4DRS3A6x3HOwLst3LNOmh0LjmWI8R/0X+GuTN7o8TA34JNVqwUVdTwglvA8g7e5qVa+hiA6z+GZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297575; c=relaxed/simple;
	bh=FwlmxzgNNsXV1CHaYSFMIgNpOIJtze9CdHh9q/2DSgM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=J0gNOvMLkr6ZxuhxzkHf0fCJ3T/LYT0DZhrysG7NAOEaOwkW2+aZt31ykz8CiN2hJLthi5tIzvGL1D5T6kUa79SdbaLcPvO/xolTUw5HXaLoVWTvk/HgpTaYMxj93lyd8vO3om+LJ7WBcRMzjwVsUEKUpxIHhUTOQVHm36NEOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw7E9hcz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2021c03c13aso2513285ad.1;
        Wed, 21 Aug 2024 20:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724297573; x=1724902373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsdM0828MfQOpBE/mASYHCli1q07G8PE7B75VM5BRRY=;
        b=Mw7E9hcznfYp45t4DVFL7V5n6H+MFp4BXs6yjNVbCgAFvAr2vhaIzzxFzkVpA35TqT
         fsX+gL2TO6D+SpYL829ZMsD15zPU0tYepqco0Ds0kHsMmmTJIoj6HuveeotgQRTxK54k
         53aYvAk40Pphme9DWoJBzOc/pTQN9T1X2PU5moNJeueBWFno69MUQAgjsvNmyDkNsLsq
         7JS10igrn+TqWwNe0SHoeZ5U+E/hrprHuIrTuayEeAOxti7lUR+T2/IumSxOcWq4hws2
         m+ZBxXq/pFP5NYkDK6DtvOucTrAqrWTYfX1WN8ni9FuISf+wOgai4B3r32iFLPnCft+l
         Gh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724297573; x=1724902373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsdM0828MfQOpBE/mASYHCli1q07G8PE7B75VM5BRRY=;
        b=Lzm81Mn7ea6raIuPlwdF8R/z1lcOIpj34kpkoYob+mFVDy/56MLndZOBoW8iehQsFm
         3/xYA6W58NyUK2HawDRAvFME6R+lnSQwSkLIHY4FYkL0l22PX5Dod3JFnmXsBDUMorW3
         6csjojmYeg5LqyDjl1c3NCZmu4adSDFWUGCkmJc8segkuPwEmCUT2UxKsLAV/vdZL5vj
         FAowp5C2S0J2BbJF4dJvxicUgyJ0rMdZGV0Bw4PMDkjZhVQGJ3b5p9NZ81+jmaTtYAg2
         Qb0s80eyRGqPNH+Rw9FlhDO5F6zQ75uryZknqmp7Ga4MopIN0FVnpFs3A2q2FmzgQ1mg
         eMow==
X-Forwarded-Encrypted: i=1; AJvYcCXfj+ySKzNkg3gH5o0NmXnCj12pIPoX0B+WqVeWKXBlEZ7ubucKkk5UaYPune5ctkZMSt78jik+@vger.kernel.org, AJvYcCXoPS7mUnkwGfMxYi9gTSihUMfyKtB+ch4QbJTrJOZspLVG/BglXOh9y1HYYWRnkCtwMVU0VX7eQ+Mmp7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCq5dEG47tqgx+LSdNP0WPtyjx964uSdakUZPvL2+Wb4JYsu1x
	ceB+nAIIgRFWPoolI3XxvD8J2h7CgmSMIG0SqfJkniiStpku7BgBnFTk8FwKiY0=
X-Google-Smtp-Source: AGHT+IHu2+Ak0Mb+Bwigr8bEWAHyxnvGBhnxMZ02OWwWSVSxNRBgFwudGO6lFR5bbRv7jRHMexRIgQ==
X-Received: by 2002:a17:903:2310:b0:1f9:d6bf:a67c with SMTP id d9443c01a7336-2037ef230afmr25768785ad.5.1724297572738;
        Wed, 21 Aug 2024 20:32:52 -0700 (PDT)
Received: from localhost.localdomain ([58.18.89.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dd2e8sm3122885ad.121.2024.08.21.20.32.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Aug 2024 20:32:52 -0700 (PDT)
From: Xi Huang <xuiagnh@gmail.com>
To: madalin.bucur@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuiagnh@gmail.com
Subject: [PATCH] net: dpaa:reduce number of synchronize_net() calls
Date: Thu, 22 Aug 2024 11:32:43 +0800
Message-Id: <20240822033243.38443-1-xuiagnh@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function dpaa_napi_del(), we execute the netif_napi_del()
for each cpu, which is actually a high overhead operation
because each call to netif_napi_del() contains a synchronize_net(),
i.e. an RCU operation. In fact, it is only necessary to call
 __netif_napi_del and use synchronize_net() once outside of the loop.
like commit 2543a6000e,5198d545db. here is the function definition:
 static inline void netif_napi_del(struct napi_struct * napi)
{
	__netif_napi_del(napi).
	synchronize_net();
}

Signed-off-by: Xi Huang <xuiagnh@gmail.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index cfe6b57b1..5d99cfb4e 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -3156,8 +3156,9 @@ static void dpaa_napi_del(struct net_device *net_dev)
 	for_each_possible_cpu(cpu) {
 		percpu_priv = per_cpu_ptr(priv->percpu_priv, cpu);
 
-		netif_napi_del(&percpu_priv->np.napi);
+		__netif_napi_del(&percpu_priv->np.napi);
 	}
+	synchronize_net();
 }
 
 static inline void dpaa_bp_free_pf(const struct dpaa_bp *bp,
-- 
2.34.1


