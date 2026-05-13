Return-Path: <netdev+bounces-287749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE4RN6gLBWo1RwIAu9opvQ
	(envelope-from <netdev+bounces-287749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:39:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECCC53C150
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77D733043685
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 23:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D323CDBBB;
	Wed, 13 May 2026 23:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXZJ4Bvt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EACD3CC9EA
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715537; cv=none; b=K2V98oTHl8n/AgB7o1LQHmSgOkfHLCWWwopV8CKVU9r5rmqbxi1Z/q5kKJ0veij/Y77dwjjbmaWbqvv5TMqE52PTaBYTVKb4pEmfEipvi/x4e7hqt924Z5unDHR6PRN5LqkYSdR2EuXv4I61LXfArPum5ejgSnLA1Ns/z0iS2uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715537; c=relaxed/simple;
	bh=yNFOqidkRBNgkU5BEct5DiEOH0XxS4aqc8GDnXCUja0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szPWqHNhH37Tyae6GVGDVDhhvwlWBMd39CHb/JPNHlBFjvUK8t/3eDI9zkg9BquOMRQsEgvvHKBqHGXxR2WWAzRghoLGeVFTSZV5FZ4aP30BvjtU7DHGJT110nAKCg3nq2VgfIyutXK67GV7pxzAq2Wg3X70sojMviJrHAGgGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXZJ4Bvt; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9102e90bcbeso115232785a.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 16:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778715535; x=1779320335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyfRQ0H0Q6NSd7lYeTh8kpqekVQ9G1te4Gf1oV/71tU=;
        b=CXZJ4Bvtc2b7dh2+wu8VwYt1kH+tqGBWurxIQ1QDS/4PZInvcL2OXtKYv3DrJgUuQF
         Ie3+rubAgqIOLFOUYBoHYpmnRdJDBRk9v/BlqwltCXuInhNhh9ugAf+ALUfSv0/0bNMP
         gMheYQ618fyLtAixmmIgd55DMpwhw8DFLy5zrkGo0qndehAGbMXibkmBf/28g2+YWx+O
         LKHkI6PZMX1uAd2Cj/ZZHmxcaczemi6sknb9/FQd3CQs/7EiWBM//Fem4XSxQOO9DUJQ
         at/AFoaRh3HVXPguWKohfv9RKbNX5lSJiuhPos2qkxtzJMzVrv7qw/ly0iRQiV0wwAlP
         W5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715535; x=1779320335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kyfRQ0H0Q6NSd7lYeTh8kpqekVQ9G1te4Gf1oV/71tU=;
        b=M7rgBGxGOZvc4/OfCH4/DBSswZgKbmN5fC4Puqm3dTHY9PYDiuORuyiROA2XJ66txV
         9bx5XePw9Fg4frDKtSdMRAytTiYYmk1t0GRnDwH6EY0iOwGwIXfJeytCrIAVD66F9ppl
         Bv5f+/bpYISemj9GNfoSaYSY95t2I/Ptg/1NM15JC04ddPUQCK25aUzvp+zCWp0MA8cW
         4dySpyVqfWLd95qodth0OWWtAn2xDAYe9Ypc0Pvyp4uVfCaAke1AwzeED72JC/qx+1BE
         MTgCHOzY8gJdtzLbjc8r1nWZlbkdUSabk5zFgVtft+XEq2gP7u6Aikw9AUmsqXrovO3Y
         6AXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+R1D8fBy27P/Yf+7V5zlORspSrstBWNeopnyDzCrYbk0mNABZ1W4dDWxtn0eCgXD9gc0fO5Go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu2VnpRsLrHOeEvwNDhii1K5pb4xn5CwS+hgNa1FGPxVO//Hs7
	PFR3qRezZSfVaOQepAkCBYVAUkYUS4vP4Okm/rvYTZvG55pmgylf4bPf
X-Gm-Gg: Acq92OHprsNfQ0UfL/gq2nebRjOvTnwgIg6z/4erqyevCI2gdSV9qt5PULIRA512ynJ
	z4tCVcIcdE4aYpq0xGjYKjKRRvY42ny90HFvBgd74OIFSZy4J57puDMWIu4BL8H/aqM7TAB/4eY
	PYIECLkvfM8cPIgLzl/e6uPWcid9bU1E2oFQlWfaUom88B+zyosABBPCdyKiQo3KLAjCY/WUbt3
	lXliekgTPmEBc2/d9BHjVIJH9UUoV3HD4iAcvqBl1Sswfg7+rnlZ8wo4t7IBXoV+268SUYH7mJ1
	E+wDiMHqIMi/A5DtBk2WOiMFRF3Ma3TndrD26LNjMe0x38Erw/FO/ufKETeZmTGZMZiKG3EXTkm
	XZAUcA37GjjudSFNICCdjLLzL0Y7OvzEXI88iE278x5UZ/J26bhmegRXC0BaPW0Fz/Ik0hWhiXB
	McM841Z+TE/89bA3tH+I0ZdjswRAfBNIqhuNEHAnrfcMcjXJogxUElSrLFKNtN9yq+ZN8o7Qd85
	wV8zg6Zq6hTWsnCTdkEgTI3VbQR9qjsaWqd2DSJo8yx2Qkxi2G4CQ==
X-Received: by 2002:a05:620a:4155:b0:8f4:3895:25d7 with SMTP id af79cd13be357-90f88d9aeb1mr853891985a.23.1778715535171;
        Wed, 13 May 2026 16:38:55 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baf2236fsm94186085a.20.2026.05.13.16.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:38:54 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: Felix Maurer <fmaurer@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Luka Gejak <luka.gejak@linux.dev>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/1] net: hsr: defer node table free until after RCU readers
Date: Wed, 13 May 2026 19:38:38 -0400
Message-ID: <20260513233838.3064715-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513233838.3064715-1-michael.bommarito@gmail.com>
References: <20260513233838.3064715-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5ECCC53C150
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[redhat.com,linutronix.de,linux.dev,gmail.com,smail.nju.edu.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287749-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

HSR node-list and node-status generic-netlink operations run under
rcu_read_lock(). They walk hsr->node_db through hsr_get_next_node() and
hsr_get_node_data(), but RTM_DELLINK teardown removes the same node table
with plain list_del() and frees each node immediately.

That lets a generic-netlink reader hold a struct hsr_node pointer across
hsr_dellink(). In a KASAN build, widening the reader window after
hsr_get_next_node() obtains the node reproduces a slab-use-after-free
when the reader copies node->macaddress_A; the freeing stack is
hsr_del_nodes() from hsr_dellink().

Use list_del_rcu() and defer the free through the existing
hsr_free_node_rcu() callback. This matches the lifetime rule used by the
HSR prune paths, which already delete nodes with list_del_rcu() and
call_rcu().

Fixes: b9a1e627405d ("hsr: implement dellink to clean up resources")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 net/hsr/hsr_framereg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index d09875b33588..06b0977ab099 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -163,8 +163,8 @@ void hsr_del_nodes(struct list_head *node_db)
 	struct hsr_node *tmp;
 
 	list_for_each_entry_safe(node, tmp, node_db, mac_list) {
-		list_del(&node->mac_list);
-		hsr_free_node(node);
+		list_del_rcu(&node->mac_list);
+		call_rcu(&node->rcu_head, hsr_free_node_rcu);
 	}
 }
 
-- 
2.53.0


