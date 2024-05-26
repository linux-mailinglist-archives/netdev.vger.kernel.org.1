Return-Path: <netdev+bounces-98088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2B58CF4A6
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC65281138
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CC4171C9;
	Sun, 26 May 2024 14:57:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D06171B0;
	Sun, 26 May 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716735467; cv=none; b=UPgHGYMuditHdZEBYwxK+6oGK3NfeZ+jsqPn8L4DhZqgT/IQdLanEXZcoez4Z414aKRIKgCnxKzp5bafKFG1m1aK3m2pwGAPrvinjUrAuOSSDzmAMZON70op+srHixQlbR7sc8iePK4Pc5y3FawVA+HADJBQwepY481NO8vodtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716735467; c=relaxed/simple;
	bh=AWuyBa9xPCLRsgOsdytfGSl/rbd5PD3DKk+m9xlX1hE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MkDJH4RZnUYw1FV2capL6XayIos6VQayeg9KU0QlAgc2Tutootamlv5WDOCzeNtYA4Lky/fBGZrk079nu+bqDVIdxZjrxwhLnIeenHjgAbQcaTKJXSXMFK8Z+ZwLHb37kICXJpgsYzCSPJr7Fq7Cer7h/c1QRf3OPSetwZG1FRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp90t1716735442tmrpnru2
X-QQ-Originating-IP: d19yNXHlKFhMn1jXpxkUY3K5Jw8/ed9ZnmhrIZ9gsXM=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 26 May 2024 22:57:20 +0800 (CST)
X-QQ-SSF: 01400000000000I0J000000A0000000
X-QQ-FEAT: QityeSR92A1kDI7lTOharDXzqe3GCZqJ3snE2fLcyD6KqoFxCw4zW51Me1aIu
	ZP6gz0Cazu36eZxWlwU3u8sBNlXCy5CdrE+Xoys4lg16NxMc90Nek3j9UQbJqWOf3V8ypBM
	vJjQ2IqEuX5jq8/wo0E3HWWJY6cTOrPR74N14KaDdMx+ZAcSWkMYe9iwkbuQl+W/KbdCR0O
	lX+kJWTFeIQxFTiz3VOQh+xZAjO4MADzPG5CV4AgE71vKgJtVIvvSWUzJFWNsqlLXSo5HkR
	rR6AY0U0EisXgyOlSwy54b8VeoUWs3QMhmB3odsPCT5XyLQ2eco0QzuQnSFvk0iMyVh702c
	bcKoPDg0fWhs+/MP6d1cJy8xB+oAd8/o6pDf4D96GIyZsQggIbQuP2Qc8aqeUOnLHDU8Gw2
	KQ9t0fJc1jY=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 634043123438159302
From: Gou Hao <gouhao@uniontech.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	wuyun.abel@bytedance.com,
	leitao@debian.org,
	alexander@mihalicyn.com,
	dhowells@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	gouhaojake@163.com
Subject: [PATCH 1/2] net/core: remove redundant sk_callback_lock initialization
Date: Sun, 26 May 2024 22:57:17 +0800
Message-Id: <20240526145718.9542-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-2

sk_callback_lock has already been initialized in sk_init_common().

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 net/core/sock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 8629f9aecf91..67b10954e0cf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3460,7 +3460,6 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	}
 	sk->sk_uid	=	uid;
 
-	rwlock_init(&sk->sk_callback_lock);
 	if (sk->sk_kern_sock)
 		lockdep_set_class_and_name(
 			&sk->sk_callback_lock,
-- 
2.20.1


