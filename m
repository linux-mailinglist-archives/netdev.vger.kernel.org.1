Return-Path: <netdev+bounces-116331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B4A94A122
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F406B24EDA
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363691B32B3;
	Wed,  7 Aug 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="g2nKiK/S"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C319A28F
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013696; cv=none; b=ljACLBGtvhT68zrevERPBZLvqbTTFeIZU5OCRetalLXqsUaG74bHTku/94A+eHMkaQNLXCYFxK9H9QtEnjssAO5UvutLh0oS9Wrtu9MlC1y0sy7Fo7Mw15tRwT5PxTi/XXB6bI61Jj6yBWo9URETf1JL0aJgM7+oTvbHiskJ0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013696; c=relaxed/simple;
	bh=Gbv9IlGXNuAv7vCEUlVapZC1V1D4SGVYHUcgCYyfWxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H5nPyZPoIiL6mWZSRIuQv1D9Vxz0/aRzlXFARCtf19ZRnkVVbtxgvZm1SdpPcv5vFK+nx8B3NzYRB9702yy642twUEoKdaZ2ZusCk2fdX/kOeS2+1strDxoo0+pdbygRpD7lRNenGb40CtezxIjA8/eR1Aue/9Cx/R2lBubXmV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=g2nKiK/S; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:9ea4:d72e:1b25:b4bf])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 1B9C47D9B6;
	Wed,  7 Aug 2024 07:54:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723013693; bh=Gbv9IlGXNuAv7vCEUlVapZC1V1D4SGVYHUcgCYyfWxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09horms@kernel
	 .org|Subject:=20[PATCH=20v2=20net-next=200/9]=20l2tp:=20misc=20imp
	 rovements|Date:=20Wed,=20=207=20Aug=202024=2007:54:43=20+0100|Mess
	 age-Id:=20<cover.1723011569.git.jchapman@katalix.com>|MIME-Version
	 :=201.0;
	b=g2nKiK/SmOMZZDxr84ZgVvLjD/RyVG2KRqg06CKMhg4xGM2bTF/k9oZLglsmjo9i0
	 W4/U1LVFThbu5nSpp9vZoqCZXmhU7d6rFfTN4O7LsaQanUtMGMQ0XALfHH4Tw5aC0p
	 DaiWzoD/S97xpmzORHhVpff5FLvrgB7K0ZrKetJZa3m3mOUMxbBF8XXAgjoeoSwB63
	 YzAi/oEO60RMqWpSuu49LBJ8Q4fwObVkDb4wJwd8UXwdiyiSrUeVC1mFaSh4FciM6z
	 tc2zVR9wJb9Agda2f/rK5j7e013KFOwKn2da6XMKOCoYxoXz/xihpdEcrKNdFLPB7O
	 0IJLky1ebRgbQ==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	horms@kernel.org
Subject: [PATCH v2 net-next 0/9] l2tp: misc improvements
Date: Wed,  7 Aug 2024 07:54:43 +0100
Message-Id: <cover.1723011569.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series makes several improvements to l2tp:

  * update documentation to be consistent with recent l2tp changes.
  * remove inline keyword from functions in c source code.
  * move l2tp_ip socket tables to per-net data.
  * handle hash key collisions in l2tp_v3_session_get
  * implement and use get-next APIs for management and procfs/debugfs.
  * improve l2tp refcount helpers.
  * use per-cpu dev->tstats in l2tpeth devices.
  * flush workqueue before draining it in l2tp_pre_exit_net. This
    fixes a change which was recently applied to net-next so isn't
    suitable for the net tree.

James Chapman (9):
  documentation/networking: update l2tp docs
  l2tp: remove inline from functions in c sources
  l2tp: move l2tp_ip and l2tp_ip6 data to pernet
  l2tp: handle hash key collisions in l2tp_v3_session_get
  l2tp: add tunnel/session get_next helpers
  l2tp: use get_next APIs for management requests and procfs/debugfs
  l2tp: improve tunnel/session refcount helpers
  l2tp: l2tp_eth: use per-cpu counters from dev->tstats
  l2tp: flush workqueue before draining it

 Documentation/networking/l2tp.rst |  54 ++++-----
 net/l2tp/l2tp_core.c              | 187 +++++++++++++++++++++---------
 net/l2tp/l2tp_core.h              |  11 +-
 net/l2tp/l2tp_debugfs.c           |  24 ++--
 net/l2tp/l2tp_eth.c               |  42 +++----
 net/l2tp/l2tp_ip.c                | 116 +++++++++++++-----
 net/l2tp/l2tp_ip6.c               | 118 ++++++++++++++-----
 net/l2tp/l2tp_netlink.c           |  72 +++++++-----
 net/l2tp/l2tp_ppp.c               |  64 +++++-----
 9 files changed, 437 insertions(+), 251 deletions(-)

---
v2:
  - Add missing CCs to documentation patch. (pw-bot)
  - Remove inline keyword from functions in c source code. (pw-bot)
  - Wrap long lines to keep within the char limit. (horms)
  - Remove Fixes tag in "handle hash key collisions" patch. (horms)
  - Retarget "l2tp: fix lockdep splat" to the net tree. (horms)
  - Modify incorrect Fixes tag in "flush workqueue" patch.
v1: https://lore.kernel.org/netdev/cover.1722856576.git.jchapman@katalix.com/

-- 
2.34.1


