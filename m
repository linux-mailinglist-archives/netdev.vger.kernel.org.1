Return-Path: <netdev+bounces-274398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIIMD9cWzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:12:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F83384F44
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BB2F3031F2F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 07:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665392E0B58;
	Thu,  2 Apr 2026 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSjxZgdr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A633985
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113499; cv=none; b=ls1aBxA/HegMGmnPf45q+E0fZSV8m/6hLMHFVnPRjYjpEWRqYp6vgYVZlUAJ5ZwbqFwrP5rR6vUziFkSnVDLmvuO+GF+I+B1yHFJSU5gJKi8acseXp0jz4eSDHD3VE272t7fMDl/bx1pduh9ZaJBmTLNfPcCtqEEgj31phlyd50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113499; c=relaxed/simple;
	bh=1TSTMqOm9cmSJ4LczUj2OiI1xQHECRu8PZ6KCLgd8qE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PjSSlqxnhgEZGqP5lBRejfBSG5swOpfwT3B2QM31fjpIMRKA6+vE8FKJC+wFjSlK3DQUgRubDakf4nxLe63BYifH75lSNTITb5RyMybidiOYLwQRAOFHmJN60jhd8c5GbfXgB+v9UYi+6d6QxVTfU2mt3tTFXTmwAvf88g8y4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSjxZgdr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b240d753ceso1366935ad.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 00:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113498; x=1775718298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SqhD1rqHEnhQYdw+1/ZccPF9S9AeJH2M51VjBbKaEow=;
        b=YSjxZgdr8mjyfrYRK8WfizAVi6UaMq2lYMwnDNMOIQBBpNcjmpbwqGRaBDJUM3uDXa
         dXg1iy26EGvOedFTEVUKpQ+VzkdXkCc6CzzDKX+1GytSkzsmebB/wz41zkClvZeBs2xv
         TVHY1HKaA/0VuyTDek7ZCpg4fQZdNWT2KU7yw0+FuBKpaxap70ykM2385dHhJsUKbpPZ
         TYspX0tD1UpvJClDEVJW23726zIefDpt1wV6QxUXeofdlTKYjKSiLXlpI8RXUibMCZqT
         HvRwdi7Fsz/1DfFy03H3e1S4jfSJw7/74lwmczUA6sbyCqX21BKU306CQcwRT+CCRG8C
         HRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113498; x=1775718298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqhD1rqHEnhQYdw+1/ZccPF9S9AeJH2M51VjBbKaEow=;
        b=iIQToar331tm7uuNArZ87RWFE8ljWkmmGlDapbhhRCNIbpjfdJJUm2AHDt0x6bRix5
         gKZnO/M6bMnWnF7GwZjKT7152dtQM22/jIsQk6aHw1Qeady8oG7E4dcK05Jh1CSWYDhR
         oYB1lk23E7Buly97EgWve4pauI1xcFVHx4VtzVjwrNfLL92xKhLewFFpbZ8TGEqPbSen
         ya+SjWw/bak6lVxQs0XB+4oh8MwW1BLn70ofzLyLuFMVVH8KgF1HHJJfZ6FQ5zbz2fgx
         CMwLZmGOjanslpdcH6xNsnu+BEgCSRYCO3qUF5qEwIXq2UzRiwdFyBmabHbi0g87AnZx
         njjw==
X-Forwarded-Encrypted: i=1; AJvYcCWfpeDVu18JjpVP9kCK/cQn9yGBy/hPeYWJleH4q+7LCiIvW3Hw3rkDGMARsw+PmSyogk2DWoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jzN9Hu1OyA5BfD/yejdnVayjqCffYv9RvSyjQKUvNMK0kpMC
	iwLtcR4UGD8Jw0APkZYnoh0KPbZDHCLoPVDac1Fu6ft74P+jUhaXhTYc1bmtjRNl7+Q=
X-Gm-Gg: AeBDiesIHaWZ4X5y5YTwUuOaZ3u9zZLG9Rg1OI5gAyUdaCK5hQg0G7TMQmoEZGSWzuO
	3fYNR+0iX1vhzRtvTaI5I4rX3GFN3AYzleqGuKhI1koROC4FzZqWJolulpHs433lRGUO/bvZnlf
	TkF7S9evQwotTM58B7z5z6RhegKMwB6geDuvs1OF3Lgd9bFGZPN7Fa3kz2pnYg3zVaoOtwiJVh5
	Uxl4Ae29lNovn4pJVlRoAwdQs+XIRhnhWdcolfmBUGoOn59uq/DRie4wRh7PsOVCvBtcOM/EXxo
	IuefOodEunFu585P8ikQZ5cPWLPG1eDTbmys49J8KLFueTdWQ+xZj49CSAP/L3rUkKAQhcgIRjh
	s8XpdhWY64zDVae9subw2C8qLEzZDv7CHGqNQAAC5oqpzY8tMfA+PveJL7HmuOGhLQH2Fruqaff
	BgAEoCq9S7IzsDeOR3Wamd0v7VAOKa3kQM
X-Received: by 2002:a17:903:32cd:b0:2b2:48a5:45c3 with SMTP id d9443c01a7336-2b269a90306mr40011725ad.1.1775113497552;
        Thu, 02 Apr 2026 00:04:57 -0700 (PDT)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbcafsm18486795ad.77.2026.04.02.00.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:04:57 -0700 (PDT)
From: Yiqi Sun <sunyiqixm@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	Yiqi Sun <sunyiqixm@gmail.com>
Subject: [PATCH net] ipv4: icmp: fix null-ptr-deref in icmp_build_probe()
Date: Thu,  2 Apr 2026 15:04:19 +0800
Message-Id: <20260402070419.2291578-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-274398-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunyiqixm@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44F83384F44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipv6_stub->ipv6_dev_find() may return ERR_PTR(-EAFNOSUPPORT) when the
IPv6 stack is not active (CONFIG_IPV6=m and not loaded), and passing
this error pointer to dev_hold() will cause a kernel crash with
null-ptr-deref.

Instead, silently discard the request. RFC 8335 does not appear to
define a specific response for the case where an IPv6 interface
identifier is syntactically valid but the implementation cannot perform
the lookup at runtime, and silently dropping the request may safer than
misreporting "No Such Interface".

Fixes: d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
---
 net/ipv4/icmp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 568bd1e95d44..d294666c68d9 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1270,7 +1270,8 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
  *	Searches for net_device that matches PROBE interface identifier
  *		and builds PROBE reply message in icmphdr.
  *
- *	Returns false if PROBE responses are disabled via sysctl
+ *	Returns false if PROBE responses are disabled via sysctl or
+ *	the request should be silently discarded.
  */
 
 bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
@@ -1346,6 +1347,13 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
 				goto send_mal_query;
 			dev = ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
+			/*
+			 * If IPv6 identifier lookup is unavailable, silently
+			 * discard the request instead of misreporting NO_IF.
+			 */
+			if (IS_ERR(dev))
+				return false;
+
 			dev_hold(dev);
 			break;
 #endif
-- 
2.34.1


