Return-Path: <netdev+bounces-224411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2278AB845F9
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EE44A2822
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D493016E7;
	Thu, 18 Sep 2025 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ph52zKkK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F42DA757
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195351; cv=none; b=i6bjGXZT+WLPj74I8z7H9XokATHAL/SPvl5IRIpUtt8kw3K/pbZP2OzzTPIAo29mayY4bmxGZh6dNmOqldfMSyPccL+a2bmSVuYXz7N4MTkPvdcf6vbNjKFlylp/Ur6JMv56xgV9IUlS8fWnCi1aLfgS3Iu1FuiQAotkpM0NxAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195351; c=relaxed/simple;
	bh=squjaUGwvjOpSFrNMIz9RrXWPF94lJUUd4ATjUW/C2s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ULGUhNdTAXkDeLFTVv3jfNp0qj63MWSKDmpkSL7jmN0FQbdMJYqvqo/y4FrN2Yavss2XkOYF5j5fZSW+BbVCPwBy/9UkZd9P6LgMN0myhd25d7WTrF/nzYrN1N3DkrVK5CMOXifSQjTtnE6A9yVM6id+VKF/kM1rS2ICUOcLpqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ph52zKkK; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8178135137fso179578385a.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758195349; x=1758800149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iPaw1AZLiquzjsqOMBykQ+uIyFcDfGsfZaCmu2KrsQ8=;
        b=Ph52zKkKqksrSAIRZ5o9KilIs9H0bYNFVpU2ew15RyAdwpiqvAbszaDFBXMaB8wYrW
         KuS7N1T1iQw/hmVTrwIS/ZtUbWj5+DCGJDCH0FPJ7hHLqB0W5mbU9slgcgash929GRgr
         jN8l3IDIGdbZk/zEjkO8iH1A6LFh/ea5tDg3lo5n418XaZ4jUm4EvibA4vBmktNqLzXO
         fLkKCy52d8oTIWh4OyLgKH+5yB3Or7uPdhL1FVjJWTeIt0avWJqiOWneOA4cl4XPwE4Z
         3xeUL90JBArFZma0SP6FQRF28pWuNXZpxo4F1ItY2FeELCfN0pFQZ17s5bUtMXEDYSNl
         BMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195349; x=1758800149;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPaw1AZLiquzjsqOMBykQ+uIyFcDfGsfZaCmu2KrsQ8=;
        b=DQJyn5NiBtlkZwxNPgp2Yc5OPChTtgGGT1SnWA17LGHpRnZoicpBf6aTjn6sve8UjB
         57CDoBEO7NTY2DlTn1oYiqJJx/lN12kKK0kVq/7iMufJrthMeLe4LEKGSuMJTwzA6R88
         QNPOBUprbWPLEeagjjZYwY03zD8SBoWlz6WZ9XfYeunKxK5sZJMVjMwza0Iz07IJeAX1
         HRt35+KdTsP1XaLpd+xzniAB9bEs+H6y4sgUMlgnBRcwu50O/ILAPABFRocOWNWrRi4z
         OffibYlLjYC874B8urBFbhbSnK55mdEFbn3lpTMysWdrnfSjA2BEBsqlHpQu4L0kCzDL
         M/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXZKOXU+hKJmdTxGBSZ2XqDNJm9BTEavLdmA7FXl2SxzJb/wp7GEznav5Y0Pmnc7ORyOBS2JIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJtl6gG/kWwit+ZmQxBuDHdEYpZrnPlV5zL0dxoA9kh+OkbJ96
	Xwju/DR/QREK4s9Y60oYmiq+5cQkndOKCbHH1arf82gC4tZdB8sISJhG61xsKGFlvXARUKsTwMr
	Uk0A0Vbr1GRFLUg==
X-Google-Smtp-Source: AGHT+IFeGZ62kZQfizVjVTR8PLEct7pvXJ8tFgsngw7Hpe5zJZngEF6kFIkha81MZ9ImQqy6YmlOPCr3iWqv6Q==
X-Received: from qkbdv8.prod.google.com ([2002:a05:620a:1b88:b0:7ee:a726:3a9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7010:b0:7fd:50bd:193b with SMTP id af79cd13be357-8310765991dmr613130685a.14.1758195348661;
 Thu, 18 Sep 2025 04:35:48 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:35:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918113546.177946-1-edumazet@google.com>
Subject: [PATCH net-next] psp: rename our psp_dev_destroy()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

psp_dev_destroy() was already used in drivers/crypto/ccp/psp-dev.c

Use psp_dev_free() instead, to avoid a link error when
CRYPTO_DEV_SP_CCP=y

Fixes: 00c94ca2b99e ("psp: base PSP device support")
Closes: https://lore.kernel.org/netdev/CANn89i+ZdBDEV6TE=Nw5gn9ycTzWw4mZOpPuCswgwEsrgOyNnw@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 net/psp/psp.h      | 4 ++--
 net/psp/psp_main.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/psp/psp.h b/net/psp/psp.h
index 0f34e1a23fdd553861d411c960bc41ebe534a688..9f19137593a03abcf42c5b5f92aae61b1d439e22 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -13,7 +13,7 @@
 extern struct xarray psp_devs;
 extern struct mutex psp_devs_lock;
 
-void psp_dev_destroy(struct psp_dev *psd);
+void psp_dev_free(struct psp_dev *psd);
 int psp_dev_check_access(struct psp_dev *psd, struct net *net);
 
 void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
@@ -42,7 +42,7 @@ static inline bool psp_dev_tryget(struct psp_dev *psd)
 static inline void psp_dev_put(struct psp_dev *psd)
 {
 	if (refcount_dec_and_test(&psd->refcnt))
-		psp_dev_destroy(psd);
+		psp_dev_free(psd);
 }
 
 static inline bool psp_dev_is_registered(struct psp_dev *psd)
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index b4b756f87382c46815f0d74e8b765c962e74eba5..0f8c50c8e94358a060722614a59278320c33134b 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -99,7 +99,7 @@ psp_dev_create(struct net_device *netdev,
 }
 EXPORT_SYMBOL(psp_dev_create);
 
-void psp_dev_destroy(struct psp_dev *psd)
+void psp_dev_free(struct psp_dev *psd)
 {
 	mutex_lock(&psp_devs_lock);
 	xa_erase(&psp_devs, psd->id);
@@ -122,7 +122,7 @@ void psp_dev_unregister(struct psp_dev *psd)
 
 	psp_nl_notify_dev(psd, PSP_CMD_DEV_DEL_NTF);
 
-	/* Wait until psp_dev_destroy() to call xa_erase() to prevent a
+	/* Wait until psp_dev_free() to call xa_erase() to prevent a
 	 * different psd from being added to the xarray with this id, while
 	 * there are still references to this psd being held.
 	 */
-- 
2.51.0.384.g4c02a37b29-goog


