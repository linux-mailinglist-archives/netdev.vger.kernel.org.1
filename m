Return-Path: <netdev+bounces-279128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM6XD8gx4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:00:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD1E413EFC
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4904430557D8
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7F234A786;
	Thu, 16 Apr 2026 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjMSWclM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C679D20C029
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365851; cv=none; b=pBEx/+CEUvWjqaZNTBxoKWEWw4aB3gJhJ/k/hkvYS48IlW0RPqIWDh8AE1VKFLB36B3yxpn6NjJ0URtEl1SSuoIKAGEOeqGiOC2oJ+dpOLOaQN/4JBSVAFcxAn9IxRYFk7fVWpxWm67yYM5YAV96dRIONfg8TM+jZ62TY+TzocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365851; c=relaxed/simple;
	bh=ErwOnT0JgTTw7vhCQZp+f8jltSpFdP+zGg2SkB2ZJU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6QKgysfTGSc4vYURkbyYEMq6Z2UxIu39udM26yEh98Zo1JjkGKKil+l5WjZAk+CXrsbRdtMARUvQIkbxSMHYMOHhfXevkso9e9TRVTxE1csReXvTY2Pymun7vyQ0OB5Pu/K3FdrevIsuQdyz/xx0/Z4LNsH2zcgPqvU1cDR3Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjMSWclM; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7dc35728a57so5285091a34.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365848; x=1776970648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi026evQFCdtftLRIl+IFDB1TLnlqPPKmYddAHJGBWk=;
        b=WjMSWclMkPRC6tBlIUF7ILhoWx/QVqr50/TZ4hZRk/p0UVUlAA0y15epFhT0n2Ulyf
         TvQSyhNui1Teu58yW0IG1OqDS0f1KA4pb96ymxxU0EfsbjO3ITluoNYhANn6zJ7CbfEn
         BCc2vgaazFTGj7GosEqHOEQof9pTKEpGstHBZ2nH1YRo9QLhV85pKqxantlkcadAukKH
         buzWmZ1SQyVc7/4NVvG1eeq0DGwp799SqIerbpXpLc7NGSjcnKp+hn02LX2rJzXaLiWi
         XZnu29mYXx7Pyubzz0Up1jQc4+78XZYL0rYT8cc/2tT4zW6/6Iv7PMyB9R7iP8yMOIfe
         CkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365848; x=1776970648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hi026evQFCdtftLRIl+IFDB1TLnlqPPKmYddAHJGBWk=;
        b=UIH0RiuI/rDeQTR+6vTIlKRU1aelbhc7msTTVAuX1gm7jIOEbs0tQC+MzQwSl4VqGe
         3voP6+jBv2T7ym5TmWsh2NYyrp6RITIBgX80BbLkGHvUEIV7tbeDLNCsz2xI1QAp6Ve7
         v0uKDgnVfNDwu/wO5CSXa6RkQQiU2WcPJDcr19UmjbdmOi6eFRC4ySeO1ypOApos09q8
         8RhenjXTHtbm2keIEDbcJcg89baYTFhY/+BsMp0qPREsWdcUFNhqo7xgrTEAQ05gbk4P
         L9D/Vpi5Ukv0mTaavix+bPoRxZzo1+V8Cf1fz2SouVT35Fl4Q3AwGGLOKgm8PDuJXNmV
         eywg==
X-Gm-Message-State: AOJu0YxliCi/jzzFU6KqtCk63dqYN2Te0YW9QDnmEwbxMJxqceZurIby
	A2Xhfuyn6S+7VzLrg0l0rlkiJWf7rlNl1XeG290SMF4DSrM1Wxnpi0ES0pB7jEDb
X-Gm-Gg: AeBDieso7w38AXGoAjIddjc4IW8ABdmT8eP0gquT0EY6cSdzGhsj8eDTC2pfUaG728i
	4rwq56h8KjmuhZza8IynqyWUst+PGZsWzjZ3mjKvjRbRP9ggD1fL8N5wMsX+qfDoZ+QPuEh/rP7
	92YtHqaaptL9mg/PPNlClpRG5Nuh9CW1Jjf/5DVtEv0gIHym34YUHwU/nZUp91NiixyboKpdx65
	f3jjCUOtrtDqFuCvElfgZeccSZk/CUcz7x3skZLyIcCPkens8gNmevtWZPoM0xTS1RTPYwW2tLt
	j8P1xa8P0ukOBCy8uP1L2FsaRmp4s74uQrzorvi6oG2MoKjWRyq/k5vn4Bl+6j2+qu0bkzTkie6
	VTBFUW0+0gMXbLDqrrwnuUPnT5m9ur3PeSDUPjC64BdldV1uGoh29DFoVdNfSSZQ4FK9Sjc84KG
	w79pRjtvhAbhYfcK2E7G3bGISZuvzI
X-Received: by 2002:a05:6830:67f4:b0:7d7:cd20:fc86 with SMTP id 46e09a7af769-7dc9272d923mr345102a34.25.1776365848621;
        Thu, 16 Apr 2026 11:57:28 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc90c90896sm504965a34.25.2026.04.16.11.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:57:28 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jiri Pirko <jiri@resnulli.us>,
	Jay Vosburgh <jv@jvosburgh.net>
Subject: [PATCH net v8 15/15] selftests: net: use ip commands instead of teamd in team rx_mode test
Date: Thu, 16 Apr 2026 11:57:12 -0700
Message-ID: <20260416185712.2155425-16-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416185712.2155425-1-sdf@fomichev.me>
References: <20260416185712.2155425-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279128-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:mid,fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jvosburgh.net:email]
X-Rspamd-Queue-Id: 6FD1E413EFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace teamd daemon usage with ip link commands for team device
setup. teamd -d daemonizes and returns to the shell before port
addition completes, creating a race: the test may create the macvlan
(and check for its address on a slave) before teamd has finished
adding ports. This makes the test inherently dependent on scheduling
timing.

Using ip commands makes port addition synchronous, removing the race
and making the test deterministic.

Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../selftests/drivers/net/bonding/lag_lib.sh    | 17 +++--------------
 .../drivers/net/team/dev_addr_lists.sh          |  2 --
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
index bf9bcd1b5ec0..f2e43b6c4c81 100644
--- a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
+++ b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
@@ -23,20 +23,9 @@ test_LAG_cleanup()
 		ip link set dev dummy2 master "$name"
 	elif [ "$driver" = "team" ]; then
 		name="team0"
-		teamd -d -c '
-			{
-				"device": "'"$name"'",
-				"runner": {
-					"name": "'"$mode"'"
-				},
-				"ports": {
-					"dummy1":
-						{},
-					"dummy2":
-						{}
-				}
-			}
-		'
+		ip link add "$name" type team
+		ip link set dev dummy1 master "$name"
+		ip link set dev dummy2 master "$name"
 		ip link set dev "$name" up
 	else
 		check_err 1
diff --git a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
index b1ec7755b783..26469f3be022 100755
--- a/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
+++ b/tools/testing/selftests/drivers/net/team/dev_addr_lists.sh
@@ -42,8 +42,6 @@ team_cleanup()
 }
 
 
-require_command teamd
-
 trap cleanup EXIT
 
 tests_run
-- 
2.52.0


