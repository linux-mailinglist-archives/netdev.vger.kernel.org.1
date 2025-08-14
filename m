Return-Path: <netdev+bounces-213804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 472ADB26C8A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360951C81D42
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90188288CBF;
	Thu, 14 Aug 2025 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAiQmYbD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F6266574;
	Thu, 14 Aug 2025 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189028; cv=none; b=eigLwzCDn+WiMvXmhaOujm0lZsvpAPvnwljj9tDtN5n1ApOE3m5u9VaNLScLAnhF6x2xsEGNfoCvRLQVDLzXxE8IKgtur38+Uw7++LMBfEgUc+p3icdA/+Tw9+y325KOXY5tCkvwKAWFpSRour7GwdKOqi5ShADBE83lQA2XyLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189028; c=relaxed/simple;
	bh=8eTEDvbS27yrss3ut74R9MdQYKV6UwvenQ7s+8Lw6ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDBnNfBrEzLROGegFrCXbmux+QxyrkD5KZr26OM516GDEk+PPRqmpJdJhal2EwiqjDeRTkSyHlSQmduDyq72drquz/3/THLoNDML9FfxxGL+WAC1LODLIvWpck82Re8GCowg1gcbZbrzvmTDpcJLHhdPm6zbTBsRqw2bw9ARyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAiQmYbD; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b471740e488so1125790a12.1;
        Thu, 14 Aug 2025 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755189026; x=1755793826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJUpVtdQJ13ix1MWZWj9H2jS6xpOO2nJmtE7Ac5hyE0=;
        b=cAiQmYbDf4MYnJqGg5XDEhNO08KwwGDix7UpLmcPuwc6Y0Ca6qEOf9qXPZ5cU0lCIY
         B8dV+ZaIuFw/gZr+Lz4GsCjgPB4kI0JTX76QfqpNYdsXmAzRBicFkFui0yO3l6LHunKA
         llZ0SIrUT4buE4K37SSpZRo6kHQAf8/7OQEiFJnLz8GCv8mw7mQKmhKg6G2RcKrHJ7yn
         22MJFJHDMyqXNr+EPqNfaKXrN+YaK/Sj9Zh4nGVMyC9IllEgIUkCWx/ehypKgp0AzQVk
         VMtF61Pl/Y3Subf7iXt2C2jZ8Lurcbm94Arx44O4bpXCnTSuq8kF6IZXlPJfgMjx05dh
         ZtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755189026; x=1755793826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJUpVtdQJ13ix1MWZWj9H2jS6xpOO2nJmtE7Ac5hyE0=;
        b=F0qDSbpHBJ0n1pXau7dw7RcLbJbIFJk47PZeoj7wtHFtYZE5GBaUyUX/YZ/SSjOsLY
         aNpos8+WZsD7cKEEsVu2GNVb0pQjlx7Snup+clm3y8Adu2qf9xQ2+nXq7d+1/BlvytNc
         2WBUP2PFfAWwxnthRyLQx7ZuQsGSb0/n6jtZO/RXWwMBqlddTyDKkDW7Jrj9BxX2UwFz
         3myDX0ipMcNbKkpWbitYq+COU/5MjdYBA4RX1khfzis3bHYAiaaHntGx/GSMQASX5aiR
         KWFAfjCWia9Ti0WiKQ6NgTGjUOBNe3N/lW3tAD3AGPk3mjAJrMKm5xS8jLJkcu/AgJ1N
         dqmg==
X-Forwarded-Encrypted: i=1; AJvYcCU0BX6Dfh8vJTzxfhhpSHnXNVvNwsZhQxeHOT8qskkWAyEEr/xWw7HHZB2zIBpHOYv1lySnXNnv@vger.kernel.org, AJvYcCXq56mAb5CWHXaMKqRg6aYLgznKoBwjR0pivVZmGUj3+n6YGQ6tKM/NbnaNEstbH2mfEQzA1N1t6c/KJbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxhKaVwoVxIyI9Kl5A04U61YX8oZCGj3Elb+v/h2hOEzqBOM4
	jIH27MTyoeYur512zunCtpZWgWVPwI8DR8ay5G/b+HMDxb/Z+66q1pWiwcilbw==
X-Gm-Gg: ASbGnculPiQdu5hHOxd0PgdGJOtEpYbC2WszIqVI9Mb+OJ1BmL2JZx5r08ogIje3nJa
	+rx7O3dLfk9Cy74czdtQLobPMG2svW36iPyN7CQFbED7xwiXYUvH9PHYyRptc2qTM5uoRZFqSu+
	FoGqrdTsm4/xDMcGYMucCJxPkC08oXNeeEsaAbywuCMnmRk/2biBcaz09KUWtRJyfer8qLTeoJX
	qlgEGJCFmQYnvi1CpJcoa87duskTA2tdZgIcuFl5H+w2AQC8QnrkyEciceVv1i4/KvBHHRBdJsK
	q0O1ah6nUtAawhIJhHtgBQ9wt9zP4dEUjkGIabEkwQVnpzI/tGBJyicyWEFgogoKooYdm7UnvSC
	TseQuybUooowfPk6NCNW+nQqEPv+8877ziFj7GppZ0jKKC34gTPO1SbclSOLtgNK56dgMYJ6bsk
	4gvB5gWgNTxg==
X-Google-Smtp-Source: AGHT+IFNM6MvQxFQMmvHfm8EWRclofWRxVkoIbeED3WGrsSMg5Q4XsYpxHjt33kdE4mVFnfSiZXBUg==
X-Received: by 2002:a17:902:ea0e:b0:240:3ed3:13e7 with SMTP id d9443c01a7336-244586daab4mr58933455ad.42.1755189026182;
        Thu, 14 Aug 2025 09:30:26 -0700 (PDT)
Received: from chandra-mohan-sundar.aristanetworks.com ([2401:4900:1cb8:7b85:37eb:c20:7321:181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899adc3sm356194365ad.118.2025.08.14.09.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:30:25 -0700 (PDT)
From: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
To: jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chandra Mohan Sundar <chandramohan.explore@gmail.com>,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH net] net: libwx: Fix the size in RSS hash key population
Date: Thu, 14 Aug 2025 22:00:10 +0530
Message-ID: <20250814163014.613004-1-chandramohan.explore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While trying to fill a random RSS key, the size of the pointer
is being used rather than the actual size of the RSS key.

Fix by passing an appropriate value of the RSS key.
This issue was reported by static coverity analyser.

Fixes: eb4898fde1de8 ("net: libwx: add wangxun vf common api")
Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
index 5d48df7a849f..3023ea2732ef 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
@@ -192,7 +192,7 @@ void wx_setup_vfmrqc_vf(struct wx *wx)
 	u8 i, j;
 
 	/* Fill out hash function seeds */
-	netdev_rss_key_fill(wx->rss_key, sizeof(wx->rss_key));
+	netdev_rss_key_fill(wx->rss_key, WX_RSS_KEY_SIZE);
 	for (i = 0; i < WX_RSS_KEY_SIZE / 4; i++)
 		wr32(wx, WX_VXRSSRK(i), wx->rss_key[i]);
 
-- 
2.43.0


