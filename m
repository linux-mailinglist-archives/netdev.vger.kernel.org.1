Return-Path: <netdev+bounces-26010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821C9776727
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA961C21318
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9B61D31E;
	Wed,  9 Aug 2023 18:26:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD701AA83
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F494C433CC;
	Wed,  9 Aug 2023 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691605613;
	bh=CAHRFx1G+6UAt+zZJjAIi6UiYoO0mkBdCL9YK0F5NdM=;
	h=From:To:Cc:Subject:Date:From;
	b=hgdoaoGKy8PxNRlwsjQJ07FMxYbtruWM8YsC7Dz605rqBY7LF2wdKjdcfPr8cC+va
	 zftQgtl5mOWulFu8hpNkPUARMIz8YFVGVe7TEVfQ+uanaj573dXc73ZrvltvCCGY+L
	 /sZN4afXt78YOBWZqeAVnZUjJ46quD+o/Ikn+1F/zZpp/WZCvpkY4JgDVALjpGHUEJ
	 hMjAzOsxuhYvjK+d9EC0zTt912tyCClPtWh3XNvsLGDsXgk9FJYdaZ/i69enOnz27d
	 n61z1A6aAE9waZxwiFCBzk0wOL3FJqMY5jln4lnBmAIz/1US34rFgxstZUckm4XBey
	 WZA6Z6vi0V3kg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/10] genetlink: provide struct genl_info to dumps
Date: Wed,  9 Aug 2023 11:26:38 -0700
Message-ID: <20230809182648.1816537-1-kuba@kernel.org>
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

Jakub Kicinski (10):
  genetlink: use push conditional locking info dumpit/done
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
 include/net/genetlink.h         |  72 +++++++++++++++++--
 net/core/netdev-genl.c          |  15 ++--
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
 net/ethtool/netlink.c           |  31 ++++-----
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
 44 files changed, 226 insertions(+), 178 deletions(-)

-- 
2.41.0


