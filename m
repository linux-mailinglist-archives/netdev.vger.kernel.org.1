Return-Path: <netdev+bounces-13073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B12273A16D
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7343B1C2104E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ACC1ED4C;
	Thu, 22 Jun 2023 13:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1583E1E522
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:05:26 +0000 (UTC)
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1778219AB;
	Thu, 22 Jun 2023 06:05:25 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1qCJzn-00D3Em-Qs; Thu, 22 Jun 2023 14:05:08 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
	(envelope-from <ben@rainbowdash>)
	id 1qCJzo-002Xr9-0l;
	Thu, 22 Jun 2023 14:05:08 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	claudiu.beznea@microchip.com,
	nicolas.ferre@microchip.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: net: macb: sparse warning fixes
Date: Thu, 22 Jun 2023 14:05:04 +0100
Message-Id: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These are 3 hopefully easy patches for fixing sparse errors due to
endian-ness warnings. There are still some left, but there are not
as easy as they mix host and network fields together.

For example, gem_prog_cmp_regs() has two u32 variables that it does
bitfield manipulation on for the tcp ports and these are __be16 into
u32, so not sure how these are meant to be changed. I've also no hardware
to test on, so even if these did get changed then I can't check if it is
working pre/post change.

Also gem_writel and gem_writel_n, it is not clear if both of these are
meant to be host order or not.

Ben Dooks (3):
  net: macb: check constant to define and fix __be32 warnings
  net: macb: add port constant to fix __be16 warnings
  net: macb: fix __be32 warnings in debug code

 drivers/net/ethernet/cadence/macb_main.c | 25 +++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

-- 
2.40.1


