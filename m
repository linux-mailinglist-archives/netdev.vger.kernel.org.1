Return-Path: <netdev+bounces-304251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WAELLXywRmqzbgsAu9opvQ
	(envelope-from <netdev+bounces-304251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:39:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EDD6FC2F4
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:39:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ObD/bg8p";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304251-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304251-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A93BD32C11E0
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74023A48D9;
	Thu,  2 Jul 2026 18:05:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9814B39A079
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 18:05:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015530; cv=none; b=dASc1pRSrgE+RTn4B71tX/Vi8CYRCoLk6xQXSmWSREXDTlbaWsL5wmGCFe4NsldSwPro8+ZGFvMcOJ1OEs3E0JzOc4YOPSbFLa5AUOsdsa45rQ/BSVaj0qVufS0KJZD67RgrDAeAcnIX3CL14rQIsJrVnaqLx8RLs+zRgU5ACns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015530; c=relaxed/simple;
	bh=CpF/+ZkhfLaqd+Qm00Pw9dFR1GigXcDjVgN3qQ1kJPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d29R/MayVuf8EJ8dsvu9ROQ+uxRiM77IBLofK1s3+dfp49ZJPHdQW9sNYfNSH0aKz0WuWwsLPngO3Pb39G0yFOsOMZpu919QsYXuUbKDyovco08+cw4w2XNer4iDSn1eo6Dsa00YgkE2vXK9WDv0YeiM+C3dN6slSMM9fevX17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObD/bg8p; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-845e363246aso1967126b3a.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783015528; x=1783620328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTjUs2y9goRcZj8GKlJQUGr0p6xKvzwQaEafBMRd3lo=;
        b=ObD/bg8p9bFWU61fEkUCX2uJ4me158v9ITALNnZ5GG7HLKjP2g2YumTURXfT0/cY42
         cFNe+xKBkG0LGO7ZOEKK8ns8gQ5/k40OfuJ00M0v3RIw29gNlSSKRLyQg2L1xWm6sE5B
         tyKC+Q4QDSh8RQqSfUU2jMGmeybpfkwZC9Asc6gWytao47xB5P07O5mCja/A6R3ZrdxB
         acYKpqzvpC9FAApCVZledyB3BIJ/713bx055eiJUzFxNfcq4L5Mr5omrp4NVNpAvTf6B
         FBHi6EdrH5aO1AOkZZiNHRWumQaAKqoYXCb1dlt1y3/csKyV/Kx5pbwhXVqzp7NuO9g8
         RBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783015528; x=1783620328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jTjUs2y9goRcZj8GKlJQUGr0p6xKvzwQaEafBMRd3lo=;
        b=klZZkAuzYQC5wfAWiUmVoJkZql3i8adGbNBotSgYxuduIXSsgg2aD2Lk8h7Bomno3M
         DhsDs2CfaZO4URFLls07dbOHAdkd6hZUIcq8MZOQz4qengCrz6lS4gJ1QS4UUrmhIrit
         eGkWqh5VVrylpDhkJFgOTGfXUxMxLGkYLzXUvlbp8eL3WFLy2NPIkCVx69rtYHzTUd6a
         sRQ8JanP3PyG67SLrKWUfYfOm5aNCVQTtnDjhJvm+fY6O+Bm0UEn/W0CaZLp58d7XwJc
         HTO4OGtVEwrlwnWTg1ZzjO/5B8Q6RJL4QEZHuZFjyCdVb3WGtts+M0Mn6xXplUZ2IA8/
         Ep3w==
X-Forwarded-Encrypted: i=1; AHgh+Rq8Xa7gyPKMm4CrT+VIl4Dp7Iwe5OnF5mfS2JJ8Z45M2cbDhoVLHXYfo9PESJhAv+rOzn2yTVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoj8xW2sEkSWIGgILcnixLdkFDAFVfxCw2+/t5oOjtcwgzf3sN
	9WMgvDxF8NaS3wrGBSS8Y+3esCWDAsC9pRmtribNnAtgF0s6VBavckqT
X-Gm-Gg: AfdE7cnrdma24dd4lCvBe6pxmPwiTFKuu23clsEQFqufQTe1tMFCeg6u2qLj0wHl27o
	PkWMKGlpaP/L4mnIvfSVLZnpMwPoxGllh42TLgKMKH3rnBYwVFBstoDqn9Xd8jYEpRbINl5zd4/
	Um+FS58IiOXV/meGdh5oOGu2qlk52isZuWiiAP+aKg8RQj7iK66Zt8eVK5OLYf1Em2fAZGGI16b
	a2SLG/Kj5VVQ5DcpaRrIbSPkC78z3UcvmlPY4hLkG8pw6SruhTssF/feO6x8X1DBh7t96XQ/Klw
	fgBvtxjoZcl3xODbIcC2ZZfZffXRypr7AWxmSrT7zIeIw82JD9eAZj5tWD6hDirtPeijU8ooyRP
	7cLwkS7tPz3M/ivdkpBHCl1c9T9mW8/xex3Evz61IVYvmRW+O5jR/fgNpbG87kwLrrM/99XMgMq
	UptJfN4cehaGzkS8mR5P/C+nJpfyk3StGYUVwMcw==
X-Received: by 2002:a05:6a00:2a0e:b0:847:8d2d:712f with SMTP id d2e1a72fcca58-847c0678924mr7094180b3a.10.1783015527818;
        Thu, 02 Jul 2026 11:05:27 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78d69csm1701877b3a.25.2026.07.02.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 11:05:27 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] octeon_ep: fix skb frags overflow in the RX path
Date: Fri,  3 Jul 2026 02:05:17 +0800
Message-Id: <20260702180518.2013324-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702180518.2013324-1-maoyixie.tju@gmail.com>
References: <20260702180518.2013324-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304251-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vburru@marvell.com,m:sedara@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ntu.edu.sg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18EDD6FC2F4

__octep_oq_process_rx() builds an skb for a multi-buffer packet by adding
one fragment per buffer_size chunk:

	data_len = buff_info->len - oq->max_single_buffer_size;
	while (data_len) {
		...
		skb_add_rx_frag(skb, shinfo->nr_frags, buff_info->page, 0,
				buff_info->len, buff_info->len);
		...
	}

buff_info->len comes from the device response header
(be64_to_cpu(resp_hw->length)). Nothing bounds the fragment count against
MAX_SKB_FRAGS. data_len can be close to 65535. buffer_size defaults to
about 3776 on 4K pages, so a full packet yields about 18 fragments. That
is one more than the default MAX_SKB_FRAGS of 17, so skb_add_rx_frag()
writes past shinfo->frags[].

The fragment count is now checked before build_skb(). A packet that needs
more fragments than the skb can hold is dropped. octep_oq_drop_rx()
consumes its descriptors like the build_skb failure path. The same class
was fixed in other RX paths, including commit 5ffcb7b890f6 ("net: atlantic:
fix fragment overflow handling in RX path") and commit f0813bcd2d9d ("net:
wwan: t7xx: fix potential skb->frags overflow in RX path").

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
index e6ebc7e44a..bdbed58c7b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
@@ -453,6 +453,15 @@ static int __octep_oq_process_rx(struct octep_device *oct,
 
 		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
 
+		if (buff_info->len > oq->max_single_buffer_size) {
+			u16 data_len = buff_info->len - oq->max_single_buffer_size;
+
+			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
+				octep_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
+				continue;
+			}
+		}
+
 		skb = build_skb((void *)resp_hw, PAGE_SIZE);
 		if (!skb) {
 			octep_oq_drop_rx(oq, buff_info,
-- 
2.34.1


