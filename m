Return-Path: <netdev+bounces-151141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B837B9ECFC2
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369C418887CC
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B0D13B5AE;
	Wed, 11 Dec 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaXWFTDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF8134AC
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931128; cv=none; b=WD9LDbnXD+M11iCfNA2qVGs1sTagfweTYkaFNJhUxSfTyUtUic5igLtjJsTrpm6waUk0xAvmamiUSXBfwDKoxvQcUhVvYKyk9MBmGJnL1f22avQIxSsdZVXNa9kdNU0iZ2nkNJ5oALZu1tMISSQWinoOE8ckfsIRmmnPFj2bjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931128; c=relaxed/simple;
	bh=nfkSVveSOQFK0fyG49zgemzYr5p+ZQr0aSixQs/hcLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AgZdyb8Y1cTsENKdPpc8yoRdFhASIUn5Nr1MZwlwCer7JrU8ISDzZkP+YCa36vegpJICZb75QSCcgSpTfYnS3XkNHqKLBZW6U5DtbJnFnoiJn7iiCimr06uPWrWxQlT48w0eJ/rLragIW7MnFVjg08eQifl5vxmeoiYspQH+yCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaXWFTDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE56C4CED2;
	Wed, 11 Dec 2024 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931127;
	bh=nfkSVveSOQFK0fyG49zgemzYr5p+ZQr0aSixQs/hcLI=;
	h=From:To:Cc:Subject:Date:From;
	b=OaXWFTDW0A+dsXvel28tzlEVS/63WQnjWOwZkYho1Vqs1w5aYFfCTgKS0hZ/ZYjcz
	 UlJ/eCwrnnT3YekinGRGmeSmW7TGmxpZ6CY5ykX6l/5zXFwGvXZAkdVePHb1FSiU9/
	 f4kvVR/5ha6mmrWmXpGuFxMHA9oUnkuV6XOsH16gZQosFTPKQf1SKmxJY6EpJ/3KGy
	 UBerLPhI8Lr2phDepVgiayYzsEGoKKUZ5cXEdNvpdsEr/5hDQ8ekzaeKnHEHMb6fnT
	 kltgPjaO/MWxkoaiP2q+C9IDjWT5qLc3A0FGbD5rzQelXUaK3FW5RYjQ23aBCzqSdT
	 FsXGzetAtRRTQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha EN7581 SoC
Date: Wed, 11 Dec 2024 16:31:48 +0100
Message-ID: <cover.1733930558.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for ETS and TBF qdisc offload available in the Airoha
EN7581 ethernet controller.
Some DSA hw switches do not support Qdisc offloading or the mac chip
has more fine grained QoS capabilities with respect to the hw switch
(e.g. Airoha EN7581 mac chip has more hw QoS and buffering capabilities
with respect to the mt7530 switch). 
Introduce ndo_setup_tc_conduit callback in order to allow tc to offload
Qdisc policies for the specified DSA user port configuring the hw switch
cpu port (mac chip).

Lorenzo Bianconi (5):
  net: airoha: Enable Tx drop capability for each Tx DMA ring
  net: airoha: Introduce ndo_select_queue callback
  net: dsa: Introduce ndo_setup_tc_conduit callback
  net: airoha: Add sched ETS offload support
  net: airoha: Add sched TBF offload support

 drivers/net/ethernet/mediatek/airoha_eth.c | 372 ++++++++++++++++++++-
 include/linux/netdevice.h                  |  12 +
 net/dsa/user.c                             |  47 ++-
 3 files changed, 422 insertions(+), 9 deletions(-)

-- 
2.47.1


