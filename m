Return-Path: <netdev+bounces-124504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C364A969BFB
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB501F213ED
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860C11C62D7;
	Tue,  3 Sep 2024 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="zfY7mx2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65541A42B3
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363350; cv=none; b=RmZ0b+ZqwEtEl7YvmXf3tPgljYyIEOLIlq136AzfPSHeJxzVcFo7k4FvWjxVMHAzG4EBS3Ki76fAtFCkMPVj1tZjl/VY3oaocpjGya8gEp996vYIA/jsQSerL12JvUEbU7dRSfW0IidWJALqDEm0rfcbdMkCip6pQg3+W/TMIRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363350; c=relaxed/simple;
	bh=549pC1Ex3vvIIiJV0u5ufMAvWBbGs7c7XWpaimHR/BI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fMh7Bj/KuHDfEgaIKVr/w1L0fRW9N+mFsFzdl8xzlssrToyDhcCWajF0AIBfr3kyGVG46mlGJC4Hsy+JREQ5/J1xA9xbLpMVCyB+Graz8cdY/u00GYYqLEIhohv203wb/iIJu8VQ68KvT7e5i7nM7MVtQGQa9PpqMZYwZ7zSPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=zfY7mx2Y; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:ba5c:3e5a:b199:d36f])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id B1DBE7D9AC;
	Tue,  3 Sep 2024 12:35:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1725363348; bh=549pC1Ex3vvIIiJV0u5ufMAvWBbGs7c7XWpaimHR/BI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09kernel=20test=20robot=20<lkp@intel.com>,=
	 0D=0A=09Dan=20Carpenter=20<dan.carpenter@linaro.org>,=0D=0A=09Tom=
	 20Parkin=20<tparkin@katalix.com>|Subject:=20[PATCH=20net-next=20v2
	 ]=20l2tp:=20remove=20unneeded=20null=20check=20in=20l2tp_v2_sessio
	 n_get_next|Date:=20Tue,=20=203=20Sep=202024=2012:35:47=20+0100|Mes
	 sage-Id:=20<20240903113547.1261048-1-jchapman@katalix.com>|MIME-Ve
	 rsion:=201.0;
	b=zfY7mx2Y2g/o2f4sVfe7/GrZX5DUtMAFoI4DMtpPYxCP0euax4dHcVLdyUt6kj51H
	 uOX4taEh0JnVNyv8ohfpLqqeTV5Je4taQxAOTME07dQ1TaAwO0oSX9XN5SaACAaygg
	 +ikc1nL4r27oULz0ZojJM1VggPXsQrPqLqQFDkjniGvE0Vd+2OXFIn70uoWfOE3mjK
	 eqasQgCLnZAb42n83TsS0broBVeNuE+jAKNZFcNittaChuI5ctET/XkXoimlENfX+N
	 9rmFD404YntDiQZYA+LtLleXCEzsFdzLkDUCfr0sqwux619964wKe+UYgEMMayS764
	 eSVaNJ5x0zpkA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Tom Parkin <tparkin@katalix.com>
Subject: [PATCH net-next v2] l2tp: remove unneeded null check in l2tp_v2_session_get_next
Date: Tue,  3 Sep 2024 12:35:47 +0100
Message-Id: <20240903113547.1261048-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit aa92c1cec92b ("l2tp: add tunnel/session get_next helpers") uses
idr_get_next APIs to iterate over l2tp session IDR lists.  Sessions in
l2tp_v2_session_idr always have a non-null session->tunnel pointer
since l2tp_session_register sets it before inserting the session into
the IDR. Therefore the null check on session->tunnel in
l2tp_v2_session_get_next is redundant and can be removed. Removing the
check avoids a warning from lkp.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202408111407.HtON8jqa-lkp@intel.com/
CC: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: James Chapman <jchapman@katalix.com>
Acked-by: Tom Parkin <tparkin@katalix.com>
---

 v2: improve commit log and use acked-by tag
 v1: https://lore.kernel.org/netdev/20240902142953.926891-1-jchapman@katalix.com/

---
 net/l2tp/l2tp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 32102d1ed4cd..3eec23ac5ab1 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -345,7 +345,7 @@ static struct l2tp_session *l2tp_v2_session_get_next(const struct net *net,
 			goto again;
 		}
 
-		if (tunnel && tunnel->tunnel_id == tid &&
+		if (tunnel->tunnel_id == tid &&
 		    refcount_inc_not_zero(&session->ref_count)) {
 			rcu_read_unlock_bh();
 			return session;
-- 
2.34.1


