Return-Path: <netdev+bounces-259196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Mu0IrcslWmRMgIAu9opvQ
	(envelope-from <netdev+bounces-259196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 04:06:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C55D152C9D
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 04:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 045A7303E498
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 03:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D732874E0;
	Wed, 18 Feb 2026 03:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2hZlaXf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEEA19DF4F
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 03:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771383985; cv=none; b=eRQhIEmY6B7cj7iQ6wY/X9B1BNVo56lfhzxX0Mjttkw2r3q6GgdSnlYIwW4Tv8i5P/1ye/aoaFgsz6DY0kphDl1kx20cpIAWpLHf3URvHCTkB74bGeNculJXU/YwAnH1YulEK1X2lueUq4DZ++fwBLFXgLb3Ek/fA9o5gKMD0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771383985; c=relaxed/simple;
	bh=lpXDhwDt7M7bVF11Uw6qzFCsVYaslNnh3blirfXhByc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEUjOPd3zuiYEAvhCjqSRaLnbpbTZXNNbZlEdXqENdoXHrl5jP1kCI3BSGvGv9WcGYG8PDLyUWtg0JmKhfMGY8MpC3YfEgaWtwULDpLOMxV0VeT2B4rmjV9gyGimiI7Z++9sXHMZTWXVbguAk9Q8H+tlIn5R2hUZX3q4aamXL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2hZlaXf; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d1872504cbso399154a34.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 19:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771383982; x=1771988782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44uTeUd2c473NALQsDJSupHm1e3w/A5YaHo3jbN+xAo=;
        b=G2hZlaXfqfNJOeG83JRX7ZtSlj6D5wuQ/lUz4Kiqbdt/3EENz9/pBxmBeG9z0o+JBD
         0hcfcJRW8MrwZVzHjLtPgBXJ1rO83MQlRGysWXtbDkyyC1NF5458VhV1sTd6eshIWHld
         1QTMD7bsJPk89HY7EfjUMzVMzaX5lMFhhSFqJYd3s7RJvVr2lgetLsk51JIxyf2BMmA9
         6iIZWCuFqStmrJ2vOIUmxwQjQtRPgHMUm1td9eUcMDEzTM5vRU1Ojz4+7Mace7EbebtL
         1Ba5tmVl0F6Mn16dd1dx8ZS5AnmttdW3Tm9EDm+ZtmfogYtFeVH79SOEy3vyuQvlBYaJ
         IRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771383982; x=1771988782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44uTeUd2c473NALQsDJSupHm1e3w/A5YaHo3jbN+xAo=;
        b=DS6e9F9DFRnoOqi6rlEGUUU5BNp2+plaMPrieTwY3VW9CdSfmllPDkg7+B9rdcD8n8
         3IGUdFiig/hqpH21Rno7Mmb3BEiICpC+Tpa8WMoCj82TWkX4J64e3Hx0MtN3GzlIkrmY
         r3MzjfXVv9sx0qtJBpWXEkd9yCRtIaPA6lnQW2Tu478hVg4fsfNRyV89fHRxPOVnyF8j
         okHMEJFIyf/LEaXpSTyV6ru66P96GT0EjBaok6yMiLr3vMgdzwkPzpugApBOKXp9GOP3
         oNcO9lnPYqrZH2j0Yyz8W/8uSrEA2uiMz3ZwF/YKSt6PHv1T0EczGfPoHKhuJ9XZw3xb
         lJxg==
X-Forwarded-Encrypted: i=1; AJvYcCUTAD+VPDLc0PrpPqUoaI+hsC0L2Bm7ISN3Bg+YwQd/5ShPVUO/wSVY9Bwus3WDV60FLAlMd0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2Bj9t4ipqcRfeOH+Gx3cO0uTICat4hb/eiEa+sVuWTlS83YH
	RCfuXedBkCcaQ37X5EJl2j2dq2C1Zf9wpxEibDYsvaYYTeKkN6sUisPe
X-Gm-Gg: AZuq6aK+2PsYlxe31G7n9ufK1aZOrkLDNLfNuC7letiLwshzsLHd7IpYittv+Bg04MA
	CSEGhE5S8fYP03quCcCGBUvYpP7hC8r/tV42orsW/urCW2NmKjp+0djnLj2OmI9eKK2Ve5GSndA
	LIt9bUxfPaHWbXNZbII6N7QStmxhpcJtKQZmgemvyqZT1z2eqCH+rNiUOmL2C6Yzndw+vtZncnO
	IgB6N+gjXHH8YjLwGEwfc5ONaqVXBkGm8opRiiRKCcRiNjKZ9dDaQxC/+n8YpZkRGTWsT6hrBKq
	6J39odJG4CRJg0PLc0kx85TZ/R6UGMdaZIUhd6OOZ4/L5iL7xq3a1RxtSnA3CgcvTw0K4a100Ek
	r2L3gMcVHw6JU7sR8+QAE/OgefHJlPt06W2GFHfE8R4kOFN54FF3pG/auiq42qrPx5tVz9xBe+W
	Z/HSQkctUeLuMWIZicuCSvCbFX1JHPVg==
X-Received: by 2002:a05:6830:270e:b0:7cf:d075:2674 with SMTP id 46e09a7af769-7d5062b100emr339790a34.15.1771383982000;
        Tue, 17 Feb 2026 19:06:22 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:4f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4c22d11a3sm12113537a34.6.2026.02.17.19.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 19:06:21 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH net] eth: fbnic: Advertise supported XDP features.
Date: Tue, 17 Feb 2026 19:06:20 -0800
Message-ID: <20260218030620.3329608-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259196-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,google.com,redhat.com,lunn.ch,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,meta.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C55D152C9D
X-Rspamd-Action: no action

Drivers are supposed to advertise the XDP features they support. This was
missed while adding XDP support.

Before:
$ ynl --family netdev --dump dev-get
...
 {'ifindex': 3,
  'xdp-features': set(),
  'xdp-rx-metadata-features': set(),
  'xsk-features': set()},
...

After:
$ ynl --family netdev --dump dev-get
...
 {'ifindex': 3,
  'xdp-features': {'basic', 'rx-sg'},
  'xdp-rx-metadata-features': set(),
  'xsk-features': set()},
...

Fixes: 168deb7b31b2 ("eth: fbnic: Add support for XDP_TX action")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index e3ca5fcfabef..b4b396ca9bce 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -805,6 +805,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->hw_enc_features |= netdev->features;
 	netdev->features |= NETIF_F_NTUPLE;
 
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_RX_SG;
+
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
 
-- 
2.47.3


