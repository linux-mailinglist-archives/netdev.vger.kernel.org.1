Return-Path: <netdev+bounces-160123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95521A18586
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 20:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883143AB6E2
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 19:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB41F8AD9;
	Tue, 21 Jan 2025 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pur3n1eb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F571F756A
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486677; cv=none; b=ruCm4U048S8ouwPIZ1dyGnB4qBS36zCiGhordRCYxaX+geSOkyuMdXfB5lBpRARDLDZUZ1QpGLR8Lv7hs7Rzzu2pteFQGP6ELqBn0bc7oFYoQwl8ngi9RdlnUy5TnjPgLszJh6G178m5prCUlmTKph6wB5pC/CDw2VDmrNIfojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486677; c=relaxed/simple;
	bh=ps14zeISRQUrPp/FMjIu7GyzXnHtSdfWr0SOARpLgXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tlJz5CmE5CVJfZ8VZNCU29EgvGFBWNJ6xeHSuvv8Xfg21GK7BePIRweBcnC9xaTyu33wp1IgffLeeFiy9ygDYhu+jJvuiMRpe/p6VJG1ygmVcGK6tWulPjU7mt9PBrzYGVM0/YPgl74+VBPbVH2AJ2cC1hGSZsApsmtq90thKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pur3n1eb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f78a4ca5deso5634201a91.0
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 11:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737486674; x=1738091474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDWORuj0wvWXpxW0vCuhr9iAbZl0aXjuDP2zaKtZhzU=;
        b=pur3n1ebv8zuooOE/arc+KlWluLbCtB9xruX4vpTQ6NiTkMzaHw7VPrDhR1BcgH4lL
         CyJks5qAVeGcS1LdwgW4wqbgl33qPJHesRgyUhU1NyuRtmReP5YSHMRT9AEk4EAqTlXW
         fvuxR4gXbTJIMd6eA5cgZQbYECsCXxwOlpMOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486674; x=1738091474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDWORuj0wvWXpxW0vCuhr9iAbZl0aXjuDP2zaKtZhzU=;
        b=miJCeWKQDYlaDUIvs1WSGXOqhrN4MYFERCAV77I9a/wSqX0CL0L04n33SHfUh9sq8T
         Y9FGAwcoiANWerSKPxDdGv7zWFNCkTQdNh7MzAotpZ+K/o+Boj3f9mETI/UzIkPCglW9
         rO1J2R2OiwSkat8HSp7d1RRSJfRoWpvlVmxMo6nvijdM2RVoEpMsH7gL7xENr4mWw37K
         YBaV4MtWDox+yg/gheH5LPlhex4M0LHoK1Y875oRSmsq5eo243eMS7HrIk4ZGhLCZD2e
         wil7GZ8heaR30kCRSceVf3MvQYqpHSFg+YVLnJS8+I4xPwvp6JDgjmnRf9MsJiZbvW5/
         Dz3Q==
X-Gm-Message-State: AOJu0YydZY4nniU7BnXkcMWWcCYdyStaVlASPXksI7FI/Xk4mJGYqoJn
	Wji161isDrXCss/B5tXOftyLHyAumu9dwLoc5hW3ZFUQSbwHLoZA0MDbecswnpm2LdUmqreqZU6
	XU4gvIeq9EYsbErIbfQ9MSkXQQ+EMIN00t6nniT/sWbapysKlspV+QPG5hzaI18ZBli81NkZ9Nv
	RtUDEsmS+5f49QNt44rhHH1GKnKseE2Cqqlco=
X-Gm-Gg: ASbGncv69y8o6eHFCYD1N34Oz1E0r4hp8WTYD52ZYRTqB7cXFebPkaBvDuhYGNkdEZ9
	/TXALk1laxjCVQPhBQkwINV5kC9H3bss2M6sTg66MC07nhjVRSauXjBGlWsYfdZigIru4FJ1Zyk
	Hnt3wv2taiBDsnAh+uiivWZHMvxA/5NYl+peHSGPpSn12BqScaZHlpAvP6+KMC7Xrorya/wHL+I
	7B8rqPEhM0w1eB9iU1DQkW4tB8z6DFCh4DRVUnPvX8jrm6/7ouZHR8EUWCRJt0Jk7Q5qazzVq0a
	Qg==
X-Google-Smtp-Source: AGHT+IEb+ow9B8HMeKsPl0hXMsb+u+xhEKMUqjLwNXvMEkGNBJdrkESWe8cbHdWnNyIQHfkYMacpPA==
X-Received: by 2002:a17:90a:c888:b0:2f4:f7f8:fc8a with SMTP id 98e67ed59e1d1-2f782d8cd4emr28724895a91.33.1737486673632;
        Tue, 21 Jan 2025 11:11:13 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm1793440a91.26.2025.01.21.11.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:11:13 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 4/4] virtio_net: Use persistent NAPI config
Date: Tue, 21 Jan 2025 19:10:44 +0000
Message-Id: <20250121191047.269844-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121191047.269844-1-jdamato@fastly.com>
References: <20250121191047.269844-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use persistent NAPI config so that NAPI IDs are not renumbered as queue
counts change.

$ sudo ethtool -l ens4  | tail -5 | egrep -i '(current|combined)'
Current hardware settings:
Combined:       4

$ ./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/netdev.yaml \
    --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'type': 'tx'}]

Now adjust the queue count, note that the NAPI IDs are not renumbered:

$ sudo ethtool -L ens4 combined 1
$ ./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/netdev.yaml \
    --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'}]

$ sudo ethtool -L ens4 combined 8
$ ./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/netdev.yaml \
    --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
 {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
 {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'rx'},
 {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'},
 [...]

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 rfcv3:
   - Added Xuan Zhuo's Reviewed-by tag. No functional changes.

 v2:
   - Eliminate RTNL code paths using the API Jakub introduced in patch 1
     of this v2.
   - Added virtnet_napi_disable to reduce code duplication as
     suggested by Jason Wang.

 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c120cb2106c0..e0752a856adf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6411,8 +6411,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	INIT_DELAYED_WORK(&vi->refill, refill_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
-		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
-				      napi_weight);
+		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
+				      i);
+		vi->rq[i].napi.weight = napi_weight;
 		netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
-- 
2.25.1


