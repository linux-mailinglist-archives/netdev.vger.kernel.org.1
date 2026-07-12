Return-Path: <netdev+bounces-306991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pvWgFmwmVGpDiwMAu9opvQ
	(envelope-from <netdev+bounces-306991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 01:42:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E857746402
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 01:42:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=KazK+9mv;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306991-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306991-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62E87300D337
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFBB38D3EA;
	Sun, 12 Jul 2026 23:42:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C0385D94
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 23:42:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783899729; cv=none; b=GNfaSxVBFU8k8kbNt0yXF7PpffGQCPYv97CtJEDkNVQ+FPRVB1MI6ZtEZ0uQjiuq0bfoiC2g3RhR/3C3GTmkUoqN/QWaY5VrLfK4laKIhSYnwSX29dAavUYG0+yGwZy8gtOgn5MLLGUx6LfkA9zWME7C+YimxijZfrL22YKVZqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783899729; c=relaxed/simple;
	bh=dLgwcnW4YtgNTCb07VpBnEanlIde5YMvtskoZ4n/0XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sovEf2XzdCEeNm8W+riXDzIP31JMRjtEmD22oyXSMQvXLHtAYEXbIWL/Axnid0bVF33lbJ0iM+tYjq4N1odF0sXk1vZ2J32nYfWj8QV9vsLQGotHY5yB792sQQIgivFDrRlagT4Oy8vxbfa3tpMr47nwdcEj6DPbTJn87HqDlVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=KazK+9mv; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a2dcec51cso656056b3a.3
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783899728; x=1784504528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOSvs3VNPQa+toUMC3FY+7NtrOSPXGuDizFuqw88H7U=;
        b=KazK+9mvzIm6kSf3mVKRNikwhV7qsyX9veCDhOWDpUb9sAwhzJc4bHYcID+0WJ3cPH
         etJZ0eBrAl8c2+pg04d6scPGVR0SMBW9ldkxB2KFaeF4Eoq2m2qlEibLZVanv3YmQBfd
         KE4sMxlqXtCKacaJED2LFdJUkQQx3i3O1rnCGiJJzTDOQ618/FVbARBrqF72Z4rqf1vL
         I9WRd/mmkSqTTlA2RDwfR/XxHll5GJVsUe9xONpa6IKl5+FXTYiOGtn3JiUUccxcomrh
         yqyAcRqM+GVUopQiqvvoEtfrXvTsk7mKrrWnvZG4DrCP66JpNEOHSuB6aX6Ysq99lYJ2
         l1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783899728; x=1784504528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOSvs3VNPQa+toUMC3FY+7NtrOSPXGuDizFuqw88H7U=;
        b=M70ed3GxrktLMTeb01/FTbjwEMJzdVG0+MDYV812mM2s/OY0cH/rthQLWKP8XUrmYn
         fcXW/UqLUICJPET6/sBEyfFCr/P/o2z72wiaDctnpNk9VWhBMSReJZLvh7OAW4iOL5ae
         urVM3gnfUgExkFqkxycSJ3JgoQQ7vEljrD9u0RZcTEPlwI4/TZwgsORAT4mFFOLpVvUU
         wLOCdJRiI8iwoBF6fd5TYfZLMc0qOc77anvLkpes//44vGAcZt64I85DnFycrKwM3ehP
         8vb8POijY99I6Wf+e7sq33cHm0/iWEH9waIbxeNkn5PqWms9htaNuxXogbPH7KbHeXaI
         tnXA==
X-Forwarded-Encrypted: i=1; AHgh+RrF6+JMqtUGzvyvUEfk9Vmu0LPYGymr7E7h2ZmTcrlz2hTtsp7MfQPosnKqqKJyxtqeiPdSF6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnhKJrGCsnZDX4rQMvlcqyUAyN86mzZ3aCl6EH1DvvzZxPOLm
	iIUljX7+/jetgncG6/pP0/yEMU4DROLkyEm8+zuRnu+cmxBt3Y0ixiAlMRBkw+PQfw==
X-Gm-Gg: AfdE7ckVu/295Ve5h3GZt5SwJQmPlg9eRF6Kbo8SAUiCwxmPJhfJabvfTQ/KDTz8WN2
	eDUj0yo2o2TATSBxyW5Hqtu9T2rJEVoYOZeJnyz6tOtDd/af/oJSYoHSn0rer2ebj807ThkvdXG
	qfgzAjc5CinXsIb46yPNgG02O2TpvSH9keNjimYdEtXzfyemb+yvocUHe1yVlvKXyl867bEsXUa
	Go1XtuR6E3PR6UKTQH5u16qckblYl/vjnfC7ekbnGPaUswTXDaVVxQV0mirPtbCJlDze9lb/2R1
	rbzdqsU8Q890ytKOz6rb5yXuxF38CNXWufB1UBVQREiV6JWd/0DQVymk8jhmBtB243MiOqBSPOv
	z8p8DC4gc9JqvkkJr0s8RVoQvDcRbN7GnhKcyWO3Zf65rz4Qttzy6sM9Uf8mXPT27Lo+//AJCTw
	==
X-Received: by 2002:a05:6a00:4484:b0:848:3f07:c5a2 with SMTP id d2e1a72fcca58-8488974f8cdmr6076086b3a.4.1783899727744;
        Sun, 12 Jul 2026 16:42:07 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec82:d7be:f961:4fa0:51a9:cde5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca79ac0e269sm5756646a12.3.2026.07.12.16.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 16:42:07 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Patrick McHardy <kaber@trash.net>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH nf] netfilter: nf_conntrack_sip: widen NAT rewrite delta to s32 in sip_help_tcp()
