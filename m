Return-Path: <netdev+bounces-173379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40C3A588B3
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 22:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21B7188CDAC
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E051220693;
	Sun,  9 Mar 2025 21:58:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443C21A955;
	Sun,  9 Mar 2025 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557537; cv=none; b=EUnBSfP9w5vLwJL7O1sDlC5Hlm3DvTyvb/PkwWSK8OS44mTjWSat6trvQ/MIqs7URjf/KgL3cbPUolk9c1aek9DXb5ZXt6OjbmBZ+U/WowaymvUTDJvfOzejKi2apixHLmxM+pjMZPIzSOMMzAwobcLbv8yUqxFbRNKenGnO+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557537; c=relaxed/simple;
	bh=FB2tc7eprG9cXnHm7ci4NPgcqb3ckMxXxdXnHPWNjbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dr4t+eUkqmURTthzj3IUpjpPpkZ+5axDmEcL4AkGOeq7RHImVb0UWQpAgT4/yrXUWtJ48SWzEoMkIXsQfvRbn4xlC8tocdAIvMb2EdjUNy6OzLjeqtnh/fMydKC+xJJdtBdhzkKk43Pxb5ImARGqY5vrX01DX/OobkbEJBBXGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22409077c06so42851925ad.1;
        Sun, 09 Mar 2025 14:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557535; x=1742162335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbv9Bl0VqWVgQml5NKHkLpTxIj0O8bXBcl60c7VvrUM=;
        b=DJ25fyslVwHzVcJ1Bo8Qrwtm+k9Jqh4/KcX9q/5xcOVtSLii/Iepail5mWkAmXmrS7
         qfVD5aRg34zSldISVOxmHJ7Ey3qEN3LTj6CaR8gbK/7uFjL3CVvdarpxPRccOInIEESc
         6iQNDzOOKj43+sqpA93Xyko9eArNXjDgS1YgJw7N4u93frpReL3IxlvGK4x9f4t7/4xu
         4+XWJd283FATOwoQpIFmQgaXZJ69LneiXolOoKZRFzS3YHn0lZi4q4PA2IiHuahlUFdm
         13pvOIux+ewWvKUf7Ue5Sp9v2ddGs/xG2e6A663Tw1kA6XxJc4097mLZgwXBtQLURf7m
         kIBA==
X-Forwarded-Encrypted: i=1; AJvYcCVMpGrdSmYnxDwiT2Ty3VJ0hjP1gproRvejkg5phptMWhF6ymSP6u0DzBcKEgYmHgbH0eh013SqSPQPINE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWagfPSoY6RGcJJ8hvDTsiEA+29g0AzenKZnafHVJ7as0jzfvJ
	0wwYxe9fAVJhj/q5nX5HA1WjXJGprHKiRRqMD/cXUiwG8Uacj8SqIbDX+F0Idg==
X-Gm-Gg: ASbGncsjhO13EHEUoFrGiz7PLu8+lp6tdslMLtixpOiBdpcpuohxeeffAnA5kQRsbWS
	5tb6a8uMOX2RzOjkcxwoCynDK8U4FcS8hvr9Tn+AVzKLFM17uh1xIuT+0DW3Nf4wGlLJJQYYBpg
	6J+CBazTFQ8Nz2FRyHcSdAbS8icZ7Xvvdl74SnWAB7xjgx4MoL1W0bYul+yQbwQ7+pkrcNUU5WD
	jLx8ibbNXGbgHfRnkLYptnqy0noqrNgUt/3sxIS98bR3nnLoR8t0wm+Dd3UpAmo033r3ptl9lSI
	6KAljoODAf8XzQyjpPCn1iZ8TWFn58On9LI7yRRmJv18
X-Google-Smtp-Source: AGHT+IG/cjY58elYbDg3E7VLxAregQ1BJKUg/e5vrmn+atfQ1VocqDcDvWX1vARl7k93qpOfKL6ibw==
X-Received: by 2002:a17:902:cf07:b0:223:58ea:6fdf with SMTP id d9443c01a7336-22428a8d325mr228758945ad.28.1741557534913;
        Sun, 09 Mar 2025 14:58:54 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109e98adsm64527145ad.90.2025.03.09.14.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 14:58:54 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me
Subject: [PATCH net-next v2 2/3] eth: bnxt: request unconditional ops lock
Date: Sun,  9 Mar 2025 14:58:50 -0700
Message-ID: <20250309215851.2003708-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309215851.2003708-1-sdf@fomichev.me>
References: <20250309215851.2003708-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_lock_ops conditionally grabs instance lock when queue_mgmt_ops
is defined. However queue_mgmt_ops support is signaled via FW
so we can sometimes boot without queue_mgmt_ops being set.
This will result in bnxt running without instance lock which
the driver now heavily depends on. Set request_ops_lock to true
unconditionally to always request netdev instance lock.

Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 66dfaf7e3776..08ac01d6a509 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16613,6 +16613,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
+	dev->request_ops_lock = true;
 
 	rc = register_netdev(dev);
 	if (rc)
-- 
2.48.1


