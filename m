Return-Path: <netdev+bounces-284385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKi9EZvs+WkLFQMAu9opvQ
	(envelope-from <netdev+bounces-284385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:11:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D94CE361
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 688643018A86
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF60421EFB;
	Tue,  5 May 2026 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWjKTa32"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE2426ED1
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986060; cv=none; b=KyRmgXZYhx4vpDe0cwIvRRLPHg0CSypdGIhpdgYPsqKIwF9LABQAOuitdvL4+5m7Wrkv1H7lSH2iS3zWrkBkLaoR9Yk+if6FuMJKJm9GVwxEpDSuLe0mi/HXvIACTEzQLpQr1HBQYB1TFYwQC1tggoUAHx5v5HotatZwHsI3e3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986060; c=relaxed/simple;
	bh=rQBhSa3ETzBD4CsdNH0W29ieQ5iLuwRikv6sD50NxUc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T6KZx0iUQ54ylSM1jrXeQ9aY0MY970DjXTUCl96FoGuB+/lil2CGx2AyJjy8NkD/D2cbO0iy2aVg+DEUYAjdqb2In4gyuGm421NbVELtdkxe4yboyGDqrckXY8uWqs0ypPjZ7bukZj60SANyDNfO/0LyskIaYT4SUiXaes9ETmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWjKTa32; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7bd795b6288so51543067b3.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777986058; x=1778590858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RSayxUV0P2R6WIZjvAZmbbkNBuB5OopLok5vlbaS2Qc=;
        b=MWjKTa32hnq51sIDYCX163GkavORsD2lCjUJ+PLzrMlgCY5PYitn7TruNYQVb4Epcp
         Qobwy00m2BXyzffoM1HJYaiQdWI3p9l3QRgCiLmy1qCZG+7NYMsol5oCjIoVYnJlHeXY
         KixZ1rhuXoeNolE8qezJEDUDCfI1bFpk4EvOza5WWZeA6UchPBCiV0ARRPbxNyMwGf5U
         G/BgiMt5VRZXml1xyq66UUyEb5vwamrKqU/JZjdQT5wQjQIHY4H5hw7tqMsB8T/tdMUa
         N/7CaiJL6d1+tDRJHASUp7oRpM2C+0XBDY/DOzVA923rcA7iv4wWC9bu5NqFx3ipkVJi
         dphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986058; x=1778590858;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSayxUV0P2R6WIZjvAZmbbkNBuB5OopLok5vlbaS2Qc=;
        b=aRV+G38GLpu+oOWNOdLkEvqlT/7qprcZxTYshqRR8SDgwOguFugQvgPAMQrcsVJXmc
         pM7wWLcKj1BtJQW3lW8NWFhig/eMKugeZWABe66Qgi7H55sFxpWYEUJfHIB4N9zZkMJ4
         Su9cb+ewF9xIy9zvwOl3vLVs1VYVGE5rkLl+AK+45+jyFeKqQtSSHPcBGmZ/sV5NcBtM
         lEIZbzw39/uyvzQW53G5Gkx8omr48pUt4Zp/YK/gc7tIV8liMkWXv9w7tJZ5YYNruIpI
         n5YE5GchCHcjiNWWXGnRIW3LOxAMg4Kb2snOEsc1rdF/br7PY2SWN/5UoziRauTsfe4Q
         bFHw==
X-Forwarded-Encrypted: i=1; AFNElJ901QhJty4+X48HG13b9D2FBytg6svjV/jidE42xZIDFOMBexpZdPwicxbkFFjBLeUu/Y6u/vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV9Z6KNvUH3O1mC8fvRwUIoKkTvrqTxvp7DaoqjIfv0PT7a5tO
	iPKLl4x2DJcRVSuAT5rAHPBc/V1grouusDgs8x+ouA9JVfjmv/0/aL3SEX6YcWPwoKb8rIV9vUf
	fE6vqjYFbzB3PYg==
X-Received: from ywbcl30.prod.google.com ([2002:a05:690c:c1e:b0:7bd:5d13:538e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6086:b0:79e:c253:f723 with SMTP id 00721157ae682-7bda8dcac2bmr31548877b3.34.1777986058117;
 Tue, 05 May 2026 06:00:58 -0700 (PDT)
Date: Tue,  5 May 2026 13:00:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505130056.2927197-1-edumazet@google.com>
Subject: [PATCH net] ipv6: fix potential UAF caused by ip6_forward_proxy_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 448D94CE361
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284385-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

ip6_forward_proxy_check() calls pskb_may_pull() which might re-allocate
skb->head.

Reload ipv6_hdr() after the pskb_may_pull() call to avoid using
the freed memory.

Fixes: e21e0b5f19ac ("[IPV6] NDISC: Handle NDP messages to proxied addresses.")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_output.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7e92909ab5be3f86b10bf9527e97f3bfe794e9e9..aee91ba04130527ceb19881dc1e7232a5d2c8580 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -468,6 +468,7 @@ static int ip6_forward_proxy_check(struct sk_buff *skb)
 		default:
 			break;
 		}
+		hdr = ipv6_hdr(skb);
 	}
 
 	/*
@@ -582,6 +583,8 @@ int ip6_forward(struct sk_buff *skb)
 	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
 	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev)) {
 		int proxied = ip6_forward_proxy_check(skb);
+
+		hdr = ipv6_hdr(skb);
 		if (proxied > 0) {
 			/* It's tempting to decrease the hop limit
 			 * here by 1, as we do at the end of the
-- 
2.54.0.545.g6539524ca2-goog


