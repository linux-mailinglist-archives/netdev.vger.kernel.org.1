Return-Path: <netdev+bounces-158774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD40A132D3
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5A1168895
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BD319D082;
	Thu, 16 Jan 2025 05:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="mVNTyO5A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D219992C
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006813; cv=none; b=H+ok0qEKKvdn+38cpgZ2kwIXHGoaGK7eWSVbFuMBaDYUvoYwuotDoTMOPN249rCdbsVh5nhtf93SJkjtKs/JM4gOB+oz0wS5IkmHPyFFzCCOponmBU13UJH8b1Y9UZUROoPCMEUB+5IaeHsE8XCAaBcU1qHUOQ3BYr4J5+tELjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006813; c=relaxed/simple;
	bh=UXb3rPE/1GDUYX7xYJCycggz8UdX0ho9WDF1GZTuo+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpzKIIA+08GiUjBHVMTSg8REjgbbvv24clB8pYnV+71cBLJUQuwBT4xVenoiPivgPZoeCi05l330/2Akig7NsfszSg4pTB1CfEy+Zb75bY3RgLccfCho3pE6F/eCoO0eCS0/MAdVHBhUKRfG4BnpblcArSqM19nZi9pYODhVq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=mVNTyO5A; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166651f752so10997955ad.3
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 21:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737006811; x=1737611611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZtsz2Rtgk1xt8CSQNH2JM2w40RollK9oAaOdJJO1B8=;
        b=mVNTyO5AueG417aZ80WO//Gl32jM0u9aMFWJyGBz10NMCkRZ+0iZZ3PqFVLH6xxF1P
         XnSBBuljpGWDmealrh6GFFXOTC7sw4IbPasu6DHLeLbfOMnEuFHH3i/Zl32Mg3zwjMI1
         tTbHIHT6BwpPcdESiaS9irQsT0x6XwSbZQiD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737006811; x=1737611611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZtsz2Rtgk1xt8CSQNH2JM2w40RollK9oAaOdJJO1B8=;
        b=XkjvgLhbSraoobNUKlQXosDaVvJmwFu+pY8iSHDNTWWCZzUHemgBu6CeegiiLJDuB6
         hj8bTCHAo+G3S/rBthVWBD25tU4yQC3H5m49jQ4KVrNVdTjyuMJFlqBw8WtSsivBsJf9
         KBBvlMuCpSNGRx6Dkzp3TxmrHbWEQduTly0IfFPt5b4ScjiUGVkh/Zmc6uoiEyIipKz+
         t8CzR6UI0eM4rcfE/PW1uYgEaIvoi+ZtqmQV9IBQvMtCLp+D2R41FEgAz4D3Aq4HeZQy
         1U6gh1DYAfyG7rXMJUR43QflmvYdEBcPaqGR+dNZmNM57Aq5yukTEmpuaw53vrkH8SJ9
         mONw==
X-Gm-Message-State: AOJu0Ywy/thyq/WPW1/uq+0jsZQJKaroc6h+KOnTCz1SGgnMdcWfs+Ca
	TWyfOfAQWT0HC14yIyJBsMiEkIsrkHB39kjkP5peBlaFzpLiJcCTxC7abBPgYh9VuB6UIOxf8az
	mypGgXdpqpVAB9sOgzOkIopxlUu1zda2wwvGckq13R9ZTrPvJ6+GaYEKrnGOcJS30u+0Nee2HDJ
	tWFYOVczdmx8STcqH9+VQdjw7SyFotmHpRc3g=
X-Gm-Gg: ASbGncut70MuPg8z4vq9KcJCK2QkXWDdvwq7NHTgBvT9K+5t4mS68WXjXsB5C4YpviD
	EDcCWZAUvv/4Yy+lAkVY3WxUoW6gRGPXYvAU8cmukEilMckBvi2x4zWbweq5vyMR93TExyc9fDn
	7TTTLEo3Nt266kDRr5TX5gD4Srqc3F2IUd72qnoMW2CoSN5g1NQ0GwiUeIr5VwwbR+UDibhE3QG
	4igCJZpu2xXxzzR3O15W0l+mKhWPzA0/+YMcoD+OqBGqnGJ+K/SnX3/hoV0rjbH
X-Google-Smtp-Source: AGHT+IGKQzp0gRosRVZZiRnTi2eKc0WyUMTIwNaRCmD8fTVjAZ/tLpnB9TpD79nfRxnZfUmc/GT8fg==
X-Received: by 2002:a17:902:dace:b0:216:4b5a:998b with SMTP id d9443c01a7336-21a83fe4c3bmr516333485ad.45.1737006811200;
        Wed, 15 Jan 2025 21:53:31 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c991sm91249655ad.168.2025.01.15.21.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:53:30 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 4/4] virtio_net: Use persistent NAPI config
Date: Thu, 16 Jan 2025 05:52:59 +0000
Message-Id: <20250116055302.14308-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116055302.14308-1-jdamato@fastly.com>
References: <20250116055302.14308-1-jdamato@fastly.com>
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
Combined:	4

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
---
 v2:
   - New in this v2. Adds persistent NAPI config so that NAPI IDs are
     not renumbered and napi_config settings are persisted.

 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6fda756dd07..52094596e94b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6420,8 +6420,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
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


