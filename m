Return-Path: <netdev+bounces-230279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E5BE62AA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 04:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9815542531
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 02:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EB2257831;
	Fri, 17 Oct 2025 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i2BL5EqH"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0424E4C4;
	Fri, 17 Oct 2025 02:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669698; cv=none; b=qq+G/LGtVSSEsC09lz32lYSe4PsGFj0FsXZESbzkROetMklFAFtaZcz1b1WvZh/XF8wPMDhdKO0W68AeF8/v1IaQtWJrtZmv/GF+YJmNoXtr2OoDqBGCNyvQtQ7mN+6+K+o2r4FAhV53ww+uZxltfs71Kgcvu8O81qtIDzF0Bro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669698; c=relaxed/simple;
	bh=GptHK7yWYhQHbkkDCkGr2RUUoeUD+aRp88DB6CEjG/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kbXTR1ifIwXyPGqNM2PB79sOnaxUwWb6AKCHfoWEdbBXc61YSvl+gqQxQngi0dyxIBhXMivx8dXTAMSsg/xnQYkSfh2jfW7NB8gdvY5U8T8Jm7JofrTXEN0GjE4EQo9drbSBl4S2HQxAlO/OrhyBMAVRt8u25QCJWPQwHPI+Ka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i2BL5EqH; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=gsD4iU66HRdWVSeqorKj9chRCEwii5hdDnr8XL5Wha8=;
	b=i2BL5EqHl/szGy+TEllBG/fEvlDu1Tia3mHn46COnDKwC5eeAmyTUO4upcDXyd
	4CW190svd5LC4avv4VqjHg0FWFziuIbQtJ/txcfT32wjMKhMdAguZrJK3SJBTKOj
	HmL1ZSp7EryEl2w9xGUGyAsAxG7ybZ6HjswDpSLfb/Fis=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAn2XPOr_FoPz7CAQ--.949S2;
	Fri, 17 Oct 2025 10:54:08 +0800 (CST)
From: yicongsrfy@163.com
To: michal.pecio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	oliver@neukum.org,
	pabeni@redhat.com
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH net v6 0/3] ax88179 driver optimization
Date: Fri, 17 Oct 2025 10:54:01 +0800
Message-Id: <20251017025404.1962110-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAn2XPOr_FoPz7CAQ--.949S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWxZrW5JF15Wr1xtF4DCFg_yoW3Crg_ur
	nIg347Jr1jqFyUZFWUXr4avry7Ka1vgwn2q3Zrtry5X343XF1DZw1kJr1rWa4xXF4UZFn7
	Crn2ka4fZr12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbhvKUUUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiLBjp22jxqzyNpgAAsj

From: Yi Cong <yicong@kylinos.cn>

This series of patches first fixes the issues related to the vendor
driver, then reverts the previous changes to allow the vendor-specific
driver to be loaded.

Yi Cong (3):
  net: usb: support quirks in cdc_ncm
  net: usb: ax88179_178a: add USB device driver for config selection
  Revert "net: usb: ax88179_178a: Bind only to vendor-specific
    interface"

 drivers/net/usb/ax88179_178a.c | 84 ++++++++++++++++++++++++++++------
 drivers/net/usb/cdc_ncm.c      | 44 +++++++++++++++++-
 2 files changed, 112 insertions(+), 16 deletions(-)

Changes since v5:
Only change "net: usb: ax88179_178a: add USB device driver for config selection":
1. modify the registration order.
2. fix error return value.
3. delete unuse check in probe.
--
2.25.1


