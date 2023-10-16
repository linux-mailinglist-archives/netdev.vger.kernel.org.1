Return-Path: <netdev+bounces-41543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689B67CB475
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977751C20BB6
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C6437156;
	Mon, 16 Oct 2023 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ideFaHP6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846C36AFB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1864FC433C8;
	Mon, 16 Oct 2023 20:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697487422;
	bh=ZCM6m1vkcSGzlicIues5nVt9PtOCTFy5nERTZxxVh0I=;
	h=From:To:Cc:Subject:Date:From;
	b=ideFaHP6R3SVbynUDF1UxOo2foLRe6Nhh/HyaF/VqzNtxNtG4RlkG1gcggzHD7NLb
	 fck4K+Dxe7TKq9wXjxg2DT6VAs1jdE9VcOIMC5LLCXszbz80EW0EfUf3BcPnIoFQQH
	 dg7B9m7PF3ng0E0ZS3/102PsGJ3Po5g+UeTI6Ew9nrWVCFbzzsim4AcN5kDG7F9RRS
	 90zGJGq15jNGOSjTs7yyMT7P5xF4HLm3WWfQFYRk3IGOqj2zDigUaGBSY8iOYrB6Yx
	 G0nhdt5O9ymF0cfdEzLxVlgNYvO6DjAaX1ImWoiPfA/U4eSaoFWZhTFskbdwGAq7Fx
	 LE68VOksclDIw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/5] net: fix bugs in device netns-move and rename
Date: Mon, 16 Oct 2023 13:16:52 -0700
Message-ID: <20231016201657.1754763-1-kuba@kernel.org>
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

Link: https://lore.kernel.org/all/20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at/

Jakub Kicinski (5):
  net: fix ifname in netlink ntf during netns move
  net: check for altname conflicts when changing netdev's netns
  net: avoid UAF on deleted altname
  net: move altnames together with the netdevice
  selftests: net: add very basic test for netdev names and namespaces

 net/core/dev.c                            | 63 ++++++++++++----
 net/core/dev.h                            |  3 +
 tools/testing/selftests/net/Makefile      |  1 +
 tools/testing/selftests/net/netns-name.sh | 91 +++++++++++++++++++++++
 4 files changed, 142 insertions(+), 16 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns-name.sh

-- 
2.41.0


