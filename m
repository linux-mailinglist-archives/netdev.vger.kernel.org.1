Return-Path: <netdev+bounces-224286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3818B8385A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639043A4A4D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4982EDD6D;
	Thu, 18 Sep 2025 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjzxA8t/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810C2E974E
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184291; cv=none; b=H7aH5IV06Kpg5G+HLV01D8t4xYy4XWVSnbdD4VrXnSczhAWyoxTWVrqWv5KymMFAzqw/zSgTnbSoLtLtb0qPV9SNahwKcLfOGcoR10DvgLw4HfvWc2Q+wARQaoLLCAb9WbudvIRt2pDUvREXfZRbO2rkNAGR0ziwed+osv24Nqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184291; c=relaxed/simple;
	bh=/JGl8hvi1Q0a9LZHKiOuXpK3BZvmXlZ5XzcXJqEbOy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AldB8E+pmkomC30G0SB3PYrPa5Qc17WrwyJaGUTzGcrRTzV3qjC4BZ5B0o+yZGZgjzSuiliin5WoXUE8IqN0keeh0A7VXZtJeqTN5TdsftD8mjVd88JzGRT/FWwqrpy50hs57cVhtCfT+IzXYeHQhutHEvFFi3dG3IBJhuTwb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjzxA8t/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729FEC4CEE7;
	Thu, 18 Sep 2025 08:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758184291;
	bh=/JGl8hvi1Q0a9LZHKiOuXpK3BZvmXlZ5XzcXJqEbOy0=;
	h=From:To:Cc:Subject:Date:From;
	b=gjzxA8t/ZMcnS1x3ghRMrdUtBMWlKz0t7snMpZU0GsJoGqcLOOcomKEl8B7BgjQn/
	 oTvluhm2FQepNcV4MJMlS1vFI2UAwpllEjw4wklBUs/PMt3fmqE4kDgMxeHhNQt2Dh
	 6rrDqjYQ0of26d+4TppYZMD1tWDPdsx4+6xcjFr/mDiAtoMxtsBSLqW/UwwbHw4aRu
	 B4aIoT/Z/4hyNG5g8EUsUEYx5GgaIru7MjDd/FswAVNlRKIWH5Do7Aqlth2C6dqW05
	 f+ndQUjfLE7t9Warh15DYx5W6ss2D+dabgpgtShQDWLRq6AqeNSose/QTq8tWLia6k
	 2jBzKWH3ClbyA==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/4] net: ipv4: some drop reason cleanup and improvements
Date: Thu, 18 Sep 2025 10:31:13 +0200
Message-ID: <20250918083127.41147-1-atenart@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A few patches that were laying around cleaning up and improving drop
reasons in net/ipv4.

Thanks,
Antoine

Since v1:
- Added patch 3 [David Ahern's suggestion].

Antoine Tenart (4):
  net: ipv4: make udp_v4_early_demux explicitly return drop reason
  net: ipv4: simplify drop reason handling in ip_rcv_finish_core
  net: ipv4: use the right type for drop reasons in ip_rcv_finish_core
  net: ipv4: convert ip_rcv_options to drop reasons

 include/net/udp.h   |  2 +-
 net/ipv4/ip_input.c | 37 ++++++++++++++++++-------------------
 net/ipv4/udp.c      | 12 ++++++------
 3 files changed, 25 insertions(+), 26 deletions(-)

-- 
2.51.0


