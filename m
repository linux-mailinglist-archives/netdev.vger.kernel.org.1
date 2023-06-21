Return-Path: <netdev+bounces-12849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E617391B5
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F856281606
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3341D2AD;
	Wed, 21 Jun 2023 21:38:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8119E52
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 21:38:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D1B1988;
	Wed, 21 Jun 2023 14:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pkZgplOLZ8AEWdttiF8Ut3/Ee7D1W2OVcYqdc7VQf0E=; b=hahh76qvYl0Fq2GFFDkufVXBNW
	oV2SJ1FhPuHkEy8W4LoBtBWC42GP7UJZe6fuCMix3NeaJpAMLLIDUBjqVvjoIUE/i86SVeM+lcP7q
	9MPBcOg8Kn7W/8izfWD6BIgq9RTItyF4Jqke2LfeA0YFjc3LooxYwi759wIfBbiqjnPYbkIhktmeO
	+Rapg1fUGOb2nKLhosk0mXDcggxZ5z0UPa5t+Gu7XDxSjYNDuXKtge4g+Z9SpIGSY4y3inPey7A3b
	Qar56EuAacwqJ+UjC4NlgqHAcBeA6g60aEiHm5rWzAWAErbCDlZwPley9kZivrg7iSRYP/QgOtKDW
	Z/v97k4g==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qC5WJ-00FnwL-1q;
	Wed, 21 Jun 2023 21:37:43 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Simon Horman <simon.horman@corigine.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] s390/net: lcs: fix build errors when FDDI is a loadable module
Date: Wed, 21 Jun 2023 14:37:42 -0700
Message-ID: <20230621213742.8245-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Require FDDI to be built-in if it is used. LCS needs FDDI to be
built-in to build without errors.

Prevents these build errors:
s390-linux-ld: drivers/s390/net/lcs.o: in function `lcs_new_device':
drivers/s390/net/lcs.c:2150: undefined reference to `fddi_type_trans'
s390-linux-ld: drivers/s390/net/lcs.c:2151: undefined reference to `alloc_fddidev'

This FDDI requirement effectively restores the previous condition
before the blamed patch, when #ifdef CONFIG_FDDI was used, without
testing for CONFIG_FDDI_MODULE.

Fixes: 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202306202129.pl0AqK8G-lkp@intel.com
Suggested-by: Simon Horman <simon.horman@corigine.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/s390/net/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff -- a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -6,11 +6,13 @@ config LCS
 	def_tristate m
 	prompt "Lan Channel Station Interface"
 	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
+	depends on FDDI=y || FDDI=n
 	help
 	  Select this option if you want to use LCS networking on IBM System z.
 	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
 	  To compile as a module, choose M. The module name is lcs.
 	  If you do not know what it is, it's safe to choose Y.
+	  If FDDI is used, it must be built-in (=y).
 
 config CTCM
 	def_tristate m

