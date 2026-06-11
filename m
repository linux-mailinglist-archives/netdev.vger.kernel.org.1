Return-Path: <netdev+bounces-297916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dEKuK8w6KmofkwMAu9opvQ
	(envelope-from <netdev+bounces-297916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:34:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C24F66E344
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:34:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="qGxa1D9/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297916-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297916-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E256302D0BB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E28349CFC;
	Thu, 11 Jun 2026 04:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E1349CC2
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:33:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781152422; cv=none; b=E5wlv8qDetF0EnYdFo+RZFSF3Ple7C4DJDv6rPrst2W5J1ymvMftpBnpHQWoqbq9tVlBcxXGt9yAMp1Vlzb1Ck0yzlPVwfgLBExR4C+vmh4O5WgpAwCwy/kPG+zf+FtDhO89GDi2A71tMXrTW15l7Mw7dPHFf+96DVaDt5ybQUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781152422; c=relaxed/simple;
	bh=1I8QxdKrCRUCW4iwYx12QJu9o2BPfXrulVxJ4CLW3gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lq7eHMfwvAQ+FMcx9lIVf+FKau8evqUng1hK4JJrfsb6igKQIAQou2MaWCYb1KloldISG+Lij/riAq6g9FrYoTxn6kyX0lwl8tWIE4EB8xhIdCgdx9lB1pdqusn6sDIzBsaEA5du6ieaiRIq/mhfFLXcSJCaM62VVMrkLBn95J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGxa1D9/; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf36a6905cso53694085ad.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 21:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781152420; x=1781757220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+34DITpYKqJD3bohFtBBR1rYgBIHRY/jTC+acVQfU8=;
        b=qGxa1D9/o9W+1vyYtP6Rz1zoAGZu2iNEm5IfGClffsHx8IWnv+H8u3ArIrmlvUAqCL
         O1/Brg/HVryCTss9ORYcxRysjQAolZqVyjHl2VrN3NlW9lGvYFlkjdEBisajGyHAZR3x
         4w1enDnKKP+5ytC1/rJR+73dF5gr/2fBMIcofwICbSHVyDVl1p6LBBtG9s/tMOm+KaPf
         0VMT9AD0auTJyaaQIeW+syfeQvAuHx/3dr3Ta3Pm1b2ez4KR1PTtWe3a5lpBNS9RWfum
         e8veOVen4zQa+J6xhDStL5n4HDvpfVoYe7PQqKBnuLYfAFxdM0tJwqFBJhZbAOclxBxn
         100Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781152420; x=1781757220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+34DITpYKqJD3bohFtBBR1rYgBIHRY/jTC+acVQfU8=;
        b=ES3d/EGOpRO/JlmZ14OE93eyTjJQZJStUfWVS0vYPPBGBFrCjaZmd441XlSvtDKlmO
         Ej6P+zgwXUR4UP1W8Fjwa7QMrpy6Qt+COPFrUTwtXvxLc6oYyrnooCIP6MW7BGyCJ6ZW
         bkoxzw6oeYcqw+WbTj6Zlfm09dVJFRVu/+vb3hQT6V7G8wwQBu5GCy5ovjyzwTFmUlFh
         97Z1pM0J3o4vrGVIK7D1a++dyJk+q3oYDKviQLXpTzf6aErHynHD/PNiS/4frHNkW2gP
         bkfpJJKdjBEDvcE9M1Uq++NfXMmxSJi9ZUVcG+UCBEseIyaXYBXUk1Ace69PN5MOhFcd
         HiKw==
X-Gm-Message-State: AOJu0YwinhwDCuLdZCA2RZwWuZfDco00rvYyef/K5bxQH7SSClLgRZR/
	+0p0AIjMsMjARSsntSYMQWTvwwMei2Xd6w4umuD++QxrY9lklzT0YZVh
X-Gm-Gg: Acq92OGWtuuoqDSnnIr7uTw5ilsiNNWoN2RlJNqmGVIF8jCD+pPun1/0kF5pPtc103n
	4/3kbEGlfgfh128kxA1XdSGANpHvmqKXPI0Kn8N7bOjgGpJ0pl2SdfuFgev3CUv46/0wNvAqZjz
	P4iWYPNXzE7EZsbfZiVpdtObNw9hGmf7Afbmhhk5RSzxdkr/VHrqElwUawY0EFfIvqgzd2pTl96
	UbBR35PnA8fSFsGoal9MN6EKasxvq5JsBmU0dj6vCcSWbCbFAN53LxvQuGvrnCLGNN0uV9QSxKk
	pTZruDOHkPuqslDiOnKAn+MbCX9IMstT0SqE7RyD2leQlBvQc3RxTNw5UAMAPq8+Xf1yOMCFJZU
	gpv7O5WoUp9j129gKl81CTqU57bFCdl9JZKAE2V6xlf7BwXEuIlcWp540Il/fC5m9vNnAI7PZIN
	aDH4NOyDaQO7RToHs1wMIhaPQi+jwKBlo9MoWbys5xE44BFyBAVzvC/oW08bdfX1oF0Woy1HDUe
	dQcMMRMiTxGUveNtKsZb+wTRUkJ8Il8wiBRuj4=
X-Received: by 2002:a17:903:3846:b0:2bd:8395:fedd with SMTP id d9443c01a7336-2c2f32549c9mr12465535ad.37.1781152420328;
        Wed, 10 Jun 2026 21:33:40 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([2a12:a304:100::109f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e05fsm270794455ad.54.2026.06.10.21.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 21:33:39 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	toke@redhat.com,
	menglong.dong@linux.dev,
	emil@etsalapatis.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf: Run generic devmap egress prog on private skb
Date: Thu, 11 Jun 2026 12:33:16 +0800
Message-ID: <20260611043317.512843-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611043317.512843-1-sun.jian.kdev@gmail.com>
References: <20260611043317.512843-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297916-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:toke@redhat.com,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:sun.jian.kdev@gmail.com,m:johnfastabend@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me,redhat.com,etsalapatis.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C24F66E344

Generic XDP devmap multi redirect uses skb_clone() for intermediate
destinations and sends the last destination with the original skb. This
can leave multiple destinations sharing the same packet data.

This becomes visible after generic devmap egress-program support was
added: a devmap egress program may mutate packet data, and another
destination sharing the same data can observe that mutation.

Native XDP broadcast redirect does not have this issue because
xdpf_clone() copies the frame data for each destination. Generic XDP
should provide the same per-destination isolation before running a
devmap egress program.

Fix this by making cloned skbs private before running the generic devmap
egress program. Use skb_copy() instead of skb_unshare() so allocation
failure does not consume the skb and the existing caller error paths keep
their ownership semantics.

Fixes: 2ea5eabaf04a ("bpf: devmap: Implement devmap prog execution for generic XDP")
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/devmap.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index cc0a43ebab6b..14506834345a 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -512,8 +512,10 @@ static inline int __xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
 	return 0;
 }
 
-static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dtab_netdev *dst)
+static int dev_map_bpf_prog_run_skb(struct sk_buff **pskb,
+				    struct bpf_dtab_netdev *dst)
 {
+	struct sk_buff *skb = *pskb;
 	struct xdp_txq_info txq = { .dev = dst->dev };
 	struct xdp_buff xdp;
 	u32 act;
@@ -521,6 +523,18 @@ static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dtab_netdev
 	if (!dst->xdp_prog)
 		return XDP_PASS;
 
+	if (skb_cloned(skb)) {
+		struct sk_buff *nskb;
+
+		nskb = skb_copy(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		consume_skb(skb);
+		skb = nskb;
+		*pskb = nskb;
+	}
+
 	__skb_pull(skb, skb->mac_len);
 	xdp.txq = &txq;
 
@@ -710,7 +724,10 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 	 * return 0 even if packet is dropped. Helper below takes care of
 	 * freeing skb.
 	 */
-	if (dev_map_bpf_prog_run_skb(skb, dst) != XDP_PASS)
+	err = dev_map_bpf_prog_run_skb(&skb, dst);
+	if (err < 0)
+		return err;
+	if (err != XDP_PASS)
 		return 0;
 
 	skb->dev = dst->dev;
-- 
2.43.0


