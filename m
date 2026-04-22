Return-Path: <netdev+bounces-280286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMOhJIwv6GlHGgIAu9opvQ
	(envelope-from <netdev+bounces-280286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:16:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF54414BF
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C85343016CA3
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D19304BA3;
	Wed, 22 Apr 2026 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvzQa0ry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A941A9FBC
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776824145; cv=none; b=RQMBO2h9zJvJgJdAfb6y/KLmyYrwH4fPQZ3IjVqKYqPH0sqpUUXumw+W88v6FQn2FUyzhs5fZFknK++kKWjepN9FjcISFTkdPOEcFau2ztX5uCd+3A3BUA77eq63IYAtt5q5hfrG/lD7nwlVw1qIk281wzPigCta+rB1MU2fiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776824145; c=relaxed/simple;
	bh=RaoS18NQ6ormUMAZohAhAbNG+kw7Dwqeuj/gOMWHJv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwyDbauOqteNCvOXun8GPhWdgkJUIOUHVGqkWT6Nk1Erzqw6S5/LcxsYoyGmz8IG8S6rmdDcuIMZyG+z6A/p5ON3hMP0+07wNMV5guOMQV2zo5DLVcpAab1E4WFHu9ZiVkR9h277R70hVCnirf+Bw+w1ud79QBfFRPinhF4f1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvzQa0ry; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso2982772b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 19:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776824143; x=1777428943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q+ZGgRpaM6gIFlLsyQEgm5dg/TZd90+yNvNU+V/yubU=;
        b=jvzQa0ryCkfTFujHDF5A415yxa8DV2IaZ6ak9FcJYqHRWpWR7x6sGmGTks8VE08lyu
         14J6N2gpUOKqbxB14IEACNhHALZyE8iBpbmcyvUuggvYnkSd/WdiAInA4+hcW4SSCGwM
         DKBYaDAt2Gosxubp02jO35iX0WfkpymGUFRIo9ouDzU7vXuEpr2ZDVCgPfUVGFdcjWUp
         UsvVn817cWQt2Ml03YyGLwx2BNNisP0JZyIgQ+OmtXHUSLMrm0rVz33Q6/yToJqAtglg
         gYARdQ56GWiln2kNqpSCLt2w0YeBWLVqN8GRu5i8SxXKGKhvXDDXNS6Fxa88K3woTF7R
         1wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776824143; x=1777428943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+ZGgRpaM6gIFlLsyQEgm5dg/TZd90+yNvNU+V/yubU=;
        b=Jm1c55HTTU7lB0mlPlWb5mp8+Fc+usJ7gXzBXeqM/OwcZ5rTbTGDvVE1D12QzZSphf
         eqpsn2WRH4uUY8LNIqugdVZKJTgosqvFM8rzh3ECIqJGlWFgWS5SlzBVbp4uLU2oX/zM
         Lnwqfb6O+mH9TbOr9ksOh2a90qcs1C/AB5KFKMSqFisFOg/Iez4YaTqnoAekilCuoivk
         OHDKaZSMuCHRJeI04Z21NasCupuqhNwTv/0C5WUTLo2cYCtJywa6wxcm5qTRkcnhOKVr
         13MhOwdUbilXa1wTKzscgGVOm7AJDRJqx4RWMJIbxaBttTXlUHGlpsV+Pwu6GqGBwvqQ
         yOdg==
X-Gm-Message-State: AOJu0YwjT8zlD0G7lOiwegucxQsCxu7GH6J6ZakyahhtIpl06o3ib0sP
	TdhiLUeRXIvR7ntCmenNZtUwA1xQO0hsjr4+bSUuh75Hg/QUh/uie17J
X-Gm-Gg: AeBDiesubb1M1SXOZy877Ur1/pKhouomNBpMmT4Krh55E/YE02+fdnhJSCdfhecq5dI
	RVBssrLrYTXZ3CIhbJwIcK9CXukYsqlDNQWlZLotXQlOQ8iZCsR9wWwOFvVSg5rURIZf1YagEcs
	HnLQa+5Sf5UhpU5CK+UdWjC1Lje6bh1km/p61BHb6Q0w9pJ8rfmKe0kgoM5VLbZqiUN5sv+15PL
	XktPvBWj9t/Rp2s7LBPxluFSpJ8t50xXWBpb1juGOyCwOFyHF3kOXBgvx6C0yq5euuJL8EhhAT5
	JZMnXUojPVEgHFvDad806/RvRrjMrX3ts7TTApy7OOArMuM13fvqbAUv5uuvcuYVrbAUps2D5Sg
	8GQls5QOyMbq3lqA6EPYR1ggwvuoriMXY8sSEzNO7nWd1MkgWAUBI110SPAMUT38VsGH5aILzrp
	PkiLFYGVS7bmSEDZZMOMQ+VG1NKXtkf4c9/jO9prERe6rnnT0/eV3E/No+jIelxPcdqDmZl+NJx
	vckAm0dAULlid/2Rg==
X-Received: by 2002:a05:6a00:4b01:b0:82f:49b5:cfc3 with SMTP id d2e1a72fcca58-82f8b551df5mr17378366b3a.18.1776824143126;
        Tue, 21 Apr 2026 19:15:43 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:6adb:27a7:d382:d9c9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec24850sm15689255b3a.60.2026.04.21.19.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 19:15:41 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: courmisch@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com
Subject: [PATCH] net: phonet: fix BUG_ON() in pn_socket_autobind()
Date: Wed, 22 Apr 2026 07:45:33 +0530
Message-ID: <20260422021533.16987-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280286-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,706f5eb79044e686c794];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: ECBF54414BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pn_socket_autobind() calls pn_socket_bind() and treats
-EINVAL as a signal that the socket was already bound,
then uses BUG_ON() to verify it:

    if (err != -EINVAL)
        return err;
    BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));

However, pn_socket_bind() returns -EINVAL in multiple
cases:

  1. address length too short
  2. socket not in TCP_CLOSE state
  3. socket already bound  <- only intended case

When -EINVAL comes from cases 1 or 2, sobject is still
zero (never assigned), causing BUG_ON to fire and crash
the kernel.

Fix this by checking the bound state directly via
pn_port(sobject) BEFORE calling pn_socket_bind(),
eliminating the ambiguous -EINVAL interpretation
entirely.

Reported-by: syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=706f5eb79044e686c794
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/phonet/socket.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index c4af26357144..5a55e7d14e85 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -204,14 +204,14 @@ static int pn_socket_autobind(struct socket *sock)
 	struct sockaddr_pn sa;
 	int err;
 
+	if (pn_port(pn_sk(sock->sk)->sobject))
+		return 0; /* socket was already bound */
+
 	memset(&sa, 0, sizeof(sa));
 	sa.spn_family = AF_PHONET;
 	err = pn_socket_bind(sock, (struct sockaddr_unsized *)&sa,
 			     sizeof(struct sockaddr_pn));
-	if (err != -EINVAL)
-		return err;
-	BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
-	return 0; /* socket was already bound */
+	return err;
 }
 
 static int pn_socket_connect(struct socket *sock, struct sockaddr_unsized *addr,
-- 
2.43.0


