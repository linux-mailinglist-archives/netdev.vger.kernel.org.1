Return-Path: <netdev+bounces-244500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD571CB9010
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 15:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B6543053B3B
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F93F26C3A2;
	Fri, 12 Dec 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="k1O/WETs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49ED18A6AD
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765550995; cv=none; b=iYnaM+8rC7pO+wFd9rzZECuqAnJaTms5ugeFHhRInv/cyX1P9E1rt5Nd6647OZUArKTNUve2o4QcYQHVSR3T/aioZrzgr9uDMkeXEw1b3qf0ary3QDlFdslbBP18Da1GYkS5fJDzxN4RTvmh8rKj17AN3TXepu5iNFC856/IuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765550995; c=relaxed/simple;
	bh=lEOPbLZ8iK9A4EcSY6GtElHcm2Z2lNDMRR0j2H3qVSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzwnX0c17ezh0aBH26seo/vdCYaf3lcumm98i9Z4cvFo9AxNtMr6V3kJ/M9aj+Bp7J5okRd1A9BzuJC0NZHnuSffzwcE5m2sgl9vhYkqsUGNIgMBq/7v9C0+UM5SoW/mwg+xCX5KC8PRUULzEkvo8OqB7TaTCapcS/eEPzmNbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=k1O/WETs; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 331763F829
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765550985;
	bh=EoivPywf7QXsLeTHC8lXLQ+O9tet6+0xD7qUCbPDZtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=k1O/WETss1W1yE0mVYBu1vv2xO6Cor2Jei/t/Uyk9GXHVmXwsyDX/sWT65+Q4ttTP
	 FXCKmJ5wIZFi9sVQey88GDU/16M2wkScI3ceLvzNWLznSELLRzbFR23sHRdCIxZyzp
	 UrQi7sh3l88UMvHcgda3kACec188TDgkW7JKR7yIRj8rCvxvZUC1vTn/iV3pylTqvs
	 oFmvl3Z23NHEdPSR3503joz1QsXu2HX0zTzj6dkV6haccck/3mtVlEDUhgZioFhG0D
	 gpR6KZr07qSLI2a5miuvoyWO8mp/G9g5+uylnLyEMSkPMMsW76stt0Od9Fu/CQq+Zg
	 IwjGDA7lawRaI+Jj0iCZJ/ti4+v0+gZAW0BQUdV6JsPcdnzi6fXp2mUJlEsie+N13n
	 l1xVHru+BHJ/INJHrZ3V9m2oiBhLeRybKbykgZd0L2D/ufaR9A/5IQkAKc5Del5wdU
	 81yfuBuv+CqA5KFxuhAp7QVlQnl72WHGjOR02phakgPHlv9qTSx5mG19ABfj0AHZis
	 g0wb/k1aznfEAYHSjOE9131xynZA7fqmv8vp515Ghah45U5XxYDXCTJwCodv2u3q/k
	 g4gqmFNG6AHBZ0qi6YXVZqg9zCcodmJ0bmGc7hop5CjbKNl65DaGeFFQtzcqbFMyOe
	 CC+VZM8kJ5yHRyfmya3FowBk=
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8823f4666abso26089546d6.0
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 06:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765550983; x=1766155783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoivPywf7QXsLeTHC8lXLQ+O9tet6+0xD7qUCbPDZtM=;
        b=m6HeLtEaW6yQI0Z01mMwoTp7hRHIKjwzDJn2tNSotGS+AdCxL7mXybYOwsG4ufRSM5
         OUF4sTsHHNrseukLgihrlSVEs+np6Idfqs2RBW2M9IpquzQWB7CWWesBwKYZ88qoopiY
         H20cBPEJX6p02p0r+S0y8aIoeO3GzZF5s9gBSWvC85OFRkc8Q6SSy57crr4Fjons51d+
         ayX6pMrj+6BODnPWHUpfKEOgIOWVOe6hWcD4xcGQIpIEGwaCM/nblCR7glzXDluDUjJQ
         DNU7csO3Kho6kbQdmKPi5pRr1JQNw/vnudyfxSKjwPDSbulnsSyBL0k8xKv6dQMW8g/b
         Cs7Q==
X-Gm-Message-State: AOJu0YyJ2wUl8bXtyuq5U2UfaDEZuf5vKX90W40Sij9+e6ZTNVAHbT3N
	xZK8NJSjeuzh+onQSasizsc4QYhVMvBiiOwRip63cE2YE/93aBQu9wAXvMYVlksgreMjELi7dvw
	++Ryb8lNNS+fFjQA4hUBRz1eoERBDskwEBOHPkXIgD3LyU5Qq1V8kFPyN0kPuIsjKsLrP0iJVNk
	Hrd2KP/w==
