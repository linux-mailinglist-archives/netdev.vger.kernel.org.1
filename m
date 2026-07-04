Return-Path: <netdev+bounces-304732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GeIIAsiHSWob2wAAu9opvQ
	(envelope-from <netdev+bounces-304732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 00:23:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E39D7088C2
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 00:23:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=AsNWhC8k;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304732-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304732-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0501301548A
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 22:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4F23B7744;
	Sat,  4 Jul 2026 22:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C853397E8A
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 22:22:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783203780; cv=none; b=j5eFL1lFA0rhzim8mD4KX6fwQedgum2Sj77nHvDkyR0ApiBBAeCfnBWGgaBNLiWsbr5bDmgq1EmuFk6sVYxPqQsOyt4kfXwg0iYZX6eSkWgVFV6rJU17SfDkQSpuzcQPv1S3AqE/vbap6lV79Oj8BGact4HYY3hCYWUZBo7/Too=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783203780; c=relaxed/simple;
	bh=4qvXCceyH6zuN3hy7lanVxkYiDgB7NLTyjSDVr5VmfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GbDwm9SluwPVZYxUlSK4HOO+D6z5IKg5auRNm2EPVquN/kjum+N7R00SSpKEfpGaqr9rA984AubXXyHFA3bCIIxtZo3+R78Px3SSpwdYnzF+m2vwBhWTbwJVFb2XAA6XHWLg3yNae88tgmOqpN+ANLd8MinH0l76pTQpkNdfpfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=AsNWhC8k; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-847aa193d98so1370146b3a.3
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 15:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783203779; x=1783808579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=70dWq0Alk4Cssp1Jlc+lKIuB3dScjeAA+8YF2YRZQ6U=;
        b=AsNWhC8k7R0WWEKIfGofTKSIDrAPehoeazwfk9psRH118/yAOzV7KIj0JbSrJ5bS7w
         3oI6WLy2Sx5L+HYb984Y0AxZjsRF0K2FCMGqUiGOZDqcgg1M5JG8hkwFT3917gXR4lpd
         IPrtMrf+jz4dmDHXuRjcfsMMn6cSWqdqac9d49oFc8DgJvcgZ3B6jJLxqAuomFTbRqdu
         CiR6YpTG/E00QSxsy7Q3WQpDQBMEV8pYQNP4dY1cPl9y6rYrMSkjXno5lB7gtPkwlk+4
         hjsPce3jAT76Y/ncv5AT9+nzD6ACI+/C6fwob4zAhsJt36QFCcWRvlmtCjjImDDHsxoi
         e/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783203779; x=1783808579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70dWq0Alk4Cssp1Jlc+lKIuB3dScjeAA+8YF2YRZQ6U=;
        b=EEBYNuXhI9wwIYBXLqoyTG94SbyGYJgyYZ6U3kx+w3hJ5HcdCvEFc32i++zSS2EXOi
         BwiKo5NkkQHaBoMIknFxvTEWioV9pUDTYT5xHE/WVJEbZxZ9cZiaNnBEXpE1U+yVIrYO
         eA6JVaSz3YqkPTsBvv4kpmUZaasx0mZ4Cmi35g2FtTxaNoYf24jHWvo/sbR7ULWmGBN2
         n2YTfHDNWuPhUZPIshN5csPvPVPh6pUfF+P0cy/5CKVv6RnhQJu1vOhZhWeoCKoqvsuo
         ccpK26oIyspLwoR8p6fw1JfVs18AufDAHiBgSl1WHr0gETIYl0fCe/JSBKAvwuwat+AC
         6S0Q==
X-Gm-Message-State: AOJu0Yw7M3N5Lfqi38oGE8H7+Px3wlP7/OPQZaaSALIc6pljZ7c97PuQ
	yTddcIfNclx0/Z5i5b5XAtfQlrVFkf8s3/Z1itzeItsXhPjjwdzJCEb0tM1nVjvPrA==
X-Gm-Gg: AfdE7ckhYBs5421B//2w4VzauSxMBlO6AAPWDOm6EE2d9yRssPF0c+1I+QT+xKT+w3f
	btVZijVZTRatJgqbt5Ck2KCxrxLGhWZAElc40Wj/uE6O9zX3Ku/tzWKDYlWMVve5gqR2bpEG/7J
	QH72Wf0dMWzNBytctkbAY59+ouqrvz7XF/1PBLE34rOg1Y7fTy2302JbdxBVPlFbuEbTvVmIfoD
	h2E6q1Z/djQ89tGpyFVCOksb3vZsttgnEI3YESlqwS7eBjAMmTHunGhkbr4tDDtE8JpxTyj5Mvy
	YauY5hK29Y7wYCFJESDDx7BWfAapksGxwNgLCfWPWMEuF1D0zNP6wgeOkHNHBSTw0BpNIcILWb6
	NkTNrBGCBx1UjzBqyQqvdlRwhBNf3MkcxWLs1UizaWMPeG5vyUblHSncpJHX5vqycuDex/M+xfd
	Y=
X-Received: by 2002:a05:6a00:1894:b0:847:8625:f7bb with SMTP id d2e1a72fcca58-847f6faa023mr4130520b3a.60.1783203778712;
        Sat, 04 Jul 2026 15:22:58 -0700 (PDT)
Received: from p1.. ([172.56.105.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbdc8dsm1575890b3a.55.2026.07.04.15.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 15:22:58 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Machata <petrm@nvidia.com>,
	Andy Roulin <aroulin@nvidia.com>,
	David Yang <mmyangfl@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] vxlan: vnifilter: enforce exact length of GROUP/GROUP6 attributes
Date: Sat,  4 Jul 2026 15:22:54 -0700
Message-ID: <20260704222254.914567-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,asu.edu];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:roopa@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:petrm@nvidia.com,m:aroulin@nvidia.com,m:mmyangfl@gmail.com,m:kees@kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E39D7088C2

The VXLAN VNI filter entry policy declares the GROUP/GROUP6 address
attributes as NLA_BINARY with only a maximum length, so validate_nla()
accepts a payload shorter than the address. The GROUP consumer reads it
with nla_get_in_addr(), an unconditional 4-byte load, so a short
attribute over-reads up to 3 bytes of uninitialised slab data, which are
stored into remote_ip and echoed back via RTM_GETTUNNEL, disclosing
kernel memory.

Switch both entries to NLA_POLICY_EXACT_LEN() so the validator rejects
any GROUP/GROUP6 that is not exactly 4 / 16 bytes; a valid address is
always sent at full width.

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 3e76f4e21094..dd94085e0886 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -462,10 +462,8 @@ static int vxlan_vnifilter_dump(struct sk_buff *skb, struct netlink_callback *cb
 static const struct nla_policy vni_filter_entry_policy[VXLAN_VNIFILTER_ENTRY_MAX + 1] = {
 	[VXLAN_VNIFILTER_ENTRY_START] = { .type = NLA_U32 },
 	[VXLAN_VNIFILTER_ENTRY_END] = { .type = NLA_U32 },
-	[VXLAN_VNIFILTER_ENTRY_GROUP]	= { .type = NLA_BINARY,
-					    .len = sizeof_field(struct iphdr, daddr) },
-	[VXLAN_VNIFILTER_ENTRY_GROUP6]	= { .type = NLA_BINARY,
-					    .len = sizeof(struct in6_addr) },
+	[VXLAN_VNIFILTER_ENTRY_GROUP]	= NLA_POLICY_EXACT_LEN(sizeof_field(struct iphdr, daddr)),
+	[VXLAN_VNIFILTER_ENTRY_GROUP6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 };
 
 static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
-- 
2.43.0


