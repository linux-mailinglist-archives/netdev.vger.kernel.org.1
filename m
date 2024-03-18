Return-Path: <netdev+bounces-80323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF2387E58A
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC121F21B87
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E256528E0B;
	Mon, 18 Mar 2024 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cBItaKYR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092392C19B
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753556; cv=none; b=ESXtZ3CpMT2J6RhTQ9IVSsf+qfu/EwECtSacYJcVYHkF7KnbdLJHhMxbit1Twysl1zhnsl/mcVLiRThE8JF9iMmSJiOPaDrBPSvNiDMEgiPfpKY3y6LCFaPAlSvjFe/WU21Qrz2wgmkKQ7B8BFNFVDsblH1xlS0rxIl3Ll28k80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753556; c=relaxed/simple;
	bh=CUvTTXLxdeuTP3dHzkakgMvvcCcYlWeJGpB4uBgq9e4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9Had5qCJObJXlRk9iC8FYIB57vHyT+htqryhdtD7/PGiUCDkIF583aVOPj2jxJyD3AcEh2MKrnYrE8nDLc1iQOaZ3gc67o1o76fLNmOpCJg7TcTcChFkZmMQd7nIaoRczB5VT+vUftMuSJCcmUWeMkFtNUD76AGYsSQy0iTtVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cBItaKYR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4140eb3aeb9so6365085e9.3
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 02:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710753552; x=1711358352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQm+b32koq7bGT8qRFji5Egvm6B7h1vGwYxI1dLBKwI=;
        b=cBItaKYRMoNjBZE8hYXGNCp7+bHDaZMt45BY5RQAEmeTicn/cQu1GAkHAF8XWSRWeC
         YaGDT7EusFWocs3hWbLJvLURcxfTdbOcGtWJRZJRXfzigqN0P8KU6Y+d3F+NzLavdGZ7
         0HxZJT6Gof7QbhUitKSyeJAO2TS1bgKsiWbvNefeKs92T4KYLXtmyQjfKFAS6caMDmvz
         604yqh4YKc8jHo5ZafNy2x9pONYwMmT9pv9gBbEuW6YZs3+n0qMVQTO2u1f4ZRkS5s/O
         ki7AA3B421/eif7HXfwO/9bG5uM48K3VDp8MZHR3zhauQrN80wYZurGe9uP8e74ZkfN/
         o65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753552; x=1711358352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQm+b32koq7bGT8qRFji5Egvm6B7h1vGwYxI1dLBKwI=;
        b=Mt1X5Pl2LzDZJKJSVRHhp7TXpArzVbJXNXiHTtajAaX/HklKK6LL9T69wkEoh4dauw
         0ERd3jTC7vE8/9/E8ffAMHoDZlfFH5kZI3LLOxYVfVJVI/bTbbUTJm8x4lMl4YC6ftRd
         qNyvgBjNktK+a6KjUEbbtGpaTh5vBMPmv81XUXPSiNh/dxaFUvrqxoPf+qpNMGn7XQVF
         F2id/8DgbA726Zl2HuoXBQmePY4Fa4bN9yJWe8iR+ZEBPFjbsO7d30oOGF6FrdHRwrej
         A5dAJ8T0lDmfzkMDlULPUS3smWRWES81a5s9iN2kt9Mo5eQfMQeAgZXfBM2ObEpOWhAg
         yq8g==
X-Gm-Message-State: AOJu0YwXRH/nWNgixmlGbBJJtw7Sp2BbCv6Dnv3R630WBQlC2Ug+J646
	HOLyOUtvOF+8FSvv6U9i9U9RCn6vsVv4THoNN+4Oat80rYAJsH2y7B+YilTX+yyhb9PdObFl4Sp
	Q
X-Google-Smtp-Source: AGHT+IEb+uZIUlGiHXiWEvOpKknoxoftm3sZ77vrFxaR7JVX2vqdplssZYRBoISNOXzFEH09s9KThQ==
X-Received: by 2002:a05:600c:358f:b0:414:dae:218f with SMTP id p15-20020a05600c358f00b004140dae218fmr1992247wmq.35.1710753551984;
        Mon, 18 Mar 2024 02:19:11 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b00413294ddb72sm14121807wmo.20.2024.03.18.02.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:19:11 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	parav@nvidia.com
Subject: [patch net] devlink: fix port new reply cmd type
Date: Mon, 18 Mar 2024 10:19:08 +0100
Message-ID: <20240318091908.2736542-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Due to a c&p error, port new reply fills-up cmd with wrong value,
any other existing port command replies and notifications.

Fix it by filling cmd with value DEVLINK_CMD_PORT_NEW.

Skimmed through devlink userspace implementations, none of them cares
about this cmd value.

Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
Closes: https://lore.kernel.org/all/ZfZcDxGV3tSy4qsV@cy-server/
Fixes: cd76dcd68d96 ("devlink: Support add and delete devlink port")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/port.c b/net/devlink/port.c
index 4b2d46ccfe48..118d130d2afd 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -889,7 +889,7 @@ int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOMEM;
 		goto err_out_port_del;
 	}
-	err = devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_NEW,
+	err = devlink_nl_port_fill(msg, devlink_port, DEVLINK_CMD_PORT_NEW,
 				   info->snd_portid, info->snd_seq, 0, NULL);
 	if (WARN_ON_ONCE(err))
 		goto err_out_msg_free;
-- 
2.44.0


