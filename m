Return-Path: <netdev+bounces-202814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA352AEF19E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E133A9DFB
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8126D22CBE9;
	Tue,  1 Jul 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8iXJviE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC621FDE19
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359544; cv=none; b=X4MUAd7pzu5edGCs3umR9JdfEKFAqiS0j+QWmjZMNToyBNaR2Q1/05gH/ic6T01b0lae5oMv6Ufhp01CwXxjW11lmzwcSmhBvQmXZ2ZjomHL9/WArpXWlZbz7HnwsizhnFG/dcOuW9BmdpCIuJkI4Cz9BiT0KOnKU24snxDsYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359544; c=relaxed/simple;
	bh=SuXcd4PtrLa/k1pRkA5GoGK5jg5M473qJl6hJMm1oDQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NxcZ+8r1d+nqoKkCXvr5acOQErFNLTYsFdAc+alVUCzzHHnKCqGTOf3SOP88L37wOvg6wCM9v+vHowiKVvZ4wa+Hyud3t6NMBUfDy4odH2PCEDxNfi9fWDu27gsU9Z+6U0t32Kz42mqM9L6nGQhRYlmdTTBl7IgUWmjZiEpxei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8iXJviE; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7d44a260e45so599911885a.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751359541; x=1751964341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rr1yO4Lr/8tJk8PW4Ef+0vqq+Av6E3FNkXy3PpPHSdU=;
        b=F8iXJviEMZXRxEPNxSTYn8l5APuTPNVbxfqezu+cr9RNWavVjbK6v3wxlMkXs27ohY
         Idkon08SGCXtnsoLRODUpiFkFEtSi67yQ82TONcp20s1q6ICtVO3Rp1OU59CCao5oB+C
         VW/JH1arL4XEmL/LGY7nCA4/v3latJDiDLnCRovgK0PWlky8hgUdN3hpgELKhWIkysSV
         nPpCNUiq55pdNrmyVjerWPzUVJikabnyF3c0q9cPfuvSD4UJiS1a18U0lf7sOqOH+xHa
         6bFk1cbarvU78b411rKBO0NJDciwDncFh+fXtuYd/GWLJhfovJNlHl1YXIx+t04IjA8r
         3FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359541; x=1751964341;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rr1yO4Lr/8tJk8PW4Ef+0vqq+Av6E3FNkXy3PpPHSdU=;
        b=U/hPdfDkNfxsH91W6ERsq/oGWXM88kbcg8xseFCkh2kNmoBmmxUp6ad8QxK8tEF6f1
         G3ujZmnfJUVYoawHYGLFO1iNJ2aeZxprWt3gU0xVrFmxWtkHvq0DpMZZzfjYwxggsGQ7
         6aNB9eRssWgF2VgSU76t5Tmwsec3AnC6to2gnR7aRgp47aWfwQsNInCIMhOn425Q+E/C
         k6o1IuyPNJU/BKfRGbgq70V2KSMJPicwQy1ZU0BM+mVjoUDjap6PTnLasjcBcnejpE6O
         wqEnE+SYIqQbBraKH2xHZaWsVcBWcCk+o60mhOfNPhICkEnUUJhoEcMGUvi91Kql8Ekq
         pWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHqohKwu2nJJug15rwVjG4Wc0J+gzl8uQO9g2NmYeXmfpdgXe+L8PG+GqZfLzmt43HCtgXXsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoap9nDv1xeWD9QytZqHceHjhRJOqXjO1MVqSudrKpf53x9i/q
	RMgLp5r/CYt9u6sAjAlNz1qqu4ehGygwhB3GybVogIsRUnmk0CBkgTRbPiPM+wC9iSV7yDs3Bk5
	/CPjEAHPQ8gkFNw==
X-Google-Smtp-Source: AGHT+IHg/dM+7X9a31CHLY2KIari8ao1Smn7YpEpMU6oHcHz/A4glnWSQiUcTG1O6pxhp2zGhz3pWe8kr7W9Ug==
X-Received: from qkpl3.prod.google.com ([2002:a05:620a:28c3:b0:7d4:61d0:dabc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:179f:b0:7d3:acfa:de46 with SMTP id af79cd13be357-7d466e317demr351324685a.21.1751359541579;
 Tue, 01 Jul 2025 01:45:41 -0700 (PDT)
Date: Tue,  1 Jul 2025 08:45:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250701084540.459261-1-edumazet@google.com>
Subject: [PATCH net-next] net: ifb: support BIG TCP packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Set the driver limit to GSO_MAX_SIZE (512 KB).

This allows the admin/user to set a GSO limit up to this value, to
avoid segmenting too large GRO packets in the netem -> ifb path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ifb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index 67424888ff0aad4ca3d6980950f54f2c4b7fdf33..d3dc0914450a87a491c2f634739b324a96d0a9a0 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -333,6 +333,7 @@ static void ifb_setup(struct net_device *dev)
 
 	dev->min_mtu = 0;
 	dev->max_mtu = 0;
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
 }
 
 static netdev_tx_t ifb_xmit(struct sk_buff *skb, struct net_device *dev)
-- 
2.50.0.727.gbf7dc18ff4-goog


