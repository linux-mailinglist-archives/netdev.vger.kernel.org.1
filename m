Return-Path: <netdev+bounces-305868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p0AwDSBwTmr2MgIAu9opvQ
	(envelope-from <netdev+bounces-305868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:43:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF597282F5
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:43:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=LVH2xcyX;
	dmarc=pass (policy=reject) header.from=canonical.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305868-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305868-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB0213172C7B
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40194439349;
	Wed,  8 Jul 2026 15:27:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A5242D9D
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 15:27:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524476; cv=none; b=VuAvFUNbEPwNE5vOdSPio1289Lu0njvBid0pPYbHuHwX3A4IZPZIbY7aMxlExGvFGhknfDrbkP8zbobIMTtGQ2er5YU3lePXFFPI8Vp3j5dNUy7HbSWtubBnZbv/VysmlhRJCpuo8zQJBrhHzll9zXlBmWigOXQXOrTGaAh4K68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524476; c=relaxed/simple;
	bh=6jHqdZXH2o25X4C8Qo1lrHLPG4nFtCmtPQ4a4mwT6EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIWSCpQo/tYw5lfB0CJuDGY7l4JrnlED75BnBD/feog7n5g7Gs22f1EC6Mb5oIhQAYoakT/JXrQ8EX89pRVrftL1H52SwrRWmPki4RCpAzBAgb71Zz9cxi3x2WjeN4Sky+VG8thwBImLSFoh9nJpsCizB0c3ePMi+kENtum7CvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=LVH2xcyX; arc=none smtp.client-ip=185.125.188.123
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4893E3F61A
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783524467;
	bh=zlcM7dYOWNF3Lzm/T73XtTla6vOUEX6Hfc1lNEV//wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=LVH2xcyX0NZCOQz406/bopsTwmweFHcKRlCgzuDnV+fDEIJzWnY/r7DMtgTBdLnZX
	 x6wbOWp5OFBllBbFlyVEmkbHqUZvy8D332B/0yiWnsvqKaAaYvZw+7cqj9cjOPK8V0
	 6OgL1yq06hSULyhSiOveD51KJu+mbLYygPuE7lPEFzOTpXoWCqz941QtAW2XUrcpk9
	 0SdnVBbhsIPWJ897KLcP0mkARLmFr2OVjej1wrOU58561QZpbHeO9LrgS512UQh8QH
	 ys+6Sk7sQbYL6onCdPhS/CoNu4Wv18wrsu57MYKTf6t1lByIU9/+J9MRjuwsi8Q78i
	 UzPMFK0yuAARy9Y4nAn/+IxSwuUYdKRqQXvS3+1I84afMwqntnQgtmAVSVAUXCXs8x
	 R9W5W6VOKnn6GuhOMwzWpxJPP1iWJQl2M4HgwV9YBaAVrwimbNu0l9hOm6j/ScD0U3
	 U3Obp7wbCpVPPJ+T7r5FJJx5VhkijtcpHWeluh7s6N+AuqzJ05WLIKFZo2dViPimGF
	 F1UvPJ4skidwdRwo4+RvC4U0tziPLlNEZ/K/uGyH31wZuxPADVxY66oWTUjis2Qcsm
	 Ww0XDOL2cB65+FSllWHKKTjm3x0ToxrCTg0J/3fzthnk+Nu233964Jn24CKBtS5FzE
	 ck8YRfojoU6l/lMHXHnN3m1g=
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493e3ecd385so7953765e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 08:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524467; x=1784129267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zlcM7dYOWNF3Lzm/T73XtTla6vOUEX6Hfc1lNEV//wM=;
        b=PlYkd1XuKt88+NBJwFQvd0+JgPf/aPx4UcM6vjYuyDEMmMu4MVv5eZTG29Xsi6tw8+
         htqMDY2jpXVsqeRQxRKHbPyJ/2at71n/8wK1lkZz2m82MNh8gEQtHVm62lAfR12pWCkr
         /WTQmylPS0yj+FWri1dD1tXJEt3xlNQUYf4v+PUSWM2afbFzjGedRxRrWzA2Nuhg7rgK
         FjE8Ivc5jVABEEQOlAgtmEy7ronlydAvqNY90dfM9UtJ6/rr3BMmHr0Jss2xXsQP66zW
         yWG79ev/DPPJH8jGejJxM0L4gab4O2A5cMcJXQmjlaozIaLEctx+IHAhdHO91R9Qsu1d
         h1YQ==
X-Gm-Message-State: AOJu0YzAOwvcwUuymZDZywk9J+I5sjTq0tvkSQROY9KuDvm2e/vvQzn7
	wC6mv2yXjgAb1P2Qpkj/ch5jCFKxyEBPl1IWte6+/2HhVfZNUOnrZI0LJ6KEGEZZpf9QBJXghKZ
	Tsh93YKe1Im95pvQtreBIr/xe8bm99NZOM6wsvU/ZnHEW7AqfmP0YZ6urjo5ejkE9/y8atygi0j
	GUQtUp4w==
X-Gm-Gg: AfdE7cksAT9EeXvEZaMuhJ51gHZ5mwoSZ85TRiKbDIoxMQexhef1O8FdMMnhGtEmr6X
	vQOSeMGS6AwAdYOp2F+S2Um/nXguwFlD2tsg9DpzJdfNXlYoOjuzkg/PtaV7vIHz8Izg2QHKCqW
	grs+bk1UcniSB5pCeu4azWzvMWkMSr2Z5Zcu+rP48+cugM9PUH52x5ZoZhBFNj794FcNughVaqK
	UjZhp6JFsxT/NELnUY8UV5nkeLyc2oDgsqi7VNDTwurgeuLQNBKc3wtsdnp0AYF/sYILbDNgdhY
	xDVns1d1i4EdaZpsKYKeI4mTpvq+Pfc7WuhE1mrSW8Z4fJWFWXDH3g97daA2t8TySKrwYwsUq2/
	zAMXaO7davYSHNHvkIfNg7+Ko3gVUVxBB7KwzBTBGxZK649OKgirtZUUQscfblXvabqExeFzrlV
	DvguJ8fg==
X-Received: by 2002:a05:600c:204c:b0:493:c453:6002 with SMTP id 5b1f17b1804b1-493e68eff16mr19928245e9.35.1783524466880;
        Wed, 08 Jul 2026 08:27:46 -0700 (PDT)
X-Received: by 2002:a05:600c:204c:b0:493:c453:6002 with SMTP id 5b1f17b1804b1-493e68eff16mr19927945e9.35.1783524466471;
        Wed, 08 Jul 2026 08:27:46 -0700 (PDT)
Received: from localhost (93-40-86-183.ip38.fastwebnet.it. [93.40.86.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0faee30sm125274565e9.10.2026.07.08.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:27:46 -0700 (PDT)
From: Alessio Faina <alessio.faina@canonical.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Alessio Faina <alessio.faina@canonical.com>,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next] selftests/net: Skip srv6_end_dt46_l3vpn_test::host_vpn_tests if iproute2 too old
Date: Wed,  8 Jul 2026 17:27:45 +0200
Message-ID: <20260708152745.2430714-1-alessio.faina@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305868-lists,netdev=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[alessio.faina@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:alessio.faina@canonical.com,m:po-hsu.lin@canonical.com,m:andrea.mayer@uniroma2.it,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.faina@canonical.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[canonical.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BF597282F5

In case iproute2 is older than version 5.14.0, released ~Sept 1, 2021,
the End.DT46 support is not available and the host_vpn_tests test contained
in the srv6_end_dt46_l3vpn_test.sh file is failing in some kernel backports.
This is the result of those tests:

################################################################################
TEST SECTION: SRv6 VPN connectivity test among hosts in the same tenant
################################################################################

    TEST: IPv6 Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)  [ FAIL ]

    TEST: IPv4 Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)  [ FAIL ]

    TEST: IPv6 Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)  [ FAIL ]

    TEST: IPv4 Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)  [ FAIL ]

    TEST: IPv6 Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)  [ FAIL ]

    TEST: IPv4 Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)  [ FAIL ]

    TEST: IPv6 Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)  [ FAIL ]

    TEST: IPv4 Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)  [ FAIL ]

To amend this, check the current running iproute2 supports the required
feature and, if not, just skip the test to avoid a failure.


Signed-off-by: Alessio Faina <alessio.faina@canonical.com>
---
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh       | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
index a5e959a080bb..406c6a3d253e 100755
--- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
@@ -510,12 +510,15 @@ host2gateway_tests()
 host_vpn_tests()
 {
 	log_section "SRv6 VPN connectivity test among hosts in the same tenant"
+	if ip route add help 2>&1 | grep -q -i End.DT46; then
+		check_and_log_hs_connectivity 1 2 100
+		check_and_log_hs_connectivity 2 1 100
 
-	check_and_log_hs_connectivity 1 2 100
-	check_and_log_hs_connectivity 2 1 100
-
-	check_and_log_hs_connectivity 3 4 200
-	check_and_log_hs_connectivity 4 3 200
+		check_and_log_hs_connectivity 3 4 200
+		check_and_log_hs_connectivity 4 3 200
+	else
+		echo "SKIP: SRv6 End.DT46 is unsupported by the installed iproute2 version"
+	fi
 }
 
 host_vpn_isolation_tests()
-- 
2.43.0


