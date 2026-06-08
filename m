Return-Path: <netdev+bounces-296560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VVhRKo3CJmqHkAIAu9opvQ
	(envelope-from <netdev+bounces-296560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:24:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0845465699C
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:24:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=h0iPmvLE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296560-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296560-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1081B3082E52
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EA33806D6;
	Mon,  8 Jun 2026 13:11:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE23B27D4
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:11:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924310; cv=none; b=nL8Tj3k+XmN/8mjplnrCro2dtkceStbyPuBEiJ8rRPqm94Fkoj9s65tXSmuSQHn3nvXOzit2XcMS3Vnu3dkv4GvMr7A8RsezW0do/kjECZEWUL5TTlJWo9ut3P6YEgECCef3oGCrdfb1vJIm34ukZzTlSYeWFqd6cJXAewZy/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924310; c=relaxed/simple;
	bh=zahU5t1RhrDqy2kwYlZ9w9xNNdoco/26I0R7MMpsG9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lK9KjJSGUJReCDQ39lq+w6GRUQ1HCkQGBDHQBkbnkgrcAbrXm/2gZnugqJpvLryzW2dFRG25CTrbDMj/x8zkxRyH1ur5W0/jruH/WMHFfj5ftw/fX1Vd3msrrsxLoWD47IFug4TkHYo+anqlk6xW2rTBygXen7ZICWlc6bMR9rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0iPmvLE; arc=none smtp.client-ip=209.85.221.65
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-45ef74860bfso263632f8f.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780924307; x=1781529107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOgO2fIH4gzuJPh6xZ0IuyezXpRFOhq8G4N3LT7JL+A=;
        b=h0iPmvLE3hVyv2iSWk9tfue3qL4AZab0neAmDMz4qh+cAK5OLienWlsiXJn0xcty/U
         c2Q0Ssdi4BNFK1b5M1DkkshVRTdLhHGB8jfHAxlnuvH/GnHXXpKIISG+CJqQ6NwZJR0e
         s/cqVWrv5dA4VdHfpzFF0IFVa6UQ/COskYs5eKeOgkyo/ZbBsNlrXFkUXQWBTjvGKJw3
         4pJ9KaH6QpwA1Fe9amNPH4i/HnIUgyr2yZYMZwnawSv1TOF5Gzix2mx7ZqtOLgyZDK+L
         OLlDGuQplbVCle8Ln3ys3YLIynKXNUU7zRJa1itdLvSheTgVV23ToPiSXTs4PHQd72hv
         JtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924307; x=1781529107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NOgO2fIH4gzuJPh6xZ0IuyezXpRFOhq8G4N3LT7JL+A=;
        b=C1JeopTQTGLeaSFt/B37YD3TDHDuc3/DFCGp57rpWesI38a5fXSsFOsi9UCSg+fvM5
         OJTKyP6SsF4Wmw6d+HboYuxxE++6vwrXUJjy7TGSaPp0bYNTAjUWNmRYrmTQ7QzdrbF5
         F34RcvzNdS053c5O97VNS8x1n+pIWsM0YdvH4d2WzfoQKME78nuhbE6Z83BOhk4hE1tZ
         OKCdx/H5RdazD82k1vMs8yH/dAxM8Yl3fZn12/cFRnbt2bhEsUfiZ5ctFla0iBB8LXt3
         9mqHuXQRJEXEA1s5pnTdXV7Y8Wi+RwKdznMLCf2LbGkwPJ4nWLxDqVpPMPd9DOViRWDS
         xW7A==
X-Gm-Message-State: AOJu0YwIegUNtu1Q6LuZouhdaqPLAt5nMRiIVOo0ZpZcpzL+y3+zgvzA
	xhNPQLhU2+NcQb/almMTm0JyuqSTTpq3A5kFGqY3ECmXJd5o70a2uwRPGMULgB8G
X-Gm-Gg: Acq92OEoufDowLTbEZ5adBsYSfZZKEE3qgAhRInwnQWGtqrP/tH9z2GkZa3dtu545Xu
	zFWzUYze5THuKdlI+4dmuy81iXdQz2lPFkjaNf+ANwRgvFP3opIUHUcm3R1kaVEpqsGKu87WAt6
	/TLMHXj2t6k3/RezZirYMhcBQA3g1PTgNOwbUwG8gJf64+9Vj/LqmKzz833ZIr64gWctp33eV9G
	nyprRjqSFydgVef3YEhc0PWPMRB9SdpN7j1UxnOzS97ASQ/WLaxeVV6NGVgEJNaGyqHFFK4KiKg
	Stdf0zKGjoB6s+Ej9rYzkoAgZ2RfbcjrT0gO5ONlt/ri2CO8FSVxmp3OYrNjPnPAkrbX2PqgoKQ
	MmgQt1ocgNGgGyxaylVcQ3BdVw/NGW3tt1MiitfACXgLmvR/4K7UctjnniSdbUJssj6NGGf1iuP
	oi1LFnRYT5jbpmbjkaLtvCCBo8i0O68/0UNTqaLNskWg==
X-Received: by 2002:a05:600c:314e:b0:490:bc36:9b2b with SMTP id 5b1f17b1804b1-490c258a138mr97307755e9.2.1780924307123;
        Mon, 08 Jun 2026 06:11:47 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm300135675e9.2.2026.06.08.06.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:46 -0700 (PDT)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	shuah@kernel.org,
	kuniyu@google.com,
	alice@isovalent.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 10/10] selftests/net: add jumbogram test case to msg_zerocopy.sh
