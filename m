Return-Path: <netdev+bounces-292315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IqlDhv6FmqCzwcAu9opvQ
	(envelope-from <netdev+bounces-292315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:05:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A05E58CC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8B15300CE7A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DB83CDBA8;
	Wed, 27 May 2026 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRbl+Os/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB41402439
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890277; cv=none; b=ArdL74PAk34KJmp9iXim9qRT+jfo9u3qrDcW/xw/PfnTYCcvDJaPx5n/8Tb175pdwAuHQJWCnky2KY/FZ0Mnqrfmj7Ea83v3QlRJBW5PE5ls1PmHlbgway5C0bzZUTwpE61hO0jGei2Mf0Mv/JBhfNe8uOe4NdIF1cY59bP/pd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890277; c=relaxed/simple;
	bh=eZu08mVs02TntUL7GMXdknTj6wwcyvaBBkvZpAxupeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgInCsaHhoMd0AFrBGIcxFQrgW+B2xyIEs2Jq+QZkApmztF3B3BoJWTLuZ85qISWtwaa4tXgZrt2JdacjG1z6fWOyKnvPosAupo15gh7FDAHrTTCzmVZdgWIrUbfyKKu6p++LTx4C/n+lJjLRX63vyxObsheKLOp9vFVJPnzgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRbl+Os/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so7487384f8f.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890273; x=1780495073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylxspOikl//hUYOHTbCgkMeRhn08cWcQtF58xpwNlyg=;
        b=kRbl+Os/RBeRxw8GuAPgMwvooTT2cYkvimcE2CiNAhVYRID4+FsN/KmJ/n0BPPyYZG
         7mFp3XSaQkjZL2kW9zzRIunJPgPIbeoKUyUKrq98QbgjAuux4AF1aEuSRLA9zbH/VZNc
         e53CpKo6CicERJpmoF9vojJCZBabseM3uaL7ZbpSnbn/R4vnXjrs/wHDpCq1SdtH7VaL
         /xjps3af4vjbFagMPDdVf8RUj6wsg5ug8l1D0qrXAXarP/93tgybnN7Q9IPOlxNdvRAl
         DZg4KdVTPCi31K5FVOswFa6y3mNPp5S5t9XuH2p2AdmlaOV3GArh0y3M2S+ur2YLHl4/
         yErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890273; x=1780495073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylxspOikl//hUYOHTbCgkMeRhn08cWcQtF58xpwNlyg=;
        b=T03jV7/6RliteMjO+MFN+30qZLujJfNDFtuXPQ3LAvQZD6RBNp3sxuUv1ohWO1iBWl
         6mf7oTwelNuIU6AJz+XM6O/wGvKyHmfLYYzSGhSHXDvQZKnYY4Na6jVUEUqLFdv+rBzn
         sNKUg1R/hBYs5bYdxoGxUkf3l50j4ibCfi7x52pz3tsWcSEHVPclthNlwjrjkUfa3B6J
         AD51+kPhLOfCu6NuubtKpU0D4v2/+yz4l75KZOGPIpwmUpURYq6+/6fIVsEABfWWK9dj
         wWJ2SlRNMY562iHLfSMAc4Ya5dx4oby6hMdtkIAAKLdLXTYovcHeF11LU0iPI5USHGWq
         ldBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9un8i7IeWLn8Y6dqDw84Cce5Tho2OO2rQ3rfW48vdzT08nox2elF0I8te62W3qu6v1N0qCzGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/a5gyRYsJWQDJ99zj1mBetnOMMvYWs0HykAt4R+dCUUa3w8t3
	XiluaMF+h8FAaj8tgGNEKfYWUXBH2jO2uSg5MZZx3hT0IoLaCn9788P/a3mD
X-Gm-Gg: Acq92OHpy7eskXfu6yoBODpe2Y2co1rJbksS7DWx3rqksfOYBXs38PUQio/XgRDTS6p
	Oya2wvNkHZzJcqPZhWnhaKkAblUFl1DU0de32L09bA4/QXerb1Ow5oMA6LRkq/b92PAuiuC23AD
	9aoYkeIp305dbX30+ZRTT0YkTy7kbPhRVmdPISJFC8IvaxQ460tTQXG8EGuU+uKfaBqFdBbXroE
	Y9G81gxDOZ480GWblTKeN9X57bh3+Fjbi54sc99s8r1w8mZFrFamPjM08df0lfZEbMvyCyGl3Gc
	mFznm6X5MDoclX6NVlaUXlKheaPqBheG9jZoiWUhlYeMAp+YI+DUbh6/XHPMVWzTUqA+toYCUQB
	0mUCNX55M5IvipnU3HyjYkA98ERwkGZXvzJPmK1+x2lBY+jMu4bJ3cDg4XFXSXwQRb/qqltwe1V
	MbcbU=
X-Received: by 2002:a05:6000:144c:b0:43d:77e1:6a69 with SMTP id ffacd0b85a97d-45eb38c2026mr39606398f8f.38.1779890272700;
        Wed, 27 May 2026 06:57:52 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5c2323sm6388642f8f.34.2026.05.27.06.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:57:51 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] netfilter: nft_tunnel: fix use-after-free on object destroy
Date: Wed, 27 May 2026 13:57:50 +0000
Message-ID: <20260527135751.1031891-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-292315-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,talencesecurity.com:email]
X-Rspamd-Queue-Id: 382A05E58CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

nft_tunnel_obj_destroy() calls metadata_dst_free() which directly
kfree()s the metadata_dst, ignoring the dst_entry refcount. Packets
that took a reference via dst_hold() in nft_tunnel_obj_eval() and
are still queued (e.g. in a netem qdisc) are left with a dangling
pointer. When these packets are eventually dequeued, dst_release()
operates on freed memory.

Replace metadata_dst_free() with dst_release() so the metadata_dst
is freed only after all references are dropped. The dst subsystem
already handles metadata_dst cleanup in dst_destroy() when
DST_METADATA is set.

Fixes: af308b94a2a4 ("netfilter: nf_tables: add tunnel support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/netfilter/nft_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 0b987bc2132ae..68f7cfbbee063 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -676,7 +676,7 @@ static void nft_tunnel_obj_destroy(const struct nft_ctx *ctx,
 {
 	struct nft_tunnel_obj *priv = nft_obj_data(obj);
 
-	metadata_dst_free(priv->md);
+	dst_release(&priv->md->dst);
 }
 
 static struct nft_object_type nft_tunnel_obj_type;
-- 
2.47.3


