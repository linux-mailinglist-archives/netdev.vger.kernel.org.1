Return-Path: <netdev+bounces-268532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BAsE8IquWmVtQEAu9opvQ
	(envelope-from <netdev+bounces-268532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:19:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD10D2A7BBE
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCDC63030E92
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ADC39E6CD;
	Tue, 17 Mar 2026 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2wV8MV2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09FE330D43
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742542; cv=none; b=QN1gU1MpdoQtivrHrv4t+UCG8+WcX/PfygzDYDd87XVOr66LtnHpviCi7KhoZimWyR1pQVq13XPSYhMR14CMtpqzxXNF/uD07F7cARNFx75pFX32fCvrnPDZHOy55vbCqCMOcd7x1/59Tk+3qPeWZpHdbR1MWtYgMKj2Rct5VzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742542; c=relaxed/simple;
	bh=qQsRsRo1lwM6NZ4V6oJfN2UKgfC38t0H7ex14ZKedEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bO2QNLMLiRC+VmjiZJZplU17Ka3z3xUWe9L+hlZYQsR6W/Kaih+LvvAQTB1cqgXqFVMlKU17LIxUkYb3wsxbDd/dMdd1NMc0gi4iBidBQwE03YwSC9aYovmZJJnHXWjSjhayyp1EnGFfKoMgeKLsyE6MeryrLJQdrUTA+S/ydJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2wV8MV2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9358bc9c50so690493066b.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773742540; x=1774347340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iRfjqfC/TBsGVHqBrwzxSIT/mb5DrDQmAIZikbq0tmE=;
        b=T2wV8MV2NyFc103MuvEJc+GKaXi1VZl8XQR9cc65Jj8cITqe2nmlhyRT/jVOTmn5ta
         0V2lti5sbKPPHjpWy0amNJNRxPDQ1mgb5/Yi3Zrp/KS0NUj8P2g3YPjP+vCgrrLi/pV4
         j+hApRBIGHV22TsSomHI2KVKbFOwjpnuDvfl1k8bv3BRtzjxDgICpu/bCDzUGS/nXNGr
         IMWETVVglpOl3uNIC8s9P7cets1qXPJTSuVEpt4CZzhvcLVRttn4W9R2tGL1wXZXh5qq
         h2mbb5+aZdfArlc710yTktryLtbRrT0611UkH4gLUAPLkEz7D6FA0AhY2SFxJlcCVhMx
         dg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773742540; x=1774347340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRfjqfC/TBsGVHqBrwzxSIT/mb5DrDQmAIZikbq0tmE=;
        b=IXlI491MBtJVlIdK9Hmj0tDRylsFrDsOapfrQXuJ6G8Egcw60YSPCuITIPG/Lo5fqn
         99OiAPn9eftAGYVf5PqeTwTJz15Y1hA+yeUKsGfsfX6bj8eMWYJ0hei3Tl6eAyqWBujZ
         YJr8t2bKxWcRjvxLqG9tWz8o6/ujTkLh6BGbk122uYQ/YpZ3Irz+K71Oy9xnoY7nnZ3C
         yMezpGR8BJrD7wx5Wl22EkViNndovHVpy5aLd7sU5CECnwNR17efVaApSAQWY0IM5QB+
         FIjx+2ZNruiQMZXspDPXxg05gGxodhDu76k0tMJ7HdJmW9FfbtPHDmMhlwDmyvVcLsRA
         lxuA==
X-Forwarded-Encrypted: i=1; AJvYcCXlIx++aoiMy0z5g7Ws3/5neT/dvmg/LdWbcgY+yxL4NWeY13jL/A8xP9R8pPVIfyY0MsGHeUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0InGF7SO14GwPZRJ0l4XUXmFTLPNlwR6kHvNZwnlFA76sl5o
	q4kQzJE/hIYnwkqQ2ZsHeLVrSXMyZcJJIQNg0jETdyUgCUQHIYHNmn2R
X-Gm-Gg: ATEYQzxZPXWYQvpGe40CIDTNXUZc0jBK1c5qsN7bSq4OIEpgHyUBW8brQHKL43m8X9y
	axoabU7qvaFW1QtUSOiMotAnCU5/ai8pUuCfsmDzaJkFm+bYXpdGSsx9nBxcAOqTffiqxCdSo+D
	uDsRJyUm9czaf5S/iDdKqOSNNbrkAUqQHWgYn1EP8mD7OIkbeBwKTkOi8oTifKl3JP4x/+dlxIR
	UtziqgjrsM7xsmec1aY9+p3ZjT2nPc1EH5i0FP4ROBLzBX5/6wJeSduz6ubXIsUm5G+cH4m1xbk
	4JOCpjs437vlHwI4MShmULz24tzeMCQEmFn8p6T5FpQLs2McZO2bhZ9qKbF3WJ8JgYpwTKaUEJI
	WOtN4DJ12ovcYPeJfKvY+cOdnVbcD44LLX2qnk6yOn9BpyRcGNrRtieyV5BgoRdwBU4PBvQM23R
	W/fJnYL1PSGnjXKnkzj69yvpfv8Hs6ozKYcojpKyGupYzePARJSX+2y5HFrqL4EdAwWSeid5rd9
	yGerwVOgzRJR2vNwCZ+6C+QVkkUPsHOXdVwMZa5rQteepIvtJqrrfk=
X-Received: by 2002:a17:907:9343:b0:b97:3bbe:e432 with SMTP id a640c23a62f3a-b97650e9a55mr945539466b.23.1773742539481;
        Tue, 17 Mar 2026 03:15:39 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9781914f96sm656674666b.47.2026.03.17.03.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 03:15:39 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH v12 nf-next] netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to nft_dev_path_info()
