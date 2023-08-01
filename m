Return-Path: <netdev+bounces-23359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580BB76BB55
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157EF280AC3
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEF823581;
	Tue,  1 Aug 2023 17:36:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A0B2CA5
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:36:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97127E53;
	Tue,  1 Aug 2023 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SWqlbekppgSroQPPJP/3qDBApVOhh/NvmKjJyRLwLH0=; b=hiz0RUwVYTZZ6TK5VpMOw0E5XG
	MtyyC98LVWL7klWbNaqiJNv8Dr3jF9l8F8st3D29nTvE4tneu6UGYOIdP8XFbmpIeYmrMro136Uim
	+Hf2OzqfQvQUnLelMucaIGsmKKdz6SaLvTH2qWCH8LeDooXF7HXbxVmRKgaKVojUsnAsBoz8Mjeh9
	f5p/XpET41o9Z9tRY49sSnU1URk9tIX/K1ppO+BBRcDsT+HOMwc+aUvL1o1U8DgiBL0LfeNYjqM8s
	a5mIsbq2WLwit9MELxipEwnXB7anem87RSKIQWNkZtA3qQdTM+2EZExRXfi6BMxzTpqpGsYp6902i
	Ux9DcgAg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qQtHe-002w3o-2e;
	Tue, 01 Aug 2023 17:35:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Joshua Kinard <kumba@gentoo.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list),
	linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: require EXPORT_SYMBOL_GPL symbols for symbol_get v2
Date: Tue,  1 Aug 2023 19:35:39 +0200
Message-Id: <20230801173544.1929519-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

this series changes symbol_get to only work on EXPORT_SYMBOL_GPL
as nvidia is abusing the lack of this check to bypass restrictions
on importing symbols from proprietary modules.

Changes since v1:
 - stop using symbol_get for sharpsl_pm.c (Arnd)
 - stop using symbol_get for au1xmmc platform irq handlers
 - better (and simpler) error reporting

Diffstat:
 arch/arm/mach-pxa/sharpsl_pm.c                   |    2 --
 arch/arm/mach-pxa/spitz.c                        |   14 +-------------
 arch/mips/alchemy/devboards/db1000.c             |    8 +-------
 arch/mips/alchemy/devboards/db1200.c             |   19 ++-----------------
 arch/mips/alchemy/devboards/db1300.c             |   10 +---------
 drivers/mmc/host/Kconfig                         |    4 ++--
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c |    2 +-
 drivers/rtc/rtc-ds1685.c                         |    2 +-
 kernel/module/main.c                             |   14 +++++++++++---
 9 files changed, 20 insertions(+), 55 deletions(-)

