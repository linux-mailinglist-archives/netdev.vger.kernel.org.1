Return-Path: <netdev+bounces-211131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921BBB16D08
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9C41AA6782
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 08:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADCB1E1DFE;
	Thu, 31 Jul 2025 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc4edSLo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016EC382;
	Thu, 31 Jul 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948830; cv=none; b=j6ENMUCD5Oj9NEWEwBPOBZoPL36XiyPwBmhkJBTjMywxiA0wAzuhHusDr0rpmtNYJNzZFwADUIqn899+HRe8waDCyKdztD9m2GkXs7w/xyvc1XIIsisCtlWyibsFPoKH4qByJMJc4aICE2kck3x5jQf5UDcGdpmUb9h8yOqtwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948830; c=relaxed/simple;
	bh=r5xu+folPtN4140SmoCo8kgE7mra55rzzX7qxRua6t0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=exWL1IyFbLdwMYlul57miOnxJYK3jH1P9Hi/iHMINtJlhygV+DI4XfFqFod97MA3IHa/Jgzb45GDxINqXq+JVYEdc3vtcg4o1S8FmoPU3KE7oFoogMjLFewKBbgpYg0I+DMaqddlkR2ubUqtnkt59ajNGqW++iwqnCYQ05r3qPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc4edSLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4387C4CEEF;
	Thu, 31 Jul 2025 08:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753948829;
	bh=r5xu+folPtN4140SmoCo8kgE7mra55rzzX7qxRua6t0=;
	h=From:To:Cc:Subject:Date:From;
	b=dc4edSLolumclnC0ZKh8AwGW29bmZb7kcva3sh7Kc2dFQY/TZrE41tsz3jkuuudx6
	 J9hPBhNoTeoru9bvhPhEM/6Rqh02onuSqbC4fhuPmmsfLH2YhuWNIUo3sNYyqiGrH0
	 Xxt64kL/Hz9OfcOKDKPM5aqxW9uL9+/a6xOprtpQ8H+1p72Gf0nFGWeQ3Wua2BOq3j
	 Ite/tUoZgIddnu4rXQpsoEQwHves3Xp+yD8gkJArtysTzm9gyxgJkTQWwXpRmmbsiX
	 D7ZdGgOyz3CBlE6M36XKaLtv+Y49x7E/kISHjTzG30dP+FTagBCclqlfnaJbNpAnOn
	 PryLD6/bW+zGQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Alex Elder <elder@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	P Praneesh <quic_ppranees@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
	Balamurugan S <quic_bselvara@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipa: fix compile-testing with qcom-mdt=m
Date: Thu, 31 Jul 2025 10:00:20 +0200
Message-Id: <20250731080024.2054904-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There are multiple drivers that use the qualcomm mdt loader, but they
have conflicting ideas of how to deal with that dependency when compile-testing
for non-qualcomm targets:

IPA only enables the MDT loader when the kernel config includes ARCH_QCOM,
but the newly added ath12k support always enables it, which leads to a
link failure with the combination of IPA=y and ATH12K=m:

    aarch64-linux-ld: drivers/net/ipa/ipa_main.o: in function `ipa_firmware_load':
    ipa_main.c:(.text.unlikely+0x134): undefined reference to `qcom_mdt_load

The ATH12K method seems more reliable here, so change IPA over to do the same
thing.

Fixes: 38a4066f593c ("net: ipa: support COMPILE_TEST")
Fixes: c0dd3f4f7091 ("wifi: ath12k: enable ath12k AHB support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ipa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
index 6782c2cbf542..01d219d3760c 100644
--- a/drivers/net/ipa/Kconfig
+++ b/drivers/net/ipa/Kconfig
@@ -5,7 +5,7 @@ config QCOM_IPA
 	depends on INTERCONNECT
 	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
 	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
-	select QCOM_MDT_LOADER if ARCH_QCOM
+	select QCOM_MDT_LOADER
 	select QCOM_SCM
 	select QCOM_QMI_HELPERS
 	help
-- 
2.39.5


