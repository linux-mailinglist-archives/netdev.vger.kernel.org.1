Return-Path: <netdev+bounces-16047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B6474B259
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 16:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1279D1C20FDD
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF606D2E9;
	Fri,  7 Jul 2023 14:00:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3291C135
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 14:00:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD2E1FE6
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688738429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tw4V2NfImeC5GfdO0ctBGdDxwJlMQmkR6fz8vyJ73Zo=;
	b=Ah6bZaw8+YzP88nZEJpShZQWy0LBJDP5ZlN5f9uJ1rQMQvVJdOgd9/LtVftZgmntbhkcVz
	SHUXPRDsdMyx+CesHRlYKaaWF6Kw3Nc1q+QKV664LPCRuDruLHdBZMeTCHCIyYNn5DnoaM
	pM/0zW0uJix0mlxXSG60oDtDN+7ve4w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-GcVuy2HmPeOr0kuq4Z8fqQ-1; Fri, 07 Jul 2023 10:00:25 -0400
X-MC-Unique: GcVuy2HmPeOr0kuq4Z8fqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BDDC88D543;
	Fri,  7 Jul 2023 14:00:23 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-39.pek2.redhat.com [10.72.12.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 594D02166B26;
	Fri,  7 Jul 2023 14:00:08 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	schnelle@linux.ibm.com,
	vkoul@kernel.org,
	eli.billauer@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	derek.kiernan@amd.com,
	dragan.cvetic@amd.com,
	linux@dominikbrodowski.net,
	Jonathan.Cameron@huawei.com,
	linus.walleij@linaro.org,
	tsbogend@alpha.franken.de,
	joyce.ooi@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tglx@linutronix.de,
	maz@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	frowand.list@gmail.com,
	Baoquan He <bhe@redhat.com>,
	kernel test robot <lkp@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH 5/8] net: altera-tse: make ALTERA_TSE depend on HAS_IOMEM
Date: Fri,  7 Jul 2023 21:58:49 +0800
Message-Id: <20230707135852.24292-6-bhe@redhat.com>
In-Reply-To: <20230707135852.24292-1-bhe@redhat.com>
References: <20230707135852.24292-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On s390 systems (aka mainframes), it has classic channel devices for
networking and permanent storage that are currently even more common
than PCI devices. Hence it could have a fully functional s390 kernel
with CONFIG_PCI=n, then the relevant iomem mapping functions
[including ioremap(), devm_ioremap(), etc.] are not available.

Here let ALTERA_TSE depend on HAS_IOMEM so that it won't be built
to cause below compiling error if PCI is unset:

------
ERROR: modpost: "devm_ioremap" [drivers/net/ethernet/altera/altera_tse.ko] undefined!
------

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Joyce Ooi <joyce.ooi@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org

---
 drivers/net/ethernet/altera/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/altera/Kconfig b/drivers/net/ethernet/altera/Kconfig
index 17985319088c..4ef819a9a1ad 100644
--- a/drivers/net/ethernet/altera/Kconfig
+++ b/drivers/net/ethernet/altera/Kconfig
@@ -2,6 +2,7 @@
 config ALTERA_TSE
 	tristate "Altera Triple-Speed Ethernet MAC support"
 	depends on HAS_DMA
+	depends on HAS_IOMEM
 	select PHYLIB
 	select PHYLINK
 	select PCS_LYNX
-- 
2.34.1


