Return-Path: <netdev+bounces-206126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E543CB01AD3
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DEFB5A79F3
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8451D2DAFAB;
	Fri, 11 Jul 2025 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/duXg36"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECBD2D77E7
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234015; cv=none; b=RT0S+jgykeFaZOsO35K29QNSdhpRTiQBwJjemLrtLXlfD+83bXuxELENxk3CaitUq55/Btw2tD8a0eqZboXZ2ZMkgS/LGF4aPfPXJpVXh1r0v2r6aZuxT/uV3/+4Pd8/JSESzWsMzQhJ6mNVuOxfGImxcUtxp9/w/mKOCDTUxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234015; c=relaxed/simple;
	bh=UDs4dcOigaQkelpzItetKI6c5n0kooa1iIE2EjDzWd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TAUcyAJ9L/B1tcQxWsn/aFRYPYdHm8BiF/LON6vlhmZsuIkiMeXy3gEHi7cCpEBkrvtU1YcUh1PNJPeBnTbG4lGZu/Sf/i37iuC63dKr/Y4RWAyJJ5nD3XeZXB8XkPPj2Ql5HwvfwtCeed0ayg+CGZzPb/gPkE/tAPuGBUEiZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/duXg36; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a58813b591so37905181cf.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752234013; x=1752838813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpV6p+NtDiFKm7nYsKECFIYR7OAUx1H4SLeeYwv7jrU=;
        b=i/duXg36sd/KnLXq+JydiFZOdq+dUMrmVEreAamSPkQQXoR4OXueNKZueU8EArLsnU
         hMQYW4QpHf+/isNuqf/iKD5k+8xXTSy/l/3T05EfzWMwYw+F1bWAiJ3fTtRmEiDFMl2m
         dlnBQOzSOUYE46BRSiJRHH6sGHYV0eMVbaVDtmj+SSgVqU0Si9gwZfmaQH0iF179bYUD
         2OaseuW/KJW1hviLwrm8rp9O4rwdUY8Bg2dhu0nZUO1YmVF3f9rkTPMSkUzSINXGMhSL
         eCwLmWU2Tx469u/QtUMZEI+ajiir+SLtsxN9GokvAi5j7G8tF6U19QAEOHivtusN5iGq
         laUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234013; x=1752838813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpV6p+NtDiFKm7nYsKECFIYR7OAUx1H4SLeeYwv7jrU=;
        b=LqE/deolNupQLsVR5271/OG5nlMiQWKk+EZUx4AkIhA6ll5asm+JqekdjGEj5tV/BC
         P9ZIY4KI/ptO53Cb6kNsfWQehJ7P7Q7tYeH4jOdN2EVPFUGEFRZWvzNIUp0J8FHxDUjD
         GGgl/GyqqKQj3CjJD9b7Cyy6Jw+thkWoCjrcQMXGYuOqwec9GVO94emmpzdqeJvWij84
         PsBHwpDua3utFfT5cuxi9omDRwHcWcf4gMH2zdfk1ED1WYRbESMk19E+ptVponZVMJWB
         J7uZdBeBEmL3B8OfdMjKja6Fe2awmcUt5ytp0XFf8YklH9HV9kN9KkBbHRCplIfAOhrR
         Mo7w==
X-Forwarded-Encrypted: i=1; AJvYcCVwzNlF4TVmHBOnxBQhfxchRUHfQu2wjr4MUFcpqhc6W5T33o9DVMwCzgMdw8tQXvepxw5Ohg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJiO75ILkzFv2jIvyIZ7AhhUb7equ05rUkZrFRoYCO4KvdBdyz
	3zAo041VBIjkO0xUpx/M+Kcu1n7U7T1ADSfEmboTv5lJlcr+BSWRsLPS+n0XwMqnoNhTXgctPig
	aIvGo5stXjcf5pQ==
X-Google-Smtp-Source: AGHT+IG+CsyOPdJeuMgDpU+zW+c4HoRL3qTmoPcL6cZ4JC+ycXABdNVFg5evedLCMxGHZ/tCXbWv+vayw1w6wQ==
X-Received: from qtbcr10.prod.google.com ([2002:a05:622a:428a:b0:4aa:f44e:3753])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1147:b0:4a9:8232:cb35 with SMTP id d75a77b69052e-4a9e9ca479emr128925381cf.15.1752234012651;
 Fri, 11 Jul 2025 04:40:12 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:40:00 +0000
In-Reply-To: <20250711114006.480026-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711114006.480026-3-edumazet@google.com>
Subject: [PATCH net-next 2/8] tcp: add LINUX_MIB_BEYOND_WINDOW
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new SNMP MIB : LINUX_MIB_BEYOND_WINDOW

