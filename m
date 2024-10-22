Return-Path: <netdev+bounces-137806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3679A9E65
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E765282118
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FBF198A01;
	Tue, 22 Oct 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="KXIeTcpb"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147C195FD5
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588991; cv=none; b=pv1UDJptP0xQyyiUOFynzSxLJ8Iv5lRD0OalWNzJsIaosSQqil0LPINq4f+OT/9BY7OxxJ96e/W5HQEZzNpEvzkRpf2OciQsRbvFr6otHwT6Rga8czaUABeggwob58bhKA2VCAfJlHJCuT7n07D27k3M1nZOISrve4bFcN8UmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588991; c=relaxed/simple;
	bh=pJARG6fK636+xSWOyG8RpjxTo/j6ZqZtQBkqnkA2Kko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSS2W/N+a0GpzLHbZi3gxAhCYscpFawjM/QmGk2avXxqgzf8kx5smId/7QccZ/gLnlTmHA1RlAAnmEhzhax097XAmDr8TnWvpVnHbYriSUqqjtABeV79pZqhiFu3WZ40l4VY0Fgmc0TDF1d4R9R3lCcZzu/WCpeCksXtl5sRrOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=KXIeTcpb; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A702220842;
	Tue, 22 Oct 2024 11:23:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ePTr-KuQDmSf; Tue, 22 Oct 2024 11:23:02 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 183B22084E;
	Tue, 22 Oct 2024 11:23:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 183B22084E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729588980;
	bh=IwcD0yMiff04v7tB/JvjGTLdIMViu7gMgJOoGsFL3XM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=KXIeTcpb4OoO8XpseGR0kwqnC8OuUnF6iYkYs0X7HfcT+Elu0ejsJ27ikez5RHUnC
	 4kQwMFpTGt22fNpUdiWM5qGEJeRxesl2i7deE4EBPbhtrgCxikU3HDYoC/2EJlne49
	 CebkU/KyxA7UY+vdMYJ/W/AJDhax4ZM7tbDa5K98/26JPxkC1NYCQnr8YGGuthVueV
	 +lqAsAniYYlh/EryZVZLbuXWe3gY5Tpx8hza89Yiu4TbbZ4iD/Gc5eTUEfGuYV3Cs8
	 Yfscf9Ggw/9Gfv8oErflJq0ubGile+7IqHJ5gWhBKLOSDKOMlLzva1A+qj/DyIYYFY
	 mMfxZ+7iwqw6w==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 11:22:29 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 11:22:29 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 18DCD3184C8E; Tue, 22 Oct 2024 11:22:29 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/5] xfrm: validate new SA's prefixlen using SA family when sel.family is unset
Date: Tue, 22 Oct 2024 11:22:25 +0200
Message-ID: <20241022092226.654370-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022092226.654370-1-steffen.klassert@secunet.com>
References: <20241022092226.654370-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Sabrina Dubroca <sd@queasysnail.net>

This expands the validation introduced in commit 07bf7908950a ("xfrm:
Validate address prefix lengths in the xfrm selector.")

syzbot created an SA with
    usersa.sel.family = AF_UNSPEC
    usersa.sel.prefixlen_s = 128
    usersa.family = AF_INET

Because of the AF_UNSPEC selector, verify_newsa_info doesn't put
limits on prefixlen_{s,d}. But then copy_from_user_state sets
x->sel.family to usersa.family (AF_INET). Do the same conversion in
verify_newsa_info before validating prefixlen_{s,d}, since that's how
prefixlen is going to be used later on.

Reported-by: syzbot+cc39f136925517aed571@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 55f039ec3d59..8d06a37adbd9 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -201,6 +201,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 {
 	int err;
 	u8 sa_dir = attrs[XFRMA_SA_DIR] ? nla_get_u8(attrs[XFRMA_SA_DIR]) : 0;
+	u16 family = p->sel.family;
 
 	err = -EINVAL;
 	switch (p->family) {
@@ -221,7 +222,10 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		goto out;
 	}
 
-	switch (p->sel.family) {
+	if (!family && !(p->flags & XFRM_STATE_AF_UNSPEC))
+		family = p->family;
+
+	switch (family) {
 	case AF_UNSPEC:
 		break;
 
-- 
2.34.1


