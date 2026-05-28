Return-Path: <netdev+bounces-292662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9KTrNhcjGGoJeQgAu9opvQ
	(envelope-from <netdev+bounces-292662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:12:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAED5F1187
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A90E3011049
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9143E3E00BB;
	Thu, 28 May 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZqdbQHA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2E3D3317
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966739; cv=none; b=CCxX5s67ZddfKHsMEsei3cIpG1rOA5IDTG0VSZzMT5yFdy1Zw7emI9n3Q7DJuTN0TmW9mQ2lFNRL8jtKL5d+6lmhj99NZc5+ZKONFLWmr5cBZJansu/sFMDNYIswnbiAjhWyVGYd9DWVc3DH9aLxHhnvb2u1InnKBC5vOz4lvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966739; c=relaxed/simple;
	bh=b4yzUYDgsNnna6cksjHB3xOq3uPizKotCCHRLJR2qVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DzGo9gG7yUlM7FwEUOzIa84cVuI8TQy2mzU/Pdt4HgmpNNMb1LIA+rrvgN98+E2qeiTN2sxh1R8/LliZJ1E7CYIPWF6KlWmk5nUblU9yO0c7LsBoS6VwAfg1qIZ2TsbYX2JfCRWfSit5qHgXsNaXxU+6qENZ01zPDzBaA2QLxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZqdbQHA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bccb978bd9so77063745ad.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779966737; x=1780571537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqc9nveU7NUU23u0mW5oSotuBU5xhBDBx8BbOpvmxL4=;
        b=aZqdbQHA78YL6Yapz/v4sSCIHsooUknz4CwhbqAjxVc2UZpYUGy8BSxy003crU7Ia/
         JkkAbrtngt2ZH2bQxcZ7DImFrESJtO8U0ow4IKkWGzFsa5TRsbWbJikLuMSqqIS3xsrN
         H0+GiN9RBm4+tTdvuAYNYtU+MaV57Gsq2APK7Anu1wJFLMdCVFftGE8rnqeaisfTCyC2
         abFy/uuMw8CH0uzgJfNMbyw+FWAoapHRKrVQiNAjkiSI63pQBgmRKZ7MnN5fhj5vTJhI
         pa6KZnPsk+vdvSX++yxnSufyifMOhTHeYc5ucX29P7rGGu2VKPEJw2EWWPP30zX7ywBB
         8oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779966737; x=1780571537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqc9nveU7NUU23u0mW5oSotuBU5xhBDBx8BbOpvmxL4=;
        b=RryDmou6SpAV/XRRN2Tqp1IaiHC9ZOPOl1FRHRzvck4kY+QVH/EW5aVt3dDe0C/EVc
         XdGaukNd7ZsGUJNX2YTu1uAe7rwuSVpwQJcTYcGlzKvcMgsajiffReZg8FeMCJuG+aw8
         Go/x5k7sw4Z9Lny2LlVVoj88WUJCUMjP5swwirNc4DBG4eDoihcfsKChUcBi3vWZMKn8
         Cr0r34Of4NIx0PFkDmlgc9ebpqwc4z1D+ikK000KoRB8j/bpK9IsoqVs6GAM8ayeOtiV
         xZsnkQ5iEcbnt798gzA2/hPba24sfGMtbGgAerQ/eD/tvxvuCuSOCJ1RX+AM79PiPQ4m
         1QpQ==
X-Gm-Message-State: AOJu0YwMK18P/GkxDHOg70ftgko28BtFs9zRBx23ZvLqGhugoT71MWgS
	ZLhYxl7FqB9C1mczKDClefIRvw+ihYo3kbLQsT6bSMtPKC1k7KHTpQIj
X-Gm-Gg: Acq92OE3B4UHBjH+4JFeLrIhwNiiDQTQfw+ymN2DgcKTTvAWwiRajYAfVpw5ThOI3Yz
	gMlXGsWEPmQhK3l7uFf2v9ZvBTSNsSbU4dQMZ/DF9hefYrlAyFklvUb97m1lLuBdxzRCVBF2sdn
	Ze4kPtcgMjcgzhIoXSANh+T1mEp/LF0mVf3I0hc/M+eYRA5e5jB1Hsx0z7nzp/r+vkolPv9Jcro
	4auQYAC1R4YB0GkpP4UToDiRpnOm74REyPTwMHYOcLSM3bl9cfSL32j97Lt/zfi90Ty/bAR2iDy
	tmCG1KXJOTYLNWiqKUdAYI7mNPYjLLPhHq/r9PYKFAiO7bSPBywqK3RdEkWg8MfKyCKP1W10Vbm
	f9oPPNuyA0z9EszryWTVzxfaZrdehuo+6Fl1XIYo1JYTSMhXiql6fsgqTIhQtUZR7q6zhVaxdQb
	Mwfw4nJgt6zh/p8KWCpTPhO7GrBBsjTmg0C/QZnJEdH9ub6LH/6a8zyys=
X-Received: by 2002:a17:903:2acd:b0:2bd:6327:b507 with SMTP id d9443c01a7336-2bf10cc81a1mr10828205ad.18.1779966737321;
        Thu, 28 May 2026 04:12:17 -0700 (PDT)
Received: from teatimelab.tailcd024.ts.net ([192.129.190.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5924211sm162946435ad.84.2026.05.28.04.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:12:16 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	horms@kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH net] ipv4: validate ip_forward_options() option fields against skb tail
Date: Thu, 28 May 2026 19:12:04 +0800
Message-ID: <20260528111204.482401-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nvidia.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-292662-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5AAED5F1187
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip_forward_options() re-reads the RR/SRR/TS option length byte
optptr[1] and pointer byte optptr[2] from the skb on the forwarding
path and uses them as indexes for 4-byte writes via
ip_rt_get_source() (and a memcmp walk in the SRR branch).

__ip_options_compile() validates those bytes at parse time but stores
only the option's offset into IPCB(skb)->opt.{rr,srr,ts}.  An nftables
FORWARD-chain payload mutation between parse and consume can rewrite
the bytes, driving the indexed writes out of bounds and overlapping
skb_shared_info.  With optptr[2] mutated the write can land in
skb_shared_info.frag_list; the next time the skb is dropped
kfree_skb_list_reason() walks the forged list and frees an
attacker-controlled pointer, an arbitrary-free primitive (R15 below
is the corrupted frag_list):

  BUG: unable to handle page fault for address: ffffed10195fd757
  Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:kfree_skb_list_reason+0x167/0x5f0
  RAX: 1ffff110195fd757 RBX: dffffc0000000000
  R15: ffff8880cafebabe
  CR2: ffffed10195fd757
  Call Trace:
   skb_release_data+0x565/0x820
   sk_skb_reason_drop+0xc1/0x350
   ip_rcv_core+0x7a8/0xcd0
   ip_rcv+0x97/0x270
   __netif_receive_skb_one_core+0x161/0x1b0
   process_backlog+0x1c4/0x5b0
   net_rx_action+0x934/0xfa0

Bound optptr[2] within optptr[1] before the RR and TS writes, and
clamp the SRR walk to the bytes actually present in the skb.  Match
the existing error handling in this function: skip the malformed
option in place rather than returning, so the single ip_send_check()
at the end still recomputes the checksum for any option that was
updated earlier.

Cc: stable@vger.kernel.org
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/ipv4/ip_options.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index be8815ce3ac24..36a4e3cc39dd1 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -544,18 +544,26 @@ void ip_forward_options(struct sk_buff *skb)
 
 	if (opt->rr_needaddr) {
 		optptr = (unsigned char *)raw + opt->rr;
-		ip_rt_get_source(&optptr[optptr[2]-5], skb, rt);
-		opt->is_changed = 1;
+		if (optptr + optptr[1] <= skb_tail_pointer(skb) &&
+		    optptr[2] >= 5 && optptr[2] <= optptr[1] + 1) {
+			ip_rt_get_source(&optptr[optptr[2] - 5], skb, rt);
+			opt->is_changed = 1;
+		}
 	}
 	if (opt->srr_is_hit) {
 		int srrptr, srrspace;
 
 		optptr = raw + opt->srr;
 
-		for ( srrptr = optptr[2], srrspace = optptr[1];
-		     srrptr <= srrspace;
-		     srrptr += 4
-		     ) {
+		/* optptr[1] (option length) may have been rewritten after the
+		 * parse-time check; if it now runs past the skb the option is
+		 * malformed, so skip the source-route rewrite below.
+		 */
+		srrspace = optptr[1];
+		if (optptr + srrspace > skb_tail_pointer(skb))
+			srrspace = 0;
+
+		for (srrptr = optptr[2]; srrptr <= srrspace; srrptr += 4) {
 			if (srrptr + 3 > srrspace)
 				break;
 			if (memcmp(&opt->nexthop, &optptr[srrptr-1], 4) == 0)
@@ -572,8 +580,11 @@ void ip_forward_options(struct sk_buff *skb)
 		}
 		if (opt->ts_needaddr) {
 			optptr = raw + opt->ts;
-			ip_rt_get_source(&optptr[optptr[2]-9], skb, rt);
-			opt->is_changed = 1;
+			if (optptr + optptr[1] <= skb_tail_pointer(skb) &&
+			    optptr[2] >= 9 && optptr[2] <= optptr[1] + 5) {
+				ip_rt_get_source(&optptr[optptr[2] - 9], skb, rt);
+				opt->is_changed = 1;
+			}
 		}
 	}
 	if (opt->is_changed) {
-- 
2.47.3


