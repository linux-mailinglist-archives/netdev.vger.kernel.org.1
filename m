Return-Path: <netdev+bounces-106028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5A79144DB
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0D21F241BA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 08:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FF24D5AA;
	Mon, 24 Jun 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="PRi+3F47"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203FF29CE3
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217794; cv=none; b=Ty5apturFH/Bj5KhssgprBrkE8mJxoN8cQ9XnK1pgLEaAonFJBej7J/BR6GxO4dkhjaw6cnFkXJaF0tSHh2QCwIOQ9vcVOVNwgRZwkO+7U+b5RkNfFkvv74/gxh/OXZH8xOfV6NinBve8Rc+qFeHijlndJLU1/XeJo5JrNcksxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217794; c=relaxed/simple;
	bh=MXfzqDKhT6SwXnjm/jPsCEg7lMMwCW49wIlFNm4SdK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ipDDq1YenIAb/B2cOT9fD/befc9GibAATk6r6aBVwle6vHtM89TodmIA1+pbGuo4Docueg4Wg9BBE/h/k/9o5uQsTRrRYAznpOKd5Q2iFJxsBEBOj17oovYVetBgsntycOo7JlgYNSr//s+N1BR/fxotqka9zVqiEV6Fwf0Nnwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=PRi+3F47; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:28df:af21:a9f:6679])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id D5E257D9CA;
	Mon, 24 Jun 2024 09:29:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1719217786; bh=MXfzqDKhT6SwXnjm/jPsCEg7lMMwCW49wIlFNm4SdK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20dsahern@kernel.org,=0D=0A=09tparkin@katalix.com
	 ,=0D=0A=09pabeni@redhat.com,=0D=0A=09kuba@kernel.org,=0D=0A=09edum
	 azet@google.com,=0D=0A=09James=20Chapman=20<jchapman@katalix.com>,
	 =0D=0A=09kernel=20test=20robot=20<lkp@intel.com>|Subject:=20[PATCH
	 =20net-next]=20l2tp:=20remove=20incorrect=20__rcu=20attribute|Date
	 :=20Mon,=2024=20Jun=202024=2009:29:45=20+0100|Message-Id:=20<20240
	 624082945.1925009-1-jchapman@katalix.com>|MIME-Version:=201.0;
	b=PRi+3F477Xms2fzQFDYmJ9zyS6ndZH7gDbQbXmm5NSKU4ouzL53w7AkBAZnPc9fh3
	 +3UvVfSQDXlm0UyozbPBdcWInwoEgIqXwx7T/qUJjarKP3eGLXQpbAHGtEBN4Jyvfe
	 hIhi7zYYv/QwX0AKO93BEmsHUhbOt4/Dfr18snasTqrzXsIAcj7CsA/teXMSSI7Q64
	 EbErQY2QPXy7+BQ4OAJv5eB8K0/XIdTCQr1l02xSpZ0Hj5X1/vsesUyO5JrMItAipV
	 iy5J0MS+rTGsRhkQQ/V9ZlCzW/pxji/54ruuGS3quM2q7k4YrA7lFi2Ae6LALVTrsm
	 PVF0kVyqdpyNA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	tparkin@katalix.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	James Chapman <jchapman@katalix.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net-next] l2tp: remove incorrect __rcu attribute
Date: Mon, 24 Jun 2024 09:29:45 +0100
Message-Id: <20240624082945.1925009-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a sparse warning.

Fixes: d18d3f0a24fc ("l2tp: replace hlist with simple list for per-tunnel session list")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406220754.evK8Hrjw-lkp@intel.com/
Signed-off-by: James Chapman <jchapman@katalix.com>
---
 net/l2tp/l2tp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index be4bcbf291a1..64f446f0930b 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1290,7 +1290,7 @@ static void l2tp_session_unhash(struct l2tp_session *session)
 static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
 {
 	struct l2tp_session *session;
-	struct list_head __rcu *pos;
+	struct list_head *pos;
 	struct list_head *tmp;
 
 	spin_lock_bh(&tunnel->list_lock);
-- 
2.34.1


