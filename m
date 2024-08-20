Return-Path: <netdev+bounces-120238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C24958ACD
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142DA1C21880
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4C18E77E;
	Tue, 20 Aug 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iuq/diWA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E75A18EFC9
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166776; cv=none; b=M/iAchUTxbW1AclkKU6YGpqbIBhFtE8RABRAJVGTCaZmJqpVFcSE986GoFQQmwd+IpC/tNNX1mkNsMLjWsDuk+YrC4POjhUa8AUWRl0oc65FuOicrpKlylY6RzofmhcplQKNjW3OC9fL7wACiC9iqnSfJhtmHaDZ9Mlet6Ctttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166776; c=relaxed/simple;
	bh=Ux2b6Z3oprQlMNNy1m/EmI//Kg58jPatRm9WtaDo61o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPYh7AMsnrFNhN7rLEZENThaWu0g0p35wr/WBRIFifyiTvoht1ZDR2mbHNQU0i4OfL3ABmZokr7ZbpZD23pz9+5xOIqIsrSOYw+j/R5G+PYtRORKACmKA1Lt/O0CPa+V4dhl12OezC5hOhJBOb6Z78ZkQd9ZUeEuCxCXq7biGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iuq/diWA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724166773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wEojKC2/dfN2gSdwN2Ex3TKV34lh7vRNPuNjvZwme+Y=;
	b=Iuq/diWAuJxk9uIelD/0iyJY12mvlGMIJ7OqiS+qUM28/5EAVJmevRnLdi6OLMqHQV+q2G
	oXknx1RfxiOJEcl3d6BnsehVdIzKPTibq9XKojPme6idbCt+GJ6x//Nb0JsR0upd2/kaJQ
	+HLAk1ZANw5QBd2N0yqUX1rXBrm/DTA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-eyaJgNNCOnqn_mn96lCCYQ-1; Tue,
 20 Aug 2024 11:12:49 -0400
X-MC-Unique: eyaJgNNCOnqn_mn96lCCYQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0FDF1955D4D;
	Tue, 20 Aug 2024 15:12:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0638019560AA;
	Tue, 20 Aug 2024 15:12:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH v4 net-next 00/12] net: introduce TX H/W shaping API
Date: Tue, 20 Aug 2024 17:12:21 +0200
Message-ID: <cover.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
			"leaves": [ 
			  {"handle": {"scope": "queue", "id":'$QID1' },
			   "weight": '$W1'}, 
			  {"handle": {"scope": "queue", "id":'$QID2' },
			   "weight": '$W2'}], 
			  {"handle": {"scope": "queue", "id":'$QID3' },
			   "weight": '$W3'}], 
			"root": { "handle": {"scope":"node"},
			 	  "bw-max": 10000000}}'
{'ifindex': $IFINDEX, 'handle': {'scope': 'node', 'id': 0}}

Q1 \
    \
Q2 -- node 0 -------  netdev
    / (bw-max: 10M)
Q3 / 


* Delegation

A containers wants to limit the aggregate B/W bandwidth of 2 of the 3
queues it owns - the starting configuration is the one from the
previous point:

SPEC=Documentation/netlink/specs/net_shaper.yaml
./tools/net/ynl/cli.py --spec $SPEC \
	--do group --json '{"ifindex":'$IFINDEX', 
			"leaves": [ 
			  {"handle": {"scope": "queue", "id":'$QID1' },
			   "weight": '$W1'}, 
			  {"handle": {"scope": "queue", "id":'$QID2' },
			   "weight": '$W2'}], 
			"root": { "handle": {"scope": "node"},
				  "parent": {"scope": "node", "id": 0},
				  "bw-max": 5000000 }}'
{'ifindex': $IFINDEX, 'handle': {'scope': 'node', 'id': 1}}

Q1 -- node 1 --------\
    / (bw-max: 5M)    \
Q2 /                   node 0 -------  netdev
                      /  (bw-max: 10M)
Q3 ------------------

* Cleanup:

To delete a single queue shaper:

./tools/net/ynl/cli.py --spec $SPEC --do delete --json \
	'{"ifindex":'$IFINDEX', 
	  "handle": {"scope": "queue", "id":'$QID3' }}'

Q1 -- node 1 --------\
    / (bw-max: 5M)    \
Q2 /                   node 0 -------  netdev
                       (bw-max: 10M)

