Return-Path: <netdev+bounces-260354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAKgA/9KnWmhOQQAu9opvQ
	(envelope-from <netdev+bounces-260354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:53:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB501828EB
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3112303ACB8
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3013081DF;
	Tue, 24 Feb 2026 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhk52DEA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF7F3093DB
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915997; cv=none; b=VtC+2xtFh3IRjuRi4a294AYaCifeNf7qjPZeAvJjIeHIJtHU4LUznPSk03BbPtola5NHFZpzigdredrhd3NQl9rGRHp+BNwltUcDZMBkELy5zRWvyQkMQY2SdFHf5GYfVS4qTB+04PSRAPB38XS0kXqmmIdr/HbwHCvhVYtz1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915997; c=relaxed/simple;
	bh=s5w90tjQkJYYzbC3vOYs6oXg7h6S7OJfWNsP/+o7GlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQAtzrEHjSc4IxdCueIM3a1v0ossVc8vQpGwJ5DWARRs1VNNJLWkintATkZ8DKe1Y8Tg83PKl3L19t6Xq1BV/TBCKNEMtkzJ3TGJg2ZV/zmbziiI3uS2E7NPfLFn7K9gWfAjFnwQaDrKM125AUCuSOHfpCrfjDpdbXhKb+tBzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhk52DEA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65a40f3f048so9549240a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771915995; x=1772520795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWLpgkJWRF7bEw/Zu91fLz8PWNtrMB/wH+bAcmEPFvw=;
        b=hhk52DEAYcaUOc50p/Tu45xjiuPLoKFj42Up34NHhs3VpxGny8pv+L7DfhWTffPxFk
         h3u5gnEfeUm9z9a20Viy5ru4n9nNQl92hBJNmpRopaCr1UCN5/hFDR/Gres9fAY/0L7o
         EE5f8kXA5UhJSSt09n1ELOlW31KkYfsNmlPRnSj3RKyiiWXywx8DHKXxvdlxQ/JgIgmO
         NryzkJWnm4tDJLuxjU/jB3dvGl0sWpkGluRJ1DoQUaFakX28EhsejcJSBrcu51zmQqzt
         bhOJeXeKtSFSv9kSGfdIzQ0zdJskS1aZHA/enpCDlgTRVqX0LHrrRLT5ZHAQpv1emvHa
         mp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771915995; x=1772520795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWLpgkJWRF7bEw/Zu91fLz8PWNtrMB/wH+bAcmEPFvw=;
        b=PaUGCvJ1rNuslfGQWt4vbu/LfK9GUWb+mn63mXC+2G3tXdv8bhonOSZOEf0DbX8iUE
         xRJoGIRfNWdLSSgcm/eio9LiMGdEXz5Kq6fFxaiGoqG9hDA79NgUIX2UGDGFgd5PoxTB
         2lTwgyy/Aebix5k9QJwHb6706vTq6bds2lucQyGvkRnCcrFM15qN0MVfKa6fqTXHkFyH
         cIb69jijIXyVqEqZpBSJ6pBC3VY/Elw1zELVSS5flEVm+dlT6cB/3V1GyLpz6OCM+jcJ
         f3NQtJ+kcnLLHFOUtU/sySK5MYXWyKDuoyToKHY/wvPZSJ2CFiTPh3b/fuAO7JrTwyS2
         O8lg==
X-Gm-Message-State: AOJu0Yyr3rAj4HTKqhcQQ8ICZXcbfgWSPGNyjHCeLHP2wMyswwVYZEgQ
	wkuV9+kb8kZTe44JmUdivvdMQ3pQvmK+z1y+xBNmIBtvF57nA2yxbrx5
X-Gm-Gg: AZuq6aJrPZUmn0GOZsvCs4EFW0vj8SchBIqOofB5GhlvqbROGT3ik1K2fOi5l9hwU3W
	MdSH2XlFPr+r2sDEOcqLlDagZusdjIWIvrA25tF0dJ9yihMBiwgIN3h1a/2bxFgEPbFZdgTXdQE
	dj9FIjzoc8LH2r+Z2d+8U9TncKiqegvUsVwJqJPyPUcvZ5boWa3bMd7AfIsuDkHJzuHNIJRCbVx
	Ofp3G9ao6j9EJ4LnDtitOIlsI7ZCY2i4gpGt41iBEV02wOgTmwJsaNKdaod+/MICvllBhmrFkwn
	tnVwtbNMVQGVRXIGQPcDoLmzGPp/zD+DtYQjkbFUNuAc1vqkpDQWGmTv7l4Tm4UpOLU8q4YMUWN
	kjNzLjpc17lJwCM2QjGz2XRMZYjeOklTXWtTKjC3kolMFk7YJgdnmXDMgRfwBEO7I/xDlUtbC8b
	CI6+1MbUkCglLaJ4NNJUJyNbOjElw2o/KK1Isk+BvWh/DgGiRBKjIpfLQK2tyO45cQ1sCJbPcP/
	Mc4Y+iXlJWOjohmys8nnlln2Q9TFd5T9/FpKveIQ+wC9iYsX4OdLA8=
X-Received: by 2002:a17:906:4455:b0:b8f:8ff5:45d with SMTP id a640c23a62f3a-b9081c19dd5mr506369666b.53.1771915994218;
        Mon, 23 Feb 2026 22:53:14 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eaba13866sm3096698a12.18.2026.02.23.22.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:53:13 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v19 nf-next 1/5] net: pppoe: avoid zero-length arrays in struct pppoe_hdr
Date: Tue, 24 Feb 2026 07:53:02 +0100
Message-ID: <20260224065307.120768-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224065307.120768-1-ericwouds@gmail.com>
References: <20260224065307.120768-1-ericwouds@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260354-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[earthlink.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,netfilter.org,strlen.de,nwl.cc,blackwall.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BAB501828EB
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


