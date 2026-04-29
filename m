Return-Path: <netdev+bounces-282365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLrSJDDz8WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:01:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0757E493D41
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80AFC301F492
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB8D347537;
	Wed, 29 Apr 2026 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CWORx137"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0863F65E5
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777464091; cv=none; b=Exc7LmC8VwaCIGXa/ek50Z7J5qwpv4qDV935KMcWl4AJPvcNnUu+alENrs4VI5CVSBA4zW59ekFUmiJRZUUQtuu1+JQJM7LSbB+o1seYu13KgHZOr3Wd0hrUgDtuHNn5UUXJ6CKAqvfi7ZJpbfT9Z9Ib9GJyfuG7w+9ZQP/YY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777464091; c=relaxed/simple;
	bh=xyrL5T8AsJk/ToMETXqbbDtwu6ZnVcGeKFJ6x1z4nEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rO/C90PCP7N8DD7NmpBaGxMxBGhlHynv/xYBYdUiydNqNluypKVFuPJWhuEqhpJYnyV3xLQCvJVCRmWIi4Pi0oIytmm2PAV9lz/QWDdFCBSCB3g7EuHe5Xyr8aCs2NC+XE0T+vYAJskrnh25+UTQw4mKW7YfGPAa/IGktS4Gqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CWORx137; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so90299145e9.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 05:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1777464087; x=1778068887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBM0OlrQmuYd36e8vhU/lMffJDXcg8ey9ENppibtuC8=;
        b=CWORx137TpBhqO2wt9BYevEwhZ3mWGmaIUZQluo3v7uEI/mkeh/cxBD7LMWUhTKrN9
         Be9mOAY/MbDlvEdDenxdlvG3DL/Vm/+yiC9xdFU34ABkSbzf9OphdM1uyhNJ81ymwDIN
         yPsJAgGnzfnXwJP2hzYtlqHdUZpJ0gQ6hFmaIOh5VK5r9p0v6l51g953k6nk5HcD5d1U
         AhUKt/bUFNEnwl0VJioKCW7mHQJ8WYj6IFxAE2QrUzZXH91V6XxFA4TxkihloI7UZpl0
         QjFd+eXAw8AecVpJrb/gOJIGwv7R1/LK1sE4NGC42psNh1+zw4pNwAidXANiD3jVCWkm
         tCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777464087; x=1778068887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBM0OlrQmuYd36e8vhU/lMffJDXcg8ey9ENppibtuC8=;
        b=eAYhmYoUKDOa1ffo57KLfa0IaLkAyfZpAbTOzYBROd0bxyy8qh4dPmShAcEUMBOseu
         NBGikkHydgvE/1MKPMp+O13liA98lbwMdhF7AUqn1EO4p+qe94AgvBgESn+q1p9OGqmV
         e1h+8s4t170bUkATwRkZLHKHCQBxafMyXo10BqtE57jtQRAuHa+uYG7ks8L8Pllj3yHK
         ac0HEiW6XBVQhbk9kVIoKyVIFEe0KXIxwyREoZZwFZ2mDUZqd/cgGYU7FA30N+4g9CcR
         wLewicFa9KZ183/FU0uxtZC72XhpaLFooY7Ue6M21HlMrWaFIGcrQ1OZ57/3wmmE/sf6
         anVg==
X-Gm-Message-State: AOJu0Yz5juHEVw/0+fd4qOxqxDK0swb1aKOE2t6Y/C6eJY+kcBZCS51m
	lYUW+JRsBg+6Ocbpm75pbQY0jmNPDCs4EX+R/e066rq1L5esfPoLjV5OV7gAq7Z8phFh+KPcJQW
	l3LYcTgYPvuL0r3zvmQmBXw5usBw6IGN3sxM4lPnoTxV3FdfX6X/gjjtCr86aebkPdTI=
X-Gm-Gg: AeBDietR2vqARihNSJOCoJQhY7Wnkp3BKk5Lf7+sRRI0N522d9PG3g6vlrzIqiEXQcf
	85pTc0Rk31YRu88Yyo4SGfjWRQuiPTkp9GoGaiuJfiVQYXYayEV/QwereHLNIxL4WTi/Bv4C+R2
	RvhUeOnRLTWMRcpl8hgIf/hkVZD+TchuNDgNXgiWbTRtPCyQJjncmofLLxvgbForHU/Z+68AdRU
	OyDDdNckE+qr9eLnEsmBNnTaUCIvwiGAF80GmlgoaWToJJdk7mcX53iLNTKjgOEXnKW6Eyf2Wlv
	63Keahs48IK0GWHZ3aECiC9kiIrQABXoxPurm6W2FulRWXokpc9QaZXI63D1xu5YTmIKhB6AWeD
	Ku8A4d6278Dm4Z6YriWy40jcchslzXm+k7EuzPT0tKR1HUIN1VhqiAT1ATGLRrV04fHFKz57CXW
	DH5PfpH/mHguQc+wonr+n3Q7f2TtPoS5eP/9+MmBXSU80iNR4=
X-Received: by 2002:a05:600c:c177:b0:488:aa3d:faca with SMTP id 5b1f17b1804b1-48a77b12ac3mr112112545e9.18.1777464087014;
        Wed, 29 Apr 2026 05:01:27 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:1b06:3877:bfc9:c6ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c1c2b37sm31361275e9.1.2026.04.29.05.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:01:26 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Minqiang Chen <ptpt52@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 1/2] ovpn: reset MAC header before passing skb up
Date: Wed, 29 Apr 2026 14:01:19 +0200
Message-ID: <20260429120120.514491-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429120120.514491-1-antonio@openvpn.net>
References: <20260429120120.514491-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0757E493D41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mandelbit.com,linux.dev,queasysnail.net,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com,gmail.com,openvpn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282365-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:email,openvpn.net:dkim,openvpn.net:mid,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Qingfang Deng <qingfang.deng@linux.dev>

After decapsulating a packet, the skb->mac_header still points to the
outer transport header.

Fix this by calling skb_reset_mac_header() in ovpn_netdev_write() to
ensure the MAC header points to the beginning of
the inner IP/network packet, as expected by the rest of the stack.

Reported-by: Minqiang Chen <ptpt52@gmail.com>
Fixes: 8534731dbf2d ("ovpn: implement packet processing")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index db43a1f8a07a..d92bb87be2b2 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -85,6 +85,7 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	skb_scrub_packet(skb, true);
 
 	/* network header reset in ovpn_decrypt_post() */
+	skb_reset_mac_header(skb);
 	skb_reset_transport_header(skb);
 	skb_reset_inner_headers(skb);
 
-- 
2.53.0


