Return-Path: <netdev+bounces-227076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 732B9BA7FF3
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99614179C9A
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 05:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9CC299943;
	Mon, 29 Sep 2025 05:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jxmtlTy5"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBBD2853EF;
	Mon, 29 Sep 2025 05:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123958; cv=none; b=m4ED2ZALFo2/b5VnlYckZRBvtZWycUrYpKoBFh6VicGnQI9jj/2hlCx4w4YQ59yQxPBlsCcmh6Zpu2OpAB/cvYOpHUu3nUzvoMGedbiIjLfHdccqJ9KI6uYF+R1K4dVsBU56CXE2+2maqR2/aqfEfATeQcqIpO5rP3+zZRJR/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123958; c=relaxed/simple;
	bh=d118q319CrrpOr6XHYXy0i+KhU2/dDwgMXrzsHt3YLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Szr8ngO5YgiC7HvhPAjJTCg56dn4FbDRjG2bFnyiV9PYuYI68w83OlbAzPmZL0fFfRNNx+Bl7zKuLuiJO9A+eJrXpLhlKxK1JpOfAUUw1TtifzMPy5YRVMFlrgfFMflGWyoPMFg0VJ4ekRAQNaJ8JqDB4ZswPv5CQEdjO+TCO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jxmtlTy5; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=qwx46OjxT4hzDy7PYeqYaZncgd9MREv4oHX5XIKHA6U=;
	b=jxmtlTy5gq2AQuaQJotNNM8oXGMjsOpLHCxE3SuvKUgdc+GOk1UZVvhBVJHxGQ
	DB1p5P9M+524ae98tIstKlOdhb5qOkMBoNfXrCnbWGvIArbOVVyVNA4TUa/AEBVP
	v9Bs6fcfM/EE7ieIMsklSowWCYj4lyDS2FBqSOG4/Vji4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3p9vDGdpoadHeAQ--.6422S2;
	Mon, 29 Sep 2025 13:31:47 +0800 (CST)
From: yicongsrfy@163.com
To: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Cc: marcan@marcan.st,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: [PATCH v2 0/3] ax88179 driver optimization
Date: Mon, 29 Sep 2025 13:31:42 +0800
Message-Id: <20250929053145.3113394-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250928212351.3b5828c2@kernel.org>
References: <20250928212351.3b5828c2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgB3p9vDGdpoadHeAQ--.6422S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrykGr4fCryfAry7Cry5XFb_yoWDKFg_uw
	nIg347Ar1UWFy5XFWUGr4avryakay0g397ZasIq345X342qFn8Zr4vqr1fW3Z7GF4jvFnr
	CwnFyF1Fqr9FgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbcyZUUUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBFA3X22jaEB7g0wADsZ

From: Yi Cong <yicong@kylinos.cn>

This series of patches first reverts the previous changes to allow
the vendor-specific driver to be loaded, then fixes the issues
related to the vendor driver.

Yi Cong (3):
  Revert "net: usb: ax88179_178a: Bind only to vendor-specific
    interface"
  net: usb: support quirks in usbnet
  net: usb: ax88179_178a: add USB device driver for config selection

 drivers/net/usb/ax88179_178a.c  | 98 +++++++++++++++++++++++++++------
 drivers/net/usb/cdc_ncm.c       |  2 +-
 drivers/net/usb/usbnet.c        | 14 +++++
 drivers/net/usb/usbnet_quirks.h | 39 +++++++++++++
 include/linux/usb/usbnet.h      |  2 +
 5 files changed, 138 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/usb/usbnet_quirks.h

Changes since v1:
- Patch 1: Revert "net: usb: ax88179_178a: Bind only to
 vendor-specific interface"(No changes)
- Patch 2: net: usb: support quirks in usbnet (Correct the description of
 usbnet_quirks.h and modify the code style)
- Patch 3: net: usb: ax88179_178a: add USB device driver for
 config selection (New patch)

--
2.25.1


