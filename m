Return-Path: <netdev+bounces-110617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF8192D7A6
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 19:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A99A281A58
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564E31957FC;
	Wed, 10 Jul 2024 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlI3E/Py"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C111990CF
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633252; cv=none; b=VXbUxo48YCiYBNL+Mu9XITF1zt6AxwNSeYjknIUpqZTu72oZsPgghFf1TMzmvdfNl79tXotVMxBJvyAfMC/11hbk6VcdJfqi8XSkNeSlkXUVG7tV70AmOKe3U57o61un+Lw+KY0uRg+JI8iY9gbw9cdORdHpm1j2SwzlxqylQ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633252; c=relaxed/simple;
	bh=NEN2Nf823rj/tF7GmJaiOKNoS16QG8mhZXPz2EAt6l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=demnjNfApuxw9Q80k1IhSslvdymz/GaxsAThW0atFtA2m5LyPRj+IdIZI2Dhd3bsg15S//bSS2CrpHQMEMMYprvkTC/be+v3yypmLnOJmQa9Pk97WT+zagUlnUKcKyseFMwNbk0jQmD1Pq7CCZHAO4SJaU94JEsygt3Sr4rjh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlI3E/Py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E43C32781;
	Wed, 10 Jul 2024 17:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720633251;
	bh=NEN2Nf823rj/tF7GmJaiOKNoS16QG8mhZXPz2EAt6l0=;
	h=From:To:Cc:Subject:Date:From;
	b=tlI3E/PyvJ0gnAVKEKjh4SevKaBIoGu+FBLTcRlPNLxltKh6SP/F2xOTpnEUfHRra
	 HRiinK8JP2//aIA7PLs8R8X6/EuqVtHywbHGul5H5GsJc+SuzwNXHkUjNKyc0XNLeF
	 d6D3tdN6uP69N/liwyP60IOZQRl/IadJ+f8QfFjLOkUwbIqkTJd0dWo1mqA/xuI+lr
	 1wWY3EsZqZAJ0QKCcuZgwUJrrYll5MS5/GY+EvqTLDElXmI7AG6lyOkkHblpJ7/Tnm
	 /4K1B0CvVc1CDdvKuDddV4GY3pF0lo8BgK9vanT6SwNEx+JWB9H13+mbZJg3F+2Xqt
	 J6orjh6tuBKog==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	ecree.xilinx@gmail.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] ethtool: use the rss context XArray in ring deactivation safety-check
Date: Wed, 10 Jul 2024 10:40:41 -0700
Message-ID: <20240710174043.754664-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have an XArray storing information about all extra
RSS contexts - use it to extend checks already performed using
ethtool_get_max_rxfh_channel().

Jakub Kicinski (2):
  ethtool: fail closed if we can't get max channel used in indirection
    tables
  ethtool: use the rss context XArray in ring deactivation safety-check

 net/ethtool/channels.c |  6 ++---
 net/ethtool/common.c   | 51 +++++++++++++++++++++++++++++++++---------
 net/ethtool/common.h   |  2 +-
 net/ethtool/ioctl.c    |  4 +---
 4 files changed, 44 insertions(+), 19 deletions(-)

-- 
2.45.2


