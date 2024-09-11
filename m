Return-Path: <netdev+bounces-127233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5911E974B25
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC021F28933
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6D139D0A;
	Wed, 11 Sep 2024 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GDbLQIfL"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE58137772;
	Wed, 11 Sep 2024 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039400; cv=none; b=I7k+yccsKQVJ+EX5Z4nmXj7XirrgtmSiUZ5vAXXulCdeFcH0u4FW9aVOSd/YY24HXFnSW/1F8g1pe1ca3gHyRGkSmgwZU4mwRfelMkRfQ1uwOtK2F+kU2DNt7QY4Not2bxML3hSNWE7IEmu8G70wunH4eYUXF6uKseYlAXDwJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039400; c=relaxed/simple;
	bh=cKCVE6fxdH+qkaWTP5lqut/gULnW+AWMnrKhio5+rIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XeAs/6vyxpEkGavUOfaIjF3os3lKhBfQK1dCGHJHTMZcHohxYi7ZbYDI4bJ3Ef2hN9TIiIbYOyrNdI6PRhdiBIZ5Tx9dF+/GlD/Iig2GWvpgStAPrsxHmKLLbcs2dIwGCTYbjV2Z36Tv2LftM9z77oXP66LSliciImKsWmcYnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GDbLQIfL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1D62F
	MWI5K9n6trmzpOldPg6iYX1e0kitJrS+J7UUZI=; b=GDbLQIfLiWPlZ6BMTfN32
	ZftR8lRJj/zmSWnng31dfqOb7h27V2R0RkJ3tFj2frXqaO+rkpw5mf+2R7pZ3xBr
	nkXivU5lFDBy7JIx/Ipk0CMyu8MHr6FRK+mu0eoc8LPouvKFXPwQlLpq38QgenuT
	E79ZTIyx4hTSaiDnDi94Wc=
Received: from iZbp1asjb3cy8ks0srf007Z.. (unknown [120.26.85.94])
	by gzsmtp2 (Coremail) with SMTP id sSgvCgDHlNDJROFmUTiXAg--.1190S2;
	Wed, 11 Sep 2024 15:20:41 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: alibuda@linux.alibaba.com,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH v2] net: check the return value of the copy_from_sockptr
Date: Wed, 11 Sep 2024 15:18:21 +0800
Message-Id: <20240911071820.53888-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sSgvCgDHlNDJROFmUTiXAg--.1190S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFW8KFyDJw4fGFy3WF1rZwb_yoWfGrb_Ar
	yrAry5Ga4UZan8C3yrCrWrXrWUZFsrKr4IqFnxJrW3Aa1FkFyYqws7CrykGr13GFW7CF1D
	Cry8Jr9xA3y2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjbyCtUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRQlXamXAo1zjEgAAsa

We must check the return value of the copy_from_sockptr. Otherwise, it
may cause some weird issues.

Fixes: 33f339a1ba54e ("bpf, net: Fix a potential race in do_sock_getsockopt()")
Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
Changes from v1:
Add a fix tag

---
 net/socket.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 0a2bd22ec105..6b9a414d01d5 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2370,8 +2370,11 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 	if (err)
 		return err;
 
-	if (!compat)
-		copy_from_sockptr(&max_optlen, optlen, sizeof(int));
+	if (!compat) {
+		err = copy_from_sockptr(&max_optlen, optlen, sizeof(int));
+		if (err)
+			return -EFAULT;
+	}
 
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET) {
-- 
2.39.2


