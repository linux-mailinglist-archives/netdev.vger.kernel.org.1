Return-Path: <netdev+bounces-262007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPKWEBUwomke0wQAu9opvQ
	(envelope-from <netdev+bounces-262007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:00:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F6F1BF4A0
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F25AC3030FDE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D9F29BD8C;
	Sat, 28 Feb 2026 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LFl1enMY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB6226E6FB
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236815; cv=none; b=XE4VFS3yjuJVB2PoqdUPZYCFd7LLREStCS/gbtfrAzcf8LyXVCn9KxZRoPcV1e2hUb8emE5jmS2t/6EYGqPossokkC0YVmVxZs3hpy2/kPAXMAjyO6q85Tt9mR8k0/o7EcLYnsKdFY7sAji5DzQB/WbtFtNejkOpqYHq8UZnkpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236815; c=relaxed/simple;
	bh=aTGdGKIbN78z0HccJeLIaLaLIQQWPHWa0zQSLVb6wio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Au8+Nzm/iEVGrHbq1SQhBpjUJCjPrqr+iGLG3P1rWj8sb17g2imxUMREgKaTBwiwcl7/W4xlHgblNC2lBKO1vB4OYGTZUmzMkOEn4DDYD8t3NXjMCjz9eGROBO8FUafApn/n5xtZTxEm+sTdg6eVFvKK8QpaCJ6B0PJUplXBxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LFl1enMY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483bd7354efso33438795e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772236812; x=1772841612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+c1YssimIKbOeI4y9o12dVhyqLS9jie10yKUyGHwPU=;
        b=LFl1enMY7roRyPPwF1GrmVov7+FunnZbvGKy1rMM8VrKnAlfOQVj5caVk9Uc7pvHnC
         un21/a0hD2QSSt+Jjey3gPgT3MQ8ZDtubNUdbDjpOXW60nIfNwlNL7sEufJu1gEnVMa9
         DX+GuhuiJTIrao1J2csPld7Ac8ZyUwlZrLXJp+hmvzta9zUNQgDyYYNy4NYgVaadm3Sw
         B1W+a2zu4H+5VgeqfMd88+EtaCeGZsIJDUhadq/ZG3xaH/w/5s464K7cak9xivNwfkgG
         k112aFhNKJwlYIoh0Dzgwe7KhPqiCm284EwLE29slO/6JhXeG+suUZzl32VTMmk4YFRe
         8R+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236812; x=1772841612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+c1YssimIKbOeI4y9o12dVhyqLS9jie10yKUyGHwPU=;
        b=jbxEn/NFZjLC0Izmh0YRUZmCiT7HhyglR5tqfjxqed7yOdi9V45ybV3CfY60Ilp1bv
         ByBZ1omQ+F8wbRz8ebJq7WbWEljeBescJaQozRSiVTRZPjEDb2cy8vErJBtiabhTr1UW
         2xgd5M2f6phKqvy9zDy6Z3ae5pg5fkmJHcYoGQR2IfcybA/4wnwmZTViVl+Z9J/S45Gg
         Bez0GX4lN/Rc4mqruDFbO2iUJwk4ZD9qpP2h+Kbu8hnzNWPdaCOxxOfk72ue4xTl3vOn
         z0P3jaFsG5QAMF9a32kDKJnOCQ7lDJzev3nCz3cgoKippLfciptxDMsdYwKri7Uxtqrl
         Tryw==
X-Gm-Message-State: AOJu0YzEanOcZh39jlFC0A5I8j6C6JCpP8LMeqeyMMFluAUmA0LitthR
	y3UZ7snzKqxv9A8ExrOnqSgr3LugiLT4e5pYjmafteRa5YmiQSMHp6+Ni66C4C2m+9y7UUcUYV6
	+wyU0I+A5VVTk3bVtZ29V4j3305fOYP6yEY5SelQu3cBKwQfnzwx0pU7VgG7jpK5+
X-Gm-Gg: ATEYQzw9fzj5ORG8tb7CsrCN1umOhpDdMEezy9C5gMmUxS2aiOsZ0kQb5KflhV9lGBG
	98m+v9tEC7BjmfPefzk1WH6UlIh2NvL5U/fOioP9tinWA50sPjr4LXtZ7iIMGC6SfpvH9K3SvFI
	Z/awlWQwmNvqpWovggYAb6wr+uHCPY7PlSoSRkLxXgRh3SGmsIsKJpeTSX4wpdejgCeVPNgD/Sl
	bqgJCNESvIgbZ/UdgvX9DnewwXlOwn7bzIXLe5HfWxgZZK5g3PvYAc0DI0paes/KIOvQszFmcSU
	lU06zJ0PIqtnHAWrYjQEXVbYKU/W3oOEr1kEQDi4sYBxDmozKQxQ3sI6duh7tfXhYR1PqqJaD/Q
	i8wIrN1aVyBUuac0PVY8AuOjwHjRfnnLUytSAb6yCJ6fYuqmpZ/PPfqeHjBERSw3V6cR/O26Imu
	U5eVN06ZO3E1ydMLnoPRAqyTVoJ+IJCsReznrt
X-Received: by 2002:a05:600c:5306:b0:483:6d42:25c6 with SMTP id 5b1f17b1804b1-483c9bc4210mr74586385e9.23.1772236811767;
        Fri, 27 Feb 2026 16:00:11 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:d378:d869:cb10:1603])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77466sm94420695e9.5.2026.02.27.16.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:00:11 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 2/9] ovpn: use correct array size to parse nested attributes in ovpn_nl_key_swap_doit
Date: Sat, 28 Feb 2026 00:59:48 +0100
Message-ID: <20260227235955.660-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227235955.660-1-antonio@openvpn.net>
References: <20260227235955.660-1-antonio@openvpn.net>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262007-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:mid,openvpn.net:dkim,openvpn.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04F6F1BF4A0
X-Rspamd-Action: no action

From: Sabrina Dubroca <sd@queasysnail.net>

In ovpn_nl_key_swap_doit, the attributes array used to parse the
OVPN_A_KEYCONF uses OVPN_A_PEER_MAX instead of
OVPN_A_KEYCONF_MAX. Note that this does not cause any bug, since
currently OVPN_A_KEYCONF_MAX < OVPN_A_PEER_MAX.

The wrong constant was introduced by commit 203e2bf55990
("ovpn: implement key add/get/del/swap via netlink")

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index c7f382437630..fed0e46b32a3 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1061,8 +1061,8 @@ int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_peer *peer;
 	u32 peer_id;
 	int ret;
-- 
2.52.0


