Return-Path: <netdev+bounces-307770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RtaoN1GfV2o/YAAAu9opvQ
	(envelope-from <netdev+bounces-307770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 16:55:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E075FA29
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 16:55:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jvT+oBVU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307770-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307770-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A564333A786
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4A844685C;
	Wed, 15 Jul 2026 14:35:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90242BC37
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 14:35:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126159; cv=none; b=C//vZsNKvtI46mz7lUb4z40kBco5sPVam4GBzb+IcdGR+SsaWGFgt41ixdQ4f1eY8QBki/EwLgnJBgx74FoRq4oXGK2DiGkue6ndeib0rz65zfpAzSgjb+gcxYAvZ1MW6Mxt54k+y/zNNZbwG/JiZOdlHDFRD+qNfyGhDmg0epU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126159; c=relaxed/simple;
	bh=hxmKRPMmqGMKGywEfTu9KROw+Ys4d3cc+jYzBoXbH1A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WQFXfTB05jIKGN1S4Vv8T0ctCqhcQjtYQJFzueetIFbeHhrEuLJtkpQH7VyCu5yIxpFc53+e1f+U6/3KZoh7cP9yHvmEiuegNETnHhsxh3+u1msfKW5YA6VS6hnLSXHaNSJEyX11hlGub/foeUGrmsU172chR2iBDPVXaSeG4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvT+oBVU; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso3533006a12.2
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784126158; x=1784730958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z3P+ay8dWFUyLvh92+wpcw02jxXPVk53CiD8LmKlD/k=;
        b=jvT+oBVUxc+9uR00Ulxnxc9l1TVjSUAaJWNrjsnWQJd/DjIjZx5gnV1J3dIVUep/dX
         jAPjoUOW5xX8hRqkxm++CIEigTCXnQ/1eIaB1WrJA8cR7DiNa5H4FuQO1eNTUbxyZhm7
         iTwSl7Jj3bs9jX47Lowr956C2t5HEmSBVLYSKmqQ0lPPw8XeDwuRtyWivnwExxNyNHe7
         890kQOUgNB72SJUSjLTB8wC1+kzpHyIYp01vLBVSw0PFJQ1TViJqgclP5nhvu4Cf+Jx/
         PluddWa/+0GiOCuvAa3/bhyxtrXjmJF6tUHIFbGH5Pg4JcYtvFURBZWPSyzGWzzpRt02
         2cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126158; x=1784730958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z3P+ay8dWFUyLvh92+wpcw02jxXPVk53CiD8LmKlD/k=;
        b=UgjuzXNi03hkZtW+xBYV4Lb2cbUg0wbhCxF5FxQvNYSpbXMdYB6oaphSedJjIqmE1M
         alPiAP6e3Q5z/K6y7qfCNCf1lFftGqmkLJwcl0cVYtxW7ZHW7ixzfBz+LVeq0U0MDLvL
         kXMrMLegOpheoT94hjaADgyvsdrXnW/jRXBkFXQphBWPNzadLE/GgChmmUTQfef9ljma
         pKEZNVtz/zVN+mMDQbkdgmJR9srInd4da2qkvR8zhOMgYsEzQFKAKFxeK2I+4DldKbO+
         aw5DOklM5NKoTYkq6Gjleii2Bl8bdjOY6KYT0xWKGKbE4q2WfFqOt+BiHIYoDFsfw/Zt
         xJeg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0bp+49OatzZd6GaOWg6ZfyAbzMvJz/eG1XhrRJTvQiabRkktVrKhdo0iaHgqjKIaVQ3MkkpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmbrhkvUEPsZJOtEXjNn3PFRJWd8FT0O9hChil5T646LmnOyu
	9WBYQaNnErMPMiUOpb8INbgdG3afGtC5fLMG859qgAxZmSV9GJz6w/oK
X-Gm-Gg: AfdE7cn1MgBQz3Ju2GYYA+uikTBJENB30amMm2x9U0X2TxF0M6P1qugs82lTBfNAI9Z
	iU9fgn7hmoUl8IAB9Rxt2aaQU+OnNgKq8NfVhy1qMDbfNmfitftL/v4zdmfct53EiJVrTY1YuXE
	MlTTpMhsz+l8KU+K70bQCq5VfYlUvcYuIn1utvUWHlHoe201Y7M2vcuE7dEbG92bPLY4yy8rKg3
	v0R1cQxBQXVWmLzzmE/LS2DJIllaeEVX6kkpuK96PeJY9nj1g3PASqC9uVkU5nhBmsis41sTJhK
	eqWhYPhPGbybyo3I4Nyy5p5eXqoqGFqRxCaL12uUpc2xv8ZqcKuQpm7OQ9WufAJcoBktW4+e7Uf
	xojJYOwfRQXtYdoFwAVvnU37GTU4UY4u9SzFfHEWvRwqfzQg3CL4v3cgRD8+gAzR4AWO6RPwnLy
	5aAXdoQZ4EJ6ZAYjnb2TJzG2YGTj4CfGcWlF9WxVG0a7kVVIeQncQ=
X-Received: by 2002:a05:6300:6d85:10b0:3c3:7a0a:18a6 with SMTP id adf61e73a8af0-3c37a199b18mr757383637.18.1784126157664;
        Wed, 15 Jul 2026 07:35:57 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:90:2db1:3066:c473:74d2:497d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fcd31sm2370744eec.4.2026.07.15.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:35:57 -0700 (PDT)
Sender: Deepak Rao Gaikwad <deepaksraog@gmail.com>
From: deepakraog <gaikwad.dcg@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: selftests: fix typo in ip_defrag comment
Date: Wed, 15 Jul 2026 20:05:48 +0530
Message-ID: <20260715143549.14094-1-gaikwad.dcg@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-307770-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[gaikwaddcg@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaikwaddcg@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 289E075FA29
X-Rspamd-Action: no action

Correct "thourough" to "thorough" in a comment describing the
non-overlap reassembly test loop.

Signed-off-by: deepakraog <gaikwad.dcg@gmail.com>
---
 tools/testing/selftests/net/ip_defrag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ip_defrag.c b/tools/testing/selftests/net/ip_defrag.c
index f9ed749fd..146f2a2a5 100644
--- a/tools/testing/selftests/net/ip_defrag.c
+++ b/tools/testing/selftests/net/ip_defrag.c
@@ -378,7 +378,7 @@ static void run_test(struct sockaddr *addr, socklen_t alen, bool ipv6)
 		} else {
 			/* Without overlaps, each packet reassembly (== one
 			 * send/receive pair below) takes very little time to
-			 * run, so we can easily afford more thourough testing
+			 * run, so we can easily afford more thorough testing
 			 * with a nested loop: the full non-overlap test takes
 			 * less than one second).
 			 */
-- 
Deepak Rao Gaikwad


