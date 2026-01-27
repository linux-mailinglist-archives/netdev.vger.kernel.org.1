Return-Path: <netdev+bounces-253657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMH3L1EeeGkKoQEAu9opvQ
	(envelope-from <netdev+bounces-253657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:09:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 658618EE34
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5177230067BD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D5F2D7DD2;
	Tue, 27 Jan 2026 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcRrFefQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF822D6E4B
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479749; cv=none; b=lNsauYDs3Fr+3SOnPoU1P0jksai4LVd45Dxvf7pLo9hT74VwOcP1tV9RRSJ9l5FMQMJMj8AQiTPV0+vgiAOdNcbYunvd7G+iDtbRctkN8A+nz9xqHEVpnisVZgEps9Vna+LonnncxRtfEBeWXqPdOdp1lxUHpXt5fRWoInuYjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479749; c=relaxed/simple;
	bh=0t0dl3v9CeZspqERK8OCxRJsZj/7BPyDqzX+ailEm5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQARsGrqVU3jJD5IG8uh0hMsYEV5i1uVL7HQqXWK1gW4tM7f/x8TrFC4Z12SZljQvCc1Rj8I1xYqVwv0H+gp2beU5tJL9HQ6nQdULDzOEwh1Y4uNoi12h5dk0pPIV7lYJXHTC/2YMNA1GBJRVwM5W2QCCua3d0U1T0Hq50vgWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcRrFefQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-352c5bd2769so3256235a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 18:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769479748; x=1770084548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpCifLiPOJS30ldSXwTRHj3fHBDp1Tvh3VJtIU/qW+o=;
        b=LcRrFefQStG0Dqq5FNAOBKmuT9u7G7fxmSpbJ6h0YLWJXpsV9rTXcKex5GAGCEXWne
         YOyQsshvq7pH7+eILpismXTIt655nm5Uavx2g4itGwG1QrP6npDNQpLqXw7Ee4lRu7cI
         wbKO2dQGsdnqOgq8I6CXGncWFq4GnhrhAxFNpiXTzULbz4821U9VTKB3xD6Wr+zqixTc
         4W5U8qdjdc0srU1OapECy1iHSjNtAw3kvYPUaHAObgtMuT6PZaizpG7Q3jv1tPF0UejN
         xkDsPD59c6mAgCA3d18OT4q7qUd4qmxMg0m0xCpcwUiFRMx5f85LoUxVNMx6g2U6Zz+U
         yL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479748; x=1770084548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vpCifLiPOJS30ldSXwTRHj3fHBDp1Tvh3VJtIU/qW+o=;
        b=S/HpmCwOKCMMyv8Yv/0nAMS+EOB+abVvpe2hqRmTOtv1bj5jWpltCyplpMSXU0Dn4k
         eYgd8GbD76MLHbiwV6N1GyB/nZF//o3yzYWD1KdE1cCaBAz4V6sV85z0n6IjgR4kDd6G
         z0uBhGn4YVq2GzAkY6Klgdp+TN6AZZV398NTciDBH/nBJEhK8C8vaSvOiXlyaupjYBmR
         mzgAtIWzr4TOcL+D/QuieopWJ7YhaH05rPD62Bkg3MzplHyZeABxIAbgQNhNVyF4UC6X
         9G0wuIBID4Agd2Kor8fcJzRIfIg3hSNz2I+zWcuMY/UHAtlDxXAefvXwgRCSa3VXq14m
         uI+A==
X-Gm-Message-State: AOJu0YzZxxxsGI6s2imFzQLIKQFLP1FLsivM9SJ/m0It+cdjzCCurk8K
	GjhBy8UfK2qFIOW2qH/pbgMVxo0GKtBZzs9qU6qaDgXfwQF/WxYOmvLuLxJ98w==
X-Gm-Gg: AZuq6aIUnSfFjJYRt/xLQNtY4w0g37JHKqNE5gOF6V3V1/FicFdg3o9hPhEfB8t47w9
	kXwXCLPQdZj+vR6FFZwntmS8cY7d+S7VYeffgzjtpDEOMLeXNmmgoBF9OKg0tV06mRhFceOyRhT
	hQRyG09leYQfE2kA3nbDPp62PxoNNUXwUoHTlMmd+vN/udWgE/lCdnzsosZQogNxLGXBp2F+Pa2
	Pu56qzk9OB3P0zR7Nwme0vq/3+NN/FIz4hCTVnNfqZK6iL4yRpTFDtGGc63S+1oQKl/YVwlWL05
	KdqzFU27mkqs85iG9q8Clo0ZidWGqMLUZ2gyit4f91nui7sfgdbtypZDXL623BtItIzaTcbkITV
	iehwjjr2gTpVrW+flQq2MklYJFcaazXIEhnEa7nJ7M9/LzS4qyzgrml53anQVDP7xM9nGZW5Clm
	IZHjHQIhZjcLULhNrtTEHJ8dQS1llZZvd/OorJS5JsEMYpCWO2UOrXnw==
X-Received: by 2002:a17:90b:560f:b0:347:5ddd:b2d1 with SMTP id 98e67ed59e1d1-353feda7677mr276391a91.27.1769479747594;
        Mon, 26 Jan 2026 18:09:07 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f613fc36sm693540a91.10.2026.01.26.18.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:09:07 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/4] net: dsa: tag_yt921x: fix priority support
Date: Tue, 27 Jan 2026 10:07:58 +0800
Message-ID: <20260127020847.1482724-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127020847.1482724-1-mmyangfl@gmail.com>
References: <20260127020847.1482724-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253657-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 658618EE34
X-Rspamd-Action: no action

Packet priority is part of the rx tag. It defaults to 0, but adding DCB
support to the switch driver will break the tag driver by setting it to
non-zero.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/dsa/tag_yt921x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index 6bbfd42dc5df..b93715a057c7 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -17,7 +17,8 @@
  *   2: Rx Port
  *     15b: Rx Port Valid
  *     14b-11b: Rx Port
- *     10b-0b: Cmd?
+ *     10b-8b: Priority
+ *     7b-0b: Cmd
  *   2: Tx Port(s)
  *     15b: Tx Port(s) Valid
  *     10b-0b: Tx Port(s) Mask
@@ -33,7 +34,8 @@
 
 #define YT921X_TAG_PORT_EN		BIT(15)
 #define YT921X_TAG_RX_PORT_M		GENMASK(14, 11)
-#define YT921X_TAG_RX_CMD_M		GENMASK(10, 0)
+#define YT921X_TAG_RX_PRIO_M		GENMASK(10, 8)
+#define YT921X_TAG_RX_CMD_M		GENMASK(7, 0)
 #define  YT921X_TAG_RX_CMD(x)			FIELD_PREP(YT921X_TAG_RX_CMD_M, (x))
 #define  YT921X_TAG_RX_CMD_FORWARDED		0x80
 #define  YT921X_TAG_RX_CMD_UNK_UCAST		0xb2
@@ -98,6 +100,8 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 		return NULL;
 	}
 
+	skb->priority = FIELD_GET(YT921X_TAG_RX_PRIO_M, rx);
+
 	cmd = FIELD_GET(YT921X_TAG_RX_CMD_M, rx);
 	switch (cmd) {
 	case YT921X_TAG_RX_CMD_FORWARDED:
-- 
2.51.0


