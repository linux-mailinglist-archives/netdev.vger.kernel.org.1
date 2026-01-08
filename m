Return-Path: <netdev+bounces-248214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 955D8D0570A
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A70823028E71
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089962C21EC;
	Thu,  8 Jan 2026 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delta-utec-com.20230601.gappssmtp.com header.i=@delta-utec-com.20230601.gappssmtp.com header.b="A96yEUlE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB529D29E
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894327; cv=none; b=IDuipUueaFpdSALolXa8sKcOKX0/8+SVhTDH4hi0rxDDSYdiCmJakIDkH1GHFwt/N1AiLkQYj9IPu7QUfsyyPsGMc2ajiL+jbBqvM25Jt4cE+vXBsis23bdf6cVmGeP3iK2QYHCKminu+LVh83BgOLqiBDSi61LDvlcCgUnDpgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894327; c=relaxed/simple;
	bh=DfSElPunnT3DQ2VoEPFNQt4PS9eIRe0lWDhQUGVTfxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hl55Dacr3VyKkuFyRYYRT5l4TU5ckC3n0XzX0NANo8M/fc1qmq0ih9ATgUKKaFVcmRk2Ok2vXIeitG+2JF2WTaXN+O85/gUriUP1jnISzaB0zGw1brFFI5gjhoSJS+/R6gRaE+3iykBIdcd+UmWsDZY9bHienpSUS+S0I8c2pDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delta-utec.com; spf=none smtp.mailfrom=delta-utec.com; dkim=pass (2048-bit key) header.d=delta-utec-com.20230601.gappssmtp.com header.i=@delta-utec-com.20230601.gappssmtp.com header.b=A96yEUlE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delta-utec.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=delta-utec.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so5628980a12.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 09:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=delta-utec-com.20230601.gappssmtp.com; s=20230601; t=1767894315; x=1768499115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UxTJ8YNxrjufokYjFRXPMXxOxHBYQQfpvqHnyHlCiE=;
        b=A96yEUlE5xcQS4VVINhFT9RQDwmGox92oOkvfQ6/QndVz7jWDQId63bX1/FsWu/ngn
         GSwYTwJJKoicopYyvnAoJogtXsbLJPd4zOQczcqat7TJTcUAhJY8ab6ooWvdwHm4Fp+t
         fRtJHMjPLWvxtnKcLBTaz3tVUtOlS8GQE96dHV0VmyrLDf4rddJ9amos830BIYV+dnDZ
         IQYxFwt6nK0hmM63IR2RMQ5ve6+1ySeax1uIWpnde8DGndygMSPGMjke7u6MXSXxfWk4
         cVenj1npgebUiklB9frcwdomcxBy/H6zEuDPYrM48uU4Jy+Im7sXv3WSWPM+PsGLB4yS
         PzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767894315; x=1768499115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UxTJ8YNxrjufokYjFRXPMXxOxHBYQQfpvqHnyHlCiE=;
        b=gkJ7qhxIGHVlYMlhPX75YluUW8qoqSODFrpdNJ8214WzybCLw+Soiedv2YOR2CGMcj
         PrQmaoA9e/3zv5JwEuC59q+tvWI/aa1glnJ07hz2fiY2FlPpAYWcuQ8Bi5lCokP3j1d3
         o2bco2yk+lGxc84ak9UeCyC7EHout8RkSLxq5R5a0L37K+JLHIhX7Qo3lr4moN8+E5Aa
         Zl4+s2zJd3YallRAhvCRvnaThEVwkZz45/mzX8KI0z88p7ZDOVC7IXPhBDteGl+Q/aYw
         MFO05eJT3l9oT6fKweCKTD4GcjCWfAsvKbZXh7yu+N45LXP83ESZK4anF8XI1LUWG714
         gglg==
X-Gm-Message-State: AOJu0YxxhylqKAMvkjFz13eUxpr1onbFaw0SLiflqW7QqaObxNp+dVOw
	pR8t9DB2hybq9Au3G4rR0jkWxK0wXmO+KAjHjjKOtCCvDtwjplcz150wELoBoE+NlvWoL9C3+8C
	nca2EIgx5
