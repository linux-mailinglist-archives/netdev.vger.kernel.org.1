Return-Path: <netdev+bounces-88212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5746F8A6553
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137C728453B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C85C8249A;
	Tue, 16 Apr 2024 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct08AY2j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F5386
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253386; cv=none; b=s5aW07OH7z4TAoQ+LBT6WIAzoOCNAhM1Ps6tQTabD0Zc2dPrt14eti3+0E9BWFtEpkFhPM+elEQesuwp4S46ftFQ6qXhS1z6P67nCKyHylQVoKXKGdpj5EEofhzdUFYaP98kFQy98q3rowBAxFJtXgv65CLpvWal9BBpyW4QFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253386; c=relaxed/simple;
	bh=QjJzx72Ii7Sp3a22OsYNQmmWTCaSJb+lVkJBTg/YtRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0/e/eu6MMvUc9ezf9MEU4+zHoydVBa+FzvBIKOqoK/kcdSMLOJWReSaIM8CLjqQ91TKzczp35ZNpbQuge9nfxg6zA0Kq067YBwqtjQ7YJ9aASV5yE3gyEkd++zlCsSWRyKmSlfK6WlebQIRtSFU3i6ghi5+e/vAsfE8wc1vKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct08AY2j; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e2bbc2048eso33168705ad.3
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713253384; x=1713858184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NF+8s2YSkm0xT9TpPeR9HkXVuzALFR5UG13Vs9IVEE=;
        b=ct08AY2jsvx869SZvvTKn+p2jfW0rW0i1/Yr/7qiq9PkuynyY7U92oUZMARTaosNf3
         pPPh0N4NT8TewVbJXWhs0x4ur9dXTG+a67Rthvptrvm7nFqsY6iG78N5n8LiWQKK8mGG
         cOwFrh+YGl/TEf/Dku4snO0tWAyXxeGPwZv0xOmnt+svMwEFXFXBWE+rRGe2dVu2pnuy
         ejVGXFJf2My+NkbtAynPsY7Z82IISXDAqu3arb9D/V+Z+18fmb83RAmsRfK3bR7O1wG4
         DCMfRLx/N/YZJAEoXtbP7blzAflDn/xMzpvjeQMNYeDxmmwQ+Rsroyl2SA4NsMtLjqaz
         mxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713253384; x=1713858184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NF+8s2YSkm0xT9TpPeR9HkXVuzALFR5UG13Vs9IVEE=;
        b=HLCY9CLyCJYUx63QjhEp6oNcHhObxp7YzvaLQfFMiOZpSIUaZQT9waa6X51kYgoNx8
         +mGezfKaJdmMwSFfH7k15lS25oWkMNoUj7ARExP+WpbNgoh9EXvov4LJ8zpqDzIXvX1Q
         bZ2l+IQZyDX+eFhRNRK0HcJXWoRB5a4TO0+V23e2zerIy5/J+JszTy3zkDfuzP7mBVV5
         BwoNPKQRDur/gy0AFeVgy4Z0+4AStRGE1VEeV7zGY3YaKk4K4LqB0ELGTh0hxEyIBBIk
         5bDKmyQqi+xVSbcDA4pwXWsDMbX3FJoH7ExW7F37YtLdZ1IE1Vzn/Gw+HPrATMGRpuOa
         2+9A==
X-Gm-Message-State: AOJu0YxW1mzV3ZhsclYJmsbhxFBJpD5u8FaJMTPrLJrVlYLjGQoclNGV
	0DOQU9L982mWhbpbnq25AQRt86389RUGgiFalkmTxfU8Y+l1vrHN
X-Google-Smtp-Source: AGHT+IHLTl1dVWVnqEYQjV+inIDInmggx511Gyfhlk2SBRDI71FpzJ9mq1vszVaOa15II0ht3nr5eA==
X-Received: by 2002:a17:902:d2d0:b0:1dd:76f0:3dde with SMTP id n16-20020a170902d2d000b001dd76f03ddemr13284595plc.31.1713253384393;
        Tue, 16 Apr 2024 00:43:04 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d16-20020a170903231000b001e4881fbec8sm9126947plh.36.2024.04.16.00.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 00:43:03 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 3/3] net: rps: locklessly access rflow->cpu
Date: Tue, 16 Apr 2024 15:42:32 +0800
Message-Id: <20240416074232.23525-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240416074232.23525-1-kerneljasonxing@gmail.com>
References: <20240416074232.23525-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This is the last member in struct rps_dev_flow which should be
protected locklessly. So finish it.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 6892682f9cbf..6003553c05fc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4533,7 +4533,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		rps_input_queue_tail_save(rflow->last_qtail, head);
 	}
 
-	rflow->cpu = next_cpu;
+	WRITE_ONCE(rflow->cpu, next_cpu);
 	return rflow;
 }
 
@@ -4597,7 +4597,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		 * we can look at the local (per receive queue) flow table
 		 */
 		rflow = &flow_table->flows[hash & flow_table->mask];
-		tcpu = rflow->cpu;
+		tcpu = READ_ONCE(rflow->cpu);
 
 		/*
 		 * If the desired CPU (where last recvmsg was done) is
-- 
2.37.3


