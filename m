Return-Path: <netdev+bounces-202161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B62AEC695
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 12:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F621189CF31
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D1224249;
	Sat, 28 Jun 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrTk8GBq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837B1E1E1C;
	Sat, 28 Jun 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751108164; cv=none; b=QjpZXln+qBkD7AKRGSRVe0N7HMaUNuRB1krpRL+/6IL1MKoB7M6BEDG2gzDsUyrX/tNgskEfRn0HGNHs+4o1McsgO0Cp+AnuvohQha1g6o0KTOElJd0y6NwJr6mUkfFuikbMbNb27pJjKHWSoM0F14+WKBi12s3bp0a+BUOXs6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751108164; c=relaxed/simple;
	bh=KpbTmrsrRfUP5yw0LwxCsmoR/Ojb3WLsTy98XGKAlmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syP/jn+YtaX8Jr5VcmUuLjvNLCxevyN7UrMuPmGE/5Id7sDmnqm6E2Zw2OJbqEsvCtUwtZJB86CbCmZty7dMctGSR6TY1o6YchPYwrKQPgJ2U0Khu8Dz+IndmRbK41nGAtvwkJqf2VtaQ2tAYsWqF0TDs9co9GjOk1XKIMiB1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrTk8GBq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fba9f962so2994896b3a.0;
        Sat, 28 Jun 2025 03:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751108162; x=1751712962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A73jB41l9dOIANrWvvSRKqyz67Ti0po3QDM6Q+/r5UI=;
        b=ZrTk8GBq/fm6OQoo/2Ga0rkkGfjQ62FkDv8Wq4IciUqkZhH4F0LgteWKEY2a4vLsGL
         HlAaxUwFGo+czisI7uTz5Y1qb1aZ8pnA/Wi0zKgdZ/bbKuU4hZwlJqkGPQmnh4SkdaRd
         LfoIUtBby/uG3RXJE54O1uP0wOPpUjamehtd0op+V2E+ygvvub5/iGmbJKPrtxkjUf4l
         tQjb+u7OFDLJKPvl+hunZySoDclM1Oq8ZjPVw3sqpebXDPqP48LAQVme4+zbFCi0IKBC
         s74ipAF3IEhq7AmaJUoXlCFdXWubu2VkhSM4lpHrSospmvthO9PfLooVpZutLX7H0fyC
         Idnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751108162; x=1751712962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A73jB41l9dOIANrWvvSRKqyz67Ti0po3QDM6Q+/r5UI=;
        b=u0KEhwZJBuGDkAiUF2JIO4x+a/vZb1YpOjsex/fStxz0K+Iaj5gNfjbzH5zE33tt3V
         BWve6g2X7eTXORfdKoI1nIJECWnfgBjnKqD2Hgl9LANO/aTBia7/+duDMuP4xe5pMGHB
         kO//WXgnPv9ZswdmY/QOxkLMhemg1iMXpZ3NJwGztAwxsOR8hJq4t1L1ib7vensJxbk9
         lGxWFW+pjds4R6TNEs/gj4nf324vW3K+AUcwCtNE94tDxMNgScCyyrakWyzAzWhIr3bg
         WNocOUgU4bRSOV1huPpCEG1BqddeLYQ9FMBu88+OifgCoSzoaSanixSkmZlxpXwRlgcy
         2cmw==
X-Forwarded-Encrypted: i=1; AJvYcCWvjzYlVhVtAk8ON3ofDjhhtRxa0xBiurBTOcE6/bLqqd2K2TniEl9T0oqRhNBQOfQhJrTk09qoDFQeDx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8I8kmUeVzPVfTOmw4Rqn5SRN+StcaPiZqWHTfS4TQniG3z9R1
	zn0B0cdt00aUeilheZ73jQz6Lm+nETTgXmq7KP9f/BtS+4zg3xeFl802
X-Gm-Gg: ASbGncsNsgVPBc9/p6plRFmt4R33hrOl2w3eSTxcSu11QGoqFYQ6BVoheVsU3BsHCZx
	lbgB/ybCqhnyuSdAri3yajMYpQdqR2KuQ9q01Ug6A8ovvNmPuFREIrJ9GAeT2aDuPSM0fcaOmVv
	YUtj0QDx/Viy3lrQaU0y9yQc/TTpcy64RVcssYVce4KuXhQ+PI8Jy8sHeR8xuS26MCKe1DuC++1
	N7yPDcB32d6wJVzt3Th2SLc0DbPYpGmYyn9wUVIO3V7pBqhTuck0RZQOfHOlU8T/XLbgH90NcxG
	0c06IpDuDlKZj5owVjgatCzCUFkswG0LvibPx3FXCEcAo2LLi3AguLYsvfCNcnNA/PhoSIDK9hN
	wi1xLTjF84A==
X-Google-Smtp-Source: AGHT+IFnN/WfwwEwV9w7lf/KFPvTVzOXbSASDAmtcW8rNhS1ZHd2VAdGPmXGVhUDHBgTRY7e8cuuKg==
X-Received: by 2002:a05:6a00:1805:b0:748:a0b9:f873 with SMTP id d2e1a72fcca58-74af7ac66f3mr9002134b3a.9.1751108161701;
        Sat, 28 Jun 2025 03:56:01 -0700 (PDT)
Received: from faisal-ThinkPad-T490.. ([49.207.215.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541c471sm4440291b3a.56.2025.06.28.03.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 03:56:00 -0700 (PDT)
From: Faisal Bukhari <faisalbukhari523@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typo in af_netlink.c
Date: Sat, 28 Jun 2025 16:25:42 +0530
Message-ID: <20250628105542.269192-1-faisalbukhari523@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake in net/netlink/af_netlink.c
appened -> appended

Signed-off-by: Faisal Bukhari <faisalbukhari523@gmail.com>
---
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e8972a857e51..f325ad7c1485 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2455,7 +2455,7 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 	unsigned int flags = 0;
 	size_t tlvlen;
 
-	/* Error messages get the original request appened, unless the user
+	/* Error messages get the original request appended, unless the user
 	 * requests to cap the error message, and get extra error data if
 	 * requested.
 	 */
-- 
2.43.0


