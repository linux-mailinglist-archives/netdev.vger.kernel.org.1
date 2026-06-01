Return-Path: <netdev+bounces-293897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LVGLpvdHWpsfQkAu9opvQ
	(envelope-from <netdev+bounces-293897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 21:29:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F0624A58
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 21:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF6C33076089
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 19:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3137F724;
	Mon,  1 Jun 2026 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky3hS9Aq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91D835CBD7
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341879; cv=none; b=NQ3ryLVEcusa+J5vVE9B/7y8qI2l61RFpy8bgyPdDbVIqd9i5HRNwin9Qdv8IWznO6CPj/TdsaERjjVtVP1cEEl/wIo4kAKItQxVxW2exD+V0P5eUr3dXKBd1347mlX74c/CPtmH8XpzGpJGuHayercAprlH1aEx1QatXsQat18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341879; c=relaxed/simple;
	bh=rkHcjsPkRR9nNSHxR46h2y9fTpo1dvARrrbdvhIHj/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHIM167yWdlPr8OG934vUrQT1aBQef7VNKNHLOA5Q9Vc4fjHvVnO7TNe1zSurEmaBzTNJY34U6KLHrCIbSsB89lUcebACf5SWBSerAI6yxaEEyn4tDeAn1tuAZ4SIfPqhEay7uJzC3/WTOs82PpLHCu9vVfb9f4joSzpehnI3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky3hS9Aq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0bd02d97eso20828855ad.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780341878; x=1780946678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8Jk1ivLmwr3VP3ike29F6VRWUYvoG1CiSF1zOqSE6U=;
        b=Ky3hS9AqHXRSJRKrQavLc3UCZYwr7npEDXG78lJeKbVx8lKsMxgYDvOwjHHukeehgo
         atSxmGiMrF71OcGGX32O6CAIlV9eo5Yk+lbACPC70YvKqcO3Rqdvhh3oKoaeYUmu7jbE
         V4Q6AEMfpp9ac0lN46yEntowvNO9NM9rJJGIY75VWjNn6lvjI+RtKQIE5wOfMOzkhegh
         HPxQN6/+KLkA/ABBiPEecPTnDGsaMRsJZMlJtwCr+pM8LiXTjD1xdXBECB+++LiwBpbA
         neFlcoSwXK/0hcPuoY9BZJDKUSoXW/g1T9/wiBECs4LbnlqW3MF0Qd30SYZ2XoQOOx8P
         SL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341878; x=1780946678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p8Jk1ivLmwr3VP3ike29F6VRWUYvoG1CiSF1zOqSE6U=;
        b=Og9FLCE4b/Ya72/hp3hYR2JjZGi7pC3GMXZ4ZsOeng2fLeIDbC325EpYka3hfnCb/3
         wVQmpB1lgwOkXfzGjjr9xTiZl+A4KH8eHM/5pqlV9R8+NiuBKOng86sRq600LihWRpyd
         E7Lh/9JOrpAYKp8CTMSlOMWPFAea40eRrH3xM8j4R6VkY/zjm5+4cdL2CMnaXalGgSE7
         2jZeEsq9Juexk+cKk/XAcVgLCpB8wTcU0SK9RycJSQqzQubdBEGWZES5U0cDmCzRJLVR
         2cL0XKGVSjzdJ9mJngIANG+voA/6F0iFY2wfZkHdOLon+T2FE0zjmD/tSL86vsurqxiD
         ZFVw==
X-Gm-Message-State: AOJu0YwrdK+jsMEiSN+1+i+ff8NnrdnNvDIetM0aJxUqVnvVcUAYAVam
	ErvWSEodjb7HTaJoP5UeQCAWA1+LfqA4y5cs2VsdaIKc9NiM8E4KkOS3
X-Gm-Gg: Acq92OFCab3tSsi4Kxpu8IVE70ENJ5FhabD46mojLCoW3dXreW/KLI6OVfwzURjY+7j
	Gv4NaXcV3WMMoG+4NtZZ5L29I83ao0LZCjK5U7BgwTrzc0lBJMI2dbH8TuMUBrWN7CZQqwWeSHk
	ObeMKVKUTEuoMgBd87m8B6k5ALqhvuJbcLfilzRWFOifQFJQOgrbAybuZxYBVLimpZTy1CfJE6v
	lkU2PC9Fj7JG24BnzFb2rDWYKgQXolC6ErWFkPLIvUnRrwLCsQgVi/L8KW4E0hfwzGfgHY7fd80
	ZWS20MM1xb66wCNbnFR5dpJZmPq7SS7VH+IxoPZ9fhrYnPvpe+GW50UMzK6SR4J/1/CP78DfpPI
	n10TopbvPSji6H4wQas19DTD/p3nSuZJOzFT2sL6FDhCe+DPlmfTqOdcV4h9lsEX/N9csfqrwN5
	2RsDBpF2qFtIsD1+NsqAuAyCUggj1aiQ==
X-Received: by 2002:a17:903:8c8:b0:2bc:eea4:83c3 with SMTP id d9443c01a7336-2bf368334b0mr136497405ad.25.1780341877857;
        Mon, 01 Jun 2026 12:24:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a2dbfbsm113520295ad.37.2026.06.01.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:24:37 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 01 Jun 2026 12:24:27 -0700
Subject: [PATCH net-next 1/2] net: devmem: allow bind-rx from non-init user
 namespaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-nl-prov-v1-1-9bc57d6ca3f3@meta.com>
References: <20260601-nl-prov-v1-0-9bc57d6ca3f3@meta.com>
In-Reply-To: <20260601-nl-prov-v1-0-9bc57d6ca3f3@meta.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293897-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2E6F0624A58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

NETDEV_CMD_BIND_RX is currently GENL_ADMIN_PERM, which checks
CAP_NET_ADMIN against init userns. With recent container/netkit/ns
support for devmem, other userns/netns use cases come online and require
bind-rx to allow CAP_NET_ADMIN in non-init user ns as well.

Switch the flag to GENL_UNS_ADMIN_PERM to allow bind-rx for
CAP_NET_ADMIN in the netns's owning userns as well.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 Documentation/netlink/specs/netdev.yaml | 2 +-
 net/core/netdev-genl-gen.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index a1f4c5a561e9..49862b666d7d 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -798,7 +798,7 @@ operations:
       name: bind-rx
       doc: Bind dmabuf to netdev
       attribute-set: dmabuf
-      flags: [admin-perm]
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index c7e138bfe345..d18c89b5a6c7 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -220,7 +220,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.doit		= netdev_nl_bind_rx_doit,
 		.policy		= netdev_bind_rx_nl_policy,
 		.maxattr	= NETDEV_A_DMABUF_FD,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= NETDEV_CMD_NAPI_SET,

-- 
2.53.0-Meta


