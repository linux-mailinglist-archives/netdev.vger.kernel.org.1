Return-Path: <netdev+bounces-255257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNltLuwdfWlQQQIAu9opvQ
	(envelope-from <netdev+bounces-255257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:09:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 715FCBEB3F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57D94306D8FE
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE6038884F;
	Fri, 30 Jan 2026 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fc8IMgoy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8E38884B
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806993; cv=none; b=Sr2HwlayQ21gkkrA9U6enOxL24amOeNq39iuo4zZjRtYbSkDFNY9N/KSWGY9DnKJ51vonFsoqbZHYGmWx/MKjoIHS49O5FKpoEFxGMSqdPDWgwuC9Ct8SLVXSzOFjZtlEtuLmbZDS6s2rG8bXPCCrYydFnr1L8PMQ0+6Jl0O8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806993; c=relaxed/simple;
	bh=Y9b/jODNF5fXCx/FUcTOqKUodQaWqzwF85jHPmS68hk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AZ1e7ud91ONuPg6u7mTj+4lam08v2azv8xdzB4g5LUq1+9JAaABrCUM7SRgavgd91YH7r/MD9CabvlwriQsJ8SxaDc8zebpdZHbrl4Jc3S8tziRMWLmvL/mQZhcHfLCcnleCIiXNmpvPEBtO+Lq/zPEVOC3wIrVtacHVs1M55zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fc8IMgoy; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c70b6a5821so566601685a.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769806991; x=1770411791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mR9vp7V4NbWDJo35TU4fbEkZTIrnYaXU9aEJvrEzNd8=;
        b=fc8IMgoy88PTxw2kw1H3E/QDymd5t5PdmHgvh/UZDR/EYaxo6aACZuz2FxYeM4ehdh
         vZUgH6yaM1W6NZl1nEUIipQ86c4II5QYbMsHnxcStWCE4ex3RUPDbiuzXQqcYTxpccXs
         Mi2cGvBQdj9Iw6O1CdsdPOV5R0if7ZH3u48ZDd+hPGSmcfNl1lHIupikpw1Bi27cVAxL
         +XzjiweYi6CmHZE/xtQeKl+82k+ga9YsVjUeOQrb0QiLI5ayyVgUpSTCVXVluAt1DdNS
         ZwBxaeLZkLW2ExkyYpTAqEFM4B27AKIqQOtPNOBRn8XLI3r1CMivE+c+G1E+c4BttfMg
         z4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806991; x=1770411791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mR9vp7V4NbWDJo35TU4fbEkZTIrnYaXU9aEJvrEzNd8=;
        b=PFQGWQWi9APy8PLPUKT1hM0PERSM8j458pR69c3mG6B7Z7pYFz/7fTVyzqcyQFWb74
         tmpFouRdvWMqPdHH1b/F7zA8fsKq57qoVEZ9q8hgQZBE9n49WTBa0isCbRpZOiZUhDI+
         +Xb7VKM9mhKjZjkNYd/bo8KSkLzcYwoFNxWREztjhhaRiyZUeah3tgLyEYQ5fNlMMHNL
         Z5wptvv3PVdY6om4bFfToW0wbH6AOQNhYDB4LPO/ojoXrmaDUX/bOygX96/QHh4KMmfs
         LtLcPXHNyzvbgDj2SK1lfyBSdB7MHkFRCcb8mucsgYXInb9djLQTJiyc+viWioiSayRQ
         PVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcaEN2DWQ0M/5Nk1vg9UPjpPpr0OmdN53Q5/XS0Tp+Q7QetfnRYS9ZHHtSbBZ9AwgvRK2DiGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37U6NPiHcQL8cVvkE2Cbk/wiPoJOmYvtdabWqItv7boKM1nyq
	Cs2kiYMkNU/RLdT3u+ZdVsgjq+YgaV7y5T5hYdgzTmFGSoGcUG9UGfVxHMTAZv9Rw3X7732yivr
	Wv70BiIRVKt6EYw==
X-Received: from qknsu4.prod.google.com ([2002:a05:620a:4b44:b0:8c5:2681:83ea])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:80b:b0:8c9:eb6a:1659 with SMTP id af79cd13be357-8c9eb6a177fmr402034085a.9.1769806991038;
 Fri, 30 Jan 2026 13:03:11 -0800 (PST)
Date: Fri, 30 Jan 2026 21:02:59 +0000
In-Reply-To: <20260130210303.3888261-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130210303.3888261-5-edumazet@google.com>
Subject: [PATCH net-next 4/8] ipv6: use SKB_DROP_REASON_PKT_TOO_BIG in ip6_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255257-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 715FCBEB3F
X-Rspamd-Action: no action

When a too big packet is dropped, use SKB_DROP_REASON_PKT_TOO_BIG.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 279d4daa85c442eb3db8add1d97c57c1ffbe820f..4bb61265f1d8f870dbfd60bd22b8ab78828fb4cd 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -383,7 +383,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	ipv6_local_error((struct sock *)sk, EMSGSIZE, fl6, mtu);
 
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_FRAGFAILS);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
 unlock:
 	rcu_read_unlock();
 	return ret;
-- 
2.53.0.rc1.225.gd81095ad13-goog


