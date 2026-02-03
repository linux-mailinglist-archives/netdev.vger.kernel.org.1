Return-Path: <netdev+bounces-256046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CU4HWxGgWnNFAMAu9opvQ
	(envelope-from <netdev+bounces-256046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:50:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7CED3256
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE13D30413B7
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4F521018A;
	Tue,  3 Feb 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="ZBfpOojc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6BB1F5834
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079766; cv=none; b=cJGeFjSMNIplRd2my67QWAUm65JQCxMaZOpDG6ZdhTOFGaTHGVgwoLJVz8S5c0LcdbXo2rTC6zyyKaKgAQ/iTfDGf7FtVRWvn0SRCaLT82G37PCv27IP6xSd+inGxAo1rG/sj/f+Ji3eJ4fOhghWcIN058VwqbWrQhJebkXDuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079766; c=relaxed/simple;
	bh=Ch7iIAas2iBnoNI29e0pHhApT6wyENmQjWT8C5tpAzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmUsNWKiziAEvInVV9IDlIOjKv3unMwwQaC+oCqB3rViJT1SSqLWatZkvV6xIwjlviTXuSgc6n8SbdAv0gMoD1Yf5fCnXHwi65xlhxLzblJmduVLi1U6hzO+eLr3htqTp54l+R+q2tM5jNgdMYd5+G1+4mNyiQQwgonSh1o5kec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=ZBfpOojc; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b7070acfdcso5642852eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 16:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770079764; x=1770684564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zln3SlFBxMmH0zbpwhckoP2qYDegDEhkAS3nEPrQ8YU=;
        b=ZBfpOojcnJsuFsqXbE/U3dXwXW7kCZFWfDsOO5UU1mE1Gz8x74X+H980iV0ymhZwA7
         HjM9znyNCnhA+6D8fkhRnu6C3fb68uwDK1AqAkFm/hkSiGRoy8eakzHDR2kRRb+nQHu/
         Tha5dusv2hxVXUOUeT3Iy4LDoLNyPvcnbefcgYuHnB98S+CRlz5yWz688b9iQWAbd685
         VrdwMY8tlqm59JVKjpRvb0Fsz52gmPvJQpuX9k0sCLA3AXttuLQhqDwMhDFqcxyzvhtE
         DLpzYzI0IvOzI1r7OEaoY+BBlsci6t7JxjDgEQ16BYmzwx63ceTA5mgSui8oBjwbGqp1
         uA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770079764; x=1770684564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zln3SlFBxMmH0zbpwhckoP2qYDegDEhkAS3nEPrQ8YU=;
        b=ASfdiduXvsfhPEThF9+Lz4xjSlwshPBaX4YrvOQleKcQyRBQIEFXH/MndXFq/MpUdG
         3Tx2l4bsAOZ6TyPRF9ZAAl61S8S0tfxHAXR9Is/xDF7mHbA79yO+j6yMfay8JjKmLch5
         ZHZbEerBErMRFPhM7gtvXXimbgezFfHLk7c+gx/Bc1k1ErYSmUYPiCl3P+cIKXt0qgjW
         A6tMySMyQltX2dyiQQUI8iq1snE7TgBEfSSiJd9QGwoJhG88ZUaJq8zU6lD9B8/XZHMj
         XjC9cxxewxrMuJ2oBg+WXdXhHgKMHyLKL8cOACFlZUz21fA1HKDrxq0mWv+xMGL5PpwW
         Ok5g==
X-Forwarded-Encrypted: i=1; AJvYcCUke9FVkZhs3uDkDdhwfdsqMyUOdgqfUVudHX4iJDo3lza4ow5Z96HghHGViyMPH2K6VTA7b2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxzuSGzSjR9+a45fPTWic1oUSja6N0tSgvpD0qEinTXgoDMf4
	h31bhSZX13BWjlet1VOeWZ0rlb0KGG3uQNsuHHO9YqtxXjGJOk+1fbRuXi/pVlh+6Q==
X-Gm-Gg: AZuq6aLGEliBBd57xisosVgDKJ1y89PnYIHu6EzaBaTS2GVE9h//dFT4K85c7kl3SlD
	kyaxQmSnBdROSJuwSyYbqMdGLlmnzYUhlOEZsD+4agsYj7gVbAPrhE73d/VpvkvhceWxPC7Jg+y
	JsgYHCAnO/KJ1t2c/Rxbx2HisGtYUvO1GAb7y8LVdw+FFef3mKiIVquh59hz1LocpCvi0l/UW34
	nwUrsYpr2JweAtxvfpBwkmDZo1Rk4JkYwap7el3V8wCo1LW5Qx0Q7Lfpcwo8nz+61e0kEvd59uy
	mMRCTyjnn72m2bRlDp5sCPGvUO7GvrGp+VhXW+nf0INUJl7n9dbEhHyp2GRPs3XYhzv8ugvFSVY
	4i8lelhicb0uJa8aTPKs5mLHWBZEZ8m1YMqg3+/CiRSYimZbMGOCCsdynYd9W4p4xR2XZ6YvHQh
	eW9qkl6idewie6UORLrTz5MgPaLsIiBcydZGJs4AQleJgiOiluaBDAuPjK
X-Received: by 2002:a05:7300:bc05:b0:2b7:a4b3:ea77 with SMTP id 5a478bee46e88-2b7c89278c9mr4240299eec.34.1770079764451;
        Mon, 02 Feb 2026 16:49:24 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:d7c2:35ea:5a4f:74f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm21017016eec.17.2026.02.02.16.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:49:24 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v6 04/10] ipv6: Set HBH and DestOpt limits to 2
Date: Mon,  2 Feb 2026 16:48:47 -0800
Message-ID: <20260203004853.94438-5-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203004853.94438-1-tom@herbertland.com>
References: <20260203004853.94438-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com];
	TAGGED_FROM(0.00)[bounces-256046-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC7CED3256
X-Rspamd-Action: no action

Set the default limits of non-padding Hop-by-Hop and Destination
options to 2. This means that if a packet contains more than two
non-padding options then it will be dropped. The previous limit
was 8, but that was too liberal considering that the stack only
support two Destination Options and the most Hop-by-Hop options
likely to ever be in the same packet are IOAM and JUMBO. The limit
can be increased via sysctl for private use and experimentation.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
---
 include/net/ipv6.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index cf2203ff2bfd..85d89b27a92c 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -86,9 +86,12 @@ struct ip_tunnel_info;
  * silently discarded.
  */
 
-/* Default limits for Hop-by-Hop and Destination options */
-#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 8
-#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
+/* Default limits for Hop-by-Hop and Destination non-padding options. The
+ * default value for both is 2. This sets a limit at two non-padding options
+ * (see sysctl documentation)
+ */
+#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 2
+#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 2
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
 
-- 
2.43.0


