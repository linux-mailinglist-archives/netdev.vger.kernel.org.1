Return-Path: <netdev+bounces-258774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ou2HHXakWlpnQEAu9opvQ
	(envelope-from <netdev+bounces-258774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:38:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE89513EE04
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D14A030115B1
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01CC2C234A;
	Sun, 15 Feb 2026 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5GTsMkG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5822DA755
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771166307; cv=none; b=c4qEpUmYzpsBD2MQ1ULpyYDrhLde8dr//o5zDlBsEois0IZgocdy7ma+2d88dGW/WMSzzeZz1K2sDIiNPaQxB3V1CWHW9IIFgaqi2kjJdy6pKyLqV3P/jHPTMjPIx1IdDFYl56J9awM4yjlNjeXGQKiuXo5T5/bNYGqsPtHDUvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771166307; c=relaxed/simple;
	bh=UPByaHYqhgtSWyyv7t7+b/UInadkg2EQnjWHBcbGAwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hO3fjnQFA/PAvvUhibS0JxB6WPyh8nYJ4EYH2R4I0u2DvxEmys1sJiP/MABz8VhviWKgSIS83iyzHFr6c/ldvvKGmtGN4EPMoaSUCL82NeS1EBozKSRxkx4k41vZQ4XBw8xnr6aorOceu5dZJobBIpR7TY8+oOyze/bWUvzf1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5GTsMkG; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb42f56c4aso1251383685a.3
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 06:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771166305; x=1771771105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RLUcxzfG/P+L6JhuOmSXXl/39/xLTcg4e+nAUP6rNvQ=;
        b=e5GTsMkGtAegaov3a3ypGWi9w2OZ3U9IKp4TWApUBvbaaLWC1PazuOa7myrTy4iqeO
         vXpugoN8zk3kOg7BMlDBj8sot/KN7fzgavN/w+Da3P09t/LTAuCO9khWAWDDa5mv0LzW
         606i5cSmVRdf+0LmGVVegXr38JZF6ieCA+NeixIbxPOx/nvHkjpP9a5TYYLPT4n2+/v1
         FRjnCJNjoEIyIGgLt7w2c+JTqw3xBviI8UAEuJscHCNAiYtXlCiuKPy+PKdggA2K4Wla
         Jvkj14N3GoCvyfcTrPtl/ZGP5K45VlqdmWBWUjSL37X8/WzyhlaQR6D6YNPh54MlPIDN
         VrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771166305; x=1771771105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLUcxzfG/P+L6JhuOmSXXl/39/xLTcg4e+nAUP6rNvQ=;
        b=xBt433GkbgJo9rPe/AzPPmU/mIWTE8GrwQNp9FEDZwbct6w1C/0U7dpKQxaJ4yqSm3
         fzpnAMlAW0oDfs+xMrNogZz5pxFE4HIgKg4hmsrtlnhsZSSVTPpF8b1tT1hV0CmFauIz
         b3SekjOWnMMTYnuLyNvaVDD8u/KlJabA6BVp7cajDesZ1Kj9+8FDwGJ6/Km2W4680n9H
         pszre2Wv3njL/zF7l2DjG2G3cxuVTaxHxm028WQXvzVGU9qYYDEq7dYyqXLIOZ2dYq0N
         cwfhFp7grOHdZS3Fec+3/mUNbHVmMvKTgBkBhhhkwAJt+7ItNp893m1xjJuuf9KeaX4T
         RgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9VquosSzPUUsrVeRRRf/2wFP9+NyF1/sXMcbDHxVuSR7qzeErtBaJMi3ZMZlGVbijDSqdiPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtekVG8zvilW+k0yPw+55HtBYN1ihiNFSLZ+3eGuD7Mgz1DOG
	krBIfJgkFTWxofGDfUSfPgmUrbUMyX5J5mM8trkh4mfUgzp6oViV5naQL4x6dAGJ3ds/NhR3rLM
	y87eWuztSqAve4Q==
X-Received: from qkps15.prod.google.com ([2002:a05:620a:29cf:b0:8ca:5ca:a250])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4554:b0:8c7:f61:fd7b with SMTP id af79cd13be357-8cb4243c329mr920052385a.57.1771166305191;
 Sun, 15 Feb 2026 06:38:25 -0800 (PST)
Date: Sun, 15 Feb 2026 14:38:17 +0000
In-Reply-To: <20260215143821.2330791-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215143821.2330791-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215143821.2330791-2-edumazet@google.com>
Subject: [PATCH net 1/5] icmp: prevent possible overflow in icmp_global_allow()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258774-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DE89513EE04
X-Rspamd-Action: no action

Following expression can can overflow
if sysctl_icmp_msgs_per_sec is big enough.

sysctl_icmp_msgs_per_sec * delta / HZ;

Fixes: 4cdf507d5452 ("icmp: add a global rate limitation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e216b6df633123ed475e28907d788db6bfb42115..eff8487c0aba8df0d1e515b9ac6ff7f9ac1de436 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -250,7 +250,8 @@ bool icmp_global_allow(struct net *net)
 	if (delta < HZ / 50)
 		return false;
 
-	incr = READ_ONCE(net->ipv4.sysctl_icmp_msgs_per_sec) * delta / HZ;
+	incr = READ_ONCE(net->ipv4.sysctl_icmp_msgs_per_sec);
+	incr = div_u64((u64)incr * delta, HZ);
 	if (!incr)
 		return false;
 
-- 
2.53.0.310.g728cabbaf7-goog


