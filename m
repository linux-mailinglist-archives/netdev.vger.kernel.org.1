Return-Path: <netdev+bounces-301637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SxRTKxvOO2rDdQgAu9opvQ
	(envelope-from <netdev+bounces-301637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:31:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 150AB6BE22C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:31:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jdT26ra3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301637-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301637-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C97543013841
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A8313B58A;
	Wed, 24 Jun 2026 12:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837381C695
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:30:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304227; cv=none; b=t7JQ5tnUqlak1nVc+W/wNtGBDEwPpd5DHh+AHliG5cdZxa7moJ2uho+CrRRbB/BAhrMQw9Zfg76Kit/tbSZtC7I8i9GtFQam10OrZyObLZF7o4x7QBb7l9zkqWYh0uGFO4GgtKcc39nKE7n0W5rpjk7boDFt7CXtZfhlRy468/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304227; c=relaxed/simple;
	bh=oWZSy2vnXbzemBv3Qg4Trq/YGNygJUwHFXQxIa9sI0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDhfIW4Gvyi3MjHOLFeH+dMiZJUYCUQQAt4BtpFOUC+HotjvRLY7J7X6Wo4vRNUfdSN+EdiBhVvavZRawai3RsJdIg6wHiNdNrgnfNZsE0DFS5DnUex6yRJfAV9KxM7pzeG14ZO6aMXLW3nR5s9UVwnBsg7otK1ZXVVeQNrTflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdT26ra3; arc=none smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7dfceeaf168so11057427b3.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 05:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782304226; x=1782909026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+8k9TIVBzrtkJ+5AdlIoIq3eU8KFjMxgcsnRy+gI+28=;
        b=jdT26ra32blMuBBmDt1H56hE/dwz8FR/vAvvDkBUVEdGFDwVPVURYXT2VHuMjCGRgE
         95C09sVPZVWTGeRr+k8/IIyh4tHQcSbEN/LD+5evYUKKNRyZ77ECq7mhgNZegJLIPxFh
         CruLZPY6AVzCpJQIpcu13Sd/BXxr7qiXQ1Ao93/44xo2SUfktFi+lVBlk4vIKN907pmk
         kK51as2km6VU7lMYN/6rYg2RN8s8zo8xGdvWXNpRXz+Ht4lPD6uLtQapbkM0V2HyjoSZ
         wfwsMQVjFhqdxedw4jqYdniwZV0KwsJVFv1ObRa/owEJSkkM955pzc4+k3ONAxB4up9e
         dmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782304226; x=1782909026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8k9TIVBzrtkJ+5AdlIoIq3eU8KFjMxgcsnRy+gI+28=;
        b=WZ3l8jl0yXSAvUnyShcZ0DNjf3Iy5CJnm51ApcmnQmcF+JrPZjyF7PKaIoMHl7T+rM
         p9nuPVp4E8OSWIGcaFgBE6ZPglOhhiv+9uxdRc/qib5UgnA+OgKPGNsJnCUT4R3GOp1G
         i5ePZJDQij5UJqozXEU+AxcKtEDFoi3NLAAsIIurEiL5XDm2QSNbpaSEAw9Nz7uf8tnB
         Mf4tm7EmB+JBmE254eMiSmpaq+HuTW9MixaZGN3ahIg6oMbl/Rvu1/hs23xMhdrYoYLN
         4TgqLW8Q8US9yYt2wGJ4owGufX1hzEfd1Vtm/gAm0FZZxswPEkVrHixD291JDDrGAZ6c
         r+ag==
X-Forwarded-Encrypted: i=1; AHgh+RogAADMcBXFL4UD8itqbHLrpEvi8jQ35ZlcNx64WyyQlD6sKb9UJEtqdD6+oHBX5RHDc0gjlgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYcNQuuPQnwnxcTLDzRxNlYbTMTwB5jh0H+ywVZN/k2dMD/Dm0
	xXlH3HuyHBDGmHvOCPaj65faz696NE5qJ/UEFKbUlvhQDlX7itdw9yuY
X-Gm-Gg: AfdE7cnyBDsKOQaiGxcsOK2r3dLRLQ8f1WcCrW92RhvU0xoXbYxbxBM7EyZACUPVS3m
	DhpcbGXX36FKoS52xDkAENPuvJnq3vIRJbXTl5wXv1fo0cWSB5EJC+vo4XzUa0CFib9tWHHxxgf
	+XKPNMOvqi1E3V6/OHOS/DAhMWfgrO67E1tGm2SblbYm8y/wNMuyR1TR+i+7hnV53BQq/IHX6Y/
	L9TFg7bKP5D/nlGP0y8OFN2W/q7G5cYL8HacXz5Sn0UiqvFlfVkx0c+LoZjLEgFIsfTW4uuoivF
	smlSlBqOGITzdbWGhOpMw7PyflPNg8FVnmacWgSd8Z9jKANSuYB3iaypPn40gSQbuLDQKGtEkYw
	S5BA5ckiR4iBGxLLepUQ55V7D+IRpBfHR47W+AJCRHN/mu4PpJdJFPXUGBHCetVmi8AjP2dBivs
	OSQUCzeRtuSwG+hIVkGT3u5RocUw==
X-Received: by 2002:a05:690c:c4f7:b0:7dc:c477:9e98 with SMTP id 00721157ae682-806c3a1a9ddmr62727187b3.31.1782304225501;
        Wed, 24 Jun 2026 05:30:25 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025c96fdb3sm57601677b3.1.2026.06.24.05.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:30:25 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jason@zx2c4.com
Cc: shuah@kernel.org,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] selftests: wireguard: avoid extglob in netns CPU count
Date: Wed, 24 Jun 2026 14:30:09 +0200
Message-ID: <20260624123009.7008-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.zx2c4.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301637-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Jason@zx2c4.com,m:shuah@kernel.org,m:wireguard@lists.zx2c4.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alhouseenyousef@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 150AB6BE22C

netns.sh enables extglob before using cpu+([0-9]) to count CPUs, but
bash -n parses the whole script without executing that shopt command. This
makes syntax checks fail even though the script is intended for bash.

Use the ordinary cpu[0-9]* glob instead. It matches the same CPU directory
names without requiring extglob, and lets bash validate the script syntax.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 tools/testing/selftests/wireguard/netns.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/wireguard/netns.sh b/tools/testing/selftests/wireguard/netns.sh
index a8f550aec..98b423494 100755
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -22,12 +22,11 @@
 # interfaces in $ns1 and $ns2. See https://www.wireguard.com/netns/ for further
 # details on how this is accomplished.
 set -e
-shopt -s extglob
 
 exec 3>&1
 export LANG=C
 export WG_HIDE_KEYS=never
-NPROC=( /sys/devices/system/cpu/cpu+([0-9]) ); NPROC=${#NPROC[@]}
+NPROC=( /sys/devices/system/cpu/cpu[0-9]* ); NPROC=${#NPROC[@]}
 netns0="wg-test-$$-0"
 netns1="wg-test-$$-1"
 netns2="wg-test-$$-2"
-- 
2.54.0


