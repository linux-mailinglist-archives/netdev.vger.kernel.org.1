Return-Path: <netdev+bounces-82831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD4F88FE1B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E21D1F256B5
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2457E567;
	Thu, 28 Mar 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjrPU0Nd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A427CF1F
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625575; cv=none; b=WWJn1jhyLlDDffuMkf7FKiQQYNRoKsW5qIwh/VG4/pqrTHK7A4SNSpYmxJWDfbKc5+2X9ygISvFBxpQuelswRrC7znjVcsMS0Y7mIOmmGOKNbCs3XHbokagDdQJPEMb7+FpHpK9K0HlfjkzfhJ3TLKQHpIKsGQE1wrsyy+llSVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625575; c=relaxed/simple;
	bh=Oex/7nEBLObO1+DbNjY3FmS9g/j3FZGyPn+xvvmaLfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OzUK0xlCFl1k2n16lUahLPOfpHIhms43ZR9iFCsCZ/TtL8XpxABuXvd5DnzI6CUW3+amjbGFmMeXC8LXCCfbaYDI/Zqmy638S2RDkYJGsK+EMDXfGoieZVstB6x77DTQq+LEVC6wjoR6dSKeeAxTW4kBqG4r7DWFUbJVKh8rP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjrPU0Nd; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5159e6d31a3so234343e87.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711625571; x=1712230371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/PbkV5itK67FFQjkSzKcj/C0TGmUzscGNYJRydZqpc=;
        b=gjrPU0NdzgyjsAqr5OQGk+m7fzML90w0mPty5av/Qg5JgepbfPzwPe1A33p+1EdkUF
         zIIlpPp8XkDBIH+lIc+YiN4LaccofygFPyEZVT9PeSorrEOg6dA2Jc20/1KHjoKHFTL3
         nFKn1YelRuTKpkDPF/HnKPXvkrDRlvNHSAiDT45Fg9OAlTIrk7Gw+fl4cAEcbvGfVtk7
         /4T17Uf2YJeszIq2ISnO+09flaTea9ks9dzzQLf0xfHj7Sh7vmSToG9eXWVJZuj8yHC5
         EjzmdrJlZqKZB41yv6C6O9dQFexKiLGKZ1BHDzruPkyY0oEP3JFjvNpy0Z26qDl26duR
         xl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711625571; x=1712230371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/PbkV5itK67FFQjkSzKcj/C0TGmUzscGNYJRydZqpc=;
        b=ACCabt5fYP0lZ1gwsmYPWyfD/VjCF+/Gov8Sy8g5NXllwJQJXxFup5Ky27f0P5Tbs1
         i3FOrBXUXx+LOm0U+ndJR6TcCvbBmQRXn8tzIUTGLUwcHtrkC5WrR8SZUBH5rFr3QQ7P
         6P5XESqOxkgvRLTK6TySEXplGa4DxoWQ0yifmtNitF5mVJMltP8g65NE87Le8blCxjpH
         XT6nJp+wGhuRuGl868oEthfqqU7nBlBCwvkgLHeO5YJgQgI53gJXMn97KKQE/jAYt0BF
         gSPG3QUJs/pl1Qxuecxyjoq4HbmUSuBoHYZjvsq18pNSrUF+1zNtFMbso/wmXhYAP+PG
         2eCg==
X-Gm-Message-State: AOJu0YwAZFQMwL+8Pk2Zp83K7Vo+ZEchU4StgerHuTIlI4emu3jKjLQs
	qxM6syYUCxVWvJH3YAa5voFf286HIK3nwarhki8cND2atJbO9pS8bmNbA7vX6BpRs29K
X-Google-Smtp-Source: AGHT+IGubIEN7TC0jcNL6bpxJv0i0Wqy/2Ql86UKZxh7ljaXe+zeSTZ44Es4Je+fSCkLfHliMltoBA==
X-Received: by 2002:a05:6512:547:b0:513:c1a8:28c1 with SMTP id h7-20020a056512054700b00513c1a828c1mr1677057lfl.2.1711625570705;
        Thu, 28 Mar 2024 04:32:50 -0700 (PDT)
Received: from localhost.localdomain ([83.217.198.104])
        by smtp.gmail.com with ESMTPSA id b14-20020ac25e8e000000b00513e9f88249sm164038lfq.207.2024.03.28.04.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 04:32:50 -0700 (PDT)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>,
	syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Subject: [PATCH v2 net] RDMA/core: fix UAF in ib_get_eth_speed
Date: Thu, 28 Mar 2024 07:32:33 -0400
Message-Id: <20240328113233.21388-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A call to ib_device_get_netdev from ib_get_eth_speed
may lead to a race condition while accessing a netdevice
instance since we don't hold the rtnl lock while checking
the registration state:
	if (res && res->reg_state != NETREG_REGISTERED) {

v2: unlock rtnl on error patch

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")
Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 drivers/infiniband/core/verbs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 94a7f3b0c71c..9c09d8c328b4 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1976,11 +1976,13 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
 		return -EINVAL;
 
+	rtnl_lock();
 	netdev = ib_device_get_netdev(dev, port_num);
-	if (!netdev)
+	if (!netdev) {
+		rtnl_unlock()
 		return -ENODEV;
+	}
 
-	rtnl_lock();
 	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
 	rtnl_unlock();
 
-- 
2.30.2


