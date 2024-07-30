Return-Path: <netdev+bounces-114312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C5D9421BD
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA741C23E15
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487118DF8A;
	Tue, 30 Jul 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDMSLn0v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449618DF7F
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372080; cv=none; b=ZwgqN2vCujqqHyF4OQzpGzP3y+pCYV11d2MczTquWy4lz/IFFJKK5uMA1ZVqYunhWK9If051mgak2aiEftrxjbdloDWAoh5xvrdQT3WyhtRdO+sAG9Ms5UZEhUi9XephyY0dcSY4USHTNCM8jv9BX/gBvMHMwMeD4LcUFqzEBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372080; c=relaxed/simple;
	bh=o5uFK+8FwLUhYkHEM7B3gAi0d+XAaZrHHQB0lVVgphI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ew5r9RIT6NdCcMn2aemLE9MT2MoqZ7NDhEtdxeYjp0bmFqch/sr+43ciAgF+hUyvA/O6D5h632t99NUR0LVkK8ddHL5Zk1UPQoPxHJlz6rbii8Z55jbsHamsOnor0QDzpl3b2H42DzAc25EJAHJyghDj1EADynKABl6ef0WVV9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDMSLn0v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722372077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=51qASRQMh3uFH0QZQBKvB6XdVD2qu0Xe2dI1IwjUPoQ=;
	b=SDMSLn0vMc5S8HFJgB58wsiKTi+mVbFeb0sghcIkJUpciQ05yV1S8CaxNpjn79Xjv4YgWn
	An1mc853uxZKPgo5vR3iEdHkWnfXWFJvNrFq2T0P2cKS1yVkSsJC1OiOtlnyR0nXvemuME
	qVqmegQmK9gx+rA1o+nvU51laOjcGmA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-4Bwzk8czP_61KtASW8qtlQ-1; Tue,
 30 Jul 2024 16:41:13 -0400
X-MC-Unique: 4Bwzk8czP_61KtASW8qtlQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E76B31955D4C;
	Tue, 30 Jul 2024 20:41:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 800353000193;
	Tue, 30 Jul 2024 20:41:06 +0000 (UTC)
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
Subject: [PATCH v3 00/12] net: introduce TX H/W shaping API
Date: Tue, 30 Jul 2024 22:39:43 +0200
Message-ID: <cover.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We have a plurality of shaping-related drivers API, but none flexible
enough to meet existing demand from vendors[1].

This series introduces new device APIs to configure in a flexible way
TX H/W shaping. The new functionalities are exposed via a newly
defined generic netlink interface and include introspection
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

deleting the last shaper under a group deletes the group, too:

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

Changes from RFC v2:
 - added patch 1
 - fixed deprecated API usage

RFC v2: https://lore.kernel.org/netdev/cover.1721851988.git.pabeni@redhat.com/

Changes from RFC v1:
 - set() and delete() ops operate on a single shaper
 - added group() op to allow grouping and nesting
 - split the NL implementation into multiple patches to help reviewing

RFC v1: https://lore.kernel.org/netdev/cover.1719518113.git.pabeni@redhat.com/

[1] https://lore.kernel.org/netdev/20240405102313.GA310894@kernel.org/

Paolo Abeni (8):
  tools: ynl: lift an assumption about spec file name
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
 net/shaper/shaper.c                           | 963 ++++++++++++++++++
 net/shaper/shaper_nl_gen.c                    | 142 +++
 net/shaper/shaper_nl_gen.h                    |  30 +
 tools/net/ynl/ynl-gen-c.py                    |   6 +-
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/shaper.py | 267 +++++
 .../testing/selftests/net/lib/py/__init__.py  |   1 +
 tools/testing/selftests/net/lib/py/ynl.py     |   5 +
 37 files changed, 2988 insertions(+), 4 deletions(-)
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


