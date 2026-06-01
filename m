Return-Path: <netdev+bounces-293549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FlhAHgYHWrFVgkAu9opvQ
	(envelope-from <netdev+bounces-293549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:28:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDA619ACD
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5C85301C941
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17704346A1E;
	Mon,  1 Jun 2026 05:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlFVs8Aq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C83438AB;
	Mon,  1 Jun 2026 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291513; cv=none; b=pCke2khkj7SMQnP8omyQdoYBJSwVZda0mpiN0DwQIWktg0OZHR407B8uAuyiuSs9ScDO5aVTseuFuZISqkreHcl0I2+QGDAKFoRwjd1hChyXOGkAXFYcO+LK9vzFihXpL7icJ+2A/oqMadbhyR1f+XAmDOU4RqqfepzMJ3VYCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291513; c=relaxed/simple;
	bh=niuqZifnBFajFfYY7W8jSm6ZOf+wyVIp9ZJSDYb+4q8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WjF7uPKxQKJU1iGkIbPmd1TF3YfRgQfM2UltGgCZ0fzMS1KDp5V0tPB9HNNNx2DE9SYp7EeDzXJDDHmh09sVEoJU4odkB7pmiW812CTVs8a656QT6IfaNvaNAt9TtYdGRR23Aan+JQ2Wc6hbzXeCcSK2IP3mR+yPZvwvLgE028Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlFVs8Aq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54211F00893;
	Mon,  1 Jun 2026 05:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780291511;
	bh=YYiQYtfIcs/Lry7vOcyrJuCq64gZVH3+K+aVFA+e/XE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jlFVs8AqFGN8zVSYpSoCBesU5BX/WNkOH/SrhsZLFHC/EGWA+4K/HanW3gLPVQ3yS
	 fEwlV3xrTmNk8Jcto+wgY484EZJ8639xIuN/KOqqTdtbV1OA01wePDE44wVEn3/9qB
	 Qgla1HrlEqvyFeidD13b2TOyEI5zLHr51ncSOqSLD1wgMSaSBEoLBsN9TW3hwU2X3p
	 Iugog8BElL2NdCq5qaa423UdJ/pK1TBOT/v29QzMGgxOvPuH7sDqrVMdZgRlSbhXOW
	 YYkH7XS126oAZAcbeMg+aketatLetx5/my6pkONbGr3OTR/80kxSHe1ab0/lZIRsOF
	 OFijLzMg0msCw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 15:22:14 +1000
Subject: [PATCH net-next 07/11] selftests: mptcp: validate ADD_ADDRv6 + TS
 + port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-next-mptcp-add-addr6-port-ts-v1-7-4fc25dfef62e@kernel.org>
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=niuqZifnBFajFfYY7W8jSm6ZOf+wyVIp9ZJSDYb+4q8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHReSPHzk6LKq2lQuTRVQq/MeQxUC5GZKeP4dM
 Q2MT16kZNaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah0XkgAKCRD2t4JPQmmg
 cy1nD/44LZr8mIB6hM/Ny56pMvpBnJ7aHx9ZAEqe0WA8w7ehQan7XC0Pz6p9MoxUawOr7l2PkdQ
 L5Gv37YuHmiHTLT4vpKuMfJ7CdiHXxLKTrOkB1gxDY+oprmbvCjSQ4QNyVSQhUkaz8Rr4vxkL/N
 zdUd9eKpTa5zocUshm+nhKOWLgq17BeOM+QEolS7gPAZXNAPx4LbBB+GNgjg3aACkMjqT+1jRVH
 B1JFBVqD+Nv2PAzdmh/iQK7+uZ4pbL3nO2eVD4uCuUTv+lBNv4uor62GGcFDEjbSBZi4gEUjV4p
 7CUPxzmTSwLewX02GTCsnFYakUc9pkbQFtFNVyV5d5B5P0p/jAbPb9CnWO7fNHqHNuu6zNLT57D
 /3P86rg5RHVLyFZiEw/z8r7FLPOu2eZV1UekV6JnJhXfx8MD3EWV9SRgt6m6BEtYGwgfpxbz9XS
 YbJe+KjmZesC6iNiJ2nGUROPZ5prHvLnXQUyzaWXYlmnTFmHU/ndwR23sC860zYhJXc8Jbcf/Sf
 uowgNj12Ht1lEW7o1AEW6xJwcQGaQfg6efYqZOYJm4TXq5OSrBB6a7hNjneSDqfrLpHM8Rx51v4
 pVtRC1ra0fNhqAp2r1DSjKrLWsRE87TGqZud6dQrjBClnIWHw6Y+Tr2eiJ74jUS4RTGHSJpoWM3
 ewANFqOQ1hnB2Ew==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293549-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6BBDA619ACD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This validates the feature added by parent commit, where it is now
possible to send an ADD_ADDR with a v6 IP address and a port number,
while the connection is using TCP Timestamps.

This test is simply a copy of the previous one: "signal address with
port", but using IPv6 addresses. This test is only executed if the
add_addr_v6_port_drop_ts sysctl knob is available. If not, it means the
kernel doesn't support this feature.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 23b17957686a..d491c3e964d6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3214,6 +3214,17 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 	fi
 
+	# signal address v6 with port
+	if reset "signal address v6 with port" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/add_addr_v6_port_drop_ts'; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
+		run_tests $ns1 $ns2 dead:beef:1::1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1 1
+	fi
+
 	# subflow and signal with port
 	if reset "subflow and signal with port"; then
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100

-- 
2.53.0


