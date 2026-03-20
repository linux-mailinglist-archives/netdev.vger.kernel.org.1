Return-Path: <netdev+bounces-269830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKnONKv9vGn15AIAu9opvQ
	(envelope-from <netdev+bounces-269830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:56:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C202D6E04
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E123630057A6
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3175B31D726;
	Fri, 20 Mar 2026 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbbSApdJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525731D366
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993383; cv=none; b=MlVgz+/uEEa+l0XOi6qA8+9DJ2iV09RbgKL0N4PugXmK5yndU9ojil2SC/Ve/WJw9ide6fxQPLoFOry9mLMmoXJD0BWjmwqdX4Hq58BbQyBqeUUPyMb/jkxdEChSw8DpMAKzhVNTi8U6LQZiHxEG0ABsWW6eFZoeQaTLC1cRIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993383; c=relaxed/simple;
	bh=UAEy2Xe2unCpV2Aisrk8JVqTZDFSxpOzIYuBLw1sdN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POAxhNeAoDeQ96UUHGjl9IDXAQaBV5U/vDosDxaLeiXI4wayEJd7HyZx6Zo2UPiImuJhvuUZWZKyiz/ACjHeHbAD89/kSrVeXtnctRJoKLf4yXrWnTWKlsPxw0TvgZDacSl/BV2jr+pFVWy4cX5mHIviuwuHs19rTkdh4/6F5/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbbSApdJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so214979766b.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773993374; x=1774598174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DHrhfST8MC/cgKssvPyr9ZbJixCQY5nYy4UehicETCA=;
        b=nbbSApdJyCwnHSybwx/1PqJDfpYiZeUb13p1b/Qir9S7qCcw7Dhvt+mQ+Nr2uqk/pq
         zy9ILYgR5ituptBr/iOACfuYrOe086//PAczY3fJoOe3VLbY+1OjjohAUX2Z/rqtut4k
         RCYVeRQAA0TAJKrqPI1buIm0hMKDj8U8kM7JQeaQxaEWpHCLGMe0bxpnKubeYNevSNQq
         QKQmI5FoWDlYYbJcmx47qpTFUGjtIWWVCNoYw/BAj/JzVXpw8UHTTDnbeR8fzKRdBUvs
         uS9rQcfUBp+h/sEz4KByTNQmn7dDSvcROjc5eiGZDadDCXl1z1ObE4KKnUBECLf6O+UZ
         9PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773993374; x=1774598174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHrhfST8MC/cgKssvPyr9ZbJixCQY5nYy4UehicETCA=;
        b=gL4e4ayc9G2PokyGk9sLWHlAwLTzN5XhpngvYkp3vBjZsZEcWhyS31EGCqjgdltq2d
         QhqPjlRFciQGoPdlI6DanD/WEXFbILeRXl/Z6xIqgkAYj8lpBp3EdDTAJJMyUj2n1GAu
         kWprYXruhRsQ1Mai4yBvOG0M6F/UgEB13RMp6x+ELdgXu8J7dzUaVj8pmr1LnlpOi8zg
         UUqJjJA/czDsxd0ruE04hpWS9DDG9WDdsZsc+35nxE3LxIr3rGILcjVpqNxlT6txg5qL
         /PMdZWW2LvGjRUobLU7T/AYdN3K3elbGBftLkdMyyMXj4EgiBp2PBdIFqTR6QRWNgKLo
         bSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXisx2Kdha6xJuozD8C086tiLIj7l/5MCyjPHDe5rjlT0+8s7tPiwKIox4uYVOHUbpruOCwCHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5VjogwFsnURC8faPG9XTUYa2wbBq7nu1fgUgYLw1KEypsBMeh
	oqvOl7LPN5QscvOiw0HB9Y2fu0yu5y7rg3S/WDXg6k4AfO8JByOxrsjm
X-Gm-Gg: ATEYQzz261/vNgGonKJesJ7DFzmjCqHAaJvnu+rFrvuKvWStohM5Gu9rzpORkhKNfFX
	KLKD6bMPqrOGH/EQtczfYKpHoPUe7ADaWLDIEEEoR8bs9SZ0OpFH4Ui74n04eCclTzG842WNy+e
	7CmGh3vEwctzr1eb9u3voXGfe5ccpA/uiYdfOtuiDtonajYgM+1ezkkAJsBTRhj/po6BcjzDAxa
	LjVi3B1YGBo7Xc6paRmAQKRaCiuSjqOCooBqDDAIpNA5x+C6uYpUUFO+uDOIj2dyjqPpN+tALJJ
	RKmY/pSq7AtI+LVYN3+4Y+9zWgo1rZKs6s7mB64lLRpk2HEMxKpdy2vkM/L51hauGQKblkLPbNh
	HDeuI10Nha1+ubb6Ik7VGJafS7gltiXsecnzZa3s55Z0ElM7UHiVl+O61M2R632o2cdNd3ipf
X-Received: by 2002:a17:906:a2d8:b0:b98:50b:e94a with SMTP id a640c23a62f3a-b982f244b9fmr110605666b.16.1773993373952;
        Fri, 20 Mar 2026 00:56:13 -0700 (PDT)
Received: from gmail.com ([2a09:bac1:5540::49b:47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983365a14csm115965066b.43.2026.03.20.00.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 00:56:13 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH net-next v2 1/2] net: add netdev_from_priv() helper
Date: Fri, 20 Mar 2026 15:56:03 +0800
Message-ID: <20260320075605.490832-1-dqfext@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269830-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.844];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39C202D6E04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a helper to get netdev from private data pointer, so drivers won't
have to store redundant netdev in priv.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v2: update kdoc format
 - https://lore.kernel.org/netdev/20260319022608.323969-1-dqfext@gmail.com/

 include/linux/netdevice.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7ca01eb3f7d2..6882b41bb3e8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2765,6 +2765,17 @@ static inline void *netdev_priv(const struct net_device *dev)
 	return (void *)dev->priv;
 }
 
+/**
+ * netdev_from_priv() - get network device from priv
+ * @priv: network device private data
+ *
+ * Returns: net_device to which @priv belongs
+ */
+static inline struct net_device *netdev_from_priv(const void *priv)
+{
+	return container_of(priv, struct net_device, priv);
+}
+
 /* Set the sysfs physical device reference for the network logical device
  * if set prior to registration will cause a symlink during initialization.
  */
-- 
2.43.0


