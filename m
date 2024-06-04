Return-Path: <netdev+bounces-100634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1248FB66F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F01E1F21E83
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2FA13CFA4;
	Tue,  4 Jun 2024 15:00:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-07.21cn.com [182.42.151.156])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A75112BE81
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.151.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513255; cv=none; b=fBTbD8hdNoddYbnkkFnD3aCma6fCNPT2qRkclscbTicYbu1rYleKnzgKi9cS5oxoA5ziVG5I6/GPbwzj6xddVnQfH/4j4biIp6kDS/blfhpN8HvFqkIdNiOHoLCS/N0KqPsoLe3Ny+03AllT4iV0GCTt2tBzWyZaVWns7NP336E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513255; c=relaxed/simple;
	bh=jbhx3qRKxNwZEDVbp4SJTMDy5H1v0hXh6CTh3I4g8/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyofN4KcfR2bVBql7vBqXu34cD3Rc/9FUz5weQXmEZ4HeB8z/+bNUrNvhpoRi6/J+SG82ZaxrADLmsWrXwU8nMSgh6vH+2yc1giXIhOrvAr+bL6IGV8DEdx8APxBL6TuG/x9AS/HlfZhPKg+q2OPVRX+bXPGamd7jNs21thpYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.151.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:63982.1038894331
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id 1E8E69BCE7;
	Tue,  4 Jun 2024 22:50:07 +0800 (CST)
X-189-SAVE-TO-SEND: +wujianguo@chinatelecom.cn
Received: from  ([36.111.140.9])
	by gateway-mua-dep-b5744948-nkwsn with ESMTP id 700218a1532b439c87ff6351da174257 for netdev@vger.kernel.org;
	Tue, 04 Jun 2024 22:50:16 CST
X-Transaction-ID: 700218a1532b439c87ff6351da174257
X-Real-From: wujianguo@chinatelecom.cn
X-Receive-IP: 36.111.140.9
X-MEDUSA-Status: 0
Sender: wujianguo@chinatelecom.cn
From: wujianguo <wujianguo@chinatelecom.cn>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	contact@proelbtn.com,
	pablo@netfilter.org,
	dsahern@kernel.org,
	pabeni@redhat.com,
	wujianguo106@163.com,
	wujianguo <wujianguo@chinatelecom.cn>
Subject: [PATCH net v2 0/3] fix NULL dereference trigger by SRv6 with netfilter 
Date: Tue,  4 Jun 2024 22:49:46 +0800
Message-ID: <20240604144949.22729-1-wujianguo@chinatelecom.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianguo Wu <wujianguo@chinatelecom.cn>

v2:
 - fix commit log.
 - add two selftests.

Jianguo Wu (3):
  seg6: fix parameter passing when calling NF_HOOK() in End.DX4 and
    End.DX6 behaviors
  selftests: add selftest for the SRv6 End.DX4 behavior with netfilter
  selftests: add selftest for the SRv6 End.DX6 behavior with netfilter

 net/ipv6/seg6_local.c                              |   8 +-
 tools/testing/selftests/net/Makefile               |   2 +
 .../selftests/net/srv6_end_dx4_netfilter_test.sh   | 335 ++++++++++++++++++++
 .../selftests/net/srv6_end_dx6_netfilter_test.sh   | 340 +++++++++++++++++++++
 4 files changed, 681 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/net/srv6_end_dx4_netfilter_test.sh
 create mode 100644 tools/testing/selftests/net/srv6_end_dx6_netfilter_test.sh

-- 
1.8.3.1


