Return-Path: <netdev+bounces-306803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aPFYJ6UdUmqIMAMAu9opvQ
	(envelope-from <netdev+bounces-306803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:40:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331A7413EE
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:40:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kOyJmZEO;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306803-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306803-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EB98300CE8E
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0994A3BB12C;
	Sat, 11 Jul 2026 10:40:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6F23BB11D
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:40:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766433; cv=none; b=pAA0dAKifnxw4I657ydDxWTP+glynjK5R7EZsqOybr943ywFvBJj0fWtxYkVIfQVm/29NcubKE2I0UzYtjhGZkeJjS5pud1x6+YXf28QHDwN6krGQe+sxlmwNdisT0tC3XrQvKqOlZbQH8+uY/cOW+GbFU+e6Da1LejrkvjCnV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766433; c=relaxed/simple;
	bh=uPaiOGoNFr7zkBX2pJiSPMuPQwkXNFMgfzCf29UXcHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6+gaF9yuT8TbFzEhR4D5llGfu/lsDmWSruvVxKO4dzEy10TuBC6Xlz+tH6oZWLas4pCghMKvY8EsMXN/W2KbH+SqhpW0IhyYUVeIm4fJurGVEjOfmDqYm4unBRQE7NQ+DMunpb1fOxcvRaHFaH2LtgnDA6wQdVoQB6VzqB9rS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOyJmZEO; arc=none smtp.client-ip=209.85.218.47
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15ea93028dso185283366b.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766429; x=1784371229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PSFjPIB523gHDvD4Fc7ge2yKmmEA/d172Uh20iN5gWg=;
        b=kOyJmZEOSDagqzhp1AkhmZnbUjgQsqHGN3F83w6j5hNqvMVLDLUcZctQs3pNHzUlpg
         idp4fCnya8Uvuzh3jEUR37JUzsjyMQdMtTheyJ1QAO9p+HCyi3O4STF7XLVzlnGkTJqM
         DZE5tuTNRenaNZEE2rjnj5zlxl0CMFtY4TFthu3TmyM52UhbX6hzTaZXVjtx32+tBRvw
         CAxHfs9yWAlSzMKWbLc9NF6Kgk1VHbMQqGSY4HH8t8ObCTsOw3jWWv1FmOrYbgEjMs8s
         0uZ9fMcBCkI1foeBQGdkig/I+Mf4/7nFVBNu/Y7+tMcSCeNCQ1xSOhUvBEE0v6u+FDK9
         DwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766429; x=1784371229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PSFjPIB523gHDvD4Fc7ge2yKmmEA/d172Uh20iN5gWg=;
        b=ogbWnoAyGFun+/u0fYRYloVkK5ZYudijykf0S62S72G8aDxTtav61+nEjfWm7Ph8/k
         xGlKyMikvovy+e+DIcx+CP/oiQBLpUjvKUdlRZ50oUkLLG26SX233Js3yQh3o0i5E/On
         o3prqMycivsE6Sh7spprL3NDbac5DfUBzQVd8wOeZVxnqSg5zvokhhjQsHv5J2ai0Ugz
         yGAmJw5WU7KDpQWdSqBuRWH2l5mRyhEYltCg29g0oq6kI7FMrXAMDXj9Q9V82N4t8BHl
         rMDqugL+OMYGv22qVM8i/kzadrFtOQNzzRWg6XAnVStcdUjq3i1cq4gNrxgK/7A/41T8
         NeIg==
X-Forwarded-Encrypted: i=1; AHgh+RpeA+jG5G1wQ4iLaZtlFbfjWqmzeo8GPLPHZSEV8dlzvz+jXEIVHqy3kjVviejMqKVxBCTE3os=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlizeK5TpuDPbV1djL4KU0YHNCflhj9vLSBhQXAdHZhdVzh43/
	TAvcWhr4a+k3s+goGhIkwulXUZRcCiEw7fm3P36cLUK9j7YglRefSg5E
X-Gm-Gg: AfdE7cmU2TF3zHohOYRta6HiQHgWhPpain6ORFzBHZwjV3XKoxKsACtDOIKnklftsMv
	/9uBXCMgT7gp9AcvcLg651Vb33N2EPZr6UUQscnPRF7odJMjcaalq+Yy3uAaot4mLwmLd/8idnZ
	/zq5+g7+ahi7hp3YG4GvBpoXpfyoNrSk4B/dwqhEd0gPFRU4QCeRsPbbQD4qT0WAULWJ1U07Y4k
	ZGh6FwO7IVNukyg46SROLeecyXDv/9tBg/dTAbimJCzlQMWE2fIbtOvEj+Nw7zQVoWu7ovZQ0Uf
	K14/oY95eEQIhOj0YhMB3zPBp54RmfZHueJ86OfhiY7Ao0t4HYEKNw0428LxO1krhMZNNgmZvxj
	fT+syTDCdTKR/S+o0RZM66wCzjTDpDLM+lbk484L4DiXf+UBMxC3+CgQq+meTju0QtrHgQlQ0AK
	Erj2343a5ZuLvvP+RrCzit0o062/rUCE6nny0PRr3xtQxXRV+7e2IVKXfb3ZZR9TXbqeXDpRmtm
	V/sEARhLPZCe4OQ4Pjem0iQw9Dagqq6JGxqvLc1Rn3Eu4ekVg==
X-Received: by 2002:a17:907:3e12:b0:c15:ff7b:ad69 with SMTP id a640c23a62f3a-c161eaa959emr84236566b.34.1783766428403;
        Sat, 11 Jul 2026 03:40:28 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:40:27 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH RESEND review-only 00/17] zcrx RQ improvements and dynamic memory provisioning 
Date: Sat, 11 Jul 2026 11:39:53 +0100
Message-ID: <cover.1783616211.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:netdev@vger.kernel.org,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306803-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3331A7413EE

Sending it out mainly to trigger review bots. The first half improves
the refill queue implementation and improves refilling limits, which
shows up when niovs are heavily fragmented like with large rx pages.
The 2nd half adds dynamic backing memory provisioning.

Pavel Begunkov (17):
  io_uring/zcrx: scale refilling with large pages
  io_uring/zcrx: move RQ head/tail to separate cache lines
  io_uring/zcrx: add RQ iterator
  io_uring/zcrx: cache RQ tail
  io_uring/zcrx: coalesce same-niov RQEs on refill
  io_uring/zcrx: constify area_reg on import
  io_uring/zcrx: add helper for deriving area token
  io_uring/zcrx: don't pass ifq_reg to area creation
  io_uring/zcrx: split dmabuf unmap and release
  io_uring/zcrx: unmap under netdev lock
  io_uring/zcrx: split append out of area creation
  io_uring/zcrx: move freelist lock to struct zcrx
  io_uring/zcrx: array of areas
  io_uring/zcrx: pass area_id to __zcrx_create_area()
  io_uring/zcrx: add dynamic area creation
  io_urint/zcrx: narrow var scope in io_zcrx_recv_skb()
  io_uring/zcrx: don't reload skb_shinfo

 include/uapi/linux/io_uring/zcrx.h |   7 +
 io_uring/query.c                   |   2 +-
 io_uring/zcrx.c                    | 445 +++++++++++++++++++++--------
 io_uring/zcrx.h                    |  15 +-
 4 files changed, 345 insertions(+), 124 deletions(-)

-- 
2.54.0


