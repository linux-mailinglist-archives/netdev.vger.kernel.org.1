Return-Path: <netdev+bounces-22743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C11769058
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519ED1C20BCF
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17048835;
	Mon, 31 Jul 2023 08:38:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C279C6AA0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:38:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB9B1AE;
	Mon, 31 Jul 2023 01:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kKpERaVXDKMd33dB8Z6172oH7fQHojYxOewfozLZ6UA=; b=koRyMNYcvjJcXhBaHMwydXCQnm
	x+vQEB+Q5teWiOuoZj514M6zhQnZLud17ppXIay4DvRFSQJaEvq8rHJnz+1vCpOKITaLITXkLJHEO
	EAYUe+R15N1eKMdl2+2+O9gg6j6f3RRiJpW3UBCe1MCVOs4Bx9zrAXYSKVZlEhCWflPFkgFqXp9jy
	7OEuwmt7lri80b9yBHSsuc1ts2I6qjMs85kjOfb1RlmDMGYTgNga5NDHRAp+CD+RXiycBBBZaHXTN
	CEJOfZT+r7rhsFZ4qbGhictyuLXB6JKD9qzhntzmW+AP4TLbiDtlxyvGtc/OaX36xc689Jc55AsRw
	23cT4P6Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qQOPq-00EYr6-0v;
	Mon, 31 Jul 2023 08:38:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Joshua Kinard <kumba@gentoo.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list),
	linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: require EXPORT_SYMBOL_GPL symbols for symbol_get
Date: Mon, 31 Jul 2023 10:38:01 +0200
Message-Id: <20230731083806.453036-1-hch@lst.de>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

this series changes symbol_get to only work on EXPORT_SYMBOL_GPL
as nvidia is abusing the lack of this check to bypass restrictions
on importing symbols from proprietary modules.

