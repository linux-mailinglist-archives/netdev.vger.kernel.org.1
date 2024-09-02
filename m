Return-Path: <netdev+bounces-124227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13187968A1A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460931C2240C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1145633086;
	Mon,  2 Sep 2024 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="YFPYI6Tn"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481081A2636
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287795; cv=none; b=VMX0VNuSw6YoNf+UgCpIp0pkSRrIPqsegD3on3jCb7L+pCkSq2wS6X0USUyH/GlpDPHt4HrIPnQqCi6EZ3HrNbnHYanRj2jo1oBKI7G44KoI5eHUj/4C2Og2fJSVqfPFiBbovyW8FKrAuCol/iVIvRvaqvcn5ppIJFiWnT9sjls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287795; c=relaxed/simple;
	bh=pw69Ol1VtkWmCeinA1jVL55T6SOYDM8118MmcRecn7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=krUhyH8fxFHD6O6RkawjgkvQBS2Ciz1A5Ok8Y4NMV+rxMW7dE/VHNsx1VNhoOPdfPAveQsucygwJy4D3SHcMs2HJMfJtwco2WDEXb6aiMLOnfWTfehY+j2OWXW6awE6dKo9jCRRRqu9SeZcK5QZUzgTGkKZRzF4HSQbKFM5BL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=YFPYI6Tn; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:fc08:81f9:afeb:42c0])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id CD29F7D889;
	Mon,  2 Sep 2024 15:29:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1725287394; bh=pw69Ol1VtkWmCeinA1jVL55T6SOYDM8118MmcRecn7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09kernel=20tes
	 t=20robot=20<lkp@intel.com>,=0D=0A=09Dan=20Carpenter=20<dan.carpen
	 ter@linaro.org>|Subject:=20[PATCH=20net-next]=20l2tp:=20remove=20u
	 nneeded=20null=20check=20in=20l2tp_v2_session_get_next|Date:=20Mon
	 ,=20=202=20Sep=202024=2015:29:53=20+0100|Message-Id:=20<2024090214
	 2953.926891-1-jchapman@katalix.com>|MIME-Version:=201.0;
	b=YFPYI6TnzBjy2CFs91r5MIBKwmtT7g/24OEo1yLUv/GUAkKVpGHSUuyDJagxWd3mX
	 bm+yc3IR0nOp4KtY5wzYyxS9g6BJ8yxuwZUvxhkf78XOUdQ3I6Z1PbPB/ywsTkzJuJ
	 jsr9o2H90LmYEqVS1Zz4XY3DfLnEQlqLtC+quZGjq/gVT8UHHFc0zNgoZJmPZDAmLJ
	 Aas6ykB0i/n8w+wND+cYwYsrplOZyLTQa2oHYtcic+/wRfzXSODC8AfaBWw7TH7MY+
	 c+Z2f7K8FLnuUfU5Vf3xlH4KRQ4M+fh7gsYcsaiP6ol/e0YJdF6KqcTpwsLv3M+BUR
	 m1/rJVVqLPygA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next] l2tp: remove unneeded null check in l2tp_v2_session_get_next
Date: Mon,  2 Sep 2024 15:29:53 +0100
Message-Id: <20240902142953.926891-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sessions in l2tp_v2_session_idr always have a non-null session->tunnel
pointer since l2tp_session_register sets it before inserting the
session into the IDR. Therefore the null check on session->tunnel in
l2tp_v2_session_get_next is redundant and can be removed.

Fixes: aa92c1cec92b ("l2tp: add tunnel/session get_next helpers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202408111407.HtON8jqa-lkp@intel.com/
CC: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
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


