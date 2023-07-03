Return-Path: <netdev+bounces-15024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F50745507
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 07:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03275280C58
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 05:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734B07E3;
	Mon,  3 Jul 2023 05:41:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B64ECD
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:41:33 +0000 (UTC)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C3CC0;
	Sun,  2 Jul 2023 22:41:29 -0700 (PDT)
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 5F8F020153; Mon,  3 Jul 2023 13:31:43 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1688362303;
	bh=LQt2kPJhGKAg0Y5UT/bfj8ZmQ8oXOQs1B872I/8uUKc=;
	h=From:To:Cc:Subject:Date;
	b=VvmvIMHiGxEiiGr+B4r3ldNNlIhw4iqbXiVtV+zal8xxkGXLZpd/Izuu12nv3L4qS
	 UGjsAs/+glhlB8D7DpzaE7sAwmZ+BanWZsK1ST+7iBr4GPg8IwtF6WkMTOIFsovpWw
	 zZR/QfhLZZHQVYHNV2mXxO4dqidLJKLNdLbdAD8zopvlrMbRwD30x0u1OmhZrnQlUA
	 vqJ5yS4AyrMA2x8WerPz8wEQRg95OJUBY5IYqyLfh0l+UMzzpfbTLYvDf+st+7esO0
	 f1qE9sVgijZ2yad4O+vqRwAa4aqQAqD94cCuSJXnUxb7rmLBwkA4tv3VEuiR7hDH/L
	 GoOJRAUs+qj+Q==
From: Matt Johnston <matt@codeconstruct.com.au>
To: linux-i3c@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 0/3] I3C MCTP net driver
Date: Mon,  3 Jul 2023 13:30:45 +0800
Message-Id: <20230703053048.275709-1-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series adds an I3C transport for the kernel's MCTP network
protocol. MCTP is a communication protocol between system components
(BMCs, drives, NICs etc), with higher level protocols such as NVMe-MI or
PLDM built on top of it (in userspace). It runs over various transports
such as I2C, PCIe, or I3C.

The mctp-i3c driver follows a similar approach to the kernel's existing
mctp-i2c driver, creating a "mctpi3cX" network interface for each
numbered I3C bus. Busses opt in to support by adding a "mctp-controller"
property to the devicetree:

&i3c0 {
        mctp-controller;
}

The driver will bind to MCTP class devices (DCR 0xCC) that are on a
supported I3C bus. Each bus is represented by a `struct mctp_i3c_bus`
that keeps state for the network device. An individual I3C device
(struct mctp_i3c_device) performs operations using the "parent"
mctp_i3c_bus object. The I3C notify/enumeration patch is needed so that
the mctp-i3c driver can handle creating/removing mctp_i3c_bus objects as
required.

The mctp-i3c driver is using the Provisioned ID as an identifier for
target I3C devices (the neighbour address), as that will be more stable
than the I3C dynamic address. The driver internally translates that to a
dynamic address for bus operations.

The driver has been tested using an AST2600 platform. A remote endpoint 
has been tested against Qemu, as well as using the target mode support 
in Aspeed's vendor tree.

---

I'll leave it to maintainers whether this should be merged through the
i3c or net tree.

Since my previous RFC email to the i3c list, this adds dt-bindings
and fixes a comment typo. 

Jeremy Kerr (1):
  i3c: Add support for bus enumeration & notification

Matt Johnston (2):
  dt-bindings: i3c: Add mctp-controller property
  mctp i3c: MCTP I3C driver

 .../devicetree/bindings/i3c/i3c.yaml          |   4 +
 drivers/i3c/master.c                          |  35 +
 drivers/net/mctp/Kconfig                      |   9 +
 drivers/net/mctp/Makefile                     |   1 +
 drivers/net/mctp/mctp-i3c.c                   | 778 ++++++++++++++++++
 include/linux/i3c/master.h                    |  11 +
 6 files changed, 838 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-i3c.c

-- 
2.37.2


