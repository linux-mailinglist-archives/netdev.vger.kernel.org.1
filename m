Return-Path: <netdev+bounces-282059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB0mIVIP8WmXcQEAu9opvQ
	(envelope-from <netdev+bounces-282059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:49:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 267A748B595
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF4BE3001AEE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DDE39479E;
	Tue, 28 Apr 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DMLcBolt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54683859E8
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405498; cv=none; b=VFPCb9ctpnKzpVX/pkot1gILk7p1wMIUVU5z+BGq0d+iFwC29sjSGaOeRELXiQ1zfJh1ZcFYWqtt50BQQ2DEm9J+OUh6mcchohSTLgA9m8KpQwyLHG+N2zcdxqrfVZB/IsDEiBenOpjZ8wFvRt16LUJ91+b1cRJJ497vJHikV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405498; c=relaxed/simple;
	bh=6tMUE+TlTPj1V8R6KjBLE7d34lJZH6rAFsftHa30yc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sHsNApgNevc7V45iUswVFofVjL7k7h6BirbhwXCLS0cuEK4bHMrUPqEfScGwgWo15PEKxq+u2nBQKeI+WxvmueNNsKuKepDEymR1GlVrQEEbv4HY/ceiZ6v3b0pOH6JbfgwZ6mEWyf43Jb7l4T/hNGn72133TRRygA41f65hAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DMLcBolt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ba6838e76f2so1232568766b.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1777405493; x=1778010293; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A4ZiG93hj0iUkFRM02kykYZWo1+YWZxugAjFUMM5ORE=;
        b=DMLcBoltifURRkc51CymmsFKFuDc1xzLF5npAoN8kFLZ2ixtqiu8Z7t3vGlyHPQE4B
         qBzlFUT2bLkgUVwzQfMviZK7WW6XPJjv+Oui0iBDsMSBpkhlPOdto8bsGxopcQyn/Gyw
         M/xIuyfjfFC8uV3ZV7LkrxXQdMWGRTRn39cD/oRsHliDe/qTXuTJ9eJX7SuBzsgs7oDE
         D8tyiu/iVEQ0X/srVnitXAix+LmtQiWvz9AH5FL3xgWg1xgo/MNZ3qnL1GYIVmecPN4K
         wtDYrA9Co2HIkX57spIrPqtbuz/iu0d8DBBBLoYU2lOlJTqct4EPEL52/A+al367tiVk
         Hd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777405493; x=1778010293;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4ZiG93hj0iUkFRM02kykYZWo1+YWZxugAjFUMM5ORE=;
        b=GaZdj0/kKXyL44cIUwrwuMq96h7dnybtmTNcU+gB2suc865WZ5bOVRguEBydDZSsm8
         1UpQl8lrOz6ClI7EqCHRU0tUqycroOGZuFgiNYKeHsOcXuKpS2Ev9kl8lxBE4Plggi5l
         JfibChVsJ9NeS42VjpjHgk/Pl9OuMEJGL1Xi+O3zCiW5ZULqj8yhSfjtbxO0jMnzIPUT
         QBIXZcct1UDyMXGgLsU7pzw0sOzwVUVXhlHwyH2Yt5KXRahLZP/d/G+xNkaH4X37CUc0
         W3EpzC4v7Zq2Ej/1yxVSE+cbMcUQqfhVzMkVJFnC6HCaVqD5gZo5prt6t3fbvKcqf11f
         Hz5g==
X-Gm-Message-State: AOJu0YxmUKFzTN3GSgYWUdsOKySJfl0wht5T7BMeaIG8bZwFxCpmvuhk
	cbSNX9aJMHOKDkLvg2+Z+wIVoHewh9M+ywuTwXMesYorOvgbr5exSMgvBCFFFzuvbKU=
X-Gm-Gg: AeBDieuNdtSMsAp1vaSHfN/bqoOq/Wonwi5r1S3hq2Sbrmok/ztNyB2l6ZnP3UwJj1l
	1m+1szBp3LJoVT38CjopnprBavgQwp2eXAOYOqnqxRg3W8SDscKLVI6/Yxbeshi6NLLACGr268R
	P68kydXKkOfgu0VWJ1tPlOrBFNlLvG0uy1VM43ReFkAQWi1RR4hQRB+XMuhu5Bd+X934269Os3n
	4BtGjNkLurg93t3tZSenTL8qqd8RAtZ4hytWP2oqjQTvsFItU3Zh/p+D/Oe9VqtWgbvJEiQfuof
	hM7s5LNKsWSzk+CO8M8ZWNj2hcpE/qFYstQFzSTE81mLg/3C41j47JQQZ3jo978b+CNIHN97LiR
	cZlxDGOAlqG8UpErobGrH5S99ap+Vh47pB4ne5CoAWwLadq8uckDNr96rUFMKPnobaQhC4QWPaY
	Qga5ktjJndFkYLGlYrmrbGMNQziH03XZcTCHhvSri01RxO+ZLyriYazfwmK89Y4e6sxs/+SzCe8
	7+qGLjbLX0=
X-Received: by 2002:a17:907:3892:b0:b9c:2c55:3384 with SMTP id a640c23a62f3a-bb93e64d116mr53898266b.31.1777405493522;
        Tue, 28 Apr 2026 12:44:53 -0700 (PDT)
Received: from cloudflare.com (79.184.127.151.ipv4.supernova.orange.pl. [79.184.127.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb808a3588bsm144691366b.14.2026.04.28.12.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:44:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 28 Apr 2026 21:44:37 +0200
Subject: [PATCH net] net: Clear skb metadata before LWT xmit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIACQO8WkC/x2NywqDQAwAf0VybmBdal+/UnqIMdZQuyvJ0griv
 3fpcWCY2cDFVBxuzQYmH3XNqUJ7aIAnSk9BHSpDDPEUjvGCX13QXz3OmWlGL9moSqPlNzobFZ7
 wSm0/sJxDRwI1tJiMuv4nd0hS4LHvP9pHQBp5AAAA
X-Change-ID: 20260428-wip-skb-local-storage-from-scratch-9a1bdce705ae
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 267A748B595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_FROM(0.00)[bounces-282059-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid]

skb metadata is meant for passing information between XDP and TC.
LWT programs cannot access the __sk_buff->data_meta pseudo-pointer.

However, LWT_XMIT programs can call helpers that move packet data.
One such helper is bpf_skb_change_head(), which uses skb_data_move() to
move both packet data and metadata after skb_push(). skb_data_move()
expects metadata to sit immediately before skb->data. This is the layout
that commit 8989d328dfe7 ("net: Helper to move packet data and metadata
after skb_push/pull") preserves for TC(X) programs when skb_push() or
skb_pull() moves packet data.

The IP output path can run LWT xmit before neighbour output has built the
outgoing L2 header. For forwarded, or otherwise RX-originated, packets
skb->data points at the network header while skb_mac_header() can still
point at the old L2 header. If such an skb still carries XDP metadata,
skb_data_move() sees metadata ending at skb_mac_header(), not immediately
before skb->data, and warns.

Drop skb metadata before calling into LWT xmit from the IPv4 and IPv6
output paths. Metadata is not part of the LWT BPF interface, and keeping it
attached lets hidden RX metadata affect LWT skb mutation helpers.

Fixes: 8989d328dfe7 ("net: Helper to move packet data and metadata after skb_push/pull")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/ipv4/ip_output.c  | 2 ++
 net/ipv6/ip6_output.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e4790cc7b5c2..3295e043310f 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -220,6 +220,8 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 			return -ENOMEM;
 	}
 
+	skb_metadata_clear(skb);
+
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7e92909ab5be..734818463e07 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -111,6 +111,8 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 		}
 	}
 
+	skb_metadata_clear(skb);
+
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 




