Return-Path: <netdev+bounces-278166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHCuM/E03Wl9agkAu9opvQ
	(envelope-from <netdev+bounces-278166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:24:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 415CB3F1F43
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B96F303CC1F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE62134B676;
	Mon, 13 Apr 2026 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwJIJO81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A8223D7E6
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104552; cv=none; b=GkT6z/XOTEZ5M+jfxsH4wmplWuje/m/y+c0rj/pT2NMcDCdiEBeEy4qNcUtfqxDz2NBYfQGGrxBdRJQzDAvNM81p5pY4WgCTJyxX2DichwLjriD6UCsaG6s7WH/+DwtTUsrUV/0HPQwuQnRTxVpYJYBq4JMyGl1JMQC8xm1yIps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104552; c=relaxed/simple;
	bh=vRfn1eIpzqwwPd1PIv52bIl1PJXjLpPHi4j0z9xDlc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+JVBirPHTCaxLDI/3skiVlgMLSlq/ZE9gbozfMdOJMGEBSKrcVw+hOUbd5XJzynWowNVhK8Y/0q5cXG3kfueen40ehdMMp2zwv6ynP/ahYIDtYfvYdcYXWAmNorzHXYiVsBxb8dvWkRj67DqIfTStadx01GV0ZvAdBRjvSPHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwJIJO81; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-482f454be5bso50636615e9.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776104550; x=1776709350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYKFqRHALrwX6tYikrZmISuQnQxh/bhcagdwZ5Pb5/A=;
        b=DwJIJO81AtnTE73M0vWwJK4bdaJxx2Awa/GRrF1W8fooPXUURNUX5qim/iCyU2wQ+O
         JcJ5crBV54DcOnae6qer+UFckZhDddllS9I58is5SyaT3w+dOX4tqQZPJz9NLZUy+dID
         3cCV1vNxKq813i4XFXkSOo4WHPPBwSHyA3oAB/bY1gGyEplPTRsNvI4uwV//TzAn8h5I
         g6jtWuR2GyejNt7qsf5GlixdMyzHIgTQbyY3whFjwLAuUOoHnQENaA4cfXsnGNSG7W4+
         +AEcGEz4nEbDSS+8fz5YQMlBO8nlEugIxBtIvixT0/fr7IiAA2rtKUuqQiH8h5+eBr5V
         2iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776104550; x=1776709350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYKFqRHALrwX6tYikrZmISuQnQxh/bhcagdwZ5Pb5/A=;
        b=lDH/PG66qb5LfJ48CIzvgy2gO/AVCPgmL/W73TVMX9+2r4hV7GQlA8atIUCopkatyB
         DoiD6ctSZq0xNPBPC3ifsDGDTuAHO1aiHXSBNABJCXM4nS5kiXaEGUhRWATKxCchs/36
         jDGi2X54fEgKiXszd1ZZN5lVAD9VMHlPtmDIzMhSMEMpJIlHgY4Gm5v6Z97BBb3MQQXK
         2TA2Lps9gy4CwmHFIrgF8WsFmEheUebw0qs2be8TUZTZ46w120N3hbV/hlGYPzRmMAjx
         4R9bFTRuphQ7aBfMC5guCwqu0U0+83WZ8pdFHIa4vZ8PfcQz7yNaWANksJQy13lhI/bl
         FM0g==
X-Forwarded-Encrypted: i=1; AFNElJ8E6eXlcS/zfhgNtTmq6TBs4QqcpqcI+zGKkOjxZM39DZO7z+gnjaHZ4R+EO2BeyMfSy/56AU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1UN1u8jQehOk6Oky/7zxadl5WkMvEpOEyCt72w4Ju66MtvMdo
	cR3mvmfJPP8VxlMwtAMMvQF2C2utDcXIwJjTd/vEYZMII0nLQIRmdCBo
X-Gm-Gg: AeBDies8ih3LVlW03Bmq4+4GgobCewcRTmD7KzotjO7g7y4/ms8x4PJORWGiY5npXQz
	ssUHCP0q2oZshLlFpXo4+IgkU8/r4RGKHD30Jiti+h0J83bDTEhhEIUvC1Tb+tC5x6xEbc/E/LJ
	1oC8sGUh0Ye3cGcLG2UJ6eEJV4XQn9UW737QqgLeSes0Pp3mGeRpdyfkpdWqNuxrhaL1ukQNrEK
	5LB714ydjci1Ji55Liht1jzSFUnkdCrc8cnm2UfrSya5fQa26k5mU/Z4+rO2ZrWwrSU6dKgS9aW
	O41UJtdB0p+dKQ3b+FNmWf/pQFSytIwsGyaDpm2ersiW8J0z7c+U5IV4Bc8EUlAasd9kTWgFsOo
	/IPrBX6edlQoz/tZU2pvOjA+9rdZr5eCf6GAePh/hvENmNuRdhKVXYAgxecHbnGqQdcSOBOMuWe
	bzGmiA2te/XgF1EsdQHkTSe7kRB4q0CGcknyOYyZl7rM2BdOYaGozI21SAlgm55BFv4C3DVU0NQ
	3Wp4zqzZEpo
X-Received: by 2002:a05:600c:a105:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-488d681701fmr132606625e9.1.1776104549378;
        Mon, 13 Apr 2026 11:22:29 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm298282905e9.4.2026.04.13.11.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:22:28 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next v2] net: check qdisc_pkt_len_segs_init() return value on ingress
Date: Mon, 13 Apr 2026 19:22:25 +0100
Message-ID: <20260413182225.10683-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,fomichev.me,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278166-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 415CB3F1F43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
changed qdisc_pkt_len_segs_init() to return an skb drop reason when
it detects malicious GSO packets. The egress path in __dev_queue_xmit()
checks this return value and drops bad packets, but the ingress path in
sch_handle_ingress() ignores it.

This means malformed GSO packets entering via TC ingress are not dropped
and could be redirected to another interface or cause incorrect qdisc
accounting.

Check the return value and drop the packet when a bad GSO is detected.

Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
Signed-off-by: David Carlier <devnexen@gmail.com>
---

v1 -> v2: reorder variable declarations for reverse xmas tree
v1: https://lore.kernel.org/netdev/20260408172307.46498-1-devnexen@gmail.com/
 net/core/dev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5a31f9d2128c..d11c22cafca9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4459,8 +4459,8 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		   struct net_device *orig_dev, bool *another)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
-	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_INGRESS;
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+	enum skb_drop_reason drop_reason;
 	int sch_ret;
 
 	if (!entry)
@@ -4472,7 +4472,15 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		*pt_prev = NULL;
 	}
 
-	qdisc_pkt_len_segs_init(skb);
+	drop_reason = qdisc_pkt_len_segs_init(skb);
+	if (unlikely(drop_reason)) {
+		kfree_skb_reason(skb, drop_reason);
+		*ret = NET_RX_DROP;
+		bpf_net_ctx_clear(bpf_net_ctx);
+		return NULL;
+	}
+
+	drop_reason = SKB_DROP_REASON_TC_INGRESS;
 	tcx_set_ingress(skb, true);
 
 	if (static_branch_unlikely(&tcx_needed_key)) {
-- 
2.53.0


