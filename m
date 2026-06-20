Return-Path: <netdev+bounces-300781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ta+bFxw4NmqK8gYAu9opvQ
	(envelope-from <netdev+bounces-300781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 08:50:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC86A8708
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 08:50:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TPt0cs81;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300781-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300781-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E067C302EECC
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 06:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5AD372675;
	Sat, 20 Jun 2026 06:50:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020ED361DA6
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 06:49:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781938201; cv=none; b=Wys4xuXgs0fnYOzKFXjlSNs3r/BRjOD9rPRAAXOElZ/C0RsZrN9Zp6ww37FgwlE6EjH3kD8Yaj7oe8d6Klr1l4LocCtsxLODhji+i206fiboION3EoC5Sfr710VtOltXGts3e2RM7IzIzyIq5xXnRceucZg5+MQ5wjB62EYFupY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781938201; c=relaxed/simple;
	bh=4mqGOvPe2ySFz23e6c1nkg/oSG2A1tbfWoG8+d7LdcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKcdvs0UHXGrfLysrAK5ag+J9KRu/nHXamxhSkvizdETXNlpACDMiuIzMh9ePS3/96hf2BKSOprcj6xbT1Rkvs2Qc8+hZALQixQQ6mIhI9ab+DpuUGIuRdsxJQ43oAV70pgtwkIV3WIg0/o2CpvsEBPSvUBwfIGYWt8g/bzxsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPt0cs81; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84537777d45so2108292b3a.3
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 23:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781938199; x=1782542999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4gFwDs7h2AgPecnLqQuSzgjfmb3gFWpW8KL8n46kjY=;
        b=TPt0cs81hgbesRMPuorL23PzGmpnbWyAOkh29ID+mbRuEI1YAYpATp3GhtF/J6DwMg
         3EnHD4xZxxHe7eZKIRpMAkgyIlZnpKeR9hfzTfNTfRDv75eNQqjVBaGWD/olye+NahFN
         8HW9DawN7P9TUO1xowLkn8pIy28i0aYYGjwsERnpxaoUmVXLcTqQv2tmnuTtZdiqNxcO
         7n6q4UeczJmO9lu2zKUpOPNhyYQEdYsGy+XgIVr45umtrVomtf7egUy3OzxcsxrOW1vH
         0eXkmUsOtmrrnPqcbGEz5yilsqqsMg478vO9QZu2/aZT2DMwOTiw9CCrD5nKsdRVeL7I
         Y83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781938199; x=1782542999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4gFwDs7h2AgPecnLqQuSzgjfmb3gFWpW8KL8n46kjY=;
        b=dV56OcruZ1nf6Xaqq5f4w/ylvFxFCiKHPolAyrq81VF1r2crJbpHBTc3KNneeXtqw0
         dL5NyssLxkvKPtio6iBLTkq6SUqa2AM8azq112yAL3QRRX9uwI7mMxHglpkK0cJhN5Pw
         rcK1LcndOVyk1//HOoxxExq1Ait0j4GzK5cxcbjUIDfTdAVFKUyPOIvXuJpZzwIH9E16
         8h5CNWeuOXauinamkppmlieSxPgB2eyhCSs8G3AK4gF0EHHMh0ImKVnyXEtX0ndGvp53
         3ZxBxtbNUGPU0AGEeQdc+PEwQPeRiZIo0vKlZ2b75UepH54rZXlEzCQ/Y5wi0BT6eWGz
         rg6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8g6qPdgWQvw2FoHekIkazNLMeJVj2CRIH/GfCc09PZQqfebi3Akl+pRV4gvYXH2OctO15CZpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg7umm21AxKyvFDbar3VbRHzRh2N5cOiaQT9luL3dOuQe6JMr0
	sX830jt+UZigvu1Hhqon2lms5nd2SjLuxwwRKIexBvbsWfe+c1ba4nve
X-Gm-Gg: AfdE7clYrELTepC6+pCS5r3LfvzpAG8D/5tKHdT9P/MvkUjmqa6DGIn1Z7317/UIilH
	D6tWdwbVaOsw4vKKWuU1M1yxjlZ1ESiOKeERPIZGxUnPc9Eilzi7SUuDu63WUgKPjqhfojuc6Rw
	vqMFMIsQh85DY12nGoP52PCjnbHeOi0hEXG7ZXGhfMrWEZtvX3CnPfuavQcqi4CRPmkPB7hLLgC
	Ojj2d1v25lnO832jRCq7or1CCUqy9hf4r58xGqv1RFQENfyxT0reQgkZ00+GDdsEGPsV16z+y7N
	/JgDTd703fULDfJepWbl6J5IvfsZoXicdrZSijStaEMQTGpHmFD9brT8PTf543tQDUatFbDf7Kr
	hdgmBryDqG3elP92J2W7jueOTVkanfHgtI2Hf84Z+iX188lhclIVCic4PcCHZKzJMO5YHBBRWaJ
	9kj2cb5M/JHLwiwyXU0qv41AWJQYxi2Q==
X-Received: by 2002:a05:6a00:4654:b0:845:328c:1ec1 with SMTP id d2e1a72fcca58-845507c1d66mr7412645b3a.12.1781938199294;
        Fri, 19 Jun 2026 23:49:59 -0700 (PDT)
Received: from i386.168.1.127 ([2402:a00:163:2ce9:9c6f:e28:3da8:7980])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ea22c7sm1197475b3a.44.2026.06.19.23.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 23:49:58 -0700 (PDT)
From: Hrushiraj Gandhi <hrushirajg23@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hrushiraj Gandhi <hrushirajg23@gmail.com>,
	syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com
Subject: [PATCH] netdevsim: fix use-after-free in __nsim_dev_port_del
Date: Sat, 20 Jun 2026 12:19:37 +0530
Message-ID: <20260620064937.16301-1-hrushirajg23@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,resnulli.us,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300781-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hrushirajg23@gmail.com,m:syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hrushirajg23@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hrushirajg23@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,6c25f4750230faf70be9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FDC86A8708

debugfs files created under a port's ddir (ethtool/get_err,
ethtool/set_err, ring params, bpf_offloaded_id, udp_ports/inject_error,
etc.) store raw pointers directly into the netdevsim struct, which lives
in the net_device private data kmalloc slab.

