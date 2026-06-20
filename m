Return-Path: <netdev+bounces-300845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NiAdKxf1NmouHAcAu9opvQ
	(envelope-from <netdev+bounces-300845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 22:16:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F379A6A9ABB
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 22:16:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=LfyoDid7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300845-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300845-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00FC13008D30
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309F036A34C;
	Sat, 20 Jun 2026 20:16:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A42417D1
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 20:16:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781986577; cv=none; b=EadrVOOTTi8LaesKyZn9I+yw0h82wFA+Jxc8GJYRqiEF8dczoeTtMek90Wo95jjqlN1AZqZg4syQGRkUoPRfDFCx/5bIl6OLvL2uR1ii4UobmilrN3Xpm0Y1YDCk49DDsQvDwA+IUXVMuRa7VeVk2UFaYriVMWA/lMwcs7qB9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781986577; c=relaxed/simple;
	bh=LIsuuVFh9rqAnffRRLX7EYaWLpMggrVjylfB5CZ81L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+g0IrybcVqeuaInpsB8UKfVnlLx1y/IDkFwpQUuxct1ZcolOEPmHUilpxeko0aRxK4ryqij233pMG0JnebjH0a+V+fTdfmaNOW4eGiz2wpiX+hKkNaYNadkp8+ryZONdEYRCGpdkdmt6SfaImKZrARemSZ43PRKrfv3V13i2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=LfyoDid7; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf1f074a12so26831025ad.0
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781986575; x=1782591375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z3UyEb8OkZcV7i25lPmBZwX/buS6tC9WTgQg7YwJuto=;
        b=LfyoDid7QHot4e6k7UtzS7ssahbMK9p6kByJryBmu3Nc2OmBH8OzZNFmIa0ksiLs+h
         ZPU3Tx47DZ7vi5/smoXzx/mCAHg4JacGsTR6/XOCn9/J8tozSMJQL3yXhVJEZJL07ylg
         5hV1aWtk7UMQQBBP30VIMDWYCzrVEsCTkcHa4iZkr+jgG0e7uOIrAxtGg2AU11VeFewv
         m8f9fSRzggjIlmbxk3eGcpWdfc29ZqvXA2H5Gxp1N5sIK9ffgKlGxIdDTxF2UwwWwrIW
         7O6HLkb9y/A4EGNmHjDrjlPMrFQwGmxzXoS1Ae2pZqVbxqLZdbcGnYJPO92d5ggTUUaN
         gHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781986575; x=1782591375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3UyEb8OkZcV7i25lPmBZwX/buS6tC9WTgQg7YwJuto=;
        b=Oku1kfDdOqAO3+Go6nV10QbqtdfT5e+JmfvtoqIQ8nK6CyxDAQeYTj5OOYCea015Dz
         Ch8h6IImFx/fnK8ckenqWwjEdTRrfE3iqNANBOq2QEx503Ba80xd6nzt9c75bPWPNy4y
         3IUIe609JIwSnoDl/eCXLXCO/DLqHxyq5AQCdZObozglqrlH5oTBM0kuicpX2yv5Nosq
         Ac+3kTI2HpZSNfnicjHNO8PBS3BJqc26xni97dzSCtNJfXW8Xl5JnG+wUw5Xd1nXlZaI
         R8ao3PrYXXnTTjXLkLgEaptaWD48VZ0BB23T2QJarO7kcCHCd9LhqkJPLXRkeugJCiD7
         9YzA==
X-Forwarded-Encrypted: i=1; AHgh+RrBkV8kDuSOAPWkmpHs8WRMQNpv+TGZc/QJjECFXCqo+PASq9qQrmaMV7jExnAHKbh6XH/OcIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJN6/66w9xRTRkZNos1JDWU6YqjBOYLPBHWkpdQYG/3By/7sY
	rSoEtIeF1/LB8QMpj3xzGwbWrQ8xWEvZYm+OJhbfi3tBMQ/r1X1jqpR3+JtX5cAR2A==
X-Gm-Gg: AfdE7cnpRUgOt6Jv70PIicdAzmv26ByvEkIfQGr17O+wZC6Bcie8G7FsNn9gJm9qKnK
	9sem2t0AJMOA1PGOqjxlFpX6HKRiGS5emCl8xMJ9J3W3Fjg9bQVmQ1Vf0iIBvNGjFtnEL5oQEjK
	PTuLOTw8BJWA5aTZlwUrlZ6zIBEu/cCh5CD5dCQSY/VKjHG618/6WXkyyUGtigmD/iwQ8uEyemn
	kqp4Iq/XfzuD3Z8AclgtafGEhzilF14apOYp2vEcsr09bWO4hjhvidiekrmkDEow6ojf/45TYAy
	AMPu0joF5A1z1Ld6X9LwMCzMrEYdXBKVtB5aGJW+zeP4WbE+Nar6D3/m89534XQE+Kmhr+Kgvx0
	BdVuygZui9t9XWB40rTVX3XbOmSkOoAGqMiYF/JJAgXlqXhJtv6nWbB+VDGibxt8C9tH3h5SSZQ
	==
X-Received: by 2002:a17:902:d509:b0:2c0:b35d:ed54 with SMTP id d9443c01a7336-2c718fc247amr88629605ad.35.1781986574669;
        Sat, 20 Jun 2026 13:16:14 -0700 (PDT)
Received: from p1.. ([172.56.104.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f85a4sm31747095ad.54.2026.06.20.13.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 13:16:14 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Jussi Maki <joamaki@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net, bpf: check master for NULL in xdp_master_redirect()
Date: Sat, 20 Jun 2026 13:15:31 -0700
Message-ID: <20260620201531.180123-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,redhat.com,asu.edu];
	TAGGED_FROM(0.00)[bounces-300845-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:hawk@kernel.org,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:joamaki@gmail.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:dkim,asu.edu:email,asu.edu:mid,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F379A6A9ABB

xdp_master_redirect() dereferences the result of
netdev_master_upper_dev_get_rcu() without a NULL check, but that helper
returns NULL when the receiving device has no upper-master adjacency.

The reach guard only checks netif_is_bond_slave(). On bond slave release
bond_upper_dev_unlink() drops the upper-master adjacency before clearing
IFF_SLAVE, so an XDP_TX reaching xdp_master_redirect() in that window
still passes netif_is_bond_slave() while master is already NULL, and
faults on master->flags at offset 0xb0:

  BUG: kernel NULL pointer dereference, address: 00000000000000b0
  RIP: 0010:xdp_master_redirect (net/core/filter.c:4432)
  Call Trace:
   xdp_master_redirect (net/core/filter.c:4432)
   bpf_prog_run_generic_xdp (include/net/xdp.h:700)
   do_xdp_generic (net/core/dev.c:5608)
   __netif_receive_skb_one_core (net/core/dev.c:6204)
   process_backlog (net/core/dev.c:6319)
   __napi_poll (net/core/dev.c:7729)
   net_rx_action (net/core/dev.c:7792)
   handle_softirqs (kernel/softirq.c:622)
   __dev_queue_xmit (include/linux/bottom_half.h:33)
   packet_sendmsg (net/packet/af_packet.c:3082)
   __sys_sendto (net/socket.c:2252)
  Kernel panic - not syncing: Fatal exception in interrupt

The missing check dates back to the original code; commit 1921f91298d1
("net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master")
later added the master->flags read where the fault now lands but kept the
unconditional deref. Check master for NULL before use; a NULL master is
treated the same as one that is not up.

Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 40037413dd4e..6037860d5283 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4430,7 +4430,7 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
 	struct net_device *master, *slave;
 
 	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
-	if (unlikely(!(master->flags & IFF_UP)))
+	if (unlikely(!master || !(master->flags & IFF_UP)))
 		return XDP_ABORTED;
 	slave = master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
 	if (slave && slave != xdp->rxq->dev) {
-- 
2.43.0


