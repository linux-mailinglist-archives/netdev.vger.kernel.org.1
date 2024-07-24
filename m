Return-Path: <netdev+bounces-112843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B1693B7FB
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 22:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79F21C22FC0
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5780616B72B;
	Wed, 24 Jul 2024 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+tB0WO4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7224A18
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852727; cv=none; b=qEC84PAX6IoZ/T7Hz0nYqVC91BtEJ6zM0DvWvQC+h4uY3drjqf140YeBNYLcA2VFKLif1h6jt+uZnZuAG91wa1cABsBcSYbFehIotnX2dJSlHCaxeQen4PM6CO8PDLY/UxIAqBCau5GzO0P7+XDSGYc64h48WO55lrec7wNT+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852727; c=relaxed/simple;
	bh=4P2w4w2jF7PEhI0u8jTi4cICZUqwry7El9DMkC1JTUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gm7d2r1JcxLUczI0xBROu7QvuxsMjz5ILWOcE6JrMXNhjEs6BFTBneu9+gg9Tp2X20rKHY5AB9rFLBJ2JamLt+5hd7beeFCR0FTIdd9xf4UdlHDM8fdD8Zcfu/KgnymiU03h/NdR8JKqb7nMhjgCvg+s7zA8OQfOAjHYFqeMoZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+tB0WO4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721852723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sjLL+P+iF7ofyL/uSS1LtHgC0S4qsbe70HvqcvGnJAI=;
	b=g+tB0WO4B9FKFWC3FISc7Wp21TkQ+fIGXVxOmTtBEgK85bCXjXjvlXGKH9HF8CCX95VdKl
	o/Xttfge96wciQyn0z8ZlDuveqyxywu/X3lRJjYY1BBBFY+iah7XBUER92ezTYwOqxQYE5
	3F+77gOqZ1689Ln00qnQRVl7xg4zVl4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-dYSnjQ2hPa26-AgIvtSuFw-1; Wed,
 24 Jul 2024 16:25:20 -0400
X-MC-Unique: dYSnjQ2hPa26-AgIvtSuFw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD4B81955D54;
	Wed, 24 Jul 2024 20:25:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1F2F19560AE;
	Wed, 24 Jul 2024 20:25:12 +0000 (UTC)
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
Subject: [PATCH RFC v2 00/11] net: introduce TX shaping H/W offload API
Date: Wed, 24 Jul 2024 22:24:46 +0200
Message-ID: <cover.1721851988.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

We have a plurality of shaping-related drivers API, but none flexible
enough to meet existing demand from vendors[1].

This series introduces new device APIs to configure in a flexible way
TX shaping H/W offload. The new functionality is exposed via a newly
defined generic netlink interface and includes introspection
capabilities. Some self-tests are included, on top of a dummy
netdevsim implementation, and a basic implementation for the iavf
driver.

Some usage examples:

* Configure shaping on a given queue:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
	--do set --json '{"ifindex":'$IFINDEX',
			"shaper": {"handle":
				{"scope": "queue", "id":'$QUEUEID' },
			"bw-max": 2000000 }}'

* Container B/W sharing

The orchestration infrastructure wants to group the 
container-related queues under a RR scheduling and limit the aggregate
bandwidth:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
	--do group --json '{"ifindex":'$IFINDEX', 
			"inputs": [ 
			  {"handle": {"scope": "queue", "id":'$QID1' },
			   "weight": '$W1'}, 
			  {"handle": {"scope": "queue", "id":'$QID2' },
			   "weight": '$W2'}], 
			  {"handle": {"scope": "queue", "id":'$QID3' },
			   "weight": '$W3'}], 
			"output": { "handle": {"scope":"netdev"},
			"output": { "handle": {"scope":"netdev"},
			   "bw-max": 10000000}}'
{'handle': {'id': 0, 'scope': 'netdev'}}

* Delegation

A container wants to set a B/W limit on 2 of its own queues:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
	--do group --json '{"ifindex":'$IFINDEX', 
			"inputs": [ 
			  {"handle": {"scope": "queue", "id":'$QID1' },
			   "weight": '$W1'}, 
			  {"handle": {"scope": "queue", "id":'$QID2' },
			   "weight": '$W2'}], 
			"output": { "handle": {"scope":"detached"},
			   "bw-max": 5000000}}'
{'handle': {'id': 0, 'scope': 'detached'}}

* Cleanup:

Deleting a single queue shaper:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
	--do delete --json \
	'{"ifindex":'$IFINDEX', 
	  "handle": {"scope": "queue", "id":'$QID1' }}'

Deleting the last shaper under a group deletes the group, too:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
	--do delete --json \
	'{"ifindex":'$IFINDEX', 
	  "handle": {"scope": "queue", "id":'$QID2' }}'
./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
        --do get --json '{"ifindex":'$IF', 
			  "handle": { "scope": "detached", "id": 0}}'
Netlink error: Invalid argument
nl_len = 80 (64) nl_flags = 0x300 nl_type = 2
	error: -22
	extack: {'msg': "Can't find shaper for handle 10000000"}

Changes from RFC v1:
 - set() and delete() ops operate on a single shaper
 - added group() op to allow grouping and nesting
 - split the NL implementation into multiple patches to help reviewing

RFC v1: https://lore.kernel.org/netdev/cover.1719518113.git.pabeni@redhat.com/

[1] https://lore.kernel.org/netdev/20240405102313.GA310894@kernel.org/

Paolo Abeni (7):
  netlink: spec: add shaper YAML spec
  net-shapers: implement NL get operation
  net-shapers: implement NL set and delete operations
  net-shapers: implement NL group operation
  netlink: spec: add shaper introspection support
  net: shaper: implement introspection support
  testing: net-drv: add basic shaper test

Sudheer Mogilappagari (2):
  iavf: Add net_shaper_ops support
  iavf: add support to exchange qos capabilities

Wenjun Wu (2):
  virtchnl: support queue rate limit and quanta size configuration
  ice: Support VF queue rate limit and quanta size configuration

 Documentation/netlink/specs/shaper.yaml       | 337 ++++++
 Documentation/networking/kapi.rst             |   3 +
 MAINTAINERS                                   |   1 +
 drivers/net/Kconfig                           |   1 +
 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  13 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 215 +++-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |   2 +
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 157 ++-
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_base.c     |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  21 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   8 +
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   8 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 333 ++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |  11 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
 drivers/net/netdevsim/netdev.c                |  37 +
 include/linux/avf/virtchnl.h                  | 119 +++
 include/linux/netdevice.h                     |  17 +
 include/net/net_shaper.h                      | 169 +++
 include/uapi/linux/net_shaper.h               |  91 ++
 net/Kconfig                                   |   3 +
 net/Makefile                                  |   1 +
 net/core/dev.c                                |   2 +
 net/core/dev.h                                |   6 +
 net/shaper/Makefile                           |   9 +
 net/shaper/shaper.c                           | 962 ++++++++++++++++++
 net/shaper/shaper_nl_gen.c                    | 142 +++
 net/shaper/shaper_nl_gen.h                    |  30 +
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/shaper.py | 267 +++++
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/ynl.py     |   5 +
 36 files changed, 2983 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/netlink/specs/shaper.yaml
 create mode 100644 include/net/net_shaper.h
 create mode 100644 include/uapi/linux/net_shaper.h
 create mode 100644 net/shaper/Makefile
 create mode 100644 net/shaper/shaper.c
 create mode 100644 net/shaper/shaper_nl_gen.c
 create mode 100644 net/shaper/shaper_nl_gen.h
 create mode 100755 tools/testing/selftests/drivers/net/shaper.py

-- 
2.45.2


