Return-Path: <netdev+bounces-243043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E661C98C8E
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 19:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F7904E1B17
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D7C2309BE;
	Mon,  1 Dec 2025 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="CzucEcIF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281E227E95
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615529; cv=none; b=E6X+ENSI80B+b4lr1fRCDjcqZpXxwQL+VhMTjJWVB/Paj2h2jovV3LsD5tVZbc4TjyzqbcnrCCxdCzvk6/fW69Qo0dGS7j0oxodI6+y2IcsnkZzHZI5QCjgv03G5pb3Bk4MqQyf4oqLo8UWbLIMpvYYzHjbtvUPtpae+RkE4vy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615529; c=relaxed/simple;
	bh=LxZe4y6NDesyT4ZuqZ49czKQuadwCOp+c6lFY8C4xnY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xv4uiWhpM5v/3Z6pSrmK65NG7LEArCpJlhi0h4x5Q48PyCXotoFfQedM6kSHn8TFahOPiW+F0HWVqd3j3dz8kphg8dBWtzvWL5H6CXxGYTRMWWZcLZzg/y0S0h1xj0Qb3BAzjMNhSa62hHBmUblvF4qeXJSY9cgk/53mPKEevfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=CzucEcIF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso7343042b3a.2
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 10:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1764615527; x=1765220327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URmII7jnQ1SfDlK8MhSSV9UZBr6hS55RZ9tRyGm/UDI=;
        b=CzucEcIFYR/I8t960PDlXlGlC0z+STHgI9j3k2Js4jN1bn8f4S507EPLDK5SZIncM4
         vOgut9JIN5AyNiUo8vVZi+llFFBlTX6dcvyUil+2Emd27ovBXEqcVxgan4Op7XllQo8c
         OE1+GljLFCg8wzwhhMtcwcbjod317Ouft+yrhIAbxTT1KCAsrvLpdcMeldYeykP+TbHL
         FNPkClmQvZjoQfgbch0M2/nlXOY5VWkcNKI84P7754H7ljnYRDzPd+8f9ZNeEGTl3NxW
         zsRS0yCLI60e5hFQ1n5+7q2Bfd0SBpJNSM6BNgqnZM/fGqb5hbT6PNXRZ6MgmQWi7Rxm
         57ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764615527; x=1765220327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=URmII7jnQ1SfDlK8MhSSV9UZBr6hS55RZ9tRyGm/UDI=;
        b=skGZf9lTgGSOPZGn0UuamId6lNMejUq8neW7vlt/DJB0EssIY+IRLCitulHnB4ZHHD
         OsWeLrAJ9sOdf5Qq0Q8XXHS5qj+4jSRAkbV4ZZAActUKZPEhv4fT6yT3viQgxNEJNC9i
         EAa7LtaSfJnlw85F/p8CGVfFMZLUqZQ2N9m79n/Tj2NoBAAXraFfp3M3kezLN0/EL3gp
         gg/Hhaen/yntkKaI8dPOgSeMFG905KTEsXvzGVDY1uCai3SQmTZ7/wWyxBbgCYt9hPy2
         aiW1W40FKF9a0lACjT9bHvA9QHmOlVCIz6EL76lDRSgdwRx/ozBpc5e4JRJ4hNGM06TE
         KjWA==
X-Forwarded-Encrypted: i=1; AJvYcCWLg3LK8U1vdKlGs+wDn7XtqMDWNyFoSIaMtxSrtPG1+S6erz+G5bFbd99iX7Q5wLylG8dcoRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6XEUIg6Z7DgLAXH3F0DP1KrSvHdgJiMCjRYZfWdWn3M5Rh/4f
	nPR+wH0Tp7r4uAPI8784urUsAwIV7qqGXEHjW8xzpeSdZYCB5NzvmSmN0by3yMQeRQ==
X-Gm-Gg: ASbGncs4WfrFvTy7dLRqdPSU9ckpKRuEgKQ1fZxD0+VhXwuSs9mqdBOH3I+mRfNOB5/
	dMwy7XTMYAY8kPRJstNypDyuuI+2GSmMMxgmWVGLqhg8DxjsKF3Mc80lhsBJIEZ42DPbrnbv6lY
	7jgDtGPm54xfdk3yi4FrvMMeoclqcWVpiCVAZECIUslivfEWxtwOqLLEKWFnmfGTDFdlHOrhedb
	QiwFfXppYGDy7JqjyC0tpOTQCbLlKEIaD3To7hwepd/TxaPfrVk4bJCb+txxZj4nP7dEDnT23Ck
	wzNnqNONSUZy2NvX112V6Ab+Dvi/wpitq6Si4GPBHIyKzn1GduABjqkrcrXjRSoohaSvvpFeB4S
	nYxRfMDXXmCmIeU0OOd+pb2fI2YlbZqBXesIo3ViopF+7NEhlteCic0DrnhjdN78fkJev1SapNK
	4rTkBJj+wipUzc8E1aw1wnqRKMnC11xVL+tQnu2HUrT1ZOObE50l1hdYfo
X-Google-Smtp-Source: AGHT+IHzm8c0xGGjaeLIwA2BPXtY2jzZQRJI4K5aM6cm2P48XqyyxX+Ndvpf6Mh9o+5LH9YF8ZMgvg==
X-Received: by 2002:a05:6a20:7485:b0:35d:5d40:6d7b with SMTP id adf61e73a8af0-3637deafc2amr31952778637.37.1764615527371;
        Mon, 01 Dec 2025 10:58:47 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:14e3:ac6f:380c:fcf3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1520a03a3sm14522852b3a.29.2025.12.01.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 10:58:46 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: tom@herbertland.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/5] ipv6: Check if max HBH or DestOp sysctl is zero and drop if it is
Date: Mon,  1 Dec 2025 10:55:30 -0800
Message-ID: <20251201185817.1003392-2-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201185817.1003392-1-tom@herbertland.com>
References: <20251201185817.1003392-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In IPv6 Destination options processing function check if
net->ipv6.sysctl.max_dst_opts_cnt is zero up front. If is zero then
drop the packet since Destination Options processing is disabled.

Similarly, in IPv6 hop-by-hop options processing function check if
net->ipv6.sysctl.max_hbh_opts_cnt is zero up front. If is zero then
drop the packet since Hop-by-Hop Options processing is disabled.
---
 net/ipv6/exthdrs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index a23eb8734e15..11ff3d4df129 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -303,7 +303,8 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	struct net *net = dev_net(skb->dev);
 	int extlen;
 
-	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
+	if (!net->ipv6.sysctl.max_dst_opts_cnt ||
+	    !pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
 	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
 		__IP6_INC_STATS(dev_net(dst_dev(dst)), idev,
@@ -1040,7 +1041,8 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 	 * sizeof(struct ipv6hdr) by definition of
 	 * hop-by-hop options.
 	 */
-	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
+	if (!net->ipv6.sysctl.max_hbh_opts_cnt ||
+	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
 	    !pskb_may_pull(skb, (sizeof(struct ipv6hdr) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
 fail_and_free:
-- 
2.43.0


