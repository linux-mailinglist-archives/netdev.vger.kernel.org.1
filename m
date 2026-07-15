Return-Path: <netdev+bounces-307743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JUUtHJ59V2rSSQAAu9opvQ
	(envelope-from <netdev+bounces-307743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:31:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB4375E275
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:31:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=S0GFZWFg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307743-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307743-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1569D300AC36
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD2046AEE1;
	Wed, 15 Jul 2026 12:29:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704093C73D9
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:29:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118548; cv=none; b=tElMabasfvH72l/PiYgGCqLG++v7r31iZTW/40e0U9XibfrvFnevk5mnDekNvk7F0UZNoW865z+optvtlfSscfQe+eQiN07k8B262Ht0ko/+I5kYqA8lMXYBvFH38y5xoU3rNPDy7DqVmHIBHVhnTdLRqKkNOQPuSEE5yv40dD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118548; c=relaxed/simple;
	bh=OdruJZBa6oWspM/17dQouf+1Ety7FDflBlOYn7n3WbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INpA+ymh0X8/RaGsHv6sRpeyItsORHh50XB9ElKOdkqem9gaMfp+fAjkYbYhtbgMJip6mBeIPoEpp1/qljfgBiSh823HCI9ECbnrFTHngJBzRF2qnhq2lZkfKl+2bM9Z/1nuxzeUTmDQiXUiFJpGjflkhzBVzoU28NUuBaqRW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=S0GFZWFg; arc=none smtp.client-ip=185.125.188.122
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 96C543F581
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784118542;
	bh=Xwm+NMhrBU9VQqJsed9CGdyjA7mRZEQ6yrEUTZU5TnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=S0GFZWFg+GLqFFN/+a5qTvjv35xqceiFvesf+m5wDQ2Pzi2vYDKONCai7BzYEnZBA
	 dR/TwWyisBh/w3oKAmjR1jlStj4IfhySqN32hGPutsHNIkzfmIwTSx4ztTv1CrJdde
	 PubicYGAgZUhvAk1CkQGFmHMQiuKB8NgW4cVCZ+y5asrh/Wx4AqFCnQo+Zi6MPIQlx
	 jBoZCUK6HUpSK7tCnY0Xh7KwSKCOD+bnNzNZdjG2sWLWhbAhxi+uYRXdf7BAGAVq+d
	 mSK2MG1DuamjbkJ4A9A/S+1oyrOS9iURtuRYmY73a7lLqIqJWfvWZuQpFXqAszTxnm
	 FZ6PHGQrPukAFZbFAesA/ARyuFtODFPse5I67/pKsHcLdDoDyBZEcOeDbcTzqx8v57
	 bBJGg4+EDXhlcsAMDkCAA0P1USfHBbCp4GPzkH+9SMPI0wySSXk2YxEghkTK7j9rKK
	 l8Xv38S++TCvDXEbweS1ngmgZV+qCOhBiEkFSw8Nh9vZHkdWuIkn461YuR/MFK+21o
	 +763s6YXPalXemUU0BrfA+LcoFm7m/e4N9O50b5My+oLinzfOMfMooU0hQP7ITfhDb
	 6wcc89e6O6YYDSLC9KTTeG7FM90ucyEkt0wLElnZFgVYNiiHhpvE4QhGG5ISJfuOpN
	 J9jqgzmwtMQtZbohj2QuTUcA=
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso26614015e9.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 05:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784118542; x=1784723342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xwm+NMhrBU9VQqJsed9CGdyjA7mRZEQ6yrEUTZU5TnE=;
        b=MBP016O6Mn6lyoue5z42z5Q2xtfyTt/5+e526XLp15cYvYdKu+cdqUNCxlUaOVUfd8
         FuXOoPaI7dDJcEie3eZr9g3X0KSj3b1C9ZrSmcbyO3iW3+RluaeZh+ucXxItjBe0aQjF
         W0J42a1Uv1aGfYTY5eGhBI+4tjAdGczauy/9hn+spjmoXp/fDgv7tdX2Zw3Iaao7ZBTz
         uR5eakg4oJKLzkjkkpci/kMA/jv44ghzZ0SYG/pmE+Fu2DVjfkC4+NVAVrWfRSScHtpK
         T/Q90TLwofrfrgaVkhMruoJEuC3IR810IE6NywbuJb6CfReCqHUN6mSSD5Vpz8Jn59HH
         DsqQ==
X-Gm-Message-State: AOJu0YyBzsGJLBQWKZV5h/cxxHEswgRhgSOHy0Uaf35WnQ7kQWs3UFev
	P6vUc9FivY10sQlEtn3j4oJN2t4vNJhoJUlpX7XBsdaEfVFQrEIEt59ENhI5a+FrqVXGu3I87xy
	tPTY99L5KAicZGC50TPxQE9dzUyIZNOEtFMJFtXxNZjhu0Tt22A/8xC+emFk1mMQP6euu1fT/uE
	T0dx2Xlg==
X-Gm-Gg: AfdE7ckuGdl6OEqZfOw+v9vehp6uHva/mXwJAL5W0i+UbGyaDRKsxsbmiLkaAukc50r
	bC9KVx9iGFQmu8HL4b6zHkAl447bq/AW3525ByaoRG075vJcMIImo3fHSaUaib6YbqeIOJblhTT
	yGGXLxJJu1oB6+jLy0OPdwpO1aRAB1FsXyhJtuxF60x5ASo7/GU2Xvaj6SRPOs3LQ5jV1uqOf2D
	8K+1lNFI0Zhx4UMZmFjMPwd4d4LSXQz21phAzDWUcqAHBskt0rxOSqZk1TRiX1tPawMXSoOasJw
	vsov+TapmhEnVfB8bQPQw5QwA8sXQEIJ88zgM2J0Dz9buqW2Aoe51eqLkQXdzEhWWN+rXtWmqHu
	6smIMmHO9vYDnAWYgGjh4L3+M/h6S1AEL7/3dlp87iPxcTxUXo4/UdYyjB8X8WFKGyewuSUN3uO
	vYxVNkAg==
X-Received: by 2002:a05:600c:608d:b0:495:3e0d:ea3b with SMTP id 5b1f17b1804b1-4953e0ded3amr21982925e9.19.1784118542157;
        Wed, 15 Jul 2026 05:29:02 -0700 (PDT)
X-Received: by 2002:a05:600c:608d:b0:495:3e0d:ea3b with SMTP id 5b1f17b1804b1-4953e0ded3amr21982645e9.19.1784118541771;
        Wed, 15 Jul 2026 05:29:01 -0700 (PDT)
Received: from localhost (93-40-66-109.ip37.fastwebnet.it. [93.40.66.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c599049sm44206255e9.0.2026.07.15.05.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:29:01 -0700 (PDT)
From: Alessio Faina <alessio.faina@canonical.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Po-Hsu Lin <po-hsu.lin@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next v3] selftests/net: Skip srv6_end_dt46_l3vpn_test if iproute2 too old
Date: Wed, 15 Jul 2026 14:28:59 +0200
Message-ID: <20260715122859.36177-1-alessio.faina@canonical.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307743-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrea.mayer@uniroma2.it,m:po-hsu.lin@canonical.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[alessio.faina@canonical.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.faina@canonical.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCB4375E275
X-Rspamd-Action: no action

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
feature and, if not, just skip the entire test to avoid a failure.


Signed-off-by: Alessio Faina <alessio.faina@canonical.com>
---
v3:
 -  fix indentation in test_iproute2_supp_or_ksft_skip()
 -  fix subject to reflect full test suite skip
 -  https://lore.kernel.org/netdev/20260713095750.2671173-1-alessio.faina@canonical.com/
v2: 
	- skip entire test suite if iproute2 is too old
v1: https://lore.kernel.org/netdev/20260708152745.2430714-1-alessio.faina@canonical.com/

 .../testing/selftests/net/srv6_end_dt46_l3vpn_test.sh  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
index a5e959a080bb..50e37d3217ea 100755
--- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
@@ -536,6 +536,14 @@ host_vpn_isolation_tests()
 	done
 }
 
+test_iproute2_supp_or_ksft_skip()
+{
+	if ! ip route add help 2>&1 | grep -qo "End.DT46"; then
+		echo "SKIP: Missing SRv6 End.DT46 support in iproute2"
+		exit "${ksft_skip}"
+	fi
+}
+
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
 	exit $ksft_skip
@@ -546,6 +554,8 @@ if [ ! -x "$(command -v ip)" ]; then
 	exit $ksft_skip
 fi
 
+test_iproute2_supp_or_ksft_skip
+
 modprobe vrf &>/dev/null
 if [ ! -e /proc/sys/net/vrf/strict_mode ]; then
         echo "SKIP: vrf sysctl does not exist"
-- 
2.43.0


