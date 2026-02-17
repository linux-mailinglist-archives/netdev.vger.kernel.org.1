Return-Path: <netdev+bounces-259044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAqAA1t0lGnVDwIAu9opvQ
	(envelope-from <netdev+bounces-259044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:59:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B1414CE20
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BFB6308B2CC
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E2536E462;
	Tue, 17 Feb 2026 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnA7tQCh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991E36D4E1
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336496; cv=none; b=RBISgjsgiSJoOzpT8niOcBp2bRYnPUTaCBkgMiUX0CgEAk0eUGDRCtLDJUpWvrrXIrAEF6eyw0sBhPz1xo2EisUgfoawj2qcUh/lxZ70TTSqNkgfREZIUwjyRkf0Z35KiFVoHaWrLNT81HQfr8MdEhLvp7FYKP8xYRqzNcymJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336496; c=relaxed/simple;
	bh=tpVz+/9KZhMiHs88YAAeN8j1bHrbz5eQ3HN+VNf5ImU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlRsw70Adv78mvxZFSWBlzJhGidK4fOeGpkWYePrqGmhIfRAhwNfsIguAOo9RFrQyGtx9JYrn4qw6Uls8MUisz3D+qjzKToD8XSVKhAddsTSzBCV51l0dgafRwBbIOigOAbjvEPD+Jo4BW3tWuNts+z7kZf8Ec64UVv3SHbNY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnA7tQCh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-482f2599980so46233215e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 05:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771336493; x=1771941293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/Db8GHeRwj5/JWbCcVvx6pqqRvI6zmNzmG5BE40n8U=;
        b=LnA7tQChJjVFuMVz2uv9kN5bp4ZrKtmIO/ltHP6mhlpfgYZ6pB8BgiYSVD40Ym5oBZ
         oBMLCoIbDsyc/ZOlz8KMq0lwk4+Pk+M2qdgPQ1fuxnpayM5bTz/ugEorif8cSQYFjjM3
         i+Yjj8bxv+OYNInlZChXTPcpILkb7tie/+1+TwnCn7gCJwb1RRaiV5Is6RCyrs8qgHAK
         +LhLDRjtsUbe0e2KNtFmA/te3GHSQBLWll3RbC2CjpLASW4owSIToSsPN5HCKLoR/3Dl
         Aermv9Y2Ys6By+HS0inXPK5Cy1v+mTN4MyrQM9+MWQttQT7tBeyqweSiqfQ6aIiX4X44
         UxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771336493; x=1771941293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/Db8GHeRwj5/JWbCcVvx6pqqRvI6zmNzmG5BE40n8U=;
        b=ePaoa/VZt60uflUaYEADVJyHVxcSwIKnnprldoYFUl7BcGTYG/E1a2kWq50DI7aVS2
         faNa3SXUhJrV6T8S0aI6GfNxqGw0v+GwhpjyuYf12Kg646Ie+HlsuIvQBiTR+9Fg1mp6
         o+bt5HHsEvThVNPUHAZnwT48ANAudQbxFpX5Y1p+18coBUKfmlIudP1PweABvpikWcDt
         /20End5kv5SgK/lg/Cc1tCdzFR9PQP62k5S5gLFvFMBwhJIsh6hBvhVOnoKKWOFOp/rC
         nHuLkjxhW6aV1GWYN6hM0v85qd7QUrSz9fIsAUpX9JH4MmEGPhHhgOPi701sd9tK0SAX
         wzTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvjTRHhyJWteaHq2DplqMkLsSjEYm+ohagH17o0cIgVHlGLgWRIFjRVaFLXNoNe4vNZKvt6qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdYKdPOVjtHvtbsfhnKbJVysqWOasAlkA9J5AMZZ7AXGFQLZLI
	uqt8bj/jMxaO0856kalQxSxk8Qg6wz7+piPB3avxHEMrMWHAiv1E0Ltq
X-Gm-Gg: AZuq6aIq+y6VQs8rhbCJ/kRd6PnD25q9qq3N9QFKr9eJggPHSthRj+TQ0xhNksCxb8g
	l1zP7zlFjz7LUV4FaUIjGy4sVicX1+ERfUH1cos5Xzz8syDeWU+R6W11aw8X/+pcNL+dl+n1Xs9
	h/fP/x42hEKscFVOrQlu2w3069ckh6pki42op/bX3sE5c/8ttYfwlMtnBwgtxfpRy/Z4/CVlITa
	F6PglGZqniMiGFGG0v/qBa8UOq6P1OdO+hPCRKG4ycMCD0C97QdMzqdFF7LomJIniEQ7endg1xo
	HS3SdHwLvgNGmqPU0WFdIl/9N4vIFft5K17bebsrx1f3gu1tvbWGgEl7TasgYNjZ2elBkyIE3MM
	YfAw/ZCdiLo4Q3Cde0/IWjTZJelYnG3VdfIaZ/FRSF94TPtrStFRSoQn1z6fX8rQSHC+wA3GgGX
	k87wtdigRPciYHuVfktJImoR/xqgKgQ4I849+pLN8TtFg+0w/DP2efjOYSL8HQ55+3jQ==
X-Received: by 2002:a05:600c:524d:b0:483:4807:210c with SMTP id 5b1f17b1804b1-48373a5d7a0mr285729075e9.24.1771336492692;
        Tue, 17 Feb 2026 05:54:52 -0800 (PST)
Received: from tabrez-VivoBook-ASUSLaptop-X513UA-KM513UA.. ([27.4.206.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5b07fsm33993120f8f.2.2026.02.17.05.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 05:54:51 -0800 (PST)
From: Tabrez Ahmed <tabreztalks@gmail.com>
To: allison.henderson@oracle.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gerd.rausch@oracle.com,
	charmitro@posteo.net,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tabrez Ahmed <tabreztalks@gmail.com>,
	syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Subject: [PATCH net v2] rds: tcp: fix uninit-value in __inet_bind
Date: Tue, 17 Feb 2026 19:23:49 +0530
Message-ID: <20260217135350.33641-1-tabreztalks@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,oracle.com,posteo.net,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-259044-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabreztalks@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,aae646f09192f72a68dc];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 76B1414CE20
X-Rspamd-Action: no action

KMSAN reported an uninit-value access in __inet_bind() when binding
an RDS TCP socket.

The uninitialized memory originates from rds_tcp_conn_alloc(),
which uses kmem_cache_alloc() to allocate the rds_tcp_connection structure.

Specifically, the field 't_client_port_group' is incremented in
rds_tcp_conn_path_connect() without being initialized first:

    if (++tc->t_client_port_group >= port_groups)

Since kmem_cache_alloc() does not zero the memory, this field contains
garbage, leading to the KMSAN report.

Fix this by using kmem_cache_zalloc() to ensure the structure is
zero-initialized upon allocation.

Reported-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aae646f09192f72a68dc
Tested-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Fixes: a20a6992558f ("net/rds: Encode cp_index in TCP source port")

Signed-off-by: Tabrez Ahmed <tabreztalks@gmail.com>
---
v2:
 - Updated Fixes tag to point to commit a20a6992558f as requested by
   Charalampos Mitrodimas and Allison Henderson.
 - Explicitly mentioned 't_client_port_group' in the commit message.
 - Fixed line wrapping to be under 75 characters. 

 net/rds/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 45484a93d75f..04f310255692 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -373,7 +373,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 	int ret = 0;
 
 	for (i = 0; i < RDS_MPATH_WORKERS; i++) {
-		tc = kmem_cache_alloc(rds_tcp_conn_slab, gfp);
+		tc = kmem_cache_zalloc(rds_tcp_conn_slab, gfp);
 		if (!tc) {
 			ret = -ENOMEM;
 			goto fail;
-- 
2.43.0


