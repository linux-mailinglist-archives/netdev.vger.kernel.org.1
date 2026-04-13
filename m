Return-Path: <netdev+bounces-278103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBdcLacB3Wm6YwkAu9opvQ
	(envelope-from <netdev+bounces-278103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:45:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7613ED7A3
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC1E23019517
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F53DEFFC;
	Mon, 13 Apr 2026 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6zPrDZr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D23DEFE4
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090953; cv=none; b=HxE3uFI/oKmfpq7YncFL7FXQSdRAIJ3LD5dySzgdskUhVmogUCoxLaHYbTjBv0gYuCFaeogfTTPudOXfZmMLopE7owKkkL7tK3fZuhFokiGaFgax+ADFRRzdB8G/UQGuWQ1Z1u6degSIPWxGg/wBFOl3/UBp+KElx6RmrqPZCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090953; c=relaxed/simple;
	bh=RSrCNG/jSsC+2RvWQg4pk6F18HBXNA8Td83Y0Dd9Y7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJqqNb6OVo6TfJ/Ff4m+o8mQWIYbWUILAcfhjeNXqEe3b2sqGTeGNtZESE2NN6iXjyX/jdALoVxmCDn+dB+exo/RDEGVRDMB49aPyJRhRpWsDgGSPx5Mxeq+O4KiXo7c/rB/pbyB2bZ04wWn8ASywTTgvy0DI4/017NRzhZYnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6zPrDZr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a871daa98fso28958135ad.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776090952; x=1776695752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cVGR3lOaEt4DscUJt6yEjkNKDke2mjxaMUyXT8HBxYI=;
        b=O6zPrDZrop1xzpZ3HC5A0jhO3nHBMZfQJtz3M+h4Qw19frgsYTbA/OvplBKsmnHNiL
         oAr+GVAlOsUtgHm0ZAlqNZEpiYeSAANLiHg5iy9xs8UPUcVJohm92OH2NIstAbT+KYLo
         GKKJhnQJwAswMIFSQL1vq/vi8XRodGC1Fs7TRKOvj2/XWc134GyW3cDZzI7G8bXWAQCi
         dV/3CJ7deTLdWRrS81Kpx5Ur1i3D7UD8A8o6XD4S+bTyVXlrfO1ngDs4iChiKkhbnugF
         hHJfIqgQEGPCyVvAr/02hB1VRRfj3BK8v/JXiLvn2fq9tRdCgMGPi2nGUJ2NDnWlBqIN
         C0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776090952; x=1776695752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVGR3lOaEt4DscUJt6yEjkNKDke2mjxaMUyXT8HBxYI=;
        b=g5fv0H5lMIoP0s8EPlsmmJj+BU+QX3JEa2nzxNsK50F5JEeYyae1WrYYM/akMOwebI
         i3RjntJc3777irOPX5tU0HpUYtZvlPL2wjDHDu8bc8Oj5G7J5g3qCbaOposMvlhmOpcK
         Bb8rokKQtWRn5OMCiKTC/QXzceQtCF0lh4onqJ4YUtY5dLRBmAEQ9XFFozEWO8QkR3lZ
         W5Lu9eih5V/KtTKYrYNPsgu8fTbNvIu01L+HpcDYBriTm+RyrP4ztEzC8PmNq+pQ4vEJ
         uN4xU+9ZXElCITNQXAVt3WfBFXMlDmqLZWW8c1DAQZsUL2s3Pn+Mt13oM46GicM0L/QD
         gS8g==
X-Gm-Message-State: AOJu0YxkbuiE8yHtPpn5CQli7Q9t1DvUtnFJFad1G2bKCFE7BL5JF/hG
	OM087r7oZDNdGsBTk9ILZ5wgJgdwY0sFm0Z2rjLrf2biIKgk+jxKPn+7
X-Gm-Gg: AeBDieu/LzJCjX+8ASASdWCxLU94K4fwJfE0rW+sscnTEnVy2q7o9YdOH03kOf2CyXu
	ZK+DcDULDocEjXKSSzgOUaG8+xdCqg4djOSqde3Bc8e3UwZjls7X4yBmp1VPTFzlFZ0xMlbW3Mk
	VQGyYXYicfdzAC4Ee0a45v7JAtjZSQBVC+o43ntHzoUD8kC/InWqZrXakoIWueDPtFOElwdizcR
	7UiFAK7rGawlV6kzSfo65oGILaMR8dO/xillb4z7zAk7lbAZX8f9Huo/Vta/JBkLSZgEWQ1W2bp
	Ucg5FD/0skw9Zl50O2w2c3y1VNrBrC980xOPUh2Q+UVN1BvxfMCheSdjM+aY0GMVZcLz0bkE6ls
	fMWqSGidDLWIewwM/DaDa1+ThERPelZmmOjXN77uEg4jH41Jh5L+8ZWLbhTCClWNz776of9Du38
	nKcPlWLQfTRh46rgr9IHe0t1dcI/pkVwMCj8HRF9yhAT2D9/kySWzNWnLOfwbSOxc2vxzs73zGE
	DTED6ZxRKI50tY3
X-Received: by 2002:a17:902:76c5:b0:2b2:470d:6d0d with SMTP id d9443c01a7336-2b2d59394f8mr92244775ad.9.1776090951436;
        Mon, 13 Apr 2026 07:35:51 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:ea9d:65ca:a4cd:ee0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f43994sm120551535ad.80.2026.04.13.07.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 07:35:50 -0700 (PDT)
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
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+901d48e0b95aed4a2548@syzkaller.appspotmail.com
Subject: [PATCH ipsec v2] xfrm: cleanup error path in xfrm_add_policy()
Date: Mon, 13 Apr 2026 20:05:42 +0530
Message-ID: <20260413143542.52134-1-kartikey406@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-278103-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,901d48e0b95aed4a2548];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D7613ED7A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the open-coded manual cleanup in the error path of
xfrm_add_policy() with xfrm_policy_destroy(), which already
handles all the necessary cleanup internally. This is consistent
with how xfrm_policy_construct() handles its own error paths.

The walk.dead flag must be set before calling xfrm_policy_destroy()
as required by BUG_ON(!policy->walk.dead).

Tested-by: syzbot+901d48e0b95aed4a2548@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2:
  - Reworded commit message to reflect cleanup rather than bugfix
    as suggested by Sabrina Dubroca
  - Removed incorrect Fixes: and Closes: tags
  - Corrected subject prefix to "PATCH ipsec"
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


