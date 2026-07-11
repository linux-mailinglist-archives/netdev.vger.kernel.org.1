Return-Path: <netdev+bounces-306769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 50bWEO4IUmqwLQMAu9opvQ
	(envelope-from <netdev+bounces-306769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:12:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E07740F90
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:12:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=L3eGaEjp;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306769-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306769-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D96B3009160
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E4337F721;
	Sat, 11 Jul 2026 09:12:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B42773CA
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:12:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761132; cv=none; b=jQ9053LP/DHvxgx4lstF3xe06ZMpt0VcJYAQ0An0ppeSc1sxSm6/GtlfDTXmnTxyL187XRsTrugN5waQfyVXwvofl2+IUqotq3jprIBV5bEjLSKDNrkdjmMYRneUHkpjgMZmfmuQgcse9s1VA6B1AYiblR2+oMATY6adhqYvLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761132; c=relaxed/simple;
	bh=uPaiOGoNFr7zkBX2pJiSPMuPQwkXNFMgfzCf29UXcHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDbHMqIejhD+Bj1RijNe4lT0Qx3TcvohUIgUxhulJymT/L2cnU2yGxH4HvkmE0+fDUBTh8VspSn9/6V46mTjV9KT9OsDDPF5q1FZmtGnPhRXB3EtVyoxX6QJvJy3SIKh/wZ/gN+Vuw+gghlB983rTCD4Hg8uGuYbZ9PPzSK/azM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3eGaEjp; arc=none smtp.client-ip=209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so2555552a12.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761129; x=1784365929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PSFjPIB523gHDvD4Fc7ge2yKmmEA/d172Uh20iN5gWg=;
        b=L3eGaEjptoxFEfk89oJhjPMsM75k7gHEIrDsQGsZdIagygiZWoqThfrDRd29GAPMeF
         1jAdgaUDxcTUETI68WH7Aqu2kjgzNusRXyb0K7NdZ+4u/AIEx1udO57i4aRfrc8zdfrM
         pN7cAwm9HCmnsYxgTvuR1RLYuP0jkyi53/eEwB1Y7EU2tvNi+B+8zJhqOIxA+bcEbUx3
         eEUkVGFbgebixee+H0xdBULw3B7867pfYUThux4FaK2vZj3OZjCZBPidqgbe2+0fyv+k
         e1/SpwDEVdYWZcLzVSyQ4F8aqBED6D3ioqnsRkcfx9tELs4eyQBDB8JdZpyKhjIWEIn5
         oiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761129; x=1784365929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PSFjPIB523gHDvD4Fc7ge2yKmmEA/d172Uh20iN5gWg=;
        b=jkPW8TU+DI6hVsamaZZnDHQUVh4AYHJEUVvx0v/wPvcXqmHp4286eufVXMmjH6VXFl
         rdCqGHAWz0MM8RIe65kl8qn6cdlYl6ljIMi4dAz/zzlJ1j0qbw3xDBfiOkDE14k5pdwT
         Sd5zNs7s3pOSrM4ecQ6KstLOKPuRzpPrIBHf23JS8h8NnQIisxUCj+QgLhdf5AwjWxXy
         Ys0kl77PLN8G8Q0vmLKPsTwY0ED5wxFIPOmWYLlM6wdIb9OljMtzTGfzpQmwuc15ZwTJ
         0ZrN7XdWjAzNa3PXYu58RNkDxmdZiIE4Uif9lrt8HdcbCIXKaBEHN69UCmsxUy7Z160m
         P/jA==
X-Forwarded-Encrypted: i=1; AHgh+RpqrfiOEpHoCqD0BfKyFi4oJq/6v/6QudMi9uf27PjxeAlRcCRauxUSOog7CwbLMw2TmPCECzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6cTzFBHeUGJHncVDHUkvo3DD7Sujy/t6Y/6A7QMUNu4hzkQSZ
	fIp8chM3ERh9sjuzFHoFYggCMc31UOUsB1tnt4yzb0NlrR6m9ltMBhhEgMFvaw==
X-Gm-Gg: AfdE7cns5gx0xoy0AnL5NVuQlk12U8LU+LFClBEnXMfHz5rB/BxEfmp9QYRaNfk9jqV
	/K+9bucw8gCpt/Qa+AM7f0WHMbAZtRzi5K/RMPlGqzsm2ufeRYRG5jcR93PNm2lo/AlWj/7wX5S
	1JsHp16CaJRMwDXurYtz+9QBd5SyvhiT7CGEjnZxVH7oGa5mnLSJXtbFDNiSZDnH4YkfSQGS6oq
	bwNuoCUnGeyW6dV2y4cXIBjETVmP+Ex3wBzBsa6gprJegOvPW2onM56+2VMoDpBViiWCuOkrUot
	0Dl/XlUq9m1qZwGLdyJ8pl4k7Z/vZ9UMa72eKbJloiqvHawZ5j5fHre6xDrMEgfo3E414VKixSW
	ICcWZNOGfuLJKCD4H85rASnGlLfTmN0Hz4cUBhGNuQh6TQeRUuZyRre7HxYaCd/bwjk6jTwcxSx
	S79pC/PS8T9tvTZgMUfhRkoCkGzLoa7B0ZL6bjvdc8LuKEZkQsrN8qCIHgeeu0dceA1mXZf4XsU
	FtLDWWTQMkTQJqrlWwWNXzV/ygeg/VqJR+KHfrxJoIdoNg=
X-Received: by 2002:a05:6402:380b:b0:69a:44e0:7455 with SMTP id 4fb4d7f45d1cf-69c5f11721fmr871751a12.30.1783761128956;
        Sat, 11 Jul 2026 02:12:08 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c60d47188sm681191a12.27.2026.07.11.02.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:12:07 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 00/17] zcrx RQ improvements and dynamic memory provisioning 
Date: Sat, 11 Jul 2026 10:11:23 +0100
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-306769-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3E07740F90

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


