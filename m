Return-Path: <netdev+bounces-107447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414E791B03A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03F3282453
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A17A19DFBF;
	Thu, 27 Jun 2024 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUicarcw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3A19DF83
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519466; cv=none; b=giyWg2YvRmKje/HiHduASXv1r2T1CfnhQqDjRYm7x9DxAJzyQjHuwZse7oEWKdfa+gEaRaEzqFgYT/EEkqITlUsr4Wg1Top68YcILGd1bUIKkqdPP+J6KoEnNXdffQUeus49wQZiHvTzbtxjhN00Xw5y6WsX0gKmnl/Hebkji8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519466; c=relaxed/simple;
	bh=BBsOb7xAV0gq+yJqqc36exgoqAi5UFox4eKUa+m9qO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDvsTYF2vBeMl1iynVSCLdhoCBdYBeQnT8Ufc3dRhesmNH6Ss/wO5T0x7R5/EM/InJscTiVcGLm4bzMOeCaXuaWXJLMkjULOiZE1RghswdTr/uIWUnnKB8nZfuSZ83A5S0ukORMtVRwdb1QwhEnh/5QX7ocKG+7ytRKJzv0UqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUicarcw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719519463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EzutnoHsGtHCnRlICF/9DqFjmn88nLYH/JlO6AIq4SM=;
	b=jUicarcw81CXaHhBgO6zlLOJQQxdFxqlZKO7f12EkyGM6NKVSc9IQRvyO79R8sa+CW0PQQ
	b0phX53mU7gEbZ5jNsBwnKNITayAS9e4i5f0TQDvN9dYBh1cD0w4HB7KvTYe7Z5OQXtdDU
	5WjmAaPfPHyzb4cAylRX99/nhGSMeX8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-sk6UkUNJMHGaooeRLzDalw-1; Thu,
 27 Jun 2024 16:17:39 -0400
X-MC-Unique: sk6UkUNJMHGaooeRLzDalw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8D5E1955DCD;
	Thu, 27 Jun 2024 20:17:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 129791955BD4;
	Thu, 27 Jun 2024 20:17:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next 0/5] net: introduce TX shaping H/W offload API
Date: Thu, 27 Jun 2024 22:17:17 +0200
Message-ID: <cover.1719518113.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

We have a plurality of shaping-related drivers API, but none flexible
enough to meet existing demand from vendors[1].

This series introduces new device APIs to configure in a flexible way
TX shaping H/W offload. The new functionalities are exposed via a newly
defined generic netlink interface and include introspection
capabilities. Some basic self-tests are included, on top of a dummy
netdevsim implementation.

The ice driver support is currently a WIP, sharing the current status
earlier since some APIs details are still under discussion.

RFC: https://lore.kernel.org/netdev/3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com/

[1] https://lore.kernel.org/netdev/20240405102313.GA310894@kernel.org/

Paolo Abeni (5):
  netlink: spec: add shaper YAML spec
  net: introduce HW Rate limiting driver API
  netlink: spec: add shaper introspection support
  net: shaper: implement introspection support
  testing: net-drv: add basic shaper test

 Documentation/netlink/specs/shaper.yaml       | 276 +++++++
 drivers/net/Kconfig                           |   1 +
 drivers/net/netdevsim/netdev.c                |  29 +
 include/linux/netdevice.h                     |  16 +
 include/net/net_shaper.h                      | 208 ++++++
 include/uapi/linux/net_shaper.h               |  90 +++
 net/Kconfig                                   |   3 +
 net/Makefile                                  |   1 +
 net/core/dev.c                                |   2 +
 net/core/dev.h                                |   6 +
 net/shaper/Makefile                           |   9 +
 net/shaper/shaper.c                           | 686 ++++++++++++++++++
 net/shaper/shaper_nl_gen.c                    | 118 +++
 net/shaper/shaper_nl_gen.h                    |  28 +
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/shaper.py | 198 +++++
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/ynl.py     |   5 +
 18 files changed, 1678 insertions(+)
 create mode 100644 Documentation/netlink/specs/shaper.yaml
 create mode 100644 include/net/net_shaper.h
 create mode 100644 include/uapi/linux/net_shaper.h
 create mode 100644 net/shaper/Makefile
 create mode 100644 net/shaper/shaper.c
 create mode 100644 net/shaper/shaper_nl_gen.c
 create mode 100644 net/shaper/shaper_nl_gen.h
 create mode 100755 tools/testing/selftests/drivers/net/shaper.py

-- 
2.45.1


