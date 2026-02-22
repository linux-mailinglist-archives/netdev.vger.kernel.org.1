Return-Path: <netdev+bounces-259900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALFEDwtem2nyygMAu9opvQ
	(envelope-from <netdev+bounces-259900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:50:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBD6170389
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5339301104B
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 19:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBC535BDC2;
	Sun, 22 Feb 2026 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="00yMW7LR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8685335B653
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771789822; cv=none; b=pcbmRjBuB6ob1hzhu3o2mjH4j8kgF5c1UEbKoZWtnQRln5bxE9sRQOCyxlrlbDtinj2W7OxwlokXkmsukn4iRllMxdRfXIKiOcPz7EPC6rxNdN5e88/tklffVkLvu5FEIPqpeqCAwI2FeIaJxt8v7Q/vGBRfUAeGdrb5Zxzl3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771789822; c=relaxed/simple;
	bh=ZwmQYHiDr7xQzle7KqXq8ohshoL0zKCKdA+gTvnaiaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XEB5Xm/i0DCWigg1xUlTxwFCD0hzpPHQZSHg6rejhz0Egab3DEoiVhAHINr75vYdwGRlhrZlK4b8xyJ3DnZX9Ty3Hy8E87bJDSJdVWE50yXf2bToJleQ1a75FT0ic8pTYDGIxJ/YPOd837wsVQfYHYG8sPNRjF2TJVbcwXkgA3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=00yMW7LR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-356236ae3c1so3335037a91.1
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 11:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771789821; x=1772394621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOnCVz923DOBdFVxzFU4usffEhsqsbbjXXkBae8WVew=;
        b=00yMW7LRnMmsQTORbka0cUramO9BTE7IaNtFBWHC2bRuSzljy+BmG9Hy/V1qxSHDIO
         zcl8aepvDSYyx5+lmiEfecX98BI2pkUkNRdoAuJGD/X1eeXCV9KhC0ueiqhq4NTqx+KC
         wvuEN3RumzUvrcb6oGwzYly/fKtnA+hxGsu26mqt1qssFag+AA/tLwD4O0RLacMVMmG1
         Ldlxou5VNFgeWrN+ygTtal9ihroG1qzeZS4F8kSh0YaRhIK7E/HvxHGUunOWdzMq8BIw
         GPDG4l/8MaeghfBvp6VDoifMq3Of5Cixd4DRROJShkIjHBhwn0Mhxdz5D0JVZAlhVCBg
         A0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771789821; x=1772394621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOnCVz923DOBdFVxzFU4usffEhsqsbbjXXkBae8WVew=;
        b=tZ3gZnaT4RBzTaDg0C77P2ZLdsRb6BKx2aXj9fIW2TMv1Ja5g9OPDUmcfEz0TkrYEM
         N9c817IBOr+2VvDmNyWInTRSctnD4sMFAeyEqRqnKlXjtcpDGBpwCyh0rrM2g+Pf4HYf
         Aa+EzIC1ZxcpFb2CMb3q3aYwoVlb81FWWQpy1+8xF4fu8CBAH+afNe+IKCjN6J4RS+B+
         /r1Rd/2E9Rp0fe35AKrOazxuTdcz3fe+qeXWl0x6yud5F0z594NR2Qn/DzXgBhuxKhbv
         9yxBCq1YPVSsLWI6Ucktsevrn9iNx1qnXGOr0gYHHQ0pmHRVDlmDItzzz0ek6Qo5KgYR
         HDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNl1Kr8EA9PBYqLMGdxgot00f2l9zv5BM5OV/2l0G/uJqPng2W7AkarNnONhkb6ervrwrG1JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXej/bnA6VucfWLU+GuyLXZMTGic2iuaKZj06MuJAMGho09ym
	rQKCWYwAXkWOW6Qf9fCosjgSM4HKaNKA3Dh3S0jrJ2dmf7/hE4FdEaE2M9MGZO1IiY9WeWrG8uV
	/noPbQg==
X-Received: from pjboi14.prod.google.com ([2002:a17:90b:3a0e:b0:356:4888:fe61])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cc7:b0:34c:ab9b:837c
 with SMTP id 98e67ed59e1d1-358983a8b41mr10553039a91.0.1771789820667; Sun, 22
 Feb 2026 11:50:20 -0800 (PST)
Date: Sun, 22 Feb 2026 19:50:03 +0000
In-Reply-To: <20260222195016.705157-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260222195016.705157-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260222195016.705157-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/2] ipmr: Fix mr_mfc.unres.unresolved corruption in ipmr_cache_resolve().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259900-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FBD6170389
X-Rspamd-Action: no action

mr_mfc.unres.unresolved is filled by skb_queue_tail() under
spin_lock_bh(&mfc_unres_lock) in ipmr_cache_unresolved().

ipmr_cache_resolve() is called from ipmr_mfc_add() after
releasing the spinlock, so nothing protects the queue.

Let's use skb_dequeue() instead.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 131382c388e9..62fe54cf7705 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1002,7 +1002,7 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 	struct nlmsgerr *e;
 
 	/* Play the pending entries through our router */
-	while ((skb = __skb_dequeue(&uc->_c.mfc_un.unres.unresolved))) {
+	while ((skb = skb_dequeue(&uc->_c.mfc_un.unres.unresolved))) {
 		if (ip_hdr(skb)->version == 0) {
 			struct nlmsghdr *nlh = skb_pull(skb,
 							sizeof(struct iphdr));
-- 
2.53.0.371.g1d285c8824-goog


