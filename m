Return-Path: <netdev+bounces-269928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YChOKVdWvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:14:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 169682DBACA
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 460823085C26
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F22D73BC;
	Fri, 20 Mar 2026 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="jrTijlXq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734903148B4
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015758; cv=none; b=eN0xM1wW9FhdnFaLNS48TyVTuiChJ8PpQ97cSAOxFe91lVnCuyd2BBI1zVJAjl/onO6e+WBDQunS6D3Mb5CkWPQF5AWkt8zl1Twp6J5GZwdkUYyftZRzw5G12wUlAREWh6Bt268siDG2K9xgwJu66wDYRSpKTcUEcLJ1FHBmjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015758; c=relaxed/simple;
	bh=KiBVHnyid/175KoQibneA2tjHy3gP6LEhUa0zYra11c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/JVFRhHboBrgwCqrvC7v9SLHHKt7xxaxndPhqxMXgcEk8n9i5YtObYBaFi9SHJJy9xa9KHtvF9dENC3GNqjdMrRIZw6viWXacV5EV3sQ2oyGA3wTOP+elgZVQ74CjoxTo1c6W6efXi9RwExPngZn9zDjeyvXa8mME+9EObDrNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=jrTijlXq; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-b9793fa5371so259354166b.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774015756; x=1774620556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSfZnsUZ5ZrY37SobT5lyXeDO7LsprFFC3V8XppCRdM=;
        b=jrTijlXqX1eYLP4oXebRfgXitUDkheFXGpBgigA4A2WyrK4igo2qPsWoSbJjc15JbS
         oi+ymPxZl0/6dmeKDdv40cLpJi4cBLj4e8IlJodaIvwgraWpfREpJ3PvodFY9rhBkqoa
         gmpmrAqb8uKUfXbUzN7f5dmpcvPSDzSvz3Oi7SYDDtvDOUXT91RWcRFAkcjVgu29FgZc
         BkV4rrx/HmVc7aXW6zjWiSmHk+QT4Itdv0sRt5jYVcAyue8ggE2uIYYckuxCZgurtUJQ
         H6Lol4rsdxj1QFeFG+fbtWeh9LJf+40zlRc6EVlamG85vwlvWYygEe7PH1pG/nRG3pXK
         j1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015756; x=1774620556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSfZnsUZ5ZrY37SobT5lyXeDO7LsprFFC3V8XppCRdM=;
        b=OGEIWhH5YCEPRh3R0yTfu55zxgShBVgg5vgS5pQv+kjx47OGUAz2BJ/60YufzYjETN
         voeGK8fnUc0ZyksnZHGRCrOSRQMqdgyxzGv8UKwkVO1K+E+v8BRcS6wv4TbaIYKn4eWq
         5sKA4x5BMrGm/4VHnTpwwwZ+0ZtJSB5w2XEvRzbdqndpjtO/LxrzOJSONZbqX2zy7Irn
         90laHPRi71hhp9YYo0gaXXj8hyPsuAhrxSQkYaB7jgiPPnKpBJtdav0vyos5SQtRYKSL
         bGIR8tgRKjxVpqieGEP2ZjX+NWRq5dp2maM2UlGZ2jRBWzV3ssr0GA4rbuo0aJktQE0N
         +21Q==
X-Gm-Message-State: AOJu0YzlStPHEn0zVwEUXdgqnH5Y7yd6RcAjubkKV9HF0XuAAyxUDrnp
	1XI8c2E/Km3LjziVDnoDhb7xUlghm0sVud8s2Q78Cr2dUf5LYiZVvRclrqjfNv6XWU8i3zjkO2l
	pujK0zdXT5PhI/MH/HX5kyOAiOq2a2bvFZ7DR
X-Gm-Gg: ATEYQzxbXsuNa6vbXWUKCpIK1shpmU3JIjMuIO+V9rg0QYuq4pX3EPH8PzmBQE38UR4
	eiEDALQHwOvnRbwIlI/CUeJW9YCLZeTVt2gzwRMmc/uUxuusDUomLGjZS6FZ0UG2zusiWhhs71i
	wbXEbMOe7L2LSgJl0SbeXMjBq0usNdcbExHaNpTsRa4ha5ti9LU1EEKevSW4AJ+brfVYq/ccDP5
	yUg6pHIzKwdz/+LLwRQmW+TpYEsmfVt1PKNzwTppJj0H/3DfIrnOePbaTT1LHjZn8ujp+uWt6YG
	9n5ZaE5NB2U13liwvGr+l5tnHRHXTcbDLXvsCmSWhXIrhsbUMKAjJQ9zK3EXYqnbzBFv3W+ODQb
	5jVoLpxPngaCNuxWECU3dfzgmT7gYbsQ74EOa4DV6d06TlK92LBPa4S3WS5XqwINF2JLtA8Keaw
	==
X-Received: by 2002:a17:906:f593:b0:b98:458e:2b99 with SMTP id a640c23a62f3a-b98458e42a5mr38000566b.38.1774015755925;
        Fri, 20 Mar 2026 07:09:15 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-b9832dc69f6sm16744866b.6.2026.03.20.07.09.15;
        Fri, 20 Mar 2026 07:09:15 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id C25C61C283;
	Fri, 20 Mar 2026 15:09:15 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	andrea.mayer@uniroma2.it,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	stefano.salsano@uniroma2.it,
	Justin Iurman <justin.iurman@6wind.com>
Subject: [PATCH iproute2-next v2 3/3] man8: update seg6 encap documentation
Date: Fri, 20 Mar 2026 15:08:47 +0100
Message-Id: <20260320140847.1730633-4-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260320140847.1730633-1-justin.iurman@6wind.com>
References: <20260320140847.1730633-1-justin.iurman@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,uniroma2.it,gmail.com,6wind.com];
	TAGGED_FROM(0.00)[bounces-269928-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.891];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,encap.red:url,l2encap.red:url,6wind.com:dkim,6wind.com:email,6wind.com:mid]
X-Rspamd-Queue-Id: 169682DBACA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Include "tunsrc" in the man page.

Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
---
 man/man8/ip-route.8.in | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index aafa6d98a4c2..9f29fd436f59 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -240,7 +240,9 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 .IR ENCAP_SEG6 " := "
 .B seg6
 .BR mode " [ "
-.BR encap " | " encap.red " | " inline " | " l2encap " | " l2encap.red " ] "
+.BR encap " | " encap.red " | " inline " | " l2encap " | " l2encap.red " ] ["
+.B tunsrc
+.IR ADDRESS " ]"
 .B segs
 .IR SEGMENTS " [ "
 .B hmac
@@ -893,6 +895,15 @@ applying the reduced segment list. When there is only one segment
 and the HMAC is not present, the SRH is omitted.
 .sp
 
+.B tunsrc
+.I ADDRESS
+- IPv6 address of the tunnel source (outer header), not used with inline mode.
+It is optional: if not provided, the tunnel source address is chosen based on
+the per-netns configuration ("ip sr tunsrc set ADDRESS") or, if not configured,
+it is dynamically resolved. If provided, it takes priority over the per-netns
+configuration and dynamic resolution.
+.sp
+
 .I SEGMENTS
 - List of comma-separated IPv6 addresses
 .sp
-- 
2.39.2


