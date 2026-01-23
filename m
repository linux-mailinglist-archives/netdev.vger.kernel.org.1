Return-Path: <netdev+bounces-252989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMfhBucCdGlA1QAAu9opvQ
	(envelope-from <netdev+bounces-252989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 00:23:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8478D7B77D
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 00:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7523A3014430
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5861EB5E1;
	Fri, 23 Jan 2026 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lambdal.com header.i=@lambdal.com header.b="Z2Vk+9bf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9131990C7
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769210595; cv=none; b=ud4gJ9+ZMT+0vToMF8bJPb7T+eWtxVEFlATjsubpuMrE0FgLfbeOiiMvLUolqJtYRUCM4qTkErRtmtxNTU/GrzOTthf8sEn3C0tUIakpVjrab3K6Vp8xu+E4NY55tA+y/veSSR9YtOwX8J+7IjklAXHobvYKTMV4AL86Ia4RL2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769210595; c=relaxed/simple;
	bh=BkQqil8bjfDxZVp+2HM9b80FetkOvjmgnQ+03vEe5IU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=P8gnRRF7VF/8IK3Uk5pv+UEFiVwE6zA7MkRzIhIIstBvQi8/Q+drvDZo++G6RMk9sL6ALylRxT4ofu1Ys8zMjtEQ2NXhdkA7s2LgOakLyWJuk9Q+7KyCZeDJa/J3hB8zSKNlfthasUyGToA6HdKm4JiGRNFBWsDqt0f2bjuPWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lambdal.com; spf=pass smtp.mailfrom=lambdal.com; dkim=pass (1024-bit key) header.d=lambdal.com header.i=@lambdal.com header.b=Z2Vk+9bf; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lambdal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lambdal.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12336f33098so2778117c88.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 15:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lambdal.com; s=google; t=1769210593; x=1769815393; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkQqil8bjfDxZVp+2HM9b80FetkOvjmgnQ+03vEe5IU=;
        b=Z2Vk+9bfU6r0s4XJGzCVqBXjinKssEgYFLLFiKsQj5YkDvcA7Ahj61GC794jwjd7J2
         BiI6Kyl59PaXIjZ7l89P4i3wq3WBDKfQLQa3qBROrJk0v0D/2WGY+0jmrvuTj8xau4a0
         hktseEyX/eD87/3zf1IEaRvSjHqOXXOv2di3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769210593; x=1769815393;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkQqil8bjfDxZVp+2HM9b80FetkOvjmgnQ+03vEe5IU=;
        b=GuHZJI3Ayni+OuggzKE00+bBtKZpA25zEt7hoDLdOe9XjEiNBjO2GiQsnvkvR/wHzH
         miESRogWpHEVfec0RKpMJ0+uG26/JTZUNQSOG7LM2/ufN10anwf552MUhG/B1ec9nu3+
         EakF0N2lEjKPt8fU7E7paXa0XlQ0D3h+qNy+mY1OpiKOy6qaaOgZP53Juh3qWHHiaiDn
         cGN1YPBJu9yuL2Cf6gEBvIL6rVrR/tjpqA0pxx4qgI1JBz+mGx7ovc8508eNJZrGPzxi
         SRscU2Jk1sl6wah7S8B08NpI4m04cWxEFJceexfl12L+cM2VmfuAtR6w2OXUTKbt9cgF
         6kxg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7SDZhKdHCJcWH25R4xjfvuOIXaJooRzJ8M0fng3y+BFDDYmfmTXxvD2fC/onU6lAsl2ubQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF7ZSZUElWYG490Ow1kEmT/YgjzYQvzQe9cbsnT98K5z3Q5+7T
	VqJB2VJrAN4itzGDojsfg5RdYn5/yH8ubCh3DLHKHssFjalGaXYb6YDFwb+buhhFrgc=
X-Gm-Gg: AZuq6aJqqrtmCGykDuqm8lLMrSgyiERs0bSQjsw3+vArhD0FAjV8J00NT8UNxM2QgRn
	vBB3eMueV+2UeNPulz75eDQcuiSwfXmOj31sY6JAuQNa/QK/xaRYArzFnGny7c+sxhOvR6/pNuG
	QFGZzgxfuECcn7LkTjuiTvadua2MTWQj5XK8WLfb0B1KUSc+lr7edTLJk+oLpUKg4wCOVMG98t2
	YABGSKgLCQJVwrXKtZ93NZ2lz8kLfU4Ad7BRa99b7lwG1fr1xTz9DARHK41Y6Y1UN/AukA+OgCC
	NilL8SOyP68RVPHkaQpik5kYUvSU7FcNzRO324RI30/BsxEfY5Ri7YmQyjSYi93N5PgZBWI9Tr/
	ukUAJfR5EdAlk7GAEUt/0IaKdSR7bQcFCCuRDyFY1QcZzM+ut3P9foVJHgxkuzljdC/agM6PFcH
	Iu7iS++9pxtid1s4llhQuerofmYtSWbdGt/2DM2mwYh2PuKqtQ5K41coRQouUnKuTh+SRB4KSi
X-Received: by 2002:a05:7022:68aa:b0:11a:2e9c:1130 with SMTP id a92af1059eb24-1247dba9487mr2375660c88.7.1769210592700;
        Fri, 23 Jan 2026 15:23:12 -0800 (PST)
Received: from [10.100.9.95] (LAMBDA-INC.bar2.SanFrancisco1.Level3.net. [4.15.73.186])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91c541sm6261819c88.7.2026.01.23.15.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 15:23:12 -0800 (PST)
Message-ID: <ecb0ffd9-4a1f-4579-bff8-264aedb5bab1@lambdal.com>
Date: Fri, 23 Jan 2026 15:23:10 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: davem@davemloft.net, kuba@kernel.org, jmaxwell37@gmail.com,
 dsahern@kernel.org, linux-decnet-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bilbao@vt.edu
From: Carlos Bilbao <carlos.bilbao@lambdal.com>
Subject: [PATCH] net: decnet: fix build error due to incompatible pointer
 type, in dn_dst_gc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lambdal.com,quarantine];
	R_DKIM_ALLOW(-0.20)[lambdal.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lambdal.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252989-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,gmail.com,lists.sourceforge.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.bilbao@lambdal.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lambdal.com:mid,lambdal.com:dkim]
