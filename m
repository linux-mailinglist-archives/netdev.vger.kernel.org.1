Return-Path: <netdev+bounces-299234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nD+tFBbPLmqF3QQAu9opvQ
	(envelope-from <netdev+bounces-299234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 17:56:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E229968172A
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 17:56:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=U6JVPoN2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299234-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299234-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B31E3009524
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B74B390995;
	Sun, 14 Jun 2026 15:56:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CAB27AC45
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 15:56:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781452562; cv=none; b=Kjvt5bD4lIp/2IoBNM2BljZwF1Ry5/ke9KLOBk/ZhGrImVaPSNq/9VmfBtJXTnyfKYoZ+M6py6AAZUY6r2/uBs8icDraNntwJvLWPPnDmht3VcCGsbC35GmSDJI9gdpwxmf/ze2dy0lLE0q9zsxsSFtOpSJKqx0EEzb/u9Lur8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781452562; c=relaxed/simple;
	bh=xPt9J/xZeKu0g1VM+iQEzePD4I+0i6xZVbJdqMn5Prw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ud2592wxfIwSTwtDcyg003VO4W0XvekX2159T+8p+bLtu/Tsnb0ucXeOCCUE/h+pBGEhhZ8aQsT+JrMEaYl85wiG5Thrtl6jfDb0wHU5wU91LvWJzsWT3ZiOc8upBZhCAffuXqFpGvgt704vEq3sm4wsDHtmGOzc0N9Hxq5YoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6JVPoN2; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9158fbaa4bbso297470885a.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781452560; x=1782057360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wik3DP7e0/pzSaBqqvFcxzhIhAeGdaetwfpdYL5NLR0=;
        b=U6JVPoN2W8yLk5NKEhzU1MORbUo3oGmEPEjryhtQYfXO1OGxSd6ZKWH3/1aJiPjERu
         /z/k46AWDIdDhSAATw1raHETP4dxJN7hUUWCAtxx/JJbfmcEDCPZtGQzVCJoR+X4gb6M
         mgYIYxYZMZjZNESnXwFrMTgTDyeB//jATc4BfSs6ZH3xWWqu0XvOEt+OffFqTCSHk8cP
         o7J11WgDFiz8sfCzY9mL8m1my5n0CWIJ5FGjjj2LBiF0MRIE79psXxE/xG6LVZN5M5Ee
         ZV9hriieXEQhx2ZdW1G5KUceQD5n787i6cxtC2xpK78mS1noLQkJtXJQKhVqq62mw3Ad
         7KpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781452560; x=1782057360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wik3DP7e0/pzSaBqqvFcxzhIhAeGdaetwfpdYL5NLR0=;
        b=ESotOgLnmfbKkHFB/pEIvwk1c0+bB4g4ohGHkiGMcykQWwJREOYgZeq+iT42m2L6Gd
         Yax96HwmG7aQhSgdObSIClhdylHDFSsaoUDVzwBF/f+evNgJTg8ZY9XvNuL7yAjQzR6D
         uq72wrqhCtPHCt1YDcp/lMJiB7Cn7VedMxvnBG8tlflNYHOmAqiaO1lLB8/qYwXSw+AA
         CkroQ9o39AJsBGZVvBdmG65JQp4dzRrkie+Z3jOepZFfPOdo9C186Ys4yiv/OzTDEvB1
         bjshpcYuQHU5kkfHjy+Y1+P//MMP794ePK4E3zFr+Mx3wYPEqrczpv0SlwFK4VG8EQNS
         CNCA==
X-Gm-Message-State: AOJu0Ywpnuc0qJ81koMVSOEgAMGk96pNTuWiGJ6O8U73cBh6lVnZI1V1
	7bWgR4RAhdOe5Tlc+7/cDMNinP+1IhHL9l2seZ2Uy0kW3Sff5VQfImme
X-Gm-Gg: Acq92OHiDidVjljv9dCMwmhJ1tcsTA84wrC14ZpxQ6W6BtlpNFtN2d6aiY9tuxn3afc
	8XcCHABzQdjy9tH63FjKwKmndk5ZymDiLVRBkHFq24EiyFsx9Gw1gKEy71/tq26uwnuBd1MhN75
	g7SlSY7/XPgNBou4nvYIxksIF3OP/Z97S48oSnjq0wZDSGGahSN1rUDcrX5A3etgoBw0MUhYVK+
	rUlKmFHIRjf0h23HihwdSy0FpNEsXxR8s8V98kM0wG/76cMUCuOlx/ub4/Sy8qHS89VRBdMA5ZQ
	u0XdHcpRmoOoL+Z33+OcnpJNN4UDClz5OmwzwkXhxKzHHXXAI07rb5JXa6R+LxogCRMNshG/fBY
	w5inLEI7MYJdv/eW37BelEq14cRPCVEUcjv1YLHdhZN1hNobi5rQW2u6BAaX62vnM0Do6FmFyO1
	z1QFa+VIoDaqNzFY3IRhw9LgDlsVJ/wmIxopTALEe6ObOYD4FOVk85mxEp46bBjUunelSzGWN3C
	SGcDew5dP9py/cisg6NnKTFdDdqME3nR3NAT1jxTwg=
X-Received: by 2002:a05:620a:29c4:b0:915:a762:2735 with SMTP id af79cd13be357-9161bcd8445mr1647151785a.37.1781452559644;
        Sun, 14 Jun 2026 08:55:59 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a006441sm818948085a.27.2026.06.14.08.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 08:55:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] amt: don't read the IP source address from a reallocated skb header
