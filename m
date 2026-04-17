Return-Path: <netdev+bounces-279271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFamLvH44Wn50AAAu9opvQ
	(envelope-from <netdev+bounces-279271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:10:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CAB4191B6
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 766D1316435C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59D73B19C2;
	Fri, 17 Apr 2026 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SQ392+t8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1DD3B2FF3
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416614; cv=none; b=EFRbSnulBr1XtiPXTnKSajdAkAB+grywSoRdPE58Xb/sNjvo2r9F7FA4g9uhm8d9fGdKNNpoNBsQUixb0gzfKE2A07+7U9u3r68Td8OpuB3TdZDDci0ev3iD9Asm1u1A4QE/amq0X+TXqpkS9YQnMRtoBMq6he0J3PrmVriF9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416614; c=relaxed/simple;
	bh=7hE4sDuauIwT1Zyw4ozXEbLLuScPJcQQPi+PWB5inJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrKcNFVZelOH99InNFFTUwjWcorU+s4H0AJRH3LterqQXOVvBB7ANZSZ7r6DSGUh9B1QFLPNA0sXC/aKFblDhj/Y6XwX3Uwb78JrQTmW3p1TRewdHRmXWZ0gc7xMNJVuZfjYrWYR9fJI501I4ZdFCJUuXKy1A0LO9Ok7+hN2Z+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SQ392+t8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d7605ec91so363048f8f.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 02:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776416611; x=1777021411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBNBqjxZa5Xs4CVu5t/hAxke0iOp9Ba/e1CpBPC2LLo=;
        b=SQ392+t8F491Swom15+XdXfY0qX1pSfiaaQwsapXFQNcl0bjVO+Zk4MpQu2oW6AnR2
         0qRv1lXPmtZalxteAyu8mffhFtwbWMl5X85wR8O8EocXSluPmk/2VWyBaCL8iOI3NDyV
         e/povnlEhB1vv3Yqmimp63X9o2FgLYNWNua4g4SUgCsKzSD5KqNjKnX91qc8Meq+OUT4
         SzwewOyrtA4rkmf6a76VCFy8c3YsOUHYJFYwEEtjzpkoB7i1W0L2sCLd75BPmlLMy5wf
         JL0CVgCQ2sAs4BbC6Pns1OGSwE/qE9DukmRZmi55G4qF890+WITeCqEDG9QkmNrwugu0
         /HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776416611; x=1777021411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBNBqjxZa5Xs4CVu5t/hAxke0iOp9Ba/e1CpBPC2LLo=;
        b=Knb/XXNSvRzxrhQ+MI5h9hRGDyEu3slNsd3hlXL/uBZneIbefIHKIPSG8jIurH6ExS
         s0jJQemKSYdCqwGopc2dq4gATJn3KaCyjW2L0jiGysw6mOd0dDlQEO8x68oIVwzc4BuJ
         QP+88FUWe6VRLSVWkIq6bjk2jCx+Ja2RGegY8/KNDKi87cyY6hndLDFyEbPtjIOVYhE7
         +J+J9vYrp35WhQSR4OL8jc3X9dlGP4oq4DZ8ZuZf6nh0eVexcaNDWWPrzfjQzI8VHwKP
         ocPAolfZlTYQsDDf/obiZHQcxNscHf43806PWb7xgEKdss0L7g+p0lAWpHdHk/Wbpxje
         aLZw==
X-Gm-Message-State: AOJu0Yxgajq5I7KHd321iXwdMqs+WClmsqp1O9JpaPX+5PfiWXBUgQMq
	9K3StTxjIc1BwMVW6ez8E7o2sKYhqNrTIHlsjw5cg+puptxgTYwUjB1Ud9J56f4ys5ZrBwyLqd7
	5pwHepc7H6pOm6CY7/hv35q7dN82LYJYGKMFUvzWgUvWJebqfuLV/74+5uNMLUraJ
X-Gm-Gg: AeBDieuDIyApzJpj3dj+2jgQW/WdrQ1LNesp5MlfesaHatsm1xX7+HuzoXSec7wm3Hg
	ngfsbxzPCp0kLFi0hyd3sSHTDmtHZGU9FU37+zUBy4KIj7XXbOjM+W11FxyDmYCjdyVLJ3Ay7yJ
	mgZtCs9bUD8jBQXy5k6DgKeOrxCZHgkcgB+nXT0681eIc08ElgHuP6liJGDjud3+qE4c9WocMWR
	PyFA3m9jpWkRIWcMOrEg/cvHFEsfGtP22g/xl/Xf0wom3hfSYb8Zxgt35ZVNqOcDhpUpHHsqjlk
	ki3RC3JsIe8NRGtRiv70HZmO8Syvc6aRXf9w38nBamEyNgwHmGMvcSsHC+v7LluKM20p63dm+g3
	IqbnX2FjtI6Idfa/23kX5piiW6f6julVZeMrBtWcEgLsOgylcrzND8hCV/bTjF1XqaCuD/zps4k
	0iXdHpcIJxFj9dR1PMpjG3Mw8d1Lxu7rVwn0s0abldpmFhGD4=
X-Received: by 2002:a5d:5f43:0:b0:43c:fde6:212d with SMTP id ffacd0b85a97d-43fe3e13d46mr2897179f8f.33.1776416610833;
        Fri, 17 Apr 2026 02:03:30 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7524:fc82:dee5:4129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e591cesm4120151f8f.36.2026.04.17.02.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 02:03:30 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	shuah@kernel.org,
	horms@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 2/6] selftests: ovpn: fail notification check on mismatch
Date: Fri, 17 Apr 2026 11:03:01 +0200
Message-ID: <20260417090305.2775723-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417090305.2775723-1-antonio@openvpn.net>
References: <20260417090305.2775723-1-antonio@openvpn.net>
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
	TAGGED_FROM(0.00)[bounces-279271-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mandelbit.com:email,openvpn.net:email,openvpn.net:dkim,openvpn.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13CAB4191B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ralf Lici <ralf@mandelbit.com>

compare_ntfs doesn't fail when expected and received notification
streams diverge.

Fix this bug by tracking the diff exit status explicitly and return it
to the caller so notification mismatches propagate as test failures.

Fixes: 77de28cd7cf1 ("selftests: ovpn: add notification parsing and matching")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index 4c08f756e63a..c92415aaddfc 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -140,23 +140,35 @@ add_peer() {
 }
 
 compare_ntfs() {
+	local diff_rc=0
+	local diff_file
+
 	if [ ${#tmp_jsons[@]} -gt 0 ]; then
 		suffix=""
 		[ "${SYMMETRIC_ID}" -eq 1 ] && suffix="${suffix}-symm"
 		[ "$FLOAT" == 1 ] && suffix="${suffix}-float"
 		expected="json/peer${1}${suffix}.json"
 		received="${tmp_jsons[$1]}"
+		diff_file=$(mktemp)
 
 		kill -TERM ${listener_pids[$1]} || true
 		wait ${listener_pids[$1]} || true
 		printf "Checking notifications for peer ${1}... "
 		if diff <(jq -s "${JQ_FILTER}" ${expected}) \
-			<(jq -s "${JQ_FILTER}" ${received}); then
+			<(jq -s "${JQ_FILTER}" ${received}) \
+			>"${diff_file}" 2>&1; then
 			echo "OK"
+		else
+			diff_rc=$?
+			echo "failed"
+			cat "${diff_file}"
 		fi
 
+		rm -f "${diff_file}" || true
 		rm -f ${received} || true
 	fi
+
+	return "${diff_rc}"
 }
 
 cleanup() {
-- 
2.52.0