X-Gm-Gg: AY/fxX73WtQur5PocdE7ClQ013ahT4fi9+bkVjBPPpX+t8BDsqAQCmw6H9220M0BYcK
	hAiE84GnT/nXHwUVE6qrx5wQQEUwXBMCsTJwtWkbTXE4Vh3huVg8GYyL5PlaXtZ5SNPqVAdqd1A
	8b4r5hxLEg7qRPl7C3bir6o7b6iALrhrz865F7jn7ql3C/DEURnZERYIM8SCQy9org/q2Mi8o1D
	6IOhqlWVeSsy7ynWpiRnEnAVXuJyIRmM5TlgdY4O0cbR1EVYNUPBKGFYgPi4EanQdUB1zAGgeJt
	b/7bg5NtpzpqZq9+Wo6VTWEBWkhUcEmL91myUm0fSIp0M3d+hnJWWZh5xIhK5rt+Bwv8l1NRUrd
	qoAKQ6IXm5YmD95trxSIbFYG4YEXXEdc9NB1EO64ZsWRYG317wf+yGnijQE29IXodu5gGSactL2
	3Biabxax66Mtt8eOFtcHUyg8ic3QUU/UwD0ZP8z34wErDHlic/uLr4NVy+ZTOY6ytyBKRx78BEt
	KXIEGniouPQwW0OTY7OjGDCGnEwnu0s7bai9Q==
X-Google-Smtp-Source: AGHT+IGuCv7a9D6GBnr5zNdHvDJ7jtKQ5O4u7L3VXCO7uSiBz1b+IWvm/+GDnPrCZY0TATroDJDEHw==
X-Received: by 2002:a17:907:72c9:b0:b80:3fb3:bea0 with SMTP id a640c23a62f3a-b844520f355mr752240166b.56.1767894314818;
        Thu, 08 Jan 2026 09:45:14 -0800 (PST)
Received: from localhost.localdomain (2001-1c00-3405-d100-83e5-0d54-1593-059c.cable.dynamic.v6.ziggo.nl. [2001:1c00:3405:d100:83e5:d54:1593:59c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d31e7sm890428966b.42.2026.01.08.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:45:14 -0800 (PST)
From: Boudewijn van der Heide <boudewijn@delta-utec.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Boudewijn van der Heide <boudewijn@delta-utec.com>,
	syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com
Subject: [PATCH net] macvlan: Fix use-after-free in macvlan_common_newlink
Date: Thu,  8 Jan 2026 18:45:04 +0100
Message-ID: <20260108174504.86488-1-boudewijn@delta-utec.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macvlan_common_newlink() function calls macvlan_port_create(),
which allocates a port structure and registers the RX handler via
netdev_rx_handler_register(). Once registered, the handler is
immediately live and can be invoked from softirq context.

If the subsequent call to register_netdevice() fails (e.g., due to
a name collision), the error path calls macvlan_port_destroy(),
which unregisters the handler and immediately frees the port with
kfree().

This creates a race condition: one thread may be processing a packet
in the RX handler and accessing the port structure, while another
thread is executing the error path and frees the port. This results
in the first thread reading freed memory, leading to a use-after-free
and undefined behavior.

Fix this by replacing kfree() with kfree_rcu() to defer the memory
release until all RCU read-side sections have completed,
and add an rcu_head field to the macvlan_port structure. This ensures
the port remains valid while any thread is still accessing it.

This functionality was previously present but was removed in
commit a1f5315ce4e1 ("driver: macvlan: Remove the rcu member of macvlan_port"),
which inadvertently introduced this use-after-free.

Fixes: a1f5315ce4e1 ("driver: macvlan: Remove the rcu member of macvlan_port")
Reported-by: syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7182fbe91e58602ec1fe
Signed-off-by: Boudewijn van der Heide <boudewijn@delta-utec.com>
---
 drivers/net/macvlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 7966545512cf..d6e8f7774055 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -47,6 +47,7 @@ struct macvlan_port {
 	struct list_head	vlans;
 	struct sk_buff_head	bc_queue;
 	struct work_struct	bc_work;
+	struct rcu_head		rcu;
 	u32			bc_queue_len_used;
 	int			bc_cutoff;
 	u32			flags;
@@ -1302,7 +1303,7 @@ static void macvlan_port_destroy(struct net_device *dev)
 		dev_set_mac_address(port->dev, &ss, NULL);
 	}
 
-	kfree(port);
+	kfree_rcu(port, rcu);
 }
 
 static int macvlan_validate(struct nlattr *tb[], struct nlattr *data[],
-- 
2.47.3


