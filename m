Return-Path: <netdev+bounces-125672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9227B96E380
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3481B2628C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEC31AAE31;
	Thu,  5 Sep 2024 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC1qFvpa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE001A42D6;
	Thu,  5 Sep 2024 19:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565788; cv=none; b=cUqUmjHYfl6/SkBS3vo3t0QhVzgWCmkKVD0SpQkUDuGUR/kaQvrZq8GvYMN/wIiDATJulQ/mU732PLCBE115QEaGx4HiDYjGA5o5ZmNBQRytWbhVrAQE/PoMFqQA9qqIF/83eHk6BndjSNeXB3WleNClOsuP5BjjpYGH+1uEOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565788; c=relaxed/simple;
	bh=ocOTfn15mZ42FkdGoCVvk24eM2eHdWKcU5toPFzmbqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFpXMWktABXxXQ+HtUrAgujPoNUDxn0W9rbnJafSHOsC/w3ot1E3/63jnact3FzscVHWr9HfAltJBfQY65TOtvFQ/+Gg+VWf8JrDsfIqEQMZkuZfm6BXTYlaqiu+1JyyCOsy8oB35Cww+QMfRpwHbQur0sKNLJBKM/b+CL4YOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC1qFvpa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71434174201so936123b3a.0;
        Thu, 05 Sep 2024 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725565785; x=1726170585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNQBpvYKouXNClVOfI4NyYFsKZ6EI9XmLFucKyRCJCQ=;
        b=AC1qFvpa4DszVMeOMqIv/UDsy8IpNDJcoGK0LlHQNimRGS9lgUnKlPdTdxkYUBWtbs
         VMDAxDundkoDE8g2rAEOpj8VYF0stsf+dZuEdE2EeBHY649FHVU2ZW36ZSksTijrjLZC
         doidf2p2HgxqlGXxXJG0S59wEbgpaUJ1GwK82qRXaDiETbMW2prHOsmfhE47sI57Zuiw
         iDgVHjt3UyirIO7saT8VNqqYplQ5/otuJLbIkJq//op4XcAf0cbaUKCctuQL4CjoFmgB
         2bzIJlRFcpZIjSVVFih4GTQFMsOm6Nd06ET4FiPgbCIv7SZrKa81cPINtyAddZspx1/O
         /ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725565785; x=1726170585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNQBpvYKouXNClVOfI4NyYFsKZ6EI9XmLFucKyRCJCQ=;
        b=eIr41R2oyVKZpndEtDF+IPjWC8Eonzo9RceT5hzK2SoGlSHje/QHhIzOjd3YiOj5fC
         Pkfi7idkAiotohygf8TQct5pvAJ84buhKDJATs+nkTAjlXgvMLjJtbuh4ZBPK50qmS8r
         AfTIunSAKswcT1Dk2YocX0/uSUaEQPEw1L50+JA0xnQ9lqUamV8xkqbVZi7RFkGx54SO
         bY/SsFXIgSo6xth/PktGg7hsU9PRktPt6b+dRWGYljW4aEfqiXVbPywv4rEk2QNcYw3i
         bwgwO9AlDrDcuAppkpeoBChYQBfbUqTlCvQFc1eYWNK3EKfHf5gEM87BHFDYCbyxmZ+B
         Gssw==
X-Forwarded-Encrypted: i=1; AJvYcCXLaMAjx5tgkiqGXA6vkHssTQ8MWh5iC8Ifw5h4ganRVJAxtE8eEVjlDbG2SgAAE5WwuhL1hWJnVHZ+Z68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhpt5HRGEaAl3CwRqVaMD/9YpqbRW4CaztsqXn2GloNWnCV3Mk
	gRKn84/oKD0B0+E9KOeSMY5x8mujbI73AIDpz2io43EP9tI7tmS+0n5Iqyfy
X-Google-Smtp-Source: AGHT+IG73rhYUtUHyzQ93pumcceiIgg9mSDXSXOc95psCZbYN9c4DSJ+iLUICWdYQxb/wcYsluFvww==
X-Received: by 2002:a05:6a20:e687:b0:1cc:e50a:47b3 with SMTP id adf61e73a8af0-1cf1d237d2fmr36803637.31.1725565785508;
        Thu, 05 Sep 2024 12:49:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71791e54585sm1248410b3a.182.2024.09.05.12.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:49:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCHv2 net-next 4/7] net: ag71xx: use ethtool_puts
Date: Thu,  5 Sep 2024 12:49:35 -0700
Message-ID: <20240905194938.8453-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905194938.8453-1-rosenp@gmail.com>
References: <20240905194938.8453-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows simplifying get_strings and avoids manual pointer manipulation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/atheros/ag71xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 74e01ce6161f..35db6912e845 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -509,8 +509,7 @@ static void ag71xx_ethtool_get_strings(struct net_device *netdev, u32 sset,
 	switch (sset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < ARRAY_SIZE(ag71xx_statistics); i++)
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       ag71xx_statistics[i].name, ETH_GSTRING_LEN);
+			ethtool_puts(&data, ag71xx_statistics[i].name);
 		break;
 	case ETH_SS_TEST:
 		net_selftest_get_strings(data);
-- 
2.46.0


