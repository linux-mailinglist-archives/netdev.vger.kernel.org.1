Return-Path: <netdev+bounces-42098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D767CD1DD
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130882816C5
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD8115A2;
	Wed, 18 Oct 2023 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/UZS8vZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA78A1382
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2B0C433C8;
	Wed, 18 Oct 2023 01:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697593099;
	bh=YtwOEOmdoEYVYgJxtRQB8HP+jCYX/vLAwSYbHMq96Q4=;
	h=From:To:Cc:Subject:Date:From;
	b=b/UZS8vZmWecGwyTghAudTf6M9ERSolzaD+CFlQMAZQK6QdXKVYBuUxMK9jAq/5Ga
	 NkqWJ0ibStzMcEwZ1HMsRbgoNQpFcVXrsLzW+2C8AooNJQ4T7CvGVjyFAVu6CE3uFh
	 okvrm8u5E7VjkOMgWnJofnWkyp9aTtg6ZxiRYkwcEq9ovbBvEs9XY7i1Vv1RPRe7I4
	 U5RGrtvay1W58EaG1wjcKql4IDZae3Z0d1sW6okj+y1SmqsRJjGeA3ps8phjYGOofD
	 E99O7/43Chy3wmduqNXMn26uHtHpX0xgFeg0LxlhrHNQBzwGS+/R15eSj2jiybFLuA
	 DUj2eF0HWE50A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	przemyslaw.kitszel@intel.com,
	daniel@iogearbox.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 0/5] net: fix bugs in device netns-move and rename
Date: Tue, 17 Oct 2023 18:38:12 -0700
Message-ID: <20231018013817.2391509-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Daniel reported issues with the uevents generated during netdev
namespace move, if the netdev is getting renamed at the same time.

While the issue that he actually cares about is not fixed here,
there is a bunch of seemingly obvious other bugs in this code.
Fix the purely networking bugs while the discussion around
the uevent fix is still ongoing.

v2:
 - fix the bug in patch 1
 - improvements in patch 5
v1: https://lore.kernel.org/all/20231016201657.1754763-1-kuba@kernel.org/

Link: https://lore.kernel.org/all/20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at/

Jakub Kicinski (5):
  net: fix ifname in netlink ntf during netns move
  net: check for altname conflicts when changing netdev's netns
  net: avoid UAF on deleted altname
  net: move altnames together with the netdevice
  selftests: net: add very basic test for netdev names and namespaces

 net/core/dev.c                            | 65 +++++++++++++----
 net/core/dev.h                            |  3 +
 tools/testing/selftests/net/Makefile      |  1 +
 tools/testing/selftests/net/netns-name.sh | 87 +++++++++++++++++++++++
 4 files changed, 141 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns-name.sh

-- 
2.41.0