X-Rspamd-Queue-Id: 8478D7B77D
X-Rspamd-Action: no action

Update the signature of dn_dst_gc() to return void instead of int.

This change is required because the .gc member of struct dst_ops was
updated to a void return type in a previous commit [1]. This leads to the
following build error:

net/decnet/dn_route.c:132:10: error: initialization of 'void (*)(struct dst_ops *)' from incompatible pointer type 'int (*)(struct dst_ops *)' [-Werror=incompatible-pointer-types]

Note that dst_alloc() inside net/core/dst.c was already updated to
ignore the return value of this callback.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=af6d10345ca76670c1b7c37799f0d5576ccef277

Fixes: af6d10345ca7 ("ipv6: remove max_size check inline with ipv4")
Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
---
 net/decnet/dn_route.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
index 729d3de6020d..840a0e3852de 100644
--- a/net/decnet/dn_route.c
+++ b/net/decnet/dn_route.c
@@ -100,7 +100,7 @@ static const int dn_rt_mtu_expires = 10 * 60 * HZ;

 static unsigned long dn_rt_deadline;

-static int dn_dst_gc(struct dst_ops *ops);
+static void dn_dst_gc(struct dst_ops *ops);
 static struct dst_entry *dn_dst_check(struct dst_entry *, __u32);
 static unsigned int dn_dst_default_advmss(const struct dst_entry *dst);
 static unsigned int dn_dst_mtu(const struct dst_entry *dst);
@@ -208,7 +208,7 @@ static void dn_dst_check_expire(struct timer_list *unused)
     mod_timer(&dn_route_timer, now + decnet_dst_gc_interval * HZ);
 }

-static int dn_dst_gc(struct dst_ops *ops)
+static void dn_dst_gc(struct dst_ops *ops)
 {
     struct dn_route *rt;
     struct dn_route __rcu **rtp;
@@ -236,8 +236,6 @@ static int dn_dst_gc(struct dst_ops *ops)
         }
         spin_unlock_bh(&dn_rt_hash_table[i].lock);
     }
-
-    return 0;
 }

 /*
--
2.50.1 (Apple Git-155)


