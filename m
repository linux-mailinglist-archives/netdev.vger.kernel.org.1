Return-Path: <netdev+bounces-296559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 33lYFvXBJmpekAIAu9opvQ
	(envelope-from <netdev+bounces-296559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:21:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1706656932
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:21:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mexZ6dIG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296559-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296559-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DD953075C13
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF94F3839B9;
	Mon,  8 Jun 2026 13:11:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E64E3382C9
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:11:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924293; cv=none; b=KSjnL9g+wTHcl29x/xBh40WPzgJ9YoTQT1TZXI9iAzUvCKlw0OK9sx0Vc9fLlymLBTCguJT0bE4uaBWz20IH78FE8LI0scXwT6EjytXEKHyy06oILcvRAkVrAerCeV9wXIbUWP1lH7X9KT6VgaMS0v9tPOGSovXRYOkN5JBY20E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924293; c=relaxed/simple;
	bh=oI6gNiEFcoU9NnbSahFXu//a0ZF+i3wgntt8K49GJK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOCLhgzX42LOWjGxxu4O0n7Mi/oxfNnIWbD+JNghW7dvzP63/XZC5RFR0V+b724NFoAHZIQHKW2iKWJHiY7n2EBu5w/ZdKD+FFQNGMOJFJcqn6Y6SEetOSe489j+ltI2omCa3JNFy/WX6PVnVFd4QPuTJxhkGwWlmqqr1fhk85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mexZ6dIG; arc=none smtp.client-ip=209.85.128.65
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490a78b0c8fso3150135e9.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780924291; x=1781529091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jzTgIxihPfxvZ9etN1WCwtNaWES27vN17kVvrZGGgw=;
        b=mexZ6dIGwHi2iLRi6QfKu/8v89sijDv3WtRHnnNq/W/3wvPAAsP44Qm29mjoTVmaDY
         tONvBuQvAXJNbMi02G9ckJuTDwVB4XO+1DmEpSNm3QoG1auhoMWF5kn6pxzOUAF5QzxO
         i19UQPpllqnYozXWbhw7FfblKQnGJhtX3DAjWCULamfGozkVCyYQ9uRYWw+0bVxfUXoa
         ywr7N0ov0Fwa0OmGqPbGaRCsCp3AiNeo02ASoXkEKMDphOsdVjzqLfOfbhyxDbMBKARl
         qfQM4nYbjrSXMC0YiKZ333JigAIboMqUhPQswd2CkNie264+uuDKsHKpTWn5rSQ2RmTu
         Ws9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924291; x=1781529091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1jzTgIxihPfxvZ9etN1WCwtNaWES27vN17kVvrZGGgw=;
        b=NY8WUhPGXDmKuHHpocd38j1tyI2VicPlBOY3ytP1nYzqIPcajw2LdJNoI+WIL4lVKF
         vh0JWXN6Kb4gM6/1o1vEtQFW5J0Y8/tMeVdLwruBFk2euBi9tiQmPA/luL3u3cHqT4V1
         8iTGOD6XCb9uPR8HUtlwPLWO2TkvFQQedoZnAld3keXW0+2WJ1Uspbb9MXApn5YyTtOy
         eDuUJ2jqoAzBqQ9dqlLIhDTKedn3DFrHfsEDNwI6DkVWGD5FTFoOgV6z89RTNOh8jeHX
         nTxthi0ajVpuXWOVUVSDa2M5pVQxIrQTZdplXEeW7S01fqTqXUPwDs9pAWHAzF7YCacM
         +BIw==
X-Gm-Message-State: AOJu0YzoiaApqt5q2ymtNGQOvEpJfLVhElq0n4k3tlTSxac4UTej8HGb
	WoHCWt+rn0lurTNdvH5xnefwhfjX9z+NEWdBa+oqj3598vI+UoyflrZKx7OURes2
X-Gm-Gg: Acq92OFhGmYUDg1Vd8HY1hBp61qV1TGbbUfSbprtT+5I6JZwySDtOjaneU+ldDGsACi
	0koBCX7zXLVek1LMPIu/h8fw2ljTQqTO8UQHyvde22EJWTbaGnvCeEJ/BgKNlglb0sgTTMC1wTC
	QSMe/Z9ShfD1EJQVmA7TzM3+Ob4AHDhoct5oOwkuDhEtr3f7ei/TuaTHjqMPX8IsPbcCr+pSxSp
	bEzI280Dk/4299wOn+AGuDcxwrnE7NTKx37Ju5boO2L6NmIKtgMYp5s0h0NbxdhcgEr2F7/8cMi
	aYXTJ0/yJ8YMjQXp8rHGTZ4JXEgKFn2eKhK/XriTx6ax1tLHVD/34kqHrs+9U9zOWfVTloGk6Ib
	4k2Q3807otF9fwEQcvwa/v1hkxRjd2xfBdqF2xhUnx4gGR+JH5IhK9owLWb7Qz4fye4ksSGWJ2I
	odgoMYfUIEmMiwWpvXFI80Uqnog3eKu5I=
X-Received: by 2002:a05:600c:8208:b0:490:b2b2:87d2 with SMTP id 5b1f17b1804b1-490c25ed6camr101467695e9.5.1780924290529;
        Mon, 08 Jun 2026 06:11:30 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm300135675e9.2.2026.06.08.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:30 -0700 (PDT)
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
Subject: [PATCH net-next 09/10] selftests/net: add test cases with MTU above 65535 to big_tcp.sh
Date: Mon,  8 Jun 2026 15:07:54 +0200
Message-ID: <20260608130755.5626-10-maklimek97@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-296559-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,big_tcp.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1706656932

This patch adds test cases to big_tcp.sh that test BIG TCP over MTUs above
65535. Two test cases are added: gso_max_size > mtu > 65535 and mtu >
gso_max_size > 65535.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 tools/testing/selftests/net/big_tcp.sh | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selftests/net/big_tcp.sh
index 2db9d15cd45f..cb0ffccda3ff 100755
--- a/tools/testing/selftests/net/big_tcp.sh
+++ b/tools/testing/selftests/net/big_tcp.sh
@@ -132,8 +132,14 @@ do_test() {
 	local gw_gro=$2
 	local gw_tso=$3
 	local ser_gro=$4
+	local mtu=$5
 	local ret="PASS"
 
+	ip -n $CLIENT_NS link set link0 mtu "$mtu"
+	ip -n $ROUTER_NS link set link1 mtu "$mtu"
+	ip -n $ROUTER_NS link set link2 mtu "$mtu"
+	ip -n $SERVER_NS link set link3 mtu "$mtu"
+
 	ip net exec $CLIENT_NS ethtool -K link0 tso $cli_tso
 	ip net exec $ROUTER_NS ethtool -K link1 gro $gw_gro
 	ip net exec $ROUTER_NS ethtool -K link2 tso $gw_tso
@@ -151,18 +157,20 @@ do_test() {
 
 	stop_counter link1 $ROUTER_NS
 	stop_counter link3 $SERVER_NS
-	printf "%-9s %-8s %-8s %-8s: [%s]\n" \
-		$cli_tso $gw_gro $gw_tso $ser_gro $ret
+	printf "%-9s %-8s %-8s %-9s %-7s: [%s]\n" \
+		$cli_tso $gw_gro $gw_tso $ser_gro $mtu $ret
 	test $ret = "PASS"
 }
 
 testup() {
-	echo "CLI GSO | GW GRO | GW GSO | SER GRO" && \
-	do_test "on"  "on"  "on"  "on"  && \
-	do_test "on"  "off" "on"  "off" && \
-	do_test "off" "on"  "on"  "on"  && \
-	do_test "on"  "on"  "off" "on"  && \
-	do_test "off" "on"  "off" "on"
+	echo "CLI GSO | GW GRO | GW GSO | SER GRO | MTU" && \
+	do_test "on"  "on"  "on"  "on"    1500 && \
+	do_test "on"  "off" "on"  "off"   1500 && \
+	do_test "off" "on"  "on"  "on"    1500 && \
+	do_test "on"  "on"  "off" "on"    1500 && \
+	do_test "off" "on"  "off" "on"    1500 && \
+	do_test "on"  "off" "on"  "off"  66000 && \
+	do_test "on"  "off" "on"  "off" 200000
 }
 
 if ! netperf -V &> /dev/null; then
-- 
2.47.3


