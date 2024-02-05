Return-Path: <netdev+bounces-69266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB45B84A8BF
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91793B212DC
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380F35A0E8;
	Mon,  5 Feb 2024 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIZjurpY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6559B76
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707169247; cv=none; b=UNpdVwKyg+Is6hUXcR2Uma4KCcqxDqsqfiajIrijuEV6XIJi7y50wt+l9GutDo2+1BZJAm7C7IUXFwS+BqMkffWFs46HQeivRPceYNRuUUxhDmzS3D9MalQx1y/VoYAxwTF+KkCl6wap89zmJIb+BcVJ0hUzfZ7HemsbwuwEF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707169247; c=relaxed/simple;
	bh=qk407FI7frV3L8SMCUcipi9YvNbrW/8M4wub+qXsq6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQ9be5XjRsCedMoGC6CH4tQKhp5ZqGqe2wFlk2ym4jt6ejEN8qlvCEg2HVKvmH/gC2VmM+Oed2OqNvO5iJV8Nkn7MUg0PqfPV4kttkg8R9Hl8G2L+/GS77VxKxdHyGoWK66xAMSRNVt3MSspvrROLyyogMRSz+1XUtmvSxlT0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIZjurpY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6041c6333cdso39550177b3.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 13:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707169244; x=1707774044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8AkpGejsu4VJ2FN79PyTLfroPMs/1bJnlVtzqqA8Wg=;
        b=YIZjurpYaDPQc12fXwajj9WaxYWvgYZQtjdfW1ClP3g4VVT0hVvRJYafsw1JK7Awwl
         fOoSnurHdbRtSH83f2/AYGjXdqXwAsGw/rJ9fR6S4NWy5jtpVxxdURTAThkmjbufnVqH
         LS8dBul0TjHs95mFyyDbTRsCzQVqkyK3EyPca9YElL9lqdSvrAZFNNhTcVW5Zgy8gDtB
         Q6zca2+d7gTuR2RLYEPV57NWJxEoySpXmX3+NQIfcGWK7NWoTzxCagSog2HaLmFhvERy
         X8O+JEdWfiyc22N+pd8FEWExxFgcXqd9eSue3pJGx/F2O2m518JcT3cumQN1zIFXnrSm
         iNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707169244; x=1707774044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8AkpGejsu4VJ2FN79PyTLfroPMs/1bJnlVtzqqA8Wg=;
        b=cBguL3i3fngJ36fXD0KmyjcOXC6CA48aKCTNqhGCBcC5G7xlU22mzzWl0RiMZHssQ9
         02E0cJjFrbPB3/c43e3pRQ2TaA/1GKKabIgM7xvw4A6QNIYUZkl/OcH3MNejexD4c9+e
         cK2+EFI8neBMNeVbOySHHjmbbMFGk/bbQxJnX14HBnb4mdzPsttsg823f49WpxdR6cMf
         OaqPZ1KoYP3kfLBHYjLPDQd2zKs2IKWZvyhsIHqGlPCpSaUjSg3HkDluZWX3FSl7SadU
         9HAgyq6gsksFxaWWQxuczXiimwFWpN7eXN5qP35mZWVh6qD+/FQ0cZPKZ9zZuskE59xz
         +F4g==
X-Gm-Message-State: AOJu0YyZMclDVUeaPXAKQhEx95SS+cR0IiKy4haRVmWDVwGohxySxSAG
	QCnimi8op2Um9+QERz+2WpTRyF/9SlxxuoIynDwwJZ2+SfiD8yvQol0tqxLe
X-Google-Smtp-Source: AGHT+IHAuKs6p2GGjlxA6NNH6he8x4WWVjkzuxoxeInenteS4vG0tnPDdNldzBZVAqVeymshYAs57w==
X-Received: by 2002:a05:6902:1b8d:b0:dc2:2846:59dc with SMTP id ei13-20020a0569021b8d00b00dc2284659dcmr762916ybb.36.1707169244280;
        Mon, 05 Feb 2024 13:40:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWAl/nidbZzLIGw9HJH1UqNdKVlVyOMvgCTY4d0SW8AIZAliAKRiVjEOzNX38ZfXTdODjLxpx9XNIV7dcr3mQ13qVtwOXYq4bWvzVcxg+C1WRJENRrnhdlujngU6exKhJjnnDtqJupEukz2yC2tyYX7xRNmk3dc0U3BUdsk+xlRHFPvYk6x/vyr6Dk1rP4/1mQO5Fyb5nntbFWx5UwMzE6ve2VnvhATKO7wwIAgGmDyB0fsOr4bpBlZpn1atCFH6qQ0kqEOIZs8mgzLKl1fKULr/n7Gd9TwWX2ddB/Waz56p01Y/v13CEtKBB62ZUZP1jnRA1MSUrKR/Ywa6kQcphVTMFNBlc4yaU5FmQ==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b69:db05:cad3:f30f])
        by smtp.gmail.com with ESMTPSA id d7-20020a258247000000b00dbf23ca7d82sm160936ybn.63.2024.02.05.13.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:40:44 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v4 4/5] net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
Date: Mon,  5 Feb 2024 13:40:32 -0800
Message-Id: <20240205214033.937814-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205214033.937814-1-thinker.li@gmail.com>
References: <20240205214033.937814-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Make the decision to set or clean the expires of a route based on the
RTF_EXPIRES flag, rather than the value of the "expires" argument.

This patch doesn't make difference logically, but make inet6_addr_modify()
and modify_prefix_route() consistent.

The function inet6_addr_modify() is the only caller of
modify_prefix_route(), and it passes the RTF_EXPIRES flag and an expiration
value. The RTF_EXPIRES flag is turned on or off based on the value of
valid_lft. The RTF_EXPIRES flag is turned on if valid_lft is a finite value
(not infinite, not 0xffffffff). Even if valid_lft is 0, the RTF_EXPIRES
flag remains on. The expiration value being passed is equal to the
valid_lft value if the flag is on. However, if the valid_lft value is
infinite, the expiration value becomes 0 and the RTF_EXPIRES flag is turned
off. Despite this, modify_prefix_route() decides to set the expiration
value if the received expiration value is not zero. This mixing of infinite
and zero cases creates an inconsistency.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 58c5270396f6..486ec83b4668 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4783,7 +4783,7 @@ static int modify_prefix_route(struct inet6_ifaddr *ifp,
 		table = f6i->fib6_table;
 		spin_lock_bh(&table->tb6_lock);
 
-		if (!expires) {
+		if (!(flags & RTF_EXPIRES)) {
 			fib6_clean_expires(f6i);
 			fib6_remove_gc_list(f6i);
 		} else {
-- 
2.34.1


