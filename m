Return-Path: <netdev+bounces-277595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 82gWLJNx2WkqpwgAu9opvQ
	(envelope-from <netdev+bounces-277595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:54:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E53F3DD0F6
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37D5F300639B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BD13A75B6;
	Fri, 10 Apr 2026 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rua2GcJG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813C346777
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858064; cv=none; b=ebotlvIw30CXqMZyrGmPweXmjkwse9n/q65qQsDVJSrYrOoJkqb/xFM3OxPxyVV/AcnTeRHyy9Y9n7drtwmK6TZu6H2kg+W4FCl12EtbtvwqbJlFJHtVptkhXMUmPfkGzPkR03Puk8+sxbYGEd2RXVg3nHhu7qgdnBZ9uRaHJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858064; c=relaxed/simple;
	bh=2GYZKiMmESfr8HQrwf8o4CAPwyYxvDvPXuCBbAISynk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MtdP+dEGOr1bScTyv0r5Tj8HzNflyxjBnlpklObsBAxEOk9uo0vTJR1F8GPtw47A3VK3L/euU8QeWcHfs16DaCKB3zUUos6pFATrclSvIzeUDhY/ZZ9Dmg1Pk6DU5SE8x6FonObXvSABZD8JVRQVbJ5GnWdbn5DyeCxkapsWcTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rua2GcJG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b242062308so49031585ad.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775858062; x=1776462862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xiir2wXTWRWwN3biMYKwe5yW+4f9Zx4AfQCfsTlrFFc=;
        b=rua2GcJGM3+Y3G/6alRFhyiJJABHYAFR18KYyLqGwyEtgLnJCtcurrfVJdGu/Z2FCl
         7ufbv5mh6N81bE9Hs0l6PZAmPp0lF4UqN144nvPc5zzfWnQUp3EPZALMZLTahGV/Rus3
         OZrfpiFn5XUgGy+t3xjJkedxFV3zpIT8dJz0zeIZoxjqhexIxPwI8MIR0zURg5XonaU8
         Q87sLrgrZuQ0Y0ANqeLswadevR9iUmW0neJEhnxtsR6SiT1A0rZiBWVxwJj3eNKVUekg
         o06qi0/ODJvR+xXY39VxVm1KvofKuBIyAF6h/2R5eiS/wZCTkLeijZYbhav8dvCG6so4
         7dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775858062; x=1776462862;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xiir2wXTWRWwN3biMYKwe5yW+4f9Zx4AfQCfsTlrFFc=;
        b=ZtwCrTHlXYTWja4y+t1ykBMKd78jAMBp0oj1nh81Qw5EG7ueVaT0R9EXeA5ig5n7fu
         05FigRKeYgwYswLI6VY1yZIPwV54BsQ1S6JB0eeHAWLF8AmjBoNPaMF/T8Fxgyejl2+F
         eY5Yrad+XCUeb5HrWePzBGzW/DY4sOxhWufSdbJxpNc3RTfgMFDpUAdnaBMRmTmfACXH
         6fm9Y/OSeV378QDaZzSfG3Tyiw2kEB0PejqmvtUpAB+sUvrFdqJD1cOCcW4OMss42QKg
         ivdmY5Nxs+UlHmxY7nSe+qJidARa2mv5tIOhp8rxH4bUmBTzM1GDx+EPDjMzAe2xCzW2
         4IHA==
X-Forwarded-Encrypted: i=1; AJvYcCVW8zSIB4aTCPwNsUPEHU1/DLTWRoORZMZjjdJPvjZNRCjSLaJC73NHdL+pYGhXablCS1i6j6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDsGoAJAt2/RVvyT5P8mlSed4A9QNAin8nTeOhy5n+IHcvXe6K
	59IeFPl1l0GQnZoj416A9GWd3my6GW6mD/AJJhIu4UimuLj2PpMJn2LagbbTSJUTTR4rygjBHpt
	1oS+wyw==
X-Received: from plbbj6.prod.google.com ([2002:a17:902:8506:b0:2a8:a03b:32c7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b83:b0:2b0:59fd:bbe5
 with SMTP id d9443c01a7336-2b2d5944aa5mr55256395ad.4.1775858062356; Fri, 10
 Apr 2026 14:54:22 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:54:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410215420.1698033-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] selftest: net: Use port outside of the default
 ip_local_ports in csum.c.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Mahesh Bandewar <maheshb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277595-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0E53F3DD0F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

csum.c binds a socket on a fixed port in init_net to test
the csum offload feature between two machines.

In our testbed, the test sometimes fails with -EADDRINUSE.

  bind r: Address already in use
  bind dgram 6: Address already in use

The fixed ports (33000, 33001, 34000) are all within the default
ip_local_ports range (32768 ~ 60999), and other processes may
happen to be using them.

Let's use ports outside of the default ip_local_ports range to
deflake the test.

  # cat /etc/services | grep -E "(13000|13001|13002)" | echo no service
  no service
  # rpm -qf /etc/services
  setup-2.15.0-28.fc44.noarch

We could add an option to specify ports if needed.

Suggested-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/lib/csum.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
index e28884ce3ab3..4e044689bc37 100644
--- a/tools/testing/selftests/net/lib/csum.c
+++ b/tools/testing/selftests/net/lib/csum.c
@@ -105,9 +105,9 @@ static char *cfg_mac_src;
 static int cfg_proto = IPPROTO_UDP;
 static int cfg_payload_char = 'a';
 static int cfg_payload_len = 100;
-static uint16_t cfg_port_dst = 34000;
-static uint16_t cfg_port_src = 33000;
-static uint16_t cfg_port_src_encap = 33001;
+static uint16_t cfg_port_dst = 13000;
+static uint16_t cfg_port_src = 13001;
+static uint16_t cfg_port_src_encap = 13002;
 static unsigned int cfg_random_seed;
 static int cfg_rcvbuf = 1 << 22;	/* be able to queue large cfg_num_pkt */
 static bool cfg_send_pfpacket;
-- 
2.53.0.1213.gd9a14994de-goog


