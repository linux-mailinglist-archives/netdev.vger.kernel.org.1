Return-Path: <netdev+bounces-292084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCPnLwBkFmpamAcAu9opvQ
	(envelope-from <netdev+bounces-292084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:24:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B05DEDD0
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB2D5301C595
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1D23750C9;
	Wed, 27 May 2026 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeKOklq/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1109363C5A
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852265; cv=none; b=m8nnB3GxoKIvdg37BOJHLNt34urjjNMI5PK/GS+zQenNoLs/UQ63GQ4f0QvmoqZKyOQj+nuNyvwG7DkwHSz3AbVCRAI1kolTQkSulaWnLhQzEoy6QYVd8tTTpPEIWZFk96hHJvKM+svsQ1cGh8HThpT5RgP0t9NhEUCr3RViRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852265; c=relaxed/simple;
	bh=8JwjeKZVaCntrKAP75csUwWF1GR9z5p9Aj3+IYZ9JKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uBUsRUX9+a2JYZ6Rrs8pmp+MLAEyWFMGF5SDgMEC1VhOM5gcdBoJxPpPbcxqpLL/5ijDYwiuEN2jJV4fRmOCIqaKHhqTyCpWdrQq+yNbvNl2G2IzXEXWWC3TPevhdtmgwvDz8W67wGuYvZYWLd7btS6I5ajgc3mXfmdM4q2cLNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeKOklq/; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c801b30188dso4972399a12.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 20:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852263; x=1780457063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl4wPPXh4KR5+kQ81v17qjTdxEHq3gUQeGIpmR+SCMM=;
        b=jeKOklq/zus7+dRDDWPRhTN3eeSG7AFXo4HE7s2qSPnjQPtNVKQL1rBibEHrcajMdp
         Eb9T3LYv63H61o1W9McDa+pW+UpQJsn6DuPcOcSzlvMpenfHZ0QKwbSOkvOxNs4LiCdS
         puBSwH7wbNhnnuqkUIgrLHm6WIDKazm/0QiPjyF4emeb8tWnceQbocz8NujtChJrIzvL
         6+rynMwOo8FOBEXxs0VNmDqwJEobjYeJLsdyNCpp/ah/Qv/yOvLPBgy3HAlPkN3i4SGc
         SDSTzP8Je9vb1sg4P8K13n6O589DMYgOjFo1RbA5OKJILJMExO6LpAO82UNnRJLKp5rs
         KEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852263; x=1780457063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hl4wPPXh4KR5+kQ81v17qjTdxEHq3gUQeGIpmR+SCMM=;
        b=GtW6MgTQ52wao6RPbtcCdzIV0LDHWzh1SJ+FUQdAWGp/tBhhzWq6Zy+e2kYduuOFHM
         ffbtETunNW4AdM7eDzelq68u5N0z4zXIkZy5F/5MVkNYy1cMh7BjWSAICVKkzHysxJGu
         iZQVFf//DpLgpNwyxe+M5jQBgeVLYGB85OOu05cOEb3aeESL0sVfa9tjOHWmQjDL4vCt
         wyyob2vgBH4gBrJXYN/BGXntveryvRDWYre5iyMqL5+KZxo3MoVvgI+CoJHlA4i2ATOq
         klnguq2ybhdEA18YBrcU4+96iQYYfRpbR97JBsl3NUr31b87oCh7eI0HbZkWHwB1sKZY
         JQwg==
X-Forwarded-Encrypted: i=1; AFNElJ+LxeMBYU/Q7og2ycL92zlLKZ/pWX2uKaOny6KEjVpLFcmvQDEhSWju6UahSqiL3Q3AC6wkoI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeMU/kN7gGXU8rHXUX8dMQnxDIdD+4K/xK6pOVoZv8BLMK25n/
	ZP6EvO4SXiJn1tWjlNNuB6vtaOqugnhsBb6dtBDw7QOSbmzu7CNuiYttQK/IR9gLzC56G0Lj
X-Gm-Gg: Acq92OHUQt7h1vfogVYiomZxAbeMir7Kt8cTNzQS53z821Y1QPcUumK4Gf28wjFZv9M
	kDCkYaZii7MG4406G4DZ8Wnq1XTPhTchS7BF7AmCFy8PeARls9Sw5Bh+8eE9WhjgiQfPI6F0Yk9
	WXIvU9M81Wkd97E75JUaZOl73x+7q9G017srqikTIGywyP83oSWRncM9SHD00tRcuTAVf1DDnvS
	nq+bcgvJg+ZdKwZShHixzoJPBa6ERF6banZCJo4eDglNDIRi8RKl1rVifC0cmrhjsS8EagUeS6u
	YC5XClBPt+wY5I3ZqPeWBO8uSnh5mHBB6hw6ESo1AnC4d8npWJoammwyNm31Y4wG65hgdcvNnjV
	746vuUmd6DmI+fo4hAHXlHETWKQAcoe4+X2xUTMPHS0T/5Gk2Ka7XubAPy+LaGYuKQS3hJiMNdx
	DmYJFInN0Xq0kYVH3U/lyMAHM228YlVLf9Wqg03hHRzLRlT+07xd1v+2iURB1u
X-Received: by 2002:a05:6a00:3923:b0:82f:ac48:8342 with SMTP id d2e1a72fcca58-8415f4066camr20956495b3a.24.1779852262723;
        Tue, 26 May 2026 20:24:22 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eae464sm779763b3a.20.2026.05.26.20.24.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 20:24:22 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH net] sctp: fix race between sctp_wait_for_connect and peeloff
Date: Wed, 27 May 2026 11:24:11 +0800
Message-ID: <20260527032411.60959-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-292084-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 228B05DEDD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sctp_wait_for_connect() drops and re-acquires the socket lock while
waiting for the association to reach ESTABLISHED state. During this
window, another thread can peeloff the association to a new socket via
getsockopt(SCTP_SOCKOPT_PEELOFF), changing asoc->base.sk. After
re-acquiring the old socket lock, sctp_wait_for_connect() returns
success without noticing the migration — the caller then accesses
the association under the wrong lock in sctp_datamsg_from_user().

Add the same sk != asoc->base.sk check that sctp_wait_for_sndbuf()
already has, returning an error if the association was migrated while
we slept.

Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_interleave")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 net/sctp/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 1d2568bb6bc2..66e12fb0c646 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9403,6 +9403,8 @@ static int sctp_wait_for_connect(struct sctp_association *asoc, long *timeo_p)
 		release_sock(sk);
 		current_timeo = schedule_timeout(current_timeo);
 		lock_sock(sk);
+		if (sk != asoc->base.sk)
+			goto do_error;
 
 		*timeo_p = current_timeo;
 	}
-- 
2.50.1 (Apple Git-155)


