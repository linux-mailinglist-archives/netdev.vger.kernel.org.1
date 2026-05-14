Return-Path: <netdev+bounces-288047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJIAFR3+BWrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:53:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD413544F69
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 505D6307354B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9CF31E830;
	Thu, 14 May 2026 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTvNdvcK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935333176E0
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777527; cv=none; b=NnGXkh1J10cFsv/mYp93qnd69bac/EnZRo8/cbURe/y/ifIQcnSsQrcMIJ3473dIQhFOrMTByr8AX4NWcBOTbzLAVFq8X3fFhxYFPAgaipdJviijsY9oz9THDuRug1e2aUmbxeh5CG3pFw3DFTBp9qq0MM3iln+3Eayk1/5FmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777527; c=relaxed/simple;
	bh=EEBJAfZmjfkpZOGOEVFX0CZS3rPpON7xamOmHMjuQC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwbt7fBEzG2pnpjhVGzVDq2kYQiFD3T0J1sHwbTm93eIzbF7CORe6WczeF2IzoRZoNZNGmy8yfSn8e0lPdVRw9fPZXnOfhO3+C7gGjuB9jgT7zvTAPAFZgRrg88vjSKBC+XyeeinsoppsFVasMatTQbRnz+ddJZM5bNWAJiCdFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTvNdvcK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b941cd869cso52682845ad.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777524; x=1779382324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTws1unEaZCkPMbtIVOShoAmXukkkseioq0bAhEtMn4=;
        b=PTvNdvcKk4OaAc8TIqBV3X2sinIU5wSnc/QXp4vNj5farp7xXeSCO6EJa5suKEmMgT
         twlqv7gFncd3GEGsYUV2izXLCqD8fRawZcQ+wDMiBy4z+5d18UIQezJ1qWoZKvDg8bjD
         ac0Eyxn7VV2E70X4m0N+GMxglcO4Dd60AsGTO27wpA7df6AkCfws9/x4u8PGA9Rq+PKW
         0dAquRkj9T5JDxbE2aIrsOI25ycDllEdtGFHtuadPKc+J+d6SgDrLG8OHqpejkZ1IuYC
         +UjDf58zZzDjs0oTYANWcViMIUPFlcitjeUAT6hRalkkwqZYj5oazeQzW48wA1h45hzP
         I+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777524; x=1779382324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTws1unEaZCkPMbtIVOShoAmXukkkseioq0bAhEtMn4=;
        b=YMdhXA6R+qKzyLYaWiyIJMh/pISYNTOAJaPCyDHLY2LeKQByaZxi5bBq6GsCtW+1+U
         e4WjojXhpqIipYUt9zPVQ8P75YPIR8kcdfZ+KJMo9wWCePBIQv1gk1sShv07W6bWz60i
         kto4M2SKVNtJbz7JOmW+BSGeOQO0bHPB0e4pHzz8g393lB/jglHrTuv1ywv1cVgnmVYh
         mr+qq1uUPbXfq5aKv0yP7EJamGutGDDi5X4mVbxGuJQzLqV0kMwyxGN4MqFgkhPdllY9
         nxIAoKjOU024d+DMokXupC0FnAlOFEDcWcqFxR5nmuiLHlwDzp2yn6oNpj8yWnXYd+1G
         ASRQ==
X-Gm-Message-State: AOJu0YyxC2Tb3tFc+h5OJJjIgfvB2q69VvhAEXFopE5fhEaudknX86Oq
	ZkilvDNw4gq70nzEcYynV6c4Gu6oqXLjLj2Uqp1iiL9hvu7aczTPh464
