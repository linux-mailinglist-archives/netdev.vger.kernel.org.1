Return-Path: <netdev+bounces-296818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tDccNT1lJ2r6vwIAu9opvQ
	(envelope-from <netdev+bounces-296818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:58:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3132465B7D4
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:58:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=Mr75bK+X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296818-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296818-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C97A302FB6E
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30002561A2;
	Tue,  9 Jun 2026 00:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D32175A7E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:54:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966444; cv=none; b=MjwH5nBQ9HsmLuL9BRL2d9Km8ku9g+al903bxZ+PXHcx9Ji56bb6R4qkDQEL0m1fd3hazxK8owEgoqBXCp4nzJ4kLz8Cs8zZyBWSanO5JzljR6WAJeuQHsLv5GbgT6tN6Cq0rjfJslbJZCpzsLs9COHeruveiTp9OuoRSU6vw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966444; c=relaxed/simple;
	bh=PeMGTAiBDA1zLaaR/tkHWppVR0Mrqa7pwBx29pP1yq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vu25n9EMj7pw1j3T8BiECzTKCwz7mfYgL6n/XtZohXKoNkn9dySJgE7w+bqSoztRdG5HSrFt3O0wN3IgadohAziOczxorLxnLFD5xmSEUz1dF/YWstbfIcfqVtE99PoPhS5/gDfAeTRGIbsw9Fiu3fk4L+oIEaLtmVKqgV5XEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Mr75bK+X; arc=none smtp.client-ip=209.85.219.51
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ccef25789fso34141286d6.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780966442; x=1781571242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SLIjYpf1CuOXyUq/M7hnmedCnWq0PTsVfjdjpT3u0Mo=;
        b=Mr75bK+XSrCTmwWB3STn/l5lAm5EDPOaL7vEpwBHra2DkTMw69nFUKDDPpbuucF/ea
         k7ol9Fa+gkozAh25rAJhjLaX/sk8ENWvD0u3LP45/gU9sUUK402vwPF8j7EY+eeHFbYK
         XaW6z/cmXChP7y28/dyBonNdobicxAMbuSXVvcdZS1teTbldVVLBj2r+LwweYCz+4Oym
         SwrvVCL4t9KrD8GO/RxntAg53aRPBVeMsiehBkliCytRjA5IUmDvSuIo1mKTxudoIBfb
         GLDKo4hmycNo8C5V/XcjvkygxssCHEioKFRq13Wi3wX6Z9i0DJbyao5CCpC7eTraPg12
         h1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966442; x=1781571242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLIjYpf1CuOXyUq/M7hnmedCnWq0PTsVfjdjpT3u0Mo=;
        b=CqIIL9g2uGevw1cMqGL1qXqLXOpRbRO4JnOTod7Ma1JIDp24LGEmj5CGjkwSXXGtgM
         8jl7LSmH+uK/CSXyWxTQkOHDID2q/arqUzAm28+OjR8pqKaXa60n8hSzveJ9T1EwsY55
         atawiM9lF9fRXI/II7iQGSSIGR1dlIHL8Ns7Fdv27diY6LeZfqdBfsoV1POzSWSxHSlQ
         Z1MTep2Tz8sq1cvMCnhnGttpNL69WfwphzacZnX/WciNaj8hJzT98o2Tk7vuWUWjZ5/Y
         V97DYeKv/9FZNWOuNggIaBMMqrFJq/tJ/DpQKiw5vBtJJS1o884oRagtX0xFCbugubeQ
         sx1A==
X-Forwarded-Encrypted: i=1; AFNElJ8rDehS8O71/nJDTmQ7xV3ZwA2wkO76LwDEwFX2QonAlYEnt+tyWWHFD7P8JKYr4b3W3X4Aea8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUcE537sgjUDrPbkFnhKAUfpEMUXuoMTT2Bf9MvLJHuJOFl8l
	+yGVMXJOyP2XL3SvhUJLQXuDCAh8TNO9pmMECHc/2+XUanZ5hNhn8piwHR1BxsbkvoY=
X-Gm-Gg: Acq92OFa79YWf8HT+j8s5iqi8CTCj/H71o+cJrhMizQIFHPL3Q3lwxntz/R+noW5wSO
	ESX5DA6nx/7vnSiN/5zv5eYl3s13k1Ce7mzfP7/hJKoVwc7NdDQ7KbUcSZxkvJeRnRgjFgOTbZU
	88GOMB6S+UirRRDXLzKtC+xSmMC869fJVPA1mPHVN2vFFqvXT1lZJaFJ8h1Q9PXavcl+KjioTFk
	zXUgQvmGTf0u82FhseOXMmAUN9h8afsqY9jx0uVK6GvfoS1nrPgLUL21LRG/Ak8GOjpl6brxjOK
	6WJxH7ElehF1m1yB8t+h8TMbNH/DmE76+GDWcJrOdlI5SpGgguddTO4ZoAsyN4baTvkOIezxD5q
	u53i4JawnQ76yuDr6rgEfzrVAfL686sh9eQgte8opMNI7FpqLFOzi1kOBcsDcUXEWOeiKP+OpBF
	gjyc+AAhE8IAH9W14z9PNrc5rX8+JcqIp0BkWwxA==
X-Received: by 2002:a05:620a:454b:b0:915:7732:ea7c with SMTP id af79cd13be357-915a9da3801mr3019464085a.43.1780966441679;
        Mon, 08 Jun 2026 17:54:01 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a2359ecsm1928705985a.14.2026.06.08.17.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:54:01 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/sched: hhf: clear heavy-hitter state on reset
Date: Tue,  9 Jun 2026 00:49:38 +0000
Message-ID: <20260609004937.1240807.c0dcec938172.hhf-reset-stale-classifier@trailofbits.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296818-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3132465B7D4

HHF reset does not clear the classifier state used to identify heavy
hitters.  Packets after reset can therefore be scheduled using flow
history from before the reset.

The reset operation should return the qdisc to an empty state.

Clear the heavy-hitter classifier tables when HHF is reset.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_hhf.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 96021f52d835..1698c1b54dec 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -461,12 +461,34 @@ static struct sk_buff *hhf_dequeue(struct Qdisc *sch)
 	return skb;
 }
 
+static void hhf_reset_classifier(struct hhf_sched_data *q)
+{
+	int i;
+
+	for (i = 0; i < HH_FLOWS_CNT; i++) {
+		struct hh_flow_state *flow, *next;
+		struct list_head *head = &q->hh_flows[i];
+
+		list_for_each_entry_safe(flow, next, head, flowchain) {
+			list_del(&flow->flowchain);
+			kfree(flow);
+		}
+	}
+	WRITE_ONCE(q->hh_flows_current_cnt, 0);
+
+	for (i = 0; i < HHF_ARRAYS_CNT; i++)
+		bitmap_zero(q->hhf_valid_bits[i], HHF_ARRAYS_LEN);
+	q->hhf_arrays_reset_timestamp = hhf_time_stamp();
+}
+
 static void hhf_reset(struct Qdisc *sch)
 {
+	struct hhf_sched_data *q = qdisc_priv(sch);
 	struct sk_buff *skb;
 
 	while ((skb = hhf_dequeue(sch)) != NULL)
 		rtnl_kfree_skbs(skb, skb);
+	hhf_reset_classifier(q);
 }
 
 static void hhf_destroy(struct Qdisc *sch)
-- 
2.43.0


