Return-Path: <netdev+bounces-49218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A37F12DF
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 13:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2C028126A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E1418E1D;
	Mon, 20 Nov 2023 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EP+R/YKb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C1BB8
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 04:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700482367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I64jWnU/Xnimdff02D+xgUnCTeMcDBWpdYaPdS1SbPI=;
	b=EP+R/YKbDNMonVFIg8zjNSKN/xMd8GxlxVgmHHewpAapNZgVmiuw0vqhgSFpDtZcJmTRKq
	Tpo5Z+Xx/qu3nyTqQ6yKvb+JUMh1XEOAPrZ1eHMDxJ1v15I8s7vSzRZFJopny9qWuHaZeH
	axVuFrJKJQTrv6D9G5zmhC0hULJuuv4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-Zlf3hxatNHOdUUxfsOzwfw-1; Mon,
 20 Nov 2023 07:12:44 -0500
X-MC-Unique: Zlf3hxatNHOdUUxfsOzwfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FB271C0F473;
	Mon, 20 Nov 2023 12:12:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C64A41121306;
	Mon, 20 Nov 2023 12:12:41 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	weihao.bj@ieisystem.com
Subject: [PATCH v2 2/2] net: usb: ax88179_178a: avoid two consecutive device resets
Date: Mon, 20 Nov 2023 13:11:41 +0100
Message-ID: <20231120121239.54504-1-jtornosm@redhat.com>
In-Reply-To: <020ff11184bb22909287ef68d97c00f7d2c73bd6.camel@redhat.com>
References: <020ff11184bb22909287ef68d97c00f7d2c73bd6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The device is always reset two consecutive times (ax88179_reset is called
twice), one from usbnet_probe during the device binding and the other from
usbnet_open.

Remove the non-necessary reset during the device binding and let the reset
operation from open to keep the normal behavior (tested with generic ASIX
Electronics Corp. AX88179 Gigabit Ethernet device).

Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Reported-by: Herb Wei <weihao.bj@ieisystem.com>
Tested-by: Herb Wei <weihao.bj@ieisystem.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Add Fixes tag.
- Follow Paolo Abeni's suggestion and remove the binding reset, not the
  reset operation to keep the normal behavior.

 drivers/net/usb/ax88179_178a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 4ea0e155bb0d..8d835fbc4316 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1298,8 +1298,6 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	netif_set_tso_max_size(dev->net, 16384);
 
-	ax88179_reset(dev);
-
 	return 0;
 }
 
-- 
2.42.0


