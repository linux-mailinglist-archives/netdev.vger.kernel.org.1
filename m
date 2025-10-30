Return-Path: <netdev+bounces-234274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B463FC1E6ED
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 06:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFBE1894990
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 05:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F44A21B9C1;
	Thu, 30 Oct 2025 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB2M4pOf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C297D37A3D6
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761802472; cv=none; b=UYfa0KtCwKjFXmkRbp3RAtBkj42yZfMMkgeNy9ATuEAWZc10eIHvvCgfjY+UgQab6d9SgpHAO3oJxuHlfGV/b+uP5brZTaK5YW4gt0WLYKaTOH9lEXeNd4MOyiZwlqB8qJ15ofiZhJkx87/Xai0lQ5UeqLE7jlJNde4+yYX58E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761802472; c=relaxed/simple;
	bh=NTNQiMekt27MGuwOcDMw9rk0PNy2ygsDrUNNQVYYVdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AgmmjuLHoSMnPb+xClSQUKJZL6143JS6fNsVNnaE/Z1UVUoKG0Gjwl+uR55slrS/QrfW5rQ9V+YSrx1EtZRbsPVapT14GJHSnQAk2vIRgEabyE2DAaTZOlK2xGa/pUYbw81i6F5aikrs4KCwlOnK7FTKdbkEWmaL9hhn6DUHrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cB2M4pOf; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso1278562a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 22:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761802470; x=1762407270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bXDn90536GRiT2FSB8MvXk81JvmC27CutOSkqb6Hxc=;
        b=cB2M4pOfpgSXw6gXxmxL8SWTnluwBSBVaRO4WAKwO6ykQsiDxAvTVNPap0hL6MskL2
         x2rxHKCbNwCjhDxlEu2TuEVBlcTfV4RMkHGprnOkJchlnSfojeb5Natx1corT1M/LlJn
         2YI5YhL0QgunaQEkhJbYah0fEMKgYpT8mwrp6WtN1qSgvdc62Vkyo2P0Gw9NrI/dBjKJ
         uQo77PbBm7bxVOiR6UvkKiJuchf4zbVj5Yr7w8FDkyS/+oFI7cpO/ngMqJH+4yIfTwSZ
         Tr0h/3rd7OEq93SQ8fko2b+6DDc6aiMSSAXeiYYZ/sYprBVuR7DU7uzeAodFkNyopPtA
         Lg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761802470; x=1762407270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bXDn90536GRiT2FSB8MvXk81JvmC27CutOSkqb6Hxc=;
        b=LdJ2ytY3hyOj8m0/wetVBCjDrvTa+ZHoHvesbyZnEPi6rYD4ZclpT4tjf5rBipaW8x
         s/NWe6xnlulHg7MV8nclrSaEzBm4+d7V3Lq+MlxUTK8YieRBRHkaXodHf612bLykcidb
         uukAdiNlKSdIZyiedpThQ07u9l2rStm8WDRzhEX0ZxCfC0pL0JlQTVHb+TzNEotQoB6H
         n5hicw1S5s76DRzv3GiEexpX3WrfLF9oMm/G3FmbHLlXZHvs+5Ywt0yaOABAcoYOqgil
         zeycGmIfYiaQqGiY8A/ScvWUFDh78GFWkQbEHW9JK0b+DIGrxgmZgMWxBOl1AlWbTdZO
         614g==
X-Forwarded-Encrypted: i=1; AJvYcCVAySc2T5NLNoerxABXnnOh+y3yb3PAYfVqR6LREjT2ZJOM+ElipPSc4eRS8VzAqRLIXd//bcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBhtit2weH2ZBpr7WiH3N78VQAw0+5r8FxxF1CeUhX+gC6Mfqs
	ywCesb2aL8yQnqWnAepk1RjPTOkSj6rtMXP9Vf4YgpLUxQu7wDha10b+
X-Gm-Gg: ASbGncu4UUwLkyFY1/qAkUsPhX69slmolNgeqLTjgjFkrtZPtgw6f56TFXow3D2Ydkx
	yTFpB5ggfHNMxV36Sw2rIepqUyULR8oZ4ouWd0OEjUj1dpMuPzYIVXZIwP0HojdtBWC0ru+qWAo
	DSo56Xd54JMIBpE4dJXMuW1xYIc+yAxvLa9JgrSSTVJRHdSmSb1jN0RKuZMgSE1Oaw7SMq5vLIh
	njk5iVRIrXfyHry5WyOnzaNqRWIQtv0Ri1PF1sJNDzf3A9Am6A4h+Vv7piOw9J5OuUqhXzf77Dh
	rhkZN5ap9Whsi7XwiI12AqIrQ+gfZRD/k4nKpH4YqSvDTpqtM5AxjZNOiAkh7+RRVVSyqwUHsK3
	BoEz5qdxPeeDU2naGF0lX0WB96UFXzk+Z7JLIMr/I4mQc1dbjb6X0VgNQuJQI9OiFkYsWoE/nci
	SO5XtooSt3eQzAPKDLbGpoow==
X-Google-Smtp-Source: AGHT+IHQSoEeyg7TPbHVX/naAJ4cljI3iJJFCjsar0UsVAbSVgztH3Vp8TrcvbDMPwYpGQRddkd2rQ==
X-Received: by 2002:a17:903:190d:b0:267:8049:7c87 with SMTP id d9443c01a7336-294ed08da86mr25707525ad.14.1761802470013;
        Wed, 29 Oct 2025 22:34:30 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d40a73sm174659995ad.74.2025.10.29.22.34.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 22:34:29 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] bna: prevent bad user input in bnad_debugfs_write_regrd()
Date: Thu, 30 Oct 2025 13:34:10 +0800
Message-Id: <20251030053411.710-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A malicious user could pass an arbitrarily bad value
to memdup_user_nul(), potentially causing kernel crash.

This follows the same pattern as commit ee76746387f6
("netdevsim: prevent bad user input in nsim_dev_health_break_write()")
and commit 7ef4c19d245f
("smackfs: restrict bytes count in smackfs write functions")

Found via static analysis and code review.

Fixes: d0e6a8064c42 ("bna: use memdup_user to copy userspace buffers")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 8f0972e6737c..ad33ab1d266d 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -311,6 +311,9 @@ bnad_debugfs_write_regrd(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
+	if (nbytes == 0 || nbytes > PAGE_SIZE)
+		return -EINVAL;
+
 	/* Copy the user space buf */
 	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
-- 
2.39.5 (Apple Git-154)


