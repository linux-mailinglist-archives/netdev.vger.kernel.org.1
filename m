Return-Path: <netdev+bounces-218478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F86B3C938
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 10:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29A5A260B5
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B87427C854;
	Sat, 30 Aug 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buHY4L8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01599286408;
	Sat, 30 Aug 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756541501; cv=none; b=q13PO9KWr/WBkyQofQCS7CkgedLI7pMx3RBYSHDIIvMuLifJl3wtmO7huAdvxwAI9DoKSYAWfuGLUAjJrywDtIHqvyQMz9+rSHtP0Hhp+9Gxy/E6k7gsAMQpF7UoCRFDbDDTGpZyiww1VZ4Ma4G+ZwyX0nGKwPIRTL6Dg2az8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756541501; c=relaxed/simple;
	bh=J+rY2UboZD7E6wDodZ1SRiN73S814aOqGEfpl4u3V5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dFHk2OkQCEC4dh1aKsJY/df4jYkRpJemrnWcxACeRwEiVohLr9/Tvsy5znRDFjE2kEN1uZVfD/bHbAnCDOYy/NckETZb3cgItkXt0z/b1wkTCU/+W4vnpOYCqEKVTqirxuuFRgaJL3Lo7smfF11HqjMRcZpXra9EBGAYNbMOa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buHY4L8/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-771e15ce64eso2453602b3a.0;
        Sat, 30 Aug 2025 01:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756541499; x=1757146299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oT5A1s8d/9uFDdMEkAgLQygc76cfTIR6QTfaUTMow7U=;
        b=buHY4L8/xEYNWWRGFEKBFlzWACzB7w/W31s1nZ0DRScuUGCfbBIE9mZL196RPTw8Lb
         8NNU4B1JFKpRRObhTQCBs8G6S/Eet4ZfBek1NeQtnTvd4s22JzMICQ0ZBiVi/wsjkdcL
         kuHgaCwC9HlHX/Cied4U8zPKo9lkDk2Fjz6Kpy6j8CNV+mMBJ9zfHjkwE+IdLHCCYVDU
         Lq+86zBTLbm3FnzyYKhIg7EhhNX+nq8UtYDFAwKRz/IzAyQpCwfbzjB9cqA2Z27O34rn
         MVK4qVaNiSJ+9CiemzJBjo2GJ10XJ4sENz++9kq+cDZchDdC+dexJiIHneCnQAuVySOV
         D4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756541499; x=1757146299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oT5A1s8d/9uFDdMEkAgLQygc76cfTIR6QTfaUTMow7U=;
        b=Eb/TPy9Ch+XfgLPTrmOzod+Xlt1tcPl0FuhTRq7RIShTCgXVy6PV2Ebsm1xSpcHYqi
         tga3tbMJQx5Pj4T9HW6cLXrP/r0gXyvvoUCVimqUDYWc2PjTzUlDsxWOYdjiTSXJ4+R3
         /RfEr/O6NZnV/vgBeq3VHIZ7EXp2yA1o0sYYzbztXihb38+lDr4Z9kx9fChmXypQH+Jl
         pPEsvBjeTVcibhXaUke/vLyve+PGMWsZjZqsL2UVzrXwyX0sQbbHsj1K02Id/yEtnHFd
         3g90ceC3UA2zKgQAn1GHoZAXdGvRFPpAQ4kG9RDL4VzF0S388XpSzSyDDhXvFomV4PbR
         YWyw==
X-Forwarded-Encrypted: i=1; AJvYcCVeOHdfAxEHD0wroHoqkPMxbabH1y0cfmjrzSS3Ti6B1qRl1DoG8oR2UCzM92c29SzNB1JZsC7m@vger.kernel.org, AJvYcCVvqchf+TvZHxZtYQPAPO1IfT4U3NP7LBKjGQwzZ1S6rorhs/U/S2nd2noWcGNtxN94zrvvdCapSqB16qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaH5ZkUVX18UBFSpEekWPPn2/ygAuBmLlsouOGIWw0VKqY/z5S
	qyaJod8SuK2PYZj2gHMEt2yFRBRdKUDgpfIgsNt/i/bjuc3Vuy/2O6vY
X-Gm-Gg: ASbGnctbxEWiBguj1Ozc4bXsxABCMM5JmnQ33g3p4P4vOc+KGDeUqL9DsMpsRCfhHXY
	Knlq/QGDThM7IG3BT7q+Z0hNAOEI5cBfk9pHq5jTufJfQUrFVq/psY8LjDi7kipcuH07wx9gw5w
	aD9Rptzrl2+kBIclC5DNZkmwRsKObxUbuyPEg9ElI9S/YZ0GQK4fkG2I7C0rpZKQ35bxbFymv/9
	613yre88QP8OHQzkcBTxHHgIyAIXJLgK2NMCCDoWVPIRIOK2w+KBhAgypD1laFsAKNHyUGvKbJF
	4VmKedHeR+CyrmIIM+9bmW6TviIJd7w3sgms/3CGisYk1KIrGESBL4WaydRTkKiJLsm+2xrOKGc
	6o+iwzpPULCU/jL+Tkw8p3841Yef5ggKiPQYh2L5+tHFvn5l79j/oU5J/IMjVwS2boo6nY43yia
	sIwD94Y8kMQV4=
X-Google-Smtp-Source: AGHT+IFB4uDxoXq45bKbL5csJQVtej0QBcMYJl7vXPhSGsuz/P+i0x/v5qnk/mzfPcbHDS/kI8QFJQ==
X-Received: by 2002:a05:6a00:cc4:b0:771:ec91:4b92 with SMTP id d2e1a72fcca58-7723e369d6amr2304013b3a.18.1756541499113;
        Sat, 30 Aug 2025 01:11:39 -0700 (PDT)
Received: from localhost.localdomain ([112.97.61.188])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7722a2b7d10sm4564100b3a.33.2025.08.30.01.11.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 30 Aug 2025 01:11:38 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] mlxsw: core_env: Fix stack info leak in mlxsw_env_linecard_modules_power_mode_apply
Date: Sat, 30 Aug 2025 16:11:22 +0800
Message-Id: <20250830081123.31033-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extack was declared on the stack without initialization.
If mlxsw_env_set_module_power_mode_apply() fails to set extack,
accessing extack._msg could leak information.

Fixes: 06a0fc43bb10 ("mlxsw: core_env: Add interfaces for line card initialization and de-initialization")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_env.c b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
index 294e758f1067..38941c1c35d3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_env.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_env.c
@@ -1332,7 +1332,7 @@ mlxsw_env_linecard_modules_power_mode_apply(struct mlxsw_core *mlxsw_core,
 	for (i = 0; i < env->line_cards[slot_index]->module_count; i++) {
 		enum ethtool_module_power_mode_policy policy;
 		struct mlxsw_env_module_info *module_info;
-		struct netlink_ext_ack extack;
+		struct netlink_ext_ack extack = {};
 		int err;
 
 		module_info = &env->line_cards[slot_index]->module_info[i];
-- 
2.39.5 (Apple Git-154)


