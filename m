Return-Path: <netdev+bounces-266197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJFsLis3sGkKhQIAu9opvQ
	(envelope-from <netdev+bounces-266197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:22:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABC72533D6
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14EE7325DB6D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902733009CC;
	Tue, 10 Mar 2026 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZAa9pQQe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F73274B32
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154231; cv=none; b=iEJCZp3N6tlwCejzKx52QhKMJugQqkC8zdkkP+aEUxeBXR1qEFTYsG+BSSOswzzdhvAfXaBXKNSmkvrRz748rjMsZVJmBf2s48AY+HkPxSkMffBfVHxJF9LRvZPC+4S83UNCh7p5s61ZCzpkvyjX2jb2K0IJSW8NkWSNNg/3xdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154231; c=relaxed/simple;
	bh=ORVIj64W7VWD/p2asQ9JCzIMDvSQTNmZHqK+BXBHmx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ogd5QZ3gl/rlmRkEWQJMY0SECfHNugok4x3w3XA/vh+kHBYwfyYGnJr6RMp2KNHD68xXSffAxcnfSODLVFidkvaPZJBDppkKZXSwrRG4pW6Id8BDy7yWQ+6xQ/BKXsLZybVdaGd2DJpj0Lq0p3HhgL8KOMAUhpY+fhgDEXKnfLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZAa9pQQe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c56e822eso7503696f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773154228; x=1773759028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU21nHtfc0uUOnrIqrZQvQlu0yPBD1nd/T9GGkWWTvg=;
        b=ZAa9pQQe5Kivh7tmtbEAL3boM2fb9qH8oZTXvZUV6WUyMGkx9Ztg2Lg0VVco4T7bgt
         kSO4+SYZ5rYRFUkppSx3p9i/OLv/YBwMxtSDqb4ZvgOfBmVgfV1VcGRDA15Njy/el49O
         2paHpYB+PBnFv4qqYC4spxA/hd6qG5/uwm3QUYh8znzmDV+4R4ZyXfnxk8TgW7w8SiCE
         xFZ042ag01viwHtis5tGU59n3oF5i+sC7LStWNADTfHEp4QAM/IZ0ge4ByfePP3xvRat
         qwND1NljyIyCNUE5UiSy5pp8ZhbrKN1qnldPWqebmKihaQt/oVb0NmK+KvDUePpP/eeV
         4qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154228; x=1773759028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iU21nHtfc0uUOnrIqrZQvQlu0yPBD1nd/T9GGkWWTvg=;
        b=Szh3Hvwk3qSxnRRhmBtuK7XVV8yUO8YGVD4jPKjPXMgHUOyYxHkdhi3EkpCvc2+yy/
         kvDffZvcVSRvtya0jl+rSdeg1u3tr4WZZP1rQElweaIm5JXv7j4W7xyfXXc+6NePWdK3
         iG1CV6LbVgf+IUE+CevzM8X3VeAsRsM70RopBBApEtONjX8ZQbRgY6l3wRKnQkLXe+VE
         FVlyaYKxiB/QZZNTiOUrqGueMYOJ0IJYjddgl2jaC9Zx9ok2thIG3E/0v6cGRNHdHZpK
         nxdJjXzwxdFuIG4r4h3enllVMQ9PxNbfJphfu3PVOXm05n+apty5O4lCXeuHFUP9Gayu
         OabA==
X-Gm-Message-State: AOJu0Yz4zKlf0Ii0YwwHAfgPszQO4VMQncYbUdeRQhos2H/e+6arKb0a
	lvw7vLMbsBUAFwHUrZ0yY0ksBgf3m8YXP2TAp8bS3zfjM1QPb5Pp9JXRRbR3JBacN8UbpRhImEM
	EFphZlyd5LMSrp3RruG3h8lJeqxIqX3RslmPIim1rRtgK6QP+MUfSJ+EU3wmHt1U+
X-Gm-Gg: ATEYQzwysalVUbh4VI9UWituAT/iuZF4zdiKlcKI90kqDopbzrbGvNrV6JNDj57lvQI
	s/no2SQKgNi6Eq5CVg4Ux/Mq7FS4yAQBzQQp5ntbrgq+Gr0F3fYy+jmmRUM9SnkLTw/8X7Ok3mV
	/nQXMAgcVhDCskbsAkOVWpBxr3REcRVsdd4ViVjazBvJ5EBEkHDdJnyShpIJeZUk6R2d2KSSlFU
	Rp8bLj+pUA8Q+oBhc7jX3IqAwR7ZR1zPC+8coDRiNwsVoXVVCMXtcmMHATKr7SxJXLszLgKPEbB
	SWOIsW9upMLr2NgXstsAjGiBxw6m0+vLR42JGIDabIYcMz8pbwTwSiYImXqPUGJcHryAJUQpiCt
	IT5YH8cpr912kcMUH9lizf3yiaMLi8DAee/M//WaNJaiRO7GcwwWTVJ4E/OB7zrj9lGKWlTwhud
	9xegSTTg2rP6vHhqdVcNiPcfPCyCJQyKcLCPkv
X-Received: by 2002:a05:6000:26cf:b0:439:c2b6:d5d8 with SMTP id ffacd0b85a97d-439da880b53mr27710812f8f.36.1773154227914;
        Tue, 10 Mar 2026 07:50:27 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5594:94ef:1bd6:89e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm35586700f8f.6.2026.03.10.07.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:50:27 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
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
Date: Tue, 10 Mar 2026 15:49:58 +0100
Message-ID: <20260310145006.30858-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310145006.30858-1-antonio@openvpn.net>
References: <20260310145006.30858-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5ABC72533D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266197-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,common.sh:url]
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


