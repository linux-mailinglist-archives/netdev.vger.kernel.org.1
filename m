Return-Path: <netdev+bounces-280045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFYUJnU552no5QEAu9opvQ
	(envelope-from <netdev+bounces-280045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:46:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A105F438571
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0F16300373B
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2DB2DC783;
	Tue, 21 Apr 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb+AbxVq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848C39EF2A
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761198; cv=none; b=LgpjBCe65j1wCy60KLDoAgRPUxPCoQcj7Zp0fDr8AeoLeM7eNPn3LBp27hyOqJtu40RDIy2RLK052noQzSEoiZhImDslX/j+xzSA+FR3794HCQhjdRsi6DN0gMVTJq5UXJi17zfK0E7eBnaN38e4p04hShy88tEiwm/vB5Xh7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761198; c=relaxed/simple;
	bh=yVzKSHrANehfDCDinh6d+1e0pJuxqNrZJzOMT0E0RD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBskwDcE1fgHGqDRNv29z88f4M0AyYafbtsnWZaHRJnTbOkdysWTp2XcE7y42wVSD4BMDTrkmD6IrVozh2mrnDcI5/iKh2iVaBwSw3W1qQFlUetasd9NJpVMilpnlCnVWOtcf50MTjnMbU6V0vorqdNbOes2U+KOZXhgpEFLi5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb+AbxVq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso14252415e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 01:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761195; x=1777365995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BymWAUd08dVn3S+UEnNA1e+mRY/CNs2bFzH3MHHZGw=;
        b=Hb+AbxVqs/bPxTz/IuMqK/VJRYwBNkLzDxgnFKGTZYxoi9f3VHZOiYWV/NrhyZU5rW
         DsIsgQJ5hTCjnwZr//bIEzHLgK856495ai8Sn8X8Lgfz5Kvs+44L+eroyqBtk0M0L83C
         mmO5rPt+eTjyYpXmymdFUGgmRjr86klwqu1YLlXS/YyYHT32L6wjfItuFV49IvytpNvK
         gyXhNJGVLjikhf/OO/UjKkC/wkUFDjH3uDcVjCB4irx/7ZHFCYJMAxDgR35EAQme47+a
         5sznFFwUjFAo4L5PwxK4UZXzfM+X3yK/IhLyoOPDR5BdFkLce4y/7XIQXUAF4Ajhp1c+
         sraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761195; x=1777365995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BymWAUd08dVn3S+UEnNA1e+mRY/CNs2bFzH3MHHZGw=;
        b=QFilhzx8NJsZm5d2EtNI5AXaZ8jcayJjTLjwzIk4napNAdtrXmc5/LWF2EodMYruoz
         VAG8hooiPvvMlQPJMXRAX41mGZW7dR24571FyO/po0tVjcW+ctf+2kOre+KKoNZoh1Td
         61oSkFhvFf2X/bkx1rmLnjvWo6eRl+JCvRDEKQ223ADKZwWatCz3vdhZaUOpyHJNhANR
         J+eU3zPGKAnKSyWwtwPlaJbiJfYM33KKZ8gBwaBeHNIFjo8AtjSXxMYbr5uzDNi7KAcR
         usrAxrEtRAugnuQla+Kvm4RI+xozErgRxkuee35ZqJbUHRJeCPDyPXh4hQUFP9M/ET7k
         hOfA==
X-Forwarded-Encrypted: i=1; AFNElJ8zdTpQP1YndPm6jJaLTIY4ok7ekypLTfdhIji1unzHqCtQQXqOsXktnvIoyXsjve5k5X+JGJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxybOteR5G1vWWSIJUqrC7oQ1AkRxaXBwUlfS9u/UVqcyLp59lS
	Ly7E9VnvKuB3imJ4OYXdyTLJjlm6TdbAJZaaAqnSMqWTLqupct3pE4vNzk+XBg==
X-Gm-Gg: AeBDieuvRclQEs1WPcaEElP25tu9PCqkwA8vsEiVtL9zJCQ6TQi9wMFS8sjzXwms14Y
	rZZVPzSl3LtyOb+CO9JASw1fMZ12v825sQId8ckaipDJ21rOaeSf4v/kcbQmNC5NO8On9UwusVS
	7tN4/d3dYV93LDDByaW/rGwr1HIQ+UU1eC3U4q1ABDkksFO4ZZecWasJCi3NbNIoDhENOpx6oMc
	RCaZ8C8tv3sH6Yxd9tgLDvRoOr0Auxt2Xb0HawL+eV2qU4LRiRVwR8cT4rXslbnMIyFrTAXc7oZ
	T8sj9WZ51EnfCXy2WbeE461MqiH3VxDM9lD4hxPnEuVzxBYUpYs80R8/4jj0dbCaUSDN8A3layw
	2mi1PUCgxiAfKt/nUI7Uxh9pSyeJwd7Qzno7oU5lJ+bgdeiS/tv2h5Wwisb3u7pkcWWJ4g4CGpg
	hkmHKIhdr+QhD4frWRHNojh1WORbabqN4HRF3AGW06IqW7IgQ7G2FIMB2fEkOpa8sky1/2q3HPh
	hAg6BE//UWGhaUlFpHh
X-Received: by 2002:a05:600c:4fd1:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-488fb782a04mr245724595e9.22.1776761195432;
        Tue, 21 Apr 2026 01:46:35 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:e3a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a575d531esm2745735e9.13.2026.04.21.01.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:46:34 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] io_uring/zcrx: clear RQ headers on init
Date: Tue, 21 Apr 2026 09:46:44 +0100
Message-ID: <331f94663c3e8f021ffa3cb770ca2844a07d4855.1776760911.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-280045-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A105F438571
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It might be unexpected to users if the RQ head/tail after a ring
creation are not zeroed, fix that.

Cc: stable@vger.kernel.org
Fixes: 6f377873cb239 ("io_uring/zcrx: add interface queue and refill queue")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index fab3693ecb0d..2eb09219f0a0 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -396,6 +396,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 	ifq->rq.ring = (struct io_uring *)ptr;
 	ifq->rq.rqes = (struct io_uring_zcrx_rqe *)(ptr + off);
 
+	memset(ifq->rq.ring, 0, sizeof(*ifq->rq.ring));
 	return 0;
 }
 
-- 
2.53.0


