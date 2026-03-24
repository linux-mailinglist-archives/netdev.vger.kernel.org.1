Return-Path: <netdev+bounces-271173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MxaFIm+wmmOlQQAu9opvQ
	(envelope-from <netdev+bounces-271173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:40:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0C31931C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 886803006107
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325531AA1F4;
	Tue, 24 Mar 2026 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjixI/Rf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE69424BBF0
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369840; cv=none; b=XSqYCNl2LSoHJYVn3lhRYJRsbUTjF9/q+pFv/a/3K/90o6ai649stvkz3dGfs0S2SR1lL0t8gfK/vemUlaIAZe4nABT6FkIU9Jsd+Ih6ylltAxr6bFsZH0X+Wa1ZdnlUpJJWYwe5fL/ewqMOeUUrvpzMCsWWHEpJ0+7IdXWnzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369840; c=relaxed/simple;
	bh=+loqDOoDtezAe+9cwiej5cMzQSFnRNX6FuIiRDPdVAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jT9wZQDDLJet3aXGNltryv1XSo53j06HIYSJaiwVyzFgUWvkL/JR2LaEDb6pm1F6LREOHo+Z1Zg+TZJ9emg+/sCNRFrj623CO18UXGiHEuUHaiYC/bg27ZzojiZF36rRjDROs+ANsN4XA5neJadcW1YeIdqII161CuQfeGvw6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjixI/Rf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so39476505e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774369837; x=1774974637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf5180HMXFzke9SCrRO5pnJfMNpCE300W+Yy8UvaLtE=;
        b=fjixI/RfMm15tBZx8IxqjeuOM4a7a87j9QKhRczLDULMuIsUVKRb23eC9AsNHPWTBD
         qBExQx/DhLbBhMo0XqrflTYb+wGRd7uw+ZnZACRRxEwgS3YVVgZVwl/TFOwXG+9ns+7N
         hl/1oNR8mFTbFSxUzYPSne88PH8ivKxWzh8ftv9saCWxzcFWwTJqCOSp2V8DQIKbCpAn
         e/iPfv1mrOj9awyztt0rsqHn4M7bxdRgKgI4zvjzZT7lK1dROCooAHq8v37tsXpPX3GQ
         n9ANw+LiaJhDLl/oSqt4N79OXgkC8ZzD12kI5dCxTlf7qwTGDVsk50avlxLafOQVrqJW
         hHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369837; x=1774974637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf5180HMXFzke9SCrRO5pnJfMNpCE300W+Yy8UvaLtE=;
        b=QquPfjhRD3SlfFow5rkQwtnmcOUHQI/3E+k6mbbMJ654/Ywb+r5b8MhUAx5jbF9Y/g
         dAy1q7DUtKwEjNU4mNHegekGREyFxSju9Qgv9pVl0jMWatZ4HPtoor60ONw16EK+NXJO
         ZvSWszBMB7S7bL7XsUCkPwLTODsZ3zyHa9ytn5RADDiKLmzME2XwChzGWHJG6Ujmruss
         oI735snrSl6Tj4NNkhurp5QFGM3U+lh5If4ZMuobEC4Hl5ZnLufE5bqwCMiVDRfglgwM
         /rctEVI+AJ9zHBpU8H2tl3/JxS/ppPGZ+WBeA8TY1Xe4BSXcK5dGlx1pbcsRTCV4qdAk
         IA5g==
X-Gm-Message-State: AOJu0YxpVKXmKKGwnlpmY2JDn/UjU3yrhLaMdUCweMpDHLQS4heM8qsW
	Ha4eQX0ZWuFxAPsMxxdTzxo6XMxS0/nhuv0wtXcj0q45uQpoTNkTpIfiYb6yXoAWSlM=
X-Gm-Gg: ATEYQzwci9kFbre1OIoiYJpuHC4KfUTGjQSedLZP6vj76AVMVDAYd9RBzpYEn30GcT5
	Faorh8RrdnryDIp/WnJzE2PzSq+MzVfNX5E3cgOjIjqOn83ayXwLSc2UDdQvKXuKXzBYE1DR93F
	WsAvj4rP53oim3zl8qPty4Ms0T5Im0dmwDRAFzwxFrMXqhgdGlQF7ReeQMu2PUN4A637DTKKbtj
	WxkT7bKhAYWZCgkvkIvTa7H+NgYgOHF/71zAlBzhezOchJ9bfOPR1IOscNVKKQVw1NxPkbp0yhL
	0r+bAmLaKNalSDuA3R9M0FFGHicIvK9CvjFbbR3f34okQMAJ1+OMyxKOpyN/ni1n0ajYTSPnNNG
	+g5IHQPdsBwzyPn1bjRAFpXVi7duwHc7xZjHzSYk5gHeQzJgLZW+529OBC6hAFjja1As8qrs+mX
	S6Wexgft/sEfffFM3W5abvTKlqs93PA7yvYpg97hGhLxfbb96rOnKFmw+ppwqYcZFkF2Xw5GwDF
	pLRyJgRQ7Hr
X-Received: by 2002:a05:600c:154a:b0:485:3d3e:1675 with SMTP id 5b1f17b1804b1-48715fd6119mr5954065e9.8.1774369836971;
        Tue, 24 Mar 2026 09:30:36 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48716549160sm668205e9.3.2026.03.24.09.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:30:36 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] netfilter: conntrack: clamp TCP window scale to TCP_MAX_WSCALE via ctnetlink
Date: Tue, 24 Mar 2026 16:30:33 +0000
Message-ID: <20260324163033.310087-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-271173-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13C0C31931C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The normal TCP option parsing path clamps td_scale to TCP_MAX_WSCALE
(14), but the ctnetlink path (nlattr_to_tcp) accepts any u8 value
(0-255). This td_scale is then used as a shift count for u32 values,
causing undefined behavior when >= 32.

Use NLA_POLICY_MAX in the netlink policy to reject values exceeding
TCP_MAX_WSCALE at parse time, consistent with how commit f900e1d77ee0
("netfilter: conntrack: add missing validation of SCTP netlink
attributes") addressed similar missing validations.

Fixes: c8e2078cfe41 ("[NETFILTER]: ctnetlink: add support for internal tcp connection tracking flags handling")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 0c1d086e96cb..7d364337d71e 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1386,8 +1386,8 @@ static int tcp_to_nlattr(struct sk_buff *skb, struct nlattr *nla,
 
 static const struct nla_policy tcp_nla_policy[CTA_PROTOINFO_TCP_MAX+1] = {
 	[CTA_PROTOINFO_TCP_STATE]	    = { .type = NLA_U8 },
-	[CTA_PROTOINFO_TCP_WSCALE_ORIGINAL] = { .type = NLA_U8 },
-	[CTA_PROTOINFO_TCP_WSCALE_REPLY]    = { .type = NLA_U8 },
+	[CTA_PROTOINFO_TCP_WSCALE_ORIGINAL] = NLA_POLICY_MAX(NLA_U8, TCP_MAX_WSCALE),
+	[CTA_PROTOINFO_TCP_WSCALE_REPLY]    = NLA_POLICY_MAX(NLA_U8, TCP_MAX_WSCALE),
 	[CTA_PROTOINFO_TCP_FLAGS_ORIGINAL]  = { .len = sizeof(struct nf_ct_tcp_flags) },
 	[CTA_PROTOINFO_TCP_FLAGS_REPLY]	    = { .len = sizeof(struct nf_ct_tcp_flags) },
 };
-- 
2.53.0


