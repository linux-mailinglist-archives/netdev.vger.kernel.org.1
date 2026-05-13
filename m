Return-Path: <netdev+bounces-287700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHGxDvC+BGoeNgIAu9opvQ
	(envelope-from <netdev+bounces-287700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:12:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC47C538A98
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 284C83071364
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DE84D90AC;
	Wed, 13 May 2026 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHmQvW9P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034603A6EF6
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695766; cv=none; b=JXptwcHHfhZKLJcRMZ/q9Ku0Jz0fUae6tCGGUH0Q8BUsPN7ZoEEdIpy3ZnXUJvsHG4JRNO9odC6ZsbMtp/CbMSSPjznGwdSJfrg9SbDkazfsQBzjt5qGktKioYCNG/ARu7WvC5acwxrxJIR1iVjZJbv+HlGIfiezqN3yGaUKa5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695766; c=relaxed/simple;
	bh=a473AoW/EYrJtLZg75oKWL9iS0yO8FVEqZPKLR/uLTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1FoWZQ/ehwEZmqqEL8aKz/ZjKXvZMTzZJ1iRfNMa+kM8Pb+k5ptxQOQgCFbRUUYJUhAITFBw1SgjuFB5KuHubRJ+RYDKI44Gym/9EAgnf+L2eFW4J278QFe7ViwUzb4V3ZwTZAdwXVICon2Iw6DAIejCl5CCFtOxtxzq4dg2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHmQvW9P; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8dbbc6c16b2so916523285a.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778695763; x=1779300563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7rgq4Cpe/q3En5LdQk+EFyKvDIOSkydeGDE5rAIQC0=;
        b=WHmQvW9PBRW/ehyqVGwGSvd4W8rwiwTrrOgOOJbkMO63zyDL5B6Z0IICsEcQakMJ2x
         hMumljh4bCjZ8DoyUAeK46aEQ2gJfK6J8oD0REfSAxWo+BVlPMq+5dG2WI0e8ReW5OLZ
         NLjQ2ZR9Zv4jKvN++NumQN8gEADWT4I6/fwdn4Z6hkrhZPfcn37OqowFr+BaUvrrSWKg
         luWTvNKRZZqH1JCeZ/h3OtoELFtJwa2wnwWpD1Tr/KKi2DwF2Q5a0xF/toRg/hqmiZD4
         wsAKs7vmH95cOQ/BYZIJyg2w9oRYPVU2dVQJ732wwOn+bN26d9rRCTCg7GgQpcIOk2QI
         t8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778695763; x=1779300563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7rgq4Cpe/q3En5LdQk+EFyKvDIOSkydeGDE5rAIQC0=;
        b=NUvOz6RYs2SqGtX7RR+FdlCnOFPdt9sOU8ZDRLdexFgWt+JOCB1nuSYZQCdXjHEJig
         Fc7Cg4p5+YZgUXzSC2pgiDV7F4hocd1aZOK/55b0PNXXWJR1gRV+3T2k+CVel72qZiw2
         UdhgUJMCvX2oGrq8SD1QqWDFgJ7oyxNcCPt5r+44Prkr+i2UbxWtLqG3JPVrYOowfEo8
         nFb7a/zX3gUcNddTcgV/Hk9xz2JyIccms+ZZYiP09knqKPvxHvUD/iBHgEZGrYPl2Hxe
         YA8VcHNEutdoNBQaJDd5JHzjXc5DxhH9UjPEsX/UaSZClplHRxVxIo0hRbEyXAF8S/yt
         zBsw==
X-Forwarded-Encrypted: i=1; AFNElJ+5+mpiIdZTf/jIIs343e8VGzOo0PSHUwyV6G6nplyHLJShE6wMDthMGTd7WKEe9XZtlXBvNyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPmxEUu+kwJw0q04w9n2NkrguuKVmnE/hmrKGr+MoD/Dnu9rrK
	pD0N9w80Hi+1eYZYHCl0tJ5NbmO0hfEkTn5ErfnYoKZc+hGmAqIZpn2X
X-Gm-Gg: Acq92OHZ2R9sbRvlEJ2qqEyv3YIESWwhsdJ4JkvvMQHY4ylgE84DbXLD5oYiGQtGz8n
	vDASuxjtjkHAPajBEdy9uQJN0EFNMfo6T062/AHYkwq629qXTPXWAmuXZ5eAQrxWvsGCnrvB7dt
	cnArfQdZ6p/B3O0VOV+wj1V1J6Txv/9k0I1CiT80//oKAgrO7j5Axj5eBQ2me0O4hP6FkcGe9L/
	Y1pGc3Ztq7giNPiijNAtRdFqA8d/pbWV068DnH46MFoq5de+dgMfwmkga5A/z9Z8ufia/DOhNvb
	l84kgE/kD5I0Y+J9TBzJLqTzv/xH5ma+Qh7AjnBO1SCSgcHwM9/eRz8x8PTJoeXeE3YIJ9ztwTQ
	HrrCsOl33hqEwAZTEm8XnWJ6mi+zZ/bj2cC+eYGbhV2jAasoqv5gxYTSnCk63HoojOeX0lncBXe
	SU7TVTJ0XvtWLcqCWMAo+LL7v6H23lbY3yHapiMaD2uxQMRtvZZTRcgsp7JGTWjb5ePwCoQxolJ
	w5D6Xy86fZURrVun5xdd4I3+uaUbSduAlheW7Gh9oA=
X-Received: by 2002:a05:620a:1995:b0:8cf:d5ca:adf8 with SMTP id af79cd13be357-910b0f08f19mr82490985a.29.1778695762828;
        Wed, 13 May 2026 11:09:22 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba182540sm27011485a.4.2026.05.13.11.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:09:22 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] rxrpc: Fix read+write past skb_headlen in soft-ACK parser
