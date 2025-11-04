Return-Path: <netdev+bounces-235526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6338EC31FFE
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 17:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 558674EA9F4
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41066328B40;
	Tue,  4 Nov 2025 16:14:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C5320CAA;
	Tue,  4 Nov 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272890; cv=none; b=Pm8OPnvajT0rajFWfs5SeWySR/cL2NIISoewZqpQ6cpLfa6oRahY8i7MgnmKBJ3WC6GNOCUQvTYYBOIuhepy98N8S5A7AQMzQ2CYUcgs1VU4zRnE0RG1qMR3mXG27xmHQDf/tZelg1QCiPUfqVP0tA6QlyLDdg0ELHEtBdM+bFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272890; c=relaxed/simple;
	bh=H/F5pJeHpTrsqI8rcwO4+74rhxt+X9HurnKV2Bk1Faw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ku68NAyWlx+pH4K1YIMxTfPL6u1t+UnDFttHiu4rMNcfWr88aSC32MR3Ddach6WfIGBB8EV0XyZzb7kAe+e2Ja3BqFbv3fbH63+VT0QsdSPradbJzphbCaIXmcJl1QtgX0xjs0xqCThB0C9/PXkuReJOCAQLK3Ayqr9jZX0FwCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.118])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPSA id 5A4GEWXW011487
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 4 Nov 2025 17:14:32 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, therbert@google.com
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH net-next v1 0/1] usbnet: Add support for Byte Queue Limits (BQL)
Date: Tue,  4 Nov 2025 17:13:26 +0100
Message-ID: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During recent testing, I observed significant latency spikes when using
Quectel 5G modems under load. Investigation revealed that the issue was
caused by bufferbloat in the usbnet driver.

In the current implementation, usbnet uses a fixed tx_qlen of:

USB2: 60 * 1518 bytes = 91.08 KB
USB3: 60 * 5 * 1518 bytes = 454.80 KB

Such large transmit queues can be problematic, especially for cellular
modems. For example, with a typical celluar link speed of 10 Mbit/s, a
fully occupied USB3 transmit queue results in:

454.80 KB / (10 Mbit/s / 8 bit/byte) = 363.84 ms

of additional latency.

To address this issue, this patch introduces support for
Byte Queue Limits (BQL) [1][2] in the usbnet driver. BQL dynamically
limits the amount of data queued in the driver, effectively reducing
latency without impacting throughput.
This implementation was successfully tested on several devices as
described in the commit.



Future work

Due to offloading, TCP often produces SKBs up to 64 KB in size. To
further decrease buffer bloat, I tried to disable TSO, GSO and LRO but it
did not have the intended effect in my tests. The only dirty workaround I
found so far was to call netif_stop_queue() whenever BQL sets
__QUEUE_STATE_STACK_XOFF. However, a proper solution to this issue would
be desirable.

I also plan to publish a scientific paper on this topic in the near
future.

Thanks,
Simon

[1] https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized-biography-61adc5730b83
[2] https://lwn.net/Articles/469652/

Simon Schippers (1):
  usbnet: Add support for Byte Queue Limits (BQL)

 drivers/net/usb/usbnet.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.43.0


