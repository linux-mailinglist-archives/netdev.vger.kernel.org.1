Return-Path: <netdev+bounces-37864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0F17B76CA
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 05:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 9B5211F21BC8
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 03:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A989ED3;
	Wed,  4 Oct 2023 03:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FDEA57;
	Wed,  4 Oct 2023 03:13:29 +0000 (UTC)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8483A6;
	Tue,  3 Oct 2023 20:13:25 -0700 (PDT)
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 1C94A2009E; Wed,  4 Oct 2023 11:13:23 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1696389203;
	bh=ny0tqbgMnonpXUjor//ALDMSkh1FdO54mddDOeMRe10=;
	h=From:To:Cc:Subject:Date;
	b=L56utQZZTWzVoOwGF4aENga3q85J7njOlCpyhvmMsSyH+Ev5DWpzX3D2G4tSoFBDs
	 n6dPm3+1e4y75U+jubsIzH0IJrBUi2JgufZjFonDtG+cBIA8tFJfj9pJnuZXgcXOG5
	 zsMEXUUg3WBFI/CE1D8GtTRjHXMseWS2JGgB0oun5QizHmkOBNGSOci2pefBD05/z+
	 /WQien5wf2uCb3PPBvXKE/KDKcEDH3/uIQcU9+aIBtjHfvXiLmrblOo/XqOrAcAsuE
	 ws+OyF88shIUoA7Wz81+qVBgE5hpi6i+8e2WIyC9/hDfju0lLwywaNlGHO1RegAdgJ
	 LZOGyFyx89Sdw==
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
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH net-next v4 0/3] I3C MCTP net driver
Date: Wed,  4 Oct 2023 11:13:13 +0800
Message-Id: <20231004031316.725107-1-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
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
 drivers/net/mctp/mctp-i3c.c                   | 761 ++++++++++++++++++
 include/linux/i3c/master.h                    |  11 +
 6 files changed, 823 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-i3c.c

-- 
2.39.2


