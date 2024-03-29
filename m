Return-Path: <netdev+bounces-83411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7CB892310
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 18:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB0F1F21FC8
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAAE136666;
	Fri, 29 Mar 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMcREHNN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE06130E2D
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735055; cv=none; b=Eca6EfaskdamjFwX+J3oTojRH/bEztnaTFGcLaYOSKQxX1SG5GBBm8PqQVQX2BNSKnSpZbCU05bYgnGgi7eoos5QzV6X4cjANCfKtSwa89TlrIp/k8CugdNSn6gbqcaAO4ropLyacPtNPTDI9xd+1S0lVoCafMl0/srIbczbkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735055; c=relaxed/simple;
	bh=9uVBMKO3dI9JT8tvOD7cYOJk97tANhOdh7NVLdpMxZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Px1efJ9WuQNbIoSQkZYN02tKPu4Xqts3GVN/tJDe+8v50A4yktgwdDVpg3oXXhnKkzXz2hPeTtTkMt2s77xOMvck58fRLRBhxcuKWp1iBXqzS4YqfqizdPItJLtCRPB8+si9e4kAdJFIjQEAAJnuv3GDscry8NFwVFLx005A/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMcREHNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFE7C433C7;
	Fri, 29 Mar 2024 17:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711735055;
	bh=9uVBMKO3dI9JT8tvOD7cYOJk97tANhOdh7NVLdpMxZE=;
	h=From:To:Cc:Subject:Date:From;
	b=EMcREHNNvGOrdBEnR+BAmcTk7V6c0EGQDtUsnrvYHAdtIhxaQjS3HNpUF9BQLfuos
	 YpUt2ezsAyoh2JHV2rmnNkvq18jnqaeNauHkXW/H0FqgvFHfrCSFGZJIAa3Vf+FEmo
	 wCDc6r4lg3O4UVu/YwIUlcLs3YiFJ1UpTNSpj3DMfLtUB9tb0GW/v6C0WLQielwRCg
	 vZZwuXAAWZ0ZBAmAoAX/yHD0l1ZyP8wW7ue8aLR6CKH4Pn4C/2Y2BslRY393ChSh58
	 clZsf0oWmCOxQkXUS+H9a78cbS1gSpchLtsyyH8bjdoywjbOacizoKZGVuRlaqgbQb
	 1eK13iSWoVmZQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	jiri@resnulli.us,
	andriy.shevchenko@linux.intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 0/3] genetlink: remove linux/genetlink.h
Date: Fri, 29 Mar 2024 10:57:07 -0700
Message-ID: <20240329175710.291749-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two genetlink headers net/genetlink.h and linux/genetlink.h
This is similar to netlink.h, but for netlink.h both contain good
amount of code. For genetlink.h the linux/ version is leftover
from before uAPI headers were split out, it has 10 lines of code.
Move those 10 lines into other appropriate headers and delete
linux/genetlink.h.

I occasionally open the wrong header in the editor when coding,
I guess I'm not the only one.

v3:
 - fix Andy's nits on patch 3
v2: https://lore.kernel.org/all/20240325173716.2390605-1-kuba@kernel.org/
 - fix Andy's nits on patch 3
v1: https://lore.kernel.org/all/20240309183458.3014713-1-kuba@kernel.org

Jakub Kicinski (3):
  netlink: create a new header for internal genetlink symbols
  net: openvswitch: remove unnecessary linux/genetlink.h include
  genetlink: remove linux/genetlink.h

 drivers/net/wireguard/main.c      |  2 +-
 include/linux/genetlink.h         | 19 -------------------
 include/linux/genl_magic_struct.h |  2 +-
 include/net/genetlink.h           | 10 +++++++++-
 net/batman-adv/main.c             |  2 +-
 net/batman-adv/netlink.c          |  1 -
 net/netlink/af_netlink.c          |  2 +-
 net/netlink/genetlink.c           |  2 ++
 net/netlink/genetlink.h           | 11 +++++++++++
 net/openvswitch/datapath.c        |  1 -
 net/openvswitch/meter.h           |  1 -
 11 files changed, 26 insertions(+), 27 deletions(-)
 delete mode 100644 include/linux/genetlink.h
 create mode 100644 net/netlink/genetlink.h

-- 
2.44.0


