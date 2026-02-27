Return-Path: <netdev+bounces-262006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJAtKT8womke0wQAu9opvQ
	(envelope-from <netdev+bounces-262006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:01:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 160D31BF4B8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CC703094A22
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49CF289378;
	Sat, 28 Feb 2026 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Roe2MDZI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E150224E4C4
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236814; cv=none; b=RSVyuwo+qvgyrBXA2NIEdvIaiXE6moI9hYHD+yEC4l4VtHzU6Gw6UfmhVwWImFEmme+OE4EvPreEb1caQf7YYXzbOkhjehc/JL4JgOOPjdHJ8T9+nD3aPY0bTIK7sW1uhE2Rqkc3f7GGei+OJ9CELOx7HR16V5NJqDz5/dB90Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236814; c=relaxed/simple;
	bh=mMU/HD7CZewtqH+Zvd4ZWA3qx97JS6oZBhr5627HZZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfaBV8uPm8LikCKj1bnsrE5bTptawIbXfK8Qs0mGqbULGmJHKdqbgCqQaAocjLO6Ajs1kp1iON22miO78tW8YZt8Eq/nm/q+0pfTEuRGeq8ilrAN0nDw7tiM+MlWsf6H1cA/yGJWF708BigmOMNiwxiJT01i7IXoBF/nTjjQHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Roe2MDZI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48371bb515eso36520335e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772236811; x=1772841611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+rhQ7JW4pW4abVch+9uicNBzF0g2w/L/0VqI66GB1g=;
        b=Roe2MDZIe+2FkDNq2ktfGvV5CC0D4sZ4HKUj0p/ZGX4HIby1DuSlAZDyreGZqt08kS
         hOInkiqMNezgBnwn+cIsaDWsj0WCrMArdUjNcLySma953QNOC6FMsGoIP+kAOHf9SiAl
         K9kIJlRH/WtFgXMSKAfQwGN4DyWlqtXMChtFrlHsjAXF78LBNGf3YCq7L8+Wo6zaKUa0
         /nccoY17U0Q68A0tsH9KjImlX1Bs950nDZMNtRBAWqgDSjGQAjZEQiKvDjVt7BQjXGNF
         wgZJPFBZsecKLqQJTnqkTiX1Vf6dclFxcqc9YLpKAMOJ3CKI1VuOxrl0l1Gw5RcQIu4J
         VlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236811; x=1772841611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K+rhQ7JW4pW4abVch+9uicNBzF0g2w/L/0VqI66GB1g=;
        b=Peac4qJczeojyv4aLxJZwFGUoWmD1tOKTu81TdPtEPF7mmAAZWblyVrFRQU3G7UfTb
         agZseWwiUQPOUSqccHmruVIV197hP0Eo41lMtNH7dOl+qHrHEsMKEIdXoEfKCw91Q80o
         S3s8kpr5FpG5OQ//pX7mHNkwdKvsPmIQzr1wDqtQ8WZd47PTii95fri/Kcn1Sefcu0Q6
         4suT1cF1zxs5h1xK7tdSid4sBXDt/AV1TX8l2w/EbHkjB+Lhgwwa7ewrYg4ZeUIcrA8r
         8NIOkllWPNn7exQ4XaI0mvMH8X8vcWGAY2oRNG22tOXfNEhAKAdXuBeTGTDxsLann1Tt
         hpuw==
X-Gm-Message-State: AOJu0Yze4Ema85qpSO1GPnlslm8euUMkz9bnjE3DTDFzIcXsPw7tprF7
	gmHQsE8HRd2uPddBDsw3/t5GA9PGWCmFfW93IwP3VmnjhKzRiMbQRtBwvAnXrvXzFHs1Z7siT+h
	opMhc/8QzjuTZSueUaxSa5yPR17/dTDvWYr4z2ADn5oIxPZbiezQ7h6nNRIk7tT0E
X-Gm-Gg: ATEYQzzGVe/kTQcOyQKXTDlYwPZOMqN5vXdiXl4qjykj8s+4hdImdRYiblAekAV8GbS
	0rOP/y1fU6TLFn7J+CaNh5BEucKkIhSap9Ba7u5g7ngh0vU/iU6bA6TUL3BaRY3zD1y4qGpNj7f
	1XMZ6OizdlPwVXHibVGpz68XI9MACngctfufIqpW0ogGWZzHR+YZdPAk3/DnZMwO9tx6IuSszPC
	3DfBMc452Q0nOI3Eb55di6j4X8+ff2m6+z4JXfgxdONLRWOpPIDmtBp532wXnsQIm8lOw/io02l
	3IRatDd74/M5e+S+FbVN9e47A4aZG66WnpJBsbKaaa2nfdT6zMV+NIk+p8DifD+/F1byxOz1Nv+
	4OEqEjJhWR00aMWRTB565LYpoJ+aOa6ajdei0+DRRg4Y9zORnlmDnsKGBMXnTaKwXswqfmC6+nk
	uH63F7aDVy5mP+kgFhia97jpNAhj4CS7gt8DQt
X-Received: by 2002:a05:600c:46d5:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-483c9bb7c16mr71673265e9.3.1772236810735;
        Fri, 27 Feb 2026 16:00:10 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:d378:d869:cb10:1603])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77466sm94420695e9.5.2026.02.27.16.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:00:10 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 1/9] selftests: ovpn: allow compiling ovpn-cli.c with mbedtls3
