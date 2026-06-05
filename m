Return-Path: <netdev+bounces-295979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CKVFNxhAI2pTmAEAu9opvQ
	(envelope-from <netdev+bounces-295979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 23:31:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA1164B668
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 23:31:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=MAIuoF79;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295979-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295979-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA3683003EA1
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 21:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BD5305691;
	Fri,  5 Jun 2026 21:22:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95223D2FF7
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 21:22:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694571; cv=none; b=obS1kiu5j0ISIVaXBvX46qzNibYa+mi8WSBJSaFriNqkgvCXjG7XC+4wJyxSxPAqmWLdRkjy1YMAQT4qCZCLCdxhP5Nw0AGfj/TZBL08qrovkUE/JUmsCPeBBR70ZwRb7opDc1d892DUsAEfy6DOuIo40piHGCNUv00NWq2fYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694571; c=relaxed/simple;
	bh=wNO+78ZIYm6dyaCkwLqHK1IxWH3NUpNiLhfj1eEtKtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzMXdwhz+d/No8Z5IWdd/7NQ9sZkag3iKH8QGMVmsZ7vdiNWSwsTyPJ0+LKSKvILfUwTv9slRz5KP6Uyw/sdNMpYHDIsroMs9KDRUuYeI2QOWiaoOo7je15XklogjsbonwTKZ0t6iqyg1G0+19fMnwWwcj2cBBNbEohUktT8/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=MAIuoF79; arc=none smtp.client-ip=209.85.217.52
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-6c28e1511adso1419776137.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780694569; x=1781299369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eI7WEECo4Ujx8Pv8G5BQB0qvXoYxz7J7Jvetb3IuYSI=;
        b=MAIuoF79GotkJFJRUpUOYt56SxC76+dWxR4bK2KnA7Ub4CmCr3pUS+ZD3m60SbKVXv
         +TeHg8Yb/LbDxqoo+lCtgpcjRfIUuzy1Z4vgWCo8mYdr6TRtIPAK/aMZOwyWQPr+9m8V
         Ol4OLuVwLtU9lLXSUZ5m5L4q1pq+aEhQWh/Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780694569; x=1781299369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eI7WEECo4Ujx8Pv8G5BQB0qvXoYxz7J7Jvetb3IuYSI=;
        b=p/KAVXQ5gS5u9UYGRo9Syw17toa2+HBfRHbnpVWR5Tr71oT89RzsyDEXjdb4k/r8tN
         r2Ow74Msgs89Ryt5hJhqGVgPkMdvKrVuu3MJRyXI3L1aYSSx5ZDskuUB8pW2V9XfUiIE
         X6xDfVIPMj/cOxf+0XIMsX+ZMGmvKXm0gwXsxg0Rf0qpfotdBJOC20JR3BcAosM7dtjS
         VgP67L7fMFWkN1ruO6RlC23Qt8tSHTyUxYHFfq5iH2r5MsmmMLQkWZ9CI/J+yuE+88E2
         h8jelPdKsRjAhp9r+SiN1RJLW9Wj4fCqyVSxiRCgIhOo10rDbSbph7vYimJ9ggBe+6Jh
         cpXA==
X-Gm-Message-State: AOJu0YzFeSF2XGKZn3YbMHnhJFM5he1II5wPKlPx4UQDaqB3wYYfcj/w
	9HZD1gCQ5BfbWb74PsxjaKPsvpYwWzmqnomn4FUkDx/dxkQVE+LLfqNPS4mKQJdSlA==
X-Gm-Gg: Acq92OHJaFhN4I5mTd0EeMuKcH9AoiMpUxbaeeFag+1rI3M5VeSlgGb85XLWVHTRkUq
	LkKaXrG+JXRlMmo3A4bjhdeIOWHR4AynP/3WlFxKs6J0U2srsek9jr0urJXKLej2Al/nhQXoviC
	ZGp3YDniMdZIECYy13DxeGHtAMfZo3AEMJktEmNLqDu6D+UejV6MtHVAdgQDoXWBbe7S60MPM6K
	KsOXLA3jycjUFganguYJCGmGFYHfNJVnOy5JBY9+PIMBM9JiokaEprSlLX+1O8v6WHq1RQ5QIK3
	cLK8nhJoVjkYzGPC3JbHo39RE/t+DU309U6bJltgrU5Qiqw5aUjCQyTuHyzRnnLPZr1AnGlNr/Z
	rzt0Ivzdag0AlosrYufz6lX7G9shXTV5D5gjqgNWWrHovEER90uRS/OTAU1KwruID7LQ+Y7Hy6U
	2Capv4ygDUeygqz3/8TXOdLsusvaShiOlEvA==
X-Received: by 2002:a05:6102:149a:b0:636:46ee:2f10 with SMTP id ada2fe7eead31-6fef0117841mr3978513137.9.1780694568875;
        Fri, 05 Jun 2026 14:22:48 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb551b4c56sm8531503137.2.2026.06.05.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:22:48 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next] net/sched: Update function name in TCQ_F_NOPARENT comment
Date: Fri,  5 Jun 2026 18:22:39 -0300
Message-ID: <20260605212239.2261320-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295979-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mojatatu.com:mid,mojatatu.com:dkim,mojatatu.com:from_mime,mojatatu.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CA1164B668

Commit 2ccccf5fb43f ("net_sched: update hierarchical backlog too") renamed
qdisc_tree_decrease_qlen() to qdisc_tree_reduce_backlog(), but this comment
was missed. Update it.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/sch_generic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d0ca932b1871..45a1e8c78222 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -86,7 +86,7 @@ struct Qdisc {
 #define TCQ_F_WARN_NONWC	(1 << 16)
 #define TCQ_F_CPUSTATS		0x20 /* run using percpu statistics */
 #define TCQ_F_NOPARENT		0x40 /* root of its hierarchy :
-				      * qdisc_tree_decrease_qlen() should stop.
+				      * qdisc_tree_reduce_backlog() should stop.
 				      */
 #define TCQ_F_INVISIBLE		0x80 /* invisible by default in dump */
 #define TCQ_F_NOLOCK		0x100 /* qdisc does not require locking */
-- 
2.54.0


