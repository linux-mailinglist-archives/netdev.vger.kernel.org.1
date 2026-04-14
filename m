Return-Path: <netdev+bounces-278270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI4gBv2h3Wl8hAkAu9opvQ
	(envelope-from <netdev+bounces-278270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 04:10:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8705E3F4E63
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 04:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7957C302D09D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3763043C9;
	Tue, 14 Apr 2026 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1nYtCjy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC62FBDE0
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776132598; cv=none; b=q1e6srTTyUPba0sct25xTE+iSA/ALse27WH04VrQtfpsFCdYc0cnXzLd1jx+rpySOshNqhAq9WN9lWYuHAIaFPJYoxKSsyTkB6Vs/vZDG9+mFuFcNNsx0tVOCjynpTdrPCX7sZijRThdAWk+NLITaKUC+Tk5ybcj8X8Kpj407PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776132598; c=relaxed/simple;
	bh=xY4b9wGUIkCrctiEpdGWM1HC1dXk7NDB/lOt+BaRB6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cs61S+QCT/QIdcu51XQGErrxTvE7iyQLANMKwQywgAW2/HhE09Hy1j4nnw81bbPw6nGAZEgDj7NSy/8OFae62qoLLkdHTLJAzujKhD5kqzb/XVguWuKp5iBgZabS4+mXsGg1tW+u+1IO6U/5pkA+lTA/8jbQDhFheoqX5UfGxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1nYtCjy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76b994f7a8so1740714a12.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 19:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776132596; x=1776737396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUZYksfTG/qLw7MfI55z+3Kvxpv1PSmQo+kMyhRoDJA=;
        b=Q1nYtCjy5zZ16XBg63+1sgVSNFEcr8EB27ipZXP0/DmTnJSQi1PeLkOhvybuCTszqh
         csyVgVArrBwTDe3OHSG5S2FH356ikuL7Es/qA0cnvgROCaD1fx4LvrUnprPP3LCB9teo
         uX3bv0TG4fQ2L9EVLfTCUxBo0ta8G0y80GSFTcmrgQDrqBjF7L9/UxjUCFPl10oG7ztA
         4z+Ub9vkcLKtvNtQ7DY06ORxfiHht61xv++73u0yCXsTtEWoniCP8R0kh1WsgDSRLJAM
         eMSmDpj2TXnyXeNITPjMTI3U7gXLw7QtLu6WAZJlrRcPX5H9RDvzEY+ol/GmaMbs7nia
         ajew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776132596; x=1776737396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUZYksfTG/qLw7MfI55z+3Kvxpv1PSmQo+kMyhRoDJA=;
        b=CMdv9mcVH8H87aQCbVjJgWseqT60iL+rOnXIrLHDZ0Onv+2yppdbpFlphBIJ2QBpJ5
         UMPho73dP1JcKlVFaSxBwcmjNbqEyuDB0ruNS+qTyAiLpNBDSEJZAYBdzLi88tkXlmX7
         qjUbcMW8riZZ4SjiV8TT10W+aRhQZgcnakTdr05Qnf6RfD6vNpqPle9Vroq4MPlb7LcP
         zgeC57nKxnW3YLfDRb5QFWgvlkvOEi4eiDm/rNmrSb9qamiVOuN5PHs1MdHIngQuypZ0
         3/EtbOL+qGY9ZknXYmq3o4WgnYP+teHmefrd4PGtk7FHn3UD6XG+T8XaHgYkzvlA3RmQ
         akIA==
X-Gm-Message-State: AOJu0Yx3BJ3s7uBheSZwtOVY5+PIfwFDUuZw8FIX/+b8Cog1oLhQlJo0
	FDrkNxnH4LSLNDBV9CQOoAg9tNEoUW5zEMYeN54lXIe81+6BFTf2geSP
X-Gm-Gg: AeBDiet27M3DPeOIWujNhGdexTM7JhDGB7YIoAXXscLd46mykbE0iE/w1BoVV126le+
	o4+0XgUoL1K0v8tcypbFz5XuHMZVkP9Ewmd2Ec9fuDQ3RjEJJPhASuZFwKpuDtXplfoQfEeG+K+
	DAJI6dHssOojK34wBNDMg6KGNimzTI+SMknoesWzGR7rNDoKOhfFyqhWBLz21UmtuE1l7oSq+Mj
	b3r4RAhW+NJLw874+jUWih8dYxAZ+nc/XMNAwbqJQIJCgs2o5jHDKOGJqUuBq3uXjfowwIVoguC
	G54lrfaagh+pP5hqXH8BOYIbEqPdOCZxR5QXkl44by/u3XoK+gZgsdJfzu7eQGG7KJn+52Vnt8J
	zOPhwaWzg+7nL//Au2DzdheAhGRXDHYwNao1KKDOCV5QVTR06HZZ6ZqFPbqtOl5sEFZqFRLV+Kg
	xAeV8zdJyO6R/RjJ8GyN03rC/5brCB9jijw2gk17JzhPdx3+ygubyv6o2fzTo3cZ0UxoUHkRmHW
	MgCOMziL9+rVZfDQA==
X-Received: by 2002:a05:6a00:3e27:b0:82a:5e9a:922e with SMTP id d2e1a72fcca58-82f0c3a9497mr15921602b3a.42.1776132595740;
        Mon, 13 Apr 2026 19:09:55 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:445c:f4a3:a803:e3c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b6d43sm11297750b3a.31.2026.04.13.19.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 19:09:55 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH ipsec-next v3] xfrm: cleanup error path in xfrm_add_policy()
Date: Tue, 14 Apr 2026 07:39:47 +0530
Message-ID: <20260414020947.65905-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-278270-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8705E3F4E63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the open-coded manual cleanup in the error path of
xfrm_add_policy() with xfrm_policy_destroy(), which already
handles all the necessary cleanup internally. This is consistent
with how xfrm_policy_construct() handles its own error paths.

The walk.dead flag must be set before calling xfrm_policy_destroy()
as required by BUG_ON(!policy->walk.dead).

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v3:
  - Changed prefix to ipsec-next as this is a cleanup
  - Dropped syzbot references as suggested by Sabrina Dubroca
v2:
  - Reworded commit message to reflect cleanup rather than bugfix
    as suggested by Sabrina Dubroca
  - Removed incorrect Fixes: and Closes: tags
  - Corrected subject prefix to PATCH ipsec
---
 net/xfrm/xfrm_user.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d56450f61669..ae144d1e4a65 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2267,9 +2267,8 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (err) {
 		xfrm_dev_policy_delete(xp);
-		xfrm_dev_policy_free(xp);
-		security_xfrm_policy_free(xp->security);
-		kfree(xp);
+		xp->walk.dead = 1;
+		xfrm_policy_destroy(xp);
 		return err;
 	}
 
-- 
2.43.0