Deleting a node shaper relinks all its leaves to the node's parent:

./tools/net/ynl/cli.py --spec $SPEC --do delete --json \
	'{"ifindex":'$IFINDEX', 
	  "handle": {"scope": "node", "id":1 }}'

Q1 ------\
          \
          node 0 -------  netdev
         /  (bw-max: 10M)
Q2 -----

Deleting the last shaper under a node shaper deletes the node, too:

./tools/net/ynl/cli.py --spec $SPEC --do delete --json \
	'{"ifindex":'$IFINDEX', 
	  "handle": {"scope": "queue", "id":'$QID1' }}'
./tools/net/ynl/cli.py --spec $SPEC --do delete --json \
	'{"ifindex":'$IFINDEX', 
	  "handle": {"scope": "queue", "id":'$QID2' }}'
./tools/net/ynl/cli.py --spec $SPEC --do get --json '{"ifindex":'$IF', 
			  "handle": { "scope": "node", "id": 0}}'
Netlink error: No such file or directory
nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
	error: -2
	extack: {'bad-attr': '.handle'}
---
Changes from V3:
 - rename
 - locking
 - delete operates on node, too

v3: https://lore.kernel.org/netdev/cover.1722357745.git.pabeni@redhat.com/

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

Paolo Abeni (9):
  tools: ynl: lift an assumption about spec file name
  netlink: spec: add shaper YAML spec
  net-shapers: implement NL get operation
  net-shapers: implement NL set and delete operations
  net-shapers: implement NL group operation
  net-shapers: implement delete support for NODE scope shaper
  netlink: spec: add shaper introspection support
  net: shaper: implement introspection support
  testing: net-drv: add basic shaper test

Sudheer Mogilappagari (1):
  iavf: Add net_shaper_ops support

Wenjun Wu (2):
  virtchnl: support queue rate limit and quanta size configuration
  ice: Support VF queue rate limit and quanta size configuration

 Documentation/netlink/specs/net_shaper.yaml   |  373 +++++
 Documentation/networking/kapi.rst             |    3 +
 MAINTAINERS                                   |    1 +
 drivers/net/Kconfig                           |    1 +
 drivers/net/ethernet/intel/Kconfig            |    1 +
 drivers/net/ethernet/intel/iavf/iavf.h        |    3 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  150 ++
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |    2 +
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   65 +
 drivers/net/ethernet/intel/ice/ice.h          |    2 +
 drivers/net/ethernet/intel/ice/ice_base.c     |    2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   21 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |    8 +
 drivers/net/ethernet/intel/ice/ice_txrx.h     |    1 +
 drivers/net/ethernet/intel/ice/ice_type.h     |    1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |    8 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  333 +++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   11 +
 .../intel/ice/ice_virtchnl_allowlist.c        |    6 +
 drivers/net/netdevsim/netdev.c                |   41 +
 include/linux/avf/virtchnl.h                  |  119 ++
 include/linux/netdevice.h                     |   17 +
 include/net/net_shaper.h                      |  116 ++
 include/uapi/linux/net_shaper.h               |   90 ++
 net/Kconfig                                   |    3 +
 net/Makefile                                  |    1 +
 net/core/dev.c                                |    2 +
 net/core/dev.h                                |    6 +
 net/shaper/Makefile                           |    9 +
 net/shaper/shaper.c                           | 1202 +++++++++++++++++
 net/shaper/shaper_nl_gen.c                    |  152 +++
 net/shaper/shaper_nl_gen.h                    |   41 +
 tools/net/ynl/ynl-gen-c.py                    |    6 +-
 tools/testing/selftests/drivers/net/Makefile  |    1 +
 tools/testing/selftests/drivers/net/shaper.py |  236 ++++
 .../testing/selftests/net/lib/py/__init__.py  |    1 +
 tools/testing/selftests/net/lib/py/ynl.py     |    5 +
 37 files changed, 3038 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/netlink/specs/net_shaper.yaml
 create mode 100644 include/net/net_shaper.h
 create mode 100644 include/uapi/linux/net_shaper.h
 create mode 100644 net/shaper/Makefile
 create mode 100644 net/shaper/shaper.c
 create mode 100644 net/shaper/shaper_nl_gen.c
 create mode 100644 net/shaper/shaper_nl_gen.h
 create mode 100755 tools/testing/selftests/drivers/net/shaper.py

-- 
2.45.2


