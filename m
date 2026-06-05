Return-Path: <netdev+bounces-295855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mWkBK4nqImrHfAEAu9opvQ
	(envelope-from <netdev+bounces-295855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:26:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB12D64946E
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:26:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=YqNH+Nsa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295855-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295855-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B9B6303D47B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5641325F;
	Fri,  5 Jun 2026 15:13:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38B3FFFB5
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 15:13:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672415; cv=none; b=NF0hsgtbMAmPQpsgLFN4ujFAhYLPGREJwB4c9Vdjl5nm3iotiRWLJ4mFUbBRhGvdwH9bkHsouslCU77CPObIsFBRZFXeDdn72by/U9Lh18qjNiDccQ/StHEUP42bZTFPb8f312wxvPhtu7UFFxTs3O8BfJ1BSItfPGiKvD1leKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672415; c=relaxed/simple;
	bh=6zI0+5Unw3aM4B++TrI955Pmj/b67v+3oLnd/DwQ2ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Okh3eRt7Ph3eOwHTwNHc3ECFD/1jopAwcGK1oym0DWPnLWnwn4btAxlvazpIUB9lY3IXyoBdvu2kNqXpECxsgA2+xn4eIGXHwmY8NneTjs06cKVkic2incka6rmBdn2FT7zlaUE773Ze3eHxgzsuC7NHqpjdwTvN4A178AzepTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=YqNH+Nsa; arc=none smtp.client-ip=209.85.222.178
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-915ab38ac14so141477885a.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780672411; x=1781277211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MUzsgU5C8dNE/wG8dusnMomxOEkXYrmT6T12TQh+ff8=;
        b=YqNH+Nsa1vnKN8bLjtg0xCAYK+HpXtDv5bRgr9RP1mO7b9ouveknjMqGLwXbl3l1Xb
         xFLnZFeDk571fPAtIwQfAuRdhaa7tByIdmcK49IK3t2oP0pjwsJIQlAeRrxIH8fkUDa1
         sZodiyPYWkhwLoVf+TR+wNEB77wNk4Ho/WJMBQl25t5hZbtDLqZ4vj0Hz9/kq5GyK+lm
         LRmq3TaBKWH52kk66pyo+/7ftkx2Tm6MjgmQCrmTjsb6bVRPQMrea7UGk3Oq7keO7waz
         v+Y2hvCVRmv7OzrJBj+xAKRT51X71mPFoPB0XRDGlupuhIakcQf5Pe4E1Lp3kpHILf4z
         olaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672411; x=1781277211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUzsgU5C8dNE/wG8dusnMomxOEkXYrmT6T12TQh+ff8=;
        b=i1QLKDEJQYmA+5/uo68i/JM9SJ/GYucoeErvCJRg6+AiP7dPeqsVWXCypffuEFl0By
         uVtcS09XUHTwiogopifPLfVfKIq9Nk5EBwAfxPsxGAUy6uROXcWUH4eQ8tmyWGZIlsDZ
         J4tQ02qruvQ16P9XXY3nDHBlsLfNybLl4Qsb7Y4xWcziAXsrKXvGRDSxiRIplc/0MUNq
         i6dOuFtbGg1exbIcDhDRY8/XpWMz9D9QhX49v+3h86xgkAUlCaOsVHW48unS53Y+fR2j
         2Xb1E8dcfz1060K0qDFB9IF584LfQ94sx8gT2OYfDGY3ehfis82niUJH2AuUDSAGF+8n
         +fYA==
X-Forwarded-Encrypted: i=1; AFNElJ83K8/20iItLscPb6SYBNcsM1cpv+N9H5S7ZO1LMPvENVepiX/4KdR26iCkcLSqUz8QLzogwUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz06VLewli0meaKp8OeT58LVt6MBlQVMk8XEL9qwy9icysGrZpc
	p9YvfPHuJAn5xEKbnYgbmHC0AtUkRy8fm9qJCMajx4V7lPlrjWvfbuzrlrdDrg4Up2U=
X-Gm-Gg: Acq92OGmDrrjcTgCn30cSsqG4KjxKRbZ6GBi+Eb2onxLI9vPY5JWDujnXCh9aFSRf3m
	r6ESn9xdjvBpBtm2P2SrxYM/TiE3aGNS+hRRKQ7IHfO3HzLew8qNIP5qOzbJJFTDEHlvko4pfUs
	p09Ecow4f36Wh58cLeJMgKe5vGNyC3sUzrMk5OhJAHUZQIfqR0+sg9GgJBOfe9l742Cr7AdDz9d
	g71XNujkbkZbzq+J53f5uGk+TYkecGSyq42T8hgHav5rhtDxpEsFmrgmKBkNwM5Uaf4yXaHpRrN
	9EMhy2zYAhosRvP4XfwnFsJZEB+k+MPaGJJskXjcBNEltCvscvwU9qLUqgKXWfKNFrbL4aDQCI+
	VM6ahdh2NBo7hvGir7F7eLfSFjRRA6+hJYUfMP2QXmkQYoEQG/G70ZG4h7h406sve2NfJ0aAtN5
	LGHh0+xnIaARuw9HbpebaZ08q4nWNazYIvprH6Yg==
X-Received: by 2002:a05:620a:6cc7:b0:915:5cbd:1e56 with SMTP id af79cd13be357-915a9dbe488mr763995785a.41.1780672411537;
        Fri, 05 Jun 2026 08:13:31 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a2465e7sm934901085a.19.2026.06.05.08.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 08:13:30 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: pfcp: allocate per-cpu tstats for PFCP netdevs
Date: Fri,  5 Jun 2026 15:13:15 +0000
Message-ID: <20260605151315.2124527-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295855-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:sam.moelius@trailofbits.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,trailofbits.com:mid,trailofbits.com:dkim,trailofbits.com:from_mime,trailofbits.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB12D64946E

PFCP uses dev_get_tstats64() as its ndo_get_stats64 callback, but
pfcp_link_setup() does not request NETDEV_PCPU_STAT_TSTATS.  The net
core therefore leaves dev->tstats NULL for PFCP devices.

Creating a PFCP rtnetlink device can immediately ask the new netdev for
stats while building the RTM_NEWLINK notification.  That reaches
dev_get_tstats64() and dereferences the NULL dev->tstats pointer.

Set pcpu_stat_type to NETDEV_PCPU_STAT_TSTATS during PFCP link setup so
the net core allocates the storage expected by dev_get_tstats64().

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 drivers/net/pfcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index 28e6bc4a1f14..a6aa30ae0af7 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -148,6 +148,7 @@ static void pfcp_link_setup(struct net_device *dev)
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->priv_flags |= IFF_NO_QUEUE;
 
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	netif_keep_dst(dev);
 }
 
-- 
2.43.0


