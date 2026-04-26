Return-Path: <netdev+bounces-281169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMXTAqgk7mn0qwAAu9opvQ
	(envelope-from <netdev+bounces-281169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:43:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9903946A652
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08C1E30146B1
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF43436DA10;
	Sun, 26 Apr 2026 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obqE+cH7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8814369991
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214593; cv=none; b=DKaOEBWW1uUnk2BqnTvE7AuwZ8ycX6kHy/BFuqS+mekclkipxoMZwGIvLl4k84LSEhvZiuWZAKakMOByivoBbdTLkZM9gUMsDn7WikrwRPK4MiwM9grRx902N8hGvYWs8jcWPhEWvPpQmWdXlVKYtu/CB/dOM26c8pkbmxQbOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214593; c=relaxed/simple;
	bh=iysh4N66Tl7xoc3UugBwoFjq1QevI5EVO8XIhrhB53g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmVkT6h1C2DPLQfS3+IClfUYHHczd32Nw+Gx6lju0SgUw8Eq2CwU0hUXFU0QDkdgyjSiIfUbYfuSUGG9CPybN/vWMMzD5KjgkYjWY7Z/lO+nshZGTCy2S/JVmNXYKuMOk+wRdviA5zZzW7hXAVbKNm86C93jo6vWXZ3p/9462BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=obqE+cH7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so59731485e9.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 07:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214590; x=1777819390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crl6zSnTLgudSBuh74XMca0YFvGlbtRGkF7ktfLkgrk=;
        b=obqE+cH7zX34c6wxqY1F42KTEbdgiT7Q4ziQ0OQF+Drrl6+PJ2B1Hd7HUdDXgY81q4
         ONPmvosjoq3ZInACpPQw8vdfTp1E7J0R0v0P5jI0eFZ+JeJorEzHkTwlF4I+QhGMGnuq
         /rAtArnjL1WxfdNyGpHQKnrjUKAzS6w3tuSnR4tTs48dO5X8kSqN++gYAM3kXGuhEFYy
         iXsXFTqgSUrVP9idxn/A33GBfu3eoJ5Sohz6qrveH4MTw5Ro+76LGo0HQedZz7WPSQST
         e0SR5Oajupr/hWvA+E39O5gY7ZhZUYZ+B2kEWMCajOXF6I3T95WMxhGABCde03+FWs81
         DQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214590; x=1777819390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Crl6zSnTLgudSBuh74XMca0YFvGlbtRGkF7ktfLkgrk=;
        b=TNKI1Kb4Z520Cs2vWyicRjYaSAYXIl3Cdsyu/ycLo4rhXe13po5Hjd+ycbRHHO1aQ2
         6CYPfwuwzpRvs5h0NsgBeK0OFsxDaqU9MQmcBcFlw0ADwbhoHt2uTkhLES3BPf/XCxl0
         0juZhgWJswBAzYgfRwTWl1SapFCcP0JfsozO9bodOr9G/quOxIeFFhrNYjPVnoYOSF7+
         /1n6T9cR+4odbXBQdV/XwR9hA27dp2pV+BnRbaFFRYagvcMGAmrOLVaNw/EZT5tTJybb
         4ce2np629cEZ3ogrdQWDg2mJm/otoAytZcid3N0WLls+cEWwjmoVc+6VFXs8iWX+ntk9
         fxlA==
X-Gm-Message-State: AOJu0YzzBcxfId6rV/1fjDxZTp8uu6NAOdbLZHgNjdl5f2SLLUSTm2XM
	jXyvbnRJvPGg3rF0vn3SITWmC7dcoGXH7GELW6z91T5fobweocfD+BoEeyrZ+w==
X-Gm-Gg: AeBDiev33j/OxcWRW2OHuDQbc+CNk4ysVKzLkKAv4sL+sKk2NVexCWuTM9iMyht2nsD
	4mYjNlQiJr3OZ0EwC/sx78opSNClEDP2YiHfh5TQW7onoyIiIty4aHa+RTFtiI2oTz11ja26Z21
	foSwXtG+srmS6zNAAryhD4YGzT+xdATahd7vbt0R+0v1ULc2MDxrKV33Zs+9skuCPyvRLCrsBbh
	yCFsZrGOCYR7bhhe2Rkfw7h7UPEGjHlznXH69TPYtpAyqlh4BUXcREQ9DgawMiKdGVLjoXkO2r7
	SB/P6Fbp/AUat/CBNq6B0iV8KWw1Nae5SLp2aePpL4AV3LY0acPJRMgu/7FSk13BUqB9vpcVLvo
	G00JcoDFHVPe6t85V9ryNznJOjhaMV1XKRUNGrHvqvmgWiokArYE81mTIdLFVB+OTr/CClmvZ/2
	KDV6rt/HDpi6AXWPiRPuBtOZcwOT3c2v9Vs3kOEsSj5NF7NxEPOwupEBzj7OjLldKIGH0mtTJgv
	7oNXvKP4Pr24ps/8QEEv8jOCg==
X-Received: by 2002:a05:600c:5254:b0:488:8bdd:cfcc with SMTP id 5b1f17b1804b1-488fb6e62a8mr600438295e9.0.1777214590130;
        Sun, 26 Apr 2026 07:43:10 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-366-193.w86-195.abo.wanadoo.fr. [86.195.82.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm658230335e9.8.2026.04.26.07.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:43:09 -0700 (PDT)
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: [PATCH net 4/5] rose: clear neighbour pointer after rose_neigh_put() in state machines
Date: Sun, 26 Apr 2026 16:43:04 +0200
Message-ID: <20260426144305.984349-5-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260426144305.984349-1-bernard.f6bvp@gmail.com>
References: <20260426144305.984349-1-bernard.f6bvp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9903946A652
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281169-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

After calling rose_neigh_put() in rose_state1_machine() through
rose_state5_machine(), rose->neighbour was left pointing at the
potentially freed neighbour structure.  A subsequent timer expiry or
concurrent teardown path could dereference the stale pointer, causing
a use-after-free.

Set rose->neighbour to NULL immediately after each rose_neigh_put()
call in the state machine functions.

Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
Tested-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
Signed-off-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
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


