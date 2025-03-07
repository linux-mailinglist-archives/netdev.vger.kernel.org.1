Return-Path: <netdev+bounces-172720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3802CA55CD7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FFB3B29B0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F13F18DB1F;
	Fri,  7 Mar 2025 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IpeKEemI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35418C337
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309950; cv=none; b=YyC0DE819ibqpZBrqp+QPQmaG/wUBkKqDxY915KtNuE+htJcrgaVQmnSRx808d/K0rXmemFU3D3kAOXYKNrYc3KZmDR71HPQ5GxpSCsnHAQDuAQMxLnqKNk7QsjbcajJqUVBJ1YL0N21lXSx6qwV+/zbRYHvCc0MwNvSjniB+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309950; c=relaxed/simple;
	bh=NRQvfEmcLOdbXMa3vkDoUqv3L83HRqj8sSJXVTmzeH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmZ9VKvH1IiH1wMs+zOIyZRRSF97qNkCaPLJQUcEGgf7HtqCp7hAhZlK+vfH6sLqqVP/gPZezsXZ3XuBWabqyvuEzherrcH78xpLjLrmYGfaqg+fSN7dRqP4mJN1/d0WDTZ+Li5PcY5M0cAm2ACzhy+D/VCD8Y7TMypC3UEnzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IpeKEemI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2234e5347e2so24928165ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 17:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741309947; x=1741914747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXXMV7POf8zFLVgsmU4lqm240SOUGeBUlbPBBPUwDdE=;
        b=IpeKEemISXj8LM8F4+azipgqCDQIoWZO3WOO9dCpSsKymcU3CsKSadAZb3s8CpYxgj
         TUKz2BFrJsF9riuu69GT7d7YaurN0owT2jm4+Rb/MklWggf4fCc61SUL4lJ4sYgFa5UU
         zna0omr+SSTI9fp0JOJPRAsyH1vmOhh6kJZOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309947; x=1741914747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXXMV7POf8zFLVgsmU4lqm240SOUGeBUlbPBBPUwDdE=;
        b=T3kNJX/oX7smzkSOHiSGZz8cCfOlzB4SiFQiqC0r8wSzi6jhX262YMISCNwsXpj5G8
         rxJ0/5cq/LSW+9MRF1HpSu5MYSWBR50C1VdFi2oMEBbB3vjnCoios3E1myH5+akGUQ+8
         TnWRXUVUBjSQbf6Wwjqf8+f88DLyyVeljXgmxJ+1QyRrPpnfPyb/UJbqCo5XTgb0wnXl
         qRNqfOIY0Dty/NlMEhXbdHaWF5aYEbU8sqifwIJzqyyR+ifs7MNLtTI5dsnn4klIyRHG
         bt7X29Li90MCvu4esWfwcvIPKDF7XkAOUNklpNvjwmHao/fY4+7hMhRWRVkxNfwlHucY
         9DTg==
X-Gm-Message-State: AOJu0YwDlwSbGbjYWZmzH8c/rY9/e5ivK5MWDnN2aliWCDauDzcaa9sC
	WlSdb/rzFSuKFlhrpi60FL0kLRfk9HrNBcxqt81nbsVML/s9iUUPQT7HD5B4vdZO6eMBi1oBBQh
	pPx1gVXU6GMTUSJFQhfTT++NOWTkKmFGHFGHF5LpZJBVpWW1AP4VNz0PrRXOYo4ofUA73K70VFV
	tOvyC3D8VOgVSTB+EtGRRaA5OW+RYDp+RuTvEeVg==
X-Gm-Gg: ASbGncsq06yueUE12pyGumF6FM57ayDacaVtVxh2wlPtGdieYIZ2I0od2jp7jCd3vpY
	pbxhkMtUR5fbMxTc/Bprrw3dPMcxH4HCxAcJ9Hi67nUcd0b1AxHCAImo5TsA/kMKppam1RGD8ry
	SwKCUoXB9Ju9CBo1jl0lZ6IHtEh2Pqd83YJQusjEF4TLz/w5t8HPu0oXbJ3Rmcw7h9qYJP3U0TX
	3TZovnv4lrqXbbf++OzL803Owj8JDR0KPoTxTJPYWH0dZnR07iF+Rkgu65UhDp1OKtArIV+hlk9
	aMYkh6/tv5PgDpOeOINLaHd9CUcbLqnNhCDdo5gBHkutCHbyrCrX
X-Google-Smtp-Source: AGHT+IFK3bB+IzKnnw66OCX8SvIqCP/r2HrOrRFyFYXEFX5hk5hRRIZRcJqImQVh7tFSujAdQgGJ9A==
X-Received: by 2002:a17:903:32c6:b0:224:13c0:58e3 with SMTP id d9443c01a7336-22428bf1976mr19677025ad.51.1741309946772;
        Thu, 06 Mar 2025 17:12:26 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410abc816sm18749685ad.258.2025.03.06.17.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:12:26 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	mst@redhat.com,
	leiyang@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v6 4/4] virtio_net: Use persistent NAPI config
Date: Fri,  7 Mar 2025 01:12:12 +0000
Message-ID: <20250307011215.266806-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307011215.266806-1-jdamato@fastly.com>
References: <20250307011215.266806-1-jdamato@fastly.com>
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
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7bd63a677123..34cec2b11b74 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6455,8 +6455,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
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
2.45.2


