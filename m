Return-Path: <netdev+bounces-130374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2624698A470
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A6EB27603
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64D7190660;
	Mon, 30 Sep 2024 13:12:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E2418FDAF;
	Mon, 30 Sep 2024 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701943; cv=none; b=lNrtKM0X6IXOuaTqnM53gBfctDFTBs0u+68DxPNjFrxbQmBH1koRr7Yks2OLNHz598TY6oTAefvRWSZWw1O94AyMiiAIeiQM/CnQ+SAXYnOnImGNbPqpZo2Cp0qvA3C98PX3WKYBWfpgM+vSavhFdzl2FTPUrkJQE8m1LXA1D54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701943; c=relaxed/simple;
	bh=pRaK3Ku3IkQXoZTZoJ3KsKO2/UXaI4WyWbGGP/VRtPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKrF3tMEX/9ObOFrjSRPyolSkemROxIwRrySYvBzRKjhva8Ur+2Pnu3AFSgFj0KEIQt7H0sLiTTs+feFcOtedI2ZcJyRE84wmKWPuVSyImAXz0KTuMxHQffx5nsNcbcMOGhiowc3b97fhpHOyuF70YMu+MY16MZ1LNowJHYp+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso36432321fa.1;
        Mon, 30 Sep 2024 06:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701940; x=1728306740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEjz2XP772fB6v2V8zpQRQxhqoxNSwh9E/XJx/MNIPQ=;
        b=v6p9QFaswCe0JMdPm96r/jyLyOPbc0INa/yzf2f7bvjLzFQ5O/pNuA+/jp716S5CZ0
         JoEQuih3ptPhf5mrj5x52KAdY+2UPep5IXzo/9G4X09AfTPnvINwtVzeJuPZCaKC0p2M
         VaZxWGYkWUZEKTnpXKaTVQzE5ZI0JgbENbFB8EDM1FgOZt6L66byjCeYj1N904/PEUDT
         5X6kPFKDI4DwpG6O6EY8zH/u4HuNNp6tPYbEn+98MDeOtqdbqkTEqJEoGJBk/s6UOXlW
         VCbUgA7UxCYbtBXqeRKuir+mVTbN+YtyH5XUxMD0K4JgEszl+WyAKrvhj8UVWNeaDcV1
         cg5g==
X-Forwarded-Encrypted: i=1; AJvYcCVCDI99QskOw3/zebEYE3/dkxeRMcGDki5SiaCkIARBmQ7SS3N71Gdhx0g5zh3sCzzHNQaO1RnsZMfL70E=@vger.kernel.org, AJvYcCXJ+/e/jFVCcLk83hV6I7x02aeuYfHnSH8o5IIuSq2O13Qt5etd6qARnSKSZoVE1duiYabvFu4D@vger.kernel.org
X-Gm-Message-State: AOJu0YzFf0iE+nvWmei6Z0ALrHJcaRopiFUSnCTIzRpb6SrErN1jneb7
	yKpozAstuotSVIM20ROQfZkRzge2RhvJjpfA3xCUMhYGYKGkeZat
X-Google-Smtp-Source: AGHT+IH+WAUaEf1YWJiluBVMe/TvS0Q+jjf7SnZ/LLAzf7IsYPn6xJuKxD+rfxCzPYl3qJP/ViaJ3Q==
X-Received: by 2002:a05:6512:3d04:b0:538:96ce:f2ed with SMTP id 2adb3069b0e04-5389fc343c8mr7812782e87.10.1727701939989;
        Mon, 30 Sep 2024 06:12:19 -0700 (PDT)
Received: from localhost (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2998cc0sm525840466b.191.2024.09.30.06.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:12:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	max@kutsevol.com
Subject: [PATCH net-next v4 01/10] net: netconsole: remove msg_ready variable
Date: Mon, 30 Sep 2024 06:12:00 -0700
Message-ID: <20240930131214.3771313-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240930131214.3771313-1-leitao@debian.org>
References: <20240930131214.3771313-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable msg_ready is useless, since it does not represent anything. Get
rid of it, using buf directly instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 01cf33fa7503..03150e513cb2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1075,7 +1075,6 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	const char *header, *body;
 	int offset = 0;
 	int header_len, body_len;
-	const char *msg_ready = msg;
 	const char *release;
 	int release_len = 0;
 	int userdata_len = 0;
@@ -1105,8 +1104,7 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 					     MAX_PRINT_CHUNK - msg_len,
 					     "%s", userdata);
 
-		msg_ready = buf;
-		netpoll_send_udp(&nt->np, msg_ready, msg_len);
+		netpoll_send_udp(&nt->np, buf, msg_len);
 		return;
 	}
 
-- 
2.43.5


