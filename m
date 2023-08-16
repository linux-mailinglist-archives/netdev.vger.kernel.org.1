Return-Path: <netdev+bounces-28265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD1577EDE0
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5995B281C84
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCE01BF11;
	Wed, 16 Aug 2023 23:43:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015417721
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 23:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EB1C433C8;
	Wed, 16 Aug 2023 23:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692229389;
	bh=k4v44u0X+QgUz1CIjQ0CemwTP1Mt5BnhXkYPMX72tWw=;
	h=From:To:Cc:Subject:Date:From;
	b=mJIF1kXUyxX+QaGwC0v9mIdg2/BUhwMa5hKwDoF7NX3lh72ILYmdtyllPFNh6b9dL
	 k5D38ntrFfzWIEcWedDdhFC+nABtNKiEtkAtIF4hUptatzRbI+KcGGfXfa5L4j+Cjn
	 ogq3s3j6rc0uWDXBq8b0cHLuMaUF8J8yEPlzSuGS14Hu6oyzkyTBse+yzdpmwCjHTR
	 TJXuot3xX4RewymQmZKzRXa4E5sYq+QioU/BwKxKpwDJew9JqE1ekGWlMtgucnIpp+
	 HAlshUEywWIycIatxagMxV7GSUfebSgXCGQGyiH26OeXxsFvHwH1cqdvljGk1r34nr
	 kUkjDQLkgGXHQ==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	aleksander.lobakin@intel.com,
	linyunsheng@huawei.com,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 00/13] net: page_pool: add netlink-based introspection
Date: Wed, 16 Aug 2023 16:42:49 -0700
Message-ID: <20230816234303.3786178-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the page pool functionality grows we will be increasingly
constrained by the lack of any uAPI. This series is a first
step towards such a uAPI, it creates a way for users to query
information about page pools and associated statistics.

I'm purposefully exposing only the information which I'd
find useful when monitoring production workloads.

For the SET part (which to be clear isn't addressed by this
series at all) I think we'll need to turn to something more
along the lines of "netdev-level policy". Instead of configuring
page pools, which are somewhat ephemeral, and hard to change
at runtime, we should set the "expected page pool parameters"
at the netdev level, and have the driver consult those when
instantiating pools. My ramblings from yesterday about Queue API
may make this more or less clear...
https://lore.kernel.org/all/20230815171638.4c057dcd@kernel.org/

Jakub Kicinski (13):
  net: page_pool: split the page_pool_params into fast and slow
  net: page_pool: avoid touching slow on the fastpath
  net: page_pool: factor out uninit
  net: page_pool: id the page pools
  net: page_pool: record pools per netdev
  net: page_pool: stash the NAPI ID for easier access
  eth: link netdev to pp
  net: page_pool: add nlspec for basic access to page pools
  net: page_pool: implement GET in the netlink API
  net: page_pool: add netlink notifications for state changes
  net: page_pool: report when page pool was destroyed
  net: page_pool: expose page pool stats via netlink
  tools: netdev: regen after page pool changes

 Documentation/netlink/specs/netdev.yaml       | 158 +++++++
 Documentation/networking/page_pool.rst        |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c |   1 +
 include/linux/list.h                          |  20 +
 include/linux/netdevice.h                     |   4 +
 include/net/page_pool/helpers.h               |   8 +-
 include/net/page_pool/types.h                 |  43 +-
 include/uapi/linux/netdev.h                   |  37 ++
 net/core/Makefile                             |   2 +-
 net/core/netdev-genl-gen.c                    |  41 ++
 net/core/netdev-genl-gen.h                    |  11 +
 net/core/page_pool.c                          |  56 ++-
 net/core/page_pool_priv.h                     |  12 +
 net/core/page_pool_user.c                     | 409 +++++++++++++++++
 tools/include/uapi/linux/netdev.h             |  37 ++
 tools/net/ynl/generated/netdev-user.c         | 415 ++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h         | 169 +++++++
 19 files changed, 1391 insertions(+), 39 deletions(-)
 create mode 100644 net/core/page_pool_priv.h
 create mode 100644 net/core/page_pool_user.c

-- 
2.41.0


