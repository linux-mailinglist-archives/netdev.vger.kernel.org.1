Return-Path: <netdev+bounces-278158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UABjKSAr3WmVaQkAu9opvQ
	(envelope-from <netdev+bounces-278158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:42:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676083F19DF
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE8113020847
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6518F37703A;
	Mon, 13 Apr 2026 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzm7dxKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3D375F95
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102164; cv=none; b=hxVIPtMErhKwMsnW9UKeCfzCLgGbjM4wWDJQDWdrSzuHGLZtwBdJclK6AajzSoZjsi2kBtEWdmGoVDHkbhcnKuIzmhhs7fgY4CDd18gLRBhBF8VGfi9m2wCFfrkC9VrBqUBKXqPFYrgF9t2VAWm7Vw0+dFBSu/UWXfqBt6iwdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102164; c=relaxed/simple;
	bh=Okef0H2XLoZJimTraD01KekCXXBRlhJ2gzRinkt+xaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOUPKK93BHC9g71tzA4VLd6qtivme7/zN5uGgzxD3WuUCqOxbW4YLlcIqvqbKDLh3XEm2Eb8MrF27JU24oIyeyFv5KQNVaKBjo2HZCrRJz+sitn/h0MrckO5IszakiyRqmvVHVXNwRSZHyEzk8/mgkhDQTdqDhV89mkD//yc8lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzm7dxKQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488c2690057so45552505e9.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776102161; x=1776706961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLuKmq5rQDVkM792bx4uWTtwIM6ABqltLpbUK7BkPSw=;
        b=jzm7dxKQ/ZtcJkM/Gv+Z+Gc0M1uqVN9SloWTfzrdZrq8j37t8MgIRF6l22Q+cYLQGb
         zGQanMTBKypJcrLcjk40YOvogAMEeC5/Wn8WXH7cYwEte3c7oobzwUomdLClwRYDLWs4
         oTAGTKAWfVbYWC0XgK+wH2+Y6O5rX1rkYDr8Lft3VPiUNnalWNkK2dweWi5eDq7isB4x
         eW9PXhE8Sl3IfkIT3tCwbfFxUL6k6bw4WkdA8+u5CI4M5496hHMzjjY90pmqxlmrjzo3
         AGrn8bAITZ3v6TANZETszCTS3cCfka+fKY2FXrsUEvQHRGaoV4b1ouAd3K/7yiJNuVqC
         Vrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776102161; x=1776706961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nLuKmq5rQDVkM792bx4uWTtwIM6ABqltLpbUK7BkPSw=;
        b=oh2NtQ8TgxDmd99i82OVqSs4pzpOEU3ALeMfuzAKyXMpKGhBrEzI3Z7V4yw7o5RnoP
         gTj3TXUDcROlP8ERlmPTkzqCSADTKIy5LwBiMXXDBw2pSYiIPqPqvW4VLK7GJ5XvCk+K
         y5eqMxgFEO+LL4IMJLomSWG/HcjNSpaIi8B58p4L2pbFEqVNV63uISZqfpngOpGReABj
         LwV/zWsWubDOKqUHc97Vk3Wam7epAgD/FEu97Qogiv/ATxRulnQ9XTrPleoksbq5AWnk
         9MJMkZk1HcpR99z+DM7gZYNXzoO5uOsx79Zs34M9fhMSO98avHh49W75HuaqcffVKxJa
         wF2Q==
X-Gm-Message-State: AOJu0YwLSn2MsUhWs2EE/IXKAvT1fpkhv5dBcAMmexrqg2kJh8MabFyS
	uc9Et6Ym5iDL8FvhL8zLwFUvrF5AFCprBmvlgIEktGVJLwZqhTeUDRTi
X-Gm-Gg: AeBDiesbQpNZ0vRKrugBOR5iMd4Pu2Ga7HpwQqdZ2kvh1KunIIvW0lvA9ZW5ODpiKKs
	QCjANe/ueuhLLugWP+noJHLcHl/0IqjXiFzvchvMJfP4cd0b04BrI3aDucPeOQzEOsGlRRTxTNx
	ErBESQwQLTZGvpUiqJJRkZiSktahze0Og4mVE/7M3gLS+jGzIo5LD4cwGTU8Bmr0upehzUehH3M
	G3VCfcTv32FAlgtKYnkVy46y+2Y5pBFIv7jzAAeBa0EfuDXMPxKXIHv1j23B+RKZOSF7v1OJ8Op
	iXEU8wuKUGqesJk7qsgxlWcvuqqehn/r8YafpI/c1H1rl3MCR+crpHmsWPlkUr0bpefonCgZFbV
	BOy0391LsgJ0n1AtglfUKlbhrM6gjRhPoRQn0I59yvcl6gIfj3UhClhC4Enxeaemu+6SsMZOxnY
	5u3OLRg+K0kdOqsDh/WxPls2sq5+HKV+0JpHWq0DLRQQDyglDWSTPwuM6BLPTlAGccBlRazdkJC
	YYx
X-Received: by 2002:a05:600c:3107:b0:488:8b52:f7de with SMTP id 5b1f17b1804b1-488d6860930mr176985285e9.12.1776102161213;
        Mon, 13 Apr 2026 10:42:41 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-366-193.w86-195.abo.wanadoo.fr. [86.195.82.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50200sm34922778f8f.29.2026.04.13.10.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:42:40 -0700 (PDT)
From: f6bvp <bernard.f6bvp@gmail.com>
To: linux-hams@vger.kernel.org
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	f6bvp <bernard.f6bvp@gmail.com>
Subject: [PATCH net-next 2/3] rose: clear neighbour pointer after rose_neigh_put() in state machines
Date: Mon, 13 Apr 2026 19:42:37 +0200
Message-ID: <20260413174238.112418-2-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413174238.112418-1-bernard.f6bvp@gmail.com>
References: <5a88b747-bb06-4ebd-99de-80ceb574cf22@free.fr>
 <20260413174238.112418-1-bernard.f6bvp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278158-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 676083F19DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After releasing a neighbour reference with rose_neigh_put() in the
ROSE state machines, the pointer in rose_sock was left dangling.
A subsequent code path could dereference the freed neighbour, causing
a use-after-free.

Set rose->neighbour to NULL immediately after each rose_neigh_put()
call in rose_state1_machine() through rose_state5_machine().

Signed-off-by: f6bvp <bernard.f6bvp@gmail.com>
---
 net/rose/rose_in.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
index 0276b393f0e5..622527f1354f 100644
--- a/net/rose/rose_in.c
+++ b/net/rose/rose_in.c
@@ -57,6 +57,7 @@ static int rose_state1_machine(struct sock *sk, struct sk_buff *skb, int framety
 		rose_write_internal(sk, ROSE_CLEAR_CONFIRMATION);
 		rose_disconnect(sk, ECONNREFUSED, skb->data[3], skb->data[4]);
 		rose_neigh_put(rose->neighbour);
+		rose->neighbour = NULL;
 		break;
 
 	default:
@@ -80,11 +81,13 @@ static int rose_state2_machine(struct sock *sk, struct sk_buff *skb, int framety
 		rose_write_internal(sk, ROSE_CLEAR_CONFIRMATION);
 		rose_disconnect(sk, 0, skb->data[3], skb->data[4]);
 		rose_neigh_put(rose->neighbour);
+		rose->neighbour = NULL;
 		break;
 
 	case ROSE_CLEAR_CONFIRMATION:
 		rose_disconnect(sk, 0, -1, -1);
 		rose_neigh_put(rose->neighbour);
+		rose->neighbour = NULL;
 		break;
 
 	default:
@@ -122,6 +125,7 @@ static int rose_state3_machine(struct sock *sk, struct sk_buff *skb, int framety
 		rose_write_internal(sk, ROSE_CLEAR_CONFIRMATION);
 		rose_disconnect(sk, 0, skb->data[3], skb->data[4]);
 		rose_neigh_put(rose->neighbour);
+		rose->neighbour = NULL;
 		break;
 
 	case ROSE_RR:
@@ -235,6 +239,7 @@ static int rose_state4_machine(struct sock *sk, struct sk_buff *skb, int framety
 		rose_write_internal(sk, ROSE_CLEAR_CONFIRMATION);
 		rose_disconnect(sk, 0, skb->data[3], skb->data[4]);
 		rose_neigh_put(rose->neighbour);
+		rose->neighbour = NULL;
 		break;
 
 	default:
@@ -255,6 +260,7 @@ static int rose_state5_machine(struct sock *sk, struct sk_buff *skb, int framety
 		rose_write_internal(sk, ROSE_CLEAR_CONFIRMATION);
 		rose_disconnect(sk, 0, skb->data[3], skb->data[4]);
 		rose_neigh_put(rose_sk(sk)->neighbour);
+		rose_sk(sk)->neighbour = NULL;
 	}
 
 	return 0;
-- 
2.51.0


