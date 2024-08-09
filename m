Return-Path: <netdev+bounces-117121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01E094CC5D
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E183E1C232CE
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9D318DF62;
	Fri,  9 Aug 2024 08:35:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE10172777
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192558; cv=none; b=B3342TemLf9E9Btyib4Vl0i3nC+JFT6Es5MnuShdF7hy5JAe83J7HtJviefh67PN8k1W+eVrSK/XR/a8bTC4b2JT7MXeYTA+6EED4+mlk93rYG2Xb+ggWgsrKmcfZ0g/Ot/RT9m8DOlOjzpcTYwD5OBZ8zCiCM8WukIVAaN/aJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192558; c=relaxed/simple;
	bh=h6OZ13BAVZNTvfPcclP5dYty4Z6aac5DFKcj/u9L0Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OloVIVoJOOncmhkqxUrvGTk/Ex507ghmlA9qHqvmVKJUXJXDRpqlGG+4CGlcQbZpJoTfZZkV9h7WPVcNpUtIpyaOe6fSCujYHHIPm1GQmJmabF0iEXK8FHduX2WhOZ324QpMOTKsl8pu9F3cm0RuB6tnuNG1XL5RbVAJZgtszCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id C73FE7D10C;
	Fri,  9 Aug 2024 08:35:55 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Antony Antony <antony@phenome.org>,
	Christian Hopps <chopps@chopps.org>
Subject: [PATCH ipsec-next v1 00/02] Add 2 functions to skbuff for code sharing
Date: Fri,  9 Aug 2024 04:34:58 -0400
Message-ID: <20240809083500.2822656-1-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Summary of Changes:

This patchset contains 2 commits which add 2 functions to skbuff.[ch].

  - skb_copy_seq_read() - copy from a skb_seq_state to a buffer
  - ___copy_skb_header() - factored existing code

these are used in a followup patchset implementing IP-TFS/AggFrag
encapsulation (https://www.rfc-editor.org/rfc/rfc9347.txt)

Patchset History:
-----------------

v1 (8/9/2024)
  - Created from IP-TFS patchset v9

v2 (8/9/2024)
  - resend with corrected CC list.

Patchset Changes:
-----------------

  include/linux/skbuff.h |  2 ++
  net/core/skbuff.c      | 43 ++++++++++++++++++++++++++++++++++++++++++-
  2 files changed, 44 insertions(+), 1 deletion(-)