X-Gm-Gg: AY/fxX7SPSNLSHnNs21aK9y5jy/qsblXrlDzQRyMaAsoZwATNTF7SGxsIT8UZnlljwx
	zpNPBQxDUCtIncxDX4Rb3hzgw1PokEeevdCnrbNxQnqSl6IzwfHudD5CWyqi2djEjVdfZmjMmus
	7tLYV/b/TfkFcAbKwfdh6YvQBuayqReYfmqWraID031LIxDvD6mqlMSSF/lXE9ckkRpvv7ZaVnJ
	mfH0anCpxW/gYWa+8WDExPKsdReS/96aC9UouPN0XPxR7Poh5Gmiom5U47ilHTa/aHvype9XhRZ
	NhxIwjYAL4GblXoulWMgzU+TAv7Q1qc5AkqclrVfIFOc63EvHOOtFpnuDujAyyW8pf+2pCLOBNm
	4TQ5Qqox3/qLuAqyXT5JoPktjVIi0T/BdYVWrOSVaQdZkv29bEe0qRcVw5/djBuln
X-Received: by 2002:a05:6214:5b89:b0:888:633f:391e with SMTP id 6a1803df08f44-8887e46e988mr31021096d6.67.1765550983607;
        Fri, 12 Dec 2025 06:49:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9wmfgV3BJqpriF+99pAJs5NZio3o6jMd/99nKRfDWX1FmNlTIdtjSoVnEpsZJII6jI8LPjQ==
X-Received: by 2002:a05:6214:5b89:b0:888:633f:391e with SMTP id 6a1803df08f44-8887e46e988mr31020866d6.67.1765550983276;
        Fri, 12 Dec 2025 06:49:43 -0800 (PST)
Received: from localhost (modemcable137.35-177-173.mc.videotron.ca. [173.177.35.137])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-888818cd87asm12157646d6.30.2025.12.12.06.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 06:49:42 -0800 (PST)
From: "Alice C. Munduruca" <alice.munduruca@canonical.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	"Alice C. Munduruca" <alice.munduruca@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v2] selftests: net: fix "buffer overflow detected" for tap.c
Date: Fri, 12 Dec 2025 09:49:21 -0500
Message-ID: <20251212144921.16915-1-alice.munduruca@canonical.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the selftest 'tap.c' is compiled with '-D_FORTIFY_SOURCE=3', the
strcpy() in rtattr_add_strsz() is replaced with a checked version which
causes the test to consistently fail when compiled with toolchains for
which this option is enabled by default.

 TAP version 13
 1..3
 # Starting 3 tests from 1 test cases.
 #  RUN           tap.test_packet_valid_udp_gso ...
 *** buffer overflow detected ***: terminated
 # test_packet_valid_udp_gso: Test terminated by assertion
 #          FAIL  tap.test_packet_valid_udp_gso
 not ok 1 tap.test_packet_valid_udp_gso
 #  RUN           tap.test_packet_valid_udp_csum ...
 *** buffer overflow detected ***: terminated
 # test_packet_valid_udp_csum: Test terminated by assertion
 #          FAIL  tap.test_packet_valid_udp_csum
 not ok 2 tap.test_packet_valid_udp_csum
 #  RUN           tap.test_packet_crash_tap_invalid_eth_proto ...
 *** buffer overflow detected ***: terminated
 # test_packet_crash_tap_invalid_eth_proto: Test terminated by assertion
 #          FAIL  tap.test_packet_crash_tap_invalid_eth_proto
 not ok 3 tap.test_packet_crash_tap_invalid_eth_proto
 # FAILED: 0 / 3 tests passed.
 # Totals: pass:0 fail:3 xfail:0 xpass:0 skip:0 error:0

A buffer overflow is detected by the fortified glibc __strcpy_chk()
since the __builtin_object_size() of `RTA_DATA(rta)` is incorrectly
reported as 1, even though there is ample space in its bounding buffer
`req`.

Using the unchecked function memcpy() here instead allows us to match
the way rtattr_add_str() is written while avoiding the spurious test
failure.

Fixes: 2e64fe4624d1 ("selftests: add few test cases for tap driver")
Signed-off-by: Alice C. Munduruca <alice.munduruca@canonical.com>
---
 tools/testing/selftests/net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
index 247c3b3ac1c9..dd961b629295 100644
--- a/tools/testing/selftests/net/tap.c
+++ b/tools/testing/selftests/net/tap.c
@@ -67,7 +67,7 @@ static struct rtattr *rtattr_add_strsz(struct nlmsghdr *nh, unsigned short type,
 {
 	struct rtattr *rta = rtattr_add(nh, type, strlen(s) + 1);
 
-	strcpy(RTA_DATA(rta), s);
+	memcpy(RTA_DATA(rta), s, strlen(s) + 1);
 	return rta;
 }
 
-- 
2.48.1


