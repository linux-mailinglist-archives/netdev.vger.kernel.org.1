Return-Path: <netdev+bounces-131455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7E898E85B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1C11C2158A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927541474C9;
	Thu,  3 Oct 2024 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGm2TaIT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19400145A18;
	Thu,  3 Oct 2024 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921522; cv=none; b=W5XONKUtxjwbNClJri2Y4QvVEJPw1kDEd/aU1GKq01qQ1DkAr6Cfb7fkM3HQjj0WOzlAwq1+3p7SNwp56DwbOawWSEaJzF6KF2JHDvWISBTlF5Xo6p/SR28kLfucFqlade7e6enVLAPrGHEarf9QZjKv5YyJWrEwbPQ2jtri5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921522; c=relaxed/simple;
	bh=3znYEdrKrSJmBz47ry+O584EposhcMqI2RWTfyP9gqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnmThmLCnE7RQnJ1852xvpAbJRaxFCA+g3KZ7vu0jJFW93wgskhQg/Bt8BEkwBXgyb7wq6K80rV8d5QK9e3auPO+CJiRjfypAw3xg1QEpw9RktYoOfXy7r8/XoaU6MCElPWgk9tG3juWsFLoNuM2cEtBDs+vPIw0apqAiN/3vgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGm2TaIT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7163489149eso327017a12.1;
        Wed, 02 Oct 2024 19:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921520; x=1728526320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4i5ri64hrjVdmz3tZTzX5i7c0GV7hJBF3q4OdGMq8f8=;
        b=SGm2TaITPpLZwBFlRXoQ43Pt28uv1t3xKp/KT7oxqb0v+na8oVLGQo2OguCS0mw5mf
         U78OrdFNpzVaDdHlDLwc8a/yQwmXy6R67ITUNsL1EkQBHoRmSXlkmMAyomPHcMSbqRhW
         amKfO6QiQq+em64msEHGthAta8U5jwsqs3szr5zxo3/Cdl867F9kZ0/MynQpL6V9bVHi
         j7N59AtmA9pbPULYgS/l+TZcdCTdDy5fAjXt92tOflTT9SB9NwYgtgCHNKi8Hspa2dTD
         7nE0fFdy9N5qYfEUg2mPloFEw16fVKBp18Ab1X/HT/DE+WOj0hfakr071gFncv2wdEFz
         vRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921520; x=1728526320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4i5ri64hrjVdmz3tZTzX5i7c0GV7hJBF3q4OdGMq8f8=;
        b=PQLzPLyo8zqgUHb2QpgjYxy/65BGMRSwIh9Oy1nE9YHmsjDAQuPd4XTz7oE2i/5c8k
         fWf6zb3yP0MFKFtE/kuSP6f9WKuMnlqh/SRJRhdfKzAV3PgypJAxfsknHUtBnqQSr439
         wJ//Bbgo476FighH4yF2XJTXuDDtZiH6dunleR182t/yhgDrWoZnJ7xrFxXiWH51Nzxj
         gPK+sSEeOdkDEYVE/dJs7iXkrXpYGKZcVYT5zAztrTqe+NSf0fckKdRRpsY+DDTL6wRW
         X0+Wp0BFVPrj5+jk4gXR9sU7/Q5a5QE1yqpht7s8t+gtKWrwCCIAWESSv7KkZXQLZKv6
         XQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU64PdY5NcyDbcZg0fr2QHL7ZEumKqL1YyvRXVnbOgxUdbPpnxk1sFpttINFdxhXptpIVMSr9o5QDuAlqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxED5DkJfoFVVeX9XoEMQ295gCM/se5Ihrz260IyY7tbv+9mqjI
	PGPhQFu4j5KgXKrf+8IV/KXIXviSM9nv/xsj0EtDAfF5sAgil4GrSe9ZbKrx
X-Google-Smtp-Source: AGHT+IHfpAnENXQM46P+rxthkomryN99+QR314Lmc2ufSPiJYmyYRHuP+j+x7J4ZyF33Ol2+x3d3dQ==
X-Received: by 2002:a05:6a20:6a9d:b0:1d6:d2c7:ac59 with SMTP id adf61e73a8af0-1d6d2c7ad1dmr2310958637.12.1727921520312;
        Wed, 02 Oct 2024 19:12:00 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:12:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next v3 16/17] net: ibm: emac: mal: add dcr_unmap to _remove
Date: Wed,  2 Oct 2024 19:11:34 -0700
Message-ID: <20241003021135.1952928-17-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's done in probe so it should be done here.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 3fae1f0ec020..4f58a38f4b32 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -714,6 +714,8 @@ static void mal_remove(struct platform_device *ofdev)
 
 	free_netdev(mal->dummy_dev);
 
+	dcr_unmap(mal->dcr_host, 0x100);
+
 	dma_free_coherent(&ofdev->dev,
 			  sizeof(struct mal_descriptor) *
 				  (NUM_TX_BUFF * mal->num_tx_chans +
-- 
2.46.2


