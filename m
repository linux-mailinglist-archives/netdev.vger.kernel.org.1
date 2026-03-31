Return-Path: <netdev+bounces-273456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANtTNRhGy2nSFAYAu9opvQ
	(envelope-from <netdev+bounces-273456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:57:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB2D363C78
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8E393004D2C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC32C11E4;
	Tue, 31 Mar 2026 03:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0nzmYaG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663331EF39E
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 03:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774929411; cv=none; b=N2ikg5LBxLwN7FnU34Guu9MDvoFv/kL4ZKpuBayG4fFyPEJYeIlYgcmIhKvVYHqCwhwZG//brc5sF/FGgdcFi5b+KgFN34SC15vbef9PRPkYBNPbsAdPWxqtvuEpFvAP1bwyNjist6kSXj2KGy0h7R6ZiYBqPisvZWDcRZoogRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774929411; c=relaxed/simple;
	bh=rLmB5xzWmQJE/Rx+ds2UDJgnJEPcYsqGc3Ak9yHZMmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kyfbddt4wLzVTMmq5DgzJO67i/ypt1Fw6XdKu2KXVXoKiOWxZKc2XswK6lsOYA0uMia6ShPdDQE0Q6/6vmwpPnqlAKyhY/h1898k7Bju5+McQqXKnwPWTJ3vU9vaOmGCX1s/zBl/POviqp1eWDeASJHcjpNtIKnpcz4AuVhyBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0nzmYaG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso1564542a91.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 20:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774929410; x=1775534210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01Ybf4qh+itt8ApsU1FLDGmh4NkFdR+YVHkIU4cnXuI=;
        b=k0nzmYaGXM4j15oDlmyoFsSxRbXURm9IpHyi6Nej6TuoVm+MPunv/sRAW/PJrDoFi7
         e5IzXLfeY81R/djK6LY3gF2SNdyjxEn6geklO4MgHR0UHt6WIBi9A/6PIGhB/ijws7aD
         JHIkL9sVd3ovpg+6MT0UoYo1dpdYvFW0Uxa6YkFsEpbhlBiguWSeu30Z502unJAZv0Pl
         krSGR9PYPqZ6zpD98wFiAOGvCgWDJmpNuJxgsbYz+OFBbbhJdbbVDHwgX1nusizGS0eH
         VqzOjURY4GMMsEVUagRSsNbCticp0Wy4bKJ1GiuEnanI06j4eH7QkD9hV35Rqq2mRMXt
         y+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774929410; x=1775534210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=01Ybf4qh+itt8ApsU1FLDGmh4NkFdR+YVHkIU4cnXuI=;
        b=EK0/bh1VQCYcYkrv1GMlALcKpICriwnCp+q8qwX+KQ5SzhRP4xrzTXHIgPtEi4vTcY
         gEFGsuPDr5slgf+z5LoAcKUzuJk5CZtdEPQVZl8CaYK5yuLoywM87dI3cOREa3Zi81uq
         ASl8TTXVpNtQcqYxYlEyoytyof4zpwwZzGZisDAvRsaLT/NZOsrzaUB1VL2uXKntjifu
         5HDHvJOhQ2Mjkx83t2G1n4C/Poksz4TNVCWMb2M9nDSWYzcIJCScPFCQPJdv5GrGVHOY
         NeKRK3c5FLkZDyDIiaI0rweuWRuPYVjDvYr4TQHkDKpUU4ilHkqM/tAbrqF9Q2m7BrKL
         cLow==
X-Gm-Message-State: AOJu0YztXvScPKc/1rsBU5o09ELXgfV6TW7CL38OMjJABeodnK7crK34
	ciG0jwCT4KswDI1fsQ6XyVG7VkQvBP85fs5GrezL81gVISBm/ufxKMMF
X-Gm-Gg: ATEYQzw7WopKSe69vB0MNnffadT2xHoyc1CLcCivvma+MKpVM0HlArbA+fwu4ReSDHZ
	RiLLlxPkVrnd7Kf3yLJIwF7/83tR5qOgcEGECI4p2KPQg1vnkQxU0VnM0croNloSTWiMwqwSNIe
	P3sjBHJMLstO13VIhOBCgf5yvPZKYw2rX5JaizXFtbH6fH/WGKg+y+BliRkxpAstf9gm4db/ofy
	YJUYPq5vglKa4niJuTG6secwyD/kCRYXDUWX/e1sHV1LuirDGfOSHxCRoIF6b0tg8MPk+Awy7ZB
	rnTkTkGpRBgKBil8hoIPfYZzeZvW05dqwJXlVEDbS9Jx37Rmh30701D7ioke7RpjvUqOMVSWATc
	tXedCNBKfTxEkffAEsoUyLsLoQsyfeS7pbkMMbWaeuEurLtWCJQnLvPy1yu11Yq3U4UqovkF4cU
	QLWjXYK/ptMAHByraYPsvmbmLxo8YPC4cANHDTIvRFGXwjiECmYoAQO70ISsozRG5lgbZTbjGeG
	cNKXOuEi513a8BKPNX1/HX0xR8oWnNj2FSi0d3Xf2ZJL8iv1OQ=
X-Received: by 2002:a17:902:ecd0:b0:2b0:606b:6fd3 with SMTP id d9443c01a7336-2b0cdc1026fmr162439575ad.5.1774929409660;
        Mon, 30 Mar 2026 20:56:49 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:500:c92f:4f4e:9953:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266e487sm94680625ad.24.2026.03.30.20.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:56:49 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 31 Mar 2026 11:56:12 +0800
Subject: [PATCH net-next 2/4] tools: ynl: ethtool: add --dbg-small-recv
 option
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-b4-ynl_ethtool-v1-2-dda2a9b55df8@gmail.com>
References: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
In-Reply-To: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-273456-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.899];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFB2D363C78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a --dbg-small-recv debug option to control the recv() buffer size
used by YNL, matching the same option already present in cli.py. This
is useful if user need to get large netlink message.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/pyynl/ethtool.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/pyynl/ethtool.py
index 8bf234d594b3..6c50368de967 100755
--- a/tools/net/ynl/pyynl/ethtool.py
+++ b/tools/net/ynl/pyynl/ethtool.py
@@ -166,12 +166,19 @@ def main():
     parser.add_argument('device', metavar='device', type=str)
     parser.add_argument('args', metavar='args', type=str, nargs='*')
 
+    dbg_group = parser.add_argument_group('Debug options')
+    dbg_group.add_argument('--dbg-small-recv', default=0, const=4000,
+                           action='store', nargs='?', type=int, metavar='INT',
+                           help="Length of buffers used for recv()")
+
     args = parser.parse_args()
 
     spec = os.path.join(spec_dir(), 'ethtool.yaml')
     schema = os.path.join(schema_dir(), 'genetlink-legacy.yaml')
 
-    ynl = YnlFamily(spec, schema)
+    ynl = YnlFamily(spec, schema, recv_size=args.dbg_small_recv)
+    if args.dbg_small_recv:
+        ynl.set_recv_dbg(True)
 
     if args.set_priv_flags:
         # TODO: parse the bitmask

-- 
Git-155)