Date: Sun, 12 Jul 2026 16:42:01 -0700
Message-ID: <20260712234201.3213635-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306991-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,trash.net,gmail.com,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kaber@trash.net,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E857746402

sip_help_tcp() stores the size change of each NAT-rewritten SIP message
in s16 diff and accumulates it in s16 tdiff, but a single message can
grow by more than S16_MAX while the packet stays under the 65535
enlarge_skb() limit: nf_nat_sip() rewrites every matching URI, and a long
Contact list expands the message by tens of kilobytes. diff then wraps,
and "datalen = datalen + diff - msglen" yields a huge unsigned datalen,
so the next iteration's ct_sip_get_header() reads past the linearized skb
tail.

Widen diff, tdiff and the seq_adjust hook to s32. Both are bounded by the
65535 byte packet limit, and the seqadj core is already s32
(nf_ct_seqadj_set() takes s32), so no previously accepted input is
rejected.

  BUG: KASAN: use-after-free in ct_sip_get_header (net/netfilter/nf_conntrack_sip.c:464)
  Read of size 1 at addr ffff888010800000 by task ksoftirqd/1/25
   ct_sip_get_header (net/netfilter/nf_conntrack_sip.c:464)
   sip_help_tcp (net/netfilter/nf_conntrack_sip.c:1694)
   nf_confirm (net/netfilter/nf_conntrack_proto.c:183)
   nf_hook_slow (net/netfilter/core.c:619)
   ip6_output (net/ipv6/ip6_output.c:246)
   ip6_forward (net/ipv6/ip6_output.c:690)
   ipv6_rcv (net/ipv6/ip6_input.c:351)
   __netif_receive_skb_one_core (net/core/dev.c:6212)
   process_backlog (net/core/dev.c:6676)
   __napi_poll (net/core/dev.c:7735)
   net_rx_action (net/core/dev.c:7955)
   handle_softirqs (kernel/softirq.c:622)
   run_ksoftirqd (kernel/softirq.c:1076)
   ...

Fixes: f5b321bd37fb ("netfilter: nf_conntrack_sip: add TCP support")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 include/linux/netfilter/nf_conntrack_sip.h | 2 +-
 net/netfilter/nf_conntrack_sip.c           | 2 +-
 net/netfilter/nf_nat_sip.c                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/netfilter/nf_conntrack_sip.h b/include/linux/netfilter/nf_conntrack_sip.h
index dbc614dfe0d5..aafa0c04f917 100644
--- a/include/linux/netfilter/nf_conntrack_sip.h
+++ b/include/linux/netfilter/nf_conntrack_sip.h
@@ -115,7 +115,7 @@ struct nf_nat_sip_hooks {
 			    unsigned int *datalen);
 
 	void (*seq_adjust)(struct sk_buff *skb,
-			   unsigned int protoff, s16 off);
+			   unsigned int protoff, s32 off);
 
 	unsigned int (*expect)(struct sk_buff *skb,
 			       unsigned int protoff,
diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index f3f90a866338..e4a70d1d77b0 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -1663,7 +1663,7 @@ static int sip_help_tcp(struct sk_buff *skb, unsigned int protoff,
 	unsigned int matchoff, matchlen;
 	unsigned int msglen, origlen;
 	const char *dptr, *end;
-	s16 diff, tdiff = 0;
+	s32 diff, tdiff = 0;
 	int ret = NF_ACCEPT;
 	unsigned long clen;
 	bool term;
diff --git a/net/netfilter/nf_nat_sip.c b/net/netfilter/nf_nat_sip.c
index aea02f6aff09..a93eaf0f7d30 100644
--- a/net/netfilter/nf_nat_sip.c
+++ b/net/netfilter/nf_nat_sip.c
@@ -321,7 +321,7 @@ static unsigned int nf_nat_sip(struct sk_buff *skb, unsigned int protoff,
 }
 
 static void nf_nat_sip_seq_adjust(struct sk_buff *skb, unsigned int protoff,
-				  s16 off)
+				  s32 off)
 {
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *ct = nf_ct_get(skb, &ctinfo);
-- 
2.43.0


