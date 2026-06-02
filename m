Return-Path: <netdev+bounces-294285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 26WPCd8BH2qWcwAAu9opvQ
	(envelope-from <netdev+bounces-294285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:16:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A290630216
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:16:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ljnnSuPO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294285-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294285-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0961B3002288
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2083136672;
	Tue,  2 Jun 2026 16:15:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D661607A4
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 16:15:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416951; cv=none; b=Ry3WS5XXKrY4ruGogOdl02OLffZK17Rc4CKbXbmlVbWfunfiSybC22TumBGucX8rsfjjJpLuhWNKsIWY9O/cMb2JzbZ9BFCN5kYt+z/7+wd328p2yUv0PbIxX52GZ1X3FTXzs/M8JqJH5i9UlP2dKPZyu+MLaGBG4Xcc9Mv1bJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416951; c=relaxed/simple;
	bh=2WNNRDg5Td4dZV1G777UiAywtY99HUA9g/cLa3kYY1o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uy6LzeBP+iY6WLXrM5Nw6J3jlKPzuals3D+vfSEUhIz4Qf8jZbPdCFpsk0utOuwB0cnCCKDwrF7su1+VkbI9Oe2Aim4q1yjL+vSnyCGB3YknBi09aGcTsVQ7WJlLnBLQS1uHAFS+CR59aPt2wSweuWniz48ExcsxpvtLFKjQFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ljnnSuPO; arc=none smtp.client-ip=209.85.217.73
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-6cfb918a9d7so3693259137.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780416949; x=1781021749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MxrawKuRjeiYmLI/CyOt3uFMjVo+B1MjcqZQlFolkBk=;
        b=ljnnSuPOxbtWrrU7loeoL+p8kuoO0UFxLmQ6OIv4tehBYZRRTrHkZ+HS/RXoGceQZD
         mg/WIM4igLLu+QMra77xk872Gmq70DUH812wMRkgHicuXR631ByX1TPoPO3Ui7HkV6UF
         2VqkwyaVrSh5frfN6EUzxsAU8qw1IgpK1kUEZFyZEJEke1KNycGOdYt/RvqIDQ6fxteK
         JXm+/gQSuGLPUzAQtQNAOxGxycqPWe0AzaYrdM57w9PjiqUibXTkDjL4lTZHvb3iRkln
         iQdSEnfcdMa9NpCB3Wf+c0Ta+SbhhXhppz4QFg9DptsTGKIe33kMot8kxJeaoejVY+JM
         dWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780416949; x=1781021749;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxrawKuRjeiYmLI/CyOt3uFMjVo+B1MjcqZQlFolkBk=;
        b=OgbVsigwxHAn3hIzc+vYk08UvP9JSGXUFZNMufozeocXQ/6IHOWsHVQzVq6XFSMcaq
         jyTw8mDeBgrfv3CWvw7Q8y9yPgUD4xLp+L4DkdL/HrHBJAVVrUgrdue/nfBjuFTckPYE
         6GzryoxpmVpO6ZE5iu778bKNxoDf5GfGg6ImpY3ENgreegVas9AeE3vLU5EQXzn3F1Be
         8I/CbxE4u/UAYrC/z1daoJNwRAiDbLOvda6D1b2eX3K9azB3emTDGpkcUkxOND2FZ93a
         PqCr207EgQgFWw5dI/0DhnlB/yeLCUXQKCrocX2c/zrkE6d+17gjO2Er+SS6wy/e7IXB
         Bmvg==
X-Forwarded-Encrypted: i=1; AFNElJ9t0a58C6zQkK8DjwIxscTWDBH2g7MyhB5VecZJ0QZ9JDzqcFxqYZTg6WGQ9sQs7FruBsCBrHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHxrLtMP7owON+4hkvDu8QK2enES0Ysd8tHfX+wipNGpQAUmFI
	W49MHfGmQjdQq1XP8971GNAxlhB6CJL6xU7Ca5klXLBUjKJKpTpTpHatmbb3W9lchofWMxHt/WF
	Wnw6hASuwwLC4Zg==
X-Received: from qvbdl10.prod.google.com ([2002:ad4:4e0a:0:b0:8cc:fcc:6e7c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:509e:b0:606:49d:1861 with SMTP id ada2fe7eead31-6ea2e790569mr542394137.27.1780416947986;
 Tue, 02 Jun 2026 09:15:47 -0700 (PDT)
Date: Tue,  2 Jun 2026 16:15:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602161547.2642155-1-edumazet@google.com>
Subject: [PATCH v2 net] ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Tamir Shahar <tamirthesis@gmail.com>, 
	Amit Klein <aksecurity@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294285-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:tamirthesis@gmail.com,m:aksecurity@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A290630216

This patch restricts setting Loose Source and Record Route (LSRR)
and Strict Source and Record Route (SSRR) IP options to users
with CAP_NET_RAW capability.

This prevents unprivileged applications from forcing packets to route
through attacker-controlled nodes to leak TCP ISN and possibly other
protocol information.

While LSRR and SSRR are commonly filtered in many network environments,
they may still be supported and forwarded along some network paths.

RFC 7126 (Recommendations on Filtering of IPv4 Packets Containing
IPv4 Options) recommend to drop these options in 4.3 and 4.4.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tamir Shahar <tamirthesis@gmail.com>
Reported-by: Amit Klein <aksecurity@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: use Ido's suggestion.
v1: https://lore.kernel.org/netdev/20260601124157.699463-1-edumazet@google.com/

 net/ipv4/ip_options.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index be8815ce3ac242372eeae4a97091cda26d40ceb0..09d745112c1526a1f151cd917f97dc1e236d6d22 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -530,6 +530,10 @@ int ip_options_get(struct net *net, struct ip_options_rcu **optp,
 		kfree(opt);
 		return -EINVAL;
 	}
+	if (opt->opt.srr && !ns_capable(net->user_ns, CAP_NET_RAW)) {
+		kfree(opt);
+		return -EPERM;
+	}
 	kfree(*optp);
 	*optp = opt;
 	return 0;
-- 
2.54.0.929.g9b7fa37559-goog


