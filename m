Return-Path: <netdev+bounces-127196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5518F97488D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5D3B233A3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD923282EE;
	Wed, 11 Sep 2024 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KmQG9QV4"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF4AAD24;
	Wed, 11 Sep 2024 03:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726024745; cv=none; b=Wx+uNBDk15A3jysuFIk4vNdv8wp6adu9Ja2rz5QKNha1lpaew9MW4zJ6tv/DcIOQNAHiLN8vBduNFFQkdeok0kRuuU8Tj19pab1wqawbOVqvjdYAcIKIL4N6nSBbe9TSO32JU8zJ3Nc1wZO/pUqjbJJXO1igXKyQMeDAzE7kzto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726024745; c=relaxed/simple;
	bh=DADXaN0GIvH5RP/RL4GpJZhFaj4Izo3dYucAmkcJ1q4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tua0RMc03Rxzjh1rZ8fjnfExnCeYq8o3K03B09+mVveEEDOxD17QGl89V5VMIfBLRynjhanSoFO9lQb84BdA52ihi93J4yQxqIe7mI4m3EJzHRmHeGYY2E8nTGPRNo6uQrC9bKmo/V/bMTpsD56WDIuKMwKhktPMOYlByaJiTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KmQG9QV4; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=NCpeqR1K5cHYjuSdgGKlaa6YEWw7IT3OlpHPPl9Jo10=;
	b=KmQG9QV4tbIsfxm55JpX588cIjEzKYeW72JRTfi0xohjLFjc0U0f0NeEF4iVv1
	Gi94PImXMpqsREBXEmKIRaTw+uY91n1jf3e0mZaGyh76gOtrxhni6V0BATPIi/GV
	C/8fJ540T9PmdBfWrAta3Mba6qPlYIYEIjhZzUf+26LD0=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wD3f2LoC+FmuhyiGg--.42294S2;
	Wed, 11 Sep 2024 11:18:01 +0800 (CST)
Date: Wed, 11 Sep 2024 11:18:00 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Should the return value of the copy_from_sockptr be checked?
Message-ID: <ZuEL6LhQ8bszGRdk@iZbp1asjb3cy8ks0srf007Z>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID:_____wD3f2LoC+FmuhyiGg--.42294S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrXr1fZry3uw48GrWfKFy3Jwb_yoWxWrg_Ar
	yUAryUWFWqqwn8C395CrWrXrWjqFsFgr10g3WDAr43Ca1rta4Ygw4vkrykAr1UGa4xZF1D
	Cr95Cr9xAay7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUepWlPUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYAdXamV4JKb83wAAsm

Hi,

Should the return value of the copy_from_sockptr in net/socket.c be checked?
The following patch may solve this problem:

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
Best,
Qianqiang Liu


