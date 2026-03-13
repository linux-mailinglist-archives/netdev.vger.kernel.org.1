Return-Path: <netdev+bounces-267594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBTHDgB5tGmOogAAu9opvQ
	(envelope-from <netdev+bounces-267594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:52:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B76AA289E8F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54CCF31021F1
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB9437F8D6;
	Fri, 13 Mar 2026 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PIRtgLFT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8B37F00C
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435112; cv=none; b=qN/dDSQW6dLhBSv4xj3wZV4lVTz6WK8jChr13B6Ayvq1u5Bqhrg3oz4Lr77/BmAOKjLk6yL72UedRYhKOGFf1tvYEAEqPuXOZppyPowJvn1yp+Xtu3RNv90uKzTOglWQjoveX5aJaRvef1b/CGMzBdtU7JxtrJzxTiIQDiCeZqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435112; c=relaxed/simple;
	bh=ORVIj64W7VWD/p2asQ9JCzIMDvSQTNmZHqK+BXBHmx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meNzevUuAZI80qV2ugo9da1V/DIHCxV/VnqR432hmJMZI5MtAC01V246UIy5sBTn4YvOoxvitK0C5nnDIIUvK/yvHt8A5DjadlME5YiLrkllNKo524BYNVYrq9igQtyC67Jce9nx7J1x8wNuueBWJhrHdao1gF1OVOgg78fJ6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PIRtgLFT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso2697226f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773435109; x=1774039909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU21nHtfc0uUOnrIqrZQvQlu0yPBD1nd/T9GGkWWTvg=;
        b=PIRtgLFT8xsKmThkDrnvqbIMUCzxHmpOnO+onLMloJfPB84kYcVz4hX9SzEoVJQkmY
         lBatNlqeshOqsTgwLIvKHC+9Id5kCUMY+YYjpMm3kK0eRhLC5wfm7b7q/uP1mJgbezT3
         YZOMH2CrVbUyo7oUPs8YnGS4gfvWwqRlo/k1CJ/8iTvhjNyH5Nbu9KX+OBt0TKKZ/I0Z
         cLQdXjrAKKlqzP3J3Ikn9zpjK0BLucIObb3DmrZqdGMmqHvHuqE9zShClAX4TBbXh4XS
         Cm1LapYnNplb5RzbwNgXUxy9jm08s99BDfXKP4L7U1gvzIcPUcCe3103yvTuk3Z9JPFn
         Pyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435109; x=1774039909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iU21nHtfc0uUOnrIqrZQvQlu0yPBD1nd/T9GGkWWTvg=;
        b=Y+J98K6CI+bU8fcog3mV4+1RaLieJpiYUp/707b/Ef8UBhtU3IAE72Ur1VV89diOdd
         jrv5qr857gbogMsC/UfikzyST5OkMrZRGtjIzR9LDrYPtMkXCPOCaOlTiEIPxYYkYOPx
         X68jWin5HTtKssJ64r1HbBmSgE9PoINAYpPoV3KtrOialMYHkxV1IrFQDToONpW8NCC4
         nEZGSjyBWmvXs3yDsipCYeoKpLQK66lv29pLbizezZ9hVGIc/KlklqyjQNiU1yWgKuig
         tWww6Y8oqK9et1QU64dcq+o3unD+pmz3d8/WKyGNTo+ddw/D1vXvKUyUq6tDhxAKD6hi
         guTA==
X-Gm-Message-State: AOJu0Yz+aOm9xLzptznLuxLi6VII53cODaevXVVXA7Jl5sE7PWTWoQsl
	A+tQUJs8gMQWgpIA0lztRami2SStMJq6j6XOiMKTy7QGswYT/s1jTQc3vDmTy3r8Bqy99F39TVs
	uPhltbWjTraVD0JDA6nCmSEHuKrJ8eaJik+xkjJrO771z8x0+Pz014gJ6MHthkKNK
X-Gm-Gg: ATEYQzwCdCQ+D/FqS8XMWmPJQ7qfoIcs1UrZwFoFrBDKdSdb27Q+fbcSqidVpsmjV7O
	AOnJtCYgra62McUC+4hdkQzurmWChYseatI7wJzzjWYGLBMqNzACKSYtgGWB4w68lz3iFznPkAJ
	bZvekLjdWiSYDsV69GWSSXZV3YjSbPT8Plr43imqPLSM2R4CNTPhWhKm1PC17QPVKquIeTqbuZ7
	VSmPdzJOXN0gE/oGXR9oeDPV5BjHBRQJnYHwUnU2GDcrmBREm1Ozz9sIsCokeWPh0aF2AmWYJTl
	NcdTgc+keS5f8i7vIC7n33Qr4+a6LwPCQYZ/wJxdiBiPm5o6rpyJdzivjvzQ+2eZ4K6wgjhKNL8
	LlO2QqZhIbLW6KhdLNU4wNxFvq+5O3dqXzNAK2PJof+/P12d/gtrCTEdHaAQTj2chFoV95eqs47
	pB/Ny5J8alB+rpWV5sEW1ELbTivTck1r214OYZjVsPzazQ2dg=
X-Received: by 2002:a05:6000:2c06:b0:439:ac6b:dd56 with SMTP id ffacd0b85a97d-43a04dcbad8mr9274022f8f.53.1773435108927;
        Fri, 13 Mar 2026 13:51:48 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:9684:4355:e76d:6ae9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273d9sm23120468f8f.34.2026.03.13.13.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:51:48 -0700 (PDT)
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
Date: Fri, 13 Mar 2026 21:51:31 +0100
Message-ID: <20260313205139.2950-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313205139.2950-1-antonio@openvpn.net>
References: <20260313205139.2950-1-antonio@openvpn.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267594-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B76AA289E8F
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