Incremented when an incoming packet is received beyond the
receiver window.

nstat -az | grep TcpExtBeyondWindow

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/net_cachelines/snmp.rst | 1 +
 include/net/dropreason-core.h                    | 2 ++
 include/uapi/linux/snmp.h                        | 1 +
 net/ipv4/proc.c                                  | 1 +
 net/ipv4/tcp_input.c                             | 1 +
 5 files changed, 6 insertions(+)

diff --git a/Documentation/networking/net_cachelines/snmp.rst b/Documentation/networking/net_cachelines/snmp.rst
index bd44b3eebbef75352599883b9dde36e7889d4120..bce4eb35ec48112ec43d99c58351d3b646a708ec 100644
--- a/Documentation/networking/net_cachelines/snmp.rst
+++ b/Documentation/networking/net_cachelines/snmp.rst
@@ -36,6 +36,7 @@ unsigned_long  LINUX_MIB_TIMEWAITRECYCLED
 unsigned_long  LINUX_MIB_TIMEWAITKILLED
 unsigned_long  LINUX_MIB_PAWSACTIVEREJECTED
 unsigned_long  LINUX_MIB_PAWSESTABREJECTED
+unsigned_long  LINUX_MIB_BEYOND_WINDOW
 unsigned_long  LINUX_MIB_TSECR_REJECTED
 unsigned_long  LINUX_MIB_PAWS_OLD_ACK
 unsigned_long  LINUX_MIB_PAWS_TW_REJECTED
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index d88ff9a75d15fe60a961332a7eb4be94c5c7c3ec..6176e060541f330792014dd6081d1d0857536640 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -305,9 +305,11 @@ enum skb_drop_reason {
 	/** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate packet) */
 	SKB_DROP_REASON_TCP_OLD_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field.
+	 * Corresponds to LINUX_MIB_BEYOND_WINDOW.
 	 */
 	SKB_DROP_REASON_TCP_INVALID_SEQUENCE,
 	/** @SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE: Not acceptable END_SEQ field.
+	 * Corresponds to LINUX_MIB_BEYOND_WINDOW.
 	 */
 	SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE,
 	/**
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 1d234d7e1892778c5ff04c240f8360608f391401..49f5640092a0df7ca2bfb01e87a627d9b1bc4233 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -186,6 +186,7 @@ enum
 	LINUX_MIB_TIMEWAITKILLED,		/* TimeWaitKilled */
 	LINUX_MIB_PAWSACTIVEREJECTED,		/* PAWSActiveRejected */
 	LINUX_MIB_PAWSESTABREJECTED,		/* PAWSEstabRejected */
+	LINUX_MIB_BEYOND_WINDOW,		/* BeyondWindow */
 	LINUX_MIB_TSECRREJECTED,		/* TSEcrRejected */
 	LINUX_MIB_PAWS_OLD_ACK,			/* PAWSOldAck */
 	LINUX_MIB_PAWS_TW_REJECTED,		/* PAWSTimewait */
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index ea2f01584379a59a0a01226ae0f45d3614733fef..65b0d0ab0084029db43135a91da6eeb1f1fba024 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -189,6 +189,7 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TWKilled", LINUX_MIB_TIMEWAITKILLED),
 	SNMP_MIB_ITEM("PAWSActive", LINUX_MIB_PAWSACTIVEREJECTED),
 	SNMP_MIB_ITEM("PAWSEstab", LINUX_MIB_PAWSESTABREJECTED),
+	SNMP_MIB_ITEM("BeyondWindow", LINUX_MIB_BEYOND_WINDOW),
 	SNMP_MIB_ITEM("TSEcrRejected", LINUX_MIB_TSECRREJECTED),
 	SNMP_MIB_ITEM("PAWSOldAck", LINUX_MIB_PAWS_OLD_ACK),
 	SNMP_MIB_ITEM("PAWSTimewait", LINUX_MIB_PAWS_TW_REJECTED),
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f0f9c78654b449cb2a122e8c53fdcc96e5317de7..5e2d82c273e2fc914706651a660464db4aba8504 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5900,6 +5900,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 		if (!th->rst) {
 			if (th->syn)
 				goto syn_challenge;
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_BEYOND_WINDOW);
 			if (!tcp_oow_rate_limited(sock_net(sk), skb,
 						  LINUX_MIB_TCPACKSKIPPEDSEQ,
 						  &tp->last_oow_ack_time))
-- 
2.50.0.727.gbf7dc18ff4-goog


