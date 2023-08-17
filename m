Return-Path: <netdev+bounces-28381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D95577F40F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB471C21333
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E043412B89;
	Thu, 17 Aug 2023 10:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF4B12B83
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 10:10:34 +0000 (UTC)
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE4A2D50;
	Thu, 17 Aug 2023 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=BJBMwVveP96hnQK3S7Atkwvtxibqop3ntHsUHjU+YeQ=; b=JxL7LlusdKm/FS1T8CitMQoZ8L
	+H1jsVkAn3kIMtXHiJYvrlV6H6hGLNbyMJkrCj+DWarmEE3VBxUqTQuNVg5nOYBEDqG6J8fGWQUgc
	Pq4k2D6FjChqamlj6LveN59WBat1uorNzyKwbArOs5eKuvo2ONPD1v+gw+ngA2DL++aBR8OLp9Y1Q
	ON2/1w4NVQ53Jw7SvttuXzph+wwgBr5LAjcZLIe4dRCvmRuRbwS0PuUhTPbmRr5o6qi+PCXnCHNIt
	a3ii1cRJo5hVkORR3UxWC4t7KKtRv4lz7tN8gVc9sbjOctSVkMF6Taf/UrpBXf00zWivexhEdn45Q
	tkP1O+qw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1qWZxV-0009wg-4I; Thu, 17 Aug 2023 12:10:29 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <martin@geanix.com>)
	id 1qWZxU-000TfR-K9; Thu, 17 Aug 2023 12:10:28 +0200
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 0/2] can: per-device hardware filter support
Date: Thu, 17 Aug 2023 12:10:12 +0200
Message-ID: <20230817101014.3484715-1-martin@geanix.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/27003/Thu Aug 17 09:42:42 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

Based on the prior discussions on hardware filtering in CAN devices[0],
I've implemented such support in the m_can driver.

The first patch is almost entirely identical to Oliver Hartkopp's patch
from 2018[1] - I've just rebased it to v6.6 and fixed a checkpatch
warning. Not sure what to do about the "Not-Signed-off-by" tag though?

The second patch is new. I've tested it with a tcan4550 device together
with Oliver's proof-of-concept change in iproute2[2].

Has anyone tried this approach with other devices, e.g. sja1000 ?

Thanks,
Martin

[0] https://lore.kernel.org/linux-can/6B05F8DE-7FF3-4065-9828-530BB9C91D1B@vanille.de/T/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?h=can-hw-filter&id=87128f7a953ef2eef5f2d2a02ce354350e2c4f7f
[2] https://marc.info/?l=linux-can&m=151949929522529

Martin Hundebøll (2):
  can: netlink: support setting hardware filters
  can: m_can: support setting hw filters

 drivers/net/can/dev/dev.c        |   3 +
 drivers/net/can/dev/netlink.c    |  33 ++++++++
 drivers/net/can/m_can/m_can.c    | 137 ++++++++++++++++++++++++++++++-
 include/linux/can/dev.h          |   5 ++
 include/uapi/linux/can/netlink.h |   1 +
 5 files changed, 175 insertions(+), 4 deletions(-)

-- 
2.41.0


