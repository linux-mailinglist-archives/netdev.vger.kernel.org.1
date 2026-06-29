Return-Path: <netdev+bounces-302547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OEN0DJtCQmq82wkAu9opvQ
	(envelope-from <netdev+bounces-302547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:02:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 243406D893D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:02:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PlnN8uFs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302547-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302547-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F24430A8228
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48D93F9263;
	Mon, 29 Jun 2026 09:40:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D392836A6
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:40:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726033; cv=none; b=m/waqwu+SVU3epf14qTFcoLBbMrnH3cG5/Apfl+UaN2yOVDixSEG4F9R4IP2/V6lMMBZz34Cd9ShTB1YfS2fNrwkKbjaKdNQPlXo1c/x8NFxkuooY1wltF4xowrd24d+WN9qOg3xGpJ9eGxA9fMHjDk5+tRe1waETB7YM4nlY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726033; c=relaxed/simple;
	bh=0NRnwOTkYqoD8DBF+bYtIQoBIoqPd4HJRoOYSMROJzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNiN7rGHHO7cJ/vk4+a9MLBks7kES62w/YgAZh26ROdJY7EmdVR2GohKYZttIsgCPZUi9vJaIz9682ERQnHbsq9QFaNVWp7o2QswT5ATW5O4vzePnwhA7QrwK38PuoF7aLyko4YcodgEZ2+gLFTo7rCSn9387JeolEqk592qey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlnN8uFs; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-46ee68c3b7aso2618055f8f.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782726031; x=1783330831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=buX7wAG0nhZSHN5FfnjkD/cPhw+ScyqwYDleMV3fgho=;
        b=PlnN8uFseUawCPD5S9sjBwd9ju8mL05Y3G0ixJp96f423Yli/5R9c9f80KtvJR3qpm
         E8QUPbMVb2V5MpNUttAjPmbGAIGTY9IaP68wJm/twiAn+auPXCJkfSk89RaxHlv4VOM7
         eYvDyWUGEDyAr9KeLoXLXrHD0xHsnKQn7qvCacCXttV1jcPuryjQx7LIVl99xdqksXY4
         f9Kwd7nNfOm82ABda1UXfFSfMn4v4ouJFI4zh7JamHDwKRKyji7oDucmFgkCtPxUJmtp
         UEPCiLXPvLNfgDVIiaYC+muXT61NBzD/P/4SgagtQEVNs5dZcChNnsOE6Gsp7REb5dQo
         nbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726031; x=1783330831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buX7wAG0nhZSHN5FfnjkD/cPhw+ScyqwYDleMV3fgho=;
        b=fFzASefni7g+Qwjj1izv7QKb/Fb+PYW2BOMt9DDfkP1HeJGCRyuGebp4ecoIhbxK1p
         5esvTYhA0DCsyzUCXcvhpZtWIAmbs7vwNRRvpHRS5Z3IF/dp322enc+M7MuLa2+chrmn
         onMGjK29dIcCRO/RnPwjlFTKOAnd4YSwGFy/VCnAZkPLFIMO3Leh+AGyzlqq/spVRJEm
         O+2TfXqFoTiDw/fu/d/ZM53Zm+UMg0kje2Dtke6zogPxVB5/6iZf2h1WUODsK9RaD/qO
         RWuV0P5b5fhUtAWNJe6SbAFfnAaexVpk5STLswhyEiCo/bPKbYSO3yK3Sb+TWGfSUaz8
         CU+w==
X-Forwarded-Encrypted: i=1; AHgh+RqkG7ETeNmFJoIHHTz6dSSW6ir0/6K06Sxla/LtMr1njXdwposvIDS7kcL62Asq+e6g0G8MPVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFgnPjgCSnPXnQaQpfXzi4VxYO1Rd3tPFFofc7VAAhedewOGMX
	VQFaOFyatP4tF8XaVeQOFTfs6KHSuCieQG7U54X1xQ2tFdyMnVxqetUp
X-Gm-Gg: AfdE7clBGm/bvK4ldCo33mORPMOFD3ZHOr1YcdqL44MWLVKpNjbdODfd7WfZYzScJUO
	UFEb1XdFEZSnMQABWi3r2Rw3Rlc0g1GOUD0+m/vJV8Gtk0H+2kOrErVj2frXB5a2Da59x/C6gni
	ReWDUo1dyTd7XOO3DjLOWJBbz3XAVMmV8wsvr/4oyzsoI4EYDFQo8RtObO5tPCZZcPdqiFSY5eb
	5Tsqc191jQx5UnkFUVJmQG0lblo8BOlBgFmjvzxwRVyRrBPu/+u8Uusb4tkuQqdmX9Ctm3mKjdx
	RsgIi+o8I7gejdQ80lrQEmAl63baeSUs42xPbTZoWCHZWXnkSUl3i8z1n3rvEHU12gsmm6sl1ii
	NhmJFhAmhrAfnGJotXd/4F1MyuQcLbyEDuiet+iJUW6nXdtvbPQTD/lv5IZCpKsZJmB+ED2Q3u0
	Z8dsbF5YdoQGTmx6teve4MS0kMuk7a6bBYQFVronZSvIVes96H6/gPki40kMRnDGTa3ESCA3Eb
X-Received: by 2002:adf:e19d:0:b0:46f:e15b:415 with SMTP id ffacd0b85a97d-46fe15b0618mr14873951f8f.12.1782726030631;
        Mon, 29 Jun 2026 02:40:30 -0700 (PDT)
Received: from localhost.localdomain (94-43-5-44.dsl.utg.ge. [94.43.5.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4726b76e6f8sm17704409f8f.13.2026.06.29.02.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:40:30 -0700 (PDT)
From: Igor Ushakov <sysroot314@gmail.com>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Igor Ushakov <sysroot314@gmail.com>
Subject: [PATCH 6.12.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Mon, 29 Jun 2026 12:39:51 +0300
Message-ID: <20260629093954.195016-2-sysroot314@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,davemloft.net,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302547-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:netdev@vger.kernel.org,m:sysroot314@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sysroot314@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sysroot314@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 243406D893D

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit d82ba05263c69fa2437fe93e4e561cc40f4c03af ]

Igor Ushakov reported that unix_gc() could run with gc_in_progress
being false if the work is scheduled while running:

  Thread 1         Thread 2                     Thread 3
  --------         --------                     --------
                   unix_schedule_gc()           unix_schedule_gc()
                   `- if (!gc_in_progress)      `- if (!gc_in_progress)
                      |- gc_in_progress = true     |
                      `- queue_work()              |
  unix_gc() <----------------/                     |
  |                                                |- gc_in_progress = true
  ...                                              `- queue_work()
  |                                                       |
  `- gc_in_progress = false                               |
                                                          |
  unix_gc() <---------------------------------------------'
  |
  ... /* gc_in_progress == false */
  |
  `- gc_in_progress = false

unix_peek_fpl() relies on gc_in_progress not to confuse GC
by MSG_PEEK.

Let's set gc_in_progress to true in unix_gc().

Fixes: 8b90a9f819dc ("af_unix: Run GC on only one CPU.")
Reported-by: Igor Ushakov <sysroot314@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260501073945.1884564-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ move WRITE_ONCE(gc_in_progress, true) into the __unix_gc() work function and drop it from unix_gc(). ]
Signed-off-by: Igor Ushakov <sysroot314@gmail.com>
---
 net/unix/garbage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 1cdb54c616..82dfb1ad34 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -583,6 +583,8 @@ static void __unix_gc(struct work_struct *work)
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
 
+	WRITE_ONCE(gc_in_progress, true);
+
 	spin_lock(&unix_gc_lock);
 
 	if (!unix_graph_maybe_cyclic) {
@@ -613,7 +615,6 @@ static DECLARE_WORK(unix_gc_work, __unix_gc);
 
 void unix_gc(void)
 {
-	WRITE_ONCE(gc_in_progress, true);
 	queue_work(system_unbound_wq, &unix_gc_work);
 }
 
-- 
2.47.3