Date: Mon,  8 Jun 2026 15:07:55 +0200
Message-ID: <20260608130755.5626-11-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608130755.5626-1-maklimek97@gmail.com>
References: <20260608130755.5626-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296560-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:maklimek97@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,isovalent.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msg_zerocopy.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0845465699C

This patch adds a test case to msg_zerocopy.sh that tests whether zerocopy
works with TCP jumbograms.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 tools/testing/selftests/net/msg_zerocopy.c  | 3 ++-
 tools/testing/selftests/net/msg_zerocopy.sh | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 1d5d3c4e7e87..b5df360c7811 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -789,7 +789,8 @@ static void parse_opts(int argc, char **argv)
 	setup_sockaddr(cfg_family, daddr, &cfg_dst_addr);
 	setup_sockaddr(cfg_family, saddr, &cfg_src_addr);
 
-	if (cfg_payload_len > max_payload_len)
+	if (cfg_payload_len > max_payload_len &&
+	    (strcmp(cfg_test, "tcp") != 0 || cfg_family != PF_INET6))
 		error(1, 0, "-s: payload exceeds max (%d)", max_payload_len);
 	if (cfg_cork_mixed && (!cfg_zerocopy || !cfg_cork))
 		error(1, 0, "-m: cork_mixed requires corking and zerocopy");
diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
index 28178a38a4e7..ab498c6ea210 100755
--- a/tools/testing/selftests/net/msg_zerocopy.sh
+++ b/tools/testing/selftests/net/msg_zerocopy.sh
@@ -7,7 +7,7 @@ set -e
 
 readonly DEV="veth0"
 readonly DUMMY_DEV="dummy0"
-readonly DEV_MTU=65535
+readonly DEV_MTU=200000
 readonly BIN="./msg_zerocopy"
 
 readonly RAND="$(mktemp -u XXXXXX)"
@@ -29,6 +29,7 @@ if [[ "$#" -eq "0" ]]; then
 
 	$0 4 tcp -t 1 || ret=1
 	$0 6 tcp -t 1 || ret=1
+	$0 6 tcp -t 1 -s 100000 || ret=1
 	$0 4 udp -t 1 || ret=1
 	$0 6 udp -t 1 || ret=1
 
-- 
2.47.3


