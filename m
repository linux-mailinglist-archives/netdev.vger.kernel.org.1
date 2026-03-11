Return-Path: <netdev+bounces-266432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOuMNmzXsGnLngIAu9opvQ
	(envelope-from <netdev+bounces-266432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:46:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4382A25B1FB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 148E731D88AD
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9726355F37;
	Wed, 11 Mar 2026 02:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzdueDN0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D434D390
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 02:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197093; cv=none; b=gAUJlXTKURYWtjYcK2YTWu+3TQbOfaEEk2NSGhjo8Ey398vkU7ekyQFFU+yeiqtgPJsnn/Cv4U70OG3OjMair1MZUQSv2Cd29r7hlokJUOXt7olXiJNKzdY3WuUoYPpxnCY2mC+/q5BOYgXUyTv6RTZOqqcaFjf4axxqirZS1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197093; c=relaxed/simple;
	bh=AzxKAZm/nl7pcn7SMGa+wkaWx2pzjLH+P7jHPWrIvAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CyBlXmlWSe1gYzEiua40slZaGRg9pt+SpubTI9XTj+ztpLgSniwKPJrpasmuyp4uUGyI480xYClRcDXs8vIj8vBLzM2IpF0at3Kx6wGPzJzf1zM/UMn2qVQtqstGl+Ct0rJNPMTNZMYrGDiVYtSRvtC/Mk2MriMFyTHIVcZ4VrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzdueDN0; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d74c1157a4so2572798a34.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773197091; x=1773801891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+q0dNvBbupC+6tyHU0OlnBS7KtJOe+yMxAJG2X59mY=;
        b=TzdueDN0lHuHBy6DsiK+fCmnhKZ2YDwIZPrN9+ZW32Lg71SMn6w2PetwFqbia/gvpY
         iQdYgzuUTXAlYvLwNf7MxTBo/5zMCOEhCwXeyFYZWEY/QcsPB2Bv5Z2djygKO9JOBXtP
         7DKAnXSQ0gBfx7207x5fABF3GGKbtL5/hJzy2g48vle3vDWlHAk0RNhM5ZdIcCUeijdS
         1/uR8PYDxyIbj4muPOtxCCpbD0KIQzE2+bFiqilUI2/SNLubwOwwNwV5cxEZZs4uRgLA
         V/FPy3LyyjBMUk4518/F8QWC63c6GG01mMJr3E1SCzX4030XhLrEO9TTWAvh89Xdxf4T
         YNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773197091; x=1773801891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+q0dNvBbupC+6tyHU0OlnBS7KtJOe+yMxAJG2X59mY=;
        b=PKpNvXt9/5LtxjC7uY8MhLFBxqWXSHFXbGc4GtVQhzEFfFVfTwFkTs9IW6v9PQjiCx
         ZMVThHsC1ya9FEVi4OZV7QgWl7Pdx9vBSdxqmJWv1e0cQV6abp+948vYxNc+VdSMbH41
         FRwYKqSz9Jt2XnvERpTFFow3Y9SUlGyRfdgKFrsDwmo2F1etofprYq2NllYEbUxb1ZM7
         V6qZxiSIJ3vw5GnUdzH6Z4bv/B5M+uI+8JkmkHhZzcUmq8B7Z5+gEn8fXzfMF3fDRUTT
         iyhj6Di5xwWubmYpOD/LU/Q/cN11sl/26PefdVm7TmE2kV2iwFvmj/p1hnvvGf2RnVbD
         qlng==
X-Gm-Message-State: AOJu0YxWxWteBDS98DDsIEfIgeSz5HCMvzw0sZHhKjoxpBfYbh+j4HpF
	Pxm0v8TESCjJC0CR8WxLnyngl57Tkd7YB3VD/ZmZ6oObd/ZtO/rOMHfMbZ7QP/1CvAA=
X-Gm-Gg: ATEYQzx6lQ7olJr8sCCxie8n8iLr4VbFUye6KYDNL6R4qwoSnWIRw5comluZipYbTVy
	G8KnLoe+1LD4m4TqDuWOzH9LqCQOK7T552pOHvXLsArLE9ZRyO9Ef8HIVSlzIM631Gk6xmkLPMW
	T2h90SF//KrZTISRBBH1grjNHwlgZwPyXvipJGO7Mn/YnoYJdFYUAv+x47SS5QyeZt4mAcTqpbB
	b2oXShbFFcvlthZU4aIygEL9miAC8mUbZj0ddBAViK4BEAW+TOU9qPsE7Yeldj0u1iRbOmhPbuW
	q7LkE0a9oHyWAhgpvOuPIbi+0qgCKsiTR75+KQdjDvPKiB20EIPfBJO7toCfK+LKLZXy4SrrsxR
	gosG6HBYaTOOH+bpN5CK8xUUDIk4NksV59vFY2psApjknM0457dUkS4Jt16jSNCjIEO5mymNtmY
	2L1X6rSr3oynrcpdwCLp167tmSYMh2Jzdn/wQ376Z3ZP6hOhDtnxlFGPIrHtuRkr+t0zNIZ2WA6
	5D5URxy0JvU
X-Received: by 2002:a05:6830:67fe:b0:7d7:3c44:c80 with SMTP id 46e09a7af769-7d76a60ac0fmr822844a34.1.1773197091416;
        Tue, 10 Mar 2026 19:44:51 -0700 (PDT)
Received: from ShravyaPC.. (r74-192-25-180.bcstcmta01.clsttx.tl.dh.suddenlink.net. [74.192.25.180])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae398fcsm691944a34.16.2026.03.10.19.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 19:44:50 -0700 (PDT)
From: ShravyaPanchagiri <shravy112@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	ShravyaPanchagiri <shravy112@gmail.com>
Subject: [PATCH] docs: octeontx2: fix typo in documentation Fix spelling mistake "Crate" to "Create" in the documentation.
Date: Tue, 10 Mar 2026 21:43:11 -0500
Message-ID: <20260311024312.6760-1-shravy112@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4382A25B1FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-266432-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shravy112@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Signed-off-by: ShravyaPanchagiri <shravy112@gmail.com>
---
 .../networking/device_drivers/ethernet/marvell/octeontx2.rst    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
index a52850602cd8..c31c6c197cdb 100644
--- a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
@@ -323,7 +323,7 @@ Setup HTB offload
 
         # ethtool -K <interface> hw-tc-offload on
 
-2. Crate htb root::
+2. Create htb root::
 
         # tc qdisc add dev <interface> clsact
         # tc qdisc replace dev <interface> root handle 1: htb offload
-- 
2.43.0


