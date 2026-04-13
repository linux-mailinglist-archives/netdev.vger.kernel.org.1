Return-Path: <netdev+bounces-277996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO0LFG+u3GnfVAkAu9opvQ
	(envelope-from <netdev+bounces-277996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:50:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D51893E95C6
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEAA83002D4B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80AB3ACF0B;
	Mon, 13 Apr 2026 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WItbWtdU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E01A3ACA65
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070174; cv=none; b=fq41uGGVyEclpEFj0DPYTPBe/CROQUgpIyw9tc6VSjUNsv5afPmzM3372KIXPqToDB80CCBOFUM0e2rurNgHQwNCMqyz0/BGf6ZOeNtDsCds1SqMZcvFalm/2C+2PQZCkLgr/OHDq6ZXUKYOmHpY3SiA6oxffGkl27b1kJu/WOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070174; c=relaxed/simple;
	bh=Kv9Y+AAtzFUduQXM83v963cOrcT7AChkyXDgQBfBHvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pbvyvhOuDGukQji0H1d/+VhpeUfag886iofBRUP80UuvVUa12aFkNUDY99Z89qMZdSG/erdRwmNnDBBSqgk6xarUTTP6ceYSKmL0NAfqs9XnUqoUmSATee1Iw0cy8I6GHNEaLwLvXl8Bdm1zxJIizKkHXItPEjKEfO18zVvHBsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WItbWtdU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so2615482a91.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 01:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776070173; x=1776674973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2Tnbg4hjUyqOZ6150LLcBtXjpvaynTEDyStTg+VbFM=;
        b=WItbWtdUZ5kMj8+0UfWfdRhbxIeRraObIcTCm14xKyenFo+6ay0ShTkraT1628oaSZ
         skngQidJ51JzEKARR18zMKJI0F80ohERhIJvfRM1hBXbZ6+fY32RSYQh/90DZsoGADDs
         DT7BTI8+9waOj6zunnz9aOAyRdWE4hfJOd4Z+pu4hHxCuR85PTiUQEEQKZlNZuhD6Q7C
         URlAAYu+Nm+JwTXGm3bGs6bYmq4oV6BVewHitHNJQYw4vFTTw1WAWCNiP8A/zFd07hmH
         4Tf5w8WQKQfYTg6guyip2BMbJQ5FLzEvBWVZIFuCCTzwEIdSDG0etFfIrb5Iwbxy/zQj
         Idbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070173; x=1776674973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2Tnbg4hjUyqOZ6150LLcBtXjpvaynTEDyStTg+VbFM=;
        b=QzOck4WdXoqHPD1TBy5q3Yg0MgChWC58VJG4AEh/JikrL91iuwxCNu4/Af9DN9eYkq
         2OQGirCbXwguX3LwYbrKQZbZ556LuAyVtXEVt+0gCxPYHv18XC0jPrEmFwVlLnhP/Xj1
         CP5oOM9i9bzCdKNasxzDHeFHPFR8VoKzk2T8F/nm4N9eXnhIYtrFUDxt7mfi54dIgL5x
         MqeJbWj6jBv0SuiihxYVWWVShVEbGXrnsQOsPdCrW6igtpQOKBb1oUavQO0eTFsOjNA+
         11xAU6pHjy48d8YTYxzzsfJoRsxf1cco4memAFPaZXOR4mxF9asZidH019/1LFDvh+vX
         J4dQ==
X-Gm-Message-State: AOJu0Yy1nMz/Tcu4+RZUm+x8oQv9NCwnnW9gv3ZKCZmTlkwrb2iDpqzK
	jz3WRIMTzldRRCExRUI8O/UIg+quaImHKSbcWPrMy64przmwIxwbSNdeKxFg8A==
X-Gm-Gg: AeBDiesSL2wc5QlJRfBSpVDM7cSay5VPf/hLlmFA8OSA9lmhboI46ffFYD/IIO35cNj
	K0YH0yVoPT8dbCQLCwvCvseUvvj8xbgvmori7yulhINEXFi+JLyOzNZVJspWdYLsNsj7E4ZKAzF
	KrXRoN7hz/M5CVqUljIO1ND4SkBZKtgyOLYEjR3PMCHSe1yjee9MbcLPao1Nirk6kZRQ8WPF0QC
	dObTxVCq8T/K4gdwYfyk2pd5S5x3ryuQMLdb9WnP6Q7j17wAR/U8m/y0i4lyxfMs814vDxFYJ2N
	R92R7Q9JK90ChEmLmcYpZFM/DpiqD05pBrpjvERLJ1shO2jwDQtK3lq2y0SUfWTiyy8aJNOUa+v
	z5LODufoLsw1KZ1VV+2EM0pAZz3zz6rCBeiBAsV5IBYbS4wpqLl7SY9KorlG5uXCRUwcySAwCTk
	yH19E1mz0bQz19k0X8rq9FtHQsqgqCHaH0HydbFSPs7RDStDD84/BldPc8m11A0NEW
X-Received: by 2002:a17:90b:5185:b0:35a:18b1:c245 with SMTP id 98e67ed59e1d1-35e4250f241mr12676059a91.3.1776070172722;
        Mon, 13 Apr 2026 01:49:32 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4e2dbf47sm8084388a91.0.2026.04.13.01.49.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 01:49:32 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] net/sched: act_mirred: fix wrong device for mac_header_xmit check in tcf_blockcast_redir
Date: Mon, 13 Apr 2026 16:49:27 +0800
Message-Id: <20260413084927.71353-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,gmail.com];
	TAGGED_FROM(0.00)[bounces-277996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phx0fer@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D51893E95C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In tcf_blockcast_redir(), when iterating block ports to redirect
packets to multiple devices, the mac_header_xmit flag is queried
from the wrong device. The loop sends to dev_prev but queries
dev_is_mac_header_xmit(dev) — which is the NEXT device in the
iteration, not the one being sent to.

This causes tcf_mirred_to_dev() to make incorrect decisions about
whether to push or pull the MAC header. When the block contains
mixed device types (e.g., an ethernet veth and a tunnel device),
intermediate devices get the wrong mac_header_xmit flag, leading to
skb header corruption. In the worst case, skb_push_rcsum with an
incorrect mac_len can exhaust headroom and panic.

The last device in the loop is handled correctly (line 365-366 uses
dev_is_mac_header_xmit(dev_prev)), confirming this is a copy-paste
oversight for the intermediate devices.

Fix by using dev_prev instead of dev for the mac_header_xmit query,
consistent with the device actually being sent to.

Fixes: 42f39036cda8 ("net/sched: act_mirred: Allow mirred to block")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/sched/act_mirred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 05e0b14b5773..2c5a7a321a94 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -354,7 +354,7 @@ static int tcf_blockcast_redir(struct sk_buff *skb, struct tcf_mirred *m,
 			goto assign_prev;
 
 		tcf_mirred_to_dev(skb, m, dev_prev,
-				  dev_is_mac_header_xmit(dev),
+				  dev_is_mac_header_xmit(dev_prev),
 				  mirred_eaction, retval);
 assign_prev:
 		dev_prev = dev;
-- 
2.39.3 (Apple Git-145)


