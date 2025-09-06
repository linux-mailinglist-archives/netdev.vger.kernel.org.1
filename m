Return-Path: <netdev+bounces-220584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD1B46FDD
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 16:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEC37BD3B9
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FA01B3937;
	Sat,  6 Sep 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SbyR8zN9"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30D1ADFE4;
	Sat,  6 Sep 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757167254; cv=none; b=QNdYu5ugdnkB6NZXK925Ef7vDP7qpx60VJx5Zo5bZEOXE5v0xCiYYZz3+6ZQGm/tyQz1njnxNf8F7I09RLoK+5/FVqZ95YcbMuHMLymxW7xvBpy8YDn9Z1dIRfkr6gFUXDfiHzCyFjKhan/+MQUlZZo1uFOJLYWo6y1dTX3UYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757167254; c=relaxed/simple;
	bh=+Ya17OzYxOlefHPbeCWX1JoI/dsn59tFRDumYvwwP5I=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=lmPbFnU++AzhXEs8EcSoNYmjzxp8EHuJvplWhj0+ilkCBXd8SculZ6JEWUoktYrU6xHV8PAYRGW2QMtmCtWCViKVoYgnNzYp2JA3ZFAEC193o6Diy3H4B5AHgPtARfM0F68IRfUH6QSwlzKKC3z+YnwXNu8PpnGURSNyF7/myBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SbyR8zN9; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757166943; bh=pDSqOj9LJo8QYj851dvKtVOYUfOR0D+2E/v7FdJbhbI=;
	h=From:To:Cc:Subject:Date;
	b=SbyR8zN9nUTF4QSxQHo6Ewnp056ydUrackxfW58XlYPoYAhCoSiry/Hh6UZamDRMZ
	 7ZpeEJsLV4kfGQV11HdNrPYGq0b6ZvGhgjLSa1HQOg1dsTpdQcXtF99v/og81MfgYv
	 LsbQviSFs2+h8Zi3Qw9sgsHlVw78oEwKXNRkjG4E=
Received: from halo.lan ([240e:379:226f:5400:8647:9ff:fe5b:afa9])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id DE49F4B9; Sat, 06 Sep 2025 21:55:36 +0800
X-QQ-mid: xmsmtpt1757166936t9f2gq3b8
Message-ID: <tencent_E71C2F71D9631843941A5DF87204D1B5B509@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmagh4muckCaN++1s12C+dCKaiLD7DgR6R1WRgBi1pheW/NU31spd
	 1CbHxqfK2DtRovwlHtvU0+nFkrV5aPT76YXo58Wq78LnpV85F9HSGeg5jkdKvg9FQ8pTcXBFCoeo
	 1DvYkAKZvCNvfXqQpzYjGFWGgvDhtxjtucooNH8ijuad/IkMgUt8TKed9lzBxqAwrA6yJBmnmU5c
	 hDaF+lEpcfUgIdilra5RC5Xqu6Zi/zZHtFXYwT4vLzVn5hZjEF7+U8eLrh/OCqdjcmJfWb8FrFC4
	 WnQWFVpstUstsKdrIQzuokQa68W5yGOW1/AbI9mg3xur6kszVolAXuTr2lKtZ3d9USVEsdMBkf00
	 pfBawfZS2nGCXqQkq7vXPROvgcVmDT3zUtAjviDoi+j6zOpXdK/Ng1l3PPRZJkZp4bDLjszzWhkU
	 OLbE/acTenuTFen0buXO1mzc7WAr/MkVxvkT+aQa2DG8/GyCzNu2gRfxjuOf0vLw0Hs09b1eTBl0
	 UB4fIgrD758X/kZqU/m3q7RkuGNjGGC9XkqgHKFISijzhHz6vAbBjHVAgq1pIATFexbxTsV7adUg
	 RkfmiDkdSa4pD4vDc+uZ/S/vKU53eeT854X/CBRuiOjgHpOKB10go56sCEdrX+dvVbdSfIxN0MNq
	 JqEn/iWauvowc+xS4g6NyStzUTa+D26fScjChVEd+KMABg6N+lbf4gPh3QnKr30VKJh96+ywYCT8
	 yA9knGgxlkHjn9BU/Spu8NNUpmw6C0twiuAD8HcSscOUpvtaqGdNLJjl7asKoHiq61tkzAjMaoFr
	 BjIw7pSiGCDo8jLx8nLxBGzXWXyFcChXCetRzunnwEZJ34V8bsAyeCiwOGfdSGqgEWvP3hkacF9U
	 jITrrBIu8SY7QoS1EzX4CHPHkxSBpWVD26Y7+M1mVso4HnppQg+QdYEeuxkL46UwQrnjRlZUgdFD
	 +40aM26S2AEPVW3wbrl9rFtD2At9jf7d1I4itkB9Urw+9RvXqmvaHYF9wV+hJ7wytyR2/ncLXiwQ
	 qzlNAHj/lZOu7L4H8NApLxWBe7aSw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yangyu Chen <cyy@cyyself.name>
To: netdev@vger.kernel.org
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH] net: atlantic: make RX page order tunable via module param
Date: Sat,  6 Sep 2025 21:54:34 +0800
X-OQ-MSGID: <20250906135434.32951-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems like AMD Strix Halo with Thunderbolt, RX map/unmap operations
with IOMMU introduce significant performance overhead, making it difficult
to achieve line rate with 10G NICs even with TCP over MTU 1500. Using
higher order pages reduces this overhead, so this parameter is now
configurable.

