Return-Path: <netdev+bounces-252470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNUwNvppcmnckQAAu9opvQ
	(envelope-from <netdev+bounces-252470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:18:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF646C367
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99AF5306791A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F536F418;
	Thu, 22 Jan 2026 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BbMOG5NA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578938F952
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102588; cv=none; b=VpiK+0CfJsLCh9N8RsD62yjUk4532RVBESqEavK439v8s9bJZ0D5gIuu9Bj88VkGOOXwQ6feTqeRDKSGd27LiDhKSjB9WRXzqIb8xcieS0dAhMlV+vb08QVF99g5XJO4v9hR6V4o3OltSxBngPraSo85kSaQECKgPO2VuZtAhdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102588; c=relaxed/simple;
	bh=rjYdmOARYUKCbI5Qykx9m5oG43v69ImKxPbYsMc4npQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jprb3ooGResjMvrg2SszoQ5LdIBYhdPWt8ItttCM1P32LpllIXlGyFPsa88aQvMvAt/+h9BJx1KnUVXr3tKGYGiIgBD2DBZaNsneeohr87VwvimfcpdT9ExiO73SfS2q8aabDcvgQhXMKcONaGY+ziqlgQqCbwtqtLjvvRqDe4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BbMOG5NA; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-894709fba26so11404946d6.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769102568; x=1769707368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s7zJQc+AxTIYgvm9+0VHPG8h2qnzjWI8vkIrEE1Mw0w=;
        b=BbMOG5NAMCHG1FRUxyERa8mYW9dL2d7W/lX+W46nzITzxBcpy06dt3EYgQ3v/XTJ8C
         uZwtQRy2SoLuperPmNEWl2FH/zfUzIQL5aNfGaExqyTOAxqF5x/4eNlE+EtyFwH741Gk
         tyd6baXGWvueJ0xr3LhEVzeNqp7RWQofKoTScJOQEmym/fxYO2csAaN0x81FRpUMQLd3
         qF1wEGxaYPxByqssWI92w+lc8o7+eaZENYwD8F5U+Jl05s6b0T81chBdU/B6GPPDBCH3
         SUERANCEfczSZUG1McPuC/0xHU/YSaQp+1JHBvzO8kBJnoixnDigr4idUx3QcUXqVCZO
         Aa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102568; x=1769707368;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7zJQc+AxTIYgvm9+0VHPG8h2qnzjWI8vkIrEE1Mw0w=;
        b=lygt9YPw1Asw3AgDOAt0uohWR6E3syFn7euyKGT67+VwGM8QGIy2OZzb3XBQsRFTVc
         WBm7xtR2LiarzgyLudRnDy75m0DkUxPdDmrG0yROEjBA2iwmCS3KXjUcSD/ZdfgsULYy
         yCY2zEES+6MeaHdqK5U7/odtR2m6a1O/LGY1p+LFBcWePdfwb+oF2XRKMeiPhi3qnRdU
         V9l7fw6j+TRCPTeyxHS+rjwS7y1PE4SGvcnP9csvE5En8mZYQE/8SwnOi6kCzkntbtU+
         Qe+6I6ZVUCEoBMqxaxQ4B+GU8YwJcgSHxIU6Vqcs+hkRgMNe8FOwmpN6phBfMWvmwGZp
         hJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM3Qj0pael2b0kAlZ5T6nd1P/MZWmfOXZuupW1pidp7uCnqnTp4bq5OWW+EURYaQYv0xgc/Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK509YOl283hsZvNZLwo+eh4dwvHHNhuBbT7qA3FeKtjSFVkZ0
	4atjdJsnEDXTWkgFVnr5FpolqHtB7FDz66Nr0ytOn2SQHOA5pdRLf+H4/qtarAHsKw+j52mMP36
	kbAgTeC7X9Wtbwg==
X-Received: from qvaa13.prod.google.com ([2002:ad4:5c4d:0:b0:88a:3030:630])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:c23:b0:87d:e456:4786 with SMTP id 6a1803df08f44-8949021f4cbmr2757836d6.45.1769102568410;
 Thu, 22 Jan 2026 09:22:48 -0800 (PST)
Date: Thu, 22 Jan 2026 17:22:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122172247.2429403-1-edumazet@google.com>
Subject: [PATCH net-next] ipv4: igmp: annotate data-races around idev->mr_maxdelay
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252470-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEF646C367
X-Rspamd-Action: no action

idev->mr_maxdelay is read and written locklessly,
add READ_ONCE()/WRITE_ONCE() annotations.

While we are at it, make this field an u32.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/inetdevice.h | 2 +-
 net/ipv4/igmp.c            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index 5730ba6b1cfaff25f2b9d206722662e1e62b88fc..dccbeb25f70141982160c776f3cc727296def2b7 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -38,11 +38,11 @@ struct in_device {
 	struct ip_mc_list	*mc_tomb;
 	unsigned long		mr_v1_seen;
 	unsigned long		mr_v2_seen;
-	unsigned long		mr_maxdelay;
 	unsigned long		mr_qi;		/* Query Interval */
 	unsigned long		mr_qri;		/* Query Response Interval */
 	unsigned char		mr_qrv;		/* Query Robustness Variable */
 	unsigned char		mr_gq_running;
+	u32			mr_maxdelay;
 	u32			mr_ifc_count;
 	struct timer_list	mr_gq_timer;	/* general query timer */
 	struct timer_list	mr_ifc_timer;	/* interface change timer */
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 7182f1419c2a4d4ea1e90ef6857f6af895dd2770..0adc993c211d7a3901f9a0e9ee816e7fddc598cd 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -227,7 +227,7 @@ static void igmp_start_timer(struct ip_mc_list *im, int max_delay)
 
 static void igmp_gq_start_timer(struct in_device *in_dev)
 {
-	int tv = get_random_u32_below(in_dev->mr_maxdelay);
+	int tv = get_random_u32_below(READ_ONCE(in_dev->mr_maxdelay));
 	unsigned long exp = jiffies + tv + 2;
 
 	if (in_dev->mr_gq_running &&
@@ -1009,7 +1009,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
 		if (!max_delay)
 			max_delay = 1;	/* can't mod w/ 0 */
-		in_dev->mr_maxdelay = max_delay;
+		WRITE_ONCE(in_dev->mr_maxdelay, max_delay);
 
 		/* RFC3376, 4.1.6. QRV and 4.1.7. QQIC, when the most recently
 		 * received value was zero, use the default or statically
-- 
2.52.0.457.g6b5491de43-goog