Date: Wed, 13 May 2026 14:09:07 -0400
Message-ID: <20260513180907.2061972-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC47C538A98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287700-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

rxrpc_input_soft_acks() builds a raw `u8 *acks = skb->data + ...`
pointer and walks it for `sp->ack.nr_acks` iterations, performing a
read-modify-write (shiftr_adv_rotr) on each byte.

The caller rxrpc_input_ack() only validates that the bytes exist
somewhere in the skb (`offset > skb->len - nr_acks`) and best-effort
linearises the head with skb_condense().  skb_condense() returns
without pulling when the skb is cloned, when paged data exceeds the
linear-head tailroom, or when frags are unreadable.  On a nonlinear
skb that survives the condense step (cloned by AF_PACKET capture,
frag_list-style after IP-fragment reassembly, or paged-frag receive
on real NICs), skb->data covers only the linear head.  The parser
then walks past skb_headlen(skb) into skb tailroom, skb_shared_info,
or the next slab object, doing in-place 1-byte shifts on up to 255
attacker-controlled offsets per ACK packet.

Sibling parsers in the same file already use the safe pattern:
rxrpc_extract_header(), rxrpc_extract_abort(), rxrpc_input_split_jumbo(),
and the rxrpc_input_ack_trailer() call site all use skb_copy_bits()
with explicit length checks.  The soft-ACK call path is the lone
direct-deref site.

Add an explicit pskb_may_pull() check before invoking the parser so
that the linear head is guaranteed to cover the SACK bitmap.  On
allocation failure return rxrpc_proto_abort() with the same
eproto_ackr_short_sack disposition the existing length check uses.
skb_condense() is retained on the path; its truesize-accounting side
effect is independent of the linearisation guarantee that
pskb_may_pull() now provides.

The bug shape was reproduced under UML+KASAN in two complementary
harnesses:

(1) A kmod that lifts the parser's inner shift loop verbatim and
    exercises it against a kmalloc(47) buffer.  KASAN reports a
    slab-out-of-bounds read on the first byte past the allocation:

      BUG: KASAN: slab-out-of-bounds in run_rxrpc_soft_acks_loop+0x52/0x74
      Read of size 1 at addr 63a7032f by task insmod/37
       which belongs to the cache kmalloc-64 of size 64
       allocated 47-byte region [63a70300, 63a7032f)

(2) A second kmod uses the in-kernel rxrpc API to allocate a real
    rxrpc_call, builds a nonlinear hostile ACK skb (linear head=46,
    paged frag=79, skb->cloned=1, nr_acks=60) and drives the
    upstream rxrpc_input_call_packet() -> rxrpc_input_ack() ->
    rxrpc_input_soft_acks() chain directly.  Sixty 0xAA sentinel
    bytes placed in the linear-head tailroom are all right-shifted
    to 0x55 by the unmodified upstream rxrpc_input_soft_acks() on
    a stock kernel.  On the patched kernel, zero of sixty shift --
    pskb_may_pull aborts the call before the parser runs.

Note: the real-path demonstration does NOT produce a literal
KASAN slab-out-of-bounds splat, because the on-wire nAcks field
is a u8 (max 255) and the OOB shift stays within the same kmalloc
slab object that holds skb_shared_info.  Per-byte corruption of
skb_shared_info and the linear-head tailroom is the actual
production effect.

A regression check on a fully-linear ACK skb confirms pskb_may_pull
is a no-op on that path; the parser continues to read in-bounds.

Fixes: d57a3a151660 ("rxrpc: Save last ACK's SACK table rather than marking txbufs")
Cc: stable@vger.kernel.org
Reported via internal source-audit pipeline on 2026-04-21.
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/rxrpc/input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 24aceb183c2c..52ace0f98d06 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1173,6 +1173,8 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (nr_acks > 0) {
 		if (offset > (int)skb->len - nr_acks)
 			return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_short_sack);
+		if (!pskb_may_pull(skb, offset + nr_acks))
+			return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_short_sack);
 		rxrpc_input_soft_acks(call, &summary, skb);
 	}
 
-- 
2.53.0


