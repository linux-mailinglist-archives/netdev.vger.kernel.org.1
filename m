Return-Path: <netdev+bounces-15818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92235749FD6
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905761C20D96
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600B9A924;
	Thu,  6 Jul 2023 14:52:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550178F5C
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 14:52:25 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9A51FE0
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 07:52:10 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7653bd3ff2fso86617985a.3
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1688655129; x=1691247129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fyfUbQSETzEWvemqOE851lvgUnh/NkXs0bSTrstNyr8=;
        b=i2Un2fu71+vZBbntcXyVTNvEdBIziZ1L1uzjczm6qGVJ0CcOsqnSyQlN1MIb5HRjl/
         blyyG7I4BbHEFeKIY7zcCUXcy3fvaNpk6nm48dG9XlvMphfL1yAOussSZ87hQ1B4qUJt
         9KxljrOCEWESkbhuCN4agXIrZhw9jsey0wGD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655129; x=1691247129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyfUbQSETzEWvemqOE851lvgUnh/NkXs0bSTrstNyr8=;
        b=b0Y+tFhOrKjgSj5Y+zCHGfohZqTfULLc+X7rDLU3O1eyLYY5IkdMEjUsmiMviJcJyU
         qQm+kIv15fKoPvJxEn3yw/6+Agay3duRsVUNJ8ZeO5PLLNPDrQ0a5EC4RjJlTpLNRlLF
         b7KFDGlN4g0aYs5ELZGWyXMctVCy/x34w9U7wyDyPCeHlPGwvyjZcGtAeW5re2f5dkc9
         uRjMI9N1Xm9AN/ttPvtRiKvR7Ygl5PidwcvOgjZqOL0dS1QK+lbNKj0tNYt/BZ+QGRDa
         t5yuVqcC0NJU5+aAfR02dpLWT+vq7WbyTml7E79DVk5c6zmHXhlYX7b+fLLGjK97fXvs
         9f8A==
X-Gm-Message-State: ABy/qLZmMF3WngIABY7tUjoGcMffZCTEtJRU04FqQW1jM29Iu02Q89cN
	bYLNvehLZp/VmU1NpNnEtPPkRA==
X-Google-Smtp-Source: APBJJlFT1vALIK6K0rOyw2waZxmnCl6+oNCTAyz6E25Ih5OW5YyHLA3Lb1ef3b6AIXboa4N85r+RfQ==
X-Received: by 2002:a05:620a:44d3:b0:765:6556:1113 with SMTP id y19-20020a05620a44d300b0076565561113mr3065592qkp.46.1688655129166;
        Thu, 06 Jul 2023 07:52:09 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id ou23-20020a05620a621700b00767303dc070sm836984qkn.8.2023.07.06.07.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:52:08 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From: "Justin M. Forbes" <jforbes@fedoraproject.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jmforbes@linuxtx.org
Subject: [PATCH] Move rmnet out of NET_VENDOR_QUALCOMM dependency
Date: Thu,  6 Jul 2023 09:51:52 -0500
Message-Id: <20230706145154.2517870-1-jforbes@fedoraproject.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The rmnet driver is useful for chipsets that are not hidden behind
NET_VENDOR_QUALCOMM.  Move sourcing the rmnet Kconfig outside of the if
NET_VENDOR_QUALCOMM as there is no dependency here.

Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
---
 drivers/net/ethernet/qualcomm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
index 9210ff360fdc..5beebe6b486e 100644
--- a/drivers/net/ethernet/qualcomm/Kconfig
+++ b/drivers/net/ethernet/qualcomm/Kconfig
@@ -61,6 +61,6 @@ config QCOM_EMAC
 	  low power, Receive-Side Scaling (RSS), and IEEE 1588-2008
 	  Precision Clock Synchronization Protocol.

-source "drivers/net/ethernet/qualcomm/rmnet/Kconfig"
-
 endif # NET_VENDOR_QUALCOMM
+
+source "drivers/net/ethernet/qualcomm/rmnet/Kconfig"
-- 
2.40.1


