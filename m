Return-Path: <netdev+bounces-260580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA3IMIbJnWl9SAQAu9opvQ
	(envelope-from <netdev+bounces-260580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:53:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6871895E6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E43C2300F192
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78913815F0;
	Tue, 24 Feb 2026 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyicDOp1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E103A63E6
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948274; cv=none; b=dxcClMeg7Ack5z5Py31OE+xlXqDmS4NjwVu+fYvtHlZusSTazGeM5z9p/O4vRtwE58FuEPTNKd6FaFZQBfzJf2B5DidfvJNWKRbP6cF6EQyD/BxnfvPJiHdJfjPsMMliBQEglVQVPB6D49vY1t79soynB0e8aCgu5yIwsfFWCOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948274; c=relaxed/simple;
	bh=GQmZQHhW4De0DzyEJsNLZte4cBDYzAbxauK0V1WfmOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsdT/4YkbcVduyqU6AmC8LklkXqaqeJtPB3MdNexZh2paSKkpnzwrXafC9M2K7NOuOzpAZGeAvW4R0OsyO3aDnp8JoXe1TLZ3drvyZEq4pgQw5m/QzQmpsVkfvcglPGI4wAjD+VVBwEC4HwYoxng3gcMz6ZId0pGjq/V6ilURjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyicDOp1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f992167dcso697220766b.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 07:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771948272; x=1772553072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AwmvumWjKWYZMSJMQV4dcJqWr2BJWWCP+BAdYPDv/fE=;
        b=jyicDOp1Wm9BfDGSRq/13xrYqRlXYfmoxz7WJoER8GxYcq0/ekgwfmVkSIkIMPGXaA
         2rj+dX2ZUxzo+ydk7oj5Qcj/wPsJ5umJxoJt7hyYgmIZ4MxN28YK4Ny53mzCMLt1HwrO
         99udZeRk13nYfB/+CEmoOlEiDbYweBm+d/yp49hvDhBrFie13XJSyz+fiYM0a4XAjMEM
         ybOMh1o04ONCd6nvUcdHURJIa9YFhfVIOWe49SWvq62sZq0vOBUBuLvRog7Vi6KErWBC
         Gb1pK8BLl3j+I59O1vnMdSd0kpHx3/vkv449aa+9sc+mhVAdl/pwu6+HEWnBZg8svNru
         lvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771948272; x=1772553072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwmvumWjKWYZMSJMQV4dcJqWr2BJWWCP+BAdYPDv/fE=;
        b=LICQjEt3MuhHn1l07c16uv3k6BFAs4NLUc4b59nvlmzIFrivGezdHr3zqOILfVxTsK
         yoRRZt+s4lQ49BuGb8846LkBNxC2LiYpyNLkgYEjScEXf67OXV1y9AaByqmxg/if0ead
         tWwcLOlSW3KyEDOsdfv2gxbaWnC+1XcgsAFzc5o13za+/vZ31Pmxk4JpQId9S7Fj03Dp
         ITXqCdScShe0W0v27KuUpfSvPQQKXkvnnrRBW0s1FrshZz4gOxCEPd4jlarbUkXRd2ui
         n6rx5kTjFD7noUpHFwXpfDgNZO3JVDxzsH6+oj7Xe0+EObD+TYSPoHOxkd9CU6j2oEfi
         53ZQ==
X-Gm-Message-State: AOJu0YxGWLM24FFsle4HBB+bq6P2zBeDzTD1Pb/LNAv95ACic46Adn6v
	qFfxtkHTMqELgnaudjxQLG/9mCHGzG3hhkmVqmUeWnk2lq5fWHGM9+YP
X-Gm-Gg: ATEYQzz0+0lQa5usYaAlOO5WOgAtP/OkBnLZXBF8qefUN3A1vRK4tMixhUl6AvRlNLH
	M/F6/Pmqw79dDGOzvlkGEdL7uFe+gp4otik7vgPpqSb9MX4UQzOgS+U6FjaK8iU6aQ5yiqEOWQ1
	hthE90rdFTB7+HMCIvVhRLzgWrmWIAgLA/CmrYgS0BC05BPhRtAbEOARrlXZTtka4HVmnTbZxAE
	mSOaTjVq+5g7gkKUqCZ+boPD6WkJ8ZoZeM5UcHsNhrezbNVh2WRhSTCQgnUkfzJKfypmhPvcn1A
	RPHxYssD01fyJBywVXVdA8B7IICXxN+7PdZpdFyzCd9dZBwm/HEcmiFL/HY7o4wxMsz37HnRGk+
	a7ShC2CwrAifqLgtDr1yV+2AiDIfsQIEA9bZnF05X0Y4StGid0XN8uOvaDVbZk6KiHYXykFN5cT
	nYB0WX12OC0Yriu7vN+JSWlqgReJoqmiuhUFWCwF9yi/ShJiAKoxIcInp10qa7aGEVrdn4XLiP+
	ps9FGXr72H7WCRV7u5MYMsj8sszuMbq42YPxbf5A82pOIXPYHhwunE=
X-Received: by 2002:a17:907:da16:b0:b80:751:ee62 with SMTP id a640c23a62f3a-b90819ae26dmr765623966b.14.1771948271448;
        Tue, 24 Feb 2026 07:51:11 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084e4c27bsm425855366b.39.2026.02.24.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:51:10 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Eric Woudstra <ericwouds@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v20 net] net: pppoe: avoid zero-length arrays in struct pppoe_hdr