Date: Sat, 28 Feb 2026 00:59:47 +0100
Message-ID: <20260227235955.660-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227235955.660-1-antonio@openvpn.net>
References: <20260227235955.660-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262006-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:mid,openvpn.net:dkim,openvpn.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 160D31BF4B8
X-Rspamd-Action: no action

mbedtls 3 installs headers and calls the shared object
differently than version 2, therefore we must now rely
on pkgconfig to fill the right C/LDFLAGS.

Moreover the mbedtls3 library expects any base64 file to
have their content on one line.
Since this change does no break older versions,
let's change the sample key file format and make mbedtls3
happy.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile   | 14 ++++++++++----
 tools/testing/selftests/net/ovpn/data64.key |  6 +-----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index dbe0388c8512..d3a070db0bb5 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -2,19 +2,25 @@
 # Copyright (C) 2020-2025 OpenVPN, Inc.
 #
 CFLAGS = -pedantic -Wextra -Wall -Wl,--no-as-needed -g -O0 -ggdb $(KHDR_INCLUDES)
+CFLAGS += $(shell pkg-config --cflags mbedcrypto-3 mbedtls-3 2>/dev/null)
+
 VAR_CFLAGS = $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0 2>/dev/null)
 ifeq ($(VAR_CFLAGS),)
 VAR_CFLAGS = -I/usr/include/libnl3
 endif
 CFLAGS += $(VAR_CFLAGS)
 
+MTLS_LDLIBS= $(shell pkg-config --libs mbedcrypto-3 mbedtls-3 2>/dev/null)
+ifeq ($(MTLS_LDLIBS),)
+MTLS_LDLIBS = -lmbedtls -lmbedcrypto
+endif
+LDLIBS += $(MTLS_LDLIBS)
 
-LDLIBS = -lmbedtls -lmbedcrypto
-VAR_LDLIBS = $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0 2>/dev/null)
+NL_LDLIBS = $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0 2>/dev/null)
 ifeq ($(VAR_LDLIBS),)
-VAR_LDLIBS = -lnl-genl-3 -lnl-3
+NL_LDLIBS = -lnl-genl-3 -lnl-3
 endif
-LDLIBS += $(VAR_LDLIBS)
+LDLIBS += $(NL_LDLIBS)
 
 
 TEST_FILES = common.sh
diff --git a/tools/testing/selftests/net/ovpn/data64.key b/tools/testing/selftests/net/ovpn/data64.key
index a99e88c4e290..d04febcdf5a2 100644
--- a/tools/testing/selftests/net/ovpn/data64.key
+++ b/tools/testing/selftests/net/ovpn/data64.key
@@ -1,5 +1 @@
-jRqMACN7d7/aFQNT8S7jkrBD8uwrgHbG5OQZP2eu4R1Y7tfpS2bf5RHv06Vi163CGoaIiTX99R3B
-ia9ycAH8Wz1+9PWv51dnBLur9jbShlgZ2QHLtUc4a/gfT7zZwULXuuxdLnvR21DDeMBaTbkgbai9
-uvAa7ne1liIgGFzbv+Bas4HDVrygxIxuAnP5Qgc3648IJkZ0QEXPF+O9f0n5+QIvGCxkAUVx+5K6
-KIs+SoeWXnAopELmoGSjUpFtJbagXK82HfdqpuUxT2Tnuef0/14SzVE/vNleBNu2ZbyrSAaah8tE
-BofkPJUBFY+YQcfZNM5Dgrw3i+Bpmpq/gpdg5w==
+jRqMACN7d7/aFQNT8S7jkrBD8uwrgHbG5OQZP2eu4R1Y7tfpS2bf5RHv06Vi163CGoaIiTX99R3Bia9ycAH8Wz1+9PWv51dnBLur9jbShlgZ2QHLtUc4a/gfT7zZwULXuuxdLnvR21DDeMBaTbkgbai9uvAa7ne1liIgGFzbv+Bas4HDVrygxIxuAnP5Qgc3648IJkZ0QEXPF+O9f0n5+QIvGCxkAUVx+5K6KIs+SoeWXnAopELmoGSjUpFtJbagXK82HfdqpuUxT2Tnuef0/14SzVE/vNleBNu2ZbyrSAaah8tEBofkPJUBFY+YQcfZNM5Dgrw3i+Bpmpq/gpdg5w==
-- 
2.52.0