If these files outlive the netdevsim struct, a concurrent reader can
trigger a slab-use-after-free by passing debugfs_file_get() (which only
checks dentry lifetime) and then dereferencing the freed data pointer
in debugfs_u32_get().

In __nsim_dev_port_del(), nsim_destroy() is called before
nsim_dev_port_debugfs_exit(). However, nsim_destroy() calls free_netdev()
at its end, while nsim_dev_port_debugfs_exit() removes the port's
debugfs directory. This means the slab is freed before the debugfs
files are removed.

Fix by calling debugfs_remove_recursive(ns->nsim_dev_port->ddir) in
nsim_destroy() right before free_netdev(). This ensures all per-port
debugfs files are destroyed synchronously before the backing memory is
freed. The subsequent call to nsim_dev_port_debugfs_exit() in
__nsim_dev_port_del() becomes a harmless no-op.

Reported-by: syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c25f4750230faf70be9
Fixes: e05b2d141fef ("netdevsim: move netdev creation/destruction to dev probe")
Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 27e5f109f933..08136e7990cb 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -1214,6 +1214,13 @@ void nsim_destroy(struct netdevsim *ns)
 		ns->page = NULL;
 	}
 
+	/*
+	 * Remove per-port debugfs files before free_netdev() releases the
+	 * netdevsim struct to prevent use-after-free in concurrent readers.
+	 */
+	debugfs_remove_recursive(ns->nsim_dev_port->ddir);
+	ns->nsim_dev_port->ddir = NULL;
+
 	free_netdev(dev);
 }
 
-- 
2.47.3


