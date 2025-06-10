Return-Path: <netdev+bounces-196035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6426AD33A6
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B271896AE9
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD42428B7C5;
	Tue, 10 Jun 2025 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QwAlEmQG"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9338B21CC71;
	Tue, 10 Jun 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551646; cv=none; b=eMDTbUgSoV7zHA5xnRizVZbJ8MEHxaTP8QTyZwpB9KWvYJgheaUOQBU1QgK7g6UcwkbbZSXwO+WwzWYzVHuXVYn9csc2L4n7uRUYs6zR20N7sYctbbn5BSor7BJ7Ly4DIc+KY6j8hUwlCDp0aJiWll9RtXKpeYu4U0IQhkLNkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551646; c=relaxed/simple;
	bh=m4goNCfrUBsfUghsVZna+NlSw2nfn6WIDNr/eDQeE3o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VHNa5UXzrX1CfHH2O9wbhDCeyyBl3ZuUSw23588PElB+F36TcvWCSJYhpMoFbDNG//vBqYq1e8Zpg02+AmTm3mL+0cg65Iqa5CPFFYzysIXRjIQJOr29/fSRXlj27kJOvsVrHMUbo88EpDsUgWRwLjhCNp0kujpsf+ExEgxR2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QwAlEmQG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AAXf6Y22658194, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749551621; bh=pmXT15qPRz+MbHhykCdehTk1H+13FgoMXnhT2YU9bww=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=QwAlEmQGSVLYHk61GvbQsLiORlsLV2pY480ygIX/YriyXhAC/VyyTQ7TQ2JfA9/5y
	 6p6KNQ90G4XqSQUzlv4GuGuYWLNrk0I/zzw5EV2LJ+vlSD1rWI5Q41oE6BjtLRrU/+
	 FQAaFfg65MYMlL5GkUt4afb17FqCSC/0z9h8jnN+yMyIbSEXhxL9N1UaV1ZgACzcli
	 /sS9km0hdsmUkSW/8xbAAzfKIWz83JJNjmzjcFVRo+v//aRMB+txU54ShDxTm8NvIl
	 0olSqmDA/N7B415IfZKYcYkNgSMzHUpIsbmR59LUySBkck7pWsNAO8nkM5O+AtVsao
	 wXfvNXlIpUFMA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AAXf6Y22658194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 18:33:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 18:33:42 +0800
Received: from RTDOMAIN (172.21.210.109) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 18:33:41 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
        <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next 0/2] Link NAPI instances to queues and IRQs
Date: Tue, 10 Jun 2025 18:33:32 +0800
Message-ID: <20250610103334.10446-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

This patch series introduces netdev-genl support to rtase, enabling
user-space applications to query the relationships between IRQs,
queues, and NAPI instances.

Justin Lai (2):
  rtase: Link IRQs to NAPI instances
  rtase: Link queues to NAPI instances

 drivers/net/ethernet/realtek/rtase/rtase.h    |  4 ++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 53 ++++++++++++++++---
 2 files changed, 49 insertions(+), 8 deletions(-)

-- 
2.34.1


