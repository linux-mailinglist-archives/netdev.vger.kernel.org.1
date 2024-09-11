Return-Path: <netdev+bounces-127221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB6A97496F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526C12886E0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800564502B;
	Wed, 11 Sep 2024 05:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mc6KNXpb"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE06748A;
	Wed, 11 Sep 2024 05:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031193; cv=none; b=uALGhDmJyKRaDeHDOdSvaK9lUsqrOI5GSGpth1O57z0rVtA14jKfwugQifTYasSSq50s7G0DzXOnsdErbyJ5/vJgWcJ2KbwmBBuhx+YnGsFln0rMs6UEnrSXTCKkS+LM1NoMTOUq65iW6EKAkD799MHMAM3YZNl1wRqA0LZaKJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031193; c=relaxed/simple;
	bh=QIVWthblxsOmuAkjr/DixC4qkE6h2wSBSIUF6PCcJXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iPtsZ+Rhy2ZGLdFTlhiXnuq3Al0xEbyovV93+Bxpujc241EGmhdCem3RgOzatuDqYBI/mivAdZ+t8dAJmpj6R9JEJujQESB+lrKebEGw/e6hblUXYHpXjCfRWQonWAMjPJwi3xNZSZGdqmM6Z5QdfKb4/zWBRubHuRdQ6+RH/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mc6KNXpb; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RHQak
	gvG3A9w2NFidR81nJeGDsLyWnLUevuzvDvH+/c=; b=Mc6KNXpb7om8aaaYq3423
	jeROAqYjnmgKNp9BlltVZR4ISYwErFAyaYtxNzHabfmHDTKmgChY/TtIfYrhHLF4
	Sg6RXKda0J5070AjIrezE/N9sVXoOKsfXwofqzJAqcx3SMWV1parmlyp0O4s0Nob
	bFvkv9gjfTxZt8L7xjjymc=
Received: from iZbp1asjb3cy8ks0srf007Z.. (unknown [120.26.85.94])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wDXn5AuJeFmxLGFAQ--.60514S2;
	Wed, 11 Sep 2024 13:05:51 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] net: check the return value of the copy_from_sockptr
Date: Wed, 11 Sep 2024 13:04:37 +0800
Message-Id: <20240911050435.53156-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXn5AuJeFmxLGFAQ--.60514S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFW5Zw1rWFyUKryftF47Jwb_yoW3GrX_Ar
	yfAry5GFy5Xan8C3yrCrZ5XrWUXFsrtr40gFnrtrW3A3WFkFyYq3yvk34kGr1UGay7AF1D
	Cry8Jr9xA3y7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjMa0tUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYAdXamV4JKb83wADsl

We must check the return value of the copy_from_sockptr. Otherwise, it
may cause some weird issues.

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
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