Date: Tue, 24 Feb 2026 16:50:30 +0100
Message-ID: <20260224155030.106918-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[earthlink.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,strlen.de,gmail.com,blackwall.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260580-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,blackwall.org:email]
X-Rspamd-Queue-Id: 3B6871895E6
X-Rspamd-Action: no action

Jakub Kicinski suggested following patch:

W=1 C=1 GCC build gives us:

net/bridge/netfilter/nf_conntrack_bridge.c: note: in included file (through
../include/linux/if_pppox.h, ../include/uapi/linux/netfilter_bridge.h,
../include/linux/netfilter_bridge.h): include/uapi/linux/if_pppox.h:
153:29: warning: array of flexible structures

It doesn't like that hdr has a zero-length array which overlaps proto.
The kernel code doesn't currently need those arrays.

PPPoE connection is functional after applying this patch.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

---

This version was last send in:

[PATCH v19 nf-next 1/5] net: pppoe: avoid zero-length arrays in
struct pppoe_hdr

Although it is needed to prevent warnings caused by my patches send to
nf-next, it was asked to send this patch separately to netdev.

 drivers/net/ppp/pppoe.c       | 2 +-
 include/uapi/linux/if_pppox.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 4275b393a454..7900cc3212a5 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -885,7 +885,7 @@ static int pppoe_sendmsg(struct socket *sock, struct msghdr *m,
 	skb->protocol = cpu_to_be16(ETH_P_PPP_SES);
 
 	ph = skb_put(skb, total_len + sizeof(struct pppoe_hdr));
-	start = (char *)&ph->tag[0];
+	start = (char *)ph + sizeof(*ph);
 
 	error = memcpy_from_msg(start, m, total_len);
 	if (error < 0) {
diff --git a/include/uapi/linux/if_pppox.h b/include/uapi/linux/if_pppox.h
index 9abd80dcc46f..29b804aa7474 100644
--- a/include/uapi/linux/if_pppox.h
+++ b/include/uapi/linux/if_pppox.h
@@ -122,7 +122,9 @@ struct sockaddr_pppol2tpv3in6 {
 struct pppoe_tag {
 	__be16 tag_type;
 	__be16 tag_len;
+#ifndef __KERNEL__
 	char tag_data[];
+#endif
 } __attribute__ ((packed));
 
 /* Tag identifiers */
@@ -150,7 +152,9 @@ struct pppoe_hdr {
 	__u8 code;
 	__be16 sid;
 	__be16 length;
+#ifndef __KERNEL__
 	struct pppoe_tag tag[];
+#endif
 } __packed;
 
 /* Length of entire PPPoE + PPP header */
-- 
2.53.0


