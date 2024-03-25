Return-Path: <netdev+bounces-81693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA7D88AD2A
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6E03029E7
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8726445025;
	Mon, 25 Mar 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYhMt7Tz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61918D272
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388239; cv=none; b=QtB04jcvfxTvL3UU56TwcRr3qnXJa4jQEIIbXoqwNiLUDrwRG1AoKqEhCMaIrlXlqSxnKfvqJ+4wZHPB7ZbIXqMIp9bTYpPR7c4mNC3ZP7nAsH6CMHH1J5eGY74pNRi7AJBfIQ7wePfd/2bMYMSRmhmHFCWnLXb0fpFkdYRwMzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388239; c=relaxed/simple;
	bh=YLqX8ZqOtfHIV+1EA9jzy/eujsMfmXqstMhSO2naG+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JzudkdwXDdYPtrq7w0QP2ZOw7QWDbM29XebAh3W11PHpUR2XGrgfrCKmIk4vBAfn5G0rm77CuKJI5ZiXbHc6OY1ZMgl+1oesTAgBTES4Kckvx9oVtBr3s4dpmkXJcQAPceX2VNu5gmxdpjj4d6xXK4t0LUbo79KsZqaNtmi+SZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYhMt7Tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CC7C433C7;
	Mon, 25 Mar 2024 17:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388239;
	bh=YLqX8ZqOtfHIV+1EA9jzy/eujsMfmXqstMhSO2naG+E=;
	h=From:To:Cc:Subject:Date:From;
	b=YYhMt7Tzig2SE7WOxsj92m4NAYXQyBKrvSyhUccGYh2gWxQwYP48HpsIrA8+mK16y
	 WA9y6bvkw5b+hTMbzTW6HZPXPFslgWcoR46Y9eK7viD6CvCdqBZ6Yu56YG56msZvrJ
	 yXQLCU/TKogJ0Zr9BezpcTsNbuxRyBIL6MTd/ZuFQ5552wtbVnpAI4v7JVXqJ2794O
	 Cczb/iQUpOjOaHG3BmMX4pi8HyOmoTEy4/1OqBPZIWFkS2gI7KJEtkPd5D/Q57S5dc
	 ooSBMIWr7sCyAanDPciFXffAcpzV4gAiHl/0GEhqU4rFCiVf8EaNUfsIbrD42FRwBi
	 FLbeZv8MJp9jQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	jiri@resnulli.us,
	andriy.shevchenko@linux.intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/3] genetlink: remove linux/genetlink.h
Date: Mon, 25 Mar 2024 10:37:13 -0700
Message-ID: <20240325173716.2390605-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two genetlink headers net/genetlink.h and linux/genetlink.h
This is similar to netlink.h, but for netlink.h both contain good
amount of code. For genetlink.h the linux/ version is leftover
from before uAPI headers were split out, it has 10 lines of code.
Move those 10 lines into other appropriate headers and delete
linux/genetlink.h.

I occasionally open the wrong header in the editor when coding,
I guess I'm not the only one.

v2:
 - fix Andy's nits on patch 3
v1: https://lore.kernel.org/all/20240309183458.3014713-1-kuba@kernel.org

Jakub Kicinski (3):
  netlink: create a new header for internal genetlink symbols
  net: openvswitch: remove unnecessary linux/genetlink.h include
  genetlink: remove linux/genetlink.h

 drivers/net/wireguard/main.c      |  2 +-
 include/linux/genetlink.h         | 19 -------------------
 include/linux/genl_magic_struct.h |  2 +-
 include/net/genetlink.h           | 10 +++++++++-
 net/batman-adv/main.c             |  2 +-
 net/batman-adv/netlink.c          |  1 -
 net/netlink/af_netlink.c          |  2 +-
 net/netlink/genetlink.c           |  2 ++
 net/netlink/genetlink.h           | 11 +++++++++++
 net/openvswitch/datapath.c        |  1 -
 net/openvswitch/meter.h           |  1 -
 11 files changed, 26 insertions(+), 27 deletions(-)
 delete mode 100644 include/linux/genetlink.h
 create mode 100644 net/netlink/genetlink.h

-- 
2.44.0


