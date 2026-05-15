Return-Path: <netdev+bounces-288312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGEaGIobB2rnrgIAu9opvQ
	(envelope-from <netdev+bounces-288312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:11:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB8C5503F0
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA8173006B2D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D959B2D3A60;
	Fri, 15 May 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAq8Th8I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732CD2236EB
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850326; cv=none; b=VvK+cJ/MQFhL0B13yzPF0KFqAv9V3OvDMa/v0wnVRCS8FtbC0Db9NgklLj0MGABmDyk0cVaJSE2PrhzNsbN2+dD8bSZYX/mQ8w4KkyMJtQRDbXoMHGiJnZxprmSwoLPaUKpA3yM42pfvXdurQtF+ESNtSj6A+bUy9kLdneHcADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850326; c=relaxed/simple;
	bh=honIpHjQXRaEfjMyiAeWROXCZ8T2OieqleA+mRE/X1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2A8xZMNavqXBq36g/GL4ehwW99yl/VVKnFbth8VsqGbfR4C9/QgEnqfrs3F4stq1UYn6WWXf99MWcUBfmFA3sYDmR+vYdYIfgU/Ka1Qsa5qdO+8s03PYahy6p4eyd66gqSviMqwAL7vN0kXH8cRjI9PNxqy9mP86AIcZMf40BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAq8Th8I; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-632a055fa9fso2386700137.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778850324; x=1779455124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qpx8RNnGHJ9ymqlzPRNI9N2p4opJtjSN86qDmoFZ1hs=;
        b=WAq8Th8IkNwUEg7G+VyKMI/si1veYwNhUa4R8DhH9YWz8gAeR2h48zsFikABHVmpO7
         EC8kC8xZ1OGUvgNLRxov0R5E1P4JzKs7PvXtg1+es7QoMBJDkc0LRtf5kFu3of25B2za
         jCmYajzf2WdAaHvzqERVEYNeiMkBxK3yr8qzp9VCeA5TFx7cPMd35dzAqajWv9RnpxOm
         TcTvXAx3YZU5aiJP0dPEbVP64tCo2F5Z5g6p51RJ1rtHi/udMqWoEwWifZksvbf6/Y80
         xZZcpqT2yPAx2Go2/OaYDv9ejPTF6RHaF0UH5IQhdB2Z6HD3wPSPGfR7dAzLrTcPQegH
         zIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850324; x=1779455124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qpx8RNnGHJ9ymqlzPRNI9N2p4opJtjSN86qDmoFZ1hs=;
        b=jD9webggyp6SqlfC79DDeINigj9xMW9GW833Q3vVcl2lrtR1peFMm9MH3sVRqEPZRs
         Zbxvf3BGPTTnATTwSl6Yy6B6etE4bqJqY92c8VUV55ZfbqalMsnZM1kBTz9Q5PzguURg
         toBlDiEmpyS3NunX1tLfKC0PsxGVkBQOWNbAnD5wNgk4XjIutf4bcaOtNgEGLrq3y2NI
         c9WYAkaiyESPWaSSu6bt+FKShrQkjM+XAsqeA/0xGpnGUeB1wpofgyXmyzENFgSorqs8
         te35iXF66vyYSA/xggD+hy6FuE04Joc1G4/cpKjry7S34X+bAE8sx1OobLmaqij5l0Wj
         2hmA==
X-Forwarded-Encrypted: i=1; AFNElJ9P1aDZyGnGxFaIjtzUIenAEx8XwoMDCz3SIopm9CWggaJF3BRpjo7f5rZEuJpjj7lwx6TKzbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xkkiG2u9gep6cv2uhlLCrxWCl8VKB9wxK3PFfviIXKbsIbd1
	8+foNS/vtmGVtPHtYhNhXoJQrls0V6V4Mn4IraGt8n9AuuDeq2UqFMiO
X-Gm-Gg: Acq92OGG7kLZHfphTUHt2+WRRXeiA1qU5pR6GBopad2quwbnj9iEJdKyyJbVAhj8FrZ
	VMEAyz+pp0BRzKjCdxTlA9rOG42cNHU3URDeaeamWUVbCenp7WC6hbAnGbQnPcbi1AzKL40euHG
	L0cHoDkBv/3q7zrfWHe75s0UC+5xKW6/bMXjIQNWiJ2LLqZEzzajrj+yGuRARLYeWoIc2AB6Qhf
	1QkiEYVoGS5YUa/7q7sDV1zVhxQIwmLg0RHF0oOqiDtsy+s1JaIS7e/Hq095OSQsfrimiQZu65T
	Ly9+PJRYjjVmAwjg+YKNAa06lEvfpmrqp/0kLyTrKVuBCvEdYD0SWLyzyT0LMHup3fyLwZAqrSp
	cZqmShJ9b4D13Kabq2MGW8+uf+3xW2IMpZWLbQs21HZ3lpYZcCxNcn7hIZ30RHPWT/NY9E6Q/ga
	J0PtxDmMsi37JVlyHAZ+B+j+tZ7F2brqxFx3xwkHq1bpCaG6GUMbQ=
X-Received: by 2002:a05:6102:304d:b0:62f:2f1f:599b with SMTP id ada2fe7eead31-63a3d21f6e7mr1756693137.7.1778850324210;
        Fri, 15 May 2026 06:05:24 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba181322sm541982685a.7.2026.05.15.06.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:05:23 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v2] ipv6: route: Unregister netdevice notifier on BPF init failure
Date: Fri, 15 May 2026 09:05:17 -0400
Message-ID: <20260515130517.779406-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CCB8C5503F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-288312-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ip6_route_init() registers ip6_route_dev_notifier before registering the
IPv6 route BPF iterator target. If bpf_iter_register() fails, the error
path jumps to out_register_late_subsys and unwinds the RTNL handlers and
late pernet subsystem, but leaves the netdevice notifier registered.

Unregister the netdevice notifier in the bpf_iter_register() failure
branch before continuing with the existing cleanup path.

Fixes: 138d0be35b14 ("net: bpf: Add netlink and ipv6_route bpf_iter targets")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
Chages since v1:
- Unregister ip6_route_dev_notifier directlry in the bpf_iter_register() failure path.
 net/ipv6/route.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index cb521700cee7..de9a1d4c72d8 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6924,8 +6924,10 @@ int __init ip6_route_init(void)
 #if IS_BUILTIN(CONFIG_IPV6)
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
 	ret = bpf_iter_register();
-	if (ret)
+	if (ret) {
+		unregister_netdevice_notifier(&ip6_route_dev_notifier);
 		goto out_register_late_subsys;
+	}
 #endif
 #endif
 
-- 
2.43.0


