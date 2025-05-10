Return-Path: <netdev+bounces-189450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FFEAB22F2
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 11:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AA7A01346
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953101EA7FF;
	Sat, 10 May 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe0H9tiR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3331A8F6D
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746869691; cv=none; b=YOePXP7JOJSbCLXQoWTdKI+jrzfTsucmmXO0anSyCJDnbUiCLt9bRy77YkTvg8/bd6+tqaZB7jU+WkT5Va1xXm2NuoWeZGi5DdkiQaiZCtLLQo3xy5tlB2NvXgJNuzosQLYhIfw8w9ZkV2XB/CJlhQ5Qk2GDGJkOBNpbe/AoOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746869691; c=relaxed/simple;
	bh=f2suzP4zeF4MA4yl2JF9aR+wb/Fr32kG2i0KddKirV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TTLa2lLZ5b/09A6Y7uT1qnpzPtYrLryL5xTQO7tR8Ggrc2bQxpP5t9D10tS4HjzHMNAQxMU8KHNqF742c+UYDjiQDLngbqpajKEk4+SKy1AJYWgFHBvOGfEjzu3o06QllQvKJlT6JgHSC2BRvpkRvxK7xlWCjfKTDxzCBbge53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe0H9tiR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so2513239a12.3
        for <netdev@vger.kernel.org>; Sat, 10 May 2025 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746869689; x=1747474489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Be+2bPvEJorGJE8qbCFSXxwdGEZHSh74U5bGp1GxslQ=;
        b=Pe0H9tiRtdLabuWCQSx3KJBxCgNBrkYY0ZEeAyJxR8xXaWNWYVPmoQ7XYDgOCLF8Ln
         l/9/zQFH3xKgS8xMqazEeKMQG6I/gQHO0V77bykPD4R+X8WD4Tkdk7VM66SqEm/e0cDn
         aSIfjEViRAnZc7smfYJ0zPPwzXSjvFfXPK+oEtdTQJXGlnQvoWCDR25RDCF2/kLNlih1
         5tfPL/ZGkePCM9v6ch4eppwJtHDH+lHiJ/pFJyAlbknFC2q/77YEsqyVai+2Jm08OJlk
         gUjf/FhcpsLktBocX5rD7AJJ7qBh20BmPjQhYWRhKZdQOgigikql0XwqTvMVdD8rxb9V
         ly1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746869689; x=1747474489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Be+2bPvEJorGJE8qbCFSXxwdGEZHSh74U5bGp1GxslQ=;
        b=JPPlnoQczVcnKrG6Y+q668thG6HgunBA/SYyeEb9nzcnvCMDE6yM71t3G36l5RR8LG
         qV9U0L+kgwQ4d9uRWS9YKkNFZC7wLom7PK4Vbp36/fSyEBQOJQ2YsI0Ge7oIPksQzQNI
         SeieTF1X/5SDqtB9WWpS5GQUqS/DPhpCc52gEA4m7nr+BXwIttcU+bVHQDMFtChwXT+2
         pBTpPJgvXEojelm3n3n3JIILKrC56nPQgPxb23IAJ7/gI1wx7fGvlZ4Z1psD4KfvvaG7
         KeK39pfnkc3Qk2gJavHJq6n9APUpYzIjr/eTk+tzbdd9Ge//rbQNFWLcV+qELURjG45U
         P24w==
X-Gm-Message-State: AOJu0YzaJgNCfMiSx9Tjd/P4N3c1zPJlBQQd2qXceMTGWWXJl3H758T3
	Wwy/j+tWkJNmW3d9yur3/o7Cmn8d0ApWOr6am4pGJHgAvbQ1SMzIXx3cvk6qiac=
X-Gm-Gg: ASbGncuYamRfyx/EjJTXWNNM7xy9sARvb5PMXIsE8MO/A9Vwqffd9HyGBHEOr4T4ovK
	wzZ2Sbi+1znG/6duAodaOyDVjyqo+6E5FwnwyDt8Pn2/Rb+HxLp7h5+oMuydikDNLXqgft6hJjr
	GTd2iYfWLAeuq3RhXTj+D9axBqVVNcqs5qCfKNy/ZEbDiUZk7LzuUU7yFHZVLubjeJMOg53SjV8
	gukzTsakC/LWYbhrS05wpwN0XwxCkBp572OuDbsCYOVf9SJIucQ1e7BELthqhUJp5RzpjEG6NXG
	PTIriOdYqgLMaGccv+5qlizXfhMcoyTQ1YsxOWhxtXXAgr5Kz6EFi5gUG0urTnggXXY94O6P+u6
	aPnQv4dgUqkrWvw==
X-Google-Smtp-Source: AGHT+IEs1ubhCSSsakIFUSE8CmG4xhyw57KNJQUoMLMTX0nteHSoI2LQLeYq4aoFF73Y5koq5kkNCg==
X-Received: by 2002:a17:902:d545:b0:21f:507b:9ad7 with SMTP id d9443c01a7336-22fc8b703acmr100906045ad.25.1746869689223;
        Sat, 10 May 2025 02:34:49 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7742264sm30273635ad.68.2025.05.10.02.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 02:34:48 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] net: mlx4: add SOF_TIMESTAMPING_TX_SOFTWARE flag when getting ts info
Date: Sat, 10 May 2025 17:34:42 +0800
Message-Id: <20250510093442.79711-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

As mlx4 has implemented skb_tx_timestamp() in mlx4_en_xmit(), the
SOFTWARE flag is surely needed when users are trying to get timestamp
information.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index cd17a3f4faf8..a68cd3f0304c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1897,6 +1897,7 @@ static int mlx4_en_get_ts_info(struct net_device *dev,
 	if (mdev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_TS) {
 		info->so_timestamping |=
 			SOF_TIMESTAMPING_TX_HARDWARE |
+			SOF_TIMESTAMPING_TX_SOFTWARE |
 			SOF_TIMESTAMPING_RX_HARDWARE |
 			SOF_TIMESTAMPING_RAW_HARDWARE;
 
-- 
2.43.5


