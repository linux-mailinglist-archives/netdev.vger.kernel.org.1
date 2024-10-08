Return-Path: <netdev+bounces-133194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279E6995476
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2DDB2663D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2751DF241;
	Tue,  8 Oct 2024 16:32:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576F76048;
	Tue,  8 Oct 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405153; cv=none; b=ClRlYXU8NIy1u9R9ER6whoKQ4oAXWt47zk8QG0nBKiBc7PrIlhkp/Q6ERXdNQ0jQmJqFpDEkgVAfWWgSpJYPwXZC1y6IfkVA14zIWdQOFFXsO82+2xu8LpwD6ChacVF4RMzxxa4vPYT7/vo2rVpz6PRep6FbR2QfZCVlVvL+XKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405153; c=relaxed/simple;
	bh=YJAjh97Dhfv8MGSxdqT1wRbh1/WtAZK1rafDPnd/LPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtU0paXwwpD+12iZHk7nReQTp84SCM3mpseh9h5Dks8rGDIF9JH5FTUbHDc1yObv/7A8extRNlmKdxS4h1PI0Qk1ysMTElgorZB+VWt6jL57q+zoeoyKfctqE4f4O/NPCxHDBWJVBAvnw9CWIsdQFhHljQnEvoiyMRJihMFxoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso7582601a12.3;
        Tue, 08 Oct 2024 09:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728405149; x=1729009949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fz8NjFhnLCsDXIDy39sai+WUJTLEdPprtTY1GEQZLqc=;
        b=fAQsRCFUIHTjFjccOvN8QRr77M9wPPKTcLN/0OAz5Xh+RDqqMWvxt26ydMLs3FmPbu
         7MHRcz1jNhiSkVt/eyGM5DXQ02sktsLkh6DNI4g8YJWi1SjqRgVk5iYdGLAis44yOvn2
         jtWPL3hjyZ9kZcCdUkRsFkTBHTyTWij/YpALDNJu0PLAr/3859+tsw7Yk28ub9k2Sda7
         qhLSGCOIjFlLN6tn7CPFQoFOh/BR75p/H3ImCrF0Jg6GZjM5J+TEwwvs96IZn6ZD/q7G
         pNaUAZ3O0jfKaL+5s2roq0rw6MTpNvNNIvEPYPO2H0AZyE+DVYz11WlwndS5LE3MgWKM
         AYbA==
X-Forwarded-Encrypted: i=1; AJvYcCUxR9WWR30Vq9IYiT54dAKV1q2K7cKJB7LWFUt2hGlHz7DIpcj1hgnL9CaZ1KkxAZsiAWsPjMDc9BthAus=@vger.kernel.org, AJvYcCXIBFBvK7yw2J1MtlOZWwuzp0NtedDKyBHpO14n6AV3HJ2Dj1E+bjGELSyamykRZwi4I9+TLseA@vger.kernel.org
X-Gm-Message-State: AOJu0YwB6TpWwQohnCk3XBaRIAbL4RFh3Ooj8s2AX69+JRH/L/z/8E2I
	GcxCzSPGfw2AAOI5yc4tAxlGkMvOKIAwkogukzT7sExIMhJK0+1s
X-Google-Smtp-Source: AGHT+IEU0xbHZmZJNMJvkTGKVnUZeISlcYDqBZAwkovZAPG4tdrjweFYWF4Y3+ulemLviwaPLl4YDA==
X-Received: by 2002:a05:6402:5518:b0:5c8:9515:cc6 with SMTP id 4fb4d7f45d1cf-5c8d2e164e5mr14340256a12.12.1728405149124;
        Tue, 08 Oct 2024 09:32:29 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05a7e87sm4428868a12.24.2024.10.08.09.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:32:28 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org (open list:L3MDEV),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: Remove likely from l3mdev_master_ifindex_by_index
Date: Tue,  8 Oct 2024 09:32:04 -0700
Message-ID: <20241008163205.3939629-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The likely() annotation in l3mdev_master_ifindex_by_index() has been
found to be incorrect 100% of the time in real-world workloads (e.g.,
web servers).

Annotated branches shows the following in these servers:

	correct incorrect  %        Function                  File              Line
	      0 169053813 100 l3mdev_master_ifindex_by_index l3mdev.h             81

This is happening because l3mdev_master_ifindex_by_index() is called
from __inet_check_established(), which calls
l3mdev_master_ifindex_by_index() passing the socked bounded interface.

	l3mdev_master_ifindex_by_index(net, sk->sk_bound_dev_if);

Since most sockets are not going to be bound to a network device,
the likely() is giving the wrong assumption.

Remove the likely() annotation to ensure more accurate branch
prediction.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/net/l3mdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/l3mdev.h b/include/net/l3mdev.h
index 031c661aa14d..2d6141f28b53 100644
--- a/include/net/l3mdev.h
+++ b/include/net/l3mdev.h
@@ -78,7 +78,7 @@ static inline int l3mdev_master_ifindex_by_index(struct net *net, int ifindex)
 	struct net_device *dev;
 	int rc = 0;
 
-	if (likely(ifindex)) {
+	if (ifindex) {
 		rcu_read_lock();
 
 		dev = dev_get_by_index_rcu(net, ifindex);
-- 
2.43.5


