Return-Path: <netdev+bounces-299214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KAF7CqOjLmo31QQAu9opvQ
	(envelope-from <netdev+bounces-299214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 14:50:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEF1681096
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 14:50:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Y+RvWZLm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299214-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299214-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C39723008D08
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE28380FC2;
	Sun, 14 Jun 2026 12:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EC61FC7C5
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 12:50:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781441439; cv=none; b=O/pccHACkCATzhM8FDq84R71nFIh4JXIQJGFgCo+bVm9354l5A10iGZFMxrK1nPpr01U2ifkGIF0eKZJGjmxsInh5mHju6GWuCsz7El0JV9fJlZLF4R4eQjEo5U8aYyqXdRrlewwLGvpenNU0ipyEaMviet5GkYo6EnzzUOTIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781441439; c=relaxed/simple;
	bh=O4ZQftSfdzDvQBw4QDT5W/g58Ju49uaSr9GgemzTkh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mm3+C2g7G83hWn4JGu4FdlOOkDcGBQJWRubQF3h7tj8LmEr+MH93y1T71Yx+kIq8zGLf2Ht91Iee0UMaSDvdeaSFZK0sJTFWht261dXQNS48++ADAINsiLFGXlp/979Q18uVfmr6QV+VcM4EWyrf8UZh8JzrbZhVtz8+ruRq+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+RvWZLm; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c168baac83so10877835ad.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 05:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781441438; x=1782046238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BUkD9fnh6nUhU2UKLYYekm+TZegtL0faOVIIvIfCto=;
        b=Y+RvWZLmGycBtbPps+p6jClbfZp3HddRukSYDtJHy/zYoEOrvFNnifznGjGatM9QgQ
         /9h/EC4EUS2b1OXpXjqEsQjC4vVpdazQHM0mCTYyhe+31gwsd0Fjwge7QqL/ZuqsUOpB
         JiOzIZk7BgesqysCA6vrW+QBZDDdqh/vkIj31HEMExDCtjOon+Ae+a5xUpUt8TkuVNb1
         qUYvZ4Hb59LhKEiTVjfJbFeRjpCZIfazBWBgYi5FyiGjYUQMlOSNQPqR1iKNbpCclib+
         szL9smRVuvVXnDXEqXFcAfDZtaltJAlPAGXXmIF4yTxK8tNzGleJS3Sazlfp7MEaOwuK
         wl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781441438; x=1782046238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BUkD9fnh6nUhU2UKLYYekm+TZegtL0faOVIIvIfCto=;
        b=NYgFGKMuLFzJp2sdowPBGozoTU06lGoq4GAjuoX9FdZ3Rcwz9NO9xE1E1FsvPVN3Yt
         oupOoY3sLw4zuWGP3CuCUoV8tlYT4C4/uc4cddUP9thIoVAU0TNHsNu4SLOFWr4jqRyC
         MXe6Wj06Ouhg1Wy1cl9fuORkuHv62kw4NPQ1B4hk/HhiBU7SV7hgoDXK0EDb8p0EEQ0v
         wX5OyTbpE+WdJsCLGGMSJCNjs/wTaBIyMKBQGvsl6Bu80lgY9EMCTMGIFuVqxTgYrZPO
         TL/dMdrK/veRN6n/eIus2HP1FjCpw87ZjYEmNK1b4awfFaIx/xQGV9JTWK1SB9NzLtEA
         k8bQ==
X-Gm-Message-State: AOJu0YxvVTLqcIYpNVCPodHAZbhCIKKq8q4ARb1myA1sm+Vq84wRdFd7
	E9Ko+OtCQTgFwy6xsEKrRxLknDZ0R4vxiyWDCTo8jWdo26I1YCIpcNzYjl2uL0IPlxPjeQ==
X-Gm-Gg: Acq92OFYMFvqPLQW60J29ySJWJWz10aJo15W+DeO6GYm//lF1NsWWmIkPGOQD1OX17I
	P8TCqsuraNgPauc3xWm4PDHsuImus4l6QqJ01xw6dqmBJKX18p+/AY5tDuBuYjZon7nqQjDVYrP
	F1shtpxtZxyjmWRsez7IkpIQ+nVg4C9EUFhsA1GWXLdYlMb7f7dhzD5A+OwDxj0+cxkVgSvjo9k
	C5vHbcvY8ub7WVflUOpLhQZIM0357BqsXupBY/NcWm+jliF7PfKv5lfuyCOcgbcFQOT3bPHZFEL
	Gqtz17Ei5kBOfsIT4g6+n1xQmV3ktKf3wJqpottA/P31+yII/bvm/Yzw6oKauwSgsVhvvgygo6b
	gBr3GEOuWoTCs/FQueqUgHYZWekAaUqph5uieXzKwawh0k80vaFQrxvCSRgg7HOEfLZB+TlhveI
	tVFZRP5deqIp6N2DfQPD3Gy2kZ5Q7aJwxYMQh90JU=
X-Received: by 2002:a17:902:da84:b0:2c0:d9b7:b7b0 with SMTP id d9443c01a7336-2c41216fae7mr121815405ad.31.1781441438112;
        Sun, 14 Jun 2026 05:50:38 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:90b2:9957:66e9:8cb4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac79fsm66426825ad.45.2026.06.14.05.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 05:50:37 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v2 0/2] net/sched: sch_fq_pie: add per-flow class statistics
Date: Sun, 14 Jun 2026 18:19:58 +0530
Message-Id: <20260614125000.6058-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,vger.kernel.org,gmail.com,nitk.edu.in];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-299214-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:jhs@mojatatu.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:vishy0777@gmail.com,m:tahiliani@nitk.edu.in,m:hemendranaik@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FEF1681096

 FQ-PIE runs an independent PIE controller per flow but exposes no
 per-flow statistics. This series wires up fq_pie_class_ops to expose
 per-flow AQM state (prob, delay, deficit, avg_dq_rate) 
 via 'tc -s class show', following a similar pattern as FQ-CoDel.
---
 Changelog:
 v2: Addressed ABI backward compatibility issue for tc_fq_pie_xstats.

 v1: https://lore.kernel.org/netdev/20260531125314.22492-1-hemendranaik@gmail.com/

---
Hemendra M. Naik (2):
  net/sched: sch_fq_pie: add per-flow statistics via class ops
  selftests: tc-testing: add fq_pie per-flow class stats test

 include/uapi/linux/pkt_sched.h                |  29 ++++-
 net/sched/sch_fq_pie.c                        | 118 +++++++++++++++++-
 tools/include/uapi/linux/pkt_sched.h          |   4 +-
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    |  22 ++++
 4 files changed, 163 insertions(+), 10 deletions(-)

-- 
2.34.1


