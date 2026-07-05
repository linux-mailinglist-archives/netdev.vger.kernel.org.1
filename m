Return-Path: <netdev+bounces-304751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ez0pL7T/SWqm9QAAu9opvQ
	(envelope-from <netdev+bounces-304751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 08:54:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 209AB7092EB
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 08:54:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RawOgPK2;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304751-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304751-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 686D8300A10E
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 06:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20822303C97;
	Sun,  5 Jul 2026 06:54:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24918C2C
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 06:54:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783234474; cv=none; b=mdNagqLdlO/f1YP673xgzijutQUQFU8H7cvdYaIcAmvIh/ONbhIsnbPEAwAvERGwAKnFpWtj3qSzC6mILRFvDSCiH25tkQ9IVtJvh6qdNyjiNrho2oVbSc349tXhZfP83XlJs+xHoP6f/KwerNAfZkKbnfkdaSI7oQ0vt2qQBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783234474; c=relaxed/simple;
	bh=qJWFce+OgM08nJ4vu/GGRAqS9Nof6BxJyncuX3fp9dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0juJYSMsCF8B69GI3oCD0Fero3ONVPaC0prpN8rKiGKgbD7zrjdq7Gi604vfl8kK6l+8lK/xLM1VzTbB42B67lKPrWhWVo/m/dAe/cHcFEVKcHqNP+AUFgpQchiwhGI1j18AEe8NM4MUuoyN1SaYgUZbqH4D8laRgDjZfvkVak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RawOgPK2; arc=none smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0006ea8eso10469531cf.1
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783234472; x=1783839272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9B7FUiAOf0n44X3RM3v2DQW8rvTR//KyTFqv6RiiUxU=;
        b=RawOgPK2T06CJnl92RmvwQzAiJCEDFuec6DEaTWURJkcYyVk32dSIVW3koeCe1bQ3o
         Ky5/X83vIg9inU4zfiK1scivLNg4n5SQPT35LvoDmDI+zxARJXpEQseOlbBASHCEGiW/
         7b9YrswS5h/eS9hYde9i4TFurQF8dgekd3AZVz/Zz0mrTu4AbwB22fYuVqbKWNi6iJa4
         eeOOXDiyxzqMMl1OJJBsAQzTbupgUu63Hl5XwgN0W0Ssnx+73qrrNdnVBGMKFTQx7vQp
         C5PiQqDqS1a3gm9n5VShIVDPut8V6mSOfOwHE2jQqItAwZax67ZUTQJ58pPuaHSUqlBn
         1BSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783234472; x=1783839272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B7FUiAOf0n44X3RM3v2DQW8rvTR//KyTFqv6RiiUxU=;
        b=QiluBpeHoXIliBFOlnhnGKJTfygW9aEXPwiog0QPCPHCs1d7n2iEzs2idGDdU6a3dd
         cp3Sgh31uHvVB7XyCTkuB80eyCzvj2y2jAZXkfgTksal4U7CVh9pCSs7ucd7mfUy59C+
         34m0uTIgGlSoyXvbbN7rQG4qHDbYFEMFtoyw/rH0tZXzrsYeRoNvyloL8vkahSutRzhN
         QUnFZnujeZVZ3W7nMOO4ooFMvlgOVDWmBhlu0FzgBQXjZHcd0RIBAiXJg0cCVn1CGqmX
         1IE/1evhL2zAVBpyj97YAfqt331hcdL99t3HcexMMGqhV/GqixHJ20/U/yiNpHxtNzTK
         gvkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tms2GF+bVvizkHOXgcd/A1Q/sJVEGDRxN/Dw/gGagtblx/oi3Dboy6QNP4ddZdn6tc8/a8+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFAGaNWY2lZYDXjaNEPOeSFfdSMDOe9t3NcXMXLDoS19qKDcN
	khpPOWt6BGHbpnYym7XmuNn8ofiQ90a1fmOyhTPQlVfgk0P6bZYbZRJc
X-Gm-Gg: AfdE7cmHqZ378UPMgI7dcxHn5xkn5MazQq89mRoTEBb/nKt8sjBPLvWVo46Ny9ZPvq7
	c62IZ4fS+HWEutaKsH08X6/kz6PxdVKmyH8/lGp6M8ACnsEK9sPHHAFRmQ3nTk7AtwS+coe5e1L
	3SdfMf0tkDwz5sA8xLAVQc917oHQT/hzhydDQTMUGnl6fydyzCFAztTsL7sopxIfsi/2XcA0kTb
	llKgUQMjVJVjGCEG2IXKHhOqPoI7c+JMvN60EfGh3RBTY0kyym+hpmEZ1HZnWXsNDYaJHnQBDNC
	lk3lQcg5RfBWioOlrJO9lTURmOozEOgFSDJ/vl7DaYaKTEfxK0uFluxvspQ8xybksfwh5nX/pyG
	2XBuKdha6PsqqWoVhbXSwCqdRP7fToTaV48Rdb3JyfBJi7vxXjW38hx07g5HMIlE7rGTtzEfg0r
	blARp60wtJ27loyH+cdP/SG4yxBFMEGGI4S3xi8Ntmlg==
X-Received: by 2002:a05:622a:5516:b0:519:f884:b587 with SMTP id d75a77b69052e-51c4c227bcbmr90608731cf.27.1783234471761;
        Sat, 04 Jul 2026 23:54:31 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41abb484sm62027661cf.4.2026.07.04.23.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 23:54:31 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] rxrpc/afs: leaked peer during netns teardown
Date: Sun,  5 Jul 2026 02:54:13 -0400
Message-ID: <20260705065415.120034-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-304751-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
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
X-Rspamd-Queue-Id: 209AB7092EB

Hi,

I can reproduce an RxRPC leaked-peer warning during network namespace
teardown after adding an AFS cell.

Reproducer:

  dmesg -C

  unshare -n sh -c '
          ip link set lo up 2>/dev/null || true
          echo "add reprocell 127.0.0.1" > /proc/fs/afs/cells
          cat /proc/net/rxrpc/peers
  '

  sleep 2
  dmesg | grep "Leaked peer"

Observed output:

  Proto Local                                           Remote                                          Use SST   Maxd LastUse      RTT      RTO
  UDP   [::]:7001                                       127.0.0.1:7003                                    1  128  1440     37s       -1        0
  [   37.969040] rxrpc: Leaked peer 61 {1} 127.0.0.1:7003

Tested on:

  commit 9fbbf69eab3417732ec2adf93e42e507351dd80a
  Linux 7.1.0-13212-g9fbbf69eab34
  CONFIG_NET_NS=y
  CONFIG_AF_RXRPC=y
  CONFIG_AFS_FS=y

Thanks.

