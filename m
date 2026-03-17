Return-Path: <netdev+bounces-268542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COOVM98vuWn4uAEAu9opvQ
	(envelope-from <netdev+bounces-268542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:41:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 747672A820D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD2FC3012BF4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68243A7595;
	Tue, 17 Mar 2026 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dQvsFc0O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D730388E65
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744035; cv=none; b=RIDrfbExi3hd0NTZj/iWsUYq7WKy8AFm/XcfrVMPf+1kVClwFggGRntnccuwq4c6p1UfLyHKUETVLcUb1crXe9iBs327Bf8OiTB7It5dJQXSIDWhUpZC8NWJzSZlgj9mSPIEFyv/CSWuud1kKZjNua8IeJFlZukBgqdrKfbSvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744035; c=relaxed/simple;
	bh=ORVIj64W7VWD/p2asQ9JCzIMDvSQTNmZHqK+BXBHmx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtQsmY556RTS5mambHQigUaJBr/kUxICIxczPCftNv4MzdHZackOQkaWYi1fA+ICWj3479wLtsAEoJKq8kwlGkTW4Xh1RL7x97QVSg2/J3Snjee8TiCdj5pH9oJ+V7/5a3uvof4PL6HEyf5kGyO9o7iPOyVNI5PISM0JFkaxvZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dQvsFc0O; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486b96760easo3632655e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773744032; x=1774348832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU21nHtfc0uUOnrIqrZQvQlu0yPBD1nd/T9GGkWWTvg=;
        b=dQvsFc0OAhzSAznJ3mXUTR2qotQvKKKAX5ry1lYeRHkT5zC7f8tG0SBMTYig+Wx3JO
         5l2DzKm/W7TJ+SV81JwnQDyxKfR0sJcLpEAMENqnJn6pPKDzikujxJChDbH3zYTUAK/t
         ddCYlMLSxhB0iHAFY8pEUWFDszBs8VV9HXvId+qbmIB25pBiay4bI3OP/7U7wtFv6/YV
         EfixbfEWQcNvZEmi6bvbVoIOYqfyC+l+3ccT89Ff6KQxdjKX0qlxcC0zM4tF5q4ToqP6
         SqNHGe9aqrlihkEWZWSJFOSgLONAdE71J0Vogw7oC3VEdyF0R0OHgU65TrUCGVGzJ68/
         JzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773744032; x=1774348832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iU21nHtfc0uUOnrIqrZQvQlu0yPBD1nd/T9GGkWWTvg=;
        b=T8CGsfOhvYYGELdnn++VFZVQdNDjupnod6h/244sNHrnj0c3bc35x+8TIU7wK2ldA5
         ZIJm5l2/fTkEyhkBErK03HII8wc10fMUY/wvXf23viWNiGxxBX6A+u0iQN/JRHrcOnZk
         VYQO350ZDiCcTzq1AVNga9uek0xYdzdOAkveS1OOeVXe5lFF1KJFE42929K2Up8FyzKL
         xvqlOtOIgCs6u8RGt4/V6w7Z6YT+akWDBMuBVs4RNmsL2cjB4CMAJNIz7PDvejWcz4J/
         zPdj542iz0I8bXlYHp7ynFKrLQzaqxP2zZ03/8Tx+bMzVr+qMtEizBL7EBmyCsm3ZOwz
         1ALw==
X-Gm-Message-State: AOJu0YzEHltShcxgwTdMlPPvzjoVIF2lqB42IDW8g8k4AVcTUiYuMfPn
	Hsbkc3ZWP5AP5IqPlTgRD93UHjaOnF9rjVYehP59UubLz7oMsZX44ZYM6eAc82kg4G0BWN4yHcg
	ZA7IXgDLSx/D53WU8EjpQgDdVrhE7CauxoZdhIWxiu80CveIajKPoUCr+zCKQZb2U
X-Gm-Gg: ATEYQzwcD10RJmrpsAbbOI7/WUaZVdoQbYgmgbGOvzuKUD7kgZaIFqrqc2R7TjHSoSe
	NnpHS8hVwZVDMP0Y6ZPbEC7GRLv62xyA1/FRKM0bYCpRkeAMx1bgo5OBb9+1DF01Ub8mTldg4ji
	zOlPvcuqiVDRXXQ2GlSPxrXYhL4uPLFWaXdd0SD03xxn0XX4FNxhnQlDiywqDbW8PuMnd50X3N3
	P6KMeZTdwF75WtVjakm/BXSm48lN7UAZ2+jY0xw7HV/Wtw8SDwcYzUbT+zIcHcQbjlgRuUUeq7a
	CQR25hyN8TR78BqI90G7tv5QJH5bYZZxSoU+Vamfo0nu+A30fRoEAz25xT3Jqtoh/gvTp1FV82x
	I9urcPTsPxJUgO8IfnyN+JDqs+ltkyyg2YdWl1yD4qCQtbYlu9qpmnKihU2Jf1cITsHa4WGa0yi
	D4D8Ph2w0+MShTzqCPR3AVue0cnOcwl3kG9NI=
X-Received: by 2002:a05:6000:2c0e:b0:43b:50bd:bca3 with SMTP id ffacd0b85a97d-43b50bdbf28mr326844f8f.1.1773744029306;
        Tue, 17 Mar 2026 03:40:29 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:4f22:3f9:13dd:cf23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm49948215f8f.31.2026.03.17.03.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 03:40:28 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net-next 1/9] selftests: ovpn: allow compiling ovpn-cli.c with mbedtls3
Date: Tue, 17 Mar 2026 11:40:15 +0100
Message-ID: <20260317104023.192548-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317104023.192548-1-antonio@openvpn.net>
References: <20260317104023.192548-1-antonio@openvpn.net>
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
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268542-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,common.sh:url,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid]
X-Rspamd-Queue-Id: 747672A820D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mbedtls 3 installs headers and calls the shared object
differently than version 2, therefore we must now rely
on pkgconfig to fill the right C/LDFLAGS.

Moreover the mbedtls3 library expects any base64 file to
have their content on one line.
Since this change does no break older versions,
let's change the sample key file format and make mbedtls3
happy.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: horms@kernel.org
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile   | 16 +++++++++++-----
 tools/testing/selftests/net/ovpn/data64.key |  6 +-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index dbe0388c8512..e59271a25d76 100644
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
-ifeq ($(VAR_LDLIBS),)
-VAR_LDLIBS = -lnl-genl-3 -lnl-3
+NL_LDLIBS = $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0 2>/dev/null)
+ifeq ($(NL_LDLIBS),)
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


