Return-Path: <netdev+bounces-296332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VS+rH84IJmrQRAIAu9opvQ
	(envelope-from <netdev+bounces-296332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 02:11:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E61EA651FBF
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 02:11:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=e7RkjrOH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296332-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296332-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C633300DDC3
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 00:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50E234CDD;
	Mon,  8 Jun 2026 00:11:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C343C15C
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 00:11:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780877499; cv=none; b=pFzHQL3fEgdmw6BltlP2UKCSTjwrwe7pM1r+6LWEj1PmX8Wtsxr6aJ9l+ntw53E2sK+7tiEQu8UKtcjfG4OBJvZlmciTui1aVvUmhqAuB05AZAS7S+gfCQzPtjbK+U2Y0WgG4AXRUsgHqvb7cgdmNLzd3sjYUOV+4nW1P9yhwX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780877499; c=relaxed/simple;
	bh=V0kYIIvrIeCHLQ8a3wc6DSRe9JDMTon7cWNexfUqcao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7tde9zHLMU0SRwblWtDa456dBosbe2qtMqXcyWMnndOFVMWkwTuQQkEUP4Bnu6fPjuws/RV/emc8eWOujKUtHjpoK8o+FmUkuaXDoo9wyEScqhJTf8Ol7ywLOPs1EOV82BfR9NMzRXpHy9+9hgRXdLNcICANQi0jTlOwdOJx1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=e7RkjrOH; arc=none smtp.client-ip=74.125.82.179
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304cf518c9dso4495258eec.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780877496; x=1781482296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7iRu3+QlhKqNKahUpScbtHabnmDiSQhKgGceKe0jaQ=;
        b=e7RkjrOHhv++qxwhAuWd/AuFvCQY4F7jRBDn/V3rOo730Eqd7fB9WiFgyLeBBCr2ir
         WFYVCiGMDjrSGmxZG9c6kRmm3qnUPue3RBP3EwUyY3pplXB2/qXz3cpEyTDRl81xw6mh
         GwxeojuIlsiiSV5tpczuDZ01x8Fsu/pA8lz2ZgqdX13/HENe9FsbarExDj3ImIIC3N/S
         cXqiQc6okzGjr8p4KkePcy6cJYQ01swMZBeaXDsMEmdFhFgDXohFfyJmIYi0W2G8zvmR
         uF7hZ+dYbPLBSLF9y/WoTpmAhYoEKUpc6Q/XIYuE2kT3HPtBJZIsYuSe435UfMZjMeRU
         er/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780877496; x=1781482296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7iRu3+QlhKqNKahUpScbtHabnmDiSQhKgGceKe0jaQ=;
        b=e5+mzYakgwBAv0y3b+7OcAQicLVD9fa54OGHTv+6eVVbJIGsrrt5NQrOcLveE523Sr
         29/qDzKvAfOZaQq4rxNaIyA58yHMLHHb/Kdzko/lHVTwx831ceQ6OvPxnIyO/IWZsAcm
         0EWX3ifWMtfN5zdZVgUXB0Irmm1WWdChimAhtAYZc/ctuAhWuC9IIKfelrJcDGzqXEsi
         FuV+Xoucaj5ZE6lj2FIaoTZDa7wYp3j1lFKpDQMiOebwOt59ld2fUUZ7k0mWbkb89Bk1
         HVD1jYSr+oZ1uuNlVKmAu3F8sWQexoFlGLmGNSprnsI1zlsNLrApXOJXfYsWzRPy+JA6
         dXlg==
X-Forwarded-Encrypted: i=1; AFNElJ8zCdQnufZNnf8lt929jQTVKKXxBfzqW1HX1WdepB2PM/TeHrNTPlbvvcf31/O6WDEl2GfB08Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuTAtNYsPd3YRQ7mFPuik/S68TAOEGFlMCkCwAhJwxnKgqOe8
	KJ8QdAYdNEj3Rw6PPLxQAmtdgs0qES64dA28zAMHhRHfN0MG1BteEH9v9DH5vR2okA==
X-Gm-Gg: Acq92OHZLnPtj7D1sa0wo4k1gg+e85d4Kx9eP0cDclc6af/3rawMNgaLl1BblpWFoeD
	5GzPVF+VF1jw6uPYU/8Ff+rh7mlM5eA0hWBI75GhPRsb0cmuALOPQsMiPo4hwcBlOd6xJp9wFnc
	2EX8+v9s9sNWDn2YL7hDLYssx7FSCxbWSzBMH96YtOXHYp18pYzLmniTuICbdbELPPiFwSOPT9R
	22XlL6zBQU2XImODhbCwUfZEgrdEZXLcTNs9mDfwen0ml8HnISGWTtIC5iQyXUEL9Yth2UiJmqB
	QUCMiy7KxZZV3tNHg2lm88RJQVZyy6D57MP9FRt9p7jIIC2nfyIdN4Hyo81cjfNxuBlF/pLgB2r
	M3kNq5vclTmqdWUS18J1lA+VvcUh46LLXbvCydq6KgapEawmi61LEDvET0rv/RvIN/MGJW+cNg2
	VCt0i8I1TSPw5h6MdS5Q==
X-Received: by 2002:a05:7300:5356:b0:2d9:db50:c6a5 with SMTP id 5a478bee46e88-3077abe9a9amr9120785eec.0.1780877496218;
        Sun, 07 Jun 2026 17:11:36 -0700 (PDT)
Received: from p1.. ([2607:fb90:ecaf:d942:ceea:844:6820:3308])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm18032945eec.3.2026.06.07.17.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 17:11:35 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	davem@davemloft.net,
	edumazet@google.com,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH nf] netfilter: nf_log: validate MAC header was set before dumping it
