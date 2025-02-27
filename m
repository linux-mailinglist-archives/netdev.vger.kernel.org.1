Return-Path: <netdev+bounces-170402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD59FA48847
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179EE188F88F
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6213826F478;
	Thu, 27 Feb 2025 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="aFjPgxMg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85326E97A
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682250; cv=none; b=O0BeV2/gla2P6M1wiEkSIYv8UBNG/cDS3GxT3yB8qoS2Rs3DRL8rZ/kgnxQcXruVSOYEzjpnx/YDqZjOqM+QjiQ+T8Gyd8xUuSvbbbsCz4SI5toY66oI65fENGicpzbqHkhFm/aMxDIbGmt07UGS2FmxK9mNlBzBNoxRb90UL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682250; c=relaxed/simple;
	bh=+SIdCL906LeLrhIoYRKYJT9sFHmdHFgcMAfsYXihQ1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaPbZU5WUQn/W4KIYxNdZ8bWkFOqB63JTNv7OPxaXhoGFYmpYHBeqhLGw+ev4P02AitmjgSrHNpzirxmLXhWQ5Vcwi3cSoRMPyts55K0Ub0uvltNsiHbl3igcrkUg5tHbV60Ixs1mK/XFW/vhAZ8t84pLw0o9MBnifqN1fuzKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=aFjPgxMg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c8f38febso26519385ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682247; x=1741287047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb0M0TRCtHIEHCHSiRXPcmJ/ChrocE4CL7Co5HwgWeE=;
        b=aFjPgxMgDDx695S2YkqepH3rnw3sJcAl7sMRv4tEkZc1OctwYJ9WJvFBrsWn0XLTTx
         X/7hgcpnofXkqQ+VVnzNouTrgbjq3VmzcNxy3ObIwVuIMat7QNoZnR6VHDGommWO3/24
         2Dkzm3d0NBsjevShpqOh5dzhDmcMxiQbQQiVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682247; x=1741287047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb0M0TRCtHIEHCHSiRXPcmJ/ChrocE4CL7Co5HwgWeE=;
        b=FoDhB1rkLX3xWrx2jZ7UsyF9siFUVZmWukhMNRiHpR1gXDWozDkbooH2VAGPa+PppM
         0Jq8/O+6U4D8dHst1sI27Raa5KRneXJZJGrv3TDtWJ7rjJo3ELmChefAeSv/AzorZ48L
         7xH6CITuH4PCRGUwbjGAmTX4tEZWjVdY6MdP5AYJfFsuW3wWZk1eUXTtxbQPzXkJfSCm
         UPl/okQi8C9IhO1tD/lLP6bXRiAcgOuwIDu3cWAS7bvCj1igS34fV23StiTV2shSVSbB
         CjfSHFps0yaXV5ycpIqEY6SLXGELDqbeZWfizE01kukJRxspxzF4QjaSg211nGkHLosY
         vmsQ==
X-Gm-Message-State: AOJu0Yxo0Qr67957sCwcbC7dDEZuVu6jQmfGcT8PormYrLxCg8ffmvsL
	84zOTfjnys4waqaCzEV09cOEzcJs7zIsJ/Ig+KiMrLln8t18o2JRoewYJtFxt/zAPsD2ghd1ZYp
	zxVh4iyjxv3Olxmrd8kYqUU9lWvVgEVpHlfQif+BGFFTuGr6tQQsZe03hvXmlrVkwKq8YwLWYpb
	svpgdqJ2ocskxP8CtHdHCk2AmpYs4KY3iHL/I95w==
X-Gm-Gg: ASbGncv7KIHHbwIyAdU8czW6leGQpoMWlbyGkrroWnT/C8QYQ008UntxHexQIDDXqvz
	eyF2pPrNPjBxQ8fRNujuQ5aOBckjnkd8NkLb0okXVTtk9q9K/Ev4BRJbJ/GqlrVV8fzzbVvhnEn
	BAh864YE+1Az580gSDFJl9KECKO4NDXJN3VuOzJNJvZEoqv4mtIyIo4SNp8e1bASelIRFGwvboD
	xvZvKI6Ru8laUkI1PnQWW7m27EyLGRN1b8D+KJSq3F2Jj0Q4Pb4b1j2hZV49nKNR3HrbSjfyw8x
	ad1nw9QlFibNYebclmnblAjbtwKM79Fkfg==
X-Google-Smtp-Source: AGHT+IG09PRDodbXU23HoxlyyGWid4dyJeVF4PnAlwJOPsZe6tyJoXz4u2UsXV4jPCtXuFyfiaBoWQ==
X-Received: by 2002:a17:902:c951:b0:221:78a1:27fb with SMTP id d9443c01a7336-22368f72060mr3908095ad.11.1740682247418;
        Thu, 27 Feb 2025 10:50:47 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:46 -0800 (PST)
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
Subject: [PATCH net-next v5 4/4] virtio_net: Use persistent NAPI config
Date: Thu, 27 Feb 2025 18:50:14 +0000
Message-ID: <20250227185017.206785-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227185017.206785-1-jdamato@fastly.com>
References: <20250227185017.206785-1-jdamato@fastly.com>
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
index 76dcd65ec0f2..8569b600337f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6447,8 +6447,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
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


