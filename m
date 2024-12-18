Return-Path: <netdev+bounces-152774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9B99F5BF2
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A31168E62
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5589F7080D;
	Wed, 18 Dec 2024 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="qtkE6H65"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68869481B3;
	Wed, 18 Dec 2024 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483476; cv=none; b=j7VAesPzue8+QQoJnHyOzRCGTxTG9PyMvknLuMD8buhyWJqY5Ao7uwp6XgOqq23Rp9+6X4C52isr55lceiEf9WG8aiEC1L9uXOW04V3oSOSO8h2m6aqNJZyd+Pa7aqZvCBgzhCFHsUYLEChAozjOPRC3Cvmk8iTxAgxPkpHJazo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483476; c=relaxed/simple;
	bh=W8qxMLSDiHnL4Z6htDMV6gzbOECGy72aWqW5n619Mqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JzpKmay2o0mb9ATfKh6uqqXRvV9VZ5JTvBf8wsYKRuWeF6AYNCRVcoUqLpRK7zyVs/qb9QzJelUpqfRC//C1tucIJyzXf7eU6VWx+WdyNGlQoJyi9YUaGMz79p1DhqjFICqJmCnp0XWW1q3k6itSs4ez6U2xVH3y5izDvoXgS9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=qtkE6H65; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=uZ1X1kvMYOle4/DVdgnt4DOIVmDexvUZfk7NpOWhalo=; b=qtkE6H65e/d6j8X3
	0cU2uTE2UH5Uw9ywG+/wWaFDO3fY5kwVvGz/8t6w9Fs2RMyZqM/4fsrlPlbnXW3UmLENoYF34/31R
	Y4HCFnB9jwesIh0uVzlvux6XKMRUVZS1QdxBwGHbppjTvFGtOYk+Mi1936YwWo7DScZnLU84ieGeA
	fF2/2fDHBJjgrypfAaoIKjn0qPcvQt2xVk6dq7pHPPRCGW1RONIjArlj2Y6PjivEVVBUTe0cjF5ZY
	uolQOt2C4MWpx/o4gfs0uP4xTNDucjzO1meKmSiM5yyA9XmVbRyyTrmIcvtx9GFsR1KncKF5baypn
	fUm04m4wlxipfWH00A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tNiNW-005zvH-2l;
	Wed, 18 Dec 2024 00:57:30 +0000
From: linux@treblig.org
To: salil.mehta@huawei.com,
	shenjian15@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 0/3] hisilicon hns deadcoding
Date: Wed, 18 Dec 2024 00:57:26 +0000
Message-ID: <20241218005729.244987-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  A small set of deadcoding for functions that are not
called, and a couple of function pointers that they
called.

Build tested only; I don't have the hardware.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Dr. David Alan Gilbert (3):
  net: hisilicon: hns: Remove unused hns_dsaf_roce_reset
  net: hisilicon: hns: Remove unused hns_rcb_start
  net: hisilicon: hns: Remove reset helpers

 .../ethernet/hisilicon/hns/hns_dsaf_main.c    | 109 ------------------
 .../ethernet/hisilicon/hns/hns_dsaf_main.h    |   5 -
 .../ethernet/hisilicon/hns/hns_dsaf_misc.c    |  67 -----------
 .../net/ethernet/hisilicon/hns/hns_dsaf_rcb.c |   5 -
 .../net/ethernet/hisilicon/hns/hns_dsaf_rcb.h |   1 -
 5 files changed, 187 deletions(-)

-- 
2.47.1


