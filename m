Return-Path: <netdev+bounces-300900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NgskNS1DOGobagcAu9opvQ
	(envelope-from <netdev+bounces-300900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:01:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5026AB888
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:01:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ee1BhgFN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300900-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300900-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A23243005D2E
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 20:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C6C233953;
	Sun, 21 Jun 2026 20:01:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F640D596
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 20:01:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782072106; cv=none; b=cHWlxNEhkwWqx4OsM3loVDLdvooKfKx/Ys1lM5DwX6CWb8IdCA7OTKq1VeQCQzwlIiRnth/a6sOahf8XnrRg1tp1LH9PozMuImt6Hs2hYemwksnnR3OmxS4SbdxOxfgM5lrs+G5vzU7l7x+0PEexR/mkLqbyByL69jsnYuTV1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782072106; c=relaxed/simple;
	bh=nfYXMoxNWupm+5Amqd6sHBduMVe3NGYUMRUkUmxi9js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmsk/B7r1qHc+pfLljnS/jrRyjhIeVyUqAedMZt1FtQxnzumZ85O1JKiaal6YD+5kQ3PBPBWkGwSMgL+RqkMRgFBh2dgGQo2paIqrqr3mpnq9QRJBlxZPNFE3jDpOb1mRwIGHqIjD3wnoTkVufegBM9edvwKo3+z1n8TrZkValM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee1BhgFN; arc=none smtp.client-ip=209.85.128.180
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7fe4808741eso38539037b3.1
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782072105; x=1782676905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rrQ5njkEEKV+WVI8pcLRxhVDp/J4nrs+car9v8weH+g=;
        b=Ee1BhgFNafEWdeIFj4OZGeE6k5wPMtZDdoLBO3xB/dxHoz+BtO7o9cO0KZUCez8eqA
         yuQtKTAPhUq8RAKs3kHCu2x/bRcE7ILrT1YXViK2d4NohmrPs9nhIsgvWMr5jTjLSr4s
         EjF72FhPvpJgKJmgKRcISgenxbgVlBMUuaQvIiv7XUv7iZzQtO9ETS0IvsusuYXxB4O2
         e0Y/XeXMVrBQMFK/K9l++JMARjALnFSVFBsEuJdSl8AUqLqVRTvp1VLizOJAOxx2BJsK
         9V8OaxU7n36r7aOX4J9Op24RUadTL6meG3jSuLe2uHPulqbUSrjw8YKLwN1zkSoErsHL
         NR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782072105; x=1782676905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrQ5njkEEKV+WVI8pcLRxhVDp/J4nrs+car9v8weH+g=;
        b=Ix1YWNVpIr7okLfSMdUJlRe+rUvAV7PkYtf2/nfBZ7ZYx3ZU4u1xgkR+H8sHE0T3yP
         T2JlGFEy+AFVedkKNBA4Evu2ozqpBf+6YnYh2hjGLohCsm0JWFnw94O8xqm9Cto7L33a
         M0tm2HVEO/1/O5Qvj8BW6SB6c8yHqkr15rhJc26e4ovVjOIvr0CNRsv3vWGkoSW45Fxa
         ku5V+8J3qGZMbqAiBqRXKq7JvZOawdy9ks1f3mLjk0r9jbol439AopFLyL4q0z69GebV
         XBvzdvPc9Ewmv87Coy0dziKnGguYqy5/VCetbbHQzkPZHdBIqz3ygnxDiyuqnE/DCOP/
         R29Q==
X-Gm-Message-State: AOJu0YyijAxfyrx4PRyV/6sa12CvITSbdiakvcs1Bb8PfrlrKCIRNQhR
	IEdKnnG02oqzKIyUuh/wRSmih9OOIUR3eYBKoI/jLyDEvU2zksOcmj+zrNuiaw==
X-Gm-Gg: AfdE7cmFTu3NjllcTDYntDx/7txrH21emy5LRY3akgqGbeLI3esrRC8SM844b0CmGFH
	qlbKlRvBlF0nhDZAttvm0YfF69KPMAq6T/B596JGwxNlcWA4ya8EvbrkyZKQe9emmY1bdtMntcC
	EDtZYDsEGNFLq3Go4H8hVYFCwUbxE8ymljXwbIgRdB/vk44o24a7VjB4VshjHtGEjBYeQHBHOwI
	xdYSlbENYkzPvTTWYEYPQwtMGev6qOvBK9ISdJJEPTPXjD1gEQP3/S3isVW58PZ0XXT5RQ9qHgJ
	XnhHzpbOxQ9KJyYwyLCcknSi00p1yxglS+D/Cdb/OWavXMt9gFCEoWVpf31ZnFSN5NVUf/F/Czh
	tG6q18N2nuvbUedoHe7rdaywbXI3UyJoPdaXPDa9coi7tqf9D3oU50qKbOHXNAh3kDoV2EppKwl
	PWLjFlHecocfLvdRN+LVt4c3qUcvZUvgCJwoq6W+UcpqgkWhwCrPOYB0ki8lohQeynFf7+gXOg3
	Um1oIRb+/8nfLC5F/s=
X-Received: by 2002:a05:690e:b87:b0:660:5dc3:3fe0 with SMTP id 956f58d0204a3-662ffcdaf26mr9377532d50.14.1782072104534;
        Sun, 21 Jun 2026 13:01:44 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66314d772b5sm2673454d50.16.2026.06.21.13.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 13:01:42 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] selftests: drv-net: so_txtime: relax variance bounds
Date: Sun, 21 Jun 2026 16:01:18 -0400
Message-ID: <20260621200137.1564776-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
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
	TAGGED_FROM(0.00)[bounces-300900-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A5026AB888

From: Willem de Bruijn <willemb@google.com>

The net-next-hw spinners on netdev.bots.linux.dev observe failing
so-txtime-py tests. A review of stdout shows most failures to be
due to exceeding the 4ms grace period. All I saw were within 8ms.
So increase to that.

Double the bounds from 4 to 8ms. This is still is small enough to
differentiate the delays programmed by the test, 10 and 20ms.

Fixes: 5c6baef3885c ("selftests: drv-net: convert so_txtime to drv-net")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20260610170651.1b644001@kernel.org/
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/drivers/net/so_txtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index 75f3beef13d9..55a386f3d1b9 100644
--- a/tools/testing/selftests/drivers/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -37,7 +37,7 @@
 
 static int	cfg_clockid	= CLOCK_TAI;
 static uint16_t	cfg_port	= 8000;
-static int	cfg_variance_us	= 4000;
+static int	cfg_variance_us	= 8000;
 static bool	cfg_machine_slow;
 static uint64_t	cfg_start_time_ns;
 static int	cfg_mark;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