After applying this patch and setting `rxpageorder=3`, testing with QNAP
QNA-T310G1S on 10G Ethernet (MTU 1500) using `iperf3 -R` on IPv6 achieved
9.28Gbps compared to only 2.26Gbps previously.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
Should we also consider make default AQ_CFG_RX_PAGEORDER to 3?

Test result showing performance improvement:
$ sudo insmod drivers/net/ethernet/aquantia/atlantic/atlantic.ko
$ sudo ip link set enp99s0 up
$ iperf3 -c fe80::3a63:bbff:fe2e:1a68%enp99s0 -R
Connecting to host fe80::3a63:bbff:fe2e:1a68%enp99s0, port 5201
Reverse mode, remote host fe80::3a63:bbff:fe2e:1a68%enp99s0 is sending
[  5] local fe80::265e:beff:fe6a:4da1 port 39588 connected to fe80::3a63:bbff:fe2e:1a68 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   271 MBytes  2.27 Gbits/sec                  
[  5]   1.00-2.00   sec   270 MBytes  2.27 Gbits/sec                  
[  5]   2.00-3.00   sec   268 MBytes  2.25 Gbits/sec                  
[  5]   3.00-4.00   sec   270 MBytes  2.26 Gbits/sec                  
[  5]   4.00-5.00   sec   268 MBytes  2.25 Gbits/sec                  
[  5]   5.00-6.00   sec   269 MBytes  2.26 Gbits/sec                  
[  5]   6.00-7.00   sec   268 MBytes  2.25 Gbits/sec                  
[  5]   7.00-8.00   sec   268 MBytes  2.25 Gbits/sec                  
[  5]   8.00-9.00   sec   268 MBytes  2.25 Gbits/sec                  
[  5]   9.00-10.00  sec   268 MBytes  2.25 Gbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  2.63 GBytes  2.26 Gbits/sec    1            sender
[  5]   0.00-10.00  sec  2.63 GBytes  2.26 Gbits/sec                  receiver

iperf Done.
$ sudo rmmod atlantic
$ sudo insmod drivers/net/ethernet/aquantia/atlantic/atlantic.ko rxpageorder=3
$ sudo ip link set enp99s0 up
$ iperf3 -c fe80::3a63:bbff:fe2e:1a68%enp99s0 -R
Connecting to host fe80::3a63:bbff:fe2e:1a68%enp99s0, port 5201
Reverse mode, remote host fe80::3a63:bbff:fe2e:1a68%enp99s0 is sending
[  5] local fe80::265e:beff:fe6a:4da1 port 43356 connected to fe80::3a63:bbff:fe2e:1a68 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  1.08 GBytes  9.28 Gbits/sec                  
[  5]   1.00-2.00   sec  1.08 GBytes  9.28 Gbits/sec                  
[  5]   2.00-3.00   sec  1.08 GBytes  9.28 Gbits/sec                  
[  5]   3.00-4.00   sec  1.08 GBytes  9.28 Gbits/sec                  
[  5]   4.00-5.00   sec  1.08 GBytes  9.28 Gbits/sec                  
[  5]   5.00-6.00   sec  1.08 GBytes  9.28 Gbits/sec                  
[  5]   6.00-7.00   sec  1.08 GBytes  9.28 Gbits/sec                  
[  5]   7.00-8.00   sec  1.08 GBytes  9.28 Gbits/sec                  
[  5]   8.00-9.00   sec  1.08 GBytes  9.28 Gbits/sec                  
[  5]   9.00-10.00  sec  1.08 GBytes  9.28 Gbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  10.8 GBytes  9.28 Gbits/sec    0            sender
[  5]   0.00-10.00  sec  10.8 GBytes  9.28 Gbits/sec                  receiver

iperf Done.
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index b24eaa5283fa..48f35fbf9a70 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -40,6 +40,10 @@ static unsigned int aq_itr_rx;
 module_param_named(aq_itr_rx, aq_itr_rx, uint, 0644);
 MODULE_PARM_DESC(aq_itr_rx, "RX interrupt throttle rate");
 
+static unsigned int rxpageorder = AQ_CFG_RX_PAGEORDER;
+module_param_named(rxpageorder, rxpageorder, uint, 0644);
+MODULE_PARM_DESC(rxpageorder, "RX page order");
+
 static void aq_nic_update_ndev_stats(struct aq_nic_s *self);
 
 static void aq_nic_rss_init(struct aq_nic_s *self, unsigned int num_rss_queues)
@@ -106,7 +110,7 @@ void aq_nic_cfg_start(struct aq_nic_s *self)
 	cfg->tx_itr = aq_itr_tx;
 	cfg->rx_itr = aq_itr_rx;
 
-	cfg->rxpageorder = AQ_CFG_RX_PAGEORDER;
+	cfg->rxpageorder = rxpageorder;
 	cfg->is_rss = AQ_CFG_IS_RSS_DEF;
 	cfg->aq_rss.base_cpu_number = AQ_CFG_RSS_BASE_CPU_NUM_DEF;
 	cfg->fc.req = AQ_CFG_FC_MODE;
-- 
2.47.2