Date: Sun, 14 Jun 2026 11:55:39 -0400
Message-ID: <20260614155539.3106537-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299234-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ap420073@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E229968172A

amt_update_handler() caches iph = ip_hdr(skb) and then calls
pskb_may_pull(). pskb_may_pull() can reallocate the skb head: the new
head is allocated and the old one is freed. The cached iph is not
refreshed, so the following tunnel lookup reads iph->saddr from the
freed head. On an AMT relay this lookup runs for every incoming
membership update, before the update's nonce and response MAC are
validated.

The sibling handlers amt_multicast_data_handler() and
amt_membership_query_handler() re-read ip_hdr() after the pull and are
not affected; only amt_update_handler() keeps the pre-pull pointer.

Snapshot the source address before the pulls and match against the
snapshot.

The stale read was confirmed by instrumentation rather than a sanitizer:
after the head is reallocated the comparison reads from the freed old
head. KASAN does not flag it because the skb head is released through
the page-fragment free path, which is not poisoned on free.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Cc: stable@vger.kernel.org # v5.16+
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Confirmed on x86_64 by instrumenting the comparison: with the update
packet built so the first pskb_may_pull() reallocates the head (it pulls
bytes out of a page fragment with no tailroom), the read runs against
the freed old head -- the head pointer moves and the old page's refcount
is 0. Neither generic KASAN nor arm64 HW-tag KASAN reports it: page-
fragment frees are not synchronously poisoned, and under MTE the freed
page keeps a tag matching the stale pointer, so this class of stale-
header read escapes the usual fuzzing oracles. On a live relay the freed
head is also exposed to reuse by later skb allocations.

  amtdbg: cmp reads iph=...e000 (skb->head=...384380) stale_head=1 ref=0

A KUnit covering the re-read can follow separately.

 drivers/net/amt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index f2f3139..af6e28d 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2455,8 +2455,10 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	struct ethhdr *eth;
 	struct iphdr *iph;
 	int len, hdr_size;
+	__be32 saddr;
 
 	iph = ip_hdr(skb);
+	saddr = iph->saddr;
 
 	hdr_size = sizeof(*amtmu) + sizeof(struct udphdr);
 	if (!pskb_may_pull(skb, hdr_size))
@@ -2472,7 +2474,7 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb_reset_network_header(skb);
 
 	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
-		if (tunnel->ip4 == iph->saddr) {
+		if (tunnel->ip4 == saddr) {
 			if ((amtmu->nonce == tunnel->nonce &&
 			     amtmu->response_mac == tunnel->mac)) {
 				mod_delayed_work(amt_wq, &tunnel->gc_wq,
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0


