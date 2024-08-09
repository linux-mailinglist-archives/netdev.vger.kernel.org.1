Return-Path: <netdev+bounces-117112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C8B94CC1D
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D751C211FB
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 08:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BCC18DF62;
	Fri,  9 Aug 2024 08:24:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A0178364
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191889; cv=none; b=CWrFOAJGu1CyV/6reHzf6Ez3lFx2A9crw2AX6bK1SV3ypK9/JC4MZErZR0DD2UOvOSO4ygNeHUMGBQjc1HjEcsjNj5iLDgLOX9sbs4BPWZxNm46+TQ+Atx+Uaba1qtO0JahJBKnLshULk7RZcXgxMFtXjNOBGy3nbYJWokgjrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191889; c=relaxed/simple;
	bh=6idp9jUdWpfN3emC9Mwdhlcq0s0VtnR6qdTbIWBmNhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRHnwCxLj6F316WYrBOKoZU3GBUnQeUUAlb60N4wpAnkvhRmBDqtKz6M0WpTGgnvoGU/fBbGVaI7t8z255i/eYtvfOUyd1q8TpkAvfVNjZkR7lUen/dAHCSibR1iejOTCloKeDpRcXmOkecQ5HADQEdQ49zB+P3l1AELmxkb/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 0604F7D10C;
	Fri,  9 Aug 2024 08:24:45 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Antony Antony <antony@phenome.org>
Subject: [PATCH ipsec-next v1 00/02] Add 2 functions to skbuff for code sharing
Date: Fri,  9 Aug 2024 04:23:12 -0400
Message-ID: <20240809082314.2810408-1-chopps@chopps.org>
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

Patchset Changes:
-----------------

  include/linux/skbuff.h |  2 ++
  net/core/skbuff.c      | 43 ++++++++++++++++++++++++++++++++++++++++++-
  2 files changed, 44 insertions(+), 1 deletion(-)

