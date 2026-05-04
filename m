Return-Path: <netdev+bounces-284086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBW6FqYm+Wmz5wIAu9opvQ
	(envelope-from <netdev+bounces-284086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:07:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A7F4C4BDE
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4A173037434
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C3A390C86;
	Mon,  4 May 2026 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="W7EKEV8u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04893390226
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935823; cv=none; b=Jyin+Wwcuvx6Qk2OfI9zMpUq4q1xhvpWBR/adIxDV+FtB4EuuxCYdMJfk3dAlryzre2SEKpnQVAt2ShtPLQyyID/UZXkOJ4Bs3+5tSfmjwHKT0ZjOtbfdcnXapDUqfXQHq6O0Su8jLpXWmymF7wE9bN9NfrN9/KKuPjIEKMF0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935823; c=relaxed/simple;
	bh=RTsVaPujv1Zipjqi6owizB/hu8GwpxevK7plImcp/R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fnmjkhtbr3Kh6y/+1/zXcE9Cfv13pFLUAM7BampxplR/yXR0CjaQrwhfd5NeG08bKmuLIrhYT7QXlCybaQ52wC39B9CGNzXYtA3YC1LL+xcMpF6u/JotTx+d0ftvA020VTeUf8v9/zy2z02HRlVxpqsVK4BtONGVEUtTguwUkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=W7EKEV8u; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so30445375e9.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1777935820; x=1778540620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zACIKFEwz1yqIQZvSt58R2/bdNJrXZHSjp9IUUKiaOs=;
        b=W7EKEV8uOw7botOA8bYBB72ywzKUVOfhNfbKRBb4Q3PeUAFpWWbSO5XG8OUwD6UNv4
         mv0Os6GJ07nQMXN01Y9l+GI4zXnYeIlDjejXSmmcdwHhjJ0JN1BgK0nx3+s/Ke0xQSvp
         LRDknmeDsGrligTZaYV1akTMoH8XnEMV/3CSTvQ3h/cr/P7M3fuqsga4Od30d88SLJ9H
         rsXyH4FzFSdpekSRu/xhyUqeEk+9tarqudOlNZ9wfbl63u2dLGpghSRd2IetpVds61rr
         ssGBNPW9HjgXBLPTILQpPzPyYGhxA/1AutoMlaxmGKka4UXUg0d6PGHl7AAVpZz4BcWJ
         juAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935820; x=1778540620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zACIKFEwz1yqIQZvSt58R2/bdNJrXZHSjp9IUUKiaOs=;
        b=PJn/jQ/HCWKpA/f4eVEvw06BKlirf+3kGQAZ10IR/fvMRJWw1QfN6zFSawG4V1LPoN
         HFLWSczW7nnYp04HtYVdYvEC2RMqtZUbCJPga2YdbVA1u2ewmdWHpJDSZyP0L3zys0r/
         hR2BvsR656DGKpJjdKsjtWb41PLqY9fY2s487KNi1WCrPkFGCUWy8Nn9+IPsVgjdihQ4
         ZT+4rTLdwQqQpM5Oru4cEuxkfe+gImlEE0bNB9moYSNRM7vglOZXccItAfw5kGCvulDx
         ciT22xvtxCz2DXBzwcpnDhLWxfoOc3rXmQCgLm7BBNgNcLPc8OOtEj68wBjntJkD4xuL
         dwug==
X-Gm-Message-State: AOJu0YzP09o4rNjA4WTvZk5j95+kjC70NZmEgJA1V6T7x6xpbbrCTnb2
	TkMmJQbwD4WCGzF+JU88mFzny4a5H170SuxCpBeI0R/ZN9ByqUfwuWAkqktM2zS9UATlGcz88uB
	iUUsqQWdrJgGT43mzT0Q9BUkevjGoeIZC8q4eR5xe9LK7U/UXbLnN/PIqn+k/mZpEXOg=
X-Gm-Gg: AeBDieuQq6c2OR2wXSD0z9E5+DiqR3iEe2kMbC4PWwiTH2JZkl71uvLuKfOJpe0Ac3X
	S5ExPYlquXHivTREM/Ialn29yPZVsI2umiV1me1W0fP8uIQWeKmBO9F1xabiJa9EX2o+aDG31aV
	QfARcz0m9yvCgJ9d0wN9erHvO/i1LSiR9dnu8qXfEGYKESc7+0ZWbIR7nUneUHrfo7zCub/6uHb
	ErIPi8W7u+ayY9I7ZX5p4Rh/Db79Kc7URf7+S7PD9aScEiH4OdGSDEm0pIMnMrRE7fcjs5gyeT8
	QWyW953Uq2aHQV+bK0XoSF453DgVilEmx/mD6VgYc7z0CTVo9JPKABXhF6qTJQ3tLue5QocnsGJ
	eBgSy+Uqcx5mS55zaMFJ2lgkn7AlAa0WGsumfjPa3wygZtjhLmiffUw56n8FMbbFbXg43pkFP4J
	aq1NrVtLSIDiHBXfS+yoXanLN9i9tcs2tv/SROeqRrj+P++II=
X-Received: by 2002:a05:600c:19d4:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48d1422baefmr21167775e9.2.1777935820006;
        Mon, 04 May 2026 16:03:40 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:1d7d:7ce5:717a:133e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm636149165e9.2.2026.05.04.16.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:03:39 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ralf@mandelbit.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 3/3] selftests: ovpn: reduce ping count in test.sh
Date: Tue,  5 May 2026 01:03:05 +0200
Message-ID: <20260504230305.2681646-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504230305.2681646-1-antonio@openvpn.net>
References: <20260504230305.2681646-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E6A7F4C4BDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284086-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test.sh:url,mandelbit.com:email,openvpn.net:email,openvpn.net:dkim,openvpn.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Ralf Lici <ralf@mandelbit.com>

The second stage of test.sh ("run baseline data traffic") performs a
basic connectivity check with ping -qfc 500 -w 3.  On slower CI
instances this is too strict for TCP: the RTT is high enough that 500
echo requests do not reliably complete within 3 seconds, so the stage
flakes and the test fails even though the ovpn setup is healthy.

Reduce the packet count to 100 for both the plain and 3000-byte pings in
that stage.  This still verifies peer setup, key exchange, routing, and
data-path traffic, without making the basic connectivity check depend on
timing out under load.

Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index b50dbe45a4d0..c06e3135fbef 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -98,10 +98,10 @@ ovpn_run_basic_traffic() {
 		sleep 0.3
 		ovpn_cmd_ok "send baseline traffic to peer ${p}" \
 			ip netns exec ovpn_peer0 \
-			ping -qfc 500 -w 3 5.5.5.$((p + 1))
+			ping -qfc 100 -w 3 5.5.5.$((p + 1))
 		ovpn_cmd_ok "send large-payload traffic to peer ${p}" \
 			ip netns exec ovpn_peer0 \
-			ping -qfc 500 -s 3000 -w 3 5.5.5.$((p + 1))
+			ping -qfc 100 -s 3000 -w 3 5.5.5.$((p + 1))
 
 		wait "${tcpdump_pid1}" || return 1
 		wait "${tcpdump_pid2}" || return 1
-- 
2.53.0


