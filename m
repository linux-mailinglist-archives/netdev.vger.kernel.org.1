Return-Path: <netdev+bounces-269868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBozEsQWvWnG6QIAu9opvQ
	(envelope-from <netdev+bounces-269868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:43:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B72D82FE
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B61E3002D09
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041F3783A2;
	Fri, 20 Mar 2026 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0a0Lq23"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B720E38644E
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999807; cv=none; b=W+hexxDqIe+o48GybMhnyjq1Qyf42bcE15q4j9Woy0UZdDtIaSLkwLS+RzW+ZKTJYUqDQ7FML9+XqjqXSfJEQvMHXOJPLhIzWo+eI89iWxJ9imAH/ahGvzNWRv6lqZHbVFIfeYXvv7NvZnG/v5HvZ216DTN3LSj1sJTAwrGHFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999807; c=relaxed/simple;
	bh=fB3+eCo1aFIZkSrmwEft3K2aH7wuz7JoHABAXhiw08c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tEVdT7UgtP2Agwq3EJWFPyfHCUQ4mn8gmb3VAnDi6Xpfo+dyEfzVk9/uRlibW0Byyywkz79Fu7WmHlFrGB1IF8ZieYwBDXX0IVUo5f+inK9tKh9RfGvSmY0rfqccyRQCFDv0SgW+nyN/3zXWTl7rPveVaOAL2vBcLW/CtgOt/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0a0Lq23; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6644a3029b3so2483177a12.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773999804; x=1774604604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MeYQRWtpyoz4pJi30E77WFExzgm8N7NsrkcrHIJmdr4=;
        b=C0a0Lq23IC/pK+K7isYCBAGlbfz/hp5i/HewEoY+sTNVhVW8uFLogxJaO31g2z/p/L
         T81mHdbFO0TYbQjl8V8pP5gNIdLlF23JaF7/ta3UF0/NlgKBBExTQABC3xxFTHVlReQZ
         7xLdSdTBD44vJPpFpsLu4yCxWD90+DvXhZB/aDXs3wMk3NVmqHpabozDnxmvOP4bI5V0
         lnBBiaAIFxtFS3Benqh4gTi8jugBW5st6CnMeeQh1D/DBVVj5dwlNWJNM1ORzdANdqs2
         +EvvhH2vDr0Mr1SVl3EDOd6PeBfl6LSU0rXI1KGvNI+MSJlqbiR+qNE/rByuYTtA4GKQ
         5xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773999804; x=1774604604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeYQRWtpyoz4pJi30E77WFExzgm8N7NsrkcrHIJmdr4=;
        b=ik06YTXZcvgvgJm+0ZrDUiXu6iWxTMC5UaQy/t2smWNYCYbTAfxQAjR2r5OcoIn1s/
         LEJg1jGiRii0DAPQp2n5aSf3YDO6GyNAd9LDY5pj85diiOa4yKYs6d5RPo+Dh6K84UMF
         07sOQKq1nQLkveVOr0NtxiwjjWaVi+kHOqnOqri0tj1N/ZGxvKSIi0xt8ZgL88Lx0QZW
         C06j9vY8/Ww0l8XFnIKCbeLtBNYCAlxSpS9kzm2edVGU1tiG5BMknx2h2yJPXJcX9Lz6
         9ChpLUpA40y6ikv04oJXCWjEIZLcSXc9yufgn4fUdFuzSikwyUsitlSao3YMVDxeuV70
         1RXw==
X-Forwarded-Encrypted: i=1; AJvYcCVED7c3Qx/xEQN5nvdxP0yfl2PAGqEUbqRJ1tmnf5FW5t29xbnihRgUm6zTTmUpQrbVRfS8Qfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDf68cIZaXxtZa58k0/cnOYAqGaSBpIjIqY14L4FdoMeqiBY/2
	121CCPwEaWFDAxt76XkXdwLcESbwA6efbCFosO3fCncHHXt5KeQorph2
X-Gm-Gg: ATEYQzyHzEudrV9a0OzPVxuE94CmSqgh+28p9cD+/Jx+sUNikSvPw/DdcNWRYInd1aT
	lrKQpHlfVpkZNbfUZgFoNWiv2OojpvpKcz9cvEdokyj2I50/nbACgTK/0ImPdMXXC7qNxfGm9j6
	cTiqEiTxwhAH50NPre3StgkIEKzjGVUivPqv+oICyxlyHOcza4fKjkLeRL9Qkjz1n82WB4/iVEK
	mqkeHf7HI3Apq5oIaks3VeKDFFdnVxvUPPD+T/l5buyiU4JhW0Uw0BXbkHm60J/guZsDa2pfd3Y
	kCS6fe/UYzST5Gzy4HnClteOPtf+qseuKoiPryxCWiYIqVgDLHjzvx9Lk9JwMIZ7/Wsp673a5N6
	m3F+SSv3QU1HJoMxTF0FkARWcVHR0k51EUOpEYJ7Lrsaw3+LeLYQoZHnSa4r2xfNW7kThxWq7Y9
	0gkTKHuAPZYJbQwg==
X-Received: by 2002:a17:906:7fd0:b0:b98:1425:2977 with SMTP id a640c23a62f3a-b982f39bba4mr150387866b.49.1773999803776;
        Fri, 20 Mar 2026 02:43:23 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:4e21:2e3c::49b:47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f8dff5sm131318366b.24.2026.03.20.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 02:43:23 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] net: airoha: add RCU lock around dev_fill_forward_path
Date: Fri, 20 Mar 2026 17:43:15 +0800
Message-ID: <20260320094315.525126-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269868-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.776];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 428B72D82FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since 0417adf367a0 ("ppp: fix race conditions in ppp_fill_forward_path")
dev_fill_forward_path() should be called with RCU read lock held. This
fix was applied to net, while the Airoha flowtable commit was applied to
net-next, so it hadn't been an issue until net was merged into net-next.

Fixes: a8bdd935d1dd ("net: airoha: Add wlan flowtable TX offload")
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v2: update fixes tag to the flowtable commit
  - https://lore.kernel.org/netdev/20260319032649.337812-1-dqfext@gmail.com/

 drivers/net/ethernet/airoha/airoha_ppe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index ec5ce41dad80..02deb739a1c7 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -227,7 +227,9 @@ static int airoha_ppe_get_wdma_info(struct net_device *dev, const u8 *addr,
 	if (!dev)
 		return -ENODEV;
 
+	rcu_read_lock();
 	err = dev_fill_forward_path(dev, addr, &stack);
+	rcu_read_unlock();
 	if (err)
 		return err;
 
-- 
2.43.0


