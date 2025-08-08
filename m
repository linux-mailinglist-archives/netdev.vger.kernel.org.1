Return-Path: <netdev+bounces-212204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB12B1EAD7
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E29AA19D0
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D0E285C9F;
	Fri,  8 Aug 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW89p9Es"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8EF28136C;
	Fri,  8 Aug 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664831; cv=none; b=dRTNWsSwWoyMuIydHfUz7FlDgksnoqzrOjXetzl6Gz8dFDYk1aAkqC/bSyTs408HVNx5XlzctSRtMH25k/s7TvKXodMYkKD10xz9mLgDJSzvk+6+pABH8HjyaqxmKiJaiWMwO8QW9LVXNyD6BkVADc5bZemLzO0grSJYxaobm1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664831; c=relaxed/simple;
	bh=mGd5zTDnP8+6/R0d1mih7E5A9LE5XPZC1Y/OWMGdGH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKBryRXtbvy3R/XDh1aJwgTQxSrjqFsuZC/18s4GFywXY9oC7aqbVyTVGQ0n+EVxOBVl8/fO0Zmye9Iu0T1yskO3afIC/g57wDC4toX8Iu/lIcFeO5bjMOaVAT3e++/YuSDjbFHhQXmMGmXbifTbHtmosmbGMUqQIjSs5u6ChR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW89p9Es; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so18754565e9.3;
        Fri, 08 Aug 2025 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664828; x=1755269628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0l1Q2AJy1H9F9FS1CSlvjw3MiwKgx+PXi31KVx/m80=;
        b=OW89p9Es/mNvocMtmtvcU1I6mnVHpM5Yyx/OxlGxvVb+CkfrMGwInv49cDoh3+mcOW
         u421eaNpOvmt6lCm1W6WM5UJgA8RItJWdbpu7tdM1PrzRtsjlZWWxVr9Rv4B1uG6FC79
         lfc9OE27vTCh5O/38dxFHpn4yGVcp1jcxO1RTTeCMVZjzjHWQGdbJWZv9f1E+iPqQPm/
         UBNoJuD2jSza+rWELBJrGQxYRHI4hAvyhj4EdKKpaQTr1JZvzg/JLQSkM/YgAcdZQJLd
         0n48ryaqg/LTMo5P4zDmxmEHYzOtSpCfu1QYYaCWA1WF6Umn6foiLPKoZbQZ9XYItnid
         +hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664828; x=1755269628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0l1Q2AJy1H9F9FS1CSlvjw3MiwKgx+PXi31KVx/m80=;
        b=Bafxv3UdfQMwqwGg3fsU1NLZyJUwNx0IHvJgBv804lIWUi4gBhCpgBZushnRYmrbIB
         Wfr8AA1uZU2JRRTlfMhTsuSUczMtrgFVy6cHD+5/XTUZm1XqsCj+pVpFSpacUKdSOM6E
         7qPyAemebJoXwAeB9JJQKXQphBOydIn9dIcchhM30gB61OLP29qkf+r05uiUZ1DAWC6M
         vvLNd0ewN7frjSvJ0jEp2QHw37oqLYTErok/bxWJyhvqB9ye2muxAYnOzG7swjj4IYcC
         UHE6rC+rPpt8voiK4O1Bi0RcvrkowKa4RGeol551IXOsCWCj8WAp6DbCsIKhrwIFyBFF
         zv3A==
X-Forwarded-Encrypted: i=1; AJvYcCUXfF6rzu4MconqKtVB/2MmvoSRsxegpPtzJtztClM7sWc6+NFxEcsZ+aV4kvy7BWM9jHlKUPWq@vger.kernel.org, AJvYcCWm/u2TCWB2zw099AKuSKTjlUwGYMWAQ33WlGqRaFlCFaaBh2t+9UwKJNEQaQiI1jMlXPi3sxbrmIRXJec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+p3Dk1PZn9NUuVzpJ3yiCGslMhn2PwxhemwAwHbVzk9ZZSpw2
	DzfR/awPQCSZN6X+lSz8fmHzFWTe5j2EoUQJNSNdV+n/oOPAqwtshXfQ
X-Gm-Gg: ASbGnctHft0isrjKrt6VFWlpJZRIkuiC5oDg09UpEiT/R7C3mx1CU2ZDZ+RKnyMbu34
	D94o0MWCSrd/VCtrX6HJ4u91XQzS04RqATsnFkriY5PipMjDXKRT7Fn9On00qRDCIXgxuSX4WIM
	KHZvDlYNjnMgTRmCNo7Hmcfe18telsaTB85arR2pU8YMIaNFm7KVblNF44Qui+La1gor5v+E/8p
	XCVhKZxupTYaBgfmwWAjvPhYWYwpjZTOeuE8ZchAvbNSNaUP/drImABNHj+77x9ccTwqJFeTlhS
	6lRuoGjsGjrFvuP8b7gF1cmPkf36p3yGKvbq63zWcoGQ6IW1kGFIdY7fgLgcnlOCpQXyUTbBDY1
	bFQUxp3BFfq6pjbu7
X-Google-Smtp-Source: AGHT+IFq2NWxe4VMf33gzUN40GDxmfXoVWKHkUvzetZQqF3E/4Yf1kGafq28N9NKc3omas2o0qD40g==
X-Received: by 2002:a05:600c:1c8b:b0:458:bfb1:1fb6 with SMTP id 5b1f17b1804b1-459fb811f48mr143315e9.2.1754664827972;
        Fri, 08 Aug 2025 07:53:47 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:47 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 11/24] net: reduce indent of struct netdev_queue_mgmt_ops members
Date: Fri,  8 Aug 2025 15:54:34 +0100
Message-ID: <cd46691de046c9758f3672b6950fef404156ffa5.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Trivial change, reduce the indent. I think the original is copied
from real NDOs. It's unnecessarily deep, makes passing struct args
problematic.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 8c21ea9b9515..d73f9023c96f 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -152,18 +152,18 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  * be called for an interface which is open.
  */
 struct netdev_queue_mgmt_ops {
-	size_t			ndo_queue_mem_size;
-	int			(*ndo_queue_mem_alloc)(struct net_device *dev,
-						       void *per_queue_mem,
-						       int idx);
-	void			(*ndo_queue_mem_free)(struct net_device *dev,
-						      void *per_queue_mem);
-	int			(*ndo_queue_start)(struct net_device *dev,
-						   void *per_queue_mem,
-						   int idx);
-	int			(*ndo_queue_stop)(struct net_device *dev,
-						  void *per_queue_mem,
-						  int idx);
+	size_t	ndo_queue_mem_size;
+	int	(*ndo_queue_mem_alloc)(struct net_device *dev,
+				       void *per_queue_mem,
+				       int idx);
+	void	(*ndo_queue_mem_free)(struct net_device *dev,
+				      void *per_queue_mem);
+	int	(*ndo_queue_start)(struct net_device *dev,
+				   void *per_queue_mem,
+				   int idx);
+	int	(*ndo_queue_stop)(struct net_device *dev,
+				  void *per_queue_mem,
+				  int idx);
 };
 
 /**
-- 
2.49.0


