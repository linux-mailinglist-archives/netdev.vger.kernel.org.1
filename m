Return-Path: <netdev+bounces-261338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMerBsRCoGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:55:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C201A5F4A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2857C30440C2
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCFF2DAFB9;
	Thu, 26 Feb 2026 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKBpYqkv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F42DCF52
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110447; cv=none; b=JAWR9eCEFUk5UT4AGF+iUPSchZcHRMF5v0e8C+gvKM6edxgu4OWmOCWGX46CEBJz7zkbAFa6bUe7LUKom7purysHWQH4taclrisE9ypHwMoP6N/o62OjjvR+0cExf85poYl9QHZ0TQDJkIolEVgrTq7vFdYBYGXCNjfOiROLQok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110447; c=relaxed/simple;
	bh=gjny3v/eTWHbeutrMbxDNE40G5kG1Ylj5usbZJzU9HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcX1koNF7wcagMw2Fpr9u7byW/IJPYj/Wwg9GfxQx5F/tHzxDqiDkHkAWaOwZNCFB9v7foTQwx8Pi9fSvNTaUUthjKCiQXD6DN6UTy9Vstz2mWRsnZOJnGJyDgwL4sDp35kmt/XJoMTJTxu6vPQaNGoKjBfleegMEvdOn7VAMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKBpYqkv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad4d639db3so3795145ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772110445; x=1772715245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUrXcfq9vgrgpVWA1902DBETXrF91GneB4Umctz9Jao=;
        b=jKBpYqkvvDZ43qLCn2J9H4npJeUPeMOS9kff2arjTHxORA+TyDvzDTmJKgUR9vSPRM
         4kxaXdZRt3EIzDhYrrkDN8izIYcRg0G+M87P/2NZhLN4HFEXjD4M9irA2L2cUoA35++P
         7qNvnTGAlRIC2rNm+CsDZtNky5I/iYV6trVfRW+MW607IhCbZxifrp5tfhTd7F0v9kS6
         a5V7/hXG9DxaahZ/9s62ioznhaRzRr9dWCSGek4iCBsT4rAmPDeiz1xKg3jXhE3wtQGd
         pRffVY3Gbg7snti1KKLL8R5lHANi74c95kRZJ9+x10+VoYXeL31TrGPmJw/QCRE/An4Q
         IIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110445; x=1772715245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUrXcfq9vgrgpVWA1902DBETXrF91GneB4Umctz9Jao=;
        b=rtR0N658Kt2YSpjbFIHtQAX2HTXS7ti/bZ12L36cYCXn8rN6vQumiWQvQnck9Qb1t9
         swf1wzIWRCccWAXaJsiu1CDpZxzDD9UAyApaPkYsuHyjPmKGTsgqcTovcpgGadpwurvC
         MjyWXjidVXsR66NggTgxVZN1vAAh+kRIP0DeFV8tbwF3KnWxgWYhyHeuVMUdKKGpzPA3
         kdJHo+nTDpsnaJ9om2+djeOI6Sso2uGZZMT4N9Zb1r5nZGzSHc24YYBZCcEDcLmzUxIU
         ywTalNRNPAEaxiX2fH0s1/NNvrPzDCHvo97F4nJ4su75uJ7gud7QG2uJMCr4ghCoq+Sk
         e59w==
X-Gm-Message-State: AOJu0YxJXORds3734lqypYIsRjoMLjGYvGjtJrPaYAdiI9E7CuHVuore
	LV36XCdtTI6Uee9Trpcbl+3lBrqa3J8HiHcxJVgfIy8wZVMQenv1q/VAOaN1XBkg9cY=
X-Gm-Gg: ATEYQzy8sgCUGIptRVKE9ExoGHre9OsL1y60n++KEma6zA8Q9r3NuwFgeaFcsZn8ZqD
	PaOGgdL6oB33xILL5HCYEmK/RgPgN9p7tv1Z5mRT0vEkCXX/P4P3bY9wzT6WrsIM4ufHF0bgRjp
	W6WbVkGrZP0APr7Gf/2MD2Q3MAZtzIC994P7RAeKnMCO2Wm+8cnCSUNLgJOH/xwSYKKmVifBaiR
	EaQv259uHjLVkgWkbXTeq3ockK9p7SZYAG08ZwjXZKqNtqIfk5pRWTAkFCnpBkANYpFqEHAX7wO
	aY+gO1vinWh1pJWkJhRSbrqKV5pYPQ8h5HOWrVEfqn3+4v3A475O9FBBRQnFplCpS/y+9B9qLyp
	bq5zD6Zkg5WEnJqTH1QdDQszUs5pDwH12u5lc9goch4QaBGQXGNR3L5uLRB9eNkWO68Xr0ZWYhV
	y1bHbNAcQGz8UcY5YfIa19EGQzNgY=
X-Received: by 2002:a17:903:19eb:b0:2ad:99bb:3129 with SMTP id d9443c01a7336-2ade9a9fa34mr42879505ad.50.1772110444926;
        Thu, 26 Feb 2026 04:54:04 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb705b53sm25276715ad.92.2026.02.26.04.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:54:04 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Mahesh Bandewar <maheshb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 3/3] selftests: bonding: add mux and churn state testing
