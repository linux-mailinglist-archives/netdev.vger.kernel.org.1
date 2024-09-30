Return-Path: <netdev+bounces-130603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733D298AE49
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF91281029
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D011AB532;
	Mon, 30 Sep 2024 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBzEUDLf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871A1A4E75;
	Mon, 30 Sep 2024 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727890; cv=none; b=CDNcxdmaEI9I1b4HDo1Sq2LMHRASppQuYHmp3YwBo+gk3CWEALpkfoEHIj7TqRix2QIPckeGq+qewdHrGVKx99FDmmo4SqeWeMdo1GCjzeXEjvgW+x58ESFb2HwNiBMQZC2Gc6ohuI4ZV8T/181LFAUrMkdXSpcJ13pASVkc82Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727890; c=relaxed/simple;
	bh=8kxk4+UMI3hnxbqNGsCvaPbUoG3GnRoirMjLsMw9SyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmSuBsNaAINWuMbM7ymLrqZxyUgHqwSI3yciC5wFu7ZM1ERc0/nB0c+BKmxfIa2YGadLVyg1+NsXdUn6GYzwvNH6mHKGaU7F/ijdQkWUfHSiJ1tmV/njbJhhqWOXWCiBJeuZiwCpq/7Ns/URjjUX0zAeFOUJx0EDQwwH0D44p1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBzEUDLf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7193010d386so4153469b3a.1;
        Mon, 30 Sep 2024 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727888; x=1728332688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A10LIzIoNF81DiF3j7aUIqtKQ+5nYw/hz6Gf8YfUK4=;
        b=CBzEUDLfcWtNr7x+ERXBdXMqPXKS2x4k3vjEMAOvhFOf3SpxvI2ZVtBNgmNKo5u2QF
         Rz88FFt3YKhMQX3/N0SP+l33yvNBniZRRtW3buiSenHl2PUbLFdoL7Z2QzLjEtmHAa1q
         /FdobnyT2NGZ+aByURuTEOiBPYdVBhTLh0LiGcD4iR177hXJ/HapvL3zYfgvS2rbfKR8
         JrH+SjfkVfD3RPGuHBIS41dOG1ktp3huJZC9TMoAYz5fZwjyXHEyozw91OZT5DGxXXi+
         f2iqWUpPWClJOWEenFYkPc5RE3axgHIiJefe0r+8Ak1zW4r8hhCCt1UFgwMQ96mzwuz8
         AFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727888; x=1728332688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7A10LIzIoNF81DiF3j7aUIqtKQ+5nYw/hz6Gf8YfUK4=;
        b=WmDs4atXW2GPK0rpBwg2aBbH1+hRil4ekBdyEhBhNXWpB0wYIn+ALMVrjehQpTIQnT
         UM5vOgCbX8HMqFj+R33v4VVq0CdCamCinJj2WSdnAJimz4sdr8wb93HOScAieOLiSCmc
         cSODkT/9yDTJVgU0UetitKKfAHinfKySmV8vbUMwW/mZFBjxDPQ9eHZjeJcyr5diBBWr
         cRa/vQkDkHuVVZI52glLMCubpFkOC6ufxMqYoJm7I28McLHUsnVoFh302ogG2H3sekbo
         JwFbz7SOvWv4DvONTuG6//9bKKVamNN8R4Hqyx2wswyCA0/8KAlYDillYjfn/T7ON3ZI
         orgg==
X-Forwarded-Encrypted: i=1; AJvYcCWdWN6wR+sd4zi4CuSE70z+DRVJgfeD+KqETjmfNwg4iSnrEGKimTbBLHkrcqYiqcO4f8s0W9A1VYCAZRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqh1TNj2Tdim+/hKTpERBKPiywZE1jcCPhaTjR0RGyHMlXpzKb
	wQtWAx4qacyTcRrJ1GmMfYBdVIBw4pBrlCT0zSaQpDWRWtcH9HJKRtQ5hf/t
X-Google-Smtp-Source: AGHT+IEm95g7LstFJamfBtP2W86Y0QwHD/Rz5PJO/tHA3Wlhs9X05sBHz4KIizEpFw7UFS7MzyFz4A==
X-Received: by 2002:a05:6a00:9287:b0:718:d5fb:2fc4 with SMTP id d2e1a72fcca58-71b25f38c9emr18662488b3a.9.1727727888010;
        Mon, 30 Sep 2024 13:24:48 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265160a5sm6670623b3a.103.2024.09.30.13.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:47 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCH net-next 9/9] net: lantiq_etop: no queue stop in remove
Date: Mon, 30 Sep 2024 13:24:34 -0700
Message-ID: <20240930202434.296960-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202434.296960-1-rosenp@gmail.com>
References: <20240930202434.296960-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is already called in stop. No need to call a second time.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/lantiq_etop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 4d8534092667..0b5642744f8a 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -673,10 +673,8 @@ static void ltq_etop_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 
-	if (dev) {
-		netif_tx_stop_all_queues(dev);
+	if (dev)
 		ltq_etop_hw_exit(dev);
-	}
 }
 
 static struct platform_driver ltq_mii_driver = {
-- 
2.46.2


