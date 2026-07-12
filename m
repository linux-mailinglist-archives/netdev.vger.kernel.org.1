Return-Path: <netdev+bounces-306920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9dOuMxEOU2p/WQMAu9opvQ
	(envelope-from <netdev+bounces-306920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 05:46:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29140743B73
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 05:46:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LxdO68Hk;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306920-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306920-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209A030160DE
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AF3274670;
	Sun, 12 Jul 2026 03:46:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C392AD37
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 03:46:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783827962; cv=none; b=Hebaqh1OkO+db4304gehBt03HyC4zmzXZyztJ9vWEsD3H4zgrfg4FhA36LIh8oOUBKFFkwCGBOcA92KC6exkZrMHIGiGW/YQ2JqUEA3SDN6SjTpYNJhL97wHbvGxL5mfKP6k2+rZqxPk0AV14fmVvUfuMxTYy/brvZDozX7Sl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783827962; c=relaxed/simple;
	bh=Qfc6vMUGIcxIJrJW+TuqjiyNUPdH0OcbBhUBq1FyOZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nBG4sPbZ14F655PKaAt3kSwRtlS0UOWCF1bC2FPZ7Gzl14pMQki7+JOW9psyqJ7Xpl8K0pHA6p88moCQq81lKVsCl4aFKaOKFcsITNRrl7i2ayyt46G4HZfbjqWriFF5vWUJYFpnI6JrNxZdwC1aQQ30VGFWX+ey4o7T3HUDp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxdO68Hk; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1788536a91.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 20:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783827961; x=1784432761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o5XKQUUXHAbUeA3WN7L6NxqU0hXLMQd2VjUouTX2jV0=;
        b=LxdO68HkeEBeczgjGU33BIrlrNOThBb1D9miJnC9T25ZOghD7DOiTWZP/qeN6657cl
         sH2qxj1F5eTKXwJfpIB7qzxOr7Bmszr+3WOjx3IKBBsbEbNbanxfqXRsO60V12gHenp8
         QWqSzRpzj8ejoJVKm1Vgp1rZuoVfUUewy9tHetsFdBPt7J3awYwWLBFBFizfsmV+rlo8
         /juMgh+UelzR8iv81pioVaxIKkW38ZHEPL7VHdjpGbv5t/wIjg52r57phhlCCFAHCvCa
         JxAJl24OEi5jx95ormFoE5Ye2bugOLd8wHYwHmnKcgeVnkGXp0BzsRpL9v+DfBXDJOFZ
         NrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783827961; x=1784432761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o5XKQUUXHAbUeA3WN7L6NxqU0hXLMQd2VjUouTX2jV0=;
        b=meKrfqPuyj6lmhENnyh59taYGYKHeFBBNt0zLff7TV+iDYfRUeVXOccJ4kLfoXx6v4
         vzcDZnJBljaOWNmQcBLbnlGZJm3x6ka5VtmZ9UBeatLAAnH6MMIOJaHAPAQ5rXOBzh63
         9pGZXQG6XJRpj35Y973zbHbs+/8RcGK01s4OB4sg7uTqm0yUKP2hSGHt50SspGAyxwaY
         ZGufo+ccTtQLsmeLRkEJs31kqc3fginAA2w5L4i+lY8HMbXmpWu1/AosdnLVlm+1l13n
         K5TRULMHiyi3fgQcw8MwmUMa2wG6eoKyoExs+5IKB2wTPT41hUmXgF864dCED0bwOk3i
         8PuA==
X-Gm-Message-State: AOJu0YyOg7WXn/FXutttL+szJGHnQdNmnZNsSh0sAWzeQixoaew8T7+m
	DVIW2IwzBc+Zqbf3eTwGqhcufCBjf771JT7FX5GjHMxjSd5fvQpINXTfGLmogGQku2o=
X-Gm-Gg: AfdE7cl8iFuF+F9qFmBsO1abzNGKaQJSa49W8GiDDRGpJWQa/cW+234kaoUO+V+jA8f
	p78wWQGw1momqGm+bruKx8p9el4gfRXf1tINqtEc/3ThTnxWRd+U97GCa9kEyaSSRD0KX4QOHuK
	E6OWp5Vb77r3dAFrriO8tIQ4/S1JVwBAeQgV8lfETfzm//ECV+Ls0DlwqMT9A5+QL6lGhogOyLG
	W9WRW3Moxeigb8FwBuwhvCyEji4koQ2+p7CP8SG8taiPQ0rGFNCjAYi01/cdzEg3hXbls4/QcYp
	qCjrfX+rJ/eqj6jZJipzYJWshxAF1D3Zkkaq3fZepdY1m/HDsMslJN6RFQf07YKBUzLf7Co/JSu
	9rz/VAyX4ka3S4RjR0snvnipRZC18ugspQPaKMeEkftX/nH3VbnOhrQIRQ9TOwvXsWPY5Hb3cMQ
	+9LR8UvN6N4gTo7uagx72w9PvIC0XfjITUaPAgLIypJlCegN4=
X-Received: by 2002:a17:90b:4e:b0:38d:c0f9:30be with SMTP id 98e67ed59e1d1-38dc77a74aamr4639670a91.38.1783827960814;
        Sat, 11 Jul 2026 20:46:00 -0700 (PDT)
Received: from Gris-WS (gia.grisge.info. [67.230.185.89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b9ca880fsm15740932eec.23.2026.07.11.20.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 20:46:00 -0700 (PDT)
From: Gris Ge <cnfourt@gmail.com>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Cc: Gris Ge <cnfourt@gmail.com>
Subject: [PATCH iproute2-next] Fix netdevsim switch_id display truncation
Date: Sun, 12 Jul 2026 11:45:17 +0800
Message-ID: <20260712034528.937880-2-cnfourt@gmail.com>
X-Mailer: git-send-email 2.55.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306920-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cnfourt@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:cnfourt@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cnfourt@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29140743B73

Problem:

The `ip -d link show sim0` against of netdevsim interface, the
`switchid` only has 62 chars. The kernel `struct netdev_phys_item_id`
confirmed the switch id is 32 bytes which should produces 64 hex chars.

Root cause:

When `print_linkinfo()` showing `switchid`, it invokes `hexstring_n2a()`
which output hex string to `SPRINT_BUF(b1)` including trailing NULL.
The 32 bytes binary need 65 chars including trailing NULL while
`SPRINT_BUF` is 64 chars.

Fix:

Bump `SPRINT_BSIZE` from 64 to 128.

Signed-off-by: Gris Ge <cnfourt@gmail.com>
---
 include/utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/utils.h b/include/utils.h
index f0d45bad..c451baa9 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -39,7 +39,7 @@ extern bool do_all;
 extern int echo_request;
 extern int use_iec;
 
-#define SPRINT_BSIZE 64
+#define SPRINT_BSIZE 128
 #define SPRINT_BUF(x)	char x[SPRINT_BSIZE]
 
 void incomplete_command(void) __attribute__((noreturn));
-- 
2.55.0


