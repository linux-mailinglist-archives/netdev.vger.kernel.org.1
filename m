Return-Path: <netdev+bounces-91043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE18B11A6
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 20:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566551F26234
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 18:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAC716D9A9;
	Wed, 24 Apr 2024 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="SfnFoxD2"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE516D4E5
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981905; cv=none; b=hIYJaHPZhQBszRiKemEgxEsSs7he+sEl1PgeiJUiq2SMHR4kMleDGj7QqicAQevqhV3VtNaGeuls9waMg+6q9JP0UvsG+j0vnS+lfnd/ItTQpLfjByhTvBrSTGUwdAPf2jmibAp3QPrvzomvZTXWl6Eic2OGmhgfu1w1xEl+ETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981905; c=relaxed/simple;
	bh=5QqOa/sTNSRl6O4Md8cOnGBPjH/SAx8G8ktkzW7uZdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hvku4Rgm6KsahvHHEZ6A8YFKlU01PWbde0wiWyx+9NFINcJyZHO++ddUvhTc86BVYM80BTGdN0YDCLjqaroEG21mHyKZfK3wHJRIDc6u5SUytt9I2nuOf+vY0sHRTxxy50/WwBb94reJ69UUKdmRRqostVQDuS1Mj+kZ5RLicpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=SfnFoxD2; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bU6zt8/xDne+I+ZptsNXHDU0+mKFefYwpOQumKZ3QLs=; b=SfnFoxD25XuU04riZN6BbGGrKt
	3iC5jlBl0fOIIz4e0ubPfpwgR2EAFBV0pVPJTet+EohhVDnfsccYcmx9pBGcjKrmJQ9sPiXnmv05p
	Cy2knX7HnI8Kvp23Y0ViCsEhBdY59c+e0y+JEfwT4IQbY2zPRi1W7wUQE08vjnS6PT6E=;
Received: from p200300daa70d8400593e4be1bb3506c9.dip0.t-ipconnect.de ([2003:da:a70d:8400:593e:4be1:bb35:6c9] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rzgzL-006rUX-1L;
	Wed, 24 Apr 2024 20:04:59 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net-next 0/4] Add TCP fraglist GRO support
Date: Wed, 24 Apr 2024 20:04:52 +0200
Message-ID: <20240424180458.56211-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When forwarding TCP after GRO, software segmentation is very expensive,
especially when the checksum needs to be recalculated.
One case where that's currently unavoidable is when routing packets over
PPPoE. Performance improves significantly when using fraglist GRO
implemented in the same way as for UDP.

When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
socket in the same netns as the receiving device. While this may not
cover all relevant use cases in multi-netns configurations, it should be
good enough for most configurations that need this.

Here's a measurement of running 2 TCP streams through a MediaTek MT7622
device (2-core Cortex-A53), which runs NAT with flow offload enabled from
one ethernet port to PPPoE on another ethernet port + cake qdisc set to
1Gbps.

rx-gro-list off: 630 Mbit/s, CPU 35% idle
rx-gro-list on:  770 Mbit/s, CPU 40% idle

Changes since RFC:
 - split up patches
 - handle TCP flags mutations

Felix Fietkau (4):
  net: move skb_gro_receive_list from udp to core
  net: add support for segmenting TCP fraglist GSO packets
  net: add code for TCP fraglist GRO
  net: add heuristic for enabling TCP fraglist GRO

 include/net/gro.h        |   1 +
 include/net/tcp.h        |   3 +-
 net/core/gro.c           |  27 ++++++++
 net/ipv4/tcp_offload.c   | 146 ++++++++++++++++++++++++++++++++++++++-
 net/ipv4/udp_offload.c   |  27 --------
 net/ipv6/tcpv6_offload.c |  92 +++++++++++++++++++++++-
 6 files changed, 265 insertions(+), 31 deletions(-)

-- 
2.44.0


