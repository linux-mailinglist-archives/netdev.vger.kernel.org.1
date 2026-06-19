Return-Path: <netdev+bounces-300687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vbddBwYqNWo1nwYAu9opvQ
	(envelope-from <netdev+bounces-300687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:37:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A356D6A573D
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:37:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XdF8De6o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300687-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300687-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECD113008D58
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA033803DA;
	Fri, 19 Jun 2026 11:37:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78BD3793A9
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 11:37:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781869059; cv=none; b=k6qe/P13jwDZ8ilhjHH1yb5Fn5jw3rX1RdTGmqWvDBGF9oKvQTinjptXMCd5ibsQGC7E5ZPMVbVbyuBGZee+U5mjBTeoAt/bjIJZbkXudNjVSAJwFCTauzSVoudb46REIqRLMzBxhWV/PTzL9oAfDISdBmEwiW4tHm2LciErFME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781869059; c=relaxed/simple;
	bh=mvonQbQVWa6ZXoLml3aLDQSYxa94cwHBReY5bw7V5Eo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R5wYbDTED2g9psEhfFp5kY0R6AGxJ9jECe4ett7ov+cxcareDEB1WXtjXBWVfr0JWpNB23B3KJXLxAcktUXKgUTMJy+GJTNCcwRhx/txN8QNLskRnpOUS4SZlOYTpyHlHWCfYQYoOp6TwR2qLBZe9BVgobBoKsNydauB2OXGa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdF8De6o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412291F000E9;
	Fri, 19 Jun 2026 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781869058;
	bh=mG0vyVDluQRxAy4jusCEO+px4MVfNltVsG+sO1nmh/4=;
	h=From:Subject:Date:To:Cc;
	b=XdF8De6o26MHRFAXcvYne+qrgyDnGUcBJN4ThPYhMrGAyZ1gP2Z7LH2yGkDKsl53B
	 oJ5SVC7UToQRWLQ/Gwh6RRRQjnkQFtvFs6RqNtpeQEer89JpzVTU2Xn/r53NIupYB3
	 i/I8RwIO0FQLWHmyGTX/KyU3MZsqcZ+gKSJ2qjujbiEG9r/2AWegY9Cv9qaBQOt8vX
	 SPogv2jkRQsHKzgk74FjuTjHpgjWWBCwhbav1dzFFNjiK/KOOlMPWPshODYIShMarT
	 j21mjgal4TsZruwiEZAJW865vnnGt4Ztg0/exeD3uBm47YtnPzh+bGk8KWU2sAfHa0
	 nCxGDjsEt5maw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net v2 0/2] airoha: fixes for sched HTB offload support
Date: Fri, 19 Jun 2026 13:37:12 +0200
Message-Id: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ7CIBBEf6XZs2sAhVZP/ofpodVt2WhAl4ZoG
 v5d0rvHmZc3s0IiYUpwblYQypw4hhrMroGbH8JMyPeawSjjlNMdDizRD/iOCSf+UMLRHZ0aVWd
 dp6BqL6ENVOsKgRboa+k5LVG+203WG/q/mDUqPLT6ZJw12rbT5UES6LmPMkNfSvkBWx8rMrYAA
 AA=
X-Change-ID: 20260618-airoha-qos-fixes-b6460b085680
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Wayen Yan <win847@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300687-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:horms@kernel.org,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A356D6A573D


---
Changes in v2:
- cosmetics
- Link to v1: https://lore.kernel.org/r/20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org

---
Lorenzo Bianconi (2):
      net: airoha: Fix off-by-one in airoha_tc_remove_htb_queue()
      net: airoha: fix netif_set_real_num_tx_queues for sparse QoS channels

 drivers/net/ethernet/airoha/airoha_eth.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)
---
base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
change-id: 20260618-airoha-qos-fixes-b6460b085680

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


