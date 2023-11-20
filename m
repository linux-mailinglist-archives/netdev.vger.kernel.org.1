Return-Path: <netdev+bounces-49217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD087F12BC
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 13:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF751C209A4
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B7F18E16;
	Mon, 20 Nov 2023 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feyk5uCz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626BEF2
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 04:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700482019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4L8bVjqEkvHhs/ZW+HMgpg1xC58k9+Ym9UYgqEjP94=;
	b=feyk5uCzI4TRmZyPvjH9O8HoDGRnLCHdwVzn2RspNpIksTgyIVcdJBFUkwwNnNBYffv8Q0
	RUQg6SW0/vmpLlO9O22CuwlTJ5tb9LoOOv1GZeLb7pVLv9/R3b1yWR238nCnh1MazhbPL6
	M7iuWBaXwOy+ptfPFxseR14M7QgpsEo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-U29Fn8xzOjKBHZFCT7zRzw-1; Mon, 20 Nov 2023 07:06:56 -0500
X-MC-Unique: U29Fn8xzOjKBHZFCT7zRzw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA174185A782;
	Mon, 20 Nov 2023 12:06:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79E8E2166B26;
	Mon, 20 Nov 2023 12:06:52 +0000 (UTC)
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
Subject: [PATCH v2 1/2] net: usb: ax88179_178a: fix failed operations during ax88179_reset
Date: Mon, 20 Nov 2023 13:06:29 +0100
Message-ID: <20231120120642.54334-1-jtornosm@redhat.com>
In-Reply-To: <020ff11184bb22909287ef68d97c00f7d2c73bd6.camel@redhat.com>
References: <020ff11184bb22909287ef68d97c00f7d2c73bd6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Using generic ASIX Electronics Corp. AX88179 Gigabit Ethernet device,
the following test cycle has been implemented:
    - power on
    - check logs
    - shutdown
    - after detecting the system shutdown, disconnect power
    - after approximately 60 seconds of sleep, power is restored
Running some cycles, sometimes error logs like this appear:
    kernel: ax88179_178a 2-9:1.0 (unnamed net_device) (uninitialized): Failed to write reg index 0x0001: -19
    kernel: ax88179_178a 2-9:1.0 (unnamed net_device) (uninitialized): Failed to read reg index 0x0001: -19
    ...
These failed operation are happening during ax88179_reset execution, so
the initialization could not be correct.

In order to avoid this, we need to increase the delay after reset and
clock initial operations. By using these larger values, many cycles
have been run and no failed operations appear.

It would be better to check some status register to verify when the
operation has finished, but I do not have found any available information
(neither in the public datasheets nor in the manufacturer's driver). The
only available information for the necessary delays is the maufacturer's
driver (original values) but the proposed values are not enough for the
tested devices.

Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Reported-by: Herb Wei <weihao.bj@ieisystem.com>
Tested-by: Herb Wei <weihao.bj@ieisystem.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Add Fixes tag.
- Comments about the available information and manufacturer's driver
  reference to complete why the new values are needed.

 drivers/net/usb/ax88179_178a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index aff39bf3161d..4ea0e155bb0d 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1583,11 +1583,11 @@ static int ax88179_reset(struct usbnet *dev)
 
 	*tmp16 = AX_PHYPWR_RSTCTL_IPRL;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
-	msleep(200);
+	msleep(500);
 
 	*tmp = AX_CLK_SELECT_ACS | AX_CLK_SELECT_BCS;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, tmp);
-	msleep(100);
+	msleep(200);
 
 	/* Ethernet PHY Auto Detach*/
 	ax88179_auto_detach(dev);
-- 
2.42.0