Date: Tue, 17 Mar 2026 11:15:25 +0100
Message-ID: <20260317101525.358016-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com,blackwall.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-268532-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bridge_fastpath.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blackwall.org:email]
X-Rspamd-Queue-Id: BD10D2A7BBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In case of using mediatek wireless, in nft_dev_fill_forward_path(), the
forward path is filled, ending with mediatek wlan1.

Because DEV_PATH_MTK_WDMA is unknown inside nft_dev_path_info() it returns
with info.indev = NULL. Then nft_dev_forward_path() returns without
setting the direct transmit parameters.

This results in a neighbor transmit, and direct transmit not possible.

So this patch adds DEV_PATH_MTK_WDMA to nft_dev_path_info() and makes
direct transmission possible.

(Also needed for flow between bridged interfaces, maybe implemented
later.)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
[ Rebased; moved to nf_flow_table_path.c ]

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

---

Changes in v12:
 -Split from [PATCH v11 nf-next] netfilter: fastpath fixes

Changes in v11: (results of testing with bridge_fastpath.sh)
- Dropped "No ingress_vlan forward info for dsa user port" patch.
- Added Introduce DEV_PATH_BR_VLAN_KEEP_HW, which changed from
   applying only in the bridge-fastpath to all fastpaths. Added
   a better explanation to the description.

Changes in v10:
- Split from patch-set: bridge-fastpath and related improvements v9

 net/netfilter/nf_flow_table_path.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 6bb9579dcc2a..f2d7822824bc 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -103,6 +103,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 		switch (path->type) {
 		case DEV_PATH_ETHERNET:
 		case DEV_PATH_DSA:
+		case DEV_PATH_MTK_WDMA:
 		case DEV_PATH_VLAN:
 		case DEV_PATH_PPPOE:
 		case DEV_PATH_TUN:
@@ -116,6 +117,10 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 				i = stack->num_paths;
 				break;
 			}
+			if (path->type == DEV_PATH_MTK_WDMA) {
+				i = stack->num_paths;
+				break;
+			}
 
 			/* DEV_PATH_VLAN, DEV_PATH_PPPOE and DEV_PATH_TUN */
 			if (path->type == DEV_PATH_TUN) {
-- 
2.53.0