Date: Sun,  7 Jun 2026 17:11:24 -0700
Message-ID: <20260608001124.309352-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296332-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E61EA651FBF

The fallback path of dump_mac_header() guards the MAC header access
only with "skb->mac_header != skb->network_header", without checking
skb_mac_header_was_set().  When the MAC header is unset, mac_header is
0xffff, so the test passes and skb_mac_header(skb) returns
skb->head + 0xffff, ~64 KiB past the buffer; the loop then reads
dev->hard_header_len bytes out of bounds into the kernel log.

This is reachable via the netdev logger: nf_log_unknown_packet() calls
dump_mac_header() unconditionally, and an skb sent through AF_PACKET
with PACKET_QDISC_BYPASS reaches the egress hook with mac_header still
unset (__dev_queue_xmit(), which would reset it, is bypassed).

Add the skb_mac_header_was_set() check the ARPHRD_ETHER path already
uses.  Only skbs with an unset MAC header are affected; valid ones are
dumped as before.

 BUG: KASAN: slab-out-of-bounds in dump_mac_header (net/netfilter/nf_log_syslog.c:831)
 Read of size 1 at addr ffff88800ea49d3f by task exploit/148
 Call Trace:
  kasan_report (mm/kasan/report.c:595)
  dump_mac_header (net/netfilter/nf_log_syslog.c:831)
  nf_log_netdev_packet (net/netfilter/nf_log_syslog.c:938 net/netfilter/nf_log_syslog.c:963)
  nf_log_packet (net/netfilter/nf_log.c:260)
  nft_log_eval (net/netfilter/nft_log.c:60)
  nft_do_chain (net/netfilter/nf_tables_core.c:285)
  nft_do_chain_netdev (net/netfilter/nft_chain_filter.c:307)
  nf_hook_slow (net/netfilter/core.c:619)
  nf_hook_direct_egress (net/packet/af_packet.c:257)
  packet_xmit (net/packet/af_packet.c:280)
  packet_sendmsg (net/packet/af_packet.c:3114)
  __sys_sendto (net/socket.c:2265)

Fixes: 7eb9282cd0ef ("netfilter: ipt_LOG/ip6t_LOG: add option to print decoded MAC header")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/netfilter/nf_log_syslog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 7a8952b049d1..ed5283fb6b67 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -815,7 +815,7 @@ static void dump_mac_header(struct nf_log_buf *m,
 
 fallback:
 	nf_log_buf_add(m, "MAC=");
-	if (dev->hard_header_len &&
+	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
 	    skb->mac_header != skb->network_header) {
 		const unsigned char *p = skb_mac_header(skb);
 		unsigned int i;
-- 
2.43.0


