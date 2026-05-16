Return-Path: <netdev+bounces-288605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJQZI9dCCGqugwMAu9opvQ
	(envelope-from <netdev+bounces-288605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:11:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D255B0FC
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C7BA30158A8
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DAB3D3D1B;
	Sat, 16 May 2026 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlFd48VZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6213D3CFD
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778926279; cv=none; b=ZgeaQF/l8NBMplBoEallUkGcPmh6YnwzES8fEbgRklLhgfh3GJOVJfjVsG1UJwZu+OMUMZc6JTjlPJa8u7oduNGnKrxsZUcrnYl37BOgvbjzKa24uOe7URf178us69Y8UGhIuBvktRECu7QIQt+4lFAQVALqqvNRP3AOnvQPJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778926279; c=relaxed/simple;
	bh=dE8POE0bLkDMBzJNszM4qPWzNSebDVGVkxt36GC39Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+Svzj0N3g8aSRjkCA/OOUOG1mg02fFRhfHsyQ6DV0G2ibRPj5rEi1R/d0UWc6cnw+lLHN7E3ULgqS0CL5LhJ3jeLTfMKJG6ckLWQlli/JpIdzl1N5muQACxOvtu4xhQ5IanfaUDm/1SZUnDneCFPij4G/xeOqG6FZ1lWVy1PuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlFd48VZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f8b60e485so328562b3a.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 03:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778926274; x=1779531074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndeekLfeYvEssA5jUCUkuBnAMWw5z8aFBinbqqlOzUY=;
        b=AlFd48VZcuG00dQ4nd724xhJ1skOf7gV4LHJUj3OC6vO2HBBTLM2uDNRFBRuxlLa4C
         +MRlIDcQsERuf3+4LHjZLs4owMxaavQ2EcYQ4qJb6HhMbC43EEsHacGr4YLv/epuE6Xc
         CWhaDmDfhuwFHQ0tlurCt7J6zuVQJs+yBv7VO/qNfiSZdWDQXlhF1hORR5jTRBYaMFJm
         LvpzPLKaLUStEmIzQQNMhX3rlv1GGHBd+Hw/WYwVxxOmao+4eGKSbwCRJqgXa9iRgfN5
         UES5r1zSyqZxFkMtXePpmoecLn7ck375mmIH+92MEWiOlme7fDbMVoXBt3pMQifGjeu1
         lJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778926274; x=1779531074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndeekLfeYvEssA5jUCUkuBnAMWw5z8aFBinbqqlOzUY=;
        b=FKRNUv5jHJL/HhZIHXzMeQnW3O2LlfEDlOMWeX1WUDotlWF18t//3bM3BzKdAckx6y
         wmbpqVNLjB1b69RZsqB8OVtDeB8QFy05glmKb/PLGtu/UifCeXdrNuUPjKQTS//AstaV
         vnraHwxzs+ZZ3ZCoz/xllQStO8vhE089qvFDUTh41JSMp8cICOreMKIRCZTD9t9DAzVQ
         lbWFluyRGhhfVOv2g6ey9MZASNkfLM6p7yLw1gCSFHCDw0l6MRn85nZwm9oImXHivK5m
         zWXJMhdgG2vL0TYeJujRAsnuAwzABxbq4sWSJPsLA581Pa/344cRzgAmU7YMxURTx8/p
         HIbQ==
X-Gm-Message-State: AOJu0YzMM9BiuOAHDFeUmcKVPvQQepREd+mHK8/EfTWhitx4LkaNqvH2
	pB1cV2BhP8iUor3znYStfyfy0pz6qC5N2TGPweQ4CLXBWyKjGM58KhGd0szJ5vrW
X-Gm-Gg: Acq92OHcSF/1QxTWU7ecIUY9nwWc+49EBQ31PNjw1E0thuYfwYQf3Y6hrfEatpFzgB3
	rYk32bcPY3dTtKqhNVeRob/oU+qQgb+3wxX45h8QasnnKfKjZSQOWzFBJ8qa/0SMktfMWnyu0rh
	LEF+gXMGtwJrRtjFyJASiqEzjhGtdML4i+TA852v6ohqkwLakBfZFKYR0QNJRtBuUtEZgWLi8Ww
	rlwtaxGoRZGbkFWCju83ST/TZihd4vwCHHGG0aThwOq4Uuokar8AwhodGXhgUh9z7HmTvF5n0ZT
	bfebIUQ7xjtCSjlau6jjNzq+MmSNya4TeAK/6vrLNLsaordEE+cofI1Iu5prub65WLvofrsEilG
	TyGmiXvUGl0Ow148VQiYquPvuHabB4pLfc3CUHQplKcszDbzh4tcO2AFA6T4rmdKFqidcTAEQtf
	EM5hDIimMONr0UEzeIFMr92lQOx47psn3nxvmOse81Li0a8F4l0m4PKxTBN0VBcozXW3ICMQ==
X-Received: by 2002:a05:6a00:2793:b0:83e:26b:528c with SMTP id d2e1a72fcca58-83f33d26f67mr7608430b3a.28.1778926274481;
        Sat, 16 May 2026 03:11:14 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([160.30.85.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1966471dsm8715506b3a.6.2026.05.16.03.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 03:11:13 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: socket: clean up __sys_accept4 comment
Date: Sat, 16 May 2026 15:41:09 +0530
Message-ID: <20260516101109.479042-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F0D255B0FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-288605-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Fix a typo and a redundant phrase in the block comment above
__sys_accept4(): "thats" -> "that's", and drop the trailing
"to recvmsg" that repeats the recvmsg() reference earlier in
the same sentence.

No functional change.

Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 22a412fdec07..eec5ed08ca00 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2089,8 +2089,8 @@ static int __sys_accept4_file(struct file *file, struct sockaddr __user *upeer_s
  *	we open the socket then return an error.
  *
  *	1003.1g adds the ability to recvmsg() to query connection pending
- *	status to recvmsg. We need to add that support in a way thats
- *	clean when we restructure accept also.
+ *	status. We need to add that support in a way that's clean when
+ *	we restructure accept also.
  */
 
 int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,

base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
-- 
2.54.0