X-Gm-Gg: Acq92OGdf27rL+pCAAZERqZr47nRDS4uY2maX6ID4zBRn1Fd82Aa/4DimX/PwOWokrW
	AoGXF5oMSeov2lENXFkAom+POkXjGZayGvcd8wjpjImiUC7sPR2ccIY+Bb7j7gujEhYrK3flPkK
	h4/hlcFWNQw7eS8zkCV80ytOrv7qGsyyuP9rNQYVEo/IVJgVp/ENAty9ok5JhBwXlLjncrL/Akc
	3mcvSey2497E+56l7PY/r7UL6oMBhbcmc0QdSmYJ3Mk1Q1OsMkkPI2eFSKh+Y/v1YvcuyVGFcsE
	zuhfBYruA2HslMVSVjbi/IL1LBWha/yckYQGzLPbYXIg6xKHUEdS8QIwxOYg+/drNgK9ccOIDzf
	hPRW0UkyCFSyQeKBQhpkf8mM1RN53ek3cNyCop7bJ5kfxhG+ZbTM6NFn3z1gH4w8tNbGvod/oGx
	MqRYDoDr4WZr/T1v9FR+gwpq9iEQsMGw==
X-Received: by 2002:a17:902:d512:b0:2b4:5f96:184d with SMTP id d9443c01a7336-2bd7e86c6a4mr3703895ad.5.1778777523797;
        Thu, 14 May 2026 09:52:03 -0700 (PDT)
Received: from Tplus.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c2631basm27937825ad.34.2026.05.14.09.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:52:03 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Simon Horman <horms@kernel.org>,
	Huw Davies <huw@codeweavers.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net 3/4] netlabel: validate CALIPSO option against skb tail in netlbl_skbuff_getattr
Date: Fri, 15 May 2026 00:51:33 +0800
Message-ID: <20260514165139.436961-4-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD413544F69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,paul-moore.com,kernel.org,codeweavers.com];
	TAGGED_FROM(0.00)[bounces-288047-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

netlbl_skbuff_getattr() locates the CALIPSO option in the IPv6 HBH
header via calipso_optptr() and hands the bare pointer to
calipso_getattr() -> calipso_opt_getattr().  The consumer re-reads
calipso[1] (option data length) and calipso[6] (cat_len/4) and walks
calipso + 10 for cat_len bytes via netlbl_bitmap_walk().

ipv6_hop_calipso() validates these bytes only at parse time inside
ipv6_parse_hopopts().  An nftables PRE_ROUTING payload write
reachable from an unprivileged user namespace can rewrite both bytes
between parse and the SELinux/Smack peer-label consume path
(selinux_sock_rcv_skb_compat -> selinux_netlbl_sock_rcv_skb ->
netlbl_skbuff_getattr).  The self-consistency check
(cat_len + 8 > len) inside calipso_opt_getattr() is defeated by
mutating both bytes consistently, allowing a ~232-byte
slab-out-of-bounds read from calipso + 10 whose set bits become MLS
categories driving the access decision.

netlbl_skbuff_getattr() has the skb; gate the consume on the option
fitting within skb_tail_pointer().  The IPv6 option layout is
type(1) + length(1) + length bytes of data, so requiring
ptr + 2 + ptr[1] <= skb_tail covers the option and its embedded
bitmap.

Runtime confirmation (Smack peer-label policy + nft HBH mutation):
Udp6InDatagrams increments to 1 with the mutated cat_len, showing
selinux/smack_socket_sock_rcv_skb -> netlbl_skbuff_getattr ->
calipso_opt_getattr -> netlbl_bitmap_walk runs end-to-end past the
option's true bound; with this patch the consume path short-circuits
at the bounds check and the counter stays 0.

Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly.")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/netlabel/netlabel_kapi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 3583fa63dd01f..4af8ab76964e0 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1399,11 +1399,20 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
 			return 0;
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
-	case AF_INET6:
+	case AF_INET6: {
+		const unsigned char *tail = skb_tail_pointer(skb);
+		u8 opt_data_len;
+
 		ptr = calipso_optptr(skb);
-		if (ptr && calipso_getattr(ptr, secattr) == 0)
+		if (!ptr || ptr + 2 > tail)
+			break;
+		opt_data_len = ptr[1];	/* IPv6 option data length */
+		if (ptr + 2 + opt_data_len > tail)
+			break;
+		if (calipso_getattr(ptr, secattr) == 0)
 			return 0;
 		break;
+	}
 #endif /* IPv6 */
 	}
 
-- 
2.47.3


