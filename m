Return-Path: <netdev+bounces-38940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57A7BD229
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 04:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B457B2814A9
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 02:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2B38465;
	Mon,  9 Oct 2023 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="R7EL1nbj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F648816;
	Mon,  9 Oct 2023 02:55:01 +0000 (UTC)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C3A4;
	Sun,  8 Oct 2023 19:55:00 -0700 (PDT)
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 2222520231; Mon,  9 Oct 2023 10:54:58 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1696820098;
	bh=QxzJYY9A0zWCE2fJK6lM/URO1TayMPdW+FPIlE3Cck8=;
	h=From:To:Cc:Subject:Date;
	b=R7EL1nbjTRsm/43cr/HyKbDuxw5tF1Z8y9HY6pqXbFKDyap8KjZQxxxGlQY9if22N
	 d+hLUekRKRpFe4VM8WvVoIDRqyM62UO2FqpdOyzIZf8jINrJDw+R46+bKrfziWMZtg
	 FIBw6vlmrss3FEBN4TrtCuwBqIjPYlW0h6Pv0iAh55BnbhjjJCLoLH6ekEOydi65Sp
	 YYvOZZmRh+6C2U3Gz4DH0lzHlzGNw/d6qtvrsUmbFAGfUeOI+eMtYNklH8uigA5L0j
	 5/vyqeb8WPZ6wAY9+zgZEOTnvBq+nDp7VEpOpreCwXQAzsbCpIYV/wkJK6mASVGtZz
	 7ilpymgpffUmA==
From: Matt Johnston <matt@codeconstruct.com.au>
To: linux-i3c@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	miquel.raynal@bootlin.com
Subject: [PATCH net-next v5 0/3] I3C MCTP net driver
Date: Mon,  9 Oct 2023 10:54:46 +0800
Message-ID: <20231009025451.490374-1-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
has been tested against QEMU, as well as using the target mode support 
in Aspeed's vendor tree.

I3C maintainers have acked merging this through net-next tree.

Thanks,
Matt

---

v5:

- Use #define for constant initializer, fixes older gcc
- Wrap lines at 80 characters, fix parenthesis alignment 

v4:

- Add asm/unaligned.h include

v3:

- Use get_unaligned_be48()
- Use kthread_run()
- Don't set net namespace

v2:

- Rebased to net-next
- Removed unnecessary pr_ printing
- Fixed reverse christmas tree ordering
- Reworded DT property description to match I2C

Jeremy Kerr (1):
  i3c: Add support for bus enumeration & notification

Matt Johnston (2):
  dt-bindings: i3c: Add mctp-controller property
  mctp i3c: MCTP I3C driver

 .../devicetree/bindings/i3c/i3c.yaml          |   6 +
 drivers/i3c/master.c                          |  35 +
 drivers/net/mctp/Kconfig                      |   9 +
 drivers/net/mctp/Makefile                     |   1 +
 drivers/net/mctp/mctp-i3c.c                   | 769 ++++++++++++++++++
 include/linux/i3c/master.h                    |  11 +
 6 files changed, 831 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-i3c.c

-- 
2.42.0


