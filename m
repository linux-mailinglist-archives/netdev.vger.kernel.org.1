Return-Path: <netdev+bounces-27505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE98577C2BB
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E628E1C20B9D
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702BDF72;
	Mon, 14 Aug 2023 21:47:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD5CA4E
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B317C433C7;
	Mon, 14 Aug 2023 21:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049645;
	bh=pnuAGP4fuz7Zc+S03PkBMOGH9lVM6Ob61GLpMf300ug=;
	h=From:To:Cc:Subject:Date:From;
	b=UCMJ24fOsPpHG7heoS3fmsUk2RjGHmilhjmgdtEVz7oXy7WZwz8RZ/h2J/z0Dws5n
	 WLjYtO9G6IuFgY832by9y8Qv9WNWP7lwXFYcCdwF9senJAogWfB+eQ05bTGWWY/F8C
	 wmThq9jDl70YxjHWGa+qer77c71bS3SgITAOY8wLoIu98v7urZDGO7qlnwuLuwrZfx
	 A1aLoEyTbPefpNkr+XtcNzg/+7qZY4G1GOxFuiM0Jutm4xE0Z+v8/4IboUS5OTk8Ju
	 Dbg37EN59B5k06EGh7yXcivwKbCwAlrQ7QOOsuuhMNwfQea2yLpeXbgfykFEf4t+ac
	 k6X+V7FoPn6iQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 00/10] genetlink: provide struct genl_info to dumps
Date: Mon, 14 Aug 2023 14:47:13 -0700
Message-ID: <20230814214723.2924989-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the biggest (which is not to say only) annoyances with genetlink
handling today is that doit and dumpit need some of the same information,
but it is passed to them in completely different structs.

The implementations commonly end up writing a _fill() method which
populates a message and have to pass at least 6 parameters. 3 of which
are extracted manually from request info.

After a lot of umming and ahing I decided to populate struct genl_info
for dumps, without trying to factor out only the common parts.
This makes the adoption easiest.

In the future we may add a new version of dump which takes
struct genl_info *info as the second argument, instead of
struct netlink_callback *cb. For now developers have to call
genl_info_dump(cb) to get the info.

Typical genetlink families no longer get exposed to netlink protocol
internals like pid and seq numbers.

v3:
 - correct the condition in ethtool code (patch 10)
v2: https://lore.kernel.org/all/20230810233845.2318049-1-kuba@kernel.org/
 - replace the GENL_INFO_NTF() macro with init helper
 - fix the commit messages
v1: https://lore.kernel.org/all/20230809182648.1816537-1-kuba@kernel.org/

Jakub Kicinski (10):
  genetlink: push conditional locking into dumpit/done
  genetlink: make genl_info->nlhdr const
  genetlink: remove userhdr from struct genl_info
  genetlink: add struct genl_info to struct genl_dumpit_info
  genetlink: use attrs from struct genl_info
  genetlink: add a family pointer to struct genl_info
  genetlink: add genlmsg_iput() API
  netdev-genl: use struct genl_info for reply construction
  ethtool: netlink: simplify arguments to ethnl_default_parse()
  ethtool: netlink: always pass genl_info to .prepare_data

 drivers/block/drbd/drbd_nl.c    |   9 +--
 drivers/net/wireguard/netlink.c |   2 +-
 include/net/genetlink.h         |  76 ++++++++++++++++++--
 net/core/netdev-genl.c          |  17 +++--
 net/devlink/health.c            |   2 +-
 net/devlink/leftover.c          |   6 +-
 net/ethtool/channels.c          |   2 +-
 net/ethtool/coalesce.c          |   6 +-
 net/ethtool/debug.c             |   2 +-
 net/ethtool/eee.c               |   2 +-
 net/ethtool/eeprom.c            |   9 ++-
 net/ethtool/features.c          |   2 +-
 net/ethtool/fec.c               |   2 +-
 net/ethtool/linkinfo.c          |   2 +-
 net/ethtool/linkmodes.c         |   2 +-
 net/ethtool/linkstate.c         |   2 +-
 net/ethtool/mm.c                |   2 +-
 net/ethtool/module.c            |   5 +-
 net/ethtool/netlink.c           |  33 ++++-----
 net/ethtool/netlink.h           |   2 +-
 net/ethtool/pause.c             |   5 +-
 net/ethtool/phc_vclocks.c       |   2 +-
 net/ethtool/plca.c              |   4 +-
 net/ethtool/privflags.c         |   2 +-
 net/ethtool/pse-pd.c            |   6 +-
 net/ethtool/rings.c             |   5 +-
 net/ethtool/rss.c               |   3 +-
 net/ethtool/stats.c             |   5 +-
 net/ethtool/strset.c            |   2 +-
 net/ethtool/tsinfo.c            |   2 +-
 net/ethtool/tunnels.c           |   2 +-
 net/ethtool/wol.c               |   5 +-
 net/ieee802154/nl802154.c       |   4 +-
 net/ncsi/ncsi-netlink.c         |   2 +-
 net/ncsi/ncsi-netlink.h         |   2 +-
 net/netlink/genetlink.c         | 119 +++++++++++++++-----------------
 net/nfc/netlink.c               |   4 +-
 net/openvswitch/conntrack.c     |   2 +-
 net/openvswitch/datapath.c      |  29 ++++----
 net/openvswitch/meter.c         |  10 +--
 net/tipc/netlink_compat.c       |   4 +-
 net/tipc/node.c                 |   4 +-
 net/tipc/socket.c               |   2 +-
 net/tipc/udp_media.c            |   2 +-
 44 files changed, 234 insertions(+), 178 deletions(-)

-- 
2.41.0