Date: Thu, 26 Feb 2026 12:53:30 +0000
Message-ID: <20260226125331.28147-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226125331.28147-1-liuhangbin@gmail.com>
References: <20260226125331.28147-1-liuhangbin@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-261338-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bond_lacp_prio.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bond_lacp_ad_select.sh:url]
X-Rspamd-Queue-Id: 32C201A5F4A
X-Rspamd-Action: no action

Rename the current LACP priority test to LACP ad_select testing, and
extend it to include validation of the actor state machine and churn
state logic. The updated tests verify that both the mux state machine and
the churn state machine behave correctly under aggregator selection and
failover scenarios.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/drivers/net/bonding/Makefile    |  2 +-
 ...nd_lacp_prio.sh => bond_lacp_ad_select.sh} | 73 +++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)
 rename tools/testing/selftests/drivers/net/bonding/{bond_lacp_prio.sh => bond_lacp_ad_select.sh} (64%)

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 6c5c60adb5e8..e7bddfbf0f7a 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -7,7 +7,7 @@ TEST_PROGS := \
 	bond-eth-type-change.sh \
 	bond-lladdr-target.sh \
 	bond_ipsec_offload.sh \
-	bond_lacp_prio.sh \
+	bond_lacp_ad_select.sh \
 	bond_macvlan_ipvlan.sh \
 	bond_options.sh \
 	bond_passive_lacp.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_ad_select.sh
similarity index 64%
rename from tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
rename to tools/testing/selftests/drivers/net/bonding/bond_lacp_ad_select.sh
index a483d505c6a8..9f0b3de4f55c 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_ad_select.sh
@@ -89,6 +89,65 @@ test_agg_reselect()
 		RET=1
 }
 
+is_distributing()
+{
+	ip -j -n "$c_ns" -d link show "$1" \
+		| jq -e '.[].linkinfo.info_slave_data.ad_actor_oper_port_state_str | index("distributing")' > /dev/null
+}
+
+get_churn_state()
+{
+	local slave=$1
+	# shellcheck disable=SC2016
+	ip netns exec "$c_ns" awk -v s="$slave" '
+	$0 ~ "Slave Interface: " s {found=1}
+	found && /Actor Churn State:/ { print $4; exit }
+	' /proc/net/bonding/bond0
+}
+
+check_slave_state()
+{
+	local state=$1
+	local slave_0=$2
+	local slave_1=$3
+	local churn_state
+	RET=0
+
+	s0_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show $slave_0" \
+		".[].linkinfo.info_slave_data.ad_aggregator_id")
+	s1_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show $slave_1" \
+		".[].linkinfo.info_slave_data.ad_aggregator_id")
+	if [ "${s0_agg_id}" -ne "${s1_agg_id}" ]; then
+		log_info "$state: $slave_0 $slave_1 agg ids are different"
+		RET=1
+	fi
+
+	for s in "$slave_0" "$slave_1"; do
+		churn_state=$(get_churn_state "$s")
+		if [ "$state" = "active" ]; then
+			if ! is_distributing "$s"; then
+				log_info "$state: $s is not in distributing state"
+				RET=1
+			fi
+			if [ "$churn_state" != "none" ]; then
+				log_info "$state: $s churn state $churn_state"
+				RET=1
+			fi
+		else
+			# Backup state, should be in churned and not distributing
+			if is_distributing "$s"; then
+				log_info "$state: $s is in distributing state"
+				RET=1
+			fi
+			if [ "$churn_state" != "churned" ]; then
+				log_info "$state: $s churn state $churn_state"
+				# shellcheck disable=SC2034
+				RET=1
+			fi
+		fi
+	done
+}
+
 trap cleanup_all_ns EXIT
 setup_ns c_ns s_ns b_ns
 setup_links
@@ -98,11 +157,25 @@ log_test "bond 802.3ad" "actor_port_prio setting"
 
 test_agg_reselect eth0
 log_test "bond 802.3ad" "actor_port_prio select"
+# sleep for a while to make sure the mux state machine has completed.
+sleep 10
+check_slave_state active eth0 eth1
+log_test "bond 802.3ad" "active state/churn checking"
+# wait for churn timer expired, need a bit longer as we restart eth1
+sleep 55
+check_slave_state backup eth2 eth3
+log_test "bond 802.3ad" "backup state/churn checking"
 
 # Change the actor port prio and re-test
 ip -n "${c_ns}" link set eth0 type bond_slave actor_port_prio 10
 ip -n "${c_ns}" link set eth2 type bond_slave actor_port_prio 1000
 test_agg_reselect eth2
 log_test "bond 802.3ad" "actor_port_prio switch"
+sleep 10
+check_slave_state active eth2 eth3
+log_test "bond 802.3ad" "active state/churn checking"
+sleep 55
+check_slave_state backup eth0 eth1
+log_test "bond 802.3ad" "backup state/churn checking"
 
 exit "${EXIT_STATUS}"
-- 
2.50.1


